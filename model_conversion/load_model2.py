from tf_to_dict import tf_to_dict, custom_object_quant
import tensorflow_model_optimization as tfmot
import tensorflow as tf
import os
import pickle


def get_best_model_path(path):
    if directories := [
        d
        for d in os.listdir(path)
        if d.startswith('model_') and d.endswith('loss')
    ]:
        # Extract loss value from each directory name
        losses = [float(d.split('_')[1].replace('loss', ''))
                  for d in directories]

    # Select directory with lowest loss value
        lowest_loss_index = losses.index(min(losses))
        lowest_loss_dir = directories[lowest_loss_index]
        print(f"The directory with the lowest loss is {lowest_loss_dir}")
        return f"{path}/{lowest_loss_dir}"

    else:
        print("No directories found with name pattern 'model_*loss'")
        return ""


class obj_class:
    def __init__(self) -> None:
        self.q_aware_model = None
        self.save_objects_path = None


def load_objects(model_dir: str):

    with tfmot.quantization.keras.quantize_scope():
        q_aware_model = tf.keras.models.load_model(
            f"{model_dir}/saved_objects/q_aware.h5")

    # q_aware_model = tf.keras.models.load_model(
    #     f"{model_dir}/saved_objects/q_aware.h5", custom_objects=custom_object_quant)

    # Load other attributes
    with open(f'{model_dir}/saved_objects/model_obj_attributes.pickle', 'rb') as f:
        loaded_attributes = pickle.load(f)
    loaded_model_obj = obj_class()
    loaded_model_obj.q_aware_model = q_aware_model
    loaded_model_obj.save_objects_path = loaded_attributes['save_objects_path']

    return loaded_model_obj


whole_dir = 'C:\\Users\\luisa\\OneDrive\\Documentos\\GitHub\\DenseNN_to_VHDL'

path = f'{whole_dir}/models/mini'
# path = f'{whole_dir}/models/normal'
best_model_path = get_best_model_path(path)
loaded_model_obj = load_objects(model_dir=best_model_path)


tf_to_dict(loaded_model_obj.q_aware_model,
           save_path=loaded_model_obj.save_objects_path
           )

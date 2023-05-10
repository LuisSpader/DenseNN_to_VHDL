import tensorflow as tf
import qkeras as qk
import tensorflow_model_optimization as tfmot
path = r'C:\Users\luisa\OneDrive\Documentos\GitHub\DenseNN_to_VHDL\models\mini\model_64_0.01157loss\quant_model8bits\KERAS_check_best_model.h5'

# custom_object_quant = {'QActivation': qk.qlayers.QActivation}
# custom_object_quant = {}
# qk.utils._add_supported_quantized_objects(custom_object_quant)
# model = tf.keras.models.load_model(path, custom_objects=custom_object_quant)

with tfmot.quantization.keras.quantize_scope():
    model = tf.keras.models.load_model(path)
a = 10

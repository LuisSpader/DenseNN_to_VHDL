
import os

whole_dir = 'C:\\Users\\luisa\\OneDrive\\Documentos\\GitHub\\DenseNN_to_VHDL'


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


def get_model_path(whole_dir: str, MINI_MODEL: bool, model_path: str):
    if model_path:
        return model_path
    path = f'{whole_dir}/models/normal'
    if MINI_MODEL:
        path = f'{whole_dir}/models/mini'

    return get_best_model_path(path)
# best_model_path = get_model_path(whole_dir, MINI_MODEL, model_path)

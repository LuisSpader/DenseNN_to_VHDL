
from pathlib import Path
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
        # check if model_path is a directory
        if os.path.isdir(model_path):
            return model_path, None

        # if is a file, create a folder with the same name as the model and move it to the new folder:
        # check if model_path is a file
        elif os.path.isfile(model_path):
            # check if model_path is a .h5 file
            if model_path.endswith('.h5'):
                # get model_path path
                if '\\' in model_path:
                    path = '/'.join(model_path.split('\\')[:-1])  # !
                    model_name = model_path.split('\\')[-1].split('.')[0]
                else:
                    path = '/'.join(model_path.split('/')[:-1])
                    model_name = model_path.split('/')[-1].split('.')[0]

                # make a folder with the same name as the model
                # count the number of files with the '.h5' extension
                count = len(list(Path(path).glob('*.h5')))

                if count > 1:  # if more than one model, create a folder with the model name and move the model to the new folder
                    model_dir = f'{path}/{model_name}'
                    if not os.path.exists(model_dir):
                        os.makedirs(model_dir)
                    os.rename(model_path, f'{model_dir}/{model_name}.h5')
                else:
                    model_dir = f'{path}'

                    # move the model to the new folder
                return model_dir, model_name
            else:
                print('get_model_path() -> ERROR: model_path is not a .h5 file')
                exit()

    path = f'{whole_dir}/models/normal'
    if MINI_MODEL:
        path = f'{whole_dir}/models/mini'

    return get_best_model_path(path), None
# best_model_path = get_model_path(whole_dir, MINI_MODEL, model_path)


import numpy as np
import os
import MNIST_database as mnist
from fxpmath import Fxp


def load_mnist_dataset():
    """
    Loads the MNIST dataset using TensorFlow/Keras.

    Returns:
        Tuple[Tuple, Tuple]: A tuple containing the training data and labels, and a tuple containing the test data and labels.
    """
    # Load the MNIST dataset
    from tensorflow.keras.datasets import mnist as mnist_tf
    (_, y_train), (_, y_test) = mnist_tf.load_data()
    return (_, y_train), (_, y_test)


def bin_images_gen(OUTPUT_BASE_DIR_PATH: str,
                   BIT_WIDTH: int = 8,
                   is_signed: bool = False,
                   n_image_test: int = 100,
                   size_final: int = 8
                   ) -> None:
    """
    Generates binary files of fixed-point encoded MNIST images for use on the implemented HDL hardware IP core.

    Args:
    BIT_WIDTH (int, optional): The number of bits to use for the fixed-point encoding. Defaults to 8.
    is_signed (bool, optional): Whether to use signed or unsigned fixed-point encoding. Defaults to False.
    n_image_test (int, optional): The number of test images to encode. Defaults to 100.
    size_final (int, optional): The final size of the MNIST images (Choose the final size of your image dataset
). Defaults to 8.
    """
    # Load the MNIST dataset and resize it
    data_zoom = mnist.MNISTData(
        size_initial=20, size_final=size_final, color_depth=5, flat=True)
    test = data_zoom.x_test
    # train = data_zoom.x_train

    # # Get the labels for the test images
    # (_, y_train), (_, y_test) = load_mnist_dataset()

    # List of numbers to encode and write to file
    #           0  1  2  3  4  5  6  7  8  9
    num_list = [3, 2, 1, 32, 4, 15, 21, 0, 61, 12]
    # # Print the binary representation of the fixed-point encoded numbers in num_list
    # for item in num_list:
    #     print(f"{str(item).ljust(4, ' ')}: {(Fxp(item, signed=is_signed, n_word=BIT_WIDTH, n_frac=0).bin())}")

    num_list = [3, 2, 1, 32, 4, 15, 21, 0, 61, 12] + list(
        range(62, 62 + n_image_test - 10)
    )
    os.makedirs(f"{OUTPUT_BASE_DIR_PATH}", exist_ok=True)  # softmax layer

    path = f'{OUTPUT_BASE_DIR_PATH}\dataset\TESTimg_downto_apfixed{BIT_WIDTH}_{n_image_test}imgs.txt'
    with open(path, 'w') as f:
        for num in num_list:
            for i in np.flip(test[num]):

                # Convert the pixel value to fixed-point and write it to file
                f.write(Fxp(i*(2**BIT_WIDTH), signed=is_signed,
                            n_word=BIT_WIDTH, n_frac=0).bin())
            # f.write(' ')

            f.write('\n')


# OUTPUT_BASE_DIR_PATH = r"C:\Users\luisa\OneDrive\Documentos\GitHub\DenseNN_to_VHDL\NNs\NN_4Layers_8bits_5_2_3_4\testbench_files"
# BIT_WIDTH = 8
# is_signed = False
# n_image_test = 100
# size_final = 8  # Choose the final size of your image dataset
# bin_images_gen(OUTPUT_BASE_DIR_PATH,  BIT_WIDTH,
#                is_signed, n_image_test, size_final)

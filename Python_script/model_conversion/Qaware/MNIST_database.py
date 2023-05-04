from tensorflow.keras.datasets import mnist as mnist
from tensorflow.python.keras.utils.np_utils import to_categorical
import numpy as np
import matplotlib.pyplot as plt
import sys
import tensorflow as tf
import scipy


# +------------------+
# | MNIST data class |
# +------------------+


class MNISTData:
    """MNIST data class. You can adjust the data_fraction to use when creating
    the data, according to your system capabilities."""

    def __init__(self, data_fraction=1., size_initial=20, size_final=8, color_depth=5, flat=True):
        """
        Args:
            size_initial (int): Initial size of images.
            size_final (int): Final size of images.
            color_depth (int): Number of bits used to represent the color depth of the images.

        """
        data = mnist
        (self.x_train, self.y_train), (self.x_test, self.y_test) = data.load_data()

        self.get_subset_of_data(data_fraction)

        self.convert_label_to_categorical()

        self.crop_and_interpolate(size_initial, size_final, color_depth)

        if flat is True:
            self.flatten_pictures()

    def get_subset_of_data(self, data_fraction):
        """
        Reduces the size of the training and test data sets to a fraction of their original size.

        Args:
            data_fraction (float): A number between 0 and 1 that represents the fraction of the original
                data set that should be used. For example, a value of 0.5 would result in the size of
                the data set being reduced by half.
        """
        # Calculate the index that corresponds to the desired fraction of the training data set.
        train_index = int(len(self.x_train) * data_fraction)

        # Reduce the size of the training data set to the desired fraction by slicing the array.
        self.x_train = self.x_train[:train_index]
        self.y_train = self.y_train[:train_index]

        # Calculate the index that corresponds to the desired fraction of the test data set.
        test_index = int(len(self.x_test) * data_fraction)

        # Reduce the size of the test data set to the desired fraction by slicing the array.
        self.x_test = self.x_test[:test_index]
        self.y_test = self.y_test[:test_index]

    def convert_label_to_categorical(self):
        """
        Convert the labels from integer format to categorical format for the train and test sets.

        The labels are converted using the `to_categorical` function from Keras utils, which
        converts a class vector of integers to a binary class matrix.

        The convert_label_to_categorical() function takes the integer labels of the train and test sets and converts them to categorical format using the to_categorical() function from Keras utils. The to_categorical() function takes a class vector of integers and converts it into a binary class matrix.


        Args:
            None.

        Returns:
            None.
            There are no arguments for this function and it returns nothing. The function simply updates the y_train and y_test attributes of the object to the categorical format


        """
        self.y_train = to_categorical(self.y_train)
        self.y_test = to_categorical(self.y_test)

    def crop_and_interpolate(self, size_initial: int, size_final: int, color_depth: int) -> None:
        """
        Process the train and test sets by cropping and zooming images and rescaling the pixel values.
            The dataset is then shrinked and zoomed according the input values.
            Definition of the crop indeces defined by the input variable size_inizial.

        Args:
            size_initial (int): Initial size of images.
            size_final (int): Final size of images.
            color_depth (int): Number of bits used to represent the color depth of the images.

        Returns:
            None
        """

        # Define indices to crop images
        border = (28 - size_initial) // 2
        border_top = -border
        if border == 0:
            border_top = None

        # Initialize lists to store processed images
        X_train_flat_zoom = []
        X_test_flat_zoom = []
        X_train_flat_zoom_int = []
        X_test_flat_zoom_int = []

        # Process train set
        for image in self.x_train:
            # Crop and zoom the image
            tmp = scipy.ndimage.zoom(image[border:border_top, border:border_top],
                                     size_final / size_initial)
            # Rescale pixel values to [0, 2^color_depth)
            tmp = (tmp / (256 // 2 ** color_depth)).astype(int)
            # Add processed image to the list
            X_train_flat_zoom.append(tmp / 2 ** color_depth)
            X_train_flat_zoom_int.append(tmp)

        # Convert lists to numpy arrays
        X_train_flat_zoom = np.array(X_train_flat_zoom)
        X_train_flat_zoom_int = np.array(X_train_flat_zoom_int)

        # Update train set
        self.x_train = X_train_flat_zoom

        # Process test set
        for image in self.x_test:
            # Crop and zoom the image
            tmp = scipy.ndimage.zoom(image[border:border_top, border:border_top],
                                     size_final / size_initial)
            # Rescale pixel values to [0, 2^color_depth)
            tmp = (tmp / (256 // 2 ** color_depth)).astype(int)
            # Add processed image to the list
            X_test_flat_zoom.append(tmp / 2 ** color_depth)
            X_test_flat_zoom_int.append(tmp)

        # Convert lists to numpy arrays
        X_test_flat_zoom = np.array(X_test_flat_zoom)
        X_test_flat_zoom_int = np.array(X_test_flat_zoom_int)

        # Update test set
        self.x_test = X_test_flat_zoom

    def flatten_pictures(self):
        """
        Flattens the input images by reshaping them from a 2D array (matrix) into a 1D array (vector).
        The number of rows is preserved, while the number of columns is set to -1, allowing NumPy to 
        automatically infer the appropriate value based on the number of elements.

        This function uses NumPy's reshape() method to convert the 2D arrays representing the input images (stored in self.x_train and self.x_test) into 1D arrays. 
        The number of rows in each array is preserved, but the number of columns is set to -1, which instructs NumPy to automatically infer the appropriate value based on the total number of elements in the array. 

        This operation effectively "flattens" the images, converting each row of pixels into a single long vector.
        """
        self.x_train = self.x_train.reshape(self.x_train.shape[0], -1)
        self.x_test = self.x_test.reshape(self.x_test.shape[0], -1)

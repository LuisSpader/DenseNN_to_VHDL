import model_conversion.Qaware.MNIST_database as mnist
from matplotlib import pyplot as plt


# Choose the final size of your image dataset
size_final = 8

# data_zoom = mnist.MNISTData(size_initial=20, size_final=size_final, color_depth=5, flat=True)
data_zoom = mnist.MNISTData(
    size_initial=20, size_final=8, color_depth=8, flat=True)
# todo: data_zoom.x_train = data_zoom.x_train*(2**(BIT_WIDTH))
# todo: data_zoom.x_test = data_zoom.x_test*(2**(BIT_WIDTH))

# x_train= data_zoom.x_train
# y_train= data_zoom.y_train
# x_test= data_zoom.x_test
# y_test= data_zoom.y_test

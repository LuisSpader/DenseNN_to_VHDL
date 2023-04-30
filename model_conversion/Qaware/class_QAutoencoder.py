import pickle
import numpy as np
import tensorflow as tf
from tensorflow.keras.layers import Input, Dense
from tensorflow.keras.models import Model
from matplotlib import pyplot as plt
from sklearn.metrics import mean_squared_error
import tensorflow_model_optimization as tfmot
import os
from matplotlib import pyplot as plt
from Qaware.callbacks import all_callbacks
from Qaware.data_zoom import *
# import MNIST_database as mnist


def extract_architecture(model):
    arch_list = []
    for layer in model.layers:
        if isinstance(layer, tf.keras.layers.Dense):
            arch_list.append(layer.units)
    return arch_list


# This will give you the directory containing file_A.py
# whole_dir = os.path.dirname(os.path.realpath(__file__))
whole_dir = 'C:\\Users\\luisa\\OneDrive\\Documentos\\GitHub\\DenseNN_to_VHDL'


class QAutoencoder:

    def __init__(self, data: mnist.MNISTData, bit_width: int = 8, EPOCHS: int = 1, Q_EPOCHS: int = 1, model_name: str = 'model', MINI_MODEL: bool = False, MODEL_SIZE: int = 3):
        self.MINI_MODEL = MINI_MODEL
        self.model_type = "mini/" if MINI_MODEL else "normal/"
        self.MODEL_SIZE = MODEL_SIZE

        self.x_train = data.x_train
        self.y_train = data.y_train
        self.x_test = data.x_test
        self.y_test = data.y_test
        self.input_min = np.min(data.x_train)
        self.input_max = np.max(data.x_train)
        self.input_shape = (data.x_train.shape[-1],)
        self.BIT_WIDTH = bit_width
        self.EPOCHS = EPOCHS
        self.Q_EPOCHS = Q_EPOCHS
        self.model_name = model_name
        self.model_name_id = None
        self.model = self.autoencoder_model_gen()
        self.history = None
        self.loss = None
        self.float_model_predictions = None
        self.path_to_model = None

        self.path_to_quantized_model = None
        self.q_aware_model = None
        self.q_aware_loss = None
        self.quantized_tflite_model = None
        self.interpreter = None
        self.input_details = None
        self.output_details = None
        self.quantized_model_predictions = None

        self.save_objects_path = None

    def mini_model(self):
        encoder_input = Input(shape=self.input_shape)
        decoder_output = Dense(
            self.x_train.shape[-1], activation='linear')(encoder_input)
        # Model
        model = Model(inputs=encoder_input, outputs=decoder_output)
        # refactor the code above to use the functional AP

        model.compile(optimizer='adam', loss='mse')
        self.extract_model_name_id(model)
        # model.compile(optimizer='adam', loss='binary_crossentropy') # classifier
        return model

    def autoencoder_model_gen(self):
        if self.MINI_MODEL:
            return self.mini_model()
        # Encoder
        # encoder_input = Input(shape=self.input_shape)
        # encoder_l1 = Dense(64, activation='relu')(encoder_input)
        # encoder_l2 = Dense(32, activation='relu')(encoder_l1)
        # encoder_l3 = Dense(16, activation='relu')(encoder_l2)
        # encoder_output = Dense(2, activation='relu')(encoder_l3)

        # # Decoder
        # decoder_l1 = Dense(16, activation='relu')(encoder_output)
        # decoder_l2 = Dense(32, activation='relu')(decoder_l1)
        # decoder_l3 = Dense(32, activation='relu')(decoder_l2)
        if self.MODEL_SIZE == 0:
            # Encoder
            encoder_input = Input(shape=self.input_shape)
            encoder_l1 = Dense(15, activation='relu')(encoder_input)
            # encoder_l3 = Dense(15, activation='relu')(encoder_l1)
            encoder_output = Dense(2, activation='relu')(encoder_l1)

            # Decoder
            # decoder_l1 = Dense(16, activation='relu')(encoder_output)
            decoder_l2 = Dense(15, activation='relu')(encoder_output)
            # decoder_output = Dense(y_train.shape[-1], activation='sigmoid')(decoder_l3) # classifier
            # decoder_output = Dense(
            #     self.x_train.shape[-1], activation='sigmoid')(decoder_l3)  # autoencoder
            decoder_output = Dense(
                self.x_train.shape[-1], activation='linear')(decoder_l2)

        if self.MODEL_SIZE == 1:
            # Encoder
            encoder_input = Input(shape=self.input_shape)
            encoder_l1 = Dense(64, activation='relu')(encoder_input)
            encoder_l3 = Dense(15, activation='relu')(encoder_l1)
            encoder_output = Dense(2, activation='relu')(encoder_l1)

            # Decoder
            # decoder_l1 = Dense(16, activation='relu')(encoder_output)
            decoder_l2 = Dense(32, activation='relu')(encoder_output)
            # decoder_output = Dense(y_train.shape[-1], activation='sigmoid')(decoder_l3) # classifier
            # decoder_output = Dense(
            #     self.x_train.shape[-1], activation='sigmoid')(decoder_l3)  # autoencoder
            decoder_output = Dense(
                self.x_train.shape[-1], activation='linear')(decoder_l2)

        if self.MODEL_SIZE == 2:
            # Encoder
            encoder_input = Input(shape=self.input_shape)
            encoder_l1 = Dense(64, activation='relu')(encoder_input)
            encoder_l2 = Dense(15, activation='relu')(encoder_l1)
            encoder_l3 = Dense(15, activation='relu')(encoder_l2)
            encoder_l4 = Dense(15, activation='relu')(encoder_l3)
            encoder_output = Dense(2, activation='relu')(encoder_l4)

            # Decoder
            # decoder_l1 = Dense(16, activation='relu')(encoder_output)
            decoder_l2 = Dense(32, activation='relu')(encoder_output)
            decoder_l3 = Dense(32, activation='relu')(decoder_l2)
            # decoder_output = Dense(y_train.shape[-1], activation='sigmoid')(decoder_l3) # classifier
            # decoder_output = Dense(
            #     self.x_train.shape[-1], activation='sigmoid')(decoder_l3)  # autoencoder
            decoder_output = Dense(
                self.x_train.shape[-1], activation='linear')(decoder_l3)

        if self.MODEL_SIZE == 3:
            # Encoder
            encoder_input = Input(shape=self.input_shape)
            encoder_l1 = Dense(64, activation='relu')(encoder_input)
            encoder_l2 = Dense(50, activation='relu')(encoder_l1)
            encoder_l3 = Dense(32, activation='relu')(encoder_l2)
            encoder_l4 = Dense(16, activation='relu')(encoder_l3)
            encoder_l5 = Dense(8, activation='relu')(encoder_l4)
            encoder_l6 = Dense(4, activation='relu')(encoder_l5)
            encoder_output = Dense(2, activation='relu')(encoder_l6)

            # Decoder
            decoder_l1 = Dense(16, activation='relu')(encoder_output)
            decoder_l2 = Dense(32, activation='relu')(decoder_l1)
            decoder_l3 = Dense(32, activation='relu')(decoder_l2)
            # decoder_output = Dense(y_train.shape[-1], activation='sigmoid')(decoder_l3) # classifier
            # decoder_output = Dense(
            #     self.x_train.shape[-1], activation='sigmoid')(decoder_l3)  # autoencoder
            decoder_output = Dense(
                self.x_train.shape[-1], activation='linear')(decoder_l3)

        # Model
        model = Model(inputs=encoder_input, outputs=decoder_output)
        # refactor the code above to use the functional AP

        model.compile(optimizer='adam', loss='mse')
        self.extract_model_name_id(model)
        # model.compile(optimizer='adam', loss='binary_crossentropy') # classifier
        return model

    def extract_model_name_id(self, model):
        arch_list = extract_architecture(model)
        arch_string = '_'.join(str(units) for units in arch_list)
        self.model_name_id = f"{self.model_name}_{arch_string}"

    def fit_data(self, batch_size=256, epochs=1):
        """Write the fit function for the autoencoder.
        Storing the fit history in self.history to be able to plot the fitting scores."""

        callbacks = all_callbacks(stop_patience=1000,
                                  lr_factor=0.5,
                                  lr_patience=10,
                                  lr_epsilon=0.000001,
                                  # min_delta=0.000001,
                                  lr_cooldown=2,
                                  lr_minimum=0.0000001,
                                  outputDir=f'models/{self.model_type}callbacks')

        self.history = self.model.fit(self.x_train, self.x_train,
                                      validation_data=(
                                          self.x_test, self.x_test),
                                      batch_size=batch_size, epochs=epochs,
                                      shuffle=True, callbacks=callbacks.callbacks)
        # self.model = strip_pruning(self.model)
        self.loss = self.model.evaluate(self.x_test, self.x_test, verbose=0)

        self.path_to_model = f'{whole_dir}/models/{self.model_type}{self.model_name_id}_{str(self.loss)[0:7]}loss/KERAS_check_best_model.model'
        if not os.path.exists(self.path_to_model):
            os.makedirs(self.path_to_model)

        self.model.save(
            self.path_to_model)
        self.history = self.history.history
        self.convert_to_Q_aware()

    def plot_float_model(self, n=6):
        """Plot the float model"""

        plt.figure(figsize=(10, 3))
        self.float_model_predictions = self.model.predict(self.x_test)
        self.plot_model_predictions(
            n,
            self.float_model_predictions,
            f'{whole_dir}/models/{self.model_type}images/float_model',
        )

    def representative_dataset(self):
        for data in self.x_train:
            # Scale the data using min and max values
            scaled_data = (data - self.input_min) / (self.input_max -
                                                     self.input_min) * (2 ** (self.BIT_WIDTH - 1))
            yield [np.array([scaled_data], dtype=np.float32)]

    def convert_to_Q_aware(self):
        quantize_model = tfmot.quantization.keras.quantize_model
        self.q_aware_model = quantize_model(self.model)
        self.q_aware_model.compile(optimizer='adam', loss='mse')
        self.fit_data_Q_aware()
        # loss = self.q_aware_model.evaluate(self.x_test, self.x_test, verbose=0)

        # # Save the quantized model
        # with open(f'quantized_model.tflite', 'wb') as f:
        #     f.write(self.q_aware_model)

        self.convert_to_tflite()

    def fit_data_Q_aware(self, batch_size=256, epochs=1):
        """Write the fit function for the autoencoder. 
        Storing the fit history in self.history to be able to plot the fitting scores."""

        self.path_to_quantized_model = f'{whole_dir}/models/{self.model_type}{self.model_name_id}_{str(self.loss)[0:7]}loss/quant_model{self.BIT_WIDTH}bits/KERAS_check_best_model.model'

        if not os.path.exists(self.path_to_quantized_model):
            os.makedirs(self.path_to_quantized_model)

        callbacks = all_callbacks(stop_patience=1000,
                                  lr_factor=0.5,
                                  lr_patience=10,
                                  lr_epsilon=0.000001,
                                  # min_delta=0.000001,
                                  lr_cooldown=2,
                                  lr_minimum=0.0000001,
                                  outputDir=f'models/{self.model_type}{self.model_name_id}_{str(self.loss)[0:7]}loss/quant_model{self.BIT_WIDTH}bits/callbacks')
        # callbacks.callbacks.append(pruning_callbacks.UpdatePruningStep())

        self.history_Q_aware = self.q_aware_model.fit(self.x_train, self.x_train,
                                                      validation_data=(
                                                          self.x_test, self.x_test),
                                                      batch_size=batch_size, epochs=epochs,
                                                      shuffle=True, callbacks=callbacks.callbacks)
        # self.model = strip_pruning(self.model)

        self.q_aware_model.save(
            self.path_to_quantized_model)
        self.history_Q_aware = self.history_Q_aware.history
        self.q_aware_loss = self.q_aware_model.evaluate(
            self.x_test, self.x_test, verbose=0)
        # self.convert_to_Q_aware()

    def convert_to_tflite(self):
        converter = tf.lite.TFLiteConverter.from_keras_model(
            self.q_aware_model)
        converter.optimizations = [tf.lite.Optimize.DEFAULT]
        converter.representative_dataset = self.representative_dataset
        converter.target_spec.supported_ops = [
            tf.lite.OpsSet.TFLITE_BUILTINS_INT8]
        converter.inference_input_type = tf.int8
        converter.inference_output_type = tf.int8

        self.quantized_tflite_model = converter.convert()

        # Save the TensorFlow Lite model
        path_to_tflite_model = f'{whole_dir}/models/{self.model_type}{self.model_name_id}_{str(self.loss)[0:7]}loss/saved_objects'
        if not os.path.exists(path_to_tflite_model):
            os.makedirs(path_to_tflite_model)
        with open(f"{path_to_tflite_model}/tflite_model.tflite", "wb") as file:
            file.write(self.quantized_tflite_model)

        # Load the quantized model
        self.interpreter = tf.lite.Interpreter(
            model_content=self.quantized_tflite_model)

        self.interpreter.allocate_tensors()

        # Get input and output details
        self.input_details = self.interpreter.get_input_details()
        self.output_details = self.interpreter.get_output_details()
        self.quantized_predictions()
        self.save_objects()

    def quantized_predictions(self, n=50):
        quantized_model_predictions = []

        for i in range(n):
            # Prepare input data
            # input_data = np.array(
            #     [self.x_test[i]*(2**(self.BIT_WIDTH-1))], dtype=np.int8)
            # input_data = np.array([(self.x_test[i] - self.input_min) / (self.input_max - self.input_min) * (2 ** (self.BIT_WIDTH - 1))], dtype=np.int8)
            input_data = np.array([(self.x_test[i] - self.input_min) / (
                self.input_max - self.input_min) * (2 ** (self.BIT_WIDTH))], dtype=np.int8)

            self.interpreter.set_tensor(
                self.input_details[0]['index'], input_data)
            # print(f"input_data: {input_data}")

            # Run inference
            self.interpreter.invoke()

            # Get output
            output_data = self.interpreter.get_tensor(
                self.output_details[0]['index'])
            output_data = self.interpreter.get_tensor(
                # self.output_details[0]['index']) / (2 ** (self.BIT_WIDTH - 1))
                self.output_details[0]['index'])
            # output_data = output_data * (self.input_max - self.input_min) / (2 ** (self.BIT_WIDTH - 1)) + self.input_min
            # output_data = output_data / (2 ** (self.BIT_WIDTH - 1))
            quantized_model_predictions.append(output_data)
            # print(f"output_data: {output_data}")

        self.quantized_model_predictions = quantized_model_predictions
        # self.compute_mse()

    def quantized_predictions2(self, n=50):
        quantized_model_predictions = []

        for i in range(n):
            # Prepare input data
            # input_data = np.array(
            #     [self.x_test[i]*(2**(self.BIT_WIDTH-1))], dtype=np.int8)
            # input_data = np.array([(self.x_test[i] - self.input_min) / (self.input_max - self.input_min) * (2 ** (self.BIT_WIDTH - 1))], dtype=np.int8)
            input_data = np.array([(self.x_test[i] - self.input_min) / (
                self.input_max - self.input_min) * (2 ** (self.BIT_WIDTH))], dtype=np.int64)

            self.interpreter.set_tensor(
                self.input_details[0]['index'], input_data)
            # print(f"input_data: {input_data}")

            # Run inference
            self.interpreter.invoke()

            # Get output
            output_data = self.interpreter.get_tensor(
                self.output_details[0]['index'])
            output_data = self.interpreter.get_tensor(
                # self.output_details[0]['index']) / (2 ** (self.BIT_WIDTH - 1))
                self.output_details[0]['index'])
            # output_data = output_data * (self.input_max - self.input_min) / (2 ** (self.BIT_WIDTH - 1)) + self.input_min
            # output_data = output_data / (2 ** (self.BIT_WIDTH - 1))
            quantized_model_predictions.append(output_data)
            # print(f"output_data: {output_data}")

        self.quantized_model_predictions = quantized_model_predictions
        # self.compute_mse()

    def plot_quantized_model(self, n=6):

        plt.figure(figsize=(10, 3))
        self.plot_model_predictions(
            n,
            self.quantized_model_predictions,
            f'{whole_dir}/models/{self.model_type}images/quant_model',
        )

    def plot_model_predictions(self, n, quantized_model_predictions, imgs_path):
        if not os.path.exists(imgs_path):
            os.makedirs(imgs_path)
        imgs_path = f"{imgs_path}/model_predictions{self.model_name}.png"

        img_size = int(np.sqrt(self.input_shape[0]))
        for i in range(n):
            ax = plt.subplot(2, n, i + 1)
            self.plot_imgs(
                self.x_test, i, img_size, ax
            )
            ax = plt.subplot(2, n, i + n + 1)
            self.plot_imgs(
                quantized_model_predictions, i, img_size, ax
            )
        plt.savefig(imgs_path.format(model_name=" complete"))
        plt.show()

    def plot_imgs(self, arg0, i, img_size, ax):
        plt.imshow(arg0[i].reshape(img_size, img_size), cmap='gray_r')
        ax.get_xaxis().set_visible(False)
        ax.get_yaxis().set_visible(False)

    def compute_mse(self):
        mse = mean_squared_error(
            self.float_model_predictions, self.quantized_model_predictions)
        print(
            f'Mean Squared Error between floating point and quantized model predictions: {mse}')
        self.mse = mse

    def save_objects(self):
        self.save_objects_path = '/'.join(self.path_to_model.split('/')[:-1])
        self.save_objects_path = f"{self.save_objects_path}/saved_objects"
        self.model.save(f"{self.save_objects_path}/model.h5")
        self.q_aware_model.save(
            f"{self.save_objects_path}/q_aware.h5")
        # self.save_objects_path = self.path_to_model
        # # Save the Keras model

        # # Save the .tflite model
        # with open(f"{self.path_to_model}/saved_objects.tflite", "wb") as file:
        #     file.write(self.quantized_tflite_model)
        # Save other attributes
        attrs_to_save = {
            'x_train': self.x_train,
            # 'y_train': self.y_train,
            'x_test': self.x_test,
            # 'y_test': self.y_test,
            'input_min': self.input_min,
            'input_max': self.input_max,
            'input_shape': self.input_shape,
            'BIT_WIDTH': self.BIT_WIDTH,
            'EPOCHS': self.EPOCHS,
            'Q_EPOCHS': self.Q_EPOCHS,
            'model_name': self.model_name,
            'history': self.history,
            'loss': self.loss,
            'float_model_predictions': self.float_model_predictions,
            'path_to_model': self.path_to_model,

            'path_to_quantized_model': self.path_to_quantized_model,
            # 'q_aware_model': self.q_aware_model,
            'q_aware_loss': self.q_aware_loss,
            'quantized_tflite_model': self.quantized_tflite_model,
            # 'interpreter': self.interpreter,
            # 'input_details': self.input_details,
            # 'output_details': self.output_details,
            'quantized_model_predictions': self.quantized_model_predictions,
            # 'history_Q_aware': self.history_Q_aware,
            # 'mse': self.mse,
            'save_objects_path': self.save_objects_path
        }
        with open(f'{self.save_objects_path}/model_obj_attributes.pickle', 'wb') as f:
            pickle.dump(attrs_to_save, f)


# BIT_WIDTH = 8
# # EPOCHS = 80
# # Q_EPOCHS = 25
# EPOCHS = 1
# Q_EPOCHS = 1
# BATCH_SIZE = 256
# MODEL_NAME = 'model'
# MINI_MODEL = True
# FIT_MODEL = True
# MODEL_SIZE = 0  # 0: short, 1: medium, 2: long, 3: very long


# MODEL_SIZE_list = [0, 1, 2, 3]
# if FIT_MODEL:
#     for _ in range(3):
#         for mode in [True, False]:
#             MINI_MODEL = mode
#             if MINI_MODEL:
#                 EPOCHS = 1
#                 Q_EPOCHS = 1
#             else:
#                 EPOCHS = 80
#                 Q_EPOCHS = 25

#             for item in MODEL_SIZE_list:
#                 MODEL_SIZE = item
#                 model_obj = QAutoencoder(data_zoom, bit_width=BIT_WIDTH,
#                                          EPOCHS=EPOCHS, Q_EPOCHS=Q_EPOCHS, model_name=MODEL_NAME)
#                 model_obj.fit_data(batch_size=BATCH_SIZE, epochs=EPOCHS)


# model_obj = QAutoencoder(data_zoom, bit_width=BIT_WIDTH,
#                          EPOCHS=EPOCHS, Q_EPOCHS=Q_EPOCHS, model_name=MODEL_NAME)
# model_obj.model.summary()
# # model.fit(x_train, x_train, epochs=EPOCHS, batch_size=BATCH_SIZE) #autoencoder
# if FIT_MODEL:
#     # batch_size=BATCH_SIZE, epochs=EPOCHS)
#     model_obj.fit_data(batch_size=BATCH_SIZE, epochs=EPOCHS)

# # create a quantized model
# def quantize_model(model, quantize_layer, quantize_config):
#     """Quantize a model.

#     Args:
#         model: The model to quantize.
#         quantize_layer: The layer to quantize.
#         quantize_config: The quantization configuration.

#     Returns:
#         The quantized model.
#     """
#     # Create a quantize wrapper for the layer.
#     quantize_wrapper = quantize_layer(**quantize_config)

#     # Quantize the model.
#     quantized_model = tf.keras.models.clone_model(
#         model,
#         clone_function=quantize_wrapper,
#     )

#     # `quantize_apply` requires a recompile.
#     quantized_model.compile(
#         loss='categorical_crossentropy',
#         optimizer='adam',
#         metrics=['accuracy'],
#     )

#     return quantized_model
import tensorflow as tf
import qkeras as qk

# Define the input shape
input_shape = (28, 28, 1)

# Create a sequential model
model = tf.keras.Sequential()

# Add a QDense layer with 128 output units
model.add(qk.qlayers.QDense(128, input_shape=input_shape))

# Add a QActivation layer with relu activation
model.add(qk.qlayers.QActivation('relu'))

# Add a QDense layer with 10 output units
model.add(qk.qlayers.QDense(10))

# Add a QActivation layer with softmax activation
model.add(qk.qlayers.QActivation('softmax'))

# Compile the model
model.compile(loss='categorical_crossentropy',
              optimizer='adam',
              metrics=['accuracy'])

# Print the model summary
model.summary()

# Train the model
model.fit(x_train, y_train,
          batch_size=128,
          epochs=10,
          validation_data=(x_test, y_test))

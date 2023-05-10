from keras.models import Sequential
from keras.layers.core import Dense, Dropout, Activation
from tensorflow.keras.optimizers import SGD
from keras.callbacks import Callback
from keras.initializers import VarianceScaling
import numpy as np

lastEpoch = 0


class EarlyStoppingByLossVal(Callback):
    def __init__(self, monitor='val_loss', value=0.008, verbose=0):
        super(Callback, self).__init__()
        self.monitor = monitor
        self.value = value
        self.verbose = verbose

    def on_epoch_end(self, epoch, logs={}):
        global lastEpoch
        current = logs.get("loss")
        if current != None and current < self.value:
            self.model.stop_training = True
            lastEpoch = epoch + 1


x = np.array([
    [0, 0], [0, 1],
    [1, 0], [1, 1]
])
y = np.array([
    [0], [1],
    [1], [0]
])

model = Sequential()
model.add(Dense(8,
                input_dim=2,
                use_bias=False,
                kernel_initializer=VarianceScaling()))
model.add(Activation('tanh'))
model.add(Dense(1,
                use_bias=False,
                kernel_initializer=VarianceScaling()))
model.add(Activation('tanh'))
model.compile(loss="mean_squared_error",
              optimizer=SGD(lr=0.6,
                            momentum=0.6))

model.fit(x, y,
          verbose=1,
          batch_size=4,
          epochs=10000,
          callbacks=[
              EarlyStoppingByLossVal()
          ])

print(model.predict(x))
print("Last epoch: " + str(lastEpoch))
model.save("xor2.h5")

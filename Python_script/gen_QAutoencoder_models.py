from model_conversion.Qaware.class_QAutoencoder import *

BIT_WIDTH = 8
EPOCHS = 80
Q_EPOCHS = 25
# EPOCHS = 1
# Q_EPOCHS = 1
BATCH_SIZE = 64
MODEL_NAME = 'model'
MINI_MODEL = True
FIT_MODEL = True
MODEL_SIZE = 0  # 0: short, 1: medium, 2: long, 3: very long


MODEL_SIZE_list = [0, 1, 2, 3]
if FIT_MODEL:
    for _ in range(3):
        for mode in [True, False]:
            # for mode in [True]:
            MINI_MODEL = mode

            if MINI_MODEL:
                EPOCHS = 1
                Q_EPOCHS = 1
            else:
                # EPOCHS = 1
                # Q_EPOCHS = 1
                EPOCHS = 80
                Q_EPOCHS = 25

            for item in MODEL_SIZE_list:
                MODEL_SIZE = item
                model_obj = QAutoencoder(data_zoom, bit_width=BIT_WIDTH,
                                         EPOCHS=EPOCHS, Q_EPOCHS=Q_EPOCHS, model_name=MODEL_NAME, MINI_MODEL=MINI_MODEL, MODEL_SIZE=MODEL_SIZE)
                model_obj.fit_data(batch_size=BATCH_SIZE, epochs=EPOCHS)


# model_obj = QAutoencoder(data_zoom, bit_width=BIT_WIDTH,
#                          EPOCHS=EPOCHS, Q_EPOCHS=Q_EPOCHS, model_name=MODEL_NAME, MINI_MODEL=MINI_MODEL, MODEL_SIZE=MODEL_SIZE)
# model_obj.model.summary()
# if FIT_MODEL:
#     model_obj.fit_data(batch_size=BATCH_SIZE, epochs=EPOCHS)

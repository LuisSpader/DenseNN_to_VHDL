//Numpy array shape [32, 10]
//Min -4.882812500000
//Max 2.451171875000
//Number of zeros 98

#ifndef W16_H_
#define W16_H_

#ifndef __SYNTHESIS__
weight16_t w16[320];
#else
weight16_t w16[320] = {1.099609375, 1.349609375, -0.109375000, 1.181640625, -4.882812500, -0.904296875, -3.224609375, 2.451171875, 0.203125000, 0.646484375, 0.859375000, -1.910156250, 0.085937500, 1.150390625, -3.214843750, 1.986328125, 0.787109375, -1.345703125, -0.298828125, -0.101562500, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.111328125, 1.109375000, -0.029296875, -0.062500000, 0.589843750, -1.064453125, 1.251953125, -2.214843750, 0.232421875, -0.001953125, -0.003906250, 1.007812500, -0.009765625, -1.017578125, 0.410156250, -1.435546875, 1.224609375, -1.869140625, 0.095703125, -0.849609375, -0.800781250, -1.955078125, 0.021484375, 0.923828125, 0.210937500, 0.617187500, 0.074218750, -0.234375000, 0.003906250, -0.103515625, 0.476562500, 0.261718750, -1.279296875, 1.330078125, 0.845703125, -0.283203125, -2.912109375, -0.218750000, -0.115234375, 0.085937500, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.669921875, -0.042968750, -1.714843750, 0.529296875, 0.193359375, 0.847656250, -1.398437500, -0.179687500, 0.441406250, -0.042968750, -0.007812500, 1.623046875, 1.492187500, 0.648437500, 0.878906250, 0.007812500, -0.044921875, -0.933593750, -3.912109375, -0.652343750, -0.449218750, -2.847656250, -0.027343750, 0.875000000, 0.210937500, 1.103515625, 0.390625000, -0.347656250, -0.130859375, 0.662109375, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.080078125, 0.000000000, 0.000000000, -0.832031250, 0.660156250, 0.503906250, -0.160156250, 0.960937500, -1.169921875, -3.044921875, -0.458984375, -0.205078125, 0.166015625, 0.193359375, -0.005859375, 1.050781250, -1.187500000, -0.349609375, -2.171875000, -3.103515625, 0.625000000, -0.798828125, 1.435546875, -1.011718750, -1.330078125, 0.107421875, 0.982421875, 0.541015625, 0.927734375, 0.089843750, -1.402343750, -0.001953125, 0.148437500, -0.005859375, 0.271484375, -0.013671875, 0.005859375, -1.005859375, -2.375000000, 1.250000000, 1.931640625, 0.248046875, -3.480468750, 1.664062500, -3.992187500, 0.847656250, 0.228515625, 0.005859375, 0.169921875, -2.248046875, -0.371093750, -0.099609375, 0.250000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.007812500, 0.906250000, -1.250000000, -2.353515625, -0.148437500, -2.353515625, -1.294921875, 1.525390625, -0.052734375, 0.621093750, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.318359375, 0.048828125, -0.003906250, -2.933593750, -1.419921875, -1.130859375, 0.402343750, 1.542968750, 0.308593750, 0.033203125, -1.960937500, -0.707031250, 0.761718750, 1.392578125, 1.175781250, 1.144531250, 0.410156250, -3.552734375, 0.222656250, -1.355468750, -0.878906250, 0.111328125, -0.726562500, 0.791015625, 0.175781250, 0.662109375, 0.007812500, -0.636718750, 0.445312500, 0.201171875, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, -1.996093750, 1.232421875, -0.085937500, -2.603515625, -0.623046875, -2.484375000, -0.654296875, 2.218750000, -0.119140625, 0.712890625, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, -1.000000000, 0.255859375, 0.343750000, -0.136718750, 1.416015625, -2.482421875, 0.011718750, 0.275390625, -2.250000000, 0.642578125, 1.884765625, 0.394531250, -1.818359375, -2.843750000, -0.642578125, -0.316406250, 0.017578125, 1.808593750, -2.462890625, 0.890625000, 0.000000000, 0.000000000, 0.035156250, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.000000000, 0.292968750, -0.035156250, 0.074218750, -3.738281250, -0.880859375, -0.357421875, 0.671875000, 0.591796875, 0.605468750, -0.792968750};
#endif

#endif
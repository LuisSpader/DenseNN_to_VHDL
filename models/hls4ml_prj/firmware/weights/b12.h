//Numpy array shape [16]
//Min -0.500000000000
//Max 0.562500000000
//Number of zeros 9

#ifndef B12_H_
#define B12_H_

#ifndef __SYNTHESIS__
bias12_t b12[16];
#else
bias12_t b12[16] = {0.0000, 0.0000, -0.0625, -0.3750, -0.5000, 0.0000, 0.0000, 0.0000, 0.5625, 0.0000, 0.0000, -0.4375, -0.4375, 0.0000, -0.2500, 0.0000};
#endif

#endif

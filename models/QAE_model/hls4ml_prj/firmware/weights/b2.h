//Numpy array shape [15]
//Min -0.312500000000
//Max 0.437500000000
//Number of zeros 2

#ifndef B2_H_
#define B2_H_

#ifndef __SYNTHESIS__
bias2_t b2[15];
#else
bias2_t b2[15] = {0.1250, -0.3125, 0.4375, 0.0625, 0.2500, 0.0625, -0.0625, 0.1250, 0.1250, 0.0625, 0.0000, 0.0000, -0.0625, 0.1875, -0.2500};
#endif

#endif

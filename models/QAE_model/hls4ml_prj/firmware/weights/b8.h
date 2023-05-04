//Numpy array shape [15]
//Min -0.187500000000
//Max 0.375000000000
//Number of zeros 1

#ifndef B8_H_
#define B8_H_

#ifndef __SYNTHESIS__
bias8_t b8[15];
#else
bias8_t b8[15] = {-0.0625, -0.1250, -0.0625, 0.3750, 0.1875, -0.0625, 0.1875, 0.1875, -0.1250, 0.0000, 0.1250, 0.1250, 0.2500, -0.1875, -0.0625};
#endif

#endif

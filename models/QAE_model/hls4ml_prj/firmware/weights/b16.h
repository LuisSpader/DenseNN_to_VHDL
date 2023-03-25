//Numpy array shape [40]
//Min -0.468750000000
//Max 0.562500000000
//Number of zeros 5

#ifndef B16_H_
#define B16_H_

#ifndef __SYNTHESIS__
bias16_t b16[40];
#else
bias16_t b16[40] = {0.25000, -0.03125, 0.28125, -0.03125, 0.03125, -0.06250, 0.00000, -0.46875, -0.03125, -0.03125, -0.09375, -0.25000, -0.28125, -0.03125, 0.09375, 0.06250, -0.03125, 0.46875, 0.34375, 0.18750, 0.09375, 0.56250, 0.18750, -0.31250, 0.00000, 0.00000, -0.40625, 0.18750, 0.40625, 0.03125, -0.03125, -0.06250, -0.15625, 0.21875, 0.43750, 0.00000, 0.00000, -0.09375, -0.09375, -0.03125};
#endif

#endif
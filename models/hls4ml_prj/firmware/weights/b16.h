//Numpy array shape [10]
//Min -0.773437500000
//Max 0.775390625000
//Number of zeros 0

#ifndef B16_H_
#define B16_H_

#ifndef __SYNTHESIS__
bias16_t b16[10];
#else
bias16_t b16[10] = {0.132812500, -0.568359375, -0.154296875, 0.775390625, 0.166015625, 0.681640625, 0.183593750, -0.773437500, -0.152343750, -0.132812500};
#endif

#endif

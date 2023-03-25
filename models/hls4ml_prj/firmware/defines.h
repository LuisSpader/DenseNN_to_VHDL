#ifndef DEFINES_H_
#define DEFINES_H_

#include "ap_int.h"
#include "ap_fixed.h"
#include "nnet_utils/nnet_types.h"
#include <cstddef>
#include <cstdio>

//hls-fpga-machine-learning insert numbers
#define N_INPUT_1_1 64
#define N_LAYER_2 32
#define N_LAYER_5 16
#define N_LAYER_8 10

//hls-fpga-machine-learning insert layer-precision
typedef ap_fixed<6,0> encoder_input_default_t;
typedef ap_fixed<6,0> input_t;
typedef ap_fixed<16,6> model_default_t;
typedef ap_fixed<16,6> layer2_t;
typedef ap_fixed<5,1> weight2_t;
typedef ap_fixed<5,1> bias2_t;
typedef ap_fixed<16,6,AP_RND,AP_SAT> layer3_t;
typedef ap_ufixed<5,0,AP_RND,AP_SAT> layer4_t;
typedef ap_fixed<16,6> layer5_t;
typedef ap_fixed<6,1> weight5_t;
typedef ap_fixed<6,1> bias5_t;
typedef ap_fixed<16,6,AP_RND,AP_SAT> layer6_t;
typedef ap_ufixed<6,0,AP_RND,AP_SAT> layer7_t;
typedef ap_fixed<16,6> layer8_t;
typedef ap_fixed<16,7> weight8_t;
typedef ap_fixed<16,7> bias8_t;
typedef ap_fixed<16,6,AP_RND,AP_SAT> layer9_t;
typedef ap_fixed<16,6> classifier_output_default_t;
typedef ap_fixed<16,6> result_t;

#endif

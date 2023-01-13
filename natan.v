module cnn_model_1_gen_blk
(
	input clk,
	input rst,

	/** input Hand Shaking **/ 
	input init_in_en,
	output init_blk_rdy,

	/** output Hand Shaking **/ 
	output ready,
	input  blk_rec_rdy,

	/** RAM_IN assignments **/
	output [10-1:0]   addr_RAM_in,
	input  [16-1:0]   data_RAM_in,

	/** RAM_OUT assignments **/
	output [2-1:0]    addr_wr_RAM_out,
	output [16-1:0]   data_wr_RAM_out,
	output            wr_en

);

/**** Summary of model_1, where the Input Shape is: 15x35x1 
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
conv2d_1 (Conv2D)            (None, 11, 31, 4)         104       
_________________________________________________________________
batch_normalization_1 (Batch (None, 11, 31, 4)         16        
_________________________________________________________________
activation_1 (Activation)    (None, 11, 31, 4)         0         
_________________________________________________________________
conv2d_2 (Conv2D)            (None, 8, 27, 6)          486       
_________________________________________________________________
activation_2 (Activation)    (None, 8, 27, 6)          0         
_________________________________________________________________
conv2d_3 (Conv2D)            (None, 7, 23, 8)          488       
_________________________________________________________________
activation_3 (Activation)    (None, 7, 23, 8)          0         
_________________________________________________________________
conv2d_4 (Conv2D)            (None, 6, 19, 10)         810       
_________________________________________________________________
activation_4 (Activation)    (None, 6, 19, 10)         0         
_________________________________________________________________
conv2d_5 (Conv2D)            (None, 6, 16, 12)         492       
_________________________________________________________________
activation_5 (Activation)    (None, 6, 16, 12)         0         
_________________________________________________________________
max_pooling2d_1 (MaxPooling2 (None, 3, 8, 12)          0         
_________________________________________________________________
conv2d_6 (Conv2D)            (None, 2, 6, 14)          1022      
_________________________________________________________________
activation_6 (Activation)    (None, 2, 6, 14)          0         
_________________________________________________________________
flatten_fpg_a2d_1 (FlattenFP (None, 168)               0         
_________________________________________________________________
dense_1 (Dense)              (None, 100)               16900     
_________________________________________________________________
dense_2 (Dense)              (None, 4)                 404       
_________________________________________________________________
activation_7 (Activation)    (None, 4)                 0         
=================================================================
Total params: 20,722
Trainable params: 20,714
Non-trainable params: 8
_________________________________________________________________

****/

	/********** convolutional 2D block: conv2d_1; dims=15x35x1 to 11x31x4 **********/
	localparam H_C1_IN	= 15;
	localparam W_C1_IN	= 35;
	localparam C_C1_IN	= 1;

	localparam H_C1_FILTERS = 5; 
	localparam W_C1_FILTERS = 5;
	localparam N_C1_FILTERS = 4;

	localparam H_C1_IN_LOG = 4;
	localparam W_C1_IN_LOG = 6;
	localparam C_C1_IN_LOG = 1;

	localparam H_C1_F_LOG = 3;
	localparam W_C1_F_LOG = 3;
	localparam N_C1_F_LOG = 2;

	localparam H_C1_OUT_LOG = 4;
	localparam W_C1_OUT_LOG = 5; 

	localparam H_C1_OUT 	= 11;
	localparam W_C1_OUT 	= 31;
	localparam C_C1_OUT 	= 4;

	localparam RAM_W_C1_IN = 10;
	localparam RAM_D_C1_IN = 16;

	localparam ROM_D_C1 = 16;

	localparam RAM_W_C1_OUT = 11;
	localparam RAM_L_C1_OUT = 1364; // .RAM_LENGHT_OUT(RAM_L_C1_OUT)
	localparam RAM_D_C1_OUT = 16;

	wire init_c1_in_en = init_in_en;	// wire in
	wire init_c1_blk_rdy;					// wire out

	wire ready_c1;							// wire out
	wire blk_c1_rec_rdy; 					// wire in
	// wire blk_c1_rec_rdy = #(READ_REC_WIRE); // wire in

	wire [RAM_W_C1_IN-1:0]	addr_RAM_c1_in;
	wire [RAM_D_C1_IN-1:0] 	data_RAM_c1_in = data_RAM_in;
	

	wire [N_C1_F_LOG-1:0] ch_number_c1_out;
	wire [RAM_W_C1_OUT-1:0]	addr_wr_RAM_c1_out;
	wire [RAM_D_C1_OUT-1:0]	data_wr_RAM_c1_out;
	wire 					wr_en_RAM_c1_out;

	conv2d_slim_blk #(	 .HEIGHT_IN(H_C1_IN),           .WIDTH_IN(W_C1_IN),           .CHANNELS_IN(C_C1_IN),
						 .HEIGHT_FILTERS(H_C1_FILTERS), .WIDTH_FILTERS(W_C1_FILTERS), .N_FILTERS(N_C1_FILTERS),
						 .H_IN_LOG(H_C1_IN_LOG),        .W_IN_LOG(W_C1_IN_LOG),       .N_IN_LOG(C_C1_IN_LOG),
						 .H_FILT_LOG(H_C1_F_LOG),       .W_FILT_LOG(W_C1_F_LOG),      .N_FILT_LOG(N_C1_F_LOG),
						 .H_OUT_LOG(H_C1_OUT_LOG),      .W_OUT_LOG(W_C1_OUT_LOG), 
						 .RAM_WIDTH_IN(RAM_W_C1_IN),    .W_DATA_IN(RAM_D_C1_IN),
						 .RAM_WIDTH_OUT(RAM_W_C1_OUT),  .W_DATA_OUT(RAM_D_C1_OUT),    .RAM_IN_PIPE(2), 
						 .GAIN_LOG(-1),                  .BIAS_ADJ(362), 
						 .W_ROM_DATA(ROM_D_C1), .ROM_MIF("files_mifs/cnn/model_1/conv2d_1_5x5x1x4.mif") )
	conv2d_1_slim_blk
	(
		.clk(clk),
		.rst(rst),

		/** input Hand Shaking **/ 
		.init_in_en(init_c1_in_en),
		.init_blk_rdy(init_c1_blk_rdy),

		/** .Hand Shaking **/ 
		.ready(ready_c1),
		.blk_rec_rdy(blk_c1_rec_rdy),

		/** RAM_in assignments **/
		.addr_RAM_in(addr_RAM_c1_in),
		.data_RAM_in(data_RAM_c1_in),

		/** RAM_out assignments **/
		.ch_number_out(ch_number_c1_out),
		.addr_wr_RAM_out(addr_wr_RAM_c1_out),
		.data_wr_RAM_out(data_wr_RAM_c1_out),
		.wr_en(wr_en_RAM_c1_out)

	);
	/****************************************************************************/

	/********** Batch Norm block: batch_normalization_1 **********/
	localparam ROM_D_B1 = 16;

	wire [RAM_W_C1_OUT-1:0]	addr_wr_batch_normalization_1_out;
	wire [RAM_D_C1_OUT-1:0]	data_wr_batch_normalization_1_out;
	wire 					wr_en_batch_normalization_1_out;

	batch_norm_blk #( .CHANNELS_IN(N_C1_FILTERS), .CH_IN_LOG(N_C1_F_LOG),
					  .RAM_WIDTH_IN(RAM_W_C1_OUT),   .W_DATA_IN(RAM_D_C1_OUT),
					  .RAM_WIDTH_OUT(RAM_W_C1_OUT),  .W_DATA_OUT(RAM_D_C1_OUT), // .RAM_LENGHT_OUT(RAM_L_C1_OUT)
					  .GAIN_LOG(1),                 .BIAS_ADJ(149), 
					  .W_ROM_DATA(ROM_D_B1),    .ROM_MIF("files_mifs/cnn/model_1/batch_normalization_1_4.mif") ) 
	batch_normalization_1_blk
	(
		.clk(clk),
		.rst(rst),

		/** RAM_IN assignments **/
		.ch_number_in(ch_number_c1_out),
		.addr_RAM_in(addr_wr_RAM_c1_out),
		.data_RAM_in(data_wr_RAM_c1_out),
		.wr_en_in(wr_en_RAM_c1_out),

		/** RAM_OUT assignments **/
		.addr_wr_RAM_out(addr_wr_batch_normalization_1_out),
		.data_wr_RAM_out(data_wr_batch_normalization_1_out),
		.wr_en(wr_en_batch_normalization_1_out)

	);
	/************************************************/

	/********** ReLU block: conv2d_1_bnorm **********/
	wire [RAM_W_C1_OUT-1:0]	addr_wr_conv2d_1_bnorm_relu_out;
	wire [RAM_D_C1_OUT-1:0]	data_wr_conv2d_1_bnorm_relu_out;
	wire 					wr_en_relu_conv2d_1_bnorm_out;

	relu_blk #( .RAM_WIDTH_IN(RAM_W_C1_OUT),   .W_DATA_IN(RAM_D_C1_OUT),
				.RAM_WIDTH_OUT(RAM_W_C1_OUT),  .W_DATA_OUT(RAM_D_C1_OUT),	// .RAM_LENGHT_OUT(RAM_L_C1_OUT)
				.RAM_IN_PIPE(0) )
	conv2d_1_bnorm_relu_blk
	(
		.clk(clk),

		/** RAM_IN assignments **/
		.addr_RAM_in(addr_wr_batch_normalization_1_out),
		.data_RAM_in(data_wr_batch_normalization_1_out),
		.wr_en_in(wr_en_batch_normalization_1_out),

		/** RAM_OUT assignments **/
		.addr_wr_RAM_out(addr_wr_conv2d_1_bnorm_relu_out),
		.data_wr_RAM_out(data_wr_conv2d_1_bnorm_relu_out),
		.wr_en(wr_en_relu_conv2d_1_bnorm_out)

	);
	/******************************************/

	/**************** RAM 2-port conv2d_1 to conv2d_2 *****************/
	wire [RAM_W_C1_OUT-1:0]	addr_rd_RAM_1;
	wire [RAM_D_C1_OUT-1:0]	data_rd_RAM_1;

	RAM_2_port_gen #( .LENGTH(RAM_W_C1_OUT), .LENGTH_EXP(RAM_L_C1_OUT), .WIDTH(RAM_D_C1_OUT) )
	RAM_2_port_1
	(
		.clock(clk),

		.address_a(addr_wr_conv2d_1_bnorm_relu_out),
		.data_a(data_wr_conv2d_1_bnorm_relu_out),
		.wren_a(wr_en_relu_conv2d_1_bnorm_out),
		.q_a(),

		.address_b(addr_rd_RAM_1),
		.data_b(),
		.wren_b(),
		.q_b(data_rd_RAM_1)
	);
	/******************************************************************/

	/********** convolutional 2D block: conv2d_2; dims=11x31x4 to 8x27x6 **********/
	localparam H_C2_IN	= 11;
	localparam W_C2_IN	= 31;
	localparam C_C2_IN	= 4;

	localparam H_C2_FILTERS = 4; 
	localparam W_C2_FILTERS = 5;
	localparam N_C2_FILTERS = 6;

	localparam H_C2_IN_LOG = 4;
	localparam W_C2_IN_LOG = 5;
	localparam C_C2_IN_LOG = 2;

	localparam H_C2_F_LOG = 2;
	localparam W_C2_F_LOG = 3;
	localparam N_C2_F_LOG = 3;

	localparam H_C2_OUT_LOG = 3;
	localparam W_C2_OUT_LOG = 5; 

	localparam H_C2_OUT 	= 8;
	localparam W_C2_OUT 	= 27;
	localparam C_C2_OUT 	= 6;

	localparam RAM_W_C2_IN = 11;
	localparam RAM_D_C2_IN = 16;

	localparam ROM_D_C2 = 16;

	localparam RAM_W_C2_OUT = 11;
	localparam RAM_L_C2_OUT = 1296; // .RAM_LENGHT_OUT(RAM_L_C2_OUT)
	localparam RAM_D_C2_OUT = 16;

	wire init_c2_in_en = ready_c1;	// wire in
	wire init_c2_blk_rdy;					// wire out

	wire ready_c2;							// wire out
	wire blk_c2_rec_rdy; 					// wire in
	// wire blk_c2_rec_rdy = #(READ_REC_WIRE); // wire in

	wire [RAM_W_C2_IN-1:0]	addr_RAM_c2_in;
	wire [RAM_D_C2_IN-1:0] 	data_RAM_c2_in = data_rd_RAM_1;
	assign addr_rd_RAM_1 = addr_RAM_c2_in;

	wire [N_C2_F_LOG-1:0] ch_number_c2_out;
	wire [RAM_W_C2_OUT-1:0]	addr_wr_RAM_c2_out;
	wire [RAM_D_C2_OUT-1:0]	data_wr_RAM_c2_out;
	wire 					wr_en_RAM_c2_out;

	conv2d_slim_blk #(	 .HEIGHT_IN(H_C2_IN),           .WIDTH_IN(W_C2_IN),           .CHANNELS_IN(C_C2_IN),
						 .HEIGHT_FILTERS(H_C2_FILTERS), .WIDTH_FILTERS(W_C2_FILTERS), .N_FILTERS(N_C2_FILTERS),
						 .H_IN_LOG(H_C2_IN_LOG),        .W_IN_LOG(W_C2_IN_LOG),       .N_IN_LOG(C_C2_IN_LOG),
						 .H_FILT_LOG(H_C2_F_LOG),       .W_FILT_LOG(W_C2_F_LOG),      .N_FILT_LOG(N_C2_F_LOG),
						 .H_OUT_LOG(H_C2_OUT_LOG),      .W_OUT_LOG(W_C2_OUT_LOG), 
						 .RAM_WIDTH_IN(RAM_W_C2_IN),    .W_DATA_IN(RAM_D_C2_IN),
						 .RAM_WIDTH_OUT(RAM_W_C2_OUT),  .W_DATA_OUT(RAM_D_C2_OUT),    .RAM_IN_PIPE(2), 
						 .GAIN_LOG(2),                  .BIAS_ADJ(643), 
						 .W_ROM_DATA(ROM_D_C2), .ROM_MIF("files_mifs/cnn/model_1/conv2d_2_4x5x4x6.mif") )
	conv2d_2_slim_blk
	(
		.clk(clk),
		.rst(rst),

		/** input Hand Shaking **/ 
		.init_in_en(init_c2_in_en),
		.init_blk_rdy(init_c2_blk_rdy),

		/** .Hand Shaking **/ 
		.ready(ready_c2),
		.blk_rec_rdy(blk_c2_rec_rdy),

		/** RAM_in assignments **/
		.addr_RAM_in(addr_RAM_c2_in),
		.data_RAM_in(data_RAM_c2_in),

		/** RAM_out assignments **/
		.ch_number_out(ch_number_c2_out),
		.addr_wr_RAM_out(addr_wr_RAM_c2_out),
		.data_wr_RAM_out(data_wr_RAM_c2_out),
		.wr_en(wr_en_RAM_c2_out)

	);
	/****************************************************************************/

	/********** ReLU block: conv2d_2 **********/
	wire [RAM_W_C2_OUT-1:0]	addr_wr_conv2d_2_relu_out;
	wire [RAM_D_C2_OUT-1:0]	data_wr_conv2d_2_relu_out;
	wire 					wr_en_relu_conv2d_2_out;

	relu_blk #( .RAM_WIDTH_IN(RAM_W_C2_OUT),   .W_DATA_IN(RAM_D_C2_OUT),
				.RAM_WIDTH_OUT(RAM_W_C2_OUT),  .W_DATA_OUT(RAM_D_C2_OUT),	// .RAM_LENGHT_OUT(RAM_L_C2_OUT)
				.RAM_IN_PIPE(0) )
	conv2d_2_relu_blk
	(
		.clk(clk),

		/** RAM_IN assignments **/
		.addr_RAM_in(addr_wr_RAM_c2_out),
		.data_RAM_in(data_wr_RAM_c2_out),
		.wr_en_in(wr_en_RAM_c2_out),

		/** RAM_OUT assignments **/
		.addr_wr_RAM_out(addr_wr_conv2d_2_relu_out),
		.data_wr_RAM_out(data_wr_conv2d_2_relu_out),
		.wr_en(wr_en_relu_conv2d_2_out)

	);
	/******************************************/

	/**************** RAM 2-port conv2d_2 to conv2d_3 *****************/
	wire [RAM_W_C2_OUT-1:0]	addr_rd_RAM_2;
	wire [RAM_D_C2_OUT-1:0]	data_rd_RAM_2;

	RAM_2_port_gen #( .LENGTH(RAM_W_C2_OUT), .LENGTH_EXP(RAM_L_C2_OUT), .WIDTH(RAM_D_C2_OUT) )
	RAM_2_port_2
	(
		.clock(clk),

		.address_a(addr_wr_conv2d_2_relu_out),
		.data_a(data_wr_conv2d_2_relu_out),
		.wren_a(wr_en_relu_conv2d_2_out),
		.q_a(),

		.address_b(addr_rd_RAM_2),
		.data_b(),
		.wren_b(),
		.q_b(data_rd_RAM_2)
	);
	/******************************************************************/

	/********** convolutional 2D block: conv2d_3; dims=8x27x6 to 7x23x8 **********/
	localparam H_C3_IN	= 8;
	localparam W_C3_IN	= 27;
	localparam C_C3_IN	= 6;

	localparam H_C3_FILTERS = 2; 
	localparam W_C3_FILTERS = 5;
	localparam N_C3_FILTERS = 8;

	localparam H_C3_IN_LOG = 3;
	localparam W_C3_IN_LOG = 5;
	localparam C_C3_IN_LOG = 3;

	localparam H_C3_F_LOG = 1;
	localparam W_C3_F_LOG = 3;
	localparam N_C3_F_LOG = 3;

	localparam H_C3_OUT_LOG = 3;
	localparam W_C3_OUT_LOG = 5; 

	localparam H_C3_OUT 	= 7;
	localparam W_C3_OUT 	= 23;
	localparam C_C3_OUT 	= 8;

	localparam RAM_W_C3_IN = 11;
	localparam RAM_D_C3_IN = 16;

	localparam ROM_D_C3 = 16;

	localparam RAM_W_C3_OUT = 11;
	localparam RAM_L_C3_OUT = 1288; // .RAM_LENGHT_OUT(RAM_L_C3_OUT)
	localparam RAM_D_C3_OUT = 16;

	wire init_c3_in_en = ready_c2;	// wire in
	wire init_c3_blk_rdy;					// wire out

	wire ready_c3;							// wire out
	wire blk_c3_rec_rdy; 					// wire in
	// wire blk_c3_rec_rdy = #(READ_REC_WIRE); // wire in

	wire [RAM_W_C3_IN-1:0]	addr_RAM_c3_in;
	wire [RAM_D_C3_IN-1:0] 	data_RAM_c3_in = data_rd_RAM_2;
	assign addr_rd_RAM_2 = addr_RAM_c3_in;

	wire [N_C3_F_LOG-1:0] ch_number_c3_out;
	wire [RAM_W_C3_OUT-1:0]	addr_wr_RAM_c3_out;
	wire [RAM_D_C3_OUT-1:0]	data_wr_RAM_c3_out;
	wire 					wr_en_RAM_c3_out;

	conv2d_slim_blk #(	 .HEIGHT_IN(H_C3_IN),           .WIDTH_IN(W_C3_IN),           .CHANNELS_IN(C_C3_IN),
						 .HEIGHT_FILTERS(H_C3_FILTERS), .WIDTH_FILTERS(W_C3_FILTERS), .N_FILTERS(N_C3_FILTERS),
						 .H_IN_LOG(H_C3_IN_LOG),        .W_IN_LOG(W_C3_IN_LOG),       .N_IN_LOG(C_C3_IN_LOG),
						 .H_FILT_LOG(H_C3_F_LOG),       .W_FILT_LOG(W_C3_F_LOG),      .N_FILT_LOG(N_C3_F_LOG),
						 .H_OUT_LOG(H_C3_OUT_LOG),      .W_OUT_LOG(W_C3_OUT_LOG), 
						 .RAM_WIDTH_IN(RAM_W_C3_IN),    .W_DATA_IN(RAM_D_C3_IN),
						 .RAM_WIDTH_OUT(RAM_W_C3_OUT),  .W_DATA_OUT(RAM_D_C3_OUT),    .RAM_IN_PIPE(2), 
						 .GAIN_LOG(1),                  .BIAS_ADJ(1050), 
						 .W_ROM_DATA(ROM_D_C3), .ROM_MIF("files_mifs/cnn/model_1/conv2d_3_2x5x6x8.mif") )
	conv2d_3_slim_blk
	(
		.clk(clk),
		.rst(rst),

		/** input Hand Shaking **/ 
		.init_in_en(init_c3_in_en),
		.init_blk_rdy(init_c3_blk_rdy),

		/** .Hand Shaking **/ 
		.ready(ready_c3),
		.blk_rec_rdy(blk_c3_rec_rdy),

		/** RAM_in assignments **/
		.addr_RAM_in(addr_RAM_c3_in),
		.data_RAM_in(data_RAM_c3_in),

		/** RAM_out assignments **/
		.ch_number_out(ch_number_c3_out),
		.addr_wr_RAM_out(addr_wr_RAM_c3_out),
		.data_wr_RAM_out(data_wr_RAM_c3_out),
		.wr_en(wr_en_RAM_c3_out)

	);
	/****************************************************************************/

	/********** ReLU block: conv2d_3 **********/
	wire [RAM_W_C3_OUT-1:0]	addr_wr_conv2d_3_relu_out;
	wire [RAM_D_C3_OUT-1:0]	data_wr_conv2d_3_relu_out;
	wire 					wr_en_relu_conv2d_3_out;

	relu_blk #( .RAM_WIDTH_IN(RAM_W_C3_OUT),   .W_DATA_IN(RAM_D_C3_OUT),
				.RAM_WIDTH_OUT(RAM_W_C3_OUT),  .W_DATA_OUT(RAM_D_C3_OUT),	// .RAM_LENGHT_OUT(RAM_L_C3_OUT)
				.RAM_IN_PIPE(0) )
	conv2d_3_relu_blk
	(
		.clk(clk),

		/** RAM_IN assignments **/
		.addr_RAM_in(addr_wr_RAM_c3_out),
		.data_RAM_in(data_wr_RAM_c3_out),
		.wr_en_in(wr_en_RAM_c3_out),

		/** RAM_OUT assignments **/
		.addr_wr_RAM_out(addr_wr_conv2d_3_relu_out),
		.data_wr_RAM_out(data_wr_conv2d_3_relu_out),
		.wr_en(wr_en_relu_conv2d_3_out)

	);
	/******************************************/

	/**************** RAM 2-port conv2d_3 to conv2d_4 *****************/
	wire [RAM_W_C3_OUT-1:0]	addr_rd_RAM_3;
	wire [RAM_D_C3_OUT-1:0]	data_rd_RAM_3;

	RAM_2_port_gen #( .LENGTH(RAM_W_C3_OUT), .LENGTH_EXP(RAM_L_C3_OUT), .WIDTH(RAM_D_C3_OUT) )
	RAM_2_port_3
	(
		.clock(clk),

		.address_a(addr_wr_conv2d_3_relu_out),
		.data_a(data_wr_conv2d_3_relu_out),
		.wren_a(wr_en_relu_conv2d_3_out),
		.q_a(),

		.address_b(addr_rd_RAM_3),
		.data_b(),
		.wren_b(),
		.q_b(data_rd_RAM_3)
	);
	/******************************************************************/

	/********** convolutional 2D block: conv2d_4; dims=7x23x8 to 6x19x10 **********/
	localparam H_C4_IN	= 7;
	localparam W_C4_IN	= 23;
	localparam C_C4_IN	= 8;

	localparam H_C4_FILTERS = 2; 
	localparam W_C4_FILTERS = 5;
	localparam N_C4_FILTERS = 10;

	localparam H_C4_IN_LOG = 3;
	localparam W_C4_IN_LOG = 5;
	localparam C_C4_IN_LOG = 3;

	localparam H_C4_F_LOG = 1;
	localparam W_C4_F_LOG = 3;
	localparam N_C4_F_LOG = 4;

	localparam H_C4_OUT_LOG = 3;
	localparam W_C4_OUT_LOG = 5; 

	localparam H_C4_OUT 	= 6;
	localparam W_C4_OUT 	= 19;
	localparam C_C4_OUT 	= 10;

	localparam RAM_W_C4_IN = 11;
	localparam RAM_D_C4_IN = 16;

	localparam ROM_D_C4 = 16;

	localparam RAM_W_C4_OUT = 11;
	localparam RAM_L_C4_OUT = 1140; // .RAM_LENGHT_OUT(RAM_L_C4_OUT)
	localparam RAM_D_C4_OUT = 16;

	wire init_c4_in_en = ready_c3;	// wire in
	wire init_c4_blk_rdy;					// wire out

	wire ready_c4;							// wire out
	wire blk_c4_rec_rdy; 					// wire in
	// wire blk_c4_rec_rdy = #(READ_REC_WIRE); // wire in

	wire [RAM_W_C4_IN-1:0]	addr_RAM_c4_in;
	wire [RAM_D_C4_IN-1:0] 	data_RAM_c4_in = data_rd_RAM_3;
	assign addr_rd_RAM_3 = addr_RAM_c4_in;

	wire [N_C4_F_LOG-1:0] ch_number_c4_out;
	wire [RAM_W_C4_OUT-1:0]	addr_wr_RAM_c4_out;
	wire [RAM_D_C4_OUT-1:0]	data_wr_RAM_c4_out;
	wire 					wr_en_RAM_c4_out;

	conv2d_slim_blk #(	 .HEIGHT_IN(H_C4_IN),           .WIDTH_IN(W_C4_IN),           .CHANNELS_IN(C_C4_IN),
						 .HEIGHT_FILTERS(H_C4_FILTERS), .WIDTH_FILTERS(W_C4_FILTERS), .N_FILTERS(N_C4_FILTERS),
						 .H_IN_LOG(H_C4_IN_LOG),        .W_IN_LOG(W_C4_IN_LOG),       .N_IN_LOG(C_C4_IN_LOG),
						 .H_FILT_LOG(H_C4_F_LOG),       .W_FILT_LOG(W_C4_F_LOG),      .N_FILT_LOG(N_C4_F_LOG),
						 .H_OUT_LOG(H_C4_OUT_LOG),      .W_OUT_LOG(W_C4_OUT_LOG), 
						 .RAM_WIDTH_IN(RAM_W_C4_IN),    .W_DATA_IN(RAM_D_C4_IN),
						 .RAM_WIDTH_OUT(RAM_W_C4_OUT),  .W_DATA_OUT(RAM_D_C4_OUT),    .RAM_IN_PIPE(2), 
						 .GAIN_LOG(1),                  .BIAS_ADJ(710), 
						 .W_ROM_DATA(ROM_D_C4), .ROM_MIF("files_mifs/cnn/model_1/conv2d_4_2x5x8x10.mif") )
	conv2d_4_slim_blk
	(
		.clk(clk),
		.rst(rst),

		/** input Hand Shaking **/ 
		.init_in_en(init_c4_in_en),
		.init_blk_rdy(init_c4_blk_rdy),

		/** .Hand Shaking **/ 
		.ready(ready_c4),
		.blk_rec_rdy(blk_c4_rec_rdy),

		/** RAM_in assignments **/
		.addr_RAM_in(addr_RAM_c4_in),
		.data_RAM_in(data_RAM_c4_in),

		/** RAM_out assignments **/
		.ch_number_out(ch_number_c4_out),
		.addr_wr_RAM_out(addr_wr_RAM_c4_out),
		.data_wr_RAM_out(data_wr_RAM_c4_out),
		.wr_en(wr_en_RAM_c4_out)

	);
	/****************************************************************************/

	/********** ReLU block: conv2d_4 **********/
	wire [RAM_W_C4_OUT-1:0]	addr_wr_conv2d_4_relu_out;
	wire [RAM_D_C4_OUT-1:0]	data_wr_conv2d_4_relu_out;
	wire 					wr_en_relu_conv2d_4_out;

	relu_blk #( .RAM_WIDTH_IN(RAM_W_C4_OUT),   .W_DATA_IN(RAM_D_C4_OUT),
				.RAM_WIDTH_OUT(RAM_W_C4_OUT),  .W_DATA_OUT(RAM_D_C4_OUT),	// .RAM_LENGHT_OUT(RAM_L_C4_OUT)
				.RAM_IN_PIPE(0) )
	conv2d_4_relu_blk
	(
		.clk(clk),

		/** RAM_IN assignments **/
		.addr_RAM_in(addr_wr_RAM_c4_out),
		.data_RAM_in(data_wr_RAM_c4_out),
		.wr_en_in(wr_en_RAM_c4_out),

		/** RAM_OUT assignments **/
		.addr_wr_RAM_out(addr_wr_conv2d_4_relu_out),
		.data_wr_RAM_out(data_wr_conv2d_4_relu_out),
		.wr_en(wr_en_relu_conv2d_4_out)

	);
	/******************************************/

	/**************** RAM 2-port conv2d_4 to conv2d_5 *****************/
	wire [RAM_W_C4_OUT-1:0]	addr_rd_RAM_4;
	wire [RAM_D_C4_OUT-1:0]	data_rd_RAM_4;

	RAM_2_port_gen #( .LENGTH(RAM_W_C4_OUT), .LENGTH_EXP(RAM_L_C4_OUT), .WIDTH(RAM_D_C4_OUT) )
	RAM_2_port_4
	(
		.clock(clk),

		.address_a(addr_wr_conv2d_4_relu_out),
		.data_a(data_wr_conv2d_4_relu_out),
		.wren_a(wr_en_relu_conv2d_4_out),
		.q_a(),

		.address_b(addr_rd_RAM_4),
		.data_b(),
		.wren_b(),
		.q_b(data_rd_RAM_4)
	);
	/******************************************************************/

	/********** convolutional 2D block: conv2d_5; dims=6x19x10 to 6x16x12 **********/
	localparam H_C5_IN	= 6;
	localparam W_C5_IN	= 19;
	localparam C_C5_IN	= 10;

	localparam H_C5_FILTERS = 1; 
	localparam W_C5_FILTERS = 4;
	localparam N_C5_FILTERS = 12;

	localparam H_C5_IN_LOG = 3;
	localparam W_C5_IN_LOG = 5;
	localparam C_C5_IN_LOG = 4;

	localparam H_C5_F_LOG = 1;
	localparam W_C5_F_LOG = 2;
	localparam N_C5_F_LOG = 4;

	localparam H_C5_OUT_LOG = 3;
	localparam W_C5_OUT_LOG = 4; 

	localparam H_C5_OUT 	= 6;
	localparam W_C5_OUT 	= 16;
	localparam C_C5_OUT 	= 12;

	localparam RAM_W_C5_IN = 11;
	localparam RAM_D_C5_IN = 16;

	localparam ROM_D_C5 = 16;

	localparam RAM_W_C5_OUT = 11;
	localparam RAM_L_C5_OUT = 1152; // .RAM_LENGHT_OUT(RAM_L_C5_OUT)
	localparam RAM_D_C5_OUT = 16;

	wire init_c5_in_en = ready_c4;	// wire in
	wire init_c5_blk_rdy;					// wire out

	wire ready_c5;							// wire out
	wire blk_c5_rec_rdy; 					// wire in
	// wire blk_c5_rec_rdy = #(READ_REC_WIRE); // wire in

	wire [RAM_W_C5_IN-1:0]	addr_RAM_c5_in;
	wire [RAM_D_C5_IN-1:0] 	data_RAM_c5_in = data_rd_RAM_4;
	assign addr_rd_RAM_4 = addr_RAM_c5_in;

	wire [N_C5_F_LOG-1:0] ch_number_c5_out;
	wire [RAM_W_C5_OUT-1:0]	addr_wr_RAM_c5_out;
	wire [RAM_D_C5_OUT-1:0]	data_wr_RAM_c5_out;
	wire 					wr_en_RAM_c5_out;

	conv2d_slim_blk #(	 .HEIGHT_IN(H_C5_IN),           .WIDTH_IN(W_C5_IN),           .CHANNELS_IN(C_C5_IN),
						 .HEIGHT_FILTERS(H_C5_FILTERS), .WIDTH_FILTERS(W_C5_FILTERS), .N_FILTERS(N_C5_FILTERS),
						 .H_IN_LOG(H_C5_IN_LOG),        .W_IN_LOG(W_C5_IN_LOG),       .N_IN_LOG(C_C5_IN_LOG),
						 .H_FILT_LOG(H_C5_F_LOG),       .W_FILT_LOG(W_C5_F_LOG),      .N_FILT_LOG(N_C5_F_LOG),
						 .H_OUT_LOG(H_C5_OUT_LOG),      .W_OUT_LOG(W_C5_OUT_LOG), 
						 .RAM_WIDTH_IN(RAM_W_C5_IN),    .W_DATA_IN(RAM_D_C5_IN),
						 .RAM_WIDTH_OUT(RAM_W_C5_OUT),  .W_DATA_OUT(RAM_D_C5_OUT),    .RAM_IN_PIPE(2), 
						 .GAIN_LOG(1),                  .BIAS_ADJ(434), 
						 .W_ROM_DATA(ROM_D_C5), .ROM_MIF("files_mifs/cnn/model_1/conv2d_5_1x4x10x12.mif") )
	conv2d_5_slim_blk
	(
		.clk(clk),
		.rst(rst),

		/** input Hand Shaking **/ 
		.init_in_en(init_c5_in_en),
		.init_blk_rdy(init_c5_blk_rdy),

		/** .Hand Shaking **/ 
		.ready(ready_c5),
		.blk_rec_rdy(blk_c5_rec_rdy),

		/** RAM_in assignments **/
		.addr_RAM_in(addr_RAM_c5_in),
		.data_RAM_in(data_RAM_c5_in),

		/** RAM_out assignments **/
		.ch_number_out(ch_number_c5_out),
		.addr_wr_RAM_out(addr_wr_RAM_c5_out),
		.data_wr_RAM_out(data_wr_RAM_c5_out),
		.wr_en(wr_en_RAM_c5_out)

	);
	/****************************************************************************/

	/********** ReLU block: conv2d_5 **********/
	wire [RAM_W_C5_OUT-1:0]	addr_wr_conv2d_5_relu_out;
	wire [RAM_D_C5_OUT-1:0]	data_wr_conv2d_5_relu_out;
	wire 					wr_en_relu_conv2d_5_out;

	relu_blk #( .RAM_WIDTH_IN(RAM_W_C5_OUT),   .W_DATA_IN(RAM_D_C5_OUT),
				.RAM_WIDTH_OUT(RAM_W_C5_OUT),  .W_DATA_OUT(RAM_D_C5_OUT),	// .RAM_LENGHT_OUT(RAM_L_C5_OUT)
				.RAM_IN_PIPE(0) )
	conv2d_5_relu_blk
	(
		.clk(clk),

		/** RAM_IN assignments **/
		.addr_RAM_in(addr_wr_RAM_c5_out),
		.data_RAM_in(data_wr_RAM_c5_out),
		.wr_en_in(wr_en_RAM_c5_out),

		/** RAM_OUT assignments **/
		.addr_wr_RAM_out(addr_wr_conv2d_5_relu_out),
		.data_wr_RAM_out(data_wr_conv2d_5_relu_out),
		.wr_en(wr_en_relu_conv2d_5_out)

	);
	/******************************************/

	/**************** RAM 2-port conv2d_5 to max_pooling2d_1 *****************/
	wire [RAM_W_C5_OUT-1:0]	addr_rd_RAM_5;
	wire [RAM_D_C5_OUT-1:0]	data_rd_RAM_5;

	RAM_2_port_gen #( .LENGTH(RAM_W_C5_OUT), .LENGTH_EXP(RAM_L_C5_OUT), .WIDTH(RAM_D_C5_OUT) )
	RAM_2_port_5
	(
		.clock(clk),

		.address_a(addr_wr_conv2d_5_relu_out),
		.data_a(data_wr_conv2d_5_relu_out),
		.wren_a(wr_en_relu_conv2d_5_out),
		.q_a(),

		.address_b(addr_rd_RAM_5),
		.data_b(),
		.wren_b(),
		.q_b(data_rd_RAM_5)
	);
	/******************************************************************/

	/********** maxpooling 2D block: max_pooling2d_1; dims=6x16x12 to 3x8x12 **********/
	localparam H_P1_IN	= 6;
	localparam W_P1_IN	= 16;
	localparam C_P1_IN	= 12;

	localparam H_P1_IN_LOG = 3;
	localparam W_P1_IN_LOG = 4;
	localparam C_P1_IN_LOG = 4;

	localparam H_P1_OUT 	= 3;
	localparam W_P1_OUT 	= 8;
	localparam C_P1_OUT 	= 12;

	localparam H_P1_OUT_LOG = 2;
	localparam W_P1_OUT_LOG = 3; 

	localparam RAM_W_P1_IN = 11;
	localparam RAM_D_P1_IN = 16;

	localparam RAM_W_P1_OUT = 9;
	localparam RAM_L_P1_OUT = 288; // .RAM_LENGHT_OUT(RAM_L_P1_OUT)
	localparam RAM_D_P1_OUT = 16;


	wire init_p1_in_en = ready_c5;	// wire in
	wire init_p1_blk_rdy;					// wire out

	wire ready_p1;							// wire out
	wire blk_p1_rec_rdy;					// wire in

	wire [RAM_W_P1_IN-1:0]	addr_RAM_p1_in;
	wire [RAM_D_P1_IN-1:0] 	data_RAM_p1_in = data_rd_RAM_5;
	assign addr_rd_RAM_5 = addr_RAM_p1_in;
	// assign addr_rd_RAM_1 = addr_RAM_p1_in;

	wire [RAM_W_P1_OUT-1:0]	addr_wr_RAM_p1_out;
	wire [RAM_D_P1_IN-1:0]	data_wr_RAM_p1_out;
	wire 					wr_en_RAM_p1_out;

	maxpool2d_slim_blk #(	 .HEIGHT_IN(H_P1_IN),          .WIDTH_IN(W_P1_IN),     .CHANNELS_IN(C_P1_IN),
							 .H_IN_LOG(H_P1_IN_LOG),       .W_IN_LOG(W_P1_IN_LOG), .C_IN_LOG(C_P1_IN_LOG),
							 .RAM_WIDTH_IN(RAM_W_P1_IN),   .W_DATA_IN(RAM_D_P1_IN), 
							 .RAM_WIDTH_OUT(RAM_W_P1_OUT), .W_DATA_OUT(RAM_D_P1_IN), 
							 .RAM_IN_PIPE(2) )
	maxpool2d_1_slim_blk
	(
		.clk(clk),
		.rst(rst),

		/** input Hand Shaking **/ 
		.init_in_en(init_p1_in_en),
		.init_blk_rdy(init_p1_blk_rdy),

		/** .Hand Shaking **/ 
		.ready(ready_p1),
		.blk_rec_rdy(blk_p1_rec_rdy),

		/** RAM_in assignments **/
		.addr_RAM_in(addr_RAM_p1_in),
		.data_RAM_in(data_RAM_p1_in),

		/** RAM_out assignments **/
		.addr_wr_RAM_out(addr_wr_RAM_p1_out),
		.data_wr_RAM_out(data_wr_RAM_p1_out),
		.wr_en(wr_en_RAM_p1_out)

	);
	/****************************************************************************/

	/**************** RAM 2-port max_pooling2d_1 to conv2d_6 *****************/
	wire [RAM_W_P1_OUT-1:0]	addr_rd_RAM_6;
	wire [RAM_D_P1_IN-1:0]	data_rd_RAM_6;

	RAM_2_port_gen #( .LENGTH(RAM_W_P1_OUT), .LENGTH_EXP(RAM_L_P1_OUT), .WIDTH(RAM_D_P1_IN) )
	RAM_2_port_6
	(
		.clock(clk),

		.address_a(addr_wr_RAM_p1_out),
		.data_a(data_wr_RAM_p1_out),
		.wren_a(wr_en_RAM_p1_out),
		.q_a(),

		.address_b(addr_rd_RAM_6),
		.data_b(),
		.wren_b(),
		.q_b(data_rd_RAM_6)
	);
	/******************************************************************/

	/********** convolutional 2D block: conv2d_6; dims=3x8x12 to 2x6x14 **********/
	localparam H_C6_IN	= 3;
	localparam W_C6_IN	= 8;
	localparam C_C6_IN	= 12;

	localparam H_C6_FILTERS = 2; 
	localparam W_C6_FILTERS = 3;
	localparam N_C6_FILTERS = 14;

	localparam H_C6_IN_LOG = 2;
	localparam W_C6_IN_LOG = 3;
	localparam C_C6_IN_LOG = 4;

	localparam H_C6_F_LOG = 1;
	localparam W_C6_F_LOG = 2;
	localparam N_C6_F_LOG = 4;

	localparam H_C6_OUT_LOG = 1;
	localparam W_C6_OUT_LOG = 3; 

	localparam H_C6_OUT 	= 2;
	localparam W_C6_OUT 	= 6;
	localparam C_C6_OUT 	= 14;

	localparam RAM_W_C6_IN = 9;
	localparam RAM_D_C6_IN = 16;

	localparam ROM_D_C6 = 16;

	localparam RAM_W_C6_OUT = 8;
	localparam RAM_L_C6_OUT = 168; // .RAM_LENGHT_OUT(RAM_L_C6_OUT)
	localparam RAM_D_C6_OUT = 16;

	wire init_c6_in_en = ready_p1;	// wire in
	wire init_c6_blk_rdy;					// wire out

	wire ready_c6;							// wire out
	wire blk_c6_rec_rdy; 					// wire in
	// wire blk_c6_rec_rdy = #(READ_REC_WIRE); // wire in

	wire [RAM_W_C6_IN-1:0]	addr_RAM_c6_in;
	wire [RAM_D_C6_IN-1:0] 	data_RAM_c6_in = data_rd_RAM_6;
	assign addr_rd_RAM_6 = addr_RAM_c6_in;

	wire [N_C6_F_LOG-1:0] ch_number_c6_out;
	wire [RAM_W_C6_OUT-1:0]	addr_wr_RAM_c6_out;
	wire [RAM_D_C6_OUT-1:0]	data_wr_RAM_c6_out;
	wire 					wr_en_RAM_c6_out;

	conv2d_slim_blk #(	 .HEIGHT_IN(H_C6_IN),           .WIDTH_IN(W_C6_IN),           .CHANNELS_IN(C_C6_IN),
						 .HEIGHT_FILTERS(H_C6_FILTERS), .WIDTH_FILTERS(W_C6_FILTERS), .N_FILTERS(N_C6_FILTERS),
						 .H_IN_LOG(H_C6_IN_LOG),        .W_IN_LOG(W_C6_IN_LOG),       .N_IN_LOG(C_C6_IN_LOG),
						 .H_FILT_LOG(H_C6_F_LOG),       .W_FILT_LOG(W_C6_F_LOG),      .N_FILT_LOG(N_C6_F_LOG),
						 .H_OUT_LOG(H_C6_OUT_LOG),      .W_OUT_LOG(W_C6_OUT_LOG), 
						 .RAM_WIDTH_IN(RAM_W_C6_IN),    .W_DATA_IN(RAM_D_C6_IN),
						 .RAM_WIDTH_OUT(RAM_W_C6_OUT),  .W_DATA_OUT(RAM_D_C6_OUT),    .RAM_IN_PIPE(2), 
						 .GAIN_LOG(3),                  .BIAS_ADJ(240), 
						 .W_ROM_DATA(ROM_D_C6), .ROM_MIF("files_mifs/cnn/model_1/conv2d_6_2x3x12x14.mif") )
	conv2d_6_slim_blk
	(
		.clk(clk),
		.rst(rst),

		/** input Hand Shaking **/ 
		.init_in_en(init_c6_in_en),
		.init_blk_rdy(init_c6_blk_rdy),

		/** .Hand Shaking **/ 
		.ready(ready_c6),
		.blk_rec_rdy(blk_c6_rec_rdy),

		/** RAM_in assignments **/
		.addr_RAM_in(addr_RAM_c6_in),
		.data_RAM_in(data_RAM_c6_in),

		/** RAM_out assignments **/
		.ch_number_out(ch_number_c6_out),
		.addr_wr_RAM_out(addr_wr_RAM_c6_out),
		.data_wr_RAM_out(data_wr_RAM_c6_out),
		.wr_en(wr_en_RAM_c6_out)

	);
	/****************************************************************************/

	/********** ReLU block: conv2d_6 **********/
	wire [RAM_W_C6_OUT-1:0]	addr_wr_conv2d_6_relu_out;
	wire [RAM_D_C6_OUT-1:0]	data_wr_conv2d_6_relu_out;
	wire 					wr_en_relu_conv2d_6_out;

	relu_blk #( .RAM_WIDTH_IN(RAM_W_C6_OUT),   .W_DATA_IN(RAM_D_C6_OUT),
				.RAM_WIDTH_OUT(RAM_W_C6_OUT),  .W_DATA_OUT(RAM_D_C6_OUT),	// .RAM_LENGHT_OUT(RAM_L_C6_OUT)
				.RAM_IN_PIPE(0) )
	conv2d_6_relu_blk
	(
		.clk(clk),

		/** RAM_IN assignments **/
		.addr_RAM_in(addr_wr_RAM_c6_out),
		.data_RAM_in(data_wr_RAM_c6_out),
		.wr_en_in(wr_en_RAM_c6_out),

		/** RAM_OUT assignments **/
		.addr_wr_RAM_out(addr_wr_conv2d_6_relu_out),
		.data_wr_RAM_out(data_wr_conv2d_6_relu_out),
		.wr_en(wr_en_relu_conv2d_6_out)

	);
	/******************************************/

	/**************** RAM 2-port conv2d_6 to dense_1 *****************/
	wire [RAM_W_C6_OUT-1:0]	addr_rd_RAM_7;
	wire [RAM_D_C6_OUT-1:0]	data_rd_RAM_7;

	RAM_2_port_gen #( .LENGTH(RAM_W_C6_OUT), .LENGTH_EXP(RAM_L_C6_OUT), .WIDTH(RAM_D_C6_OUT) )
	RAM_2_port_7
	(
		.clock(clk),

		.address_a(addr_wr_conv2d_6_relu_out),
		.data_a(data_wr_conv2d_6_relu_out),
		.wren_a(wr_en_relu_conv2d_6_out),
		.q_a(),

		.address_b(addr_rd_RAM_7),
		.data_b(),
		.wren_b(),
		.q_b(data_rd_RAM_7)
	);
	/******************************************************************/

	/********** dense block: dense_1; dims=168x100 **********/
	localparam L_D1_IN	= 168;
	localparam L_D1_OUT	= 100;

	localparam RAM_W_D1_IN = 8;
	localparam RAM_D_D1_IN = 16;

	localparam ROM_W_D1 = 15;
	localparam ROM_D_D1 = 16;

	localparam RAM_W_D1_OUT = 7;
	localparam RAM_L_D1_OUT = 100; // .RAM_LENGHT_OUT(RAM_L_D1_OUT)
	localparam RAM_D_D1_OUT = 16;

	wire init_d1_in_en = ready_c6;	// wire in
	wire init_d1_blk_rdy;					// wire out

	wire ready_d1;							// wire out
	wire blk_d1_rec_rdy;					// wire in
	// wire blk_d1_rec_rdy = #(READ_REC_WIRE); // wire in

	wire [RAM_W_D1_IN-1:0]	addr_RAM_d1_in;
	wire [RAM_D_D1_IN-1:0] 	data_RAM_d1_in = data_rd_RAM_7;
	assign addr_rd_RAM_7 = addr_RAM_d1_in;
	//assign addr_rd_RAM_1 = addr_RAM_d1_in;

	wire [RAM_W_D1_OUT-1:0]	addr_wr_RAM_d1_out;
	wire [RAM_D_D1_OUT-1:0]	data_wr_RAM_d1_out;
	wire 					wr_en_RAM_d1_out;

	dense_slim_blk #(.LENGTH_IN(L_D1_IN),   .RAM_WIDTH_IN(RAM_W_D1_IN),   .W_DATA_IN(RAM_D_D1_IN),
					 .LENGTH_OUT(L_D1_OUT), .RAM_WIDTH_OUT(RAM_W_D1_OUT), .W_DATA_OUT(RAM_D_D1_OUT),
					 .ROM_WIDTH(ROM_W_D1),  .W_ROM_DATA(ROM_D_D1),        .RAM_IN_PIPE(2),
					 .GAIN_LOG(1),          .BIAS_ADJ(478), 
					 .ROM_MIF("files_mifs/cnn/model_1/dense_1_168x100.mif") )
	dense_1_slim_blk 
	(
		.clk(clk),
		.rst(rst),

		/** input Hand Shaking **/ 
		.init_in_en(init_d1_in_en),
		.init_blk_rdy(init_d1_blk_rdy),

		/** .Hand Shaking **/ 
		.ready(ready_d1),
		.blk_rec_rdy(blk_d1_rec_rdy),

		/** RAM_IN assignments **/
		.addr_RAM_in(addr_RAM_d1_in),
		.data_RAM_in(data_RAM_d1_in),

		/** RAM_out assignments **/
		.addr_wr_RAM_out(addr_wr_RAM_d1_out),
		.data_wr_RAM_out(data_wr_RAM_d1_out),
		.wr_en(wr_en_RAM_d1_out)

	);
	/*****************************************************/
	/********** ReLU block: dense_1 **********/
	wire [RAM_W_D1_OUT-1:0]	addr_wr_dense_1_relu_out;
	wire [RAM_D_D1_OUT-1:0]	data_wr_dense_1_relu_out;
	wire 					wr_en_relu_dense_1_out;

	relu_blk #( .RAM_WIDTH_IN(RAM_W_D1_OUT),   .W_DATA_IN(RAM_D_D1_OUT),
				.RAM_WIDTH_OUT(RAM_W_D1_OUT),  .W_DATA_OUT(RAM_D_D1_OUT),	// .RAM_LENGHT_OUT(RAM_L_D1_OUT)
				.RAM_IN_PIPE(0) )
	dense_1_relu_blk
	(
		.clk(clk),

		/** RAM_IN assignments **/
		.addr_RAM_in(addr_wr_RAM_d1_out),
		.data_RAM_in(data_wr_RAM_d1_out),
		.wr_en_in(wr_en_RAM_d1_out),

		/** RAM_OUT assignments **/
		.addr_wr_RAM_out(addr_wr_dense_1_relu_out),
		.data_wr_RAM_out(data_wr_dense_1_relu_out),
		.wr_en(wr_en_relu_dense_1_out)

	);
	/******************************************/

	/**************** RAM 2-port dense_1 to dense_2 *****************/
	wire [RAM_W_D1_OUT-1:0]	addr_rd_RAM_8;
	wire [RAM_D_D1_OUT-1:0]	data_rd_RAM_8;

	RAM_2_port_gen #( .LENGTH(RAM_W_D1_OUT), .LENGTH_EXP(RAM_L_D1_OUT), .WIDTH(RAM_D_D1_OUT) )
	RAM_2_port_8
	(
		.clock(clk),

		.address_a(addr_wr_dense_1_relu_out),
		.data_a(data_wr_dense_1_relu_out),
		.wren_a(wr_en_relu_dense_1_out),
		.q_a(),

		.address_b(addr_rd_RAM_8),
		.data_b(),
		.wren_b(),
		.q_b(data_rd_RAM_8)
	);
	/******************************************************************/

	/********** dense block: dense_2; dims=100x4 **********/
	localparam L_D2_IN	= 100;
	localparam L_D2_OUT	= 4;

	localparam RAM_W_D2_IN = 7;
	localparam RAM_D_D2_IN = 16;

	localparam ROM_W_D2 = 9;
	localparam ROM_D_D2 = 16;

	localparam RAM_W_D2_OUT = 2;
	localparam RAM_L_D2_OUT = 4; // .RAM_LENGHT_OUT(RAM_L_D2_OUT)
	localparam RAM_D_D2_OUT = 16;

	wire init_d2_in_en = ready_d1;	// wire in
	wire init_d2_blk_rdy;					// wire out

	wire ready_d2;							// wire out
	wire blk_d2_rec_rdy;					// wire in
	// wire blk_d2_rec_rdy = blk_rec_rdy; // wire in

	wire [RAM_W_D2_IN-1:0]	addr_RAM_d2_in;
	wire [RAM_D_D2_IN-1:0] 	data_RAM_d2_in = data_rd_RAM_8;
	assign addr_rd_RAM_8 = addr_RAM_d2_in;
	//assign addr_rd_RAM_1 = addr_RAM_d2_in;

	wire [RAM_W_D2_OUT-1:0]	addr_wr_RAM_d2_out;
	wire [RAM_D_D2_OUT-1:0]	data_wr_RAM_d2_out;
	wire 					wr_en_RAM_d2_out;

	dense_slim_blk #(.LENGTH_IN(L_D2_IN),   .RAM_WIDTH_IN(RAM_W_D2_IN),   .W_DATA_IN(RAM_D_D2_IN),
					 .LENGTH_OUT(L_D2_OUT), .RAM_WIDTH_OUT(RAM_W_D2_OUT), .W_DATA_OUT(RAM_D_D2_OUT),
					 .ROM_WIDTH(ROM_W_D2),  .W_ROM_DATA(ROM_D_D2),        .RAM_IN_PIPE(2),
					 .GAIN_LOG(0),          .BIAS_ADJ(347), 
					 .ROM_MIF("files_mifs/cnn/model_1/dense_2_100x4.mif") )
	dense_2_slim_blk 
	(
		.clk(clk),
		.rst(rst),

		/** input Hand Shaking **/ 
		.init_in_en(init_d2_in_en),
		.init_blk_rdy(init_d2_blk_rdy),

		/** .Hand Shaking **/ 
		.ready(ready_d2),
		.blk_rec_rdy(blk_d2_rec_rdy),

		/** RAM_IN assignments **/
		.addr_RAM_in(addr_RAM_d2_in),
		.data_RAM_in(data_RAM_d2_in),

		/** RAM_out assignments **/
		.addr_wr_RAM_out(addr_wr_RAM_d2_out),
		.data_wr_RAM_out(data_wr_RAM_d2_out),
		.wr_en(wr_en_RAM_d2_out)

	);
	/*****************************************************/

	/*************** outputs assignments ****************/
	
	/** all blk_rec_rdy assignments **/
	assign blk_c1_rec_rdy = ready_d2 && blk_d2_rec_rdy;
	assign blk_c2_rec_rdy = ready_d2 && blk_d2_rec_rdy;
	assign blk_c3_rec_rdy = ready_d2 && blk_d2_rec_rdy;
	assign blk_c4_rec_rdy = ready_d2 && blk_d2_rec_rdy;
	assign blk_c5_rec_rdy = ready_d2 && blk_d2_rec_rdy;
	assign blk_p1_rec_rdy = ready_d2 && blk_d2_rec_rdy;
	assign blk_c6_rec_rdy = ready_d2 && blk_d2_rec_rdy;
	assign blk_d1_rec_rdy = ready_d2 && blk_d2_rec_rdy;
	assign blk_d2_rec_rdy = ready_d2 && blk_rec_rdy;


	/**** hand shaking assignments ****/
	assign init_blk_rdy = init_c1_blk_rdy;
	assign ready = ready_d2;

	/**** assign RAM in ****/
	assign addr_RAM_in = addr_RAM_c1_in;

	/** RAM_OUT assignments **/
	assign addr_wr_RAM_out = addr_wr_RAM_d2_out;
	assign data_wr_RAM_out = data_wr_RAM_d2_out;
	assign wr_en = wr_en_RAM_d2_out;

	/****************************************************/

endmodule 
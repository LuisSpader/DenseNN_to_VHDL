LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

  ENTITY  camada0_ReLU_500neuron_8bits_784n_signed IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 784;
    TOTAL_BITS : NATURAL := 6272
  );
  PORT (
      clk, rst, update_weights: IN STD_LOGIC;
      IO_in: IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in, c0_n5_W_in, c0_n6_W_in, c0_n7_W_in, c0_n8_W_in, c0_n9_W_in, c0_n10_W_in, c0_n11_W_in, c0_n12_W_in, c0_n13_W_in, c0_n14_W_in, c0_n15_W_in, c0_n16_W_in, c0_n17_W_in, c0_n18_W_in, c0_n19_W_in, c0_n20_W_in, c0_n21_W_in, c0_n22_W_in, c0_n23_W_in, c0_n24_W_in, c0_n25_W_in, c0_n26_W_in, c0_n27_W_in, c0_n28_W_in, c0_n29_W_in, c0_n30_W_in, c0_n31_W_in, c0_n32_W_in, c0_n33_W_in, c0_n34_W_in, c0_n35_W_in, c0_n36_W_in, c0_n37_W_in, c0_n38_W_in, c0_n39_W_in, c0_n40_W_in, c0_n41_W_in, c0_n42_W_in, c0_n43_W_in, c0_n44_W_in, c0_n45_W_in, c0_n46_W_in, c0_n47_W_in, c0_n48_W_in, c0_n49_W_in, c0_n50_W_in, c0_n51_W_in, c0_n52_W_in, c0_n53_W_in, c0_n54_W_in, c0_n55_W_in, c0_n56_W_in, c0_n57_W_in, c0_n58_W_in, c0_n59_W_in, c0_n60_W_in, c0_n61_W_in, c0_n62_W_in, c0_n63_W_in, c0_n64_W_in, c0_n65_W_in, c0_n66_W_in, c0_n67_W_in, c0_n68_W_in, c0_n69_W_in, c0_n70_W_in, c0_n71_W_in, c0_n72_W_in, c0_n73_W_in, c0_n74_W_in, c0_n75_W_in, c0_n76_W_in, c0_n77_W_in, c0_n78_W_in, c0_n79_W_in, c0_n80_W_in, c0_n81_W_in, c0_n82_W_in, c0_n83_W_in, c0_n84_W_in, c0_n85_W_in, c0_n86_W_in, c0_n87_W_in, c0_n88_W_in, c0_n89_W_in, c0_n90_W_in, c0_n91_W_in, c0_n92_W_in, c0_n93_W_in, c0_n94_W_in, c0_n95_W_in, c0_n96_W_in, c0_n97_W_in, c0_n98_W_in, c0_n99_W_in, c0_n100_W_in, c0_n101_W_in, c0_n102_W_in, c0_n103_W_in, c0_n104_W_in, c0_n105_W_in, c0_n106_W_in, c0_n107_W_in, c0_n108_W_in, c0_n109_W_in, c0_n110_W_in, c0_n111_W_in, c0_n112_W_in, c0_n113_W_in, c0_n114_W_in, c0_n115_W_in, c0_n116_W_in, c0_n117_W_in, c0_n118_W_in, c0_n119_W_in, c0_n120_W_in, c0_n121_W_in, c0_n122_W_in, c0_n123_W_in, c0_n124_W_in, c0_n125_W_in, c0_n126_W_in, c0_n127_W_in, c0_n128_W_in, c0_n129_W_in, c0_n130_W_in, c0_n131_W_in, c0_n132_W_in, c0_n133_W_in, c0_n134_W_in, c0_n135_W_in, c0_n136_W_in, c0_n137_W_in, c0_n138_W_in, c0_n139_W_in, c0_n140_W_in, c0_n141_W_in, c0_n142_W_in, c0_n143_W_in, c0_n144_W_in, c0_n145_W_in, c0_n146_W_in, c0_n147_W_in, c0_n148_W_in, c0_n149_W_in, c0_n150_W_in, c0_n151_W_in, c0_n152_W_in, c0_n153_W_in, c0_n154_W_in, c0_n155_W_in, c0_n156_W_in, c0_n157_W_in, c0_n158_W_in, c0_n159_W_in, c0_n160_W_in, c0_n161_W_in, c0_n162_W_in, c0_n163_W_in, c0_n164_W_in, c0_n165_W_in, c0_n166_W_in, c0_n167_W_in, c0_n168_W_in, c0_n169_W_in, c0_n170_W_in, c0_n171_W_in, c0_n172_W_in, c0_n173_W_in, c0_n174_W_in, c0_n175_W_in, c0_n176_W_in, c0_n177_W_in, c0_n178_W_in, c0_n179_W_in, c0_n180_W_in, c0_n181_W_in, c0_n182_W_in, c0_n183_W_in, c0_n184_W_in, c0_n185_W_in, c0_n186_W_in, c0_n187_W_in, c0_n188_W_in, c0_n189_W_in, c0_n190_W_in, c0_n191_W_in, c0_n192_W_in, c0_n193_W_in, c0_n194_W_in, c0_n195_W_in, c0_n196_W_in, c0_n197_W_in, c0_n198_W_in, c0_n199_W_in, c0_n200_W_in, c0_n201_W_in, c0_n202_W_in, c0_n203_W_in, c0_n204_W_in, c0_n205_W_in, c0_n206_W_in, c0_n207_W_in, c0_n208_W_in, c0_n209_W_in, c0_n210_W_in, c0_n211_W_in, c0_n212_W_in, c0_n213_W_in, c0_n214_W_in, c0_n215_W_in, c0_n216_W_in, c0_n217_W_in, c0_n218_W_in, c0_n219_W_in, c0_n220_W_in, c0_n221_W_in, c0_n222_W_in, c0_n223_W_in, c0_n224_W_in, c0_n225_W_in, c0_n226_W_in, c0_n227_W_in, c0_n228_W_in, c0_n229_W_in, c0_n230_W_in, c0_n231_W_in, c0_n232_W_in, c0_n233_W_in, c0_n234_W_in, c0_n235_W_in, c0_n236_W_in, c0_n237_W_in, c0_n238_W_in, c0_n239_W_in, c0_n240_W_in, c0_n241_W_in, c0_n242_W_in, c0_n243_W_in, c0_n244_W_in, c0_n245_W_in, c0_n246_W_in, c0_n247_W_in, c0_n248_W_in, c0_n249_W_in, c0_n250_W_in, c0_n251_W_in, c0_n252_W_in, c0_n253_W_in, c0_n254_W_in, c0_n255_W_in, c0_n256_W_in, c0_n257_W_in, c0_n258_W_in, c0_n259_W_in, c0_n260_W_in, c0_n261_W_in, c0_n262_W_in, c0_n263_W_in, c0_n264_W_in, c0_n265_W_in, c0_n266_W_in, c0_n267_W_in, c0_n268_W_in, c0_n269_W_in, c0_n270_W_in, c0_n271_W_in, c0_n272_W_in, c0_n273_W_in, c0_n274_W_in, c0_n275_W_in, c0_n276_W_in, c0_n277_W_in, c0_n278_W_in, c0_n279_W_in, c0_n280_W_in, c0_n281_W_in, c0_n282_W_in, c0_n283_W_in, c0_n284_W_in, c0_n285_W_in, c0_n286_W_in, c0_n287_W_in, c0_n288_W_in, c0_n289_W_in, c0_n290_W_in, c0_n291_W_in, c0_n292_W_in, c0_n293_W_in, c0_n294_W_in, c0_n295_W_in, c0_n296_W_in, c0_n297_W_in, c0_n298_W_in, c0_n299_W_in, c0_n300_W_in, c0_n301_W_in, c0_n302_W_in, c0_n303_W_in, c0_n304_W_in, c0_n305_W_in, c0_n306_W_in, c0_n307_W_in, c0_n308_W_in, c0_n309_W_in, c0_n310_W_in, c0_n311_W_in, c0_n312_W_in, c0_n313_W_in, c0_n314_W_in, c0_n315_W_in, c0_n316_W_in, c0_n317_W_in, c0_n318_W_in, c0_n319_W_in, c0_n320_W_in, c0_n321_W_in, c0_n322_W_in, c0_n323_W_in, c0_n324_W_in, c0_n325_W_in, c0_n326_W_in, c0_n327_W_in, c0_n328_W_in, c0_n329_W_in, c0_n330_W_in, c0_n331_W_in, c0_n332_W_in, c0_n333_W_in, c0_n334_W_in, c0_n335_W_in, c0_n336_W_in, c0_n337_W_in, c0_n338_W_in, c0_n339_W_in, c0_n340_W_in, c0_n341_W_in, c0_n342_W_in, c0_n343_W_in, c0_n344_W_in, c0_n345_W_in, c0_n346_W_in, c0_n347_W_in, c0_n348_W_in, c0_n349_W_in, c0_n350_W_in, c0_n351_W_in, c0_n352_W_in, c0_n353_W_in, c0_n354_W_in, c0_n355_W_in, c0_n356_W_in, c0_n357_W_in, c0_n358_W_in, c0_n359_W_in, c0_n360_W_in, c0_n361_W_in, c0_n362_W_in, c0_n363_W_in, c0_n364_W_in, c0_n365_W_in, c0_n366_W_in, c0_n367_W_in, c0_n368_W_in, c0_n369_W_in, c0_n370_W_in, c0_n371_W_in, c0_n372_W_in, c0_n373_W_in, c0_n374_W_in, c0_n375_W_in, c0_n376_W_in, c0_n377_W_in, c0_n378_W_in, c0_n379_W_in, c0_n380_W_in, c0_n381_W_in, c0_n382_W_in, c0_n383_W_in, c0_n384_W_in, c0_n385_W_in, c0_n386_W_in, c0_n387_W_in, c0_n388_W_in, c0_n389_W_in, c0_n390_W_in, c0_n391_W_in, c0_n392_W_in, c0_n393_W_in, c0_n394_W_in, c0_n395_W_in, c0_n396_W_in, c0_n397_W_in, c0_n398_W_in, c0_n399_W_in, c0_n400_W_in, c0_n401_W_in, c0_n402_W_in, c0_n403_W_in, c0_n404_W_in, c0_n405_W_in, c0_n406_W_in, c0_n407_W_in, c0_n408_W_in, c0_n409_W_in, c0_n410_W_in, c0_n411_W_in, c0_n412_W_in, c0_n413_W_in, c0_n414_W_in, c0_n415_W_in, c0_n416_W_in, c0_n417_W_in, c0_n418_W_in, c0_n419_W_in, c0_n420_W_in, c0_n421_W_in, c0_n422_W_in, c0_n423_W_in, c0_n424_W_in, c0_n425_W_in, c0_n426_W_in, c0_n427_W_in, c0_n428_W_in, c0_n429_W_in, c0_n430_W_in, c0_n431_W_in, c0_n432_W_in, c0_n433_W_in, c0_n434_W_in, c0_n435_W_in, c0_n436_W_in, c0_n437_W_in, c0_n438_W_in, c0_n439_W_in, c0_n440_W_in, c0_n441_W_in, c0_n442_W_in, c0_n443_W_in, c0_n444_W_in, c0_n445_W_in, c0_n446_W_in, c0_n447_W_in, c0_n448_W_in, c0_n449_W_in, c0_n450_W_in, c0_n451_W_in, c0_n452_W_in, c0_n453_W_in, c0_n454_W_in, c0_n455_W_in, c0_n456_W_in, c0_n457_W_in, c0_n458_W_in, c0_n459_W_in, c0_n460_W_in, c0_n461_W_in, c0_n462_W_in, c0_n463_W_in, c0_n464_W_in, c0_n465_W_in, c0_n466_W_in, c0_n467_W_in, c0_n468_W_in, c0_n469_W_in, c0_n470_W_in, c0_n471_W_in, c0_n472_W_in, c0_n473_W_in, c0_n474_W_in, c0_n475_W_in, c0_n476_W_in, c0_n477_W_in, c0_n478_W_in, c0_n479_W_in, c0_n480_W_in, c0_n481_W_in, c0_n482_W_in, c0_n483_W_in, c0_n484_W_in, c0_n485_W_in, c0_n486_W_in, c0_n487_W_in, c0_n488_W_in, c0_n489_W_in, c0_n490_W_in, c0_n491_W_in, c0_n492_W_in, c0_n493_W_in, c0_n494_W_in, c0_n495_W_in, c0_n496_W_in, c0_n497_W_in, c0_n498_W_in, c0_n499_W_in: IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c0_n0_IO_out, c0_n1_IO_out, c0_n2_IO_out, c0_n3_IO_out, c0_n4_IO_out, c0_n5_IO_out, c0_n6_IO_out, c0_n7_IO_out, c0_n8_IO_out, c0_n9_IO_out, c0_n10_IO_out, c0_n11_IO_out, c0_n12_IO_out, c0_n13_IO_out, c0_n14_IO_out, c0_n15_IO_out, c0_n16_IO_out, c0_n17_IO_out, c0_n18_IO_out, c0_n19_IO_out, c0_n20_IO_out, c0_n21_IO_out, c0_n22_IO_out, c0_n23_IO_out, c0_n24_IO_out, c0_n25_IO_out, c0_n26_IO_out, c0_n27_IO_out, c0_n28_IO_out, c0_n29_IO_out, c0_n30_IO_out, c0_n31_IO_out, c0_n32_IO_out, c0_n33_IO_out, c0_n34_IO_out, c0_n35_IO_out, c0_n36_IO_out, c0_n37_IO_out, c0_n38_IO_out, c0_n39_IO_out, c0_n40_IO_out, c0_n41_IO_out, c0_n42_IO_out, c0_n43_IO_out, c0_n44_IO_out, c0_n45_IO_out, c0_n46_IO_out, c0_n47_IO_out, c0_n48_IO_out, c0_n49_IO_out, c0_n50_IO_out, c0_n51_IO_out, c0_n52_IO_out, c0_n53_IO_out, c0_n54_IO_out, c0_n55_IO_out, c0_n56_IO_out, c0_n57_IO_out, c0_n58_IO_out, c0_n59_IO_out, c0_n60_IO_out, c0_n61_IO_out, c0_n62_IO_out, c0_n63_IO_out, c0_n64_IO_out, c0_n65_IO_out, c0_n66_IO_out, c0_n67_IO_out, c0_n68_IO_out, c0_n69_IO_out, c0_n70_IO_out, c0_n71_IO_out, c0_n72_IO_out, c0_n73_IO_out, c0_n74_IO_out, c0_n75_IO_out, c0_n76_IO_out, c0_n77_IO_out, c0_n78_IO_out, c0_n79_IO_out, c0_n80_IO_out, c0_n81_IO_out, c0_n82_IO_out, c0_n83_IO_out, c0_n84_IO_out, c0_n85_IO_out, c0_n86_IO_out, c0_n87_IO_out, c0_n88_IO_out, c0_n89_IO_out, c0_n90_IO_out, c0_n91_IO_out, c0_n92_IO_out, c0_n93_IO_out, c0_n94_IO_out, c0_n95_IO_out, c0_n96_IO_out, c0_n97_IO_out, c0_n98_IO_out, c0_n99_IO_out, c0_n100_IO_out, c0_n101_IO_out, c0_n102_IO_out, c0_n103_IO_out, c0_n104_IO_out, c0_n105_IO_out, c0_n106_IO_out, c0_n107_IO_out, c0_n108_IO_out, c0_n109_IO_out, c0_n110_IO_out, c0_n111_IO_out, c0_n112_IO_out, c0_n113_IO_out, c0_n114_IO_out, c0_n115_IO_out, c0_n116_IO_out, c0_n117_IO_out, c0_n118_IO_out, c0_n119_IO_out, c0_n120_IO_out, c0_n121_IO_out, c0_n122_IO_out, c0_n123_IO_out, c0_n124_IO_out, c0_n125_IO_out, c0_n126_IO_out, c0_n127_IO_out, c0_n128_IO_out, c0_n129_IO_out, c0_n130_IO_out, c0_n131_IO_out, c0_n132_IO_out, c0_n133_IO_out, c0_n134_IO_out, c0_n135_IO_out, c0_n136_IO_out, c0_n137_IO_out, c0_n138_IO_out, c0_n139_IO_out, c0_n140_IO_out, c0_n141_IO_out, c0_n142_IO_out, c0_n143_IO_out, c0_n144_IO_out, c0_n145_IO_out, c0_n146_IO_out, c0_n147_IO_out, c0_n148_IO_out, c0_n149_IO_out, c0_n150_IO_out, c0_n151_IO_out, c0_n152_IO_out, c0_n153_IO_out, c0_n154_IO_out, c0_n155_IO_out, c0_n156_IO_out, c0_n157_IO_out, c0_n158_IO_out, c0_n159_IO_out, c0_n160_IO_out, c0_n161_IO_out, c0_n162_IO_out, c0_n163_IO_out, c0_n164_IO_out, c0_n165_IO_out, c0_n166_IO_out, c0_n167_IO_out, c0_n168_IO_out, c0_n169_IO_out, c0_n170_IO_out, c0_n171_IO_out, c0_n172_IO_out, c0_n173_IO_out, c0_n174_IO_out, c0_n175_IO_out, c0_n176_IO_out, c0_n177_IO_out, c0_n178_IO_out, c0_n179_IO_out, c0_n180_IO_out, c0_n181_IO_out, c0_n182_IO_out, c0_n183_IO_out, c0_n184_IO_out, c0_n185_IO_out, c0_n186_IO_out, c0_n187_IO_out, c0_n188_IO_out, c0_n189_IO_out, c0_n190_IO_out, c0_n191_IO_out, c0_n192_IO_out, c0_n193_IO_out, c0_n194_IO_out, c0_n195_IO_out, c0_n196_IO_out, c0_n197_IO_out, c0_n198_IO_out, c0_n199_IO_out, c0_n200_IO_out, c0_n201_IO_out, c0_n202_IO_out, c0_n203_IO_out, c0_n204_IO_out, c0_n205_IO_out, c0_n206_IO_out, c0_n207_IO_out, c0_n208_IO_out, c0_n209_IO_out, c0_n210_IO_out, c0_n211_IO_out, c0_n212_IO_out, c0_n213_IO_out, c0_n214_IO_out, c0_n215_IO_out, c0_n216_IO_out, c0_n217_IO_out, c0_n218_IO_out, c0_n219_IO_out, c0_n220_IO_out, c0_n221_IO_out, c0_n222_IO_out, c0_n223_IO_out, c0_n224_IO_out, c0_n225_IO_out, c0_n226_IO_out, c0_n227_IO_out, c0_n228_IO_out, c0_n229_IO_out, c0_n230_IO_out, c0_n231_IO_out, c0_n232_IO_out, c0_n233_IO_out, c0_n234_IO_out, c0_n235_IO_out, c0_n236_IO_out, c0_n237_IO_out, c0_n238_IO_out, c0_n239_IO_out, c0_n240_IO_out, c0_n241_IO_out, c0_n242_IO_out, c0_n243_IO_out, c0_n244_IO_out, c0_n245_IO_out, c0_n246_IO_out, c0_n247_IO_out, c0_n248_IO_out, c0_n249_IO_out, c0_n250_IO_out, c0_n251_IO_out, c0_n252_IO_out, c0_n253_IO_out, c0_n254_IO_out, c0_n255_IO_out, c0_n256_IO_out, c0_n257_IO_out, c0_n258_IO_out, c0_n259_IO_out, c0_n260_IO_out, c0_n261_IO_out, c0_n262_IO_out, c0_n263_IO_out, c0_n264_IO_out, c0_n265_IO_out, c0_n266_IO_out, c0_n267_IO_out, c0_n268_IO_out, c0_n269_IO_out, c0_n270_IO_out, c0_n271_IO_out, c0_n272_IO_out, c0_n273_IO_out, c0_n274_IO_out, c0_n275_IO_out, c0_n276_IO_out, c0_n277_IO_out, c0_n278_IO_out, c0_n279_IO_out, c0_n280_IO_out, c0_n281_IO_out, c0_n282_IO_out, c0_n283_IO_out, c0_n284_IO_out, c0_n285_IO_out, c0_n286_IO_out, c0_n287_IO_out, c0_n288_IO_out, c0_n289_IO_out, c0_n290_IO_out, c0_n291_IO_out, c0_n292_IO_out, c0_n293_IO_out, c0_n294_IO_out, c0_n295_IO_out, c0_n296_IO_out, c0_n297_IO_out, c0_n298_IO_out, c0_n299_IO_out, c0_n300_IO_out, c0_n301_IO_out, c0_n302_IO_out, c0_n303_IO_out, c0_n304_IO_out, c0_n305_IO_out, c0_n306_IO_out, c0_n307_IO_out, c0_n308_IO_out, c0_n309_IO_out, c0_n310_IO_out, c0_n311_IO_out, c0_n312_IO_out, c0_n313_IO_out, c0_n314_IO_out, c0_n315_IO_out, c0_n316_IO_out, c0_n317_IO_out, c0_n318_IO_out, c0_n319_IO_out, c0_n320_IO_out, c0_n321_IO_out, c0_n322_IO_out, c0_n323_IO_out, c0_n324_IO_out, c0_n325_IO_out, c0_n326_IO_out, c0_n327_IO_out, c0_n328_IO_out, c0_n329_IO_out, c0_n330_IO_out, c0_n331_IO_out, c0_n332_IO_out, c0_n333_IO_out, c0_n334_IO_out, c0_n335_IO_out, c0_n336_IO_out, c0_n337_IO_out, c0_n338_IO_out, c0_n339_IO_out, c0_n340_IO_out, c0_n341_IO_out, c0_n342_IO_out, c0_n343_IO_out, c0_n344_IO_out, c0_n345_IO_out, c0_n346_IO_out, c0_n347_IO_out, c0_n348_IO_out, c0_n349_IO_out, c0_n350_IO_out, c0_n351_IO_out, c0_n352_IO_out, c0_n353_IO_out, c0_n354_IO_out, c0_n355_IO_out, c0_n356_IO_out, c0_n357_IO_out, c0_n358_IO_out, c0_n359_IO_out, c0_n360_IO_out, c0_n361_IO_out, c0_n362_IO_out, c0_n363_IO_out, c0_n364_IO_out, c0_n365_IO_out, c0_n366_IO_out, c0_n367_IO_out, c0_n368_IO_out, c0_n369_IO_out, c0_n370_IO_out, c0_n371_IO_out, c0_n372_IO_out, c0_n373_IO_out, c0_n374_IO_out, c0_n375_IO_out, c0_n376_IO_out, c0_n377_IO_out, c0_n378_IO_out, c0_n379_IO_out, c0_n380_IO_out, c0_n381_IO_out, c0_n382_IO_out, c0_n383_IO_out, c0_n384_IO_out, c0_n385_IO_out, c0_n386_IO_out, c0_n387_IO_out, c0_n388_IO_out, c0_n389_IO_out, c0_n390_IO_out, c0_n391_IO_out, c0_n392_IO_out, c0_n393_IO_out, c0_n394_IO_out, c0_n395_IO_out, c0_n396_IO_out, c0_n397_IO_out, c0_n398_IO_out, c0_n399_IO_out, c0_n400_IO_out, c0_n401_IO_out, c0_n402_IO_out, c0_n403_IO_out, c0_n404_IO_out, c0_n405_IO_out, c0_n406_IO_out, c0_n407_IO_out, c0_n408_IO_out, c0_n409_IO_out, c0_n410_IO_out, c0_n411_IO_out, c0_n412_IO_out, c0_n413_IO_out, c0_n414_IO_out, c0_n415_IO_out, c0_n416_IO_out, c0_n417_IO_out, c0_n418_IO_out, c0_n419_IO_out, c0_n420_IO_out, c0_n421_IO_out, c0_n422_IO_out, c0_n423_IO_out, c0_n424_IO_out, c0_n425_IO_out, c0_n426_IO_out, c0_n427_IO_out, c0_n428_IO_out, c0_n429_IO_out, c0_n430_IO_out, c0_n431_IO_out, c0_n432_IO_out, c0_n433_IO_out, c0_n434_IO_out, c0_n435_IO_out, c0_n436_IO_out, c0_n437_IO_out, c0_n438_IO_out, c0_n439_IO_out, c0_n440_IO_out, c0_n441_IO_out, c0_n442_IO_out, c0_n443_IO_out, c0_n444_IO_out, c0_n445_IO_out, c0_n446_IO_out, c0_n447_IO_out, c0_n448_IO_out, c0_n449_IO_out, c0_n450_IO_out, c0_n451_IO_out, c0_n452_IO_out, c0_n453_IO_out, c0_n454_IO_out, c0_n455_IO_out, c0_n456_IO_out, c0_n457_IO_out, c0_n458_IO_out, c0_n459_IO_out, c0_n460_IO_out, c0_n461_IO_out, c0_n462_IO_out, c0_n463_IO_out, c0_n464_IO_out, c0_n465_IO_out, c0_n466_IO_out, c0_n467_IO_out, c0_n468_IO_out, c0_n469_IO_out, c0_n470_IO_out, c0_n471_IO_out, c0_n472_IO_out, c0_n473_IO_out, c0_n474_IO_out, c0_n475_IO_out, c0_n476_IO_out, c0_n477_IO_out, c0_n478_IO_out, c0_n479_IO_out, c0_n480_IO_out, c0_n481_IO_out, c0_n482_IO_out, c0_n483_IO_out, c0_n484_IO_out, c0_n485_IO_out, c0_n486_IO_out, c0_n487_IO_out, c0_n488_IO_out, c0_n489_IO_out, c0_n490_IO_out, c0_n491_IO_out, c0_n492_IO_out, c0_n493_IO_out, c0_n494_IO_out, c0_n495_IO_out, c0_n496_IO_out, c0_n497_IO_out, c0_n498_IO_out, c0_n499_IO_out: OUT signed(7 DOWNTO 0);
      c0_n0_W_out, c0_n1_W_out, c0_n2_W_out, c0_n3_W_out, c0_n4_W_out, c0_n5_W_out, c0_n6_W_out, c0_n7_W_out, c0_n8_W_out, c0_n9_W_out, c0_n10_W_out, c0_n11_W_out, c0_n12_W_out, c0_n13_W_out, c0_n14_W_out, c0_n15_W_out, c0_n16_W_out, c0_n17_W_out, c0_n18_W_out, c0_n19_W_out, c0_n20_W_out, c0_n21_W_out, c0_n22_W_out, c0_n23_W_out, c0_n24_W_out, c0_n25_W_out, c0_n26_W_out, c0_n27_W_out, c0_n28_W_out, c0_n29_W_out, c0_n30_W_out, c0_n31_W_out, c0_n32_W_out, c0_n33_W_out, c0_n34_W_out, c0_n35_W_out, c0_n36_W_out, c0_n37_W_out, c0_n38_W_out, c0_n39_W_out, c0_n40_W_out, c0_n41_W_out, c0_n42_W_out, c0_n43_W_out, c0_n44_W_out, c0_n45_W_out, c0_n46_W_out, c0_n47_W_out, c0_n48_W_out, c0_n49_W_out, c0_n50_W_out, c0_n51_W_out, c0_n52_W_out, c0_n53_W_out, c0_n54_W_out, c0_n55_W_out, c0_n56_W_out, c0_n57_W_out, c0_n58_W_out, c0_n59_W_out, c0_n60_W_out, c0_n61_W_out, c0_n62_W_out, c0_n63_W_out, c0_n64_W_out, c0_n65_W_out, c0_n66_W_out, c0_n67_W_out, c0_n68_W_out, c0_n69_W_out, c0_n70_W_out, c0_n71_W_out, c0_n72_W_out, c0_n73_W_out, c0_n74_W_out, c0_n75_W_out, c0_n76_W_out, c0_n77_W_out, c0_n78_W_out, c0_n79_W_out, c0_n80_W_out, c0_n81_W_out, c0_n82_W_out, c0_n83_W_out, c0_n84_W_out, c0_n85_W_out, c0_n86_W_out, c0_n87_W_out, c0_n88_W_out, c0_n89_W_out, c0_n90_W_out, c0_n91_W_out, c0_n92_W_out, c0_n93_W_out, c0_n94_W_out, c0_n95_W_out, c0_n96_W_out, c0_n97_W_out, c0_n98_W_out, c0_n99_W_out, c0_n100_W_out, c0_n101_W_out, c0_n102_W_out, c0_n103_W_out, c0_n104_W_out, c0_n105_W_out, c0_n106_W_out, c0_n107_W_out, c0_n108_W_out, c0_n109_W_out, c0_n110_W_out, c0_n111_W_out, c0_n112_W_out, c0_n113_W_out, c0_n114_W_out, c0_n115_W_out, c0_n116_W_out, c0_n117_W_out, c0_n118_W_out, c0_n119_W_out, c0_n120_W_out, c0_n121_W_out, c0_n122_W_out, c0_n123_W_out, c0_n124_W_out, c0_n125_W_out, c0_n126_W_out, c0_n127_W_out, c0_n128_W_out, c0_n129_W_out, c0_n130_W_out, c0_n131_W_out, c0_n132_W_out, c0_n133_W_out, c0_n134_W_out, c0_n135_W_out, c0_n136_W_out, c0_n137_W_out, c0_n138_W_out, c0_n139_W_out, c0_n140_W_out, c0_n141_W_out, c0_n142_W_out, c0_n143_W_out, c0_n144_W_out, c0_n145_W_out, c0_n146_W_out, c0_n147_W_out, c0_n148_W_out, c0_n149_W_out, c0_n150_W_out, c0_n151_W_out, c0_n152_W_out, c0_n153_W_out, c0_n154_W_out, c0_n155_W_out, c0_n156_W_out, c0_n157_W_out, c0_n158_W_out, c0_n159_W_out, c0_n160_W_out, c0_n161_W_out, c0_n162_W_out, c0_n163_W_out, c0_n164_W_out, c0_n165_W_out, c0_n166_W_out, c0_n167_W_out, c0_n168_W_out, c0_n169_W_out, c0_n170_W_out, c0_n171_W_out, c0_n172_W_out, c0_n173_W_out, c0_n174_W_out, c0_n175_W_out, c0_n176_W_out, c0_n177_W_out, c0_n178_W_out, c0_n179_W_out, c0_n180_W_out, c0_n181_W_out, c0_n182_W_out, c0_n183_W_out, c0_n184_W_out, c0_n185_W_out, c0_n186_W_out, c0_n187_W_out, c0_n188_W_out, c0_n189_W_out, c0_n190_W_out, c0_n191_W_out, c0_n192_W_out, c0_n193_W_out, c0_n194_W_out, c0_n195_W_out, c0_n196_W_out, c0_n197_W_out, c0_n198_W_out, c0_n199_W_out, c0_n200_W_out, c0_n201_W_out, c0_n202_W_out, c0_n203_W_out, c0_n204_W_out, c0_n205_W_out, c0_n206_W_out, c0_n207_W_out, c0_n208_W_out, c0_n209_W_out, c0_n210_W_out, c0_n211_W_out, c0_n212_W_out, c0_n213_W_out, c0_n214_W_out, c0_n215_W_out, c0_n216_W_out, c0_n217_W_out, c0_n218_W_out, c0_n219_W_out, c0_n220_W_out, c0_n221_W_out, c0_n222_W_out, c0_n223_W_out, c0_n224_W_out, c0_n225_W_out, c0_n226_W_out, c0_n227_W_out, c0_n228_W_out, c0_n229_W_out, c0_n230_W_out, c0_n231_W_out, c0_n232_W_out, c0_n233_W_out, c0_n234_W_out, c0_n235_W_out, c0_n236_W_out, c0_n237_W_out, c0_n238_W_out, c0_n239_W_out, c0_n240_W_out, c0_n241_W_out, c0_n242_W_out, c0_n243_W_out, c0_n244_W_out, c0_n245_W_out, c0_n246_W_out, c0_n247_W_out, c0_n248_W_out, c0_n249_W_out, c0_n250_W_out, c0_n251_W_out, c0_n252_W_out, c0_n253_W_out, c0_n254_W_out, c0_n255_W_out, c0_n256_W_out, c0_n257_W_out, c0_n258_W_out, c0_n259_W_out, c0_n260_W_out, c0_n261_W_out, c0_n262_W_out, c0_n263_W_out, c0_n264_W_out, c0_n265_W_out, c0_n266_W_out, c0_n267_W_out, c0_n268_W_out, c0_n269_W_out, c0_n270_W_out, c0_n271_W_out, c0_n272_W_out, c0_n273_W_out, c0_n274_W_out, c0_n275_W_out, c0_n276_W_out, c0_n277_W_out, c0_n278_W_out, c0_n279_W_out, c0_n280_W_out, c0_n281_W_out, c0_n282_W_out, c0_n283_W_out, c0_n284_W_out, c0_n285_W_out, c0_n286_W_out, c0_n287_W_out, c0_n288_W_out, c0_n289_W_out, c0_n290_W_out, c0_n291_W_out, c0_n292_W_out, c0_n293_W_out, c0_n294_W_out, c0_n295_W_out, c0_n296_W_out, c0_n297_W_out, c0_n298_W_out, c0_n299_W_out, c0_n300_W_out, c0_n301_W_out, c0_n302_W_out, c0_n303_W_out, c0_n304_W_out, c0_n305_W_out, c0_n306_W_out, c0_n307_W_out, c0_n308_W_out, c0_n309_W_out, c0_n310_W_out, c0_n311_W_out, c0_n312_W_out, c0_n313_W_out, c0_n314_W_out, c0_n315_W_out, c0_n316_W_out, c0_n317_W_out, c0_n318_W_out, c0_n319_W_out, c0_n320_W_out, c0_n321_W_out, c0_n322_W_out, c0_n323_W_out, c0_n324_W_out, c0_n325_W_out, c0_n326_W_out, c0_n327_W_out, c0_n328_W_out, c0_n329_W_out, c0_n330_W_out, c0_n331_W_out, c0_n332_W_out, c0_n333_W_out, c0_n334_W_out, c0_n335_W_out, c0_n336_W_out, c0_n337_W_out, c0_n338_W_out, c0_n339_W_out, c0_n340_W_out, c0_n341_W_out, c0_n342_W_out, c0_n343_W_out, c0_n344_W_out, c0_n345_W_out, c0_n346_W_out, c0_n347_W_out, c0_n348_W_out, c0_n349_W_out, c0_n350_W_out, c0_n351_W_out, c0_n352_W_out, c0_n353_W_out, c0_n354_W_out, c0_n355_W_out, c0_n356_W_out, c0_n357_W_out, c0_n358_W_out, c0_n359_W_out, c0_n360_W_out, c0_n361_W_out, c0_n362_W_out, c0_n363_W_out, c0_n364_W_out, c0_n365_W_out, c0_n366_W_out, c0_n367_W_out, c0_n368_W_out, c0_n369_W_out, c0_n370_W_out, c0_n371_W_out, c0_n372_W_out, c0_n373_W_out, c0_n374_W_out, c0_n375_W_out, c0_n376_W_out, c0_n377_W_out, c0_n378_W_out, c0_n379_W_out, c0_n380_W_out, c0_n381_W_out, c0_n382_W_out, c0_n383_W_out, c0_n384_W_out, c0_n385_W_out, c0_n386_W_out, c0_n387_W_out, c0_n388_W_out, c0_n389_W_out, c0_n390_W_out, c0_n391_W_out, c0_n392_W_out, c0_n393_W_out, c0_n394_W_out, c0_n395_W_out, c0_n396_W_out, c0_n397_W_out, c0_n398_W_out, c0_n399_W_out, c0_n400_W_out, c0_n401_W_out, c0_n402_W_out, c0_n403_W_out, c0_n404_W_out, c0_n405_W_out, c0_n406_W_out, c0_n407_W_out, c0_n408_W_out, c0_n409_W_out, c0_n410_W_out, c0_n411_W_out, c0_n412_W_out, c0_n413_W_out, c0_n414_W_out, c0_n415_W_out, c0_n416_W_out, c0_n417_W_out, c0_n418_W_out, c0_n419_W_out, c0_n420_W_out, c0_n421_W_out, c0_n422_W_out, c0_n423_W_out, c0_n424_W_out, c0_n425_W_out, c0_n426_W_out, c0_n427_W_out, c0_n428_W_out, c0_n429_W_out, c0_n430_W_out, c0_n431_W_out, c0_n432_W_out, c0_n433_W_out, c0_n434_W_out, c0_n435_W_out, c0_n436_W_out, c0_n437_W_out, c0_n438_W_out, c0_n439_W_out, c0_n440_W_out, c0_n441_W_out, c0_n442_W_out, c0_n443_W_out, c0_n444_W_out, c0_n445_W_out, c0_n446_W_out, c0_n447_W_out, c0_n448_W_out, c0_n449_W_out, c0_n450_W_out, c0_n451_W_out, c0_n452_W_out, c0_n453_W_out, c0_n454_W_out, c0_n455_W_out, c0_n456_W_out, c0_n457_W_out, c0_n458_W_out, c0_n459_W_out, c0_n460_W_out, c0_n461_W_out, c0_n462_W_out, c0_n463_W_out, c0_n464_W_out, c0_n465_W_out, c0_n466_W_out, c0_n467_W_out, c0_n468_W_out, c0_n469_W_out, c0_n470_W_out, c0_n471_W_out, c0_n472_W_out, c0_n473_W_out, c0_n474_W_out, c0_n475_W_out, c0_n476_W_out, c0_n477_W_out, c0_n478_W_out, c0_n479_W_out, c0_n480_W_out, c0_n481_W_out, c0_n482_W_out, c0_n483_W_out, c0_n484_W_out, c0_n485_W_out, c0_n486_W_out, c0_n487_W_out, c0_n488_W_out, c0_n489_W_out, c0_n490_W_out, c0_n491_W_out, c0_n492_W_out, c0_n493_W_out, c0_n494_W_out, c0_n495_W_out, c0_n496_W_out, c0_n497_W_out, c0_n498_W_out, c0_n499_W_out: OUT signed(BITS - 1 DOWNTO 0)
  );
  end ENTITY;

ARCHITECTURE arch OF  camada0_ReLU_500neuron_8bits_784n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n0_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n0_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n0_W_out
   );
            
neuron_inst_1: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n1_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n1_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n1_W_out
   );
            
neuron_inst_2: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n2_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n2_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n2_W_out
   );
            
neuron_inst_3: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n3_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n3_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n3_W_out
   );
            
neuron_inst_4: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n4_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n4_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n4_W_out
   );
            
neuron_inst_5: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n5_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n5_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n5_W_out
   );
            
neuron_inst_6: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n6_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n6_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n6_W_out
   );
            
neuron_inst_7: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n7_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n7_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n7_W_out
   );
            
neuron_inst_8: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n8_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n8_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n8_W_out
   );
            
neuron_inst_9: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n9_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n9_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n9_W_out
   );
            
neuron_inst_10: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n10_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n10_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n10_W_out
   );
            
neuron_inst_11: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n11_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n11_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n11_W_out
   );
            
neuron_inst_12: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n12_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n12_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n12_W_out
   );
            
neuron_inst_13: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n13_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n13_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n13_W_out
   );
            
neuron_inst_14: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n14_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n14_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n14_W_out
   );
            
neuron_inst_15: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n15_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n15_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n15_W_out
   );
            
neuron_inst_16: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n16_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n16_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n16_W_out
   );
            
neuron_inst_17: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n17_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n17_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n17_W_out
   );
            
neuron_inst_18: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n18_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n18_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n18_W_out
   );
            
neuron_inst_19: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n19_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n19_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n19_W_out
   );
            
neuron_inst_20: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n20_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n20_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n20_W_out
   );
            
neuron_inst_21: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n21_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n21_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n21_W_out
   );
            
neuron_inst_22: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n22_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n22_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n22_W_out
   );
            
neuron_inst_23: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n23_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n23_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n23_W_out
   );
            
neuron_inst_24: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n24_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n24_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n24_W_out
   );
            
neuron_inst_25: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n25_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n25_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n25_W_out
   );
            
neuron_inst_26: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n26_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n26_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n26_W_out
   );
            
neuron_inst_27: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n27_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n27_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n27_W_out
   );
            
neuron_inst_28: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n28_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n28_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n28_W_out
   );
            
neuron_inst_29: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n29_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n29_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n29_W_out
   );
            
neuron_inst_30: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n30_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n30_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n30_W_out
   );
            
neuron_inst_31: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n31_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n31_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n31_W_out
   );
            
neuron_inst_32: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n32_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n32_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n32_W_out
   );
            
neuron_inst_33: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n33_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n33_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n33_W_out
   );
            
neuron_inst_34: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n34_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n34_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n34_W_out
   );
            
neuron_inst_35: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n35_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n35_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n35_W_out
   );
            
neuron_inst_36: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n36_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n36_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n36_W_out
   );
            
neuron_inst_37: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n37_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n37_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n37_W_out
   );
            
neuron_inst_38: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n38_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n38_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n38_W_out
   );
            
neuron_inst_39: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n39_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n39_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n39_W_out
   );
            
neuron_inst_40: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n40_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n40_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n40_W_out
   );
            
neuron_inst_41: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n41_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n41_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n41_W_out
   );
            
neuron_inst_42: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n42_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n42_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n42_W_out
   );
            
neuron_inst_43: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n43_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n43_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n43_W_out
   );
            
neuron_inst_44: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n44_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n44_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n44_W_out
   );
            
neuron_inst_45: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n45_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n45_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n45_W_out
   );
            
neuron_inst_46: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n46_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n46_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n46_W_out
   );
            
neuron_inst_47: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n47_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n47_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n47_W_out
   );
            
neuron_inst_48: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n48_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n48_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n48_W_out
   );
            
neuron_inst_49: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n49_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n49_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n49_W_out
   );
            
neuron_inst_50: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n50_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n50_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n50_W_out
   );
            
neuron_inst_51: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n51_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n51_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n51_W_out
   );
            
neuron_inst_52: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n52_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n52_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n52_W_out
   );
            
neuron_inst_53: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n53_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n53_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n53_W_out
   );
            
neuron_inst_54: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n54_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n54_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n54_W_out
   );
            
neuron_inst_55: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n55_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n55_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n55_W_out
   );
            
neuron_inst_56: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n56_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n56_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n56_W_out
   );
            
neuron_inst_57: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n57_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n57_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n57_W_out
   );
            
neuron_inst_58: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n58_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n58_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n58_W_out
   );
            
neuron_inst_59: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n59_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n59_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n59_W_out
   );
            
neuron_inst_60: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n60_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n60_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n60_W_out
   );
            
neuron_inst_61: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n61_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n61_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n61_W_out
   );
            
neuron_inst_62: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n62_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n62_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n62_W_out
   );
            
neuron_inst_63: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n63_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n63_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n63_W_out
   );
            
neuron_inst_64: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n64_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n64_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n64_W_out
   );
            
neuron_inst_65: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n65_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n65_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n65_W_out
   );
            
neuron_inst_66: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n66_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n66_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n66_W_out
   );
            
neuron_inst_67: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n67_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n67_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n67_W_out
   );
            
neuron_inst_68: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n68_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n68_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n68_W_out
   );
            
neuron_inst_69: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n69_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n69_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n69_W_out
   );
            
neuron_inst_70: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n70_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n70_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n70_W_out
   );
            
neuron_inst_71: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n71_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n71_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n71_W_out
   );
            
neuron_inst_72: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n72_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n72_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n72_W_out
   );
            
neuron_inst_73: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n73_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n73_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n73_W_out
   );
            
neuron_inst_74: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n74_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n74_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n74_W_out
   );
            
neuron_inst_75: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n75_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n75_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n75_W_out
   );
            
neuron_inst_76: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n76_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n76_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n76_W_out
   );
            
neuron_inst_77: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n77_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n77_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n77_W_out
   );
            
neuron_inst_78: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n78_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n78_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n78_W_out
   );
            
neuron_inst_79: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n79_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n79_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n79_W_out
   );
            
neuron_inst_80: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n80_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n80_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n80_W_out
   );
            
neuron_inst_81: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n81_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n81_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n81_W_out
   );
            
neuron_inst_82: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n82_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n82_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n82_W_out
   );
            
neuron_inst_83: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n83_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n83_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n83_W_out
   );
            
neuron_inst_84: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n84_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n84_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n84_W_out
   );
            
neuron_inst_85: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n85_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n85_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n85_W_out
   );
            
neuron_inst_86: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n86_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n86_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n86_W_out
   );
            
neuron_inst_87: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n87_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n87_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n87_W_out
   );
            
neuron_inst_88: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n88_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n88_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n88_W_out
   );
            
neuron_inst_89: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n89_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n89_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n89_W_out
   );
            
neuron_inst_90: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n90_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n90_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n90_W_out
   );
            
neuron_inst_91: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n91_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n91_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n91_W_out
   );
            
neuron_inst_92: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n92_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n92_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n92_W_out
   );
            
neuron_inst_93: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n93_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n93_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n93_W_out
   );
            
neuron_inst_94: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n94_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n94_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n94_W_out
   );
            
neuron_inst_95: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n95_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n95_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n95_W_out
   );
            
neuron_inst_96: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n96_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n96_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n96_W_out
   );
            
neuron_inst_97: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n97_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n97_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n97_W_out
   );
            
neuron_inst_98: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n98_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n98_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n98_W_out
   );
            
neuron_inst_99: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n99_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n99_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n99_W_out
   );
            
neuron_inst_100: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n100_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n100_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n100_W_out
   );
            
neuron_inst_101: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n101_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n101_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n101_W_out
   );
            
neuron_inst_102: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n102_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n102_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n102_W_out
   );
            
neuron_inst_103: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n103_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n103_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n103_W_out
   );
            
neuron_inst_104: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n104_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n104_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n104_W_out
   );
            
neuron_inst_105: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n105_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n105_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n105_W_out
   );
            
neuron_inst_106: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n106_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n106_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n106_W_out
   );
            
neuron_inst_107: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n107_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n107_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n107_W_out
   );
            
neuron_inst_108: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n108_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n108_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n108_W_out
   );
            
neuron_inst_109: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n109_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n109_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n109_W_out
   );
            
neuron_inst_110: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n110_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n110_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n110_W_out
   );
            
neuron_inst_111: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n111_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n111_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n111_W_out
   );
            
neuron_inst_112: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n112_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n112_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n112_W_out
   );
            
neuron_inst_113: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n113_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n113_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n113_W_out
   );
            
neuron_inst_114: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n114_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n114_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n114_W_out
   );
            
neuron_inst_115: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n115_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n115_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n115_W_out
   );
            
neuron_inst_116: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n116_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n116_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n116_W_out
   );
            
neuron_inst_117: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n117_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n117_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n117_W_out
   );
            
neuron_inst_118: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n118_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n118_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n118_W_out
   );
            
neuron_inst_119: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n119_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n119_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n119_W_out
   );
            
neuron_inst_120: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n120_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n120_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n120_W_out
   );
            
neuron_inst_121: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n121_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n121_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n121_W_out
   );
            
neuron_inst_122: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n122_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n122_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n122_W_out
   );
            
neuron_inst_123: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n123_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n123_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n123_W_out
   );
            
neuron_inst_124: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n124_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n124_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n124_W_out
   );
            
neuron_inst_125: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n125_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n125_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n125_W_out
   );
            
neuron_inst_126: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n126_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n126_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n126_W_out
   );
            
neuron_inst_127: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n127_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n127_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n127_W_out
   );
            
neuron_inst_128: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n128_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n128_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n128_W_out
   );
            
neuron_inst_129: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n129_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n129_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n129_W_out
   );
            
neuron_inst_130: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n130_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n130_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n130_W_out
   );
            
neuron_inst_131: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n131_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n131_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n131_W_out
   );
            
neuron_inst_132: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n132_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n132_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n132_W_out
   );
            
neuron_inst_133: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n133_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n133_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n133_W_out
   );
            
neuron_inst_134: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n134_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n134_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n134_W_out
   );
            
neuron_inst_135: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n135_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n135_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n135_W_out
   );
            
neuron_inst_136: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n136_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n136_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n136_W_out
   );
            
neuron_inst_137: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n137_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n137_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n137_W_out
   );
            
neuron_inst_138: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n138_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n138_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n138_W_out
   );
            
neuron_inst_139: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n139_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n139_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n139_W_out
   );
            
neuron_inst_140: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n140_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n140_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n140_W_out
   );
            
neuron_inst_141: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n141_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n141_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n141_W_out
   );
            
neuron_inst_142: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n142_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n142_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n142_W_out
   );
            
neuron_inst_143: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n143_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n143_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n143_W_out
   );
            
neuron_inst_144: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n144_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n144_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n144_W_out
   );
            
neuron_inst_145: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n145_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n145_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n145_W_out
   );
            
neuron_inst_146: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n146_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n146_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n146_W_out
   );
            
neuron_inst_147: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n147_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n147_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n147_W_out
   );
            
neuron_inst_148: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n148_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n148_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n148_W_out
   );
            
neuron_inst_149: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n149_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n149_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n149_W_out
   );
            
neuron_inst_150: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n150_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n150_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n150_W_out
   );
            
neuron_inst_151: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n151_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n151_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n151_W_out
   );
            
neuron_inst_152: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n152_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n152_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n152_W_out
   );
            
neuron_inst_153: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n153_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n153_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n153_W_out
   );
            
neuron_inst_154: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n154_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n154_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n154_W_out
   );
            
neuron_inst_155: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n155_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n155_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n155_W_out
   );
            
neuron_inst_156: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n156_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n156_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n156_W_out
   );
            
neuron_inst_157: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n157_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n157_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n157_W_out
   );
            
neuron_inst_158: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n158_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n158_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n158_W_out
   );
            
neuron_inst_159: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n159_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n159_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n159_W_out
   );
            
neuron_inst_160: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n160_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n160_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n160_W_out
   );
            
neuron_inst_161: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n161_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n161_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n161_W_out
   );
            
neuron_inst_162: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n162_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n162_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n162_W_out
   );
            
neuron_inst_163: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n163_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n163_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n163_W_out
   );
            
neuron_inst_164: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n164_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n164_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n164_W_out
   );
            
neuron_inst_165: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n165_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n165_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n165_W_out
   );
            
neuron_inst_166: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n166_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n166_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n166_W_out
   );
            
neuron_inst_167: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n167_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n167_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n167_W_out
   );
            
neuron_inst_168: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n168_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n168_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n168_W_out
   );
            
neuron_inst_169: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n169_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n169_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n169_W_out
   );
            
neuron_inst_170: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n170_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n170_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n170_W_out
   );
            
neuron_inst_171: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n171_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n171_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n171_W_out
   );
            
neuron_inst_172: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n172_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n172_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n172_W_out
   );
            
neuron_inst_173: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n173_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n173_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n173_W_out
   );
            
neuron_inst_174: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n174_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n174_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n174_W_out
   );
            
neuron_inst_175: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n175_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n175_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n175_W_out
   );
            
neuron_inst_176: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n176_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n176_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n176_W_out
   );
            
neuron_inst_177: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n177_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n177_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n177_W_out
   );
            
neuron_inst_178: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n178_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n178_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n178_W_out
   );
            
neuron_inst_179: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n179_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n179_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n179_W_out
   );
            
neuron_inst_180: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n180_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n180_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n180_W_out
   );
            
neuron_inst_181: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n181_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n181_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n181_W_out
   );
            
neuron_inst_182: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n182_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n182_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n182_W_out
   );
            
neuron_inst_183: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n183_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n183_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n183_W_out
   );
            
neuron_inst_184: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n184_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n184_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n184_W_out
   );
            
neuron_inst_185: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n185_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n185_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n185_W_out
   );
            
neuron_inst_186: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n186_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n186_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n186_W_out
   );
            
neuron_inst_187: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n187_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n187_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n187_W_out
   );
            
neuron_inst_188: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n188_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n188_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n188_W_out
   );
            
neuron_inst_189: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n189_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n189_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n189_W_out
   );
            
neuron_inst_190: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n190_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n190_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n190_W_out
   );
            
neuron_inst_191: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n191_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n191_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n191_W_out
   );
            
neuron_inst_192: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n192_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n192_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n192_W_out
   );
            
neuron_inst_193: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n193_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n193_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n193_W_out
   );
            
neuron_inst_194: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n194_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n194_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n194_W_out
   );
            
neuron_inst_195: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n195_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n195_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n195_W_out
   );
            
neuron_inst_196: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n196_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n196_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n196_W_out
   );
            
neuron_inst_197: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n197_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n197_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n197_W_out
   );
            
neuron_inst_198: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n198_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n198_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n198_W_out
   );
            
neuron_inst_199: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n199_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n199_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n199_W_out
   );
            
neuron_inst_200: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n200_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n200_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n200_W_out
   );
            
neuron_inst_201: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n201_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n201_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n201_W_out
   );
            
neuron_inst_202: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n202_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n202_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n202_W_out
   );
            
neuron_inst_203: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n203_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n203_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n203_W_out
   );
            
neuron_inst_204: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n204_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n204_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n204_W_out
   );
            
neuron_inst_205: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n205_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n205_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n205_W_out
   );
            
neuron_inst_206: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n206_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n206_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n206_W_out
   );
            
neuron_inst_207: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n207_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n207_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n207_W_out
   );
            
neuron_inst_208: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n208_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n208_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n208_W_out
   );
            
neuron_inst_209: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n209_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n209_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n209_W_out
   );
            
neuron_inst_210: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n210_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n210_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n210_W_out
   );
            
neuron_inst_211: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n211_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n211_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n211_W_out
   );
            
neuron_inst_212: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n212_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n212_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n212_W_out
   );
            
neuron_inst_213: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n213_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n213_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n213_W_out
   );
            
neuron_inst_214: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n214_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n214_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n214_W_out
   );
            
neuron_inst_215: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n215_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n215_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n215_W_out
   );
            
neuron_inst_216: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n216_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n216_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n216_W_out
   );
            
neuron_inst_217: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n217_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n217_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n217_W_out
   );
            
neuron_inst_218: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n218_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n218_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n218_W_out
   );
            
neuron_inst_219: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n219_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n219_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n219_W_out
   );
            
neuron_inst_220: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n220_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n220_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n220_W_out
   );
            
neuron_inst_221: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n221_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n221_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n221_W_out
   );
            
neuron_inst_222: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n222_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n222_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n222_W_out
   );
            
neuron_inst_223: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n223_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n223_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n223_W_out
   );
            
neuron_inst_224: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n224_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n224_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n224_W_out
   );
            
neuron_inst_225: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n225_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n225_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n225_W_out
   );
            
neuron_inst_226: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n226_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n226_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n226_W_out
   );
            
neuron_inst_227: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n227_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n227_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n227_W_out
   );
            
neuron_inst_228: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n228_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n228_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n228_W_out
   );
            
neuron_inst_229: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n229_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n229_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n229_W_out
   );
            
neuron_inst_230: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n230_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n230_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n230_W_out
   );
            
neuron_inst_231: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n231_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n231_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n231_W_out
   );
            
neuron_inst_232: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n232_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n232_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n232_W_out
   );
            
neuron_inst_233: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n233_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n233_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n233_W_out
   );
            
neuron_inst_234: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n234_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n234_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n234_W_out
   );
            
neuron_inst_235: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n235_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n235_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n235_W_out
   );
            
neuron_inst_236: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n236_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n236_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n236_W_out
   );
            
neuron_inst_237: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n237_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n237_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n237_W_out
   );
            
neuron_inst_238: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n238_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n238_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n238_W_out
   );
            
neuron_inst_239: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n239_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n239_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n239_W_out
   );
            
neuron_inst_240: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n240_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n240_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n240_W_out
   );
            
neuron_inst_241: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n241_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n241_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n241_W_out
   );
            
neuron_inst_242: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n242_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n242_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n242_W_out
   );
            
neuron_inst_243: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n243_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n243_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n243_W_out
   );
            
neuron_inst_244: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n244_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n244_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n244_W_out
   );
            
neuron_inst_245: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n245_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n245_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n245_W_out
   );
            
neuron_inst_246: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n246_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n246_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n246_W_out
   );
            
neuron_inst_247: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n247_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n247_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n247_W_out
   );
            
neuron_inst_248: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n248_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n248_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n248_W_out
   );
            
neuron_inst_249: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n249_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n249_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n249_W_out
   );
            
neuron_inst_250: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n250_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n250_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n250_W_out
   );
            
neuron_inst_251: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n251_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n251_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n251_W_out
   );
            
neuron_inst_252: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n252_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n252_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n252_W_out
   );
            
neuron_inst_253: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n253_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n253_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n253_W_out
   );
            
neuron_inst_254: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n254_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n254_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n254_W_out
   );
            
neuron_inst_255: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n255_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n255_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n255_W_out
   );
            
neuron_inst_256: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n256_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n256_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n256_W_out
   );
            
neuron_inst_257: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n257_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n257_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n257_W_out
   );
            
neuron_inst_258: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n258_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n258_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n258_W_out
   );
            
neuron_inst_259: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n259_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n259_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n259_W_out
   );
            
neuron_inst_260: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n260_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n260_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n260_W_out
   );
            
neuron_inst_261: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n261_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n261_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n261_W_out
   );
            
neuron_inst_262: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n262_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n262_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n262_W_out
   );
            
neuron_inst_263: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n263_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n263_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n263_W_out
   );
            
neuron_inst_264: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n264_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n264_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n264_W_out
   );
            
neuron_inst_265: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n265_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n265_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n265_W_out
   );
            
neuron_inst_266: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n266_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n266_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n266_W_out
   );
            
neuron_inst_267: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n267_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n267_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n267_W_out
   );
            
neuron_inst_268: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n268_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n268_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n268_W_out
   );
            
neuron_inst_269: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n269_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n269_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n269_W_out
   );
            
neuron_inst_270: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n270_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n270_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n270_W_out
   );
            
neuron_inst_271: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n271_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n271_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n271_W_out
   );
            
neuron_inst_272: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n272_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n272_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n272_W_out
   );
            
neuron_inst_273: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n273_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n273_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n273_W_out
   );
            
neuron_inst_274: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n274_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n274_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n274_W_out
   );
            
neuron_inst_275: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n275_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n275_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n275_W_out
   );
            
neuron_inst_276: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n276_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n276_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n276_W_out
   );
            
neuron_inst_277: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n277_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n277_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n277_W_out
   );
            
neuron_inst_278: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n278_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n278_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n278_W_out
   );
            
neuron_inst_279: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n279_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n279_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n279_W_out
   );
            
neuron_inst_280: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n280_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n280_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n280_W_out
   );
            
neuron_inst_281: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n281_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n281_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n281_W_out
   );
            
neuron_inst_282: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n282_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n282_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n282_W_out
   );
            
neuron_inst_283: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n283_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n283_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n283_W_out
   );
            
neuron_inst_284: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n284_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n284_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n284_W_out
   );
            
neuron_inst_285: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n285_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n285_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n285_W_out
   );
            
neuron_inst_286: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n286_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n286_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n286_W_out
   );
            
neuron_inst_287: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n287_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n287_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n287_W_out
   );
            
neuron_inst_288: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n288_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n288_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n288_W_out
   );
            
neuron_inst_289: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n289_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n289_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n289_W_out
   );
            
neuron_inst_290: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n290_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n290_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n290_W_out
   );
            
neuron_inst_291: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n291_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n291_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n291_W_out
   );
            
neuron_inst_292: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n292_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n292_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n292_W_out
   );
            
neuron_inst_293: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n293_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n293_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n293_W_out
   );
            
neuron_inst_294: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n294_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n294_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n294_W_out
   );
            
neuron_inst_295: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n295_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n295_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n295_W_out
   );
            
neuron_inst_296: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n296_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n296_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n296_W_out
   );
            
neuron_inst_297: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n297_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n297_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n297_W_out
   );
            
neuron_inst_298: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n298_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n298_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n298_W_out
   );
            
neuron_inst_299: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n299_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n299_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n299_W_out
   );
            
neuron_inst_300: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n300_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n300_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n300_W_out
   );
            
neuron_inst_301: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n301_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n301_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n301_W_out
   );
            
neuron_inst_302: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n302_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n302_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n302_W_out
   );
            
neuron_inst_303: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n303_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n303_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n303_W_out
   );
            
neuron_inst_304: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n304_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n304_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n304_W_out
   );
            
neuron_inst_305: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n305_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n305_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n305_W_out
   );
            
neuron_inst_306: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n306_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n306_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n306_W_out
   );
            
neuron_inst_307: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n307_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n307_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n307_W_out
   );
            
neuron_inst_308: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n308_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n308_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n308_W_out
   );
            
neuron_inst_309: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n309_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n309_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n309_W_out
   );
            
neuron_inst_310: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n310_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n310_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n310_W_out
   );
            
neuron_inst_311: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n311_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n311_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n311_W_out
   );
            
neuron_inst_312: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n312_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n312_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n312_W_out
   );
            
neuron_inst_313: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n313_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n313_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n313_W_out
   );
            
neuron_inst_314: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n314_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n314_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n314_W_out
   );
            
neuron_inst_315: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n315_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n315_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n315_W_out
   );
            
neuron_inst_316: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n316_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n316_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n316_W_out
   );
            
neuron_inst_317: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n317_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n317_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n317_W_out
   );
            
neuron_inst_318: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n318_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n318_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n318_W_out
   );
            
neuron_inst_319: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n319_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n319_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n319_W_out
   );
            
neuron_inst_320: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n320_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n320_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n320_W_out
   );
            
neuron_inst_321: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n321_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n321_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n321_W_out
   );
            
neuron_inst_322: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n322_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n322_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n322_W_out
   );
            
neuron_inst_323: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n323_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n323_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n323_W_out
   );
            
neuron_inst_324: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n324_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n324_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n324_W_out
   );
            
neuron_inst_325: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n325_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n325_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n325_W_out
   );
            
neuron_inst_326: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n326_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n326_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n326_W_out
   );
            
neuron_inst_327: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n327_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n327_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n327_W_out
   );
            
neuron_inst_328: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n328_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n328_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n328_W_out
   );
            
neuron_inst_329: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n329_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n329_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n329_W_out
   );
            
neuron_inst_330: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n330_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n330_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n330_W_out
   );
            
neuron_inst_331: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n331_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n331_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n331_W_out
   );
            
neuron_inst_332: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n332_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n332_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n332_W_out
   );
            
neuron_inst_333: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n333_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n333_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n333_W_out
   );
            
neuron_inst_334: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n334_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n334_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n334_W_out
   );
            
neuron_inst_335: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n335_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n335_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n335_W_out
   );
            
neuron_inst_336: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n336_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n336_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n336_W_out
   );
            
neuron_inst_337: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n337_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n337_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n337_W_out
   );
            
neuron_inst_338: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n338_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n338_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n338_W_out
   );
            
neuron_inst_339: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n339_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n339_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n339_W_out
   );
            
neuron_inst_340: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n340_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n340_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n340_W_out
   );
            
neuron_inst_341: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n341_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n341_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n341_W_out
   );
            
neuron_inst_342: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n342_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n342_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n342_W_out
   );
            
neuron_inst_343: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n343_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n343_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n343_W_out
   );
            
neuron_inst_344: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n344_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n344_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n344_W_out
   );
            
neuron_inst_345: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n345_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n345_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n345_W_out
   );
            
neuron_inst_346: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n346_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n346_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n346_W_out
   );
            
neuron_inst_347: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n347_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n347_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n347_W_out
   );
            
neuron_inst_348: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n348_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n348_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n348_W_out
   );
            
neuron_inst_349: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n349_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n349_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n349_W_out
   );
            
neuron_inst_350: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n350_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n350_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n350_W_out
   );
            
neuron_inst_351: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n351_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n351_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n351_W_out
   );
            
neuron_inst_352: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n352_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n352_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n352_W_out
   );
            
neuron_inst_353: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n353_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n353_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n353_W_out
   );
            
neuron_inst_354: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n354_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n354_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n354_W_out
   );
            
neuron_inst_355: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n355_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n355_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n355_W_out
   );
            
neuron_inst_356: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n356_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n356_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n356_W_out
   );
            
neuron_inst_357: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n357_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n357_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n357_W_out
   );
            
neuron_inst_358: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n358_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n358_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n358_W_out
   );
            
neuron_inst_359: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n359_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n359_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n359_W_out
   );
            
neuron_inst_360: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n360_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n360_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n360_W_out
   );
            
neuron_inst_361: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n361_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n361_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n361_W_out
   );
            
neuron_inst_362: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n362_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n362_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n362_W_out
   );
            
neuron_inst_363: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n363_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n363_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n363_W_out
   );
            
neuron_inst_364: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n364_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n364_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n364_W_out
   );
            
neuron_inst_365: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n365_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n365_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n365_W_out
   );
            
neuron_inst_366: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n366_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n366_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n366_W_out
   );
            
neuron_inst_367: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n367_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n367_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n367_W_out
   );
            
neuron_inst_368: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n368_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n368_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n368_W_out
   );
            
neuron_inst_369: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n369_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n369_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n369_W_out
   );
            
neuron_inst_370: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n370_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n370_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n370_W_out
   );
            
neuron_inst_371: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n371_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n371_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n371_W_out
   );
            
neuron_inst_372: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n372_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n372_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n372_W_out
   );
            
neuron_inst_373: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n373_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n373_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n373_W_out
   );
            
neuron_inst_374: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n374_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n374_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n374_W_out
   );
            
neuron_inst_375: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n375_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n375_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n375_W_out
   );
            
neuron_inst_376: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n376_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n376_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n376_W_out
   );
            
neuron_inst_377: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n377_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n377_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n377_W_out
   );
            
neuron_inst_378: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n378_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n378_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n378_W_out
   );
            
neuron_inst_379: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n379_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n379_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n379_W_out
   );
            
neuron_inst_380: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n380_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n380_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n380_W_out
   );
            
neuron_inst_381: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n381_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n381_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n381_W_out
   );
            
neuron_inst_382: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n382_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n382_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n382_W_out
   );
            
neuron_inst_383: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n383_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n383_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n383_W_out
   );
            
neuron_inst_384: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n384_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n384_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n384_W_out
   );
            
neuron_inst_385: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n385_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n385_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n385_W_out
   );
            
neuron_inst_386: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n386_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n386_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n386_W_out
   );
            
neuron_inst_387: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n387_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n387_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n387_W_out
   );
            
neuron_inst_388: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n388_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n388_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n388_W_out
   );
            
neuron_inst_389: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n389_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n389_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n389_W_out
   );
            
neuron_inst_390: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n390_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n390_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n390_W_out
   );
            
neuron_inst_391: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n391_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n391_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n391_W_out
   );
            
neuron_inst_392: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n392_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n392_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n392_W_out
   );
            
neuron_inst_393: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n393_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n393_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n393_W_out
   );
            
neuron_inst_394: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n394_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n394_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n394_W_out
   );
            
neuron_inst_395: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n395_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n395_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n395_W_out
   );
            
neuron_inst_396: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n396_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n396_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n396_W_out
   );
            
neuron_inst_397: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n397_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n397_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n397_W_out
   );
            
neuron_inst_398: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n398_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n398_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n398_W_out
   );
            
neuron_inst_399: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n399_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n399_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n399_W_out
   );
            
neuron_inst_400: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n400_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n400_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n400_W_out
   );
            
neuron_inst_401: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n401_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n401_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n401_W_out
   );
            
neuron_inst_402: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n402_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n402_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n402_W_out
   );
            
neuron_inst_403: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n403_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n403_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n403_W_out
   );
            
neuron_inst_404: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n404_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n404_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n404_W_out
   );
            
neuron_inst_405: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n405_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n405_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n405_W_out
   );
            
neuron_inst_406: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n406_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n406_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n406_W_out
   );
            
neuron_inst_407: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n407_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n407_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n407_W_out
   );
            
neuron_inst_408: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n408_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n408_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n408_W_out
   );
            
neuron_inst_409: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n409_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n409_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n409_W_out
   );
            
neuron_inst_410: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n410_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n410_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n410_W_out
   );
            
neuron_inst_411: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n411_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n411_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n411_W_out
   );
            
neuron_inst_412: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n412_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n412_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n412_W_out
   );
            
neuron_inst_413: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n413_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n413_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n413_W_out
   );
            
neuron_inst_414: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n414_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n414_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n414_W_out
   );
            
neuron_inst_415: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n415_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n415_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n415_W_out
   );
            
neuron_inst_416: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n416_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n416_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n416_W_out
   );
            
neuron_inst_417: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n417_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n417_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n417_W_out
   );
            
neuron_inst_418: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n418_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n418_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n418_W_out
   );
            
neuron_inst_419: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n419_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n419_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n419_W_out
   );
            
neuron_inst_420: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n420_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n420_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n420_W_out
   );
            
neuron_inst_421: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n421_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n421_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n421_W_out
   );
            
neuron_inst_422: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n422_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n422_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n422_W_out
   );
            
neuron_inst_423: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n423_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n423_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n423_W_out
   );
            
neuron_inst_424: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n424_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n424_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n424_W_out
   );
            
neuron_inst_425: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n425_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n425_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n425_W_out
   );
            
neuron_inst_426: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n426_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n426_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n426_W_out
   );
            
neuron_inst_427: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n427_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n427_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n427_W_out
   );
            
neuron_inst_428: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n428_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n428_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n428_W_out
   );
            
neuron_inst_429: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n429_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n429_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n429_W_out
   );
            
neuron_inst_430: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n430_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n430_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n430_W_out
   );
            
neuron_inst_431: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n431_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n431_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n431_W_out
   );
            
neuron_inst_432: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n432_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n432_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n432_W_out
   );
            
neuron_inst_433: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n433_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n433_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n433_W_out
   );
            
neuron_inst_434: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n434_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n434_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n434_W_out
   );
            
neuron_inst_435: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n435_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n435_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n435_W_out
   );
            
neuron_inst_436: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n436_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n436_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n436_W_out
   );
            
neuron_inst_437: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n437_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n437_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n437_W_out
   );
            
neuron_inst_438: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n438_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n438_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n438_W_out
   );
            
neuron_inst_439: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n439_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n439_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n439_W_out
   );
            
neuron_inst_440: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n440_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n440_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n440_W_out
   );
            
neuron_inst_441: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n441_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n441_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n441_W_out
   );
            
neuron_inst_442: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n442_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n442_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n442_W_out
   );
            
neuron_inst_443: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n443_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n443_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n443_W_out
   );
            
neuron_inst_444: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n444_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n444_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n444_W_out
   );
            
neuron_inst_445: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n445_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n445_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n445_W_out
   );
            
neuron_inst_446: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n446_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n446_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n446_W_out
   );
            
neuron_inst_447: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n447_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n447_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n447_W_out
   );
            
neuron_inst_448: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n448_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n448_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n448_W_out
   );
            
neuron_inst_449: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n449_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n449_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n449_W_out
   );
            
neuron_inst_450: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n450_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n450_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n450_W_out
   );
            
neuron_inst_451: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n451_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n451_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n451_W_out
   );
            
neuron_inst_452: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n452_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n452_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n452_W_out
   );
            
neuron_inst_453: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n453_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n453_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n453_W_out
   );
            
neuron_inst_454: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n454_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n454_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n454_W_out
   );
            
neuron_inst_455: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n455_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n455_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n455_W_out
   );
            
neuron_inst_456: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n456_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n456_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n456_W_out
   );
            
neuron_inst_457: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n457_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n457_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n457_W_out
   );
            
neuron_inst_458: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n458_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n458_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n458_W_out
   );
            
neuron_inst_459: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n459_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n459_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n459_W_out
   );
            
neuron_inst_460: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n460_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n460_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n460_W_out
   );
            
neuron_inst_461: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n461_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n461_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n461_W_out
   );
            
neuron_inst_462: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n462_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n462_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n462_W_out
   );
            
neuron_inst_463: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n463_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n463_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n463_W_out
   );
            
neuron_inst_464: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n464_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n464_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n464_W_out
   );
            
neuron_inst_465: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n465_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n465_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n465_W_out
   );
            
neuron_inst_466: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n466_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n466_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n466_W_out
   );
            
neuron_inst_467: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n467_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n467_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n467_W_out
   );
            
neuron_inst_468: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n468_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n468_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n468_W_out
   );
            
neuron_inst_469: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n469_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n469_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n469_W_out
   );
            
neuron_inst_470: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n470_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n470_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n470_W_out
   );
            
neuron_inst_471: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n471_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n471_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n471_W_out
   );
            
neuron_inst_472: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n472_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n472_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n472_W_out
   );
            
neuron_inst_473: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n473_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n473_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n473_W_out
   );
            
neuron_inst_474: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n474_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n474_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n474_W_out
   );
            
neuron_inst_475: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n475_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n475_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n475_W_out
   );
            
neuron_inst_476: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n476_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n476_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n476_W_out
   );
            
neuron_inst_477: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n477_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n477_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n477_W_out
   );
            
neuron_inst_478: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n478_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n478_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n478_W_out
   );
            
neuron_inst_479: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n479_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n479_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n479_W_out
   );
            
neuron_inst_480: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n480_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n480_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n480_W_out
   );
            
neuron_inst_481: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n481_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n481_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n481_W_out
   );
            
neuron_inst_482: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n482_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n482_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n482_W_out
   );
            
neuron_inst_483: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n483_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n483_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n483_W_out
   );
            
neuron_inst_484: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n484_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n484_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n484_W_out
   );
            
neuron_inst_485: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n485_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n485_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n485_W_out
   );
            
neuron_inst_486: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n486_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n486_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n486_W_out
   );
            
neuron_inst_487: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n487_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n487_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n487_W_out
   );
            
neuron_inst_488: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n488_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n488_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n488_W_out
   );
            
neuron_inst_489: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n489_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n489_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n489_W_out
   );
            
neuron_inst_490: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n490_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n490_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n490_W_out
   );
            
neuron_inst_491: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n491_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n491_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n491_W_out
   );
            
neuron_inst_492: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n492_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n492_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n492_W_out
   );
            
neuron_inst_493: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n493_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n493_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n493_W_out
   );
            
neuron_inst_494: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n494_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n494_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n494_W_out
   );
            
neuron_inst_495: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n495_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n495_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n495_W_out
   );
            
neuron_inst_496: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n496_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n496_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n496_W_out
   );
            
neuron_inst_497: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n497_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n497_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n497_W_out
   );
            
neuron_inst_498: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n498_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n498_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n498_W_out
   );
            
neuron_inst_499: ENTITY work.neuron_ReLU_784n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c0_n499_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c0_n499_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c0_n499_W_out
   );
             
END ARCHITECTURE;

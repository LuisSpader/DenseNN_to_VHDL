LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

  ENTITY  camada1_ReLU_300neuron_8bits_500n_signed IS
  GENERIC (
    BITS : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 500;
    TOTAL_BITS : NATURAL := 4000
  );
  PORT (
      clk, rst, update_weights: IN STD_LOGIC;
      IO_in: IN signed(TOTAL_BITS - 1 DOWNTO 0);
      c1_n0_W_in, c1_n1_W_in, c1_n2_W_in, c1_n3_W_in, c1_n4_W_in, c1_n5_W_in, c1_n6_W_in, c1_n7_W_in, c1_n8_W_in, c1_n9_W_in, c1_n10_W_in, c1_n11_W_in, c1_n12_W_in, c1_n13_W_in, c1_n14_W_in, c1_n15_W_in, c1_n16_W_in, c1_n17_W_in, c1_n18_W_in, c1_n19_W_in, c1_n20_W_in, c1_n21_W_in, c1_n22_W_in, c1_n23_W_in, c1_n24_W_in, c1_n25_W_in, c1_n26_W_in, c1_n27_W_in, c1_n28_W_in, c1_n29_W_in, c1_n30_W_in, c1_n31_W_in, c1_n32_W_in, c1_n33_W_in, c1_n34_W_in, c1_n35_W_in, c1_n36_W_in, c1_n37_W_in, c1_n38_W_in, c1_n39_W_in, c1_n40_W_in, c1_n41_W_in, c1_n42_W_in, c1_n43_W_in, c1_n44_W_in, c1_n45_W_in, c1_n46_W_in, c1_n47_W_in, c1_n48_W_in, c1_n49_W_in, c1_n50_W_in, c1_n51_W_in, c1_n52_W_in, c1_n53_W_in, c1_n54_W_in, c1_n55_W_in, c1_n56_W_in, c1_n57_W_in, c1_n58_W_in, c1_n59_W_in, c1_n60_W_in, c1_n61_W_in, c1_n62_W_in, c1_n63_W_in, c1_n64_W_in, c1_n65_W_in, c1_n66_W_in, c1_n67_W_in, c1_n68_W_in, c1_n69_W_in, c1_n70_W_in, c1_n71_W_in, c1_n72_W_in, c1_n73_W_in, c1_n74_W_in, c1_n75_W_in, c1_n76_W_in, c1_n77_W_in, c1_n78_W_in, c1_n79_W_in, c1_n80_W_in, c1_n81_W_in, c1_n82_W_in, c1_n83_W_in, c1_n84_W_in, c1_n85_W_in, c1_n86_W_in, c1_n87_W_in, c1_n88_W_in, c1_n89_W_in, c1_n90_W_in, c1_n91_W_in, c1_n92_W_in, c1_n93_W_in, c1_n94_W_in, c1_n95_W_in, c1_n96_W_in, c1_n97_W_in, c1_n98_W_in, c1_n99_W_in, c1_n100_W_in, c1_n101_W_in, c1_n102_W_in, c1_n103_W_in, c1_n104_W_in, c1_n105_W_in, c1_n106_W_in, c1_n107_W_in, c1_n108_W_in, c1_n109_W_in, c1_n110_W_in, c1_n111_W_in, c1_n112_W_in, c1_n113_W_in, c1_n114_W_in, c1_n115_W_in, c1_n116_W_in, c1_n117_W_in, c1_n118_W_in, c1_n119_W_in, c1_n120_W_in, c1_n121_W_in, c1_n122_W_in, c1_n123_W_in, c1_n124_W_in, c1_n125_W_in, c1_n126_W_in, c1_n127_W_in, c1_n128_W_in, c1_n129_W_in, c1_n130_W_in, c1_n131_W_in, c1_n132_W_in, c1_n133_W_in, c1_n134_W_in, c1_n135_W_in, c1_n136_W_in, c1_n137_W_in, c1_n138_W_in, c1_n139_W_in, c1_n140_W_in, c1_n141_W_in, c1_n142_W_in, c1_n143_W_in, c1_n144_W_in, c1_n145_W_in, c1_n146_W_in, c1_n147_W_in, c1_n148_W_in, c1_n149_W_in, c1_n150_W_in, c1_n151_W_in, c1_n152_W_in, c1_n153_W_in, c1_n154_W_in, c1_n155_W_in, c1_n156_W_in, c1_n157_W_in, c1_n158_W_in, c1_n159_W_in, c1_n160_W_in, c1_n161_W_in, c1_n162_W_in, c1_n163_W_in, c1_n164_W_in, c1_n165_W_in, c1_n166_W_in, c1_n167_W_in, c1_n168_W_in, c1_n169_W_in, c1_n170_W_in, c1_n171_W_in, c1_n172_W_in, c1_n173_W_in, c1_n174_W_in, c1_n175_W_in, c1_n176_W_in, c1_n177_W_in, c1_n178_W_in, c1_n179_W_in, c1_n180_W_in, c1_n181_W_in, c1_n182_W_in, c1_n183_W_in, c1_n184_W_in, c1_n185_W_in, c1_n186_W_in, c1_n187_W_in, c1_n188_W_in, c1_n189_W_in, c1_n190_W_in, c1_n191_W_in, c1_n192_W_in, c1_n193_W_in, c1_n194_W_in, c1_n195_W_in, c1_n196_W_in, c1_n197_W_in, c1_n198_W_in, c1_n199_W_in, c1_n200_W_in, c1_n201_W_in, c1_n202_W_in, c1_n203_W_in, c1_n204_W_in, c1_n205_W_in, c1_n206_W_in, c1_n207_W_in, c1_n208_W_in, c1_n209_W_in, c1_n210_W_in, c1_n211_W_in, c1_n212_W_in, c1_n213_W_in, c1_n214_W_in, c1_n215_W_in, c1_n216_W_in, c1_n217_W_in, c1_n218_W_in, c1_n219_W_in, c1_n220_W_in, c1_n221_W_in, c1_n222_W_in, c1_n223_W_in, c1_n224_W_in, c1_n225_W_in, c1_n226_W_in, c1_n227_W_in, c1_n228_W_in, c1_n229_W_in, c1_n230_W_in, c1_n231_W_in, c1_n232_W_in, c1_n233_W_in, c1_n234_W_in, c1_n235_W_in, c1_n236_W_in, c1_n237_W_in, c1_n238_W_in, c1_n239_W_in, c1_n240_W_in, c1_n241_W_in, c1_n242_W_in, c1_n243_W_in, c1_n244_W_in, c1_n245_W_in, c1_n246_W_in, c1_n247_W_in, c1_n248_W_in, c1_n249_W_in, c1_n250_W_in, c1_n251_W_in, c1_n252_W_in, c1_n253_W_in, c1_n254_W_in, c1_n255_W_in, c1_n256_W_in, c1_n257_W_in, c1_n258_W_in, c1_n259_W_in, c1_n260_W_in, c1_n261_W_in, c1_n262_W_in, c1_n263_W_in, c1_n264_W_in, c1_n265_W_in, c1_n266_W_in, c1_n267_W_in, c1_n268_W_in, c1_n269_W_in, c1_n270_W_in, c1_n271_W_in, c1_n272_W_in, c1_n273_W_in, c1_n274_W_in, c1_n275_W_in, c1_n276_W_in, c1_n277_W_in, c1_n278_W_in, c1_n279_W_in, c1_n280_W_in, c1_n281_W_in, c1_n282_W_in, c1_n283_W_in, c1_n284_W_in, c1_n285_W_in, c1_n286_W_in, c1_n287_W_in, c1_n288_W_in, c1_n289_W_in, c1_n290_W_in, c1_n291_W_in, c1_n292_W_in, c1_n293_W_in, c1_n294_W_in, c1_n295_W_in, c1_n296_W_in, c1_n297_W_in, c1_n298_W_in, c1_n299_W_in: IN signed(BITS - 1 DOWNTO 0);
      ----------------------------------------------
      c1_n0_IO_out, c1_n1_IO_out, c1_n2_IO_out, c1_n3_IO_out, c1_n4_IO_out, c1_n5_IO_out, c1_n6_IO_out, c1_n7_IO_out, c1_n8_IO_out, c1_n9_IO_out, c1_n10_IO_out, c1_n11_IO_out, c1_n12_IO_out, c1_n13_IO_out, c1_n14_IO_out, c1_n15_IO_out, c1_n16_IO_out, c1_n17_IO_out, c1_n18_IO_out, c1_n19_IO_out, c1_n20_IO_out, c1_n21_IO_out, c1_n22_IO_out, c1_n23_IO_out, c1_n24_IO_out, c1_n25_IO_out, c1_n26_IO_out, c1_n27_IO_out, c1_n28_IO_out, c1_n29_IO_out, c1_n30_IO_out, c1_n31_IO_out, c1_n32_IO_out, c1_n33_IO_out, c1_n34_IO_out, c1_n35_IO_out, c1_n36_IO_out, c1_n37_IO_out, c1_n38_IO_out, c1_n39_IO_out, c1_n40_IO_out, c1_n41_IO_out, c1_n42_IO_out, c1_n43_IO_out, c1_n44_IO_out, c1_n45_IO_out, c1_n46_IO_out, c1_n47_IO_out, c1_n48_IO_out, c1_n49_IO_out, c1_n50_IO_out, c1_n51_IO_out, c1_n52_IO_out, c1_n53_IO_out, c1_n54_IO_out, c1_n55_IO_out, c1_n56_IO_out, c1_n57_IO_out, c1_n58_IO_out, c1_n59_IO_out, c1_n60_IO_out, c1_n61_IO_out, c1_n62_IO_out, c1_n63_IO_out, c1_n64_IO_out, c1_n65_IO_out, c1_n66_IO_out, c1_n67_IO_out, c1_n68_IO_out, c1_n69_IO_out, c1_n70_IO_out, c1_n71_IO_out, c1_n72_IO_out, c1_n73_IO_out, c1_n74_IO_out, c1_n75_IO_out, c1_n76_IO_out, c1_n77_IO_out, c1_n78_IO_out, c1_n79_IO_out, c1_n80_IO_out, c1_n81_IO_out, c1_n82_IO_out, c1_n83_IO_out, c1_n84_IO_out, c1_n85_IO_out, c1_n86_IO_out, c1_n87_IO_out, c1_n88_IO_out, c1_n89_IO_out, c1_n90_IO_out, c1_n91_IO_out, c1_n92_IO_out, c1_n93_IO_out, c1_n94_IO_out, c1_n95_IO_out, c1_n96_IO_out, c1_n97_IO_out, c1_n98_IO_out, c1_n99_IO_out, c1_n100_IO_out, c1_n101_IO_out, c1_n102_IO_out, c1_n103_IO_out, c1_n104_IO_out, c1_n105_IO_out, c1_n106_IO_out, c1_n107_IO_out, c1_n108_IO_out, c1_n109_IO_out, c1_n110_IO_out, c1_n111_IO_out, c1_n112_IO_out, c1_n113_IO_out, c1_n114_IO_out, c1_n115_IO_out, c1_n116_IO_out, c1_n117_IO_out, c1_n118_IO_out, c1_n119_IO_out, c1_n120_IO_out, c1_n121_IO_out, c1_n122_IO_out, c1_n123_IO_out, c1_n124_IO_out, c1_n125_IO_out, c1_n126_IO_out, c1_n127_IO_out, c1_n128_IO_out, c1_n129_IO_out, c1_n130_IO_out, c1_n131_IO_out, c1_n132_IO_out, c1_n133_IO_out, c1_n134_IO_out, c1_n135_IO_out, c1_n136_IO_out, c1_n137_IO_out, c1_n138_IO_out, c1_n139_IO_out, c1_n140_IO_out, c1_n141_IO_out, c1_n142_IO_out, c1_n143_IO_out, c1_n144_IO_out, c1_n145_IO_out, c1_n146_IO_out, c1_n147_IO_out, c1_n148_IO_out, c1_n149_IO_out, c1_n150_IO_out, c1_n151_IO_out, c1_n152_IO_out, c1_n153_IO_out, c1_n154_IO_out, c1_n155_IO_out, c1_n156_IO_out, c1_n157_IO_out, c1_n158_IO_out, c1_n159_IO_out, c1_n160_IO_out, c1_n161_IO_out, c1_n162_IO_out, c1_n163_IO_out, c1_n164_IO_out, c1_n165_IO_out, c1_n166_IO_out, c1_n167_IO_out, c1_n168_IO_out, c1_n169_IO_out, c1_n170_IO_out, c1_n171_IO_out, c1_n172_IO_out, c1_n173_IO_out, c1_n174_IO_out, c1_n175_IO_out, c1_n176_IO_out, c1_n177_IO_out, c1_n178_IO_out, c1_n179_IO_out, c1_n180_IO_out, c1_n181_IO_out, c1_n182_IO_out, c1_n183_IO_out, c1_n184_IO_out, c1_n185_IO_out, c1_n186_IO_out, c1_n187_IO_out, c1_n188_IO_out, c1_n189_IO_out, c1_n190_IO_out, c1_n191_IO_out, c1_n192_IO_out, c1_n193_IO_out, c1_n194_IO_out, c1_n195_IO_out, c1_n196_IO_out, c1_n197_IO_out, c1_n198_IO_out, c1_n199_IO_out, c1_n200_IO_out, c1_n201_IO_out, c1_n202_IO_out, c1_n203_IO_out, c1_n204_IO_out, c1_n205_IO_out, c1_n206_IO_out, c1_n207_IO_out, c1_n208_IO_out, c1_n209_IO_out, c1_n210_IO_out, c1_n211_IO_out, c1_n212_IO_out, c1_n213_IO_out, c1_n214_IO_out, c1_n215_IO_out, c1_n216_IO_out, c1_n217_IO_out, c1_n218_IO_out, c1_n219_IO_out, c1_n220_IO_out, c1_n221_IO_out, c1_n222_IO_out, c1_n223_IO_out, c1_n224_IO_out, c1_n225_IO_out, c1_n226_IO_out, c1_n227_IO_out, c1_n228_IO_out, c1_n229_IO_out, c1_n230_IO_out, c1_n231_IO_out, c1_n232_IO_out, c1_n233_IO_out, c1_n234_IO_out, c1_n235_IO_out, c1_n236_IO_out, c1_n237_IO_out, c1_n238_IO_out, c1_n239_IO_out, c1_n240_IO_out, c1_n241_IO_out, c1_n242_IO_out, c1_n243_IO_out, c1_n244_IO_out, c1_n245_IO_out, c1_n246_IO_out, c1_n247_IO_out, c1_n248_IO_out, c1_n249_IO_out, c1_n250_IO_out, c1_n251_IO_out, c1_n252_IO_out, c1_n253_IO_out, c1_n254_IO_out, c1_n255_IO_out, c1_n256_IO_out, c1_n257_IO_out, c1_n258_IO_out, c1_n259_IO_out, c1_n260_IO_out, c1_n261_IO_out, c1_n262_IO_out, c1_n263_IO_out, c1_n264_IO_out, c1_n265_IO_out, c1_n266_IO_out, c1_n267_IO_out, c1_n268_IO_out, c1_n269_IO_out, c1_n270_IO_out, c1_n271_IO_out, c1_n272_IO_out, c1_n273_IO_out, c1_n274_IO_out, c1_n275_IO_out, c1_n276_IO_out, c1_n277_IO_out, c1_n278_IO_out, c1_n279_IO_out, c1_n280_IO_out, c1_n281_IO_out, c1_n282_IO_out, c1_n283_IO_out, c1_n284_IO_out, c1_n285_IO_out, c1_n286_IO_out, c1_n287_IO_out, c1_n288_IO_out, c1_n289_IO_out, c1_n290_IO_out, c1_n291_IO_out, c1_n292_IO_out, c1_n293_IO_out, c1_n294_IO_out, c1_n295_IO_out, c1_n296_IO_out, c1_n297_IO_out, c1_n298_IO_out, c1_n299_IO_out: OUT signed(7 DOWNTO 0);
      c1_n0_W_out, c1_n1_W_out, c1_n2_W_out, c1_n3_W_out, c1_n4_W_out, c1_n5_W_out, c1_n6_W_out, c1_n7_W_out, c1_n8_W_out, c1_n9_W_out, c1_n10_W_out, c1_n11_W_out, c1_n12_W_out, c1_n13_W_out, c1_n14_W_out, c1_n15_W_out, c1_n16_W_out, c1_n17_W_out, c1_n18_W_out, c1_n19_W_out, c1_n20_W_out, c1_n21_W_out, c1_n22_W_out, c1_n23_W_out, c1_n24_W_out, c1_n25_W_out, c1_n26_W_out, c1_n27_W_out, c1_n28_W_out, c1_n29_W_out, c1_n30_W_out, c1_n31_W_out, c1_n32_W_out, c1_n33_W_out, c1_n34_W_out, c1_n35_W_out, c1_n36_W_out, c1_n37_W_out, c1_n38_W_out, c1_n39_W_out, c1_n40_W_out, c1_n41_W_out, c1_n42_W_out, c1_n43_W_out, c1_n44_W_out, c1_n45_W_out, c1_n46_W_out, c1_n47_W_out, c1_n48_W_out, c1_n49_W_out, c1_n50_W_out, c1_n51_W_out, c1_n52_W_out, c1_n53_W_out, c1_n54_W_out, c1_n55_W_out, c1_n56_W_out, c1_n57_W_out, c1_n58_W_out, c1_n59_W_out, c1_n60_W_out, c1_n61_W_out, c1_n62_W_out, c1_n63_W_out, c1_n64_W_out, c1_n65_W_out, c1_n66_W_out, c1_n67_W_out, c1_n68_W_out, c1_n69_W_out, c1_n70_W_out, c1_n71_W_out, c1_n72_W_out, c1_n73_W_out, c1_n74_W_out, c1_n75_W_out, c1_n76_W_out, c1_n77_W_out, c1_n78_W_out, c1_n79_W_out, c1_n80_W_out, c1_n81_W_out, c1_n82_W_out, c1_n83_W_out, c1_n84_W_out, c1_n85_W_out, c1_n86_W_out, c1_n87_W_out, c1_n88_W_out, c1_n89_W_out, c1_n90_W_out, c1_n91_W_out, c1_n92_W_out, c1_n93_W_out, c1_n94_W_out, c1_n95_W_out, c1_n96_W_out, c1_n97_W_out, c1_n98_W_out, c1_n99_W_out, c1_n100_W_out, c1_n101_W_out, c1_n102_W_out, c1_n103_W_out, c1_n104_W_out, c1_n105_W_out, c1_n106_W_out, c1_n107_W_out, c1_n108_W_out, c1_n109_W_out, c1_n110_W_out, c1_n111_W_out, c1_n112_W_out, c1_n113_W_out, c1_n114_W_out, c1_n115_W_out, c1_n116_W_out, c1_n117_W_out, c1_n118_W_out, c1_n119_W_out, c1_n120_W_out, c1_n121_W_out, c1_n122_W_out, c1_n123_W_out, c1_n124_W_out, c1_n125_W_out, c1_n126_W_out, c1_n127_W_out, c1_n128_W_out, c1_n129_W_out, c1_n130_W_out, c1_n131_W_out, c1_n132_W_out, c1_n133_W_out, c1_n134_W_out, c1_n135_W_out, c1_n136_W_out, c1_n137_W_out, c1_n138_W_out, c1_n139_W_out, c1_n140_W_out, c1_n141_W_out, c1_n142_W_out, c1_n143_W_out, c1_n144_W_out, c1_n145_W_out, c1_n146_W_out, c1_n147_W_out, c1_n148_W_out, c1_n149_W_out, c1_n150_W_out, c1_n151_W_out, c1_n152_W_out, c1_n153_W_out, c1_n154_W_out, c1_n155_W_out, c1_n156_W_out, c1_n157_W_out, c1_n158_W_out, c1_n159_W_out, c1_n160_W_out, c1_n161_W_out, c1_n162_W_out, c1_n163_W_out, c1_n164_W_out, c1_n165_W_out, c1_n166_W_out, c1_n167_W_out, c1_n168_W_out, c1_n169_W_out, c1_n170_W_out, c1_n171_W_out, c1_n172_W_out, c1_n173_W_out, c1_n174_W_out, c1_n175_W_out, c1_n176_W_out, c1_n177_W_out, c1_n178_W_out, c1_n179_W_out, c1_n180_W_out, c1_n181_W_out, c1_n182_W_out, c1_n183_W_out, c1_n184_W_out, c1_n185_W_out, c1_n186_W_out, c1_n187_W_out, c1_n188_W_out, c1_n189_W_out, c1_n190_W_out, c1_n191_W_out, c1_n192_W_out, c1_n193_W_out, c1_n194_W_out, c1_n195_W_out, c1_n196_W_out, c1_n197_W_out, c1_n198_W_out, c1_n199_W_out, c1_n200_W_out, c1_n201_W_out, c1_n202_W_out, c1_n203_W_out, c1_n204_W_out, c1_n205_W_out, c1_n206_W_out, c1_n207_W_out, c1_n208_W_out, c1_n209_W_out, c1_n210_W_out, c1_n211_W_out, c1_n212_W_out, c1_n213_W_out, c1_n214_W_out, c1_n215_W_out, c1_n216_W_out, c1_n217_W_out, c1_n218_W_out, c1_n219_W_out, c1_n220_W_out, c1_n221_W_out, c1_n222_W_out, c1_n223_W_out, c1_n224_W_out, c1_n225_W_out, c1_n226_W_out, c1_n227_W_out, c1_n228_W_out, c1_n229_W_out, c1_n230_W_out, c1_n231_W_out, c1_n232_W_out, c1_n233_W_out, c1_n234_W_out, c1_n235_W_out, c1_n236_W_out, c1_n237_W_out, c1_n238_W_out, c1_n239_W_out, c1_n240_W_out, c1_n241_W_out, c1_n242_W_out, c1_n243_W_out, c1_n244_W_out, c1_n245_W_out, c1_n246_W_out, c1_n247_W_out, c1_n248_W_out, c1_n249_W_out, c1_n250_W_out, c1_n251_W_out, c1_n252_W_out, c1_n253_W_out, c1_n254_W_out, c1_n255_W_out, c1_n256_W_out, c1_n257_W_out, c1_n258_W_out, c1_n259_W_out, c1_n260_W_out, c1_n261_W_out, c1_n262_W_out, c1_n263_W_out, c1_n264_W_out, c1_n265_W_out, c1_n266_W_out, c1_n267_W_out, c1_n268_W_out, c1_n269_W_out, c1_n270_W_out, c1_n271_W_out, c1_n272_W_out, c1_n273_W_out, c1_n274_W_out, c1_n275_W_out, c1_n276_W_out, c1_n277_W_out, c1_n278_W_out, c1_n279_W_out, c1_n280_W_out, c1_n281_W_out, c1_n282_W_out, c1_n283_W_out, c1_n284_W_out, c1_n285_W_out, c1_n286_W_out, c1_n287_W_out, c1_n288_W_out, c1_n289_W_out, c1_n290_W_out, c1_n291_W_out, c1_n292_W_out, c1_n293_W_out, c1_n294_W_out, c1_n295_W_out, c1_n296_W_out, c1_n297_W_out, c1_n298_W_out, c1_n299_W_out: OUT signed(BITS - 1 DOWNTO 0)
  );
  end ENTITY;

ARCHITECTURE arch OF  camada1_ReLU_300neuron_8bits_500n_signed  IS 
BEGIN

neuron_inst_0: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n0_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n0_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n0_W_out
   );
            
neuron_inst_1: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n1_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n1_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n1_W_out
   );
            
neuron_inst_2: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n2_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n2_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n2_W_out
   );
            
neuron_inst_3: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n3_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n3_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n3_W_out
   );
            
neuron_inst_4: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n4_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n4_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n4_W_out
   );
            
neuron_inst_5: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n5_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n5_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n5_W_out
   );
            
neuron_inst_6: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n6_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n6_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n6_W_out
   );
            
neuron_inst_7: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n7_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n7_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n7_W_out
   );
            
neuron_inst_8: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n8_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n8_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n8_W_out
   );
            
neuron_inst_9: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n9_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n9_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n9_W_out
   );
            
neuron_inst_10: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n10_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n10_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n10_W_out
   );
            
neuron_inst_11: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n11_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n11_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n11_W_out
   );
            
neuron_inst_12: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n12_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n12_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n12_W_out
   );
            
neuron_inst_13: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n13_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n13_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n13_W_out
   );
            
neuron_inst_14: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n14_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n14_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n14_W_out
   );
            
neuron_inst_15: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n15_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n15_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n15_W_out
   );
            
neuron_inst_16: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n16_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n16_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n16_W_out
   );
            
neuron_inst_17: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n17_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n17_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n17_W_out
   );
            
neuron_inst_18: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n18_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n18_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n18_W_out
   );
            
neuron_inst_19: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n19_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n19_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n19_W_out
   );
            
neuron_inst_20: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n20_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n20_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n20_W_out
   );
            
neuron_inst_21: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n21_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n21_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n21_W_out
   );
            
neuron_inst_22: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n22_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n22_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n22_W_out
   );
            
neuron_inst_23: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n23_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n23_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n23_W_out
   );
            
neuron_inst_24: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n24_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n24_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n24_W_out
   );
            
neuron_inst_25: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n25_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n25_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n25_W_out
   );
            
neuron_inst_26: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n26_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n26_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n26_W_out
   );
            
neuron_inst_27: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n27_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n27_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n27_W_out
   );
            
neuron_inst_28: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n28_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n28_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n28_W_out
   );
            
neuron_inst_29: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n29_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n29_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n29_W_out
   );
            
neuron_inst_30: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n30_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n30_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n30_W_out
   );
            
neuron_inst_31: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n31_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n31_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n31_W_out
   );
            
neuron_inst_32: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n32_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n32_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n32_W_out
   );
            
neuron_inst_33: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n33_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n33_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n33_W_out
   );
            
neuron_inst_34: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n34_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n34_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n34_W_out
   );
            
neuron_inst_35: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n35_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n35_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n35_W_out
   );
            
neuron_inst_36: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n36_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n36_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n36_W_out
   );
            
neuron_inst_37: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n37_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n37_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n37_W_out
   );
            
neuron_inst_38: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n38_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n38_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n38_W_out
   );
            
neuron_inst_39: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n39_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n39_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n39_W_out
   );
            
neuron_inst_40: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n40_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n40_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n40_W_out
   );
            
neuron_inst_41: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n41_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n41_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n41_W_out
   );
            
neuron_inst_42: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n42_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n42_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n42_W_out
   );
            
neuron_inst_43: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n43_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n43_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n43_W_out
   );
            
neuron_inst_44: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n44_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n44_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n44_W_out
   );
            
neuron_inst_45: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n45_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n45_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n45_W_out
   );
            
neuron_inst_46: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n46_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n46_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n46_W_out
   );
            
neuron_inst_47: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n47_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n47_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n47_W_out
   );
            
neuron_inst_48: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n48_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n48_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n48_W_out
   );
            
neuron_inst_49: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n49_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n49_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n49_W_out
   );
            
neuron_inst_50: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n50_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n50_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n50_W_out
   );
            
neuron_inst_51: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n51_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n51_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n51_W_out
   );
            
neuron_inst_52: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n52_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n52_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n52_W_out
   );
            
neuron_inst_53: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n53_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n53_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n53_W_out
   );
            
neuron_inst_54: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n54_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n54_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n54_W_out
   );
            
neuron_inst_55: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n55_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n55_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n55_W_out
   );
            
neuron_inst_56: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n56_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n56_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n56_W_out
   );
            
neuron_inst_57: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n57_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n57_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n57_W_out
   );
            
neuron_inst_58: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n58_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n58_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n58_W_out
   );
            
neuron_inst_59: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n59_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n59_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n59_W_out
   );
            
neuron_inst_60: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n60_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n60_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n60_W_out
   );
            
neuron_inst_61: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n61_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n61_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n61_W_out
   );
            
neuron_inst_62: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n62_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n62_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n62_W_out
   );
            
neuron_inst_63: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n63_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n63_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n63_W_out
   );
            
neuron_inst_64: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n64_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n64_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n64_W_out
   );
            
neuron_inst_65: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n65_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n65_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n65_W_out
   );
            
neuron_inst_66: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n66_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n66_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n66_W_out
   );
            
neuron_inst_67: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n67_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n67_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n67_W_out
   );
            
neuron_inst_68: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n68_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n68_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n68_W_out
   );
            
neuron_inst_69: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n69_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n69_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n69_W_out
   );
            
neuron_inst_70: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n70_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n70_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n70_W_out
   );
            
neuron_inst_71: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n71_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n71_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n71_W_out
   );
            
neuron_inst_72: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n72_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n72_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n72_W_out
   );
            
neuron_inst_73: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n73_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n73_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n73_W_out
   );
            
neuron_inst_74: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n74_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n74_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n74_W_out
   );
            
neuron_inst_75: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n75_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n75_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n75_W_out
   );
            
neuron_inst_76: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n76_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n76_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n76_W_out
   );
            
neuron_inst_77: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n77_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n77_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n77_W_out
   );
            
neuron_inst_78: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n78_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n78_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n78_W_out
   );
            
neuron_inst_79: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n79_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n79_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n79_W_out
   );
            
neuron_inst_80: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n80_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n80_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n80_W_out
   );
            
neuron_inst_81: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n81_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n81_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n81_W_out
   );
            
neuron_inst_82: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n82_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n82_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n82_W_out
   );
            
neuron_inst_83: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n83_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n83_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n83_W_out
   );
            
neuron_inst_84: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n84_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n84_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n84_W_out
   );
            
neuron_inst_85: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n85_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n85_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n85_W_out
   );
            
neuron_inst_86: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n86_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n86_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n86_W_out
   );
            
neuron_inst_87: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n87_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n87_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n87_W_out
   );
            
neuron_inst_88: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n88_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n88_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n88_W_out
   );
            
neuron_inst_89: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n89_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n89_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n89_W_out
   );
            
neuron_inst_90: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n90_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n90_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n90_W_out
   );
            
neuron_inst_91: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n91_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n91_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n91_W_out
   );
            
neuron_inst_92: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n92_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n92_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n92_W_out
   );
            
neuron_inst_93: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n93_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n93_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n93_W_out
   );
            
neuron_inst_94: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n94_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n94_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n94_W_out
   );
            
neuron_inst_95: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n95_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n95_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n95_W_out
   );
            
neuron_inst_96: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n96_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n96_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n96_W_out
   );
            
neuron_inst_97: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n97_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n97_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n97_W_out
   );
            
neuron_inst_98: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n98_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n98_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n98_W_out
   );
            
neuron_inst_99: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n99_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n99_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n99_W_out
   );
            
neuron_inst_100: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n100_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n100_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n100_W_out
   );
            
neuron_inst_101: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n101_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n101_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n101_W_out
   );
            
neuron_inst_102: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n102_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n102_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n102_W_out
   );
            
neuron_inst_103: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n103_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n103_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n103_W_out
   );
            
neuron_inst_104: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n104_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n104_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n104_W_out
   );
            
neuron_inst_105: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n105_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n105_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n105_W_out
   );
            
neuron_inst_106: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n106_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n106_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n106_W_out
   );
            
neuron_inst_107: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n107_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n107_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n107_W_out
   );
            
neuron_inst_108: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n108_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n108_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n108_W_out
   );
            
neuron_inst_109: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n109_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n109_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n109_W_out
   );
            
neuron_inst_110: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n110_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n110_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n110_W_out
   );
            
neuron_inst_111: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n111_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n111_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n111_W_out
   );
            
neuron_inst_112: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n112_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n112_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n112_W_out
   );
            
neuron_inst_113: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n113_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n113_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n113_W_out
   );
            
neuron_inst_114: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n114_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n114_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n114_W_out
   );
            
neuron_inst_115: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n115_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n115_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n115_W_out
   );
            
neuron_inst_116: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n116_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n116_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n116_W_out
   );
            
neuron_inst_117: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n117_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n117_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n117_W_out
   );
            
neuron_inst_118: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n118_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n118_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n118_W_out
   );
            
neuron_inst_119: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n119_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n119_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n119_W_out
   );
            
neuron_inst_120: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n120_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n120_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n120_W_out
   );
            
neuron_inst_121: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n121_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n121_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n121_W_out
   );
            
neuron_inst_122: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n122_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n122_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n122_W_out
   );
            
neuron_inst_123: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n123_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n123_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n123_W_out
   );
            
neuron_inst_124: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n124_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n124_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n124_W_out
   );
            
neuron_inst_125: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n125_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n125_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n125_W_out
   );
            
neuron_inst_126: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n126_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n126_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n126_W_out
   );
            
neuron_inst_127: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n127_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n127_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n127_W_out
   );
            
neuron_inst_128: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n128_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n128_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n128_W_out
   );
            
neuron_inst_129: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n129_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n129_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n129_W_out
   );
            
neuron_inst_130: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n130_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n130_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n130_W_out
   );
            
neuron_inst_131: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n131_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n131_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n131_W_out
   );
            
neuron_inst_132: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n132_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n132_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n132_W_out
   );
            
neuron_inst_133: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n133_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n133_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n133_W_out
   );
            
neuron_inst_134: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n134_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n134_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n134_W_out
   );
            
neuron_inst_135: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n135_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n135_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n135_W_out
   );
            
neuron_inst_136: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n136_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n136_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n136_W_out
   );
            
neuron_inst_137: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n137_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n137_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n137_W_out
   );
            
neuron_inst_138: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n138_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n138_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n138_W_out
   );
            
neuron_inst_139: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n139_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n139_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n139_W_out
   );
            
neuron_inst_140: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n140_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n140_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n140_W_out
   );
            
neuron_inst_141: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n141_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n141_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n141_W_out
   );
            
neuron_inst_142: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n142_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n142_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n142_W_out
   );
            
neuron_inst_143: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n143_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n143_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n143_W_out
   );
            
neuron_inst_144: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n144_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n144_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n144_W_out
   );
            
neuron_inst_145: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n145_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n145_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n145_W_out
   );
            
neuron_inst_146: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n146_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n146_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n146_W_out
   );
            
neuron_inst_147: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n147_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n147_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n147_W_out
   );
            
neuron_inst_148: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n148_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n148_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n148_W_out
   );
            
neuron_inst_149: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n149_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n149_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n149_W_out
   );
            
neuron_inst_150: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n150_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n150_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n150_W_out
   );
            
neuron_inst_151: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n151_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n151_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n151_W_out
   );
            
neuron_inst_152: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n152_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n152_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n152_W_out
   );
            
neuron_inst_153: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n153_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n153_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n153_W_out
   );
            
neuron_inst_154: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n154_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n154_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n154_W_out
   );
            
neuron_inst_155: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n155_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n155_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n155_W_out
   );
            
neuron_inst_156: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n156_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n156_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n156_W_out
   );
            
neuron_inst_157: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n157_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n157_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n157_W_out
   );
            
neuron_inst_158: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n158_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n158_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n158_W_out
   );
            
neuron_inst_159: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n159_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n159_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n159_W_out
   );
            
neuron_inst_160: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n160_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n160_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n160_W_out
   );
            
neuron_inst_161: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n161_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n161_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n161_W_out
   );
            
neuron_inst_162: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n162_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n162_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n162_W_out
   );
            
neuron_inst_163: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n163_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n163_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n163_W_out
   );
            
neuron_inst_164: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n164_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n164_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n164_W_out
   );
            
neuron_inst_165: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n165_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n165_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n165_W_out
   );
            
neuron_inst_166: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n166_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n166_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n166_W_out
   );
            
neuron_inst_167: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n167_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n167_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n167_W_out
   );
            
neuron_inst_168: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n168_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n168_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n168_W_out
   );
            
neuron_inst_169: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n169_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n169_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n169_W_out
   );
            
neuron_inst_170: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n170_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n170_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n170_W_out
   );
            
neuron_inst_171: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n171_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n171_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n171_W_out
   );
            
neuron_inst_172: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n172_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n172_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n172_W_out
   );
            
neuron_inst_173: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n173_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n173_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n173_W_out
   );
            
neuron_inst_174: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n174_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n174_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n174_W_out
   );
            
neuron_inst_175: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n175_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n175_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n175_W_out
   );
            
neuron_inst_176: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n176_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n176_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n176_W_out
   );
            
neuron_inst_177: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n177_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n177_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n177_W_out
   );
            
neuron_inst_178: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n178_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n178_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n178_W_out
   );
            
neuron_inst_179: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n179_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n179_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n179_W_out
   );
            
neuron_inst_180: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n180_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n180_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n180_W_out
   );
            
neuron_inst_181: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n181_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n181_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n181_W_out
   );
            
neuron_inst_182: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n182_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n182_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n182_W_out
   );
            
neuron_inst_183: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n183_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n183_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n183_W_out
   );
            
neuron_inst_184: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n184_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n184_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n184_W_out
   );
            
neuron_inst_185: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n185_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n185_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n185_W_out
   );
            
neuron_inst_186: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n186_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n186_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n186_W_out
   );
            
neuron_inst_187: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n187_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n187_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n187_W_out
   );
            
neuron_inst_188: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n188_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n188_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n188_W_out
   );
            
neuron_inst_189: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n189_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n189_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n189_W_out
   );
            
neuron_inst_190: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n190_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n190_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n190_W_out
   );
            
neuron_inst_191: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n191_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n191_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n191_W_out
   );
            
neuron_inst_192: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n192_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n192_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n192_W_out
   );
            
neuron_inst_193: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n193_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n193_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n193_W_out
   );
            
neuron_inst_194: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n194_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n194_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n194_W_out
   );
            
neuron_inst_195: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n195_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n195_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n195_W_out
   );
            
neuron_inst_196: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n196_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n196_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n196_W_out
   );
            
neuron_inst_197: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n197_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n197_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n197_W_out
   );
            
neuron_inst_198: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n198_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n198_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n198_W_out
   );
            
neuron_inst_199: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n199_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n199_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n199_W_out
   );
            
neuron_inst_200: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n200_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n200_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n200_W_out
   );
            
neuron_inst_201: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n201_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n201_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n201_W_out
   );
            
neuron_inst_202: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n202_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n202_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n202_W_out
   );
            
neuron_inst_203: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n203_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n203_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n203_W_out
   );
            
neuron_inst_204: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n204_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n204_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n204_W_out
   );
            
neuron_inst_205: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n205_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n205_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n205_W_out
   );
            
neuron_inst_206: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n206_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n206_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n206_W_out
   );
            
neuron_inst_207: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n207_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n207_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n207_W_out
   );
            
neuron_inst_208: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n208_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n208_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n208_W_out
   );
            
neuron_inst_209: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n209_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n209_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n209_W_out
   );
            
neuron_inst_210: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n210_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n210_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n210_W_out
   );
            
neuron_inst_211: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n211_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n211_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n211_W_out
   );
            
neuron_inst_212: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n212_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n212_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n212_W_out
   );
            
neuron_inst_213: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n213_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n213_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n213_W_out
   );
            
neuron_inst_214: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n214_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n214_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n214_W_out
   );
            
neuron_inst_215: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n215_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n215_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n215_W_out
   );
            
neuron_inst_216: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n216_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n216_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n216_W_out
   );
            
neuron_inst_217: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n217_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n217_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n217_W_out
   );
            
neuron_inst_218: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n218_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n218_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n218_W_out
   );
            
neuron_inst_219: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n219_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n219_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n219_W_out
   );
            
neuron_inst_220: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n220_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n220_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n220_W_out
   );
            
neuron_inst_221: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n221_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n221_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n221_W_out
   );
            
neuron_inst_222: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n222_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n222_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n222_W_out
   );
            
neuron_inst_223: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n223_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n223_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n223_W_out
   );
            
neuron_inst_224: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n224_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n224_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n224_W_out
   );
            
neuron_inst_225: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n225_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n225_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n225_W_out
   );
            
neuron_inst_226: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n226_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n226_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n226_W_out
   );
            
neuron_inst_227: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n227_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n227_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n227_W_out
   );
            
neuron_inst_228: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n228_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n228_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n228_W_out
   );
            
neuron_inst_229: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n229_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n229_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n229_W_out
   );
            
neuron_inst_230: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n230_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n230_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n230_W_out
   );
            
neuron_inst_231: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n231_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n231_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n231_W_out
   );
            
neuron_inst_232: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n232_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n232_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n232_W_out
   );
            
neuron_inst_233: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n233_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n233_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n233_W_out
   );
            
neuron_inst_234: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n234_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n234_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n234_W_out
   );
            
neuron_inst_235: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n235_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n235_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n235_W_out
   );
            
neuron_inst_236: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n236_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n236_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n236_W_out
   );
            
neuron_inst_237: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n237_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n237_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n237_W_out
   );
            
neuron_inst_238: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n238_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n238_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n238_W_out
   );
            
neuron_inst_239: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n239_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n239_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n239_W_out
   );
            
neuron_inst_240: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n240_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n240_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n240_W_out
   );
            
neuron_inst_241: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n241_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n241_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n241_W_out
   );
            
neuron_inst_242: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n242_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n242_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n242_W_out
   );
            
neuron_inst_243: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n243_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n243_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n243_W_out
   );
            
neuron_inst_244: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n244_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n244_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n244_W_out
   );
            
neuron_inst_245: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n245_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n245_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n245_W_out
   );
            
neuron_inst_246: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n246_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n246_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n246_W_out
   );
            
neuron_inst_247: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n247_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n247_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n247_W_out
   );
            
neuron_inst_248: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n248_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n248_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n248_W_out
   );
            
neuron_inst_249: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n249_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n249_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n249_W_out
   );
            
neuron_inst_250: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n250_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n250_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n250_W_out
   );
            
neuron_inst_251: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n251_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n251_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n251_W_out
   );
            
neuron_inst_252: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n252_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n252_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n252_W_out
   );
            
neuron_inst_253: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n253_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n253_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n253_W_out
   );
            
neuron_inst_254: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n254_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n254_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n254_W_out
   );
            
neuron_inst_255: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n255_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n255_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n255_W_out
   );
            
neuron_inst_256: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n256_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n256_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n256_W_out
   );
            
neuron_inst_257: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n257_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n257_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n257_W_out
   );
            
neuron_inst_258: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n258_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n258_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n258_W_out
   );
            
neuron_inst_259: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n259_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n259_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n259_W_out
   );
            
neuron_inst_260: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n260_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n260_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n260_W_out
   );
            
neuron_inst_261: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n261_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n261_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n261_W_out
   );
            
neuron_inst_262: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n262_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n262_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n262_W_out
   );
            
neuron_inst_263: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n263_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n263_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n263_W_out
   );
            
neuron_inst_264: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n264_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n264_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n264_W_out
   );
            
neuron_inst_265: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n265_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n265_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n265_W_out
   );
            
neuron_inst_266: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n266_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n266_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n266_W_out
   );
            
neuron_inst_267: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n267_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n267_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n267_W_out
   );
            
neuron_inst_268: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n268_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n268_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n268_W_out
   );
            
neuron_inst_269: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n269_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n269_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n269_W_out
   );
            
neuron_inst_270: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n270_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n270_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n270_W_out
   );
            
neuron_inst_271: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n271_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n271_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n271_W_out
   );
            
neuron_inst_272: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n272_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n272_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n272_W_out
   );
            
neuron_inst_273: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n273_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n273_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n273_W_out
   );
            
neuron_inst_274: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n274_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n274_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n274_W_out
   );
            
neuron_inst_275: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n275_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n275_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n275_W_out
   );
            
neuron_inst_276: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n276_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n276_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n276_W_out
   );
            
neuron_inst_277: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n277_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n277_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n277_W_out
   );
            
neuron_inst_278: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n278_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n278_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n278_W_out
   );
            
neuron_inst_279: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n279_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n279_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n279_W_out
   );
            
neuron_inst_280: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n280_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n280_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n280_W_out
   );
            
neuron_inst_281: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n281_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n281_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n281_W_out
   );
            
neuron_inst_282: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n282_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n282_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n282_W_out
   );
            
neuron_inst_283: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n283_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n283_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n283_W_out
   );
            
neuron_inst_284: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n284_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n284_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n284_W_out
   );
            
neuron_inst_285: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n285_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n285_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n285_W_out
   );
            
neuron_inst_286: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n286_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n286_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n286_W_out
   );
            
neuron_inst_287: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n287_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n287_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n287_W_out
   );
            
neuron_inst_288: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n288_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n288_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n288_W_out
   );
            
neuron_inst_289: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n289_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n289_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n289_W_out
   );
            
neuron_inst_290: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n290_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n290_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n290_W_out
   );
            
neuron_inst_291: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n291_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n291_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n291_W_out
   );
            
neuron_inst_292: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n292_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n292_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n292_W_out
   );
            
neuron_inst_293: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n293_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n293_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n293_W_out
   );
            
neuron_inst_294: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n294_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n294_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n294_W_out
   );
            
neuron_inst_295: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n295_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n295_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n295_W_out
   );
            
neuron_inst_296: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n296_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n296_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n296_W_out
   );
            
neuron_inst_297: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n297_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n297_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n297_W_out
   );
            
neuron_inst_298: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n298_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n298_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n298_W_out
   );
            
neuron_inst_299: ENTITY work.neuron_ReLU_500n_out
   PORT MAP (
            ---------- Entradas ----------
            -- ['IN']['STD_LOGIC'] 
            clk=> clk, 
            rst=> rst, 
            update_weights=> update_weights, 
            -- ['IN']['manual'] 
            IO_in=> IO_in, 
            W_in=> c1_n299_W_in, 
            ---------- Saidas ----------
            -- ['OUT']['SIGNED'] 
            IO_out=> c1_n299_IO_out, 
            -- ['OUT']['manual'] 
            W_out=> c1_n299_W_out
   );
             
END ARCHITECTURE;

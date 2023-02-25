LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.parameters.ALL;

ENTITY top IS
  GENERIC (
    BITS       : NATURAL := BITS;
    NUM_INPUTS : NATURAL := 10;
    TOTAL_BITS : NATURAL := 80
  );
  PORT (
    clk, rst, update_weights                                                                                                                                                                                                                                                                                                                                                                                             : IN STD_LOGIC;
    IO_in                                                                                                                                                                                                                                                                                                                                                                                                                : IN signed(TOTAL_BITS - 1 DOWNTO 0);
    c0_n0_W_in, c0_n1_W_in, c0_n2_W_in, c0_n3_W_in, c0_n4_W_in, c0_n5_W_in, c0_n6_W_in, c0_n7_W_in, c0_n8_W_in, c0_n9_W_in, c0_n10_W_in, c0_n11_W_in, c0_n12_W_in, c0_n13_W_in, c0_n14_W_in, c0_n15_W_in, c0_n16_W_in, c0_n17_W_in, c0_n18_W_in, c0_n19_W_in, c0_n20_W_in, c0_n21_W_in, c0_n22_W_in, c0_n23_W_in, c0_n24_W_in, c0_n25_W_in, c0_n26_W_in, c0_n27_W_in, c0_n28_W_in, c0_n29_W_in, c0_n30_W_in, c0_n31_W_in : IN signed(BITS - 1 DOWNTO 0);
    ----------------------------------------------
    c3_n0_IO_out, c3_n1_IO_out, c3_n2_IO_out                                                                                                                                                                                                                                                                                                                                                                             : OUT signed(7 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE arch OF top IS
  -- SIGNALS
  SIGNAL c0_n0_W_out, c0_n1_W_out, c0_n2_W_out, c0_n3_W_out, c0_n4_W_out, c0_n5_W_out, c0_n6_W_out, c0_n7_W_out, c0_n8_W_out, c0_n9_W_out, c0_n10_W_out, c0_n11_W_out, c0_n12_W_out, c0_n13_W_out, c0_n14_W_out, c0_n15_W_out, c0_n16_W_out, c0_n17_W_out, c0_n18_W_out, c0_n19_W_out, c0_n20_W_out, c0_n21_W_out, c0_n22_W_out, c0_n23_W_out, c0_n24_W_out, c0_n25_W_out, c0_n26_W_out, c0_n27_W_out, c0_n28_W_out, c0_n29_W_out, c0_n30_W_out, c0_n31_W_out, c1_n0_W_out, c1_n1_W_out, c1_n2_W_out, c1_n3_W_out, c1_n4_W_out, c1_n5_W_out, c1_n6_W_out, c1_n7_W_out, c1_n8_W_out, c1_n9_W_out, c1_n10_W_out, c1_n11_W_out, c1_n12_W_out, c1_n13_W_out, c1_n14_W_out, c1_n15_W_out, c1_n16_W_out, c1_n17_W_out, c1_n18_W_out, c1_n19_W_out, c1_n20_W_out, c1_n21_W_out, c1_n22_W_out, c1_n23_W_out, c1_n24_W_out, c1_n25_W_out, c1_n26_W_out, c1_n27_W_out, c1_n28_W_out, c1_n29_W_out, c1_n30_W_out, c1_n31_W_out, c2_n0_W_out, c2_n1_W_out, c2_n2_W_out                                    : signed(BITS - 1 DOWNTO 0);
  SIGNAL c1_IO_in                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             : signed((BITS * 32) - 1 DOWNTO 0);
  SIGNAL c2_IO_in                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             : signed((BITS * 64) - 1 DOWNTO 0);
  SIGNAL c3_IO_in                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             : signed((BITS * 32) - 1 DOWNTO 0);
  SIGNAL c0_n0_IO_out, c0_n1_IO_out, c0_n2_IO_out, c0_n3_IO_out, c0_n4_IO_out, c0_n5_IO_out, c0_n6_IO_out, c0_n7_IO_out, c0_n8_IO_out, c0_n9_IO_out, c0_n10_IO_out, c0_n11_IO_out, c0_n12_IO_out, c0_n13_IO_out, c0_n14_IO_out, c0_n15_IO_out, c0_n16_IO_out, c0_n17_IO_out, c0_n18_IO_out, c0_n19_IO_out, c0_n20_IO_out, c0_n21_IO_out, c0_n22_IO_out, c0_n23_IO_out, c0_n24_IO_out, c0_n25_IO_out, c0_n26_IO_out, c0_n27_IO_out, c0_n28_IO_out, c0_n29_IO_out, c0_n30_IO_out, c0_n31_IO_out                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 : SIGNED(BITS - 1 DOWNTO 0);
  SIGNAL c1_n0_IO_out, c1_n1_IO_out, c1_n2_IO_out, c1_n3_IO_out, c1_n4_IO_out, c1_n5_IO_out, c1_n6_IO_out, c1_n7_IO_out, c1_n8_IO_out, c1_n9_IO_out, c1_n10_IO_out, c1_n11_IO_out, c1_n12_IO_out, c1_n13_IO_out, c1_n14_IO_out, c1_n15_IO_out, c1_n16_IO_out, c1_n17_IO_out, c1_n18_IO_out, c1_n19_IO_out, c1_n20_IO_out, c1_n21_IO_out, c1_n22_IO_out, c1_n23_IO_out, c1_n24_IO_out, c1_n25_IO_out, c1_n26_IO_out, c1_n27_IO_out, c1_n28_IO_out, c1_n29_IO_out, c1_n30_IO_out, c1_n31_IO_out, c1_n32_IO_out, c1_n33_IO_out, c1_n34_IO_out, c1_n35_IO_out, c1_n36_IO_out, c1_n37_IO_out, c1_n38_IO_out, c1_n39_IO_out, c1_n40_IO_out, c1_n41_IO_out, c1_n42_IO_out, c1_n43_IO_out, c1_n44_IO_out, c1_n45_IO_out, c1_n46_IO_out, c1_n47_IO_out, c1_n48_IO_out, c1_n49_IO_out, c1_n50_IO_out, c1_n51_IO_out, c1_n52_IO_out, c1_n53_IO_out, c1_n54_IO_out, c1_n55_IO_out, c1_n56_IO_out, c1_n57_IO_out, c1_n58_IO_out, c1_n59_IO_out, c1_n60_IO_out, c1_n61_IO_out, c1_n62_IO_out, c1_n63_IO_out : SIGNED(BITS - 1 DOWNTO 0);
  SIGNAL c2_n0_IO_out, c2_n1_IO_out, c2_n2_IO_out, c2_n3_IO_out, c2_n4_IO_out, c2_n5_IO_out, c2_n6_IO_out, c2_n7_IO_out, c2_n8_IO_out, c2_n9_IO_out, c2_n10_IO_out, c2_n11_IO_out, c2_n12_IO_out, c2_n13_IO_out, c2_n14_IO_out, c2_n15_IO_out, c2_n16_IO_out, c2_n17_IO_out, c2_n18_IO_out, c2_n19_IO_out, c2_n20_IO_out, c2_n21_IO_out, c2_n22_IO_out, c2_n23_IO_out, c2_n24_IO_out, c2_n25_IO_out, c2_n26_IO_out, c2_n27_IO_out, c2_n28_IO_out, c2_n29_IO_out, c2_n30_IO_out, c2_n31_IO_out                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 : SIGNED(BITS - 1 DOWNTO 0);
  SIGNAL reg_IO_in                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            : signed(TOTAL_BITS - 1 DOWNTO 0);
  SIGNAL en_registers                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         : STD_LOGIC;
BEGIN
  en_registers <= update_weights AND clk;
  c1_IO_in     <= c0_n0_IO_out & c0_n1_IO_out & c0_n2_IO_out & c0_n3_IO_out & c0_n4_IO_out & c0_n5_IO_out & c0_n6_IO_out & c0_n7_IO_out & c0_n8_IO_out & c0_n9_IO_out & c0_n10_IO_out & c0_n11_IO_out & c0_n12_IO_out & c0_n13_IO_out & c0_n14_IO_out & c0_n15_IO_out & c0_n16_IO_out & c0_n17_IO_out & c0_n18_IO_out & c0_n19_IO_out & c0_n20_IO_out & c0_n21_IO_out & c0_n22_IO_out & c0_n23_IO_out & c0_n24_IO_out & c0_n25_IO_out & c0_n26_IO_out & c0_n27_IO_out & c0_n28_IO_out & c0_n29_IO_out & c0_n30_IO_out & c0_n31_IO_out;
  c2_IO_in     <= c1_n0_IO_out & c1_n1_IO_out & c1_n2_IO_out & c1_n3_IO_out & c1_n4_IO_out & c1_n5_IO_out & c1_n6_IO_out & c1_n7_IO_out & c1_n8_IO_out & c1_n9_IO_out & c1_n10_IO_out & c1_n11_IO_out & c1_n12_IO_out & c1_n13_IO_out & c1_n14_IO_out & c1_n15_IO_out & c1_n16_IO_out & c1_n17_IO_out & c1_n18_IO_out & c1_n19_IO_out & c1_n20_IO_out & c1_n21_IO_out & c1_n22_IO_out & c1_n23_IO_out & c1_n24_IO_out & c1_n25_IO_out & c1_n26_IO_out & c1_n27_IO_out & c1_n28_IO_out & c1_n29_IO_out & c1_n30_IO_out & c1_n31_IO_out & c1_n32_IO_out & c1_n33_IO_out & c1_n34_IO_out & c1_n35_IO_out & c1_n36_IO_out & c1_n37_IO_out & c1_n38_IO_out & c1_n39_IO_out & c1_n40_IO_out & c1_n41_IO_out & c1_n42_IO_out & c1_n43_IO_out & c1_n44_IO_out & c1_n45_IO_out & c1_n46_IO_out & c1_n47_IO_out & c1_n48_IO_out & c1_n49_IO_out & c1_n50_IO_out & c1_n51_IO_out & c1_n52_IO_out & c1_n53_IO_out & c1_n54_IO_out & c1_n55_IO_out & c1_n56_IO_out & c1_n57_IO_out & c1_n58_IO_out & c1_n59_IO_out & c1_n60_IO_out & c1_n61_IO_out & c1_n62_IO_out & c1_n63_IO_out;
  c3_IO_in     <= c2_n0_IO_out & c2_n1_IO_out & c2_n2_IO_out & c2_n3_IO_out & c2_n4_IO_out & c2_n5_IO_out & c2_n6_IO_out & c2_n7_IO_out & c2_n8_IO_out & c2_n9_IO_out & c2_n10_IO_out & c2_n11_IO_out & c2_n12_IO_out & c2_n13_IO_out & c2_n14_IO_out & c2_n15_IO_out & c2_n16_IO_out & c2_n17_IO_out & c2_n18_IO_out & c2_n19_IO_out & c2_n20_IO_out & c2_n21_IO_out & c2_n22_IO_out & c2_n23_IO_out & c2_n24_IO_out & c2_n25_IO_out & c2_n26_IO_out & c2_n27_IO_out & c2_n28_IO_out & c2_n29_IO_out & c2_n30_IO_out & c2_n31_IO_out;

  PROCESS (clk, rst)
  BEGIN
    IF rst = '1' THEN
      reg_IO_in <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      reg_IO_in <= IO_in;
    END IF;
  END PROCESS;

  camada0_inst_0 : ENTITY work.camada0_ReLU_32neuron_8bits_10n_signed
    PORT MAP(
      ---------- Entradas ----------
      -- ['IN']['STD_LOGIC'] 
      clk            => clk,
      rst            => rst,
      update_weights => en_registers,
      -- ['IN']['manual'] 
      IO_in          => reg_IO_in,
      c0_n0_W_in     => c0_n0_W_in,
      c0_n1_W_in     => c0_n1_W_in,
      c0_n2_W_in     => c0_n2_W_in,
      c0_n3_W_in     => c0_n3_W_in,
      c0_n4_W_in     => c0_n4_W_in,
      c0_n5_W_in     => c0_n5_W_in,
      c0_n6_W_in     => c0_n6_W_in,
      c0_n7_W_in     => c0_n7_W_in,
      c0_n8_W_in     => c0_n8_W_in,
      c0_n9_W_in     => c0_n9_W_in,
      c0_n10_W_in    => c0_n10_W_in,
      c0_n11_W_in    => c0_n11_W_in,
      c0_n12_W_in    => c0_n12_W_in,
      c0_n13_W_in    => c0_n13_W_in,
      c0_n14_W_in    => c0_n14_W_in,
      c0_n15_W_in    => c0_n15_W_in,
      c0_n16_W_in    => c0_n16_W_in,
      c0_n17_W_in    => c0_n17_W_in,
      c0_n18_W_in    => c0_n18_W_in,
      c0_n19_W_in    => c0_n19_W_in,
      c0_n20_W_in    => c0_n20_W_in,
      c0_n21_W_in    => c0_n21_W_in,
      c0_n22_W_in    => c0_n22_W_in,
      c0_n23_W_in    => c0_n23_W_in,
      c0_n24_W_in    => c0_n24_W_in,
      c0_n25_W_in    => c0_n25_W_in,
      c0_n26_W_in    => c0_n26_W_in,
      c0_n27_W_in    => c0_n27_W_in,
      c0_n28_W_in    => c0_n28_W_in,
      c0_n29_W_in    => c0_n29_W_in,
      c0_n30_W_in    => c0_n30_W_in,
      c0_n31_W_in    => c0_n31_W_in,
      ---------- Saidas ----------
      -- ['OUT']['SIGNED'] 
      c0_n0_IO_out   => c0_n0_IO_out,
      c0_n1_IO_out   => c0_n1_IO_out,
      c0_n2_IO_out   => c0_n2_IO_out,
      c0_n3_IO_out   => c0_n3_IO_out,
      c0_n4_IO_out   => c0_n4_IO_out,
      c0_n5_IO_out   => c0_n5_IO_out,
      c0_n6_IO_out   => c0_n6_IO_out,
      c0_n7_IO_out   => c0_n7_IO_out,
      c0_n8_IO_out   => c0_n8_IO_out,
      c0_n9_IO_out   => c0_n9_IO_out,
      c0_n10_IO_out  => c0_n10_IO_out,
      c0_n11_IO_out  => c0_n11_IO_out,
      c0_n12_IO_out  => c0_n12_IO_out,
      c0_n13_IO_out  => c0_n13_IO_out,
      c0_n14_IO_out  => c0_n14_IO_out,
      c0_n15_IO_out  => c0_n15_IO_out,
      c0_n16_IO_out  => c0_n16_IO_out,
      c0_n17_IO_out  => c0_n17_IO_out,
      c0_n18_IO_out  => c0_n18_IO_out,
      c0_n19_IO_out  => c0_n19_IO_out,
      c0_n20_IO_out  => c0_n20_IO_out,
      c0_n21_IO_out  => c0_n21_IO_out,
      c0_n22_IO_out  => c0_n22_IO_out,
      c0_n23_IO_out  => c0_n23_IO_out,
      c0_n24_IO_out  => c0_n24_IO_out,
      c0_n25_IO_out  => c0_n25_IO_out,
      c0_n26_IO_out  => c0_n26_IO_out,
      c0_n27_IO_out  => c0_n27_IO_out,
      c0_n28_IO_out  => c0_n28_IO_out,
      c0_n29_IO_out  => c0_n29_IO_out,
      c0_n30_IO_out  => c0_n30_IO_out,
      c0_n31_IO_out  => c0_n31_IO_out,
      -- ['OUT']['manual'] 
      c0_n0_W_out    => c0_n0_W_out,
      c0_n1_W_out    => c0_n1_W_out,
      c0_n2_W_out    => c0_n2_W_out,
      c0_n3_W_out    => c0_n3_W_out,
      c0_n4_W_out    => c0_n4_W_out,
      c0_n5_W_out    => c0_n5_W_out,
      c0_n6_W_out    => c0_n6_W_out,
      c0_n7_W_out    => c0_n7_W_out,
      c0_n8_W_out    => c0_n8_W_out,
      c0_n9_W_out    => c0_n9_W_out,
      c0_n10_W_out   => c0_n10_W_out,
      c0_n11_W_out   => c0_n11_W_out,
      c0_n12_W_out   => c0_n12_W_out,
      c0_n13_W_out   => c0_n13_W_out,
      c0_n14_W_out   => c0_n14_W_out,
      c0_n15_W_out   => c0_n15_W_out,
      c0_n16_W_out   => c0_n16_W_out,
      c0_n17_W_out   => c0_n17_W_out,
      c0_n18_W_out   => c0_n18_W_out,
      c0_n19_W_out   => c0_n19_W_out,
      c0_n20_W_out   => c0_n20_W_out,
      c0_n21_W_out   => c0_n21_W_out,
      c0_n22_W_out   => c0_n22_W_out,
      c0_n23_W_out   => c0_n23_W_out,
      c0_n24_W_out   => c0_n24_W_out,
      c0_n25_W_out   => c0_n25_W_out,
      c0_n26_W_out   => c0_n26_W_out,
      c0_n27_W_out   => c0_n27_W_out,
      c0_n28_W_out   => c0_n28_W_out,
      c0_n29_W_out   => c0_n29_W_out,
      c0_n30_W_out   => c0_n30_W_out,
      c0_n31_W_out   => c0_n31_W_out
    );

  camada1_inst_1 : ENTITY work.camada1_ReLU_64neuron_8bits_32n_signed
    PORT MAP(
      ---------- Entradas ----------
      -- ['IN']['STD_LOGIC'] 
      clk            => clk,
      rst            => rst,
      update_weights => en_registers,
      -- ['IN']['manual'] 
      IO_in          => c1_IO_in,
      c1_n0_W_in     => c0_n0_W_out,
      c1_n1_W_in     => c0_n1_W_out,
      c1_n2_W_in     => c0_n2_W_out,
      c1_n3_W_in     => c0_n3_W_out,
      c1_n4_W_in     => c0_n4_W_out,
      c1_n5_W_in     => c0_n5_W_out,
      c1_n6_W_in     => c0_n6_W_out,
      c1_n7_W_in     => c0_n7_W_out,
      c1_n8_W_in     => c0_n8_W_out,
      c1_n9_W_in     => c0_n9_W_out,
      c1_n10_W_in    => c0_n10_W_out,
      c1_n11_W_in    => c0_n11_W_out,
      c1_n12_W_in    => c0_n12_W_out,
      c1_n13_W_in    => c0_n13_W_out,
      c1_n14_W_in    => c0_n14_W_out,
      c1_n15_W_in    => c0_n15_W_out,
      c1_n16_W_in    => c0_n16_W_out,
      c1_n17_W_in    => c0_n17_W_out,
      c1_n18_W_in    => c0_n18_W_out,
      c1_n19_W_in    => c0_n19_W_out,
      c1_n20_W_in    => c0_n20_W_out,
      c1_n21_W_in    => c0_n21_W_out,
      c1_n22_W_in    => c0_n22_W_out,
      c1_n23_W_in    => c0_n23_W_out,
      c1_n24_W_in    => c0_n24_W_out,
      c1_n25_W_in    => c0_n25_W_out,
      c1_n26_W_in    => c0_n26_W_out,
      c1_n27_W_in    => c0_n27_W_out,
      c1_n28_W_in    => c0_n28_W_out,
      c1_n29_W_in    => c0_n29_W_out,
      c1_n30_W_in    => c0_n30_W_out,
      c1_n31_W_in    => c0_n31_W_out,
      c1_n32_W_in    => c0_n32_W_out,
      c1_n33_W_in    => c0_n33_W_out,
      c1_n34_W_in    => c0_n34_W_out,
      c1_n35_W_in    => c0_n35_W_out,
      c1_n36_W_in    => c0_n36_W_out,
      c1_n37_W_in    => c0_n37_W_out,
      c1_n38_W_in    => c0_n38_W_out,
      c1_n39_W_in    => c0_n39_W_out,
      c1_n40_W_in    => c0_n40_W_out,
      c1_n41_W_in    => c0_n41_W_out,
      c1_n42_W_in    => c0_n42_W_out,
      c1_n43_W_in    => c0_n43_W_out,
      c1_n44_W_in    => c0_n44_W_out,
      c1_n45_W_in    => c0_n45_W_out,
      c1_n46_W_in    => c0_n46_W_out,
      c1_n47_W_in    => c0_n47_W_out,
      c1_n48_W_in    => c0_n48_W_out,
      c1_n49_W_in    => c0_n49_W_out,
      c1_n50_W_in    => c0_n50_W_out,
      c1_n51_W_in    => c0_n51_W_out,
      c1_n52_W_in    => c0_n52_W_out,
      c1_n53_W_in    => c0_n53_W_out,
      c1_n54_W_in    => c0_n54_W_out,
      c1_n55_W_in    => c0_n55_W_out,
      c1_n56_W_in    => c0_n56_W_out,
      c1_n57_W_in    => c0_n57_W_out,
      c1_n58_W_in    => c0_n58_W_out,
      c1_n59_W_in    => c0_n59_W_out,
      c1_n60_W_in    => c0_n60_W_out,
      c1_n61_W_in    => c0_n61_W_out,
      c1_n62_W_in    => c0_n62_W_out,
      c1_n63_W_in    => c0_n63_W_out,
      ---------- Saidas ----------
      -- ['OUT']['SIGNED'] 
      c1_n0_IO_out   => c1_n0_IO_out,
      c1_n1_IO_out   => c1_n1_IO_out,
      c1_n2_IO_out   => c1_n2_IO_out,
      c1_n3_IO_out   => c1_n3_IO_out,
      c1_n4_IO_out   => c1_n4_IO_out,
      c1_n5_IO_out   => c1_n5_IO_out,
      c1_n6_IO_out   => c1_n6_IO_out,
      c1_n7_IO_out   => c1_n7_IO_out,
      c1_n8_IO_out   => c1_n8_IO_out,
      c1_n9_IO_out   => c1_n9_IO_out,
      c1_n10_IO_out  => c1_n10_IO_out,
      c1_n11_IO_out  => c1_n11_IO_out,
      c1_n12_IO_out  => c1_n12_IO_out,
      c1_n13_IO_out  => c1_n13_IO_out,
      c1_n14_IO_out  => c1_n14_IO_out,
      c1_n15_IO_out  => c1_n15_IO_out,
      c1_n16_IO_out  => c1_n16_IO_out,
      c1_n17_IO_out  => c1_n17_IO_out,
      c1_n18_IO_out  => c1_n18_IO_out,
      c1_n19_IO_out  => c1_n19_IO_out,
      c1_n20_IO_out  => c1_n20_IO_out,
      c1_n21_IO_out  => c1_n21_IO_out,
      c1_n22_IO_out  => c1_n22_IO_out,
      c1_n23_IO_out  => c1_n23_IO_out,
      c1_n24_IO_out  => c1_n24_IO_out,
      c1_n25_IO_out  => c1_n25_IO_out,
      c1_n26_IO_out  => c1_n26_IO_out,
      c1_n27_IO_out  => c1_n27_IO_out,
      c1_n28_IO_out  => c1_n28_IO_out,
      c1_n29_IO_out  => c1_n29_IO_out,
      c1_n30_IO_out  => c1_n30_IO_out,
      c1_n31_IO_out  => c1_n31_IO_out,
      c1_n32_IO_out  => c1_n32_IO_out,
      c1_n33_IO_out  => c1_n33_IO_out,
      c1_n34_IO_out  => c1_n34_IO_out,
      c1_n35_IO_out  => c1_n35_IO_out,
      c1_n36_IO_out  => c1_n36_IO_out,
      c1_n37_IO_out  => c1_n37_IO_out,
      c1_n38_IO_out  => c1_n38_IO_out,
      c1_n39_IO_out  => c1_n39_IO_out,
      c1_n40_IO_out  => c1_n40_IO_out,
      c1_n41_IO_out  => c1_n41_IO_out,
      c1_n42_IO_out  => c1_n42_IO_out,
      c1_n43_IO_out  => c1_n43_IO_out,
      c1_n44_IO_out  => c1_n44_IO_out,
      c1_n45_IO_out  => c1_n45_IO_out,
      c1_n46_IO_out  => c1_n46_IO_out,
      c1_n47_IO_out  => c1_n47_IO_out,
      c1_n48_IO_out  => c1_n48_IO_out,
      c1_n49_IO_out  => c1_n49_IO_out,
      c1_n50_IO_out  => c1_n50_IO_out,
      c1_n51_IO_out  => c1_n51_IO_out,
      c1_n52_IO_out  => c1_n52_IO_out,
      c1_n53_IO_out  => c1_n53_IO_out,
      c1_n54_IO_out  => c1_n54_IO_out,
      c1_n55_IO_out  => c1_n55_IO_out,
      c1_n56_IO_out  => c1_n56_IO_out,
      c1_n57_IO_out  => c1_n57_IO_out,
      c1_n58_IO_out  => c1_n58_IO_out,
      c1_n59_IO_out  => c1_n59_IO_out,
      c1_n60_IO_out  => c1_n60_IO_out,
      c1_n61_IO_out  => c1_n61_IO_out,
      c1_n62_IO_out  => c1_n62_IO_out,
      c1_n63_IO_out  => c1_n63_IO_out,
      -- ['OUT']['manual'] 
      c1_n0_W_out    => c1_n0_W_out,
      c1_n1_W_out    => c1_n1_W_out,
      c1_n2_W_out    => c1_n2_W_out,
      c1_n3_W_out    => c1_n3_W_out,
      c1_n4_W_out    => c1_n4_W_out,
      c1_n5_W_out    => c1_n5_W_out,
      c1_n6_W_out    => c1_n6_W_out,
      c1_n7_W_out    => c1_n7_W_out,
      c1_n8_W_out    => c1_n8_W_out,
      c1_n9_W_out    => c1_n9_W_out,
      c1_n10_W_out   => c1_n10_W_out,
      c1_n11_W_out   => c1_n11_W_out,
      c1_n12_W_out   => c1_n12_W_out,
      c1_n13_W_out   => c1_n13_W_out,
      c1_n14_W_out   => c1_n14_W_out,
      c1_n15_W_out   => c1_n15_W_out,
      c1_n16_W_out   => c1_n16_W_out,
      c1_n17_W_out   => c1_n17_W_out,
      c1_n18_W_out   => c1_n18_W_out,
      c1_n19_W_out   => c1_n19_W_out,
      c1_n20_W_out   => c1_n20_W_out,
      c1_n21_W_out   => c1_n21_W_out,
      c1_n22_W_out   => c1_n22_W_out,
      c1_n23_W_out   => c1_n23_W_out,
      c1_n24_W_out   => c1_n24_W_out,
      c1_n25_W_out   => c1_n25_W_out,
      c1_n26_W_out   => c1_n26_W_out,
      c1_n27_W_out   => c1_n27_W_out,
      c1_n28_W_out   => c1_n28_W_out,
      c1_n29_W_out   => c1_n29_W_out,
      c1_n30_W_out   => c1_n30_W_out,
      c1_n31_W_out   => c1_n31_W_out
    );

  camada2_inst_2 : ENTITY work.camada2_ReLU_32neuron_8bits_64n_signed
    PORT MAP(
      ---------- Entradas ----------
      -- ['IN']['STD_LOGIC'] 
      clk            => clk,
      rst            => rst,
      update_weights => en_registers,
      -- ['IN']['manual'] 
      IO_in          => c2_IO_in,
      c2_n0_W_in     => c1_n0_W_out,
      c2_n1_W_in     => c1_n1_W_out,
      c2_n2_W_in     => c1_n2_W_out,
      c2_n3_W_in     => c1_n3_W_out,
      c2_n4_W_in     => c1_n4_W_out,
      c2_n5_W_in     => c1_n5_W_out,
      c2_n6_W_in     => c1_n6_W_out,
      c2_n7_W_in     => c1_n7_W_out,
      c2_n8_W_in     => c1_n8_W_out,
      c2_n9_W_in     => c1_n9_W_out,
      c2_n10_W_in    => c1_n10_W_out,
      c2_n11_W_in    => c1_n11_W_out,
      c2_n12_W_in    => c1_n12_W_out,
      c2_n13_W_in    => c1_n13_W_out,
      c2_n14_W_in    => c1_n14_W_out,
      c2_n15_W_in    => c1_n15_W_out,
      c2_n16_W_in    => c1_n16_W_out,
      c2_n17_W_in    => c1_n17_W_out,
      c2_n18_W_in    => c1_n18_W_out,
      c2_n19_W_in    => c1_n19_W_out,
      c2_n20_W_in    => c1_n20_W_out,
      c2_n21_W_in    => c1_n21_W_out,
      c2_n22_W_in    => c1_n22_W_out,
      c2_n23_W_in    => c1_n23_W_out,
      c2_n24_W_in    => c1_n24_W_out,
      c2_n25_W_in    => c1_n25_W_out,
      c2_n26_W_in    => c1_n26_W_out,
      c2_n27_W_in    => c1_n27_W_out,
      c2_n28_W_in    => c1_n28_W_out,
      c2_n29_W_in    => c1_n29_W_out,
      c2_n30_W_in    => c1_n30_W_out,
      c2_n31_W_in    => c1_n31_W_out,
      ---------- Saidas ----------
      -- ['OUT']['SIGNED'] 
      c2_n0_IO_out   => c2_n0_IO_out,
      c2_n1_IO_out   => c2_n1_IO_out,
      c2_n2_IO_out   => c2_n2_IO_out,
      c2_n3_IO_out   => c2_n3_IO_out,
      c2_n4_IO_out   => c2_n4_IO_out,
      c2_n5_IO_out   => c2_n5_IO_out,
      c2_n6_IO_out   => c2_n6_IO_out,
      c2_n7_IO_out   => c2_n7_IO_out,
      c2_n8_IO_out   => c2_n8_IO_out,
      c2_n9_IO_out   => c2_n9_IO_out,
      c2_n10_IO_out  => c2_n10_IO_out,
      c2_n11_IO_out  => c2_n11_IO_out,
      c2_n12_IO_out  => c2_n12_IO_out,
      c2_n13_IO_out  => c2_n13_IO_out,
      c2_n14_IO_out  => c2_n14_IO_out,
      c2_n15_IO_out  => c2_n15_IO_out,
      c2_n16_IO_out  => c2_n16_IO_out,
      c2_n17_IO_out  => c2_n17_IO_out,
      c2_n18_IO_out  => c2_n18_IO_out,
      c2_n19_IO_out  => c2_n19_IO_out,
      c2_n20_IO_out  => c2_n20_IO_out,
      c2_n21_IO_out  => c2_n21_IO_out,
      c2_n22_IO_out  => c2_n22_IO_out,
      c2_n23_IO_out  => c2_n23_IO_out,
      c2_n24_IO_out  => c2_n24_IO_out,
      c2_n25_IO_out  => c2_n25_IO_out,
      c2_n26_IO_out  => c2_n26_IO_out,
      c2_n27_IO_out  => c2_n27_IO_out,
      c2_n28_IO_out  => c2_n28_IO_out,
      c2_n29_IO_out  => c2_n29_IO_out,
      c2_n30_IO_out  => c2_n30_IO_out,
      c2_n31_IO_out  => c2_n31_IO_out,
      -- ['OUT']['manual'] 
      c2_n0_W_out    => c2_n0_W_out,
      c2_n1_W_out    => c2_n1_W_out,
      c2_n2_W_out    => c2_n2_W_out
    );

  camada3_inst_3 : ENTITY work.camada3_Sigmoid_3neuron_8bits_32n_signed
    PORT MAP(
      ---------- Entradas ----------
      -- ['IN']['STD_LOGIC'] 
      clk            => clk,
      rst            => rst,
      update_weights => en_registers,
      -- ['IN']['manual'] 
      IO_in          => c3_IO_in,
      c3_n0_W_in     => c2_n0_W_out,
      c3_n1_W_in     => c2_n1_W_out,
      c3_n2_W_in     => c2_n2_W_out,
      ---------- Saidas ----------
      -- ['OUT']['SIGNED'] 
      c3_n0_IO_out   => c3_n0_IO_out,
      c3_n1_IO_out   => c3_n1_IO_out,
      c3_n2_IO_out   => c3_n2_IO_out
    );

END ARCHITECTURE;
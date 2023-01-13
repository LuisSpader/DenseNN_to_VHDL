COMPONENT  vhd_topo_2n_4bit_signed IS
  PORT (
    clk, rst, update_weights: IN STD_LOGIC;
    bias: IN signed(3 DOWNTO 0);
    x1, x2: IN signed(3 DOWNTO 0);
    w1, w2: IN signed(3 DOWNTO 0);
    ----------------------------------------------
    y: OUT signed(3 DOWNTO 0)
    );
end COMPONENT;
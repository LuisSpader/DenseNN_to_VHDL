LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

  ENTITY  MAC_comb_128n_8bit_signed_mult0_v0_add0_v0 IS
    GENERIC (
        BITS : NATURAL := BITS;
        NUM_INPUTS : NATURAL := 128;
        TOTAL_BITS : NATURAL := 1024
    );
    PORT (
      clk, rst: IN STD_LOGIC;
      IO_in : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      W_in : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
      ----------------------------------------------
      IO_out: OUT signed(7 DOWNTO 0)
    );
  end ENTITY;

ARCHITECTURE arch OF  MAC_comb_128n_8bit_signed_mult0_v0_add0_v0  IS

    ---------- SINAIS ----------
	SIGNAL sum_all : signed((2*BITS) - 1 DOWNTO 0);
  SIGNAL s_Xi : signed((BITS * NUM_INPUTS) - 1 DOWNTO 0);
  SIGNAL s_Win : signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
  SIGNAL s_mult : signed(((2 * BITS) * (NUM_INPUTS)) - 1 DOWNTO 0);
    
  COMPONENT mult0_v0 IS
    GENERIC (
      BITS : NATURAL := BITS
    );
    PORT (
      X : IN signed((BITS) - 1 DOWNTO 0);
      W : IN signed((BITS) - 1 DOWNTO 0);
      Y : OUT signed((2 * BITS) - 1 DOWNTO 0)
    );
  END COMPONENT;

BEGIN
  s_Xi <= IO_in;
  s_Win <= W_in;


  sum_all <= (s_mult(((2 * BITS) * (0 + 1)) - 1 DOWNTO ((2 * BITS) * (0))) + 
    s_mult(((2 * BITS) * (1 + 1)) - 1 DOWNTO ((2 * BITS) * (1))) + 
    s_mult(((2 * BITS) * (2 + 1)) - 1 DOWNTO ((2 * BITS) * (2))) + 
    s_mult(((2 * BITS) * (3 + 1)) - 1 DOWNTO ((2 * BITS) * (3))) + 
    s_mult(((2 * BITS) * (4 + 1)) - 1 DOWNTO ((2 * BITS) * (4))) + 
    s_mult(((2 * BITS) * (5 + 1)) - 1 DOWNTO ((2 * BITS) * (5))) + 
    s_mult(((2 * BITS) * (6 + 1)) - 1 DOWNTO ((2 * BITS) * (6))) + 
    s_mult(((2 * BITS) * (7 + 1)) - 1 DOWNTO ((2 * BITS) * (7))) + 
    s_mult(((2 * BITS) * (8 + 1)) - 1 DOWNTO ((2 * BITS) * (8))) + 
    s_mult(((2 * BITS) * (9 + 1)) - 1 DOWNTO ((2 * BITS) * (9))) + 
    s_mult(((2 * BITS) * (10 + 1)) - 1 DOWNTO ((2 * BITS) * (10))) + 
    s_mult(((2 * BITS) * (11 + 1)) - 1 DOWNTO ((2 * BITS) * (11))) + 
    s_mult(((2 * BITS) * (12 + 1)) - 1 DOWNTO ((2 * BITS) * (12))) + 
    s_mult(((2 * BITS) * (13 + 1)) - 1 DOWNTO ((2 * BITS) * (13))) + 
    s_mult(((2 * BITS) * (14 + 1)) - 1 DOWNTO ((2 * BITS) * (14))) + 
    s_mult(((2 * BITS) * (15 + 1)) - 1 DOWNTO ((2 * BITS) * (15))) + 
    s_mult(((2 * BITS) * (16 + 1)) - 1 DOWNTO ((2 * BITS) * (16))) + 
    s_mult(((2 * BITS) * (17 + 1)) - 1 DOWNTO ((2 * BITS) * (17))) + 
    s_mult(((2 * BITS) * (18 + 1)) - 1 DOWNTO ((2 * BITS) * (18))) + 
    s_mult(((2 * BITS) * (19 + 1)) - 1 DOWNTO ((2 * BITS) * (19))) + 
    s_mult(((2 * BITS) * (20 + 1)) - 1 DOWNTO ((2 * BITS) * (20))) + 
    s_mult(((2 * BITS) * (21 + 1)) - 1 DOWNTO ((2 * BITS) * (21))) + 
    s_mult(((2 * BITS) * (22 + 1)) - 1 DOWNTO ((2 * BITS) * (22))) + 
    s_mult(((2 * BITS) * (23 + 1)) - 1 DOWNTO ((2 * BITS) * (23))) + 
    s_mult(((2 * BITS) * (24 + 1)) - 1 DOWNTO ((2 * BITS) * (24))) + 
    s_mult(((2 * BITS) * (25 + 1)) - 1 DOWNTO ((2 * BITS) * (25))) + 
    s_mult(((2 * BITS) * (26 + 1)) - 1 DOWNTO ((2 * BITS) * (26))) + 
    s_mult(((2 * BITS) * (27 + 1)) - 1 DOWNTO ((2 * BITS) * (27))) + 
    s_mult(((2 * BITS) * (28 + 1)) - 1 DOWNTO ((2 * BITS) * (28))) + 
    s_mult(((2 * BITS) * (29 + 1)) - 1 DOWNTO ((2 * BITS) * (29))) + 
    s_mult(((2 * BITS) * (30 + 1)) - 1 DOWNTO ((2 * BITS) * (30))) + 
    s_mult(((2 * BITS) * (31 + 1)) - 1 DOWNTO ((2 * BITS) * (31))) + 
    s_mult(((2 * BITS) * (32 + 1)) - 1 DOWNTO ((2 * BITS) * (32))) + 
    s_mult(((2 * BITS) * (33 + 1)) - 1 DOWNTO ((2 * BITS) * (33))) + 
    s_mult(((2 * BITS) * (34 + 1)) - 1 DOWNTO ((2 * BITS) * (34))) + 
    s_mult(((2 * BITS) * (35 + 1)) - 1 DOWNTO ((2 * BITS) * (35))) + 
    s_mult(((2 * BITS) * (36 + 1)) - 1 DOWNTO ((2 * BITS) * (36))) + 
    s_mult(((2 * BITS) * (37 + 1)) - 1 DOWNTO ((2 * BITS) * (37))) + 
    s_mult(((2 * BITS) * (38 + 1)) - 1 DOWNTO ((2 * BITS) * (38))) + 
    s_mult(((2 * BITS) * (39 + 1)) - 1 DOWNTO ((2 * BITS) * (39))) + 
    s_mult(((2 * BITS) * (40 + 1)) - 1 DOWNTO ((2 * BITS) * (40))) + 
    s_mult(((2 * BITS) * (41 + 1)) - 1 DOWNTO ((2 * BITS) * (41))) + 
    s_mult(((2 * BITS) * (42 + 1)) - 1 DOWNTO ((2 * BITS) * (42))) + 
    s_mult(((2 * BITS) * (43 + 1)) - 1 DOWNTO ((2 * BITS) * (43))) + 
    s_mult(((2 * BITS) * (44 + 1)) - 1 DOWNTO ((2 * BITS) * (44))) + 
    s_mult(((2 * BITS) * (45 + 1)) - 1 DOWNTO ((2 * BITS) * (45))) + 
    s_mult(((2 * BITS) * (46 + 1)) - 1 DOWNTO ((2 * BITS) * (46))) + 
    s_mult(((2 * BITS) * (47 + 1)) - 1 DOWNTO ((2 * BITS) * (47))) + 
    s_mult(((2 * BITS) * (48 + 1)) - 1 DOWNTO ((2 * BITS) * (48))) + 
    s_mult(((2 * BITS) * (49 + 1)) - 1 DOWNTO ((2 * BITS) * (49))) + 
    s_mult(((2 * BITS) * (50 + 1)) - 1 DOWNTO ((2 * BITS) * (50))) + 
    s_mult(((2 * BITS) * (51 + 1)) - 1 DOWNTO ((2 * BITS) * (51))) + 
    s_mult(((2 * BITS) * (52 + 1)) - 1 DOWNTO ((2 * BITS) * (52))) + 
    s_mult(((2 * BITS) * (53 + 1)) - 1 DOWNTO ((2 * BITS) * (53))) + 
    s_mult(((2 * BITS) * (54 + 1)) - 1 DOWNTO ((2 * BITS) * (54))) + 
    s_mult(((2 * BITS) * (55 + 1)) - 1 DOWNTO ((2 * BITS) * (55))) + 
    s_mult(((2 * BITS) * (56 + 1)) - 1 DOWNTO ((2 * BITS) * (56))) + 
    s_mult(((2 * BITS) * (57 + 1)) - 1 DOWNTO ((2 * BITS) * (57))) + 
    s_mult(((2 * BITS) * (58 + 1)) - 1 DOWNTO ((2 * BITS) * (58))) + 
    s_mult(((2 * BITS) * (59 + 1)) - 1 DOWNTO ((2 * BITS) * (59))) + 
    s_mult(((2 * BITS) * (60 + 1)) - 1 DOWNTO ((2 * BITS) * (60))) + 
    s_mult(((2 * BITS) * (61 + 1)) - 1 DOWNTO ((2 * BITS) * (61))) + 
    s_mult(((2 * BITS) * (62 + 1)) - 1 DOWNTO ((2 * BITS) * (62))) + 
    s_mult(((2 * BITS) * (63 + 1)) - 1 DOWNTO ((2 * BITS) * (63))) + 
    s_mult(((2 * BITS) * (64 + 1)) - 1 DOWNTO ((2 * BITS) * (64))) + 
    s_mult(((2 * BITS) * (65 + 1)) - 1 DOWNTO ((2 * BITS) * (65))) + 
    s_mult(((2 * BITS) * (66 + 1)) - 1 DOWNTO ((2 * BITS) * (66))) + 
    s_mult(((2 * BITS) * (67 + 1)) - 1 DOWNTO ((2 * BITS) * (67))) + 
    s_mult(((2 * BITS) * (68 + 1)) - 1 DOWNTO ((2 * BITS) * (68))) + 
    s_mult(((2 * BITS) * (69 + 1)) - 1 DOWNTO ((2 * BITS) * (69))) + 
    s_mult(((2 * BITS) * (70 + 1)) - 1 DOWNTO ((2 * BITS) * (70))) + 
    s_mult(((2 * BITS) * (71 + 1)) - 1 DOWNTO ((2 * BITS) * (71))) + 
    s_mult(((2 * BITS) * (72 + 1)) - 1 DOWNTO ((2 * BITS) * (72))) + 
    s_mult(((2 * BITS) * (73 + 1)) - 1 DOWNTO ((2 * BITS) * (73))) + 
    s_mult(((2 * BITS) * (74 + 1)) - 1 DOWNTO ((2 * BITS) * (74))) + 
    s_mult(((2 * BITS) * (75 + 1)) - 1 DOWNTO ((2 * BITS) * (75))) + 
    s_mult(((2 * BITS) * (76 + 1)) - 1 DOWNTO ((2 * BITS) * (76))) + 
    s_mult(((2 * BITS) * (77 + 1)) - 1 DOWNTO ((2 * BITS) * (77))) + 
    s_mult(((2 * BITS) * (78 + 1)) - 1 DOWNTO ((2 * BITS) * (78))) + 
    s_mult(((2 * BITS) * (79 + 1)) - 1 DOWNTO ((2 * BITS) * (79))) + 
    s_mult(((2 * BITS) * (80 + 1)) - 1 DOWNTO ((2 * BITS) * (80))) + 
    s_mult(((2 * BITS) * (81 + 1)) - 1 DOWNTO ((2 * BITS) * (81))) + 
    s_mult(((2 * BITS) * (82 + 1)) - 1 DOWNTO ((2 * BITS) * (82))) + 
    s_mult(((2 * BITS) * (83 + 1)) - 1 DOWNTO ((2 * BITS) * (83))) + 
    s_mult(((2 * BITS) * (84 + 1)) - 1 DOWNTO ((2 * BITS) * (84))) + 
    s_mult(((2 * BITS) * (85 + 1)) - 1 DOWNTO ((2 * BITS) * (85))) + 
    s_mult(((2 * BITS) * (86 + 1)) - 1 DOWNTO ((2 * BITS) * (86))) + 
    s_mult(((2 * BITS) * (87 + 1)) - 1 DOWNTO ((2 * BITS) * (87))) + 
    s_mult(((2 * BITS) * (88 + 1)) - 1 DOWNTO ((2 * BITS) * (88))) + 
    s_mult(((2 * BITS) * (89 + 1)) - 1 DOWNTO ((2 * BITS) * (89))) + 
    s_mult(((2 * BITS) * (90 + 1)) - 1 DOWNTO ((2 * BITS) * (90))) + 
    s_mult(((2 * BITS) * (91 + 1)) - 1 DOWNTO ((2 * BITS) * (91))) + 
    s_mult(((2 * BITS) * (92 + 1)) - 1 DOWNTO ((2 * BITS) * (92))) + 
    s_mult(((2 * BITS) * (93 + 1)) - 1 DOWNTO ((2 * BITS) * (93))) + 
    s_mult(((2 * BITS) * (94 + 1)) - 1 DOWNTO ((2 * BITS) * (94))) + 
    s_mult(((2 * BITS) * (95 + 1)) - 1 DOWNTO ((2 * BITS) * (95))) + 
    s_mult(((2 * BITS) * (96 + 1)) - 1 DOWNTO ((2 * BITS) * (96))) + 
    s_mult(((2 * BITS) * (97 + 1)) - 1 DOWNTO ((2 * BITS) * (97))) + 
    s_mult(((2 * BITS) * (98 + 1)) - 1 DOWNTO ((2 * BITS) * (98))) + 
    s_mult(((2 * BITS) * (99 + 1)) - 1 DOWNTO ((2 * BITS) * (99))) + 
    s_mult(((2 * BITS) * (100 + 1)) - 1 DOWNTO ((2 * BITS) * (100))) + 
    s_mult(((2 * BITS) * (101 + 1)) - 1 DOWNTO ((2 * BITS) * (101))) + 
    s_mult(((2 * BITS) * (102 + 1)) - 1 DOWNTO ((2 * BITS) * (102))) + 
    s_mult(((2 * BITS) * (103 + 1)) - 1 DOWNTO ((2 * BITS) * (103))) + 
    s_mult(((2 * BITS) * (104 + 1)) - 1 DOWNTO ((2 * BITS) * (104))) + 
    s_mult(((2 * BITS) * (105 + 1)) - 1 DOWNTO ((2 * BITS) * (105))) + 
    s_mult(((2 * BITS) * (106 + 1)) - 1 DOWNTO ((2 * BITS) * (106))) + 
    s_mult(((2 * BITS) * (107 + 1)) - 1 DOWNTO ((2 * BITS) * (107))) + 
    s_mult(((2 * BITS) * (108 + 1)) - 1 DOWNTO ((2 * BITS) * (108))) + 
    s_mult(((2 * BITS) * (109 + 1)) - 1 DOWNTO ((2 * BITS) * (109))) + 
    s_mult(((2 * BITS) * (110 + 1)) - 1 DOWNTO ((2 * BITS) * (110))) + 
    s_mult(((2 * BITS) * (111 + 1)) - 1 DOWNTO ((2 * BITS) * (111))) + 
    s_mult(((2 * BITS) * (112 + 1)) - 1 DOWNTO ((2 * BITS) * (112))) + 
    s_mult(((2 * BITS) * (113 + 1)) - 1 DOWNTO ((2 * BITS) * (113))) + 
    s_mult(((2 * BITS) * (114 + 1)) - 1 DOWNTO ((2 * BITS) * (114))) + 
    s_mult(((2 * BITS) * (115 + 1)) - 1 DOWNTO ((2 * BITS) * (115))) + 
    s_mult(((2 * BITS) * (116 + 1)) - 1 DOWNTO ((2 * BITS) * (116))) + 
    s_mult(((2 * BITS) * (117 + 1)) - 1 DOWNTO ((2 * BITS) * (117))) + 
    s_mult(((2 * BITS) * (118 + 1)) - 1 DOWNTO ((2 * BITS) * (118))) + 
    s_mult(((2 * BITS) * (119 + 1)) - 1 DOWNTO ((2 * BITS) * (119))) + 
    s_mult(((2 * BITS) * (120 + 1)) - 1 DOWNTO ((2 * BITS) * (120))) + 
    s_mult(((2 * BITS) * (121 + 1)) - 1 DOWNTO ((2 * BITS) * (121))) + 
    s_mult(((2 * BITS) * (122 + 1)) - 1 DOWNTO ((2 * BITS) * (122))) + 
    s_mult(((2 * BITS) * (123 + 1)) - 1 DOWNTO ((2 * BITS) * (123))) + 
    s_mult(((2 * BITS) * (124 + 1)) - 1 DOWNTO ((2 * BITS) * (124))) + 
    s_mult(((2 * BITS) * (125 + 1)) - 1 DOWNTO ((2 * BITS) * (125))) + 
    s_mult(((2 * BITS) * (126 + 1)) - 1 DOWNTO ((2 * BITS) * (126))) + 
    s_mult(((2 * BITS) * (127 + 1)) - 1 DOWNTO ((2 * BITS) * (127))) + 
    s_Win((BITS * (128 + 1)) - 1 DOWNTO (BITS * (128)))); 

loop_Mult_port_map : FOR i IN 0 TO (NUM_INPUTS - 1) GENERATE
    mult0_v0_inst_loop : mult0_v0
    PORT MAP(
      X => s_Xi((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      W => s_Win((BITS * (i + 1)) - 1 DOWNTO (BITS * (i))),
      Y => s_mult(((2 * BITS) * (i + 1)) - 1 DOWNTO ((2 * BITS) * (i)))
    );
  END GENERATE;
	PROCESS (rst, clk)
	BEGIN
		IF (rst = '1') THEN
                        IO_out <= (OTHERS => '0');
		ELSE
			IF (clk'event AND clk = '1') THEN --se tem evento de clock
                                IO_out <= signed(sum_all(15 DOWNTO 8));
			END IF;
		END IF;
	END PROCESS;


END arch;

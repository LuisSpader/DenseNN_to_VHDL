LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

  ENTITY  MAC_300n IS
    GENERIC (
        BITS : NATURAL := BITS;
        NUM_INPUTS : NATURAL := 300;
        TOTAL_BITS : NATURAL := 2400
    );
    PORT (
      clk, rst: IN STD_LOGIC;
      IO_in : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      W_in : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
      ----------------------------------------------
      IO_out: OUT signed(7 DOWNTO 0)
    );
  end ENTITY;

ARCHITECTURE arch OF  MAC_300n  IS

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
    s_mult(((2 * BITS) * (128 + 1)) - 1 DOWNTO ((2 * BITS) * (128))) + 
    s_mult(((2 * BITS) * (129 + 1)) - 1 DOWNTO ((2 * BITS) * (129))) + 
    s_mult(((2 * BITS) * (130 + 1)) - 1 DOWNTO ((2 * BITS) * (130))) + 
    s_mult(((2 * BITS) * (131 + 1)) - 1 DOWNTO ((2 * BITS) * (131))) + 
    s_mult(((2 * BITS) * (132 + 1)) - 1 DOWNTO ((2 * BITS) * (132))) + 
    s_mult(((2 * BITS) * (133 + 1)) - 1 DOWNTO ((2 * BITS) * (133))) + 
    s_mult(((2 * BITS) * (134 + 1)) - 1 DOWNTO ((2 * BITS) * (134))) + 
    s_mult(((2 * BITS) * (135 + 1)) - 1 DOWNTO ((2 * BITS) * (135))) + 
    s_mult(((2 * BITS) * (136 + 1)) - 1 DOWNTO ((2 * BITS) * (136))) + 
    s_mult(((2 * BITS) * (137 + 1)) - 1 DOWNTO ((2 * BITS) * (137))) + 
    s_mult(((2 * BITS) * (138 + 1)) - 1 DOWNTO ((2 * BITS) * (138))) + 
    s_mult(((2 * BITS) * (139 + 1)) - 1 DOWNTO ((2 * BITS) * (139))) + 
    s_mult(((2 * BITS) * (140 + 1)) - 1 DOWNTO ((2 * BITS) * (140))) + 
    s_mult(((2 * BITS) * (141 + 1)) - 1 DOWNTO ((2 * BITS) * (141))) + 
    s_mult(((2 * BITS) * (142 + 1)) - 1 DOWNTO ((2 * BITS) * (142))) + 
    s_mult(((2 * BITS) * (143 + 1)) - 1 DOWNTO ((2 * BITS) * (143))) + 
    s_mult(((2 * BITS) * (144 + 1)) - 1 DOWNTO ((2 * BITS) * (144))) + 
    s_mult(((2 * BITS) * (145 + 1)) - 1 DOWNTO ((2 * BITS) * (145))) + 
    s_mult(((2 * BITS) * (146 + 1)) - 1 DOWNTO ((2 * BITS) * (146))) + 
    s_mult(((2 * BITS) * (147 + 1)) - 1 DOWNTO ((2 * BITS) * (147))) + 
    s_mult(((2 * BITS) * (148 + 1)) - 1 DOWNTO ((2 * BITS) * (148))) + 
    s_mult(((2 * BITS) * (149 + 1)) - 1 DOWNTO ((2 * BITS) * (149))) + 
    s_mult(((2 * BITS) * (150 + 1)) - 1 DOWNTO ((2 * BITS) * (150))) + 
    s_mult(((2 * BITS) * (151 + 1)) - 1 DOWNTO ((2 * BITS) * (151))) + 
    s_mult(((2 * BITS) * (152 + 1)) - 1 DOWNTO ((2 * BITS) * (152))) + 
    s_mult(((2 * BITS) * (153 + 1)) - 1 DOWNTO ((2 * BITS) * (153))) + 
    s_mult(((2 * BITS) * (154 + 1)) - 1 DOWNTO ((2 * BITS) * (154))) + 
    s_mult(((2 * BITS) * (155 + 1)) - 1 DOWNTO ((2 * BITS) * (155))) + 
    s_mult(((2 * BITS) * (156 + 1)) - 1 DOWNTO ((2 * BITS) * (156))) + 
    s_mult(((2 * BITS) * (157 + 1)) - 1 DOWNTO ((2 * BITS) * (157))) + 
    s_mult(((2 * BITS) * (158 + 1)) - 1 DOWNTO ((2 * BITS) * (158))) + 
    s_mult(((2 * BITS) * (159 + 1)) - 1 DOWNTO ((2 * BITS) * (159))) + 
    s_mult(((2 * BITS) * (160 + 1)) - 1 DOWNTO ((2 * BITS) * (160))) + 
    s_mult(((2 * BITS) * (161 + 1)) - 1 DOWNTO ((2 * BITS) * (161))) + 
    s_mult(((2 * BITS) * (162 + 1)) - 1 DOWNTO ((2 * BITS) * (162))) + 
    s_mult(((2 * BITS) * (163 + 1)) - 1 DOWNTO ((2 * BITS) * (163))) + 
    s_mult(((2 * BITS) * (164 + 1)) - 1 DOWNTO ((2 * BITS) * (164))) + 
    s_mult(((2 * BITS) * (165 + 1)) - 1 DOWNTO ((2 * BITS) * (165))) + 
    s_mult(((2 * BITS) * (166 + 1)) - 1 DOWNTO ((2 * BITS) * (166))) + 
    s_mult(((2 * BITS) * (167 + 1)) - 1 DOWNTO ((2 * BITS) * (167))) + 
    s_mult(((2 * BITS) * (168 + 1)) - 1 DOWNTO ((2 * BITS) * (168))) + 
    s_mult(((2 * BITS) * (169 + 1)) - 1 DOWNTO ((2 * BITS) * (169))) + 
    s_mult(((2 * BITS) * (170 + 1)) - 1 DOWNTO ((2 * BITS) * (170))) + 
    s_mult(((2 * BITS) * (171 + 1)) - 1 DOWNTO ((2 * BITS) * (171))) + 
    s_mult(((2 * BITS) * (172 + 1)) - 1 DOWNTO ((2 * BITS) * (172))) + 
    s_mult(((2 * BITS) * (173 + 1)) - 1 DOWNTO ((2 * BITS) * (173))) + 
    s_mult(((2 * BITS) * (174 + 1)) - 1 DOWNTO ((2 * BITS) * (174))) + 
    s_mult(((2 * BITS) * (175 + 1)) - 1 DOWNTO ((2 * BITS) * (175))) + 
    s_mult(((2 * BITS) * (176 + 1)) - 1 DOWNTO ((2 * BITS) * (176))) + 
    s_mult(((2 * BITS) * (177 + 1)) - 1 DOWNTO ((2 * BITS) * (177))) + 
    s_mult(((2 * BITS) * (178 + 1)) - 1 DOWNTO ((2 * BITS) * (178))) + 
    s_mult(((2 * BITS) * (179 + 1)) - 1 DOWNTO ((2 * BITS) * (179))) + 
    s_mult(((2 * BITS) * (180 + 1)) - 1 DOWNTO ((2 * BITS) * (180))) + 
    s_mult(((2 * BITS) * (181 + 1)) - 1 DOWNTO ((2 * BITS) * (181))) + 
    s_mult(((2 * BITS) * (182 + 1)) - 1 DOWNTO ((2 * BITS) * (182))) + 
    s_mult(((2 * BITS) * (183 + 1)) - 1 DOWNTO ((2 * BITS) * (183))) + 
    s_mult(((2 * BITS) * (184 + 1)) - 1 DOWNTO ((2 * BITS) * (184))) + 
    s_mult(((2 * BITS) * (185 + 1)) - 1 DOWNTO ((2 * BITS) * (185))) + 
    s_mult(((2 * BITS) * (186 + 1)) - 1 DOWNTO ((2 * BITS) * (186))) + 
    s_mult(((2 * BITS) * (187 + 1)) - 1 DOWNTO ((2 * BITS) * (187))) + 
    s_mult(((2 * BITS) * (188 + 1)) - 1 DOWNTO ((2 * BITS) * (188))) + 
    s_mult(((2 * BITS) * (189 + 1)) - 1 DOWNTO ((2 * BITS) * (189))) + 
    s_mult(((2 * BITS) * (190 + 1)) - 1 DOWNTO ((2 * BITS) * (190))) + 
    s_mult(((2 * BITS) * (191 + 1)) - 1 DOWNTO ((2 * BITS) * (191))) + 
    s_mult(((2 * BITS) * (192 + 1)) - 1 DOWNTO ((2 * BITS) * (192))) + 
    s_mult(((2 * BITS) * (193 + 1)) - 1 DOWNTO ((2 * BITS) * (193))) + 
    s_mult(((2 * BITS) * (194 + 1)) - 1 DOWNTO ((2 * BITS) * (194))) + 
    s_mult(((2 * BITS) * (195 + 1)) - 1 DOWNTO ((2 * BITS) * (195))) + 
    s_mult(((2 * BITS) * (196 + 1)) - 1 DOWNTO ((2 * BITS) * (196))) + 
    s_mult(((2 * BITS) * (197 + 1)) - 1 DOWNTO ((2 * BITS) * (197))) + 
    s_mult(((2 * BITS) * (198 + 1)) - 1 DOWNTO ((2 * BITS) * (198))) + 
    s_mult(((2 * BITS) * (199 + 1)) - 1 DOWNTO ((2 * BITS) * (199))) + 
    s_mult(((2 * BITS) * (200 + 1)) - 1 DOWNTO ((2 * BITS) * (200))) + 
    s_mult(((2 * BITS) * (201 + 1)) - 1 DOWNTO ((2 * BITS) * (201))) + 
    s_mult(((2 * BITS) * (202 + 1)) - 1 DOWNTO ((2 * BITS) * (202))) + 
    s_mult(((2 * BITS) * (203 + 1)) - 1 DOWNTO ((2 * BITS) * (203))) + 
    s_mult(((2 * BITS) * (204 + 1)) - 1 DOWNTO ((2 * BITS) * (204))) + 
    s_mult(((2 * BITS) * (205 + 1)) - 1 DOWNTO ((2 * BITS) * (205))) + 
    s_mult(((2 * BITS) * (206 + 1)) - 1 DOWNTO ((2 * BITS) * (206))) + 
    s_mult(((2 * BITS) * (207 + 1)) - 1 DOWNTO ((2 * BITS) * (207))) + 
    s_mult(((2 * BITS) * (208 + 1)) - 1 DOWNTO ((2 * BITS) * (208))) + 
    s_mult(((2 * BITS) * (209 + 1)) - 1 DOWNTO ((2 * BITS) * (209))) + 
    s_mult(((2 * BITS) * (210 + 1)) - 1 DOWNTO ((2 * BITS) * (210))) + 
    s_mult(((2 * BITS) * (211 + 1)) - 1 DOWNTO ((2 * BITS) * (211))) + 
    s_mult(((2 * BITS) * (212 + 1)) - 1 DOWNTO ((2 * BITS) * (212))) + 
    s_mult(((2 * BITS) * (213 + 1)) - 1 DOWNTO ((2 * BITS) * (213))) + 
    s_mult(((2 * BITS) * (214 + 1)) - 1 DOWNTO ((2 * BITS) * (214))) + 
    s_mult(((2 * BITS) * (215 + 1)) - 1 DOWNTO ((2 * BITS) * (215))) + 
    s_mult(((2 * BITS) * (216 + 1)) - 1 DOWNTO ((2 * BITS) * (216))) + 
    s_mult(((2 * BITS) * (217 + 1)) - 1 DOWNTO ((2 * BITS) * (217))) + 
    s_mult(((2 * BITS) * (218 + 1)) - 1 DOWNTO ((2 * BITS) * (218))) + 
    s_mult(((2 * BITS) * (219 + 1)) - 1 DOWNTO ((2 * BITS) * (219))) + 
    s_mult(((2 * BITS) * (220 + 1)) - 1 DOWNTO ((2 * BITS) * (220))) + 
    s_mult(((2 * BITS) * (221 + 1)) - 1 DOWNTO ((2 * BITS) * (221))) + 
    s_mult(((2 * BITS) * (222 + 1)) - 1 DOWNTO ((2 * BITS) * (222))) + 
    s_mult(((2 * BITS) * (223 + 1)) - 1 DOWNTO ((2 * BITS) * (223))) + 
    s_mult(((2 * BITS) * (224 + 1)) - 1 DOWNTO ((2 * BITS) * (224))) + 
    s_mult(((2 * BITS) * (225 + 1)) - 1 DOWNTO ((2 * BITS) * (225))) + 
    s_mult(((2 * BITS) * (226 + 1)) - 1 DOWNTO ((2 * BITS) * (226))) + 
    s_mult(((2 * BITS) * (227 + 1)) - 1 DOWNTO ((2 * BITS) * (227))) + 
    s_mult(((2 * BITS) * (228 + 1)) - 1 DOWNTO ((2 * BITS) * (228))) + 
    s_mult(((2 * BITS) * (229 + 1)) - 1 DOWNTO ((2 * BITS) * (229))) + 
    s_mult(((2 * BITS) * (230 + 1)) - 1 DOWNTO ((2 * BITS) * (230))) + 
    s_mult(((2 * BITS) * (231 + 1)) - 1 DOWNTO ((2 * BITS) * (231))) + 
    s_mult(((2 * BITS) * (232 + 1)) - 1 DOWNTO ((2 * BITS) * (232))) + 
    s_mult(((2 * BITS) * (233 + 1)) - 1 DOWNTO ((2 * BITS) * (233))) + 
    s_mult(((2 * BITS) * (234 + 1)) - 1 DOWNTO ((2 * BITS) * (234))) + 
    s_mult(((2 * BITS) * (235 + 1)) - 1 DOWNTO ((2 * BITS) * (235))) + 
    s_mult(((2 * BITS) * (236 + 1)) - 1 DOWNTO ((2 * BITS) * (236))) + 
    s_mult(((2 * BITS) * (237 + 1)) - 1 DOWNTO ((2 * BITS) * (237))) + 
    s_mult(((2 * BITS) * (238 + 1)) - 1 DOWNTO ((2 * BITS) * (238))) + 
    s_mult(((2 * BITS) * (239 + 1)) - 1 DOWNTO ((2 * BITS) * (239))) + 
    s_mult(((2 * BITS) * (240 + 1)) - 1 DOWNTO ((2 * BITS) * (240))) + 
    s_mult(((2 * BITS) * (241 + 1)) - 1 DOWNTO ((2 * BITS) * (241))) + 
    s_mult(((2 * BITS) * (242 + 1)) - 1 DOWNTO ((2 * BITS) * (242))) + 
    s_mult(((2 * BITS) * (243 + 1)) - 1 DOWNTO ((2 * BITS) * (243))) + 
    s_mult(((2 * BITS) * (244 + 1)) - 1 DOWNTO ((2 * BITS) * (244))) + 
    s_mult(((2 * BITS) * (245 + 1)) - 1 DOWNTO ((2 * BITS) * (245))) + 
    s_mult(((2 * BITS) * (246 + 1)) - 1 DOWNTO ((2 * BITS) * (246))) + 
    s_mult(((2 * BITS) * (247 + 1)) - 1 DOWNTO ((2 * BITS) * (247))) + 
    s_mult(((2 * BITS) * (248 + 1)) - 1 DOWNTO ((2 * BITS) * (248))) + 
    s_mult(((2 * BITS) * (249 + 1)) - 1 DOWNTO ((2 * BITS) * (249))) + 
    s_mult(((2 * BITS) * (250 + 1)) - 1 DOWNTO ((2 * BITS) * (250))) + 
    s_mult(((2 * BITS) * (251 + 1)) - 1 DOWNTO ((2 * BITS) * (251))) + 
    s_mult(((2 * BITS) * (252 + 1)) - 1 DOWNTO ((2 * BITS) * (252))) + 
    s_mult(((2 * BITS) * (253 + 1)) - 1 DOWNTO ((2 * BITS) * (253))) + 
    s_mult(((2 * BITS) * (254 + 1)) - 1 DOWNTO ((2 * BITS) * (254))) + 
    s_mult(((2 * BITS) * (255 + 1)) - 1 DOWNTO ((2 * BITS) * (255))) + 
    s_mult(((2 * BITS) * (256 + 1)) - 1 DOWNTO ((2 * BITS) * (256))) + 
    s_mult(((2 * BITS) * (257 + 1)) - 1 DOWNTO ((2 * BITS) * (257))) + 
    s_mult(((2 * BITS) * (258 + 1)) - 1 DOWNTO ((2 * BITS) * (258))) + 
    s_mult(((2 * BITS) * (259 + 1)) - 1 DOWNTO ((2 * BITS) * (259))) + 
    s_mult(((2 * BITS) * (260 + 1)) - 1 DOWNTO ((2 * BITS) * (260))) + 
    s_mult(((2 * BITS) * (261 + 1)) - 1 DOWNTO ((2 * BITS) * (261))) + 
    s_mult(((2 * BITS) * (262 + 1)) - 1 DOWNTO ((2 * BITS) * (262))) + 
    s_mult(((2 * BITS) * (263 + 1)) - 1 DOWNTO ((2 * BITS) * (263))) + 
    s_mult(((2 * BITS) * (264 + 1)) - 1 DOWNTO ((2 * BITS) * (264))) + 
    s_mult(((2 * BITS) * (265 + 1)) - 1 DOWNTO ((2 * BITS) * (265))) + 
    s_mult(((2 * BITS) * (266 + 1)) - 1 DOWNTO ((2 * BITS) * (266))) + 
    s_mult(((2 * BITS) * (267 + 1)) - 1 DOWNTO ((2 * BITS) * (267))) + 
    s_mult(((2 * BITS) * (268 + 1)) - 1 DOWNTO ((2 * BITS) * (268))) + 
    s_mult(((2 * BITS) * (269 + 1)) - 1 DOWNTO ((2 * BITS) * (269))) + 
    s_mult(((2 * BITS) * (270 + 1)) - 1 DOWNTO ((2 * BITS) * (270))) + 
    s_mult(((2 * BITS) * (271 + 1)) - 1 DOWNTO ((2 * BITS) * (271))) + 
    s_mult(((2 * BITS) * (272 + 1)) - 1 DOWNTO ((2 * BITS) * (272))) + 
    s_mult(((2 * BITS) * (273 + 1)) - 1 DOWNTO ((2 * BITS) * (273))) + 
    s_mult(((2 * BITS) * (274 + 1)) - 1 DOWNTO ((2 * BITS) * (274))) + 
    s_mult(((2 * BITS) * (275 + 1)) - 1 DOWNTO ((2 * BITS) * (275))) + 
    s_mult(((2 * BITS) * (276 + 1)) - 1 DOWNTO ((2 * BITS) * (276))) + 
    s_mult(((2 * BITS) * (277 + 1)) - 1 DOWNTO ((2 * BITS) * (277))) + 
    s_mult(((2 * BITS) * (278 + 1)) - 1 DOWNTO ((2 * BITS) * (278))) + 
    s_mult(((2 * BITS) * (279 + 1)) - 1 DOWNTO ((2 * BITS) * (279))) + 
    s_mult(((2 * BITS) * (280 + 1)) - 1 DOWNTO ((2 * BITS) * (280))) + 
    s_mult(((2 * BITS) * (281 + 1)) - 1 DOWNTO ((2 * BITS) * (281))) + 
    s_mult(((2 * BITS) * (282 + 1)) - 1 DOWNTO ((2 * BITS) * (282))) + 
    s_mult(((2 * BITS) * (283 + 1)) - 1 DOWNTO ((2 * BITS) * (283))) + 
    s_mult(((2 * BITS) * (284 + 1)) - 1 DOWNTO ((2 * BITS) * (284))) + 
    s_mult(((2 * BITS) * (285 + 1)) - 1 DOWNTO ((2 * BITS) * (285))) + 
    s_mult(((2 * BITS) * (286 + 1)) - 1 DOWNTO ((2 * BITS) * (286))) + 
    s_mult(((2 * BITS) * (287 + 1)) - 1 DOWNTO ((2 * BITS) * (287))) + 
    s_mult(((2 * BITS) * (288 + 1)) - 1 DOWNTO ((2 * BITS) * (288))) + 
    s_mult(((2 * BITS) * (289 + 1)) - 1 DOWNTO ((2 * BITS) * (289))) + 
    s_mult(((2 * BITS) * (290 + 1)) - 1 DOWNTO ((2 * BITS) * (290))) + 
    s_mult(((2 * BITS) * (291 + 1)) - 1 DOWNTO ((2 * BITS) * (291))) + 
    s_mult(((2 * BITS) * (292 + 1)) - 1 DOWNTO ((2 * BITS) * (292))) + 
    s_mult(((2 * BITS) * (293 + 1)) - 1 DOWNTO ((2 * BITS) * (293))) + 
    s_mult(((2 * BITS) * (294 + 1)) - 1 DOWNTO ((2 * BITS) * (294))) + 
    s_mult(((2 * BITS) * (295 + 1)) - 1 DOWNTO ((2 * BITS) * (295))) + 
    s_mult(((2 * BITS) * (296 + 1)) - 1 DOWNTO ((2 * BITS) * (296))) + 
    s_mult(((2 * BITS) * (297 + 1)) - 1 DOWNTO ((2 * BITS) * (297))) + 
    s_mult(((2 * BITS) * (298 + 1)) - 1 DOWNTO ((2 * BITS) * (298))) + 
    s_mult(((2 * BITS) * (299 + 1)) - 1 DOWNTO ((2 * BITS) * (299))) + 
    s_Win((BITS * (300 + 1)) - 1 DOWNTO (BITS * (300)))); 

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

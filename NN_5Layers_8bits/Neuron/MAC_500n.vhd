LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
USE work.parameters.ALL;

  ENTITY  MAC_500n IS
    GENERIC (
        BITS : NATURAL := BITS;
        NUM_INPUTS : NATURAL := 500;
        TOTAL_BITS : NATURAL := 4000
    );
    PORT (
      clk, rst: IN STD_LOGIC;
      IO_in : IN signed(TOTAL_BITS - 1 DOWNTO 0);
      W_in : IN signed((BITS * (NUM_INPUTS + 1)) - 1 DOWNTO 0);
      ----------------------------------------------
      IO_out: OUT signed(7 DOWNTO 0)
    );
  end ENTITY;

ARCHITECTURE arch OF  MAC_500n  IS

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
    s_mult(((2 * BITS) * (300 + 1)) - 1 DOWNTO ((2 * BITS) * (300))) + 
    s_mult(((2 * BITS) * (301 + 1)) - 1 DOWNTO ((2 * BITS) * (301))) + 
    s_mult(((2 * BITS) * (302 + 1)) - 1 DOWNTO ((2 * BITS) * (302))) + 
    s_mult(((2 * BITS) * (303 + 1)) - 1 DOWNTO ((2 * BITS) * (303))) + 
    s_mult(((2 * BITS) * (304 + 1)) - 1 DOWNTO ((2 * BITS) * (304))) + 
    s_mult(((2 * BITS) * (305 + 1)) - 1 DOWNTO ((2 * BITS) * (305))) + 
    s_mult(((2 * BITS) * (306 + 1)) - 1 DOWNTO ((2 * BITS) * (306))) + 
    s_mult(((2 * BITS) * (307 + 1)) - 1 DOWNTO ((2 * BITS) * (307))) + 
    s_mult(((2 * BITS) * (308 + 1)) - 1 DOWNTO ((2 * BITS) * (308))) + 
    s_mult(((2 * BITS) * (309 + 1)) - 1 DOWNTO ((2 * BITS) * (309))) + 
    s_mult(((2 * BITS) * (310 + 1)) - 1 DOWNTO ((2 * BITS) * (310))) + 
    s_mult(((2 * BITS) * (311 + 1)) - 1 DOWNTO ((2 * BITS) * (311))) + 
    s_mult(((2 * BITS) * (312 + 1)) - 1 DOWNTO ((2 * BITS) * (312))) + 
    s_mult(((2 * BITS) * (313 + 1)) - 1 DOWNTO ((2 * BITS) * (313))) + 
    s_mult(((2 * BITS) * (314 + 1)) - 1 DOWNTO ((2 * BITS) * (314))) + 
    s_mult(((2 * BITS) * (315 + 1)) - 1 DOWNTO ((2 * BITS) * (315))) + 
    s_mult(((2 * BITS) * (316 + 1)) - 1 DOWNTO ((2 * BITS) * (316))) + 
    s_mult(((2 * BITS) * (317 + 1)) - 1 DOWNTO ((2 * BITS) * (317))) + 
    s_mult(((2 * BITS) * (318 + 1)) - 1 DOWNTO ((2 * BITS) * (318))) + 
    s_mult(((2 * BITS) * (319 + 1)) - 1 DOWNTO ((2 * BITS) * (319))) + 
    s_mult(((2 * BITS) * (320 + 1)) - 1 DOWNTO ((2 * BITS) * (320))) + 
    s_mult(((2 * BITS) * (321 + 1)) - 1 DOWNTO ((2 * BITS) * (321))) + 
    s_mult(((2 * BITS) * (322 + 1)) - 1 DOWNTO ((2 * BITS) * (322))) + 
    s_mult(((2 * BITS) * (323 + 1)) - 1 DOWNTO ((2 * BITS) * (323))) + 
    s_mult(((2 * BITS) * (324 + 1)) - 1 DOWNTO ((2 * BITS) * (324))) + 
    s_mult(((2 * BITS) * (325 + 1)) - 1 DOWNTO ((2 * BITS) * (325))) + 
    s_mult(((2 * BITS) * (326 + 1)) - 1 DOWNTO ((2 * BITS) * (326))) + 
    s_mult(((2 * BITS) * (327 + 1)) - 1 DOWNTO ((2 * BITS) * (327))) + 
    s_mult(((2 * BITS) * (328 + 1)) - 1 DOWNTO ((2 * BITS) * (328))) + 
    s_mult(((2 * BITS) * (329 + 1)) - 1 DOWNTO ((2 * BITS) * (329))) + 
    s_mult(((2 * BITS) * (330 + 1)) - 1 DOWNTO ((2 * BITS) * (330))) + 
    s_mult(((2 * BITS) * (331 + 1)) - 1 DOWNTO ((2 * BITS) * (331))) + 
    s_mult(((2 * BITS) * (332 + 1)) - 1 DOWNTO ((2 * BITS) * (332))) + 
    s_mult(((2 * BITS) * (333 + 1)) - 1 DOWNTO ((2 * BITS) * (333))) + 
    s_mult(((2 * BITS) * (334 + 1)) - 1 DOWNTO ((2 * BITS) * (334))) + 
    s_mult(((2 * BITS) * (335 + 1)) - 1 DOWNTO ((2 * BITS) * (335))) + 
    s_mult(((2 * BITS) * (336 + 1)) - 1 DOWNTO ((2 * BITS) * (336))) + 
    s_mult(((2 * BITS) * (337 + 1)) - 1 DOWNTO ((2 * BITS) * (337))) + 
    s_mult(((2 * BITS) * (338 + 1)) - 1 DOWNTO ((2 * BITS) * (338))) + 
    s_mult(((2 * BITS) * (339 + 1)) - 1 DOWNTO ((2 * BITS) * (339))) + 
    s_mult(((2 * BITS) * (340 + 1)) - 1 DOWNTO ((2 * BITS) * (340))) + 
    s_mult(((2 * BITS) * (341 + 1)) - 1 DOWNTO ((2 * BITS) * (341))) + 
    s_mult(((2 * BITS) * (342 + 1)) - 1 DOWNTO ((2 * BITS) * (342))) + 
    s_mult(((2 * BITS) * (343 + 1)) - 1 DOWNTO ((2 * BITS) * (343))) + 
    s_mult(((2 * BITS) * (344 + 1)) - 1 DOWNTO ((2 * BITS) * (344))) + 
    s_mult(((2 * BITS) * (345 + 1)) - 1 DOWNTO ((2 * BITS) * (345))) + 
    s_mult(((2 * BITS) * (346 + 1)) - 1 DOWNTO ((2 * BITS) * (346))) + 
    s_mult(((2 * BITS) * (347 + 1)) - 1 DOWNTO ((2 * BITS) * (347))) + 
    s_mult(((2 * BITS) * (348 + 1)) - 1 DOWNTO ((2 * BITS) * (348))) + 
    s_mult(((2 * BITS) * (349 + 1)) - 1 DOWNTO ((2 * BITS) * (349))) + 
    s_mult(((2 * BITS) * (350 + 1)) - 1 DOWNTO ((2 * BITS) * (350))) + 
    s_mult(((2 * BITS) * (351 + 1)) - 1 DOWNTO ((2 * BITS) * (351))) + 
    s_mult(((2 * BITS) * (352 + 1)) - 1 DOWNTO ((2 * BITS) * (352))) + 
    s_mult(((2 * BITS) * (353 + 1)) - 1 DOWNTO ((2 * BITS) * (353))) + 
    s_mult(((2 * BITS) * (354 + 1)) - 1 DOWNTO ((2 * BITS) * (354))) + 
    s_mult(((2 * BITS) * (355 + 1)) - 1 DOWNTO ((2 * BITS) * (355))) + 
    s_mult(((2 * BITS) * (356 + 1)) - 1 DOWNTO ((2 * BITS) * (356))) + 
    s_mult(((2 * BITS) * (357 + 1)) - 1 DOWNTO ((2 * BITS) * (357))) + 
    s_mult(((2 * BITS) * (358 + 1)) - 1 DOWNTO ((2 * BITS) * (358))) + 
    s_mult(((2 * BITS) * (359 + 1)) - 1 DOWNTO ((2 * BITS) * (359))) + 
    s_mult(((2 * BITS) * (360 + 1)) - 1 DOWNTO ((2 * BITS) * (360))) + 
    s_mult(((2 * BITS) * (361 + 1)) - 1 DOWNTO ((2 * BITS) * (361))) + 
    s_mult(((2 * BITS) * (362 + 1)) - 1 DOWNTO ((2 * BITS) * (362))) + 
    s_mult(((2 * BITS) * (363 + 1)) - 1 DOWNTO ((2 * BITS) * (363))) + 
    s_mult(((2 * BITS) * (364 + 1)) - 1 DOWNTO ((2 * BITS) * (364))) + 
    s_mult(((2 * BITS) * (365 + 1)) - 1 DOWNTO ((2 * BITS) * (365))) + 
    s_mult(((2 * BITS) * (366 + 1)) - 1 DOWNTO ((2 * BITS) * (366))) + 
    s_mult(((2 * BITS) * (367 + 1)) - 1 DOWNTO ((2 * BITS) * (367))) + 
    s_mult(((2 * BITS) * (368 + 1)) - 1 DOWNTO ((2 * BITS) * (368))) + 
    s_mult(((2 * BITS) * (369 + 1)) - 1 DOWNTO ((2 * BITS) * (369))) + 
    s_mult(((2 * BITS) * (370 + 1)) - 1 DOWNTO ((2 * BITS) * (370))) + 
    s_mult(((2 * BITS) * (371 + 1)) - 1 DOWNTO ((2 * BITS) * (371))) + 
    s_mult(((2 * BITS) * (372 + 1)) - 1 DOWNTO ((2 * BITS) * (372))) + 
    s_mult(((2 * BITS) * (373 + 1)) - 1 DOWNTO ((2 * BITS) * (373))) + 
    s_mult(((2 * BITS) * (374 + 1)) - 1 DOWNTO ((2 * BITS) * (374))) + 
    s_mult(((2 * BITS) * (375 + 1)) - 1 DOWNTO ((2 * BITS) * (375))) + 
    s_mult(((2 * BITS) * (376 + 1)) - 1 DOWNTO ((2 * BITS) * (376))) + 
    s_mult(((2 * BITS) * (377 + 1)) - 1 DOWNTO ((2 * BITS) * (377))) + 
    s_mult(((2 * BITS) * (378 + 1)) - 1 DOWNTO ((2 * BITS) * (378))) + 
    s_mult(((2 * BITS) * (379 + 1)) - 1 DOWNTO ((2 * BITS) * (379))) + 
    s_mult(((2 * BITS) * (380 + 1)) - 1 DOWNTO ((2 * BITS) * (380))) + 
    s_mult(((2 * BITS) * (381 + 1)) - 1 DOWNTO ((2 * BITS) * (381))) + 
    s_mult(((2 * BITS) * (382 + 1)) - 1 DOWNTO ((2 * BITS) * (382))) + 
    s_mult(((2 * BITS) * (383 + 1)) - 1 DOWNTO ((2 * BITS) * (383))) + 
    s_mult(((2 * BITS) * (384 + 1)) - 1 DOWNTO ((2 * BITS) * (384))) + 
    s_mult(((2 * BITS) * (385 + 1)) - 1 DOWNTO ((2 * BITS) * (385))) + 
    s_mult(((2 * BITS) * (386 + 1)) - 1 DOWNTO ((2 * BITS) * (386))) + 
    s_mult(((2 * BITS) * (387 + 1)) - 1 DOWNTO ((2 * BITS) * (387))) + 
    s_mult(((2 * BITS) * (388 + 1)) - 1 DOWNTO ((2 * BITS) * (388))) + 
    s_mult(((2 * BITS) * (389 + 1)) - 1 DOWNTO ((2 * BITS) * (389))) + 
    s_mult(((2 * BITS) * (390 + 1)) - 1 DOWNTO ((2 * BITS) * (390))) + 
    s_mult(((2 * BITS) * (391 + 1)) - 1 DOWNTO ((2 * BITS) * (391))) + 
    s_mult(((2 * BITS) * (392 + 1)) - 1 DOWNTO ((2 * BITS) * (392))) + 
    s_mult(((2 * BITS) * (393 + 1)) - 1 DOWNTO ((2 * BITS) * (393))) + 
    s_mult(((2 * BITS) * (394 + 1)) - 1 DOWNTO ((2 * BITS) * (394))) + 
    s_mult(((2 * BITS) * (395 + 1)) - 1 DOWNTO ((2 * BITS) * (395))) + 
    s_mult(((2 * BITS) * (396 + 1)) - 1 DOWNTO ((2 * BITS) * (396))) + 
    s_mult(((2 * BITS) * (397 + 1)) - 1 DOWNTO ((2 * BITS) * (397))) + 
    s_mult(((2 * BITS) * (398 + 1)) - 1 DOWNTO ((2 * BITS) * (398))) + 
    s_mult(((2 * BITS) * (399 + 1)) - 1 DOWNTO ((2 * BITS) * (399))) + 
    s_mult(((2 * BITS) * (400 + 1)) - 1 DOWNTO ((2 * BITS) * (400))) + 
    s_mult(((2 * BITS) * (401 + 1)) - 1 DOWNTO ((2 * BITS) * (401))) + 
    s_mult(((2 * BITS) * (402 + 1)) - 1 DOWNTO ((2 * BITS) * (402))) + 
    s_mult(((2 * BITS) * (403 + 1)) - 1 DOWNTO ((2 * BITS) * (403))) + 
    s_mult(((2 * BITS) * (404 + 1)) - 1 DOWNTO ((2 * BITS) * (404))) + 
    s_mult(((2 * BITS) * (405 + 1)) - 1 DOWNTO ((2 * BITS) * (405))) + 
    s_mult(((2 * BITS) * (406 + 1)) - 1 DOWNTO ((2 * BITS) * (406))) + 
    s_mult(((2 * BITS) * (407 + 1)) - 1 DOWNTO ((2 * BITS) * (407))) + 
    s_mult(((2 * BITS) * (408 + 1)) - 1 DOWNTO ((2 * BITS) * (408))) + 
    s_mult(((2 * BITS) * (409 + 1)) - 1 DOWNTO ((2 * BITS) * (409))) + 
    s_mult(((2 * BITS) * (410 + 1)) - 1 DOWNTO ((2 * BITS) * (410))) + 
    s_mult(((2 * BITS) * (411 + 1)) - 1 DOWNTO ((2 * BITS) * (411))) + 
    s_mult(((2 * BITS) * (412 + 1)) - 1 DOWNTO ((2 * BITS) * (412))) + 
    s_mult(((2 * BITS) * (413 + 1)) - 1 DOWNTO ((2 * BITS) * (413))) + 
    s_mult(((2 * BITS) * (414 + 1)) - 1 DOWNTO ((2 * BITS) * (414))) + 
    s_mult(((2 * BITS) * (415 + 1)) - 1 DOWNTO ((2 * BITS) * (415))) + 
    s_mult(((2 * BITS) * (416 + 1)) - 1 DOWNTO ((2 * BITS) * (416))) + 
    s_mult(((2 * BITS) * (417 + 1)) - 1 DOWNTO ((2 * BITS) * (417))) + 
    s_mult(((2 * BITS) * (418 + 1)) - 1 DOWNTO ((2 * BITS) * (418))) + 
    s_mult(((2 * BITS) * (419 + 1)) - 1 DOWNTO ((2 * BITS) * (419))) + 
    s_mult(((2 * BITS) * (420 + 1)) - 1 DOWNTO ((2 * BITS) * (420))) + 
    s_mult(((2 * BITS) * (421 + 1)) - 1 DOWNTO ((2 * BITS) * (421))) + 
    s_mult(((2 * BITS) * (422 + 1)) - 1 DOWNTO ((2 * BITS) * (422))) + 
    s_mult(((2 * BITS) * (423 + 1)) - 1 DOWNTO ((2 * BITS) * (423))) + 
    s_mult(((2 * BITS) * (424 + 1)) - 1 DOWNTO ((2 * BITS) * (424))) + 
    s_mult(((2 * BITS) * (425 + 1)) - 1 DOWNTO ((2 * BITS) * (425))) + 
    s_mult(((2 * BITS) * (426 + 1)) - 1 DOWNTO ((2 * BITS) * (426))) + 
    s_mult(((2 * BITS) * (427 + 1)) - 1 DOWNTO ((2 * BITS) * (427))) + 
    s_mult(((2 * BITS) * (428 + 1)) - 1 DOWNTO ((2 * BITS) * (428))) + 
    s_mult(((2 * BITS) * (429 + 1)) - 1 DOWNTO ((2 * BITS) * (429))) + 
    s_mult(((2 * BITS) * (430 + 1)) - 1 DOWNTO ((2 * BITS) * (430))) + 
    s_mult(((2 * BITS) * (431 + 1)) - 1 DOWNTO ((2 * BITS) * (431))) + 
    s_mult(((2 * BITS) * (432 + 1)) - 1 DOWNTO ((2 * BITS) * (432))) + 
    s_mult(((2 * BITS) * (433 + 1)) - 1 DOWNTO ((2 * BITS) * (433))) + 
    s_mult(((2 * BITS) * (434 + 1)) - 1 DOWNTO ((2 * BITS) * (434))) + 
    s_mult(((2 * BITS) * (435 + 1)) - 1 DOWNTO ((2 * BITS) * (435))) + 
    s_mult(((2 * BITS) * (436 + 1)) - 1 DOWNTO ((2 * BITS) * (436))) + 
    s_mult(((2 * BITS) * (437 + 1)) - 1 DOWNTO ((2 * BITS) * (437))) + 
    s_mult(((2 * BITS) * (438 + 1)) - 1 DOWNTO ((2 * BITS) * (438))) + 
    s_mult(((2 * BITS) * (439 + 1)) - 1 DOWNTO ((2 * BITS) * (439))) + 
    s_mult(((2 * BITS) * (440 + 1)) - 1 DOWNTO ((2 * BITS) * (440))) + 
    s_mult(((2 * BITS) * (441 + 1)) - 1 DOWNTO ((2 * BITS) * (441))) + 
    s_mult(((2 * BITS) * (442 + 1)) - 1 DOWNTO ((2 * BITS) * (442))) + 
    s_mult(((2 * BITS) * (443 + 1)) - 1 DOWNTO ((2 * BITS) * (443))) + 
    s_mult(((2 * BITS) * (444 + 1)) - 1 DOWNTO ((2 * BITS) * (444))) + 
    s_mult(((2 * BITS) * (445 + 1)) - 1 DOWNTO ((2 * BITS) * (445))) + 
    s_mult(((2 * BITS) * (446 + 1)) - 1 DOWNTO ((2 * BITS) * (446))) + 
    s_mult(((2 * BITS) * (447 + 1)) - 1 DOWNTO ((2 * BITS) * (447))) + 
    s_mult(((2 * BITS) * (448 + 1)) - 1 DOWNTO ((2 * BITS) * (448))) + 
    s_mult(((2 * BITS) * (449 + 1)) - 1 DOWNTO ((2 * BITS) * (449))) + 
    s_mult(((2 * BITS) * (450 + 1)) - 1 DOWNTO ((2 * BITS) * (450))) + 
    s_mult(((2 * BITS) * (451 + 1)) - 1 DOWNTO ((2 * BITS) * (451))) + 
    s_mult(((2 * BITS) * (452 + 1)) - 1 DOWNTO ((2 * BITS) * (452))) + 
    s_mult(((2 * BITS) * (453 + 1)) - 1 DOWNTO ((2 * BITS) * (453))) + 
    s_mult(((2 * BITS) * (454 + 1)) - 1 DOWNTO ((2 * BITS) * (454))) + 
    s_mult(((2 * BITS) * (455 + 1)) - 1 DOWNTO ((2 * BITS) * (455))) + 
    s_mult(((2 * BITS) * (456 + 1)) - 1 DOWNTO ((2 * BITS) * (456))) + 
    s_mult(((2 * BITS) * (457 + 1)) - 1 DOWNTO ((2 * BITS) * (457))) + 
    s_mult(((2 * BITS) * (458 + 1)) - 1 DOWNTO ((2 * BITS) * (458))) + 
    s_mult(((2 * BITS) * (459 + 1)) - 1 DOWNTO ((2 * BITS) * (459))) + 
    s_mult(((2 * BITS) * (460 + 1)) - 1 DOWNTO ((2 * BITS) * (460))) + 
    s_mult(((2 * BITS) * (461 + 1)) - 1 DOWNTO ((2 * BITS) * (461))) + 
    s_mult(((2 * BITS) * (462 + 1)) - 1 DOWNTO ((2 * BITS) * (462))) + 
    s_mult(((2 * BITS) * (463 + 1)) - 1 DOWNTO ((2 * BITS) * (463))) + 
    s_mult(((2 * BITS) * (464 + 1)) - 1 DOWNTO ((2 * BITS) * (464))) + 
    s_mult(((2 * BITS) * (465 + 1)) - 1 DOWNTO ((2 * BITS) * (465))) + 
    s_mult(((2 * BITS) * (466 + 1)) - 1 DOWNTO ((2 * BITS) * (466))) + 
    s_mult(((2 * BITS) * (467 + 1)) - 1 DOWNTO ((2 * BITS) * (467))) + 
    s_mult(((2 * BITS) * (468 + 1)) - 1 DOWNTO ((2 * BITS) * (468))) + 
    s_mult(((2 * BITS) * (469 + 1)) - 1 DOWNTO ((2 * BITS) * (469))) + 
    s_mult(((2 * BITS) * (470 + 1)) - 1 DOWNTO ((2 * BITS) * (470))) + 
    s_mult(((2 * BITS) * (471 + 1)) - 1 DOWNTO ((2 * BITS) * (471))) + 
    s_mult(((2 * BITS) * (472 + 1)) - 1 DOWNTO ((2 * BITS) * (472))) + 
    s_mult(((2 * BITS) * (473 + 1)) - 1 DOWNTO ((2 * BITS) * (473))) + 
    s_mult(((2 * BITS) * (474 + 1)) - 1 DOWNTO ((2 * BITS) * (474))) + 
    s_mult(((2 * BITS) * (475 + 1)) - 1 DOWNTO ((2 * BITS) * (475))) + 
    s_mult(((2 * BITS) * (476 + 1)) - 1 DOWNTO ((2 * BITS) * (476))) + 
    s_mult(((2 * BITS) * (477 + 1)) - 1 DOWNTO ((2 * BITS) * (477))) + 
    s_mult(((2 * BITS) * (478 + 1)) - 1 DOWNTO ((2 * BITS) * (478))) + 
    s_mult(((2 * BITS) * (479 + 1)) - 1 DOWNTO ((2 * BITS) * (479))) + 
    s_mult(((2 * BITS) * (480 + 1)) - 1 DOWNTO ((2 * BITS) * (480))) + 
    s_mult(((2 * BITS) * (481 + 1)) - 1 DOWNTO ((2 * BITS) * (481))) + 
    s_mult(((2 * BITS) * (482 + 1)) - 1 DOWNTO ((2 * BITS) * (482))) + 
    s_mult(((2 * BITS) * (483 + 1)) - 1 DOWNTO ((2 * BITS) * (483))) + 
    s_mult(((2 * BITS) * (484 + 1)) - 1 DOWNTO ((2 * BITS) * (484))) + 
    s_mult(((2 * BITS) * (485 + 1)) - 1 DOWNTO ((2 * BITS) * (485))) + 
    s_mult(((2 * BITS) * (486 + 1)) - 1 DOWNTO ((2 * BITS) * (486))) + 
    s_mult(((2 * BITS) * (487 + 1)) - 1 DOWNTO ((2 * BITS) * (487))) + 
    s_mult(((2 * BITS) * (488 + 1)) - 1 DOWNTO ((2 * BITS) * (488))) + 
    s_mult(((2 * BITS) * (489 + 1)) - 1 DOWNTO ((2 * BITS) * (489))) + 
    s_mult(((2 * BITS) * (490 + 1)) - 1 DOWNTO ((2 * BITS) * (490))) + 
    s_mult(((2 * BITS) * (491 + 1)) - 1 DOWNTO ((2 * BITS) * (491))) + 
    s_mult(((2 * BITS) * (492 + 1)) - 1 DOWNTO ((2 * BITS) * (492))) + 
    s_mult(((2 * BITS) * (493 + 1)) - 1 DOWNTO ((2 * BITS) * (493))) + 
    s_mult(((2 * BITS) * (494 + 1)) - 1 DOWNTO ((2 * BITS) * (494))) + 
    s_mult(((2 * BITS) * (495 + 1)) - 1 DOWNTO ((2 * BITS) * (495))) + 
    s_mult(((2 * BITS) * (496 + 1)) - 1 DOWNTO ((2 * BITS) * (496))) + 
    s_mult(((2 * BITS) * (497 + 1)) - 1 DOWNTO ((2 * BITS) * (497))) + 
    s_mult(((2 * BITS) * (498 + 1)) - 1 DOWNTO ((2 * BITS) * (498))) + 
    s_mult(((2 * BITS) * (499 + 1)) - 1 DOWNTO ((2 * BITS) * (499))) + 
    s_Win((BITS * (500 + 1)) - 1 DOWNTO (BITS * (500)))); 

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

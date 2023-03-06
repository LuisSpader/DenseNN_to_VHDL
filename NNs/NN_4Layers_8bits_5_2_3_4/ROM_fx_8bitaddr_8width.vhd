

--https://stackoverflow.com/questions/17579716/implementing-rom-in-xilinx-vhdl
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

----------------

ENTITY ROM_fx_8bitaddr_8width IS
	GENERIC (
		addr_width : INTEGER := 256; -- store 256 elements 
		addr_bits  : INTEGER := 8;   -- required bits to store 256 elements
		data_width : INTEGER := 8    -- each element has 8-bits
	);

	PORT (
		address  : IN STD_LOGIC_VECTOR(addr_bits - 1 DOWNTO 0) := (OTHERS => '0');
		data_out : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
	);
END ENTITY;

------------------
ARCHITECTURE arch OF ROM_fx_8bitaddr_8width IS

	TYPE memory IS ARRAY (0 TO addr_width - 1) OF STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
	CONSTANT myROM : memory := (

		--"bin_data",-- address(sum) || f(x) 
		"01000000", -- (00000000)0.0 || 0.5
		"01000010", -- (00000001)0.0078125 || 0.5124973964842103
		"01000011", -- (00000010)0.015625 || 0.52497918747894
		"01000101", -- (00000011)0.0234375 || 0.5374298453437496
		"01000110", -- (00000100)0.03125 || 0.549833997312478
		"01001000", -- (00000101)0.0390625 || 0.5621765008857981
		"01001010", -- (00000110)0.046875 || 0.574442516811659
		"01001011", -- (00000111)0.0546875 || 0.5866175789173301
		"01001101", -- (00001000)0.0625 || 0.598687660112452
		"01001110", -- (00001001)0.0703125 || 0.610639233949222
		"01010000", -- (00001010)0.078125 || 0.6224593312018546
		"01010001", -- (00001011)0.0859375 || 0.6341355910108007
		"01010011", -- (00001100)0.09375 || 0.6456563062257954
		"01010100", -- (00001101)0.1015625 || 0.6570104626734988
		"01010110", -- (00001110)0.109375 || 0.6681877721681662
		"01010111", -- (00001111)0.1171875 || 0.679178699175393
		"01011000", -- (00010000)0.125 || 0.6899744811276125
		"01011010", -- (00010001)0.1328125 || 0.700567142473973
		"01011011", -- (00010010)0.140625 || 0.7109495026250039
		"01011100", -- (00010011)0.1484375 || 0.7211151780228631
		"01011110", -- (00010100)0.15625 || 0.7310585786300049
		"01011111", -- (00010101)0.1640625 || 0.740774899182154
		"01100000", -- (00010110)0.171875 || 0.7502601055951177
		"01100001", -- (00010111)0.1796875 || 0.759510916949111
		"01100010", -- (00011000)0.1875 || 0.7685247834990178
		"01100011", -- (00011001)0.1953125 || 0.7772998611746911
		"01100101", -- (00011010)0.203125 || 0.7858349830425586
		"01100110", -- (00011011)0.2109375 || 0.7941296281990528
		"01100111", -- (00011100)0.21875 || 0.8021838885585818
		"01101000", -- (00011101)0.2265625 || 0.8099984339846871
		"01101001", -- (00011110)0.234375 || 0.8175744761936437
		"01101010", -- (00011111)0.2421875 || 0.8249137318359602
		"01101010", -- (00100000)0.25 || 0.8320183851339245
		"01101011", -- (00100001)0.2578125 || 0.8388910504234147
		"01101100", -- (00100010)0.265625 || 0.8455347349164652
		"01101101", -- (00100011)0.2734375 || 0.8519528019683106
		"01101110", -- (00100100)0.28125 || 0.8581489350995123
		"01101111", -- (00100101)0.2890625 || 0.8641271029909058
		"01101111", -- (00100110)0.296875 || 0.8698915256370021
		"01110000", -- (00100111)0.3046875 || 0.8754466418125836
		"01110001", -- (00101000)0.3125 || 0.8807970779778823
		"01110001", -- (00101001)0.3203125 || 0.8859476187202091
		"01110010", -- (00101010)0.328125 || 0.8909031788043871
		"01110011", -- (00101011)0.3359375 || 0.8956687768809987
		"01110011", -- (00101100)0.34375 || 0.9002495108803148
		"01110100", -- (00101101)0.3515625 || 0.9046505351008906
		"01110100", -- (00101110)0.359375 || 0.9088770389851438
		"01110101", -- (00101111)0.3671875 || 0.9129342275597286
		"01110101", -- (00110000)0.375 || 0.9168273035060777
		"01110110", -- (00110001)0.3828125 || 0.9205614508160216
		"01110110", -- (00110010)0.390625 || 0.9241418199787566
		"01110111", -- (00110011)0.3984375 || 0.9275735146384823
		"01110111", -- (00110100)0.40625 || 0.9308615796566533
		"01111000", -- (00110101)0.4140625 || 0.9340109905087812
		"01111000", -- (00110110)0.421875 || 0.9370266439430035
		"01111000", -- (00110111)0.4296875 || 0.9399133498259924
		"01111001", -- (00111000)0.4375 || 0.9426758241011313
		"01111001", -- (00111001)0.4453125 || 0.9453186827840592
		"01111001", -- (00111010)0.453125 || 0.9478464369215823
		"01111010", -- (00111011)0.4609375 || 0.9502634884414434
		"01111010", -- (00111100)0.46875 || 0.9525741268224334
		"01111010", -- (00111101)0.4765625 || 0.9547825265167125
		"01111010", -- (00111110)0.484375 || 0.9568927450589139
		"01111011", -- (00111111)0.4921875 || 0.958908721799535
		"01111011", -- (01000000)0.5 || 0.9608342772032357
		"01111011", -- (01000001)0.5078125 || 0.9626731126558706
		"01111011", -- (01000010)0.515625 || 0.9644288107273639
		"01111100", -- (01000011)0.5234375 || 0.9661048358408219
		"01111100", -- (01000100)0.53125 || 0.9677045353015495
		"01111100", -- (01000101)0.5390625 || 0.969231140642852
		"01111100", -- (01000110)0.546875 || 0.9706877692486436
		"01111100", -- (01000111)0.5546875 || 0.9720774262159271
		"01111101", -- (01001000)0.5625 || 0.973403006423134
		"01111101", -- (01001001)0.5703125 || 0.9746672967731284
		"01111101", -- (01001010)0.578125 || 0.9758729785823308
		"01111101", -- (01001011)0.5859375 || 0.9770226300899744
		"01111101", -- (01001100)0.59375 || 0.9781187290638694
		"01111101", -- (01001101)0.6015625 || 0.9791636554813196
		"01111101", -- (01001110)0.609375 || 0.9801596942659225
		"01111110", -- (01001111)0.6171875 || 0.9811090380629609
		"01111110", -- (01010000)0.625 || 0.9820137900379085
		"01111110", -- (01010001)0.6328125 || 0.9828759666842724
		"01111110", -- (01010010)0.640625 || 0.9836975006285591
		"01111110", -- (01010011)0.6484375 || 0.9844802434215911
		"01111110", -- (01010100)0.65625 || 0.9852259683067269
		"01111110", -- (01010101)0.6640625 || 0.9859363729567544
		"01111110", -- (01010110)0.671875 || 0.9866130821723351
		"01111110", -- (01010111)0.6796875 || 0.9872576505358884
		"01111110", -- (01011000)0.6875 || 0.9878715650157257
		"01111111", -- (01011001)0.6953125 || 0.9884562475160777
		"01111111", -- (01011010)0.703125 || 0.9890130573694068
		"01111111", -- (01011011)0.7109375 || 0.9895432937680818
		"01111111", -- (01011100)0.71875 || 0.9900481981330957
		"01111111", -- (01011101)0.7265625 || 0.9905289564180538
		"01111111", -- (01011110)0.734375 || 0.990986701347152
		"01111111", -- (01011111)0.7421875 || 0.991422514586288
		"01111111", -- (01100000)0.75 || 0.9918374288468401
		"01111111", -- (01100001)0.7578125 || 0.9922324299219849
		"01111111", -- (01100010)0.765625 || 0.9926084586557181
		"01111111", -- (01100011)0.7734375 || 0.9929664128450049
		"01111111", -- (01100100)0.78125 || 0.9933071490757153
		"01111111", -- (01100101)0.7890625 || 0.9936314844931846
		"01111111", -- (01100110)0.796875 || 0.9939401985084158
		"01111111", -- (01100111)0.8046875 || 0.994234034441075
		"01111111", -- (01101000)0.8125 || 0.9945137011005495
		"01111111", -- (01101001)0.8203125 || 0.9947798743064417
		"01111111", -- (01101010)0.828125 || 0.995033198349943
		"01111111", -- (01101011)0.8359375 || 0.9952742873976046
		"01111111", -- (01101100)0.84375 || 0.9955037268390589
		"01111111", -- (01101101)0.8515625 || 0.9957220745802952
		"01111111", -- (01101110)0.859375 || 0.995929862284104
		"01111111", -- (01101111)0.8671875 || 0.9961275965593289
		"01111111", -- (01110000)0.875 || 0.9963157601005641
		"01111111", -- (01110001)0.8828125 || 0.9964948127799336
		"01111111", -- (01110010)0.890625 || 0.9966651926925867
		"01111111", -- (01110011)0.8984375 || 0.9968273171575148
		"01111111", -- (01110100)0.90625 || 0.9969815836752917
		"01111111", -- (01110101)0.9140625 || 0.9971283708442995
		"01111111", -- (01110110)0.921875 || 0.997268039236989
		"01111111", -- (01110111)0.9296875 || 0.9974009322376768
		"01111111", -- (01111000)0.9375 || 0.9975273768433653
		"01111111", -- (01111001)0.9453125 || 0.997647684429022
		"01111111", -- (01111010)0.953125 || 0.9977621514787236
		"01111111", -- (01111011)0.9609375 || 0.9978710602840357
		"01111111", -- (01111100)0.96875 || 0.9979746796109501
		"01111111", -- (01111101)0.9765625 || 0.9980732653366725
		"01111111", -- (01111110)0.984375 || 0.9981670610575072
		"01111111", -- (01111111)0.9921875 || 0.9982562986690452
		"00000000", -- (10000000)-1.0 || 0.0016588010801744215
		"00000000", -- (10000001)-0.9921875 || 0.001743701330954778
		"00000000", -- (10000010)-0.984375 || 0.0018329389424928035
		"00000000", -- (10000011)-0.9765625 || 0.0019267346633274757
		"00000000", -- (10000100)-0.96875 || 0.002025320389049882
		"00000000", -- (10000101)-0.9609375 || 0.0021289397159641892
		"00000000", -- (10000110)-0.953125 || 0.0022378485212763317
		"00000000", -- (10000111)-0.9453125 || 0.0023523155709781456
		"00000000", -- (10001000)-0.9375 || 0.0024726231566347743
		"00000000", -- (10001001)-0.9296875 || 0.002599067762323347
		"00000000", -- (10001010)-0.921875 || 0.002731960763011059
		"00000000", -- (10001011)-0.9140625 || 0.0028716291557003976
		"00000000", -- (10001100)-0.90625 || 0.0030184163247084215
		"00000000", -- (10001101)-0.8984375 || 0.0031726828424851893
		"00000000", -- (10001110)-0.890625 || 0.0033348073074133443
		"00000000", -- (10001111)-0.8828125 || 0.003505187220066338
		"00000000", -- (10010000)-0.875 || 0.003684239899435986
		"00000000", -- (10010001)-0.8671875 || 0.0038724034406710283
		"00000001", -- (10010010)-0.859375 || 0.004070137715896128
		"00000001", -- (10010011)-0.8515625 || 0.004277925419704973
		"00000001", -- (10010100)-0.84375 || 0.004496273160941178
		"00000001", -- (10010101)-0.8359375 || 0.004725712602395478
		"00000001", -- (10010110)-0.828125 || 0.004966801650056957
		"00000001", -- (10010111)-0.8203125 || 0.005220125693558397
		"00000001", -- (10011000)-0.8125 || 0.005486298899450404
		"00000001", -- (10011001)-0.8046875 || 0.005765965558924903
		"00000001", -- (10011010)-0.796875 || 0.00605980149158411
		"00000001", -- (10011011)-0.7890625 || 0.006368515506815542
		"00000001", -- (10011100)-0.78125 || 0.0066928509242848554
		"00000001", -- (10011101)-0.7734375 || 0.007033587154995161
		"00000001", -- (10011110)-0.765625 || 0.007391541344281971
		"00000001", -- (10011111)-0.7578125 || 0.007767570078014998
		"00000001", -- (10100000)-0.75 || 0.00816257115315989
		"00000001", -- (10100001)-0.7421875 || 0.008577485413711984
		"00000001", -- (10100010)-0.734375 || 0.009013298652847822
		"00000001", -- (10100011)-0.7265625 || 0.009471043581946108
		"00000001", -- (10100100)-0.71875 || 0.009951801866904317
		"00000001", -- (10100101)-0.7109375 || 0.010456706231918071
		"00000001", -- (10100110)-0.703125 || 0.01098694263059318
		"00000001", -- (10100111)-0.6953125 || 0.011543752483922289
		"00000010", -- (10101000)-0.6875 || 0.012128434984274237
		"00000010", -- (10101001)-0.6796875 || 0.012742349464111596
		"00000010", -- (10101010)-0.671875 || 0.013386917827664779
		"00000010", -- (10101011)-0.6640625 || 0.014063627043245475
		"00000010", -- (10101100)-0.65625 || 0.014774031693273055
		"00000010", -- (10101101)-0.6484375 || 0.015519756578408886
		"00000010", -- (10101110)-0.640625 || 0.01630249937144093
		"00000010", -- (10101111)-0.6328125 || 0.017124033315727736
		"00000010", -- (10110000)-0.625 || 0.01798620996209156
		"00000010", -- (10110001)-0.6171875 || 0.01889096193703905
		"00000011", -- (10110010)-0.609375 || 0.019840305734077503
		"00000011", -- (10110011)-0.6015625 || 0.020836344518680425
		"00000011", -- (10110100)-0.59375 || 0.021881270936130466
		"00000011", -- (10110101)-0.5859375 || 0.022977369910025615
		"00000011", -- (10110110)-0.578125 || 0.024127021417669196
		"00000011", -- (10110111)-0.5703125 || 0.02533270322687172
		"00000011", -- (10111000)-0.5625 || 0.026596993576865856
		"00000100", -- (10111001)-0.5546875 || 0.027922573784073014
		"00000100", -- (10111010)-0.546875 || 0.02931223075135632
		"00000100", -- (10111011)-0.5390625 || 0.030768859357148008
		"00000100", -- (10111100)-0.53125 || 0.032295464698450495
		"00000100", -- (10111101)-0.5234375 || 0.03389516415917814
		"00000101", -- (10111110)-0.515625 || 0.03557118927263617
		"00000101", -- (10111111)-0.5078125 || 0.03732688734412946
		"00000101", -- (11000000)-0.5 || 0.039165722796764356
		"00000101", -- (11000001)-0.4921875 || 0.041091278200464994
		"00000110", -- (11000010)-0.484375 || 0.043107254941086116
		"00000110", -- (11000011)-0.4765625 || 0.04521747348328748
		"00000110", -- (11000100)-0.46875 || 0.04742587317756678
		"00000110", -- (11000101)-0.4609375 || 0.04973651155855672
		"00000111", -- (11000110)-0.453125 || 0.05215356307841772
		"00000111", -- (11000111)-0.4453125 || 0.05468131721594076
		"00000111", -- (11001000)-0.4375 || 0.05732417589886873
		"00001000", -- (11001001)-0.4296875 || 0.060086650174007626
		"00001000", -- (11001010)-0.421875 || 0.06297335605699649
		"00001000", -- (11001011)-0.4140625 || 0.06598900949121876
		"00001001", -- (11001100)-0.40625 || 0.06913842034334682
		"00001001", -- (11001101)-0.3984375 || 0.07242648536151769
		"00001010", -- (11001110)-0.390625 || 0.07585818002124355
		"00001010", -- (11001111)-0.3828125 || 0.07943854918397836
		"00001011", -- (11010000)-0.375 || 0.08317269649392235
		"00001011", -- (11010001)-0.3671875 || 0.08706577244027125
		"00001100", -- (11010010)-0.359375 || 0.09112296101485612
		"00001100", -- (11010011)-0.3515625 || 0.09534946489910949
		"00001101", -- (11010100)-0.34375 || 0.09975048911968513
		"00001101", -- (11010101)-0.3359375 || 0.10433122311900131
		"00001110", -- (11010110)-0.328125 || 0.10909682119561293
		"00001111", -- (11010111)-0.3203125 || 0.11405238127979084
		"00001111", -- (11011000)-0.3125 || 0.11920292202211755
		"00010000", -- (11011001)-0.3046875 || 0.12455335818741639
		"00010001", -- (11011010)-0.296875 || 0.13010847436299783
		"00010001", -- (11011011)-0.2890625 || 0.13587289700909427
		"00010010", -- (11011100)-0.28125 || 0.14185106490048777
		"00010011", -- (11011101)-0.2734375 || 0.14804719803168948
		"00010100", -- (11011110)-0.265625 || 0.15446526508353467
		"00010101", -- (11011111)-0.2578125 || 0.16110894957658523
		"00010110", -- (11100000)-0.25 || 0.16798161486607552
		"00010110", -- (11100001)-0.2421875 || 0.1750862681640398
		"00010111", -- (11100010)-0.234375 || 0.18242552380635635
		"00011000", -- (11100011)-0.2265625 || 0.19000156601531293
		"00011001", -- (11100100)-0.21875 || 0.19781611144141822
		"00011010", -- (11100101)-0.2109375 || 0.20587037180094733
		"00011011", -- (11100110)-0.203125 || 0.2141650169574414
		"00011101", -- (11100111)-0.1953125 || 0.22270013882530884
		"00011110", -- (11101000)-0.1875 || 0.23147521650098232
		"00011111", -- (11101001)-0.1796875 || 0.24048908305088887
		"00100000", -- (11101010)-0.171875 || 0.24973989440488234
		"00100001", -- (11101011)-0.1640625 || 0.259225100817846
		"00100010", -- (11101100)-0.15625 || 0.2689414213699951
		"00100100", -- (11101101)-0.1484375 || 0.2788848219771369
		"00100101", -- (11101110)-0.140625 || 0.289050497374996
		"00100110", -- (11101111)-0.1328125 || 0.29943285752602705
		"00101000", -- (11110000)-0.125 || 0.31002551887238755
		"00101001", -- (11110001)-0.1171875 || 0.320821300824607
		"00101010", -- (11110010)-0.109375 || 0.3318122278318339
		"00101100", -- (11110011)-0.1015625 || 0.34298953732650117
		"00101101", -- (11110100)-0.09375 || 0.35434369377420455
		"00101111", -- (11110101)-0.0859375 || 0.36586440898919936
		"00110000", -- (11110110)-0.078125 || 0.3775406687981454
		"00110010", -- (11110111)-0.0703125 || 0.389360766050778
		"00110011", -- (11111000)-0.0625 || 0.401312339887548
		"00110101", -- (11111001)-0.0546875 || 0.41338242108267
		"00110110", -- (11111010)-0.046875 || 0.425557483188341
		"00111000", -- (11111011)-0.0390625 || 0.43782349911420193
		"00111010", -- (11111100)-0.03125 || 0.45016600268752216
		"00111011", -- (11111101)-0.0234375 || 0.46257015465625045
		"00111101", -- (11111110)-0.015625 || 0.47502081252106
		"00111110", -- (11111111)-0.0078125 || 0.4875026035157896

		--	2 => "11111111" , --255
		--	3 => "11010101" ,  
		OTHERS => "00000000"
	);

BEGIN
	---------------
	data_out <= myROM(to_integer(unsigned(address))); -- numeric_std
	-- data_out <= myROM(conv_integer(unsigned(address))); -- Std_Logic_Arith

END ARCHITECTURE;
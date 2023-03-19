LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY OSVVM;
USE OSVVM.OsvvmGlobalPkg.ALL;

ENTITY my_tb IS
END ENTITY;

ARCHITECTURE sim OF my_tb IS
    CONSTANT clk_hz     : INTEGER := 100e6;
    CONSTANT clk_period : TIME    := 1 sec / clk_hz;

    -- Declare signals to connect to DUT inputs
    SIGNAL input_1      : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL input_2      : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL output       : STD_LOGIC_VECTOR(16 - 1 DOWNTO 0);

    -- Declare file handle and line variables
    FILE file_handle    : text OPEN read_mode IS "";
    VARIABLE line       : line;
BEGIN
    -- processo gerador de clock
    clk_gen : PROCESS
        --constant period: time := 20 ns;
    BEGIN
        clk <= '0';
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;
    -- Stimulate the DUT with the input values
    dut_inst : ENTITY work.my_block
        PORT MAP(
            input_1 => input_1,
            input_2 => input_2,
            output  => output
        );
    -- Open the text file
    file_handle <= OSVVM_textio.FOpen("relative/path/to/file.txt", OSVVM_textio.read_mode);

    file_io : PROCESS (file_handle)
        VARIABLE str : STRING(line.ALL);

    BEGIN

        -- Read each line of the text file and pass the values to the DUT inputs
        WHILE NOT OSVVM_textio.EndOfFile(file_handle) LOOP
            -- Read the next line from the file
            OSVVM_textio.GetLine(file_handle, line);

            -- Convert the line to a string

            -- Convert the string to input values
            input_1 <= STD_LOGIC_VECTOR(to_unsigned(INTEGER'image(to_integer(unsigned(str(1 TO 4)))), 8));
            input_2 <= STD_LOGIC_VECTOR(to_unsigned(INTEGER'image(to_integer(unsigned(str(5 TO 8)))), 8));

            -- Wait for some time for the DUT to process the input values
            WAIT FOR 10 ns;
        END LOOP;

        -- Close the text file
        OSVVM_textio.FClose(file_handle);

        -- End the simulation
        WAIT;
    END PROCESS;

END ARCHITECTURE;
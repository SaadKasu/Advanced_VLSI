LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench_Multiplexer IS
END testbech_Multiplexer;

ARCHITECTURE testbench_Multiplexer_Behavior OF testbench_Multiplexer IS

    COMPONENT multiplexer 
        PORT (
                dIN1 : IN std_logic;
                dIN2 : IN std_logic;
                ch   : IN std_logic;
                dOUT : OUT std_logic
             );
        END COMPONENT;

    signal dIN1 : std_logic := '0';
    signal dIN2 : std_logic := '0';
    signal ch   : std_logic := '0';

    signal dOUT : std_logic;

    --Stimulus process
    stim_proc : process
        begin
            
            wait for 100 ns;

            dIN1 <= '1';
            dIN2 <= '0';
            ch <= '0';

            wait for 100ns;

            ch <= '1';

            wait for 100ns;

        end process;

END;
            

    

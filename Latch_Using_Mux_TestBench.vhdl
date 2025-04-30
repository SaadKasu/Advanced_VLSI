LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench_latch IS
END testbench_latch;

ARCHITECTURE testbench_Latch_Behavior OF testbench_latch IS

    COMPONENT latch 
        PORT (
                D : IN std_logic;
                clk : IN std_logic;
                Q   : INOUT std_logic
             );
        END COMPONENT;
    --Inputs
    signal D : std_logic := '0';
    signal clk : std_logic := '0';
    --Output
    signal Q : std_logic;

BEGIN
    
    -- Instantiate Unit Under Test (UUT)
    uut : multiplexer PORT MAP (
        clk => clk,
        D => D,
        Q => Q
    );

    --Stimulus process
    stim_proc : process
        begin
            
            wait for 100 ns;

            D <= '0'
            ch <= '0';

            wait for 100ns;

            ch <= '1';

            wait for 100ns;

            ch<='0';
        
            wait for 100ns;

            D <= '1'
            ch <= '0';

        end process;

END;
            

    

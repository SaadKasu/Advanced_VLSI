LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench_flipflop IS
END testbench_flipflop;

ARCHITECTURE testbench_FlipFlop_Behavior OF testbench_flipflop IS

    COMPONENT flipflop 
        PORT (
                D : IN std_logic;
                clk : IN std_logic;
                Q   : OUT std_logic
             );
        END COMPONENT;
    --Inputs
    signal D : std_logic := '0';
    signal clk : std_logic := '0';
    --Output
    signal Q : std_logic;

BEGIN
    
    -- Instantiate Unit Under Test (UUT)
    uut : flipflop PORT MAP (
        clk => clk,
        D => D,
        Q => Q
    );

    --Stimulus process
    stim_proc : process
        begin

            D <= '0';
            clk <= '0';

            wait for 100ns;

            clk <= '1';

            wait for 100ns;

            clk<='0';
        
            wait for 100ns;

            D <= '1';
            clk <= '0';

            wait for 100ns;

            clk<='1';

            wait for 100ns;

            clk<='0';

            wait for 100ns;

            clk<='1';

        end process;

END;
            

    

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY latch IS
    PORT (D, clk: IN std_logic;
          Q : InOUT std_logic);
END latch;


ARCHITECTURE latch_Behavior of latch is

    COMPONENT multiplexer 
        PORT (
                S : IN std_logic;
                R : IN std_logic;
                T : IN std_logic;
                muxOut : OUT std_logic
             );
    END COMPONENT;

    BEGIN
        multiplexer port map (Q,D,clk,Q);
END latch_Behavior;

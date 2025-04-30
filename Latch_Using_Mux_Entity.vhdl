LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY latch IS
    PORT (D, clk: IN std_logic;
          Q : InOUT std_logic);
END latch;


ARCHITECTURE latch_Behavior of latch is

    COMPONENT multiplexer 
        PORT (
                dIN1 : IN std_logic;
                dIN2 : IN std_logic;
                ch : IN std_logic;
                dOUT : OUT std_logic
             );
    END COMPONENT;

BEGIN
      latch :  multiplexer port map (Q,D,clk,Q);
END latch_Behavior;

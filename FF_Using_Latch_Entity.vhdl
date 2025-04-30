LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY flipflop IS
    PORT (D, clk: IN std_logic;
          Q : OUT std_logic);
END flipflop;


ARCHITECTURE flip_Behavior of flipflop is

    COMPONENT latch 
        PORT (
                D : IN std_logic;
                clk : IN std_logic;
                Q : InOUT std_logic
             );
    END COMPONENT;
    signal temp1 : std_logic;

BEGIN
      firstFlipFlop :  latch port map (D,clk,temp1);
      secondFlipFlop : latch port map (temp1,clk,Q);
END flip_Behavior;

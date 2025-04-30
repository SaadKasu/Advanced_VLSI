LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY multiplexer IS
    PORT (dIN1, dIN2, ch : IN std_logic;
          dOUT           : OUT std_logic);

END multiplexer; 

ARCHITECTURE multiplexer_Behavior of multiplexer is
    BEGIN
        PROCESS (dIN1, dIN2, ch, dOUT) is
            BEGIN
                IF (ch = '0') then
                    dOUT <= dIN1;
                ELSE
                    dOUT <= dIN2;
            END IF;
        END PROCESS;
END multiplexer_Behavior;

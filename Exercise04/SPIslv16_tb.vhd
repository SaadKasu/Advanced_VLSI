LIBRARY	IEEE;
USE	IEEE.STD_LOGIC_1164.ALL;
USE	IEEE.STD_LOGIC_ARITH.ALL;

ENTITY SPIslv16_tb IS
END    SPIslv16_tb;

ARCHITECTURE testbench OF SPIslv16_tb IS
  CONSTANT period : TIME := 1 ns;	-- SPI clock period, 1 Ghz
  CONSTANT data_bits : NATURAL := 8;	-- register width
  CONSTANT addr_bits : NATURAL := 4;	-- address bus width

  SIGNAL rst, sclk, cs, mosi, miso : STD_LOGIC;
  SIGNAL dout0,  dout1,  dout2,  dout3,  dout4,  dout5,  dout6,  dout7, 
         dout8,  dout9,  dout10, dout11, dout12, dout13, dout14, dout15 	
	  : STD_LOGIC_VECTOR (data_bits-1 DOWNTO 0);
  SIGNAL SPIdout, SPIdin : STD_LOGIC_VECTOR (data_bits-1 DOWNTO 0);
  SIGNAL SPIaddr : STD_LOGIC_VECTOR (addr_bits-1 DOWNTO 0);
  SIGNAL SPIwrt : STD_LOGIC;	-- for debug purposes

  COMPONENT SPIslv16C
  PORT (rst  : IN  STD_LOGIC;	-- asynchr. reset, low active
  	sclk : IN  STD_LOGIC;	-- clock signal
	cs   : IN  STD_LOGIC;	-- chip select, low active
	mosi : IN  STD_LOGIC;	-- data in (from SPI master)
	miso : OUT STD_LOGIC;	-- data out (to SPI master)
	dout0,  dout1,  dout2,  dout3,  dout4,  dout5,  dout6,  dout7, 
	dout8,  dout9,  dout10, dout11, dout12, dout13, dout14, dout15 	
	     : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));	
  END COMPONENT;

BEGIN

  PROCESS

    PROCEDURE transfer_data	
       (addr  : STD_LOGIC_VECTOR (addr_bits-1 DOWNTO 0);
        data  : STD_LOGIC_VECTOR (data_bits-1 DOWNTO 0);
        write : STD_LOGIC) IS	  --  high = write 
      VARIABLE cnt : INTEGER RANGE 0 TO addr_bits+data_bits+2;
      VARIABLE bufout, bufin : STD_LOGIC_VECTOR (addr_bits+data_bits+1 DOWNTO 0);
    BEGIN
      SPIaddr <= addr;
      SPIdout <= data;
      SPIwrt  <= write;
      bufout(addr_bits+data_bits+1 DOWNTO data_bits+2) := addr;
      bufout(data_bits+1) := '0';
      bufout(data_bits DOWNTO 1) := data;
      bufout(0) := write;
      cs <= '0';
      cnt := addr_bits+data_bits+2;
      WHILE (cnt > 0) LOOP -- send bufout and receive bufin
        cnt := cnt - 1;
        mosi <= bufout(cnt);
        WAIT FOR period;  
        bufin(cnt) := miso;
        sclk <= '1';
        WAIT FOR period;  
        sclk <= '0';
      END LOOP;
      cs <= '1';
      SPIdin <= bufin(data_bits DOWNTO 1);
    END;

  BEGIN            
    sclk <= '0';
    mosi <= '0'; 
    cs   <= '1';

    WAIT FOR 5*period;
 
    transfer_data("0000","00101101",'1');
    WAIT FOR 5*period;

-- extend test sequence here

END PROCESS;

rst <= '0', '1' AFTER period;

duv : SPIslv16C PORT MAP (rst => rst, 
	sclk => sclk, cs => cs, mosi => mosi, miso => miso, 
   	dout0 => dout0, dout1 => dout1, dout2 => dout2, dout3 => dout3, 
   	dout4 => dout4, dout5 => dout5, dout6 => dout6, dout7 => dout7, 
   	dout8 => dout8, dout9 => dout9, dout10 => dout10, dout11 => dout11, 
   	dout12 => dout12, dout13 => dout13, dout14 => dout14, dout15 => dout15);
				

END testbench;


CONFIGURATION config_tb OF SPIslv16_tb IS
  FOR testbench
	FOR dut -- complete configuration here
  END FOR;
END config_tb;



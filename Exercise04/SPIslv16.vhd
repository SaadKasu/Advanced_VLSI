LIBRARY	IEEE;
USE	IEEE.STD_LOGIC_1164.ALL;
USE	IEEE.STD_LOGIC_ARITH.ALL;

ENTITY SPIslv16 IS
  PORT (rst  : IN  STD_LOGIC;	-- asynchr. reset, low active
  	sclk : IN  STD_LOGIC;	-- clock signal
	cs   : IN  STD_LOGIC;	-- chip select, low active
	mosi : IN  STD_LOGIC;	-- data in (from SPI master)
	miso : OUT STD_LOGIC;	-- data out (to SPI master)
	dout0,  dout1,  dout2,  dout3,  dout4,  dout5,  dout6,  dout7, 
	dout8,  dout9,  dout10, dout11, dout12, dout13, dout14, dout15 	
	     : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));	
END SPIslv16;

ARCHITECTURE SPIrtl OF SPIslv16 IS
  CONSTANT data_bits : NATURAL := 8;	-- register width
  CONSTANT addr_bits : NATURAL := 4;	-- address bus width
  CONSTANT out_regs  : NATURAL := 16;	-- number of output registers

  SIGNAL count : INTEGER RANGE 0 TO addr_bits+data_bits+1;-- state counter
  SIGNAL a_reg : STD_LOGIC_VECTOR (addr_bits-1 DOWNTO 0);-- address register
  SIGNAL d_reg : STD_LOGIC_VECTOR (data_bits-1 DOWNTO 0);-- data out/in register
  SIGNAL mosi_reg, miso_enb, wr_reg1, wr_reg2, rd_reg1, rd_reg2 : STD_LOGIC;
  SIGNAL addr    : INTEGER RANGE 0 TO (2**addr_bits)-1;-- register address
  SIGNAL write   : STD_LOGIC;		-- write enable, high active
  SIGNAL read    : STD_LOGIC;		-- read enable, high active
  SIGNAL data_w : STD_LOGIC_VECTOR (data_bits-1 DOWNTO 0);-- data bus for writing register
  SIGNAL data_r : STD_LOGIC_VECTOR (data_bits-1 DOWNTO 0);-- data bus for reading register

  TYPE register_type IS ARRAY (0 TO out_regs-1) OF STD_LOGIC_VECTOR (data_bits-1 DOWNTO 0);
  SIGNAL data_reg : register_type;

BEGIN

  PROCESS (sclk, rst)			-- state counter
  BEGIN
    IF rst = '0' THEN
      count <= 0;
      rd_reg1 <= '0';
      wr_reg1 <= '0';
      miso_enb <= '0';
    ELSIF sclk'EVENT AND sclk='0' THEN	-- falling SCKL edge
      IF count>addr_bits+data_bits THEN
        count <= 0;   
      ELSIF cs='0' THEN
        count <= count + 1;
      ELSE
        count <= 0;
      END IF;
      IF count=addr_bits-1 THEN
        rd_reg1 <= '1';
      ELSE
        rd_reg1 <= '0';
      END IF;
      IF count=addr_bits+data_bits THEN
        wr_reg1 <= '1';
      ELSE
        wr_reg1 <= '0';
      END IF;
      IF count>=addr_bits AND count<addr_bits+data_bits THEN
        miso_enb <= '1';
      ELSE
        miso_enb <= '0';
      END IF;
    END IF;
  END PROCESS;

  PROCESS (sclk)			-- input SPI shift register
  BEGIN
    IF sclk'EVENT AND sclk='1' THEN	-- rising SCKL edge
      IF cs='0' THEN
        IF count<addr_bits THEN
          a_reg(0) <= mosi;
          a_reg(a_reg'HIGH DOWNTO 1) <= a_reg(a_reg'HIGH-1 DOWNTO 0);
        END IF;
        IF count>addr_bits AND count<=addr_bits+data_bits THEN
          mosi_reg <= mosi;
        END IF;
        IF count=addr_bits THEN
          rd_reg2 <= '1'; -- mosi ??;
        ELSE
          rd_reg2 <= '0';
        END IF;
        IF count>addr_bits+data_bits THEN
          wr_reg2 <= mosi;
        ELSE
          wr_reg2 <= '0';
        END IF;
      END IF;
    END IF;
  END PROCESS;

  PROCESS (sclk)
  BEGIN
    IF sclk'EVENT AND sclk='0' THEN	-- falling SCKL edge
      IF cs='0' THEN
        IF count=addr_bits THEN
          d_reg <= data_r;
        ELSIF count>addr_bits AND count<=addr_bits+data_bits THEN
          d_reg(d_reg'HIGH DOWNTO 1) <= d_reg(d_reg'HIGH-1 DOWNTO 0);
          d_reg(0) <= mosi_reg;
        END IF;
      END IF;
    END IF;
  END PROCESS;

	miso  <= d_reg(d_reg'HIGH) WHEN miso_enb='1' ELSE mosi;
	read  <= rd_reg1 AND rd_reg2;
	write <= wr_reg1 AND wr_reg2;
	addr  <= CONV_INTEGER(UNSIGNED(a_reg));
	data_w <= d_reg;

  PROCESS (addr, data_reg)
  BEGIN  
    CASE addr IS 
      WHEN OTHERS => 
        data_r <= data_reg(addr);	-- read back SPI outputs
    END CASE;
  END PROCESS;

  PROCESS (rst, write, addr, data_w)
  BEGIN  
    IF rst = '0' THEN
      FOR i IN 0 TO out_regs-1 LOOP
        data_reg(i) <= (OTHERS => '0');	-- reset latches to zero
      END LOOP;
    ELSIF write = '1' THEN	
      FOR i IN 0 TO out_regs-1 LOOP 
        IF i = addr THEN 
          data_reg(i) <= data_w;	-- write new values from SPI
        END IF; 
      END LOOP;
    END IF;
  END PROCESS;

    dout0  <= data_reg(0);	-- connect latches to outputs
    dout1  <= data_reg(1);
    dout2  <= data_reg(2);
    dout3  <= data_reg(3);
    dout4  <= data_reg(4);
    dout5  <= data_reg(5);
    dout6  <= data_reg(6);
    dout7  <= data_reg(7);
    dout8  <= data_reg(8);
    dout9  <= data_reg(9);
    dout10 <= data_reg(10);
    dout11 <= data_reg(11);
    dout12 <= data_reg(12);
    dout13 <= data_reg(13);
    dout14 <= data_reg(14);
    dout15 <= data_reg(15);

END SPIrtl;

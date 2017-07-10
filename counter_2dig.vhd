----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:26:07 07/02/2017 
-- Design Name: 
-- Module Name:    counter_2dig - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_2dig is
	PORT (
		i_clk 	: IN STD_LOGIC;
		i_reset	: IN STD_LOGIC;
		o_cat1	: OUT STD_LOGIC;
		o_cat2	: OUT STD_LOGIC;
		o_led		: OUT STD_LOGIC_VECTOR (1 downto 0);
		o_digit1	: OUT STD_LOGIC_VECTOR (6 downto 0);
		o_digit2	: OUT STD_LOGIC_VECTOR (6 downto 0)
	);
end counter_2dig;

architecture Behavioral of counter_2dig is

COMPONENT scale_clock
  port (
    clk_50Mhz : in  std_logic;
    rst       : in  std_logic;
    clk_2Hz   : out std_logic);
end COMPONENT;

COMPONENT mux4
PORT(	A	:	in	STD_LOGIC_VECTOR (6 downto 0);
		B	:	in	STD_LOGIC_VECTOR (6 downto 0);
		C	:	in	STD_LOGIC_VECTOR (6 downto 0);
		D	:	in	STD_LOGIC_VECTOR (6 downto 0);
		S	:	in	STD_LOGIC_VECTOR (1 downto 0);
		F	:	out STD_LOGIC_VECTOR(6 downto 0)
		);
end COMPONENT;

COMPONENT scale_clock_60
  port (
      clk_50Mhz 		: in  std_logic;
		rst       		: in  std_logic;
		clk_60Hz   		: out std_logic;
		not_clk_60Hz   : out std_logic
	 );
end COMPONENT;

signal w_clk_2Hz : std_logic;
signal w_blink60 : std_logic_vector (1 downto 0);
signal digit1	  : STD_LOGIC_VECTOR (6 downto 0);
signal digit2	  : STD_LOGIC_VECTOR (6 downto 0);
signal digit3	  : STD_LOGIC_VECTOR (6 downto 0);
signal digit4	  : STD_LOGIC_VECTOR (6 downto 0);

begin

o_cat1  <= not w_blink60(0) ;
o_cat2  <= not w_blink60(1) ;
o_led(0)<= w_clk_2Hz;
o_led(1)<= not w_clk_2Hz;

PROCESS (w_clk_2Hz, i_reset)
	VARIABLE temp1: INTEGER RANGE 0 TO 10;
	VARIABLE temp2: INTEGER RANGE 0 TO 6;
	VARIABLE temp3: INTEGER RANGE 0 TO 10;
	VARIABLE temp4: INTEGER RANGE 0 TO 6;
BEGIN 
	---------------- counter --------------------
	IF (i_reset = '1') THEN
		temp1 := 0;
		temp2 := 0;
		temp3 := 0;
		temp4 := 0;
	ELSIF (w_clk_2Hz'EVENT and w_clk_2Hz ='1') THEN
		temp1 := temp1 + 1;
		IF (temp1 = 10) THEN
			temp1 := 0;
			temp2 := temp2 + 1;
			IF (temp2 = 6) THEN
				temp2 := 0;
				temp3	:= temp3 + 1;
				IF (temp3 = 10) THEN
				temp3 := 0;
				temp4	:= temp4 + 1;
					IF (temp4 = 6) THEN
					temp4 := 0;
					END IF;
				END IF;
			END IF;
		END IF;

	END IF;
	---------------- bcd to 7 seg ----------------
	CASE temp1 IS
		when   0 => digit1 <= "1000000"; --40 
	   when   1 => digit1 <= "1111001"; --79
		when   2 => digit1 <= "0100100"; --24
		when   3 => digit1 <= "0110000"; --30
		when   4 => digit1 <= "0011001"; --19
		when   5 => digit1 <= "0010010"; --12
		when   6 => digit1 <= "0000010"; --02
		when   7 => digit1 <= "1111000"; --78
		when   8 => digit1 <= "0000000"; --00 
		when   9 => digit1 <= "0011000"; --18
		when others => NULL;
	END CASE;
	
	CASE temp2 IS
		when   0 => digit2 <= "1000000";  -- X"0"
	   when   1 => digit2 <= "1111001";
		when   2 => digit2 <= "0100100";
		when   3 => digit2 <= "0110000";
		when   4 => digit2 <= "0011001";
		when   5 => digit2 <= "0010010";
		when   6 => digit2 <= "0000010";
--		when   7 => digit2 <= "1111000";
--		when   8 => digit2 <= "0000000";
--		when   9 => digit2 <= "0011000";
		when others => NULL;
	END CASE;
	CASE temp3 IS
		when   0 => digit3 <= "1000000";  -- X"0"
	   when   1 => digit3 <= "1111001";
		when   2 => digit3 <= "0100100";
		when   3 => digit3 <= "0110000";
		when   4 => digit3 <= "0011001";
		when   5 => digit3 <= "0010010";
		when   6 => digit3 <= "0000010";
		when   7 => digit3 <= "1111000";
		when   8 => digit3 <= "0000000";
		when   9 => digit3 <= "0011000";
		when others => NULL;
	END CASE;
	CASE temp4 IS
		when   0 => digit4 <= "1000000";  -- X"0"
	   when   1 => digit4 <= "1111001";
		when   2 => digit4 <= "0100100";
		when   3 => digit4 <= "0110000";
		when   4 => digit4 <= "0011001";
		when   5 => digit4 <= "0010010";
		when   6 => digit4 <= "0000010";
--		when   7 => digit4 <= "1111000";
--		when   8 => digit4 <= "0000000";
--		when   9 => digit4 <= "0011000";
		when others => NULL;
	END CASE;	
END PROCESS;

u_scale_clock:scale_clock
  PORT MAP (
    clk_50Mhz => i_clk,
    rst       => i_reset,
    clk_2Hz   => w_clk_2Hz
	 );
u_scale_clock_60:scale_clock_60
  PORT MAP (
    clk_50Mhz => i_clk,
    rst       => i_reset,
    clk_60Hz  => w_blink60(0),
	 not_clk_60Hz  => w_blink60(1)
	 );
u_mux4_A: mux4
PORT MAP(
			A=> not digit2, 
			B=> not digit1, 
			C=> not digit2, 
			D=> not digit1, 
			S=> w_blink60, 
			F=> o_digit1
			);
u_mux4_B: mux4
PORT MAP(
			A=> not digit3, 
			B=> not digit4, 
			C=> not digit3, 
			D=> not digit4, 
			S=> w_blink60, 
			F=> o_digit2
			);
end Behavioral;


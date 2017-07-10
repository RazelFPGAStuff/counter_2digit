
				----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:48:28 10/23/2009 
-- Design Name: 
-- Module Name:    mux_4_1 - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- This entity behaves as a quadruple 2 inputs multiplexer
entity mux4 is
PORT(	A	:	in	STD_LOGIC_VECTOR (6 downto 0);
		B	:	in	STD_LOGIC_VECTOR (6 downto 0);
		C	:	in	STD_LOGIC_VECTOR (6 downto 0);
		D	:	in	STD_LOGIC_VECTOR (6 downto 0);
		S			:	in	STD_LOGIC_VECTOR (1 downto 0);
		F			:	out STD_LOGIC_VECTOR (6 downto 0));
end mux4;

architecture Behavioral of mux4 is

begin

    with S Select
   F	<=	A when "00",
			B when "01",
			C when "10",
			D when others;

end Behavioral;

--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:48:14 07/02/2017
-- Design Name:   
-- Module Name:   F:/Surf-VHDL/VhdlCourseLab/lab_7seg/xilinxfiles/counter_2dig/counter_2dig_tb.vhd
-- Project Name:  counter_2dig
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: counter_2dig
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY counter_2dig_tb IS
END counter_2dig_tb;
 
ARCHITECTURE behavior OF counter_2dig_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter_2dig
    PORT(
         i_clk : IN  std_logic;
         i_reset : IN  std_logic;
         digit1 : OUT  std_logic_vector(6 downto 0);
         digit2 : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i_clk : std_logic := '0';
   signal i_reset : std_logic := '0';

 	--Outputs
   signal digit1 : std_logic_vector(6 downto 0);
   signal digit2 : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant i_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter_2dig PORT MAP (
          i_clk => i_clk,
          i_reset => i_reset,
          digit1 => digit1,
          digit2 => digit2
        );

   -- Clock process definitions
   i_clk_process :process
   begin
		i_clk <= '0';
		wait for i_clk_period/2;
		i_clk <= '1';
		wait for i_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for i_clk_period*10;

      -- insert stimulus here 
		
		i_reset <= '1';
		wait for 100 ns;	
		i_reset <= '0';
		wait for i_clk_period*10;
		
		

      wait;
   end process;

END;

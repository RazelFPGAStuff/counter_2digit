library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

entity scale_clock_60 is
  port (
    clk_50Mhz : in  std_logic;
    rst       : in  std_logic;
    clk_60Hz   : out std_logic;
	 not_clk_60Hz   : out std_logic
	 );
end scale_clock_60;

architecture Behavioral of scale_clock_60 is

  signal prescaler : unsigned(23 downto 0);
  signal clk_60Hz_i : std_logic;
begin

  gen_clk : process (clk_50Mhz, rst)
  begin  -- process gen_clk
    if rst = '1' then
      clk_60Hz_i   <= '0';
      prescaler   <= (others => '0');
    elsif rising_edge(clk_50Mhz) then   -- rising clock edge
      if prescaler = X"65B9A" then     -- 833,333 --> 60Hz
        prescaler   <= (others => '0');
        clk_60Hz_i   <= not clk_60Hz_i;
      else
        prescaler <= prescaler + "1";
      end if;
    end if;
  end process gen_clk;

clk_60Hz <= clk_60Hz_i;
not_clk_60Hz <= not clk_60Hz_i;
end Behavioral;
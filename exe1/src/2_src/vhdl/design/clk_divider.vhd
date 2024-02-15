----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2023 06:04:34 PM
-- Design Name: 
-- Module Name: clk_divider - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_divider is
    -- default count value for 12mhz clock to 1hz
    generic(count: integer:= 12000000);
    Port ( clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clk_divider;

architecture Behavioral of clk_divider is
begin
 
  process(clk_in,rst)
    variable div_counter: integer range 0 to count-1;
  begin
    if(rst='1') then
      div_counter := 0; 
    elsif rising_edge(clk_in) then
      if(div_counter = count - 1) then
        div_counter := 0;
      else
        div_counter := div_counter + 1;
      end if;
      if(div_counter >= count/2) then
        clk_out <= '1';
      else
        clk_out <= '0';
      end if;
    end if;

  end process;

end Behavioral;

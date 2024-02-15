----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2023 07:16:22 PM
-- Design Name: 
-- Module Name: clk_divider_tb - Behavioral
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

entity clk_divider_tb is
end clk_divider_tb;

architecture Behavioral of clk_divider_tb is

component clk_divider is
    -- default count value for 12mhz clock to 1hz
    generic(count: integer:= 12000000);
    Port ( clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component clk_divider;

signal clk_in, rst, clk_out: std_logic := '0';

constant clk_period : time := 1 sec / 12000000;

begin
 
uut: clk_divider generic map(count => 12000000)
                 port map(clk_in => clk_in, 
                          rst => rst, 
                          clk_out => clk_out);

--simulate 100mhz clock
process
begin
    clk_in<='0';
    wait for clk_period/2;
    clk_in<='1';
    wait for clk_period/2;
end process;

end Behavioral;

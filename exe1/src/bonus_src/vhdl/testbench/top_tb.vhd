----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2023 07:18:50 PM
-- Design Name: 
-- Module Name: top_tb - Behavioral
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

entity top_tb is
--  Port ( );
end top_tb;

architecture Behavioral of top_tb is

component top_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           seven: out STD_LOGIC_VECTOR(6 downto 0);
           ctr: out STD_LOGIC);
end component top_counter;

signal clk_tb, rst_tb, ctr_tb: std_logic := '0';
signal seven_tb: std_logic_vector(6 downto 0) := (others => '0');
begin

uut: top_counter port map(clk_tb, rst_tb, seven_tb, ctr_tb);

process
begin
    clk_tb <= '0';
    wait for 10ns;
    clk_tb <= '1';
    wait for 10ns;
end process;

end Behavioral;

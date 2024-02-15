----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/25/2023 12:18:10 AM
-- Design Name: 
-- Module Name: count_ones_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity count_ones_tb is
end count_ones_tb;

architecture Testbench of count_ones_tb is

component count_ones is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           F : out STD_LOGIC_VECTOR (2 downto 0):= (others => '0'));
end component count_ones;

signal X_tb: std_logic_vector(3 downto 0) := (others => '0');
signal F_tb: std_logic_vector(2 downto 0) := (others => '0');


begin

uut: count_ones port map(
    X => X_tb,
    F => F_tb);
    
TB: process
begin

for i in 0 to 15 loop
    X_tb <= std_logic_vector(to_unsigned(i, X_tb'length)); 
    wait for 10 ns;
end loop;

end process;

end Testbench;
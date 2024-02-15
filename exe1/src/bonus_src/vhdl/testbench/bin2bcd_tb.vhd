----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2023 09:14:38 PM
-- Design Name: 
-- Module Name: bin2bcd_tb - Behavioral
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

entity bin2bcd_tb is
--  Port ( );
end bin2bcd_tb;

architecture Behavioral of bin2bcd_tb is
component bin2bcd_16bit is
    Port ( 
           tbin : in STD_LOGIC_VECTOR (15 downto 0);
           bcd : out STD_LOGIC_VECTOR(19 downto 0));
end component bin2bcd_16bit;


signal i_bin_tb :STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal bcd_tb: STD_LOGIC_VECTOR(19 downto 0) := (others => '0');
begin

uut: bin2bcd_16bit port map(i_bin_tb, bcd_tb);

clock: process
begin
   wait for 10ns;
   i_bin_tb <= "1101010000110001"; --decimal 54321
end process;



end Behavioral;

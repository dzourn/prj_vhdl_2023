----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2023 05:42:55 PM
-- Design Name: 
-- Module Name: bcd2sevenseg - Behavioral
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

entity bcd2sevenseg is
    Port ( bcd : in STD_LOGIC_VECTOR (3 downto 0);
           sevenseg : out STD_LOGIC_VECTOR (6 downto 0));
end bcd2sevenseg;

architecture Behavioral of bcd2sevenseg is
    
begin
    process(bcd) is
    begin
        case bcd is
            when "0000" => sevenseg <= "0111111"; -- "0"     
            when "0001" => sevenseg <= "0000110"; -- "1" 
            when "0010" => sevenseg <= "1011011"; -- "2" 
            when "0011" => sevenseg <= "1001111"; -- "3" 
            when "0100" => sevenseg <= "1100110"; -- "4" 
            when "0101" => sevenseg <= "1101101"; -- "5" 
            when "0110" => sevenseg <= "1111101"; -- "6" 
            when "0111" => sevenseg <= "0000111"; -- "7" 
            when "1000" => sevenseg <= "1111111"; -- "8"     
            when "1001" => sevenseg <= "1101111"; -- "9" 
            when others => sevenseg <= "1000000"; -- all leds error
--            when "1010" => sevenseg <= "0000010"; -- a
--            when "1011" => sevenseg <= "1100000"; -- b
--            when "1100" => sevenseg <= "0110001"; -- C
--            when "1101" => sevenseg <= "1000010"; -- d
--            when "1110" => sevenseg <= "0110000"; -- E
--            when "1111" => sevenseg <= "0111000"; -- F
        end case;
    end process;

end Behavioral;

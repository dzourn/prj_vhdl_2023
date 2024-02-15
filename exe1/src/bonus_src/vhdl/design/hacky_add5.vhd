----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2023 04:54:19 PM
-- Design Name: 
-- Module Name: hacky_add5 - Behavioral
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

entity hacky_add5 is
    Port ( binin : in STD_LOGIC_VECTOR (3 downto 0);
           binout : out STD_LOGIC_VECTOR (3 downto 0));
end hacky_add5;

architecture Behavioral of hacky_add5 is
begin
    process(binin) is
    begin
        case binin is
            when "0000" => binout <= "0000";
            when "0001" => binout <= "0001";
            when "0010" => binout <= "0010";
            when "0011" => binout <= "0011";
            when "0100" => binout <= "0100";
            when "0101" => binout <= "1000";
            when "0110" => binout <= "1001";
            when "0111" => binout <= "1010";
            when "1000" => binout <= "1011";
            when "1001" => binout <= "1100";
            when others => binout <= "1111";
        end case;

    end process;
end Behavioral;

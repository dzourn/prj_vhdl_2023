----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2023 08:24:09 PM
-- Design Name: 
-- Module Name: count_ones - Structural
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

entity count_ones is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           F : out STD_LOGIC_VECTOR (2 downto 0):= (others => '0'));
end count_ones;

architecture Behavioral of count_ones is
begin
   
process(X) is
begin
    --we could put everything in only one case
    --split them for better understanding of the design choice
--    case X(3 downto 2) is
--        when "11" =>
--            F(2) <= X(1) and X(0);
--        when others =>
--            F(2) <= '0';
--    end case;

--    case X(3 downto 2) is
--        when "00" =>
--            F(1) <= X(1) and X(0);
--        when "01" =>
--            F(1) <= X(1) or X(0);
--        when "10" =>
--            F(1) <= X(1) or X(0);
--        when "11" =>
--            F(1) <= ((not X(1)) or (not X(0)));
--        when others =>
--            F(1) <= '0';
--     end case;
     
--     case X(3 downto 2) is
--        when "01"=>
--            F(0) <= X(0);
--        when "10"=>
--            F(0) <= X(0);
--        when "00" =>
--            F(0) <= ((not X(1)) and X(0)) or (X(1) and (not X(0)));
--        when "11" =>
--            F(0) <= ((not X(1)) and X(0)) or (X(1) and (not X(0)));
--        when others =>
--            F(0) <= '0';
--     end case;

--CORRECT IMPLMENTATION
    case X(3 downto 1) is
        when "000" =>
            F(2) <= '0';
            F(1) <= '0';
            F(0) <= X(0);
        when "001" =>
            F(2) <= '0';
            F(1) <= X(0);
            F(0) <= not X(0);
        when "010" =>
            F(2) <= '0';
            F(1) <= X(0);
            F(0) <= not X(0);
        when "011" =>
            F(2) <= '0';
            F(1) <= '1';
            F(0) <= X(0);
        when "100" =>
            F(2) <= '0';
            F(1) <= X(0);
            F(0) <= not X(0);
        when "101" =>
            F(2) <= '0';
            F(1) <= '1';
            F(0) <= X(0);
        when "110" =>
            F(2) <= '0';
            F(1) <= '1';
            F(0) <= X(0);
        when others =>
            F(2) <= X(0);
            F(1) <= not X(0);
            F(0) <= not X(0);
    
    end case;
     
end process;

end Behavioral;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2023 07:34:23 PM
-- Design Name: 
-- Module Name: sevenseg_driver_tb - Behavioral
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

entity sevenseg_driver_tb is
--  Port ( );
end sevenseg_driver_tb;

architecture Behavioral of sevenseg_driver_tb is
component sevenseg_driver is
    Port ( bin : in STD_LOGIC_VECTOR (15 downto 0);
           ctr_in: in STD_LOGIC;
           seven : out STD_LOGIC_VECTOR (6 downto 0);
           ctr_out : out STD_LOGIC);
end component sevenseg_driver;

signal bin_tb: std_logic_vector(15 downto 0) := "0000000001100010";
signal ctr_in_tb: std_logic := '0';
signal seven_tb: std_logic_vector(6 downto 0) := (others => '0');
signal ctr_out_tb: std_logic := '0';
begin

uut: sevenseg_driver port map(bin_tb,
                              ctr_in_tb,
                              seven_tb,
                              ctr_out_tb);
       

process
begin
    ctr_in_tb<= '0';
    wait for 20ns;
    ctr_in_tb <= '1';
    wait for 20ns;
end process;
end Behavioral;

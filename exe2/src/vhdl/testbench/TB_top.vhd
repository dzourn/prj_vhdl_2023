----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2023 10:31:49 PM
-- Design Name: 
-- Module Name: TB_top - Behavioral
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

entity TB_top is
--  Port ( );
end TB_top;

architecture Behavioral of TB_top is
 component top
     generic (
              D: positive := 32;
              N: positive := 4;
              W: positive := 8;
              K: positive := 5;
              L: positive := 3;
              S: positive := 2);
     Port ( clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            data_ovld: out STD_LOGIC;
                       data_out : out STD_LOGIC_VECTOR ((2*2*W)-1 downto 0));
     end component;

constant W : integer := 8;
signal tb_clk: STD_LOGIC := '0';
signal tb_rst: STD_LOGIC := '0';
signal tb_switches: STD_LOGIC := '0';
signal tb_data_out: STD_LOGIC_VECTOR ((2*2*W)-1 downto 0) := (others =>'0');


constant clk_period: time := 20 ns;

begin
uut: top port map(clk => tb_clk, rst=>tb_rst, data_ovld=>tb_switches, data_out => tb_data_out);

--reset: process is 
--begin

--wait for 20ns;
--tb_rst <= '0';

--end process;

clock_process: process is
begin
    tb_clk <= '0';
    wait for clk_period/2;
    tb_clk <= '1';
    wait for clk_period/2;
end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2023 07:22:38 PM
-- Design Name: 
-- Module Name: fibonacci_series_tb - Behavioral
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

entity fibonacci_series_tb is
--  Port ( );
end fibonacci_series_tb;

architecture Behavioral of fibonacci_series_tb is
component fibonacci_series is
    generic (num: positive := 8);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           sw: in STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (num-1 downto 0));
end component fibonacci_series;

constant num: positive := 8;
signal clk_tb: std_logic := '0';
signal  rst_tb: std_logic := '0';
signal  sw_tb: std_logic := '0';
signal leds_tb: std_logic_vector(num-1 downto 0) := (others => '0');

--constant clk_period: time := 1 sec / 12000000;
constant clk_period: time := 20ns;
begin
uut: fibonacci_series generic map(num)
        port map(clk_tb, rst_tb, sw_tb,leds_tb);

clock_proc: process
begin
    
    clk_tb <= '0';
    wait for clk_period/2;    
    clk_tb <= '1';
    wait for clk_period/2;
   
end process;

stimuli: process
begin
    wait for 500ns;
    sw_tb <= '1';
    wait for 500ns;
    sw_tb <= '0';
end process;
end Behavioral;

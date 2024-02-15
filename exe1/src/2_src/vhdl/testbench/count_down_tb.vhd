----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2023 10:20:06 PM
-- Design Name: 
-- Module Name: count_down_tb - Behavioral
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

entity count_down_tb is
--  Port ( );
end count_down_tb;

architecture Behavioral of count_down_tb is

component count_down is
    generic(num: integer := 8);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           hold : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (num-2 downto 0);
           leds : out STD_LOGIC_VECTOR (num-1 downto 0));
end component count_down;

constant num_tb: integer := 8;
signal clk_tb : std_logic := '0';
signal rst_tb: std_logic := '1';
signal hold_tb: std_logic := '0';
signal leds_tb: std_logic_vector(num_tb-1 downto 0) := (others => '0');
signal sw_tb: std_logic_vector(num_tb-2 downto 0) := (others => '0');

constant clk_period : time := 10ns;

begin

uut: count_down generic map(num_tb)
                port map(clk=>clk_tb, 
                         rst=>rst_tb, 
                         hold=>hold_tb,
                         sw=>sw_tb,
                         leds=>leds_tb);

sw_tb <= "1111111";

clock_proc: process
begin
    clk_tb <= '0';
    wait for clk_period/2;  
    clk_tb <= '1';
    wait for clk_period/2;
    
end process;

stimuli: process
begin
    wait for 10ns;
    rst_tb <= '0';
end process;

stop: process
begin
    wait for 50ns;
    hold_tb <= '1';
    wait for 100ns;
    hold_tb <= '0';
    wait for 1000ns;
end process;
end Behavioral;

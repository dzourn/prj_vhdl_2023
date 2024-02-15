----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/13/2023 04:49:17 PM
-- Design Name: 
-- Module Name: TB_system - Behavioral
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

entity TB_system is
--  Port ( );
end TB_system;

architecture Behavioral of TB_system is
component system is
    generic (
             D: positive := 32;
             N: positive := 4;
             W: positive := 8;
             K: positive := 5;
             L: positive := 3;
             S: positive := 2;
             rom_size: positive := 12;
             LEDS_DATA_OUT_SIZE: positive := 8;
             ADDRESS_WIDTH: positive := 8);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           switches: in STD_LOGIC_VECTOR(ADDRESS_WIDTH-1 downto 0);
           data_out : out STD_LOGIC_VECTOR (LEDS_DATA_OUT_SIZE-1 downto 0));
end component system;

constant tb_D: positive := 32;                
constant tb_N: positive := 4;                 
constant tb_W: positive := 8;                 
constant tb_K: positive := 5;                 
constant tb_L: positive := 3;                 
constant tb_S: positive := 2;                 
constant tb_rom_size: positive := 12;         
constant tb_LEDS_DATA_OUT_SIZE: positive := 8;
constant tb_ADDRESS_WIDTH : positive := 8;

signal tb_clk: std_logic := '0';
signal tb_rst: std_logic := '0';

signal tb_switches: std_logic_vector(tb_ADDRESS_WIDTH-1 downto 0) := (others => '0');
signal tb_data_out: std_logic_vector(tb_LEDS_DATA_OUT_SIZE-1 downto 0) := (others => '0');

constant clk_period: time := 20 ns;
begin

uut: system 
       generic map(
            D => tb_D,
            N => tb_N,
            W => tb_W,
            K => tb_K,
            L => tb_L,
            S => tb_S,
            rom_size => tb_rom_size,
            LEDS_DATA_OUT_SIZE => tb_LEDS_DATA_OUT_SIZE,
            ADDRESS_WIDTH => tb_ADDRESS_WIDTH)
       port map(
            clk => tb_clk,
            rst => tb_rst,
            switches => tb_switches,
            data_out => tb_data_out);
            
            
clock_process: process is
begin
    
    tb_clk <= '0';
    wait for clk_period/2;
    tb_clk <= '1';
    wait for clk_period/2;
  
end process;

stimuli: process is
begin
    wait for 500ns;
    tb_switches <= "00000001";
    wait for 100ns;
    tb_switches <= "00000010";
    wait for 100ns;
    tb_switches <= "00000011";

end process;
end Behavioral;

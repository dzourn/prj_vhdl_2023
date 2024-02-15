----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2023 06:49:44 PM
-- Design Name: 
-- Module Name: TB_Controller - Behavioral
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

entity TB_Controller is
--  Port ( );
end TB_Controller;

architecture Behavioral of TB_Controller is

component Controller_V2 is
    Generic (D: positive := 32;
             N: positive := 4;
             W: positive := 8;
             K: positive := 5;
             L: positive := 3);
    Port ( clk          :in STD_LOGIC;
           rst          :in STD_LOGIC;
           data_in      :in STD_LOGIC_VECTOR(D-1 downto 0);
           data_ivld    :in STD_LOGIC;
           x            :out STD_LOGIC_VECTOR(W-1 downto 0);
           x_vld        :out STD_LOGIC;
           h_val        :out STD_LOGIC_VECTOR(W-1 downto 0);
           h_vld        :out STD_LOGIC;
           tap_select   :out STD_LOGIC_VECTOR(N-1 downto 0);
           next_val     :out STD_LOGIC);
end component Controller_V2;

constant tb_D : positive := 32;
constant tb_N : positive := 4;
constant tb_W : positive := 8;
constant tb_K : positive := 5;
constant tb_L : positive := 3;

constant clk_period: time := 20 ns;

signal tb_clk           :std_logic := '0';
signal tb_rst           :std_logic := '0';
signal tb_data_in       :STD_LOGIC_VECTOR(tb_D-1 downto 0) := (others => '0');    
signal tb_data_ivld     :STD_LOGIC := '0';                       
signal tb_x             :STD_LOGIC_VECTOR(tb_W-1 downto 0) := (others => '0');         
signal tb_x_vld         :STD_LOGIC := '0';                          
signal tb_h_val         :STD_LOGIC_VECTOR(tb_W-1 downto 0) := (others => '0');     
signal tb_h_vld         :STD_LOGIC := '0';                          
signal tb_tap_selec     :STD_LOGIC_VECTOR(tb_N-1 downto 0) := (others => '0');
signal tb_next_val      :STD_LOGIC := '0';                      


begin

uut: Controller_V2
        generic map(
            D => tb_D,
            N => tb_N,
            W => tb_W,
            K => tb_K,
            L => tb_L
        )
        port map(
            clk        => tb_clk      ,
            rst        => tb_rst      ,
            data_in    => tb_data_in  ,
            data_ivld  => tb_data_ivld,
            x          => tb_x        ,
            x_vld      => tb_x_vld    ,
            h_val      => tb_h_val    ,
            h_vld      => tb_h_vld    ,
            tap_select => tb_tap_selec,
            next_val   => tb_next_val 
        );

tb_data_in <= "01001001011011111100000111110010";
clock_process: process is
begin
    tb_clk <= '0';
    wait for clk_period/2;
    tb_clk <= '1';
    wait for clk_period/2;
end process;

end Behavioral;

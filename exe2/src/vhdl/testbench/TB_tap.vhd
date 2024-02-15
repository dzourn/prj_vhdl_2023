----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2023 05:48:12 PM
-- Design Name: 
-- Module Name: TB_tap - Behavioral
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

entity TB_tap is
--  Port ( );
end TB_tap;

architecture Behavioral of TB_tap is
component tap is
    generic (D: positive := 32;
             N: positive := 4;
             W: positive := 8;
             K: positive := 5;
             L: positive := 3);
    Port ( clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           h_in     : in STD_LOGIC_VECTOR (W-1 downto 0);
           h_vld    : in STD_LOGIC;
           x_in     : in STD_LOGIC_VECTOR (W-1 downto 0);
           x_vld    : in STD_LOGIC;
           x_out    : out STD_LOGIC_VECTOR (W-1 downto 0);
           x_out_vld: out STD_LOGIC;
           y_out    : out STD_LOGIC_VECTOR ((2*W) - 1 downto 0);
           y_out_vld: out STD_LOGIC);
end component tap;

constant tb_D : positive := 32;
constant tb_N : positive := 4;
constant tb_W : positive := 8;
constant tb_K : positive := 5;
constant tb_L : positive := 3;

constant clk_period: time := 20 ns;

signal tb_clk      : STD_LOGIC:= '0';
signal tb_rst      : STD_LOGIC:= '0';
signal tb_h_in     : STD_LOGIC_VECTOR(tb_W-1 downto 0) := (others => '0');
signal tb_h_vld    : STD_LOGIC:='0';
signal tb_x_in     : STD_LOGIC_VECTOR(tb_W-1 downto 0):= (others => '0');
signal tb_x_vld    : STD_LOGIC:='0';
signal tb_x_out    : STD_LOGIC_VECTOR(tb_W-1 downto 0):= (others => '0');
signal tb_x_out_vld: STD_LOGIC:='0';
signal tb_y_out    : STD_LOGIC_VECTOR((2*tb_W)-1 downto 0):= (others => '0');
signal tb_y_out_vld: STD_LOGIC:='0';

 
begin

uut: tap
        generic map(
                D => tb_D,
                N => tb_N,
                W => tb_W,
                K => tb_K,
                L => tb_L)
        port map(
                clk      =>tb_clk      ,
                rst      =>tb_rst      ,
                h_in     =>tb_h_in     ,
                h_vld    =>tb_h_vld    ,
                x_in     =>tb_x_in     ,
                x_vld    =>tb_x_vld    ,
                x_out    =>tb_x_out    ,
                x_out_vld=>tb_x_out_vld,
                y_out    =>tb_y_out    ,
                y_out_vld=>tb_y_out_vld);
                

clock_process: process is
begin
    tb_clk <= '0';
    wait for clk_period/2;
    tb_clk <= '1';
    wait for clk_period/2;
end process;

stimuli: process is
begin
    wait for 20ns;
    tb_h_in <= "01001001";
    tb_h_vld <= '1';
    wait for 20ns;
    tb_x_in <= "11101001";
    tb_x_vld <= '1';
    wait for 20ns;
    tb_x_in <= "01001011";
    tb_x_vld <= '1';
    wait for 20ns;
    tb_x_vld <= '0';
    wait for 200ns;
end process;

end Behavioral;

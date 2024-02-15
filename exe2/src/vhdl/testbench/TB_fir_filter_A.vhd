----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/15/2023 04:09:51 PM
-- Design Name: 
-- Module Name: TB_fir_filter_A - Behavioral
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

entity TB_fir_filter_A is
--  Port ( );
end TB_fir_filter_A;

architecture Behavioral of TB_fir_filter_A is
component fir_filter_A is
    generic (
             D: positive := 32;
             N: positive := 4;
             W: positive := 8;
             K: positive := 5;
             L: positive := 3;
             S: positive := 2);
    Port (  clk         :in STD_LOGIC;
            rst         :in STD_LOGIC;
            data_in     :in STD_LOGIC_VECTOR(D-1 downto 0);
            data_ivld   :in STD_LOGIC;
            data_ovld   :out STD_LOGIC;
            data_out    :out STD_LOGIC_VECTOR ((2*2*W)-1 downto 0);
            next_val    :out STD_LOGIC);
end component fir_filter_A;

constant tb_D: positive := 32;
constant tb_N: positive := 4; 
constant tb_W: positive := 8; 
constant tb_K: positive := 5; 
constant tb_L: positive := 3; 
constant tb_S: positive := 2;

signal tb_clk       : std_logic := '0';
signal tb_rst       : std_logic := '0';
signal tb_data_in   : std_logic_vector(tb_D-1 downto 0) := (others => '0');
signal tb_data_ivld : std_logic := '0';
signal tb_data_ovld : std_logic := '0';
signal tb_data_out  : std_logic_vector((2*2*tb_W)-1 downto 0) := (others => '0');
signal tb_next_val  : std_logic := '0';

constant clk_period: time := 20 ns;

type t_arr is array (3 downto 0) of std_logic_vector(tb_D-1 downto 0);
signal arr: t_arr := (  "00000000000000000000000000000000",
                        "01001001011011111100000111110010",
                        "11110011111011011011110101000000",
                        "01111101011101011010101111101011");
                        
signal cc: integer range 0 to 3 := 0;


begin

uut: fir_filter_A 
     generic map(
         D=>tb_D,
         N=>tb_N,
         W=>tb_W,
         K=>tb_K,
         L=>tb_L,
         S=>tb_S
         )
     port map(
         clk      =>tb_clk      ,
         rst      =>tb_rst      ,
         data_in  =>tb_data_in  ,
         data_ivld=>tb_data_ivld,
         data_ovld=>tb_data_ovld,
         data_out =>tb_data_out ,
         next_val =>tb_next_val 
     ); 
     
      

clock_process: process is
begin
 tb_clk <= '0';
 wait for clk_period/2;
 tb_clk <= '1';
 wait for clk_period/2;
end process;

stimuli: process(tb_clk) is
begin
    if rising_edge(tb_clk) then
        if tb_next_val <= '1' then
            tb_data_ivld <='1';
            tb_data_in <= arr(cc);
            cc <= cc + 1;
        else
            tb_data_ivld <= '0';
        end if;
    end if;
end process;        



end Behavioral;

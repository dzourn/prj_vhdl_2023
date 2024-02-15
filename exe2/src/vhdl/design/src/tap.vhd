----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2023 05:31:58 PM
-- Design Name: 
-- Module Name: tap - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tap is
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
end tap;

architecture Behavioral of tap is
signal hx_flag : std_logic := '0';

begin

    
process(clk) is
begin
     
    if (rst = '1') then
        hx_flag <= '0';
    elsif rising_edge(clk) then
       
        if hx_flag = '0' then
            if h_vld = '1' then
                hx_flag <= '1';
            end if;
        else
            if x_vld = '1' then
                y_out <= std_logic_vector(signed(x_in) * signed(h_in));
                x_out <= x_in;
                y_out_vld <= '1';
                x_out_vld <= '1';
            else
                y_out_vld <= '0';
                x_out_vld <= '0';
            end if;
        end if;
    end if;
end process;
end Behavioral;

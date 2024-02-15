----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2023 09:12:49 PM
-- Design Name: 
-- Module Name: count_down - Behavioral
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

entity count_down is
    generic(num:positive := 8);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           hold : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (num-2 downto 0);
           leds : out STD_LOGIC_VECTOR (num-1 downto 0));
end count_down;

architecture Behavioral of count_down is

component clk_divider is
    -- default count value for 12mhz clock to 1hz
    generic(count: positive := 12000000);
    Port ( clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component clk_divider;

signal dclk: std_logic;
signal counter: unsigned(num-2 downto 0) := ( others => '0');
signal result: std_logic_vector(num-1 downto 0) := (others => '0');
signal on_off: std_logic := '1';
signal zero: std_logic := '0';
begin

--CLKDIV: clk_divider generic map(100000000)
--                    port map(clk_in=>clk, 
--                             rst=>rst, 
--                             clk_out=>dclk);

dclk <= clk;

main: process(dclk, rst) is
begin
    
    if(rst = '1') then
        counter <= unsigned(sw);
        zero <= '0';
        on_off <= '1';
--    elsif(hold = '1') then
--        result <= std_logic_vector('0'&counter);
    elsif rising_edge(dclk) then 
        if(hold = '0') then
            if(counter = 0) then
                zero <= '1';
                result <= std_logic_vector('0'&counter);
            else         
                counter <= counter - 1;
                result <= std_logic_vector('0'&counter);
            end if;
        
            if zero = '1' then
                on_off <= not on_off;
                result <= (others => on_off);
            end if;
        end if;
    end if;
 
end process;

leds <= result;

end Behavioral;

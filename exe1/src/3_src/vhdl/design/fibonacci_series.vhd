----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2023 05:58:05 PM
-- Design Name: 
-- Module Name: fibonacci_series - Behavioral
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

entity fibonacci_series is
    generic (num: positive := 8);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           sw: in STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (num-1 downto 0):= (others => '0'));
end fibonacci_series;

architecture Behavioral of fibonacci_series is
--    type state_type is (up, down, hold, reset);
--    signal state : state_type;
    
component clk_divider is
    -- default count value for 12mhz clock to 1hz
    generic(count: integer:= 12000000);
    Port ( clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component clk_divider;

signal dclk: std_logic := '0';
--signal a: integer range 0 to 2**num - 1 := 1;
signal b: integer range 0 to 2**num - 1 := 1;
signal c: integer range 0 to 2*2**num - 1 := 1;
signal b_prev: integer range -1 to 2**num - 1 := 0;
--signal c_next: integer range 0 to 2**num - 1 := 0;
signal result: integer range 0 to 2**num - 1 := 0;

--signal hold: std_logic := '0';
begin

--CLOCK_DIVIDER: clk_divider generic map(100000000)
--                            port map(clk_in => clk, rst => rst, clk_out => dclk);

dclk <= clk;

update: process(dclk, rst) is

begin
    if rst = '1' then
        b <= 1;
        c <= 1;
    elsif rising_edge(dclk) then
        if sw = '0' then
                --fibo
                if c <= 233 then
                    c <= c + b;
                    b <= c;
                    --hold previous b value for reverse fibo
                    b_prev <= b;
                    result <= b;
                else
                  result <= b;
                end if;
               
        else
                --reverse fibo
                --for the values to be updated we hold 233 one more cycle
                if c > 0 then
                    b_prev <= b - b_prev;
                    b <= b_prev;
                    c <= b;
                    result <= b_prev;
                    if b = 0 then
                        result <= b;
                    else
                        result <= b_prev;
                    end if;
                else
                    b <= 1;
                    c <= 1;
                    b_prev <= 0;
                    result <= 0;
                end if;
        end if;  
    end if;
    leds <= std_logic_vector(to_unsigned(result, leds'length));
end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2023 06:24:19 PM
-- Design Name: 
-- Module Name: top_counter - Behavioral
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

entity top_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           seven: out STD_LOGIC_VECTOR(6 downto 0);
           ctr: out STD_LOGIC);
end top_counter;

architecture Behavioral of top_counter is
    
    component clk_divider is
    -- default count value for 12mhz clock to 1hz
    generic(count: integer:= 100000000);
    Port ( clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
    end component clk_divider;
    
    component sevenseg_driver is
        Port ( bin : in STD_LOGIC_VECTOR (15 downto 0);
               ctr_in: in STD_LOGIC;
               seven : out STD_LOGIC_VECTOR (6 downto 0);
               ctr_out : out STD_LOGIC);
    end component sevenseg_driver;                                  
    
    signal counter: unsigned(15 downto 0) := (others => '0');
    signal result: std_logic_vector(15 downto 0) := (others => '0');
    signal bcd_counter: std_logic_vector(19 downto 0) := (others => '0');
    signal ctr_ss: std_logic := '0';
    signal dclk: std_logic := '0';
    
    signal sclk: std_logic := '0';
    
begin
    
    clk_div: clk_divider generic map(100000000)
                        port map(clk_in => clk,
                                 rst => rst,
                                 clk_out => dclk);
    
    --clk divider dclk for counting every second
    process(dclk, rst)
    begin
        if rst = '1' then
            counter <= (others => '0');
            result <= (others => '0');
            bcd_counter <= (others => '0');
        elsif rising_edge(dclk)then
            if counter < 100 then
                counter <= counter + 1;
                result <= std_logic_vector(counter);
            end if;
        end if;
    end process;

    clk_seven: clk_divider generic map(1000000)
                            port map(clk_in => clk,
                                     rst => rst,
                                     clk_out => sclk);
--    --faster clock for updating seven seg
    process(sclk)
    begin
        if rising_edge(sclk) then
            ctr_ss <= not ctr_ss;
        end if;
    end process;
    
    display1: sevenseg_driver port map (
                                bin => result,
                                ctr_in => ctr_ss,
                                seven => seven,
                                ctr_out => ctr);                
    
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2023 06:10:40 PM
-- Design Name: 
-- Module Name: sevenseg_driver - Behavioral
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

entity sevenseg_driver is
    Port ( bin : in STD_LOGIC_VECTOR (15 downto 0);
           ctr_in: in STD_LOGIC;
           seven : out STD_LOGIC_VECTOR (6 downto 0);
           ctr_out : out STD_LOGIC);
end sevenseg_driver;

architecture Behavioral of sevenseg_driver is

component bcd2sevenseg is                                   
    Port ( bcd : in STD_LOGIC_VECTOR (3 downto 0);       
           sevenseg : out STD_LOGIC_VECTOR (6 downto 0));
end component bcd2sevenseg;

component bin2bcd_16bit is                             
    Port (                                          
           tbin : in STD_LOGIC_VECTOR (15 downto 0);
           -- 19 to 16: ten thousands               
           -- 15 to 12: thousands                   
           -- 11 to 8: hundreds                     
           -- 7 to 4: tens                          
           -- 3 to 0: ones                          
           bcd : out STD_LOGIC_VECTOR(19 downto 0));
end component bin2bcd_16bit;   
                               
signal ones_ss, tens_ss: std_logic_vector(6 downto 0) := (others => '0');
signal bcd_ss: std_logic_vector(19 downto 0) := (others => '0');    
signal seven_ones,seven_tens : std_logic_vector(6 downto 0) := (others => '0');                         
begin
    
    bin_bcd: bin2bcd_16bit port map(tbin => bin, bcd => bcd_ss);
    
    --since we only have 2 seven seg digits
    --we only care about ones and tens
    --for more (eg 4 seg digits) we could have 2 ctr bits "00,01,10,11"
    -- and more bcd2sevenseg for hundreds, thousands, ten thousands
    b2s1:bcd2sevenseg port map(
                        bcd => bcd_ss(3 downto 0), 
                        sevenseg => seven_ones);
    
    b2s10:bcd2sevenseg port map(
                        bcd => bcd_ss(7 downto 4), 
                        sevenseg => seven_tens);    
    
    --0 is ones, 1 is tens
    ctr_proc: process(ctr_in) is
    begin
        if ctr_in = '0' then
            seven <= seven_ones;
            ctr_out <= ctr_in;
        else
            seven <= seven_tens;
            ctr_out <= ctr_in;
        end if;
    end process;
    
end Behavioral;

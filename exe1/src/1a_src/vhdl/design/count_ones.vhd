----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2023 08:24:09 PM
-- Design Name: 
-- Module Name: count_ones - Structural
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
library UNISIM;
use UNISIM.VComponents.all;

entity count_ones is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           F : out STD_LOGIC_VECTOR (2 downto 0):= (others => '0'));
end count_ones;

architecture Structural of count_ones is

signal a,b,c,d,na, nb, nc, nd: std_logic;
signal f2_0: std_logic;
signal f1_0, f1_1, f1_2, f1_3, f1_4, f1_5, f1_or0, f1_or1: std_logic;
signal f0_0, f0_1, f0_2, f0_3, f0_4, f0_5, f0_6, f0_7, f0_or0, f0_or1: std_logic;
begin
    
    a <= X(3);
    b <= X(2);
    c <= X(1);
    d <= X(0);  
    na <= not a;
    nb <= not b;
    nc <= not c;
    nd <= not d;
--    F(2) <= a and b and c and d;
    
--    F(1) <= (not a and c and d) or 
--            (not a and b and d) or 
--            (not a and b and c) or 
--            (a and not b and d) or 
--            (a and c and not d) or 
--            (a and b and not c);
            
--    F(0) <= (not a and not b and not c and d) or 
--            (not a and not b and c and not d) or 
--            (not a and b and not c and not d) or 
--            (not a and b and c and d) or 
--            (a and not b and not c and not d) or 
--            -(a and not b and c and d) or 
--            (a and b and not c and d) or 
--            (a and b and c and not d);

F2: AND4 port map(O=>F(2), I0=>a, I1=>b, I2=>c, I3=>d);
    
F10: AND3 port map(O=>f1_0, I0=> na, I1=>c, I2=>d);
F11: AND3 port map(O=>f1_1, I0=> na, I1=>b, I2=>d);
F12: AND3 port map(O=>f1_2, I0=> na, I1=>b, I2=>c);
F13: AND3 port map(O=>f1_3, I0=> a, I1=>nb, I2=>d);
F14: AND3 port map(O=>f1_4, I0=> a, I1=>c, I2=>nd);
F15: AND3 port map(O=>f1_5, I0=> a, I1=>b, I2=>nc);

F1OR0: OR3 port map(O=>f1_or0, I0=> f1_0, I1=> f1_1, I2=>f1_2);
F1OR1: OR3 port map(O=>f1_or1, I0=> f1_3, I1=> f1_4, I2=>f1_5);
F1: OR2 port map(O=>F(1), I0=> f1_or0, I1 => f1_or1);

F00: AND4 port map(O=>f0_0, I0=>na, I1=>nb, I2=>nc, I3=>d);
F01: AND4 port map(O=>f0_1, I0=>na, I1=>nb, I2=>c, I3=>nd);
F02: AND4 port map(O=>f0_2, I0=>na, I1=>b, I2=>nc, I3=>nd); 
F03: AND4 port map(O=>f0_3, I0=>na, I1=>b, I2=>c, I3=>d); 
F04: AND4 port map(O=>f0_4, I0=>a, I1=>nb, I2=>nc, I3=>nd);
F05: AND4 port map(O=>f0_5, I0=>a, I1=>nb, I2=>c, I3=>d);
F06: AND4 port map(O=>f0_6, I0=>a, I1=>b, I2=>nc, I3=>d);
F07: AND4 port map(O=>f0_7, I0=>a, I1=>b, I2=>c, I3=>nd);

F0OR0: OR4 port map(O=>f0_or0 , I0=>f0_0 , I1=> f0_1, I2=> f0_2, I3=> f0_3);
F0OR1: OR4 port map(O=>f0_or1 , I0=>f0_4 , I1=> f0_5, I2=> f0_6, I3=> f0_7);
F0: OR2 port map(O=>F(0), I0=> f0_or0, I1 => f0_or1);

end Structural;

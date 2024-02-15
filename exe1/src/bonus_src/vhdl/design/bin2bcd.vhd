----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2023 08:19:13 PM
-- Design Name: 
-- Module Name: bin2bcd - Behavioral
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

entity bin2bcd_16bit is
    Port ( 
           tbin : in STD_LOGIC_VECTOR (15 downto 0);
           -- 19 to 16: ten thousands
           -- 15 to 12: thousands
           -- 11 to 8: hundreds
           -- 7 to 4: tens
           -- 3 to 0: ones
           bcd : out STD_LOGIC_VECTOR(19 downto 0));
end bin2bcd_16bit;

architecture Behavioral of bin2bcd_16bit is

    component hacky_add5 is                                   
        Port ( binin : in STD_LOGIC_VECTOR (3 downto 0);   
               binout : out STD_LOGIC_VECTOR (3 downto 0));
    end component hacky_add5;      
                                      
    signal c1i, c1o,
        c2i, c2o,
        c3i, c3o,
        c4i, c4o,
        c5i, c5o,
        c6i, c6o,
        c7i, c7o,
        c8i, c8o,
        c9i, c9o,
        c10i, c10o,
        c11i, c11o,
        c12i, c12o,
        c13i, c13o,
        c14i, c14o,
        c15i, c15o,
        c16i, c16o,
        c17i, c17o,
        c18i, c18o,
        c19i, c19o,
        c20i, c20o,
        c21i, c21o,
        c22i, c22o,
        c23i, c23o,
        c24i, c24o,
        c25i, c25o,
        c26i, c26o,
        c27i, c27o,
        c28i, c28o,
        c29i, c29o,
        c30i, c30o,
        c31i, c31o,
        c32i, c32o,
        c33i, c33o,
        c34i, c34o : std_logic_vector(3 downto 0) := (others => '0');
        
  signal bit0 : std_logic := '0';
begin

c1i <= bit0 & tbin(15 downto 13);
c2i <= c1o(2 downto 0) & tbin(12);
c3i <= c2o(2 downto 0) & tbin(11);
c4i <= c3o(2 downto 0) & tbin(10);
c5i <= c4o(2 downto 0) & tbin(9);
c6i <= c5o(2 downto 0) & tbin(8);
c7i <= c6o(2 downto 0) & tbin(7);
c8i <= c7o(2 downto 0) & tbin(6);
c9i <= c8o(2 downto 0) & tbin(5);
c10i <= c9o(2 downto 0) & tbin(4);
c11i <= c10o(2 downto 0) & tbin(3);
c12i <= c11o(2 downto 0) & tbin(2);
c13i <= c12o(2 downto 0) & tbin(1);

c14i <= bit0 & c1o(3) & c2o(3) & c3o(3);
c15i <= c14o(2 downto 0) & c4o(3);
c16i <= c15o(2 downto 0) & c5o(3);
c17i <= c16o(2 downto 0) & c6o(3);
c18i <= c17o(2 downto 0) & c7o(3);
c19i <= c18o(2 downto 0) & c8o(3);
c20i <= c19o(2 downto 0) & c9o(3);
c21i <= c20o(2 downto 0) & c10o(3);
c22i <= c21o(2 downto 0) & c11o(3);
c23i <= c22o(2 downto 0) & c12o(3);

c24i <= bit0 & c14o(3) & c15o(3) & c16o(3);
c25i <= c24o(2 downto 0) & c17o(3);
c26i <= c25o(2 downto 0) & c18o(3);
c27i <= c26o(2 downto 0) & c19o(3);
c28i <= c27o(2 downto 0) & c20o(3);
c29i <= c28o(2 downto 0) & c21o(3);
c30i <= c29o(2 downto 0) & c22o(3);

c31i <= bit0 & c24o(3) & c25o(3) & c26o(3);
c32i <= c31o(2 downto 0) & c27o(3);
c33i <= c32o(2 downto 0) & c28o(3);
c34i <= c33o(2 downto 0) & c29o(3);
 
bcd <= c31o(3) & c32o(3) & c33o(3) & c34o(3 downto 0) & c30o(3 downto 0) &
       c23o(3 downto 0) & c13o(3 downto 0) & tbin(0);


U1: hacky_add5 port map(binin=>c1i, binout=>c1o);
U2: hacky_add5 port map(binin=>c2i, binout=>c2o);
U3: hacky_add5 port map(binin=>c3i, binout=>c3o);
U4: hacky_add5 port map(binin=>c4i, binout=>c4o);
U5: hacky_add5 port map(binin=>c5i, binout=>c5o);
U6: hacky_add5 port map(binin=>c6i, binout=>c6o);
U7: hacky_add5 port map(binin=>c7i, binout=>c7o);
U8: hacky_add5 port map(binin=>c8i, binout=>c8o);
U9: hacky_add5 port map(binin=>c9i, binout=>c9o);
U10: hacky_add5 port map(binin=>c10i, binout=>c10o);
U11: hacky_add5 port map(binin=>c11i, binout=>c11o);
U12: hacky_add5 port map(binin=>c12i, binout=>c12o);
U13: hacky_add5 port map(binin=>c13i, binout=>c13o);
U14: hacky_add5 port map(binin=>c14i, binout=>c14o);
U15: hacky_add5 port map(binin=>c15i, binout=>c15o);
U16: hacky_add5 port map(binin=>c16i, binout=>c16o);
U17: hacky_add5 port map(binin=>c17i, binout=>c17o);
U18: hacky_add5 port map(binin=>c18i, binout=>c18o);
U19: hacky_add5 port map(binin=>c19i, binout=>c19o);
U20: hacky_add5 port map(binin=>c20i, binout=>c20o);
U21: hacky_add5 port map(binin=>c21i, binout=>c21o);
U22: hacky_add5 port map(binin=>c22i, binout=>c22o);
U23: hacky_add5 port map(binin=>c23i, binout=>c23o);
U24: hacky_add5 port map(binin=>c24i, binout=>c24o);
U25: hacky_add5 port map(binin=>c25i, binout=>c25o);
U26: hacky_add5 port map(binin=>c26i, binout=>c26o);
U27: hacky_add5 port map(binin=>c27i, binout=>c27o);
U28: hacky_add5 port map(binin=>c28i, binout=>c28o);
U29: hacky_add5 port map(binin=>c29i, binout=>c29o);
U30: hacky_add5 port map(binin=>c30i, binout=>c30o);
U31: hacky_add5 port map(binin=>c31i, binout=>c31o);
U32: hacky_add5 port map(binin=>c32i, binout=>c32o);
U33: hacky_add5 port map(binin=>c33i, binout=>c33o);
U34: hacky_add5 port map(binin=>c34i, binout=>c34o);
 
end Behavioral;
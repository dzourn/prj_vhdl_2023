----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2023 08:02:45 PM
-- Design Name: 
-- Module Name: fir_filter_A - Behavioral
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

entity fir_filter_A is
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
end fir_filter_A;

architecture Behavioral of fir_filter_A is

component Controller_v2 is
    Generic (D: positive := 32;
             N: positive := 4;
             W: positive := 8;
             K: positive := 5;
             L: positive := 3;
             S: positive := 2);
    Port ( clk :        in  STD_LOGIC;
           rst :        in  STD_LOGIC;
           data_in:     in  STD_LOGIC_VECTOR(D-1 downto 0);
           data_ivld:   in  STD_LOGIC;
           x:           out STD_LOGIC_VECTOR(W-1 downto 0);
           x_vld:       out STD_LOGIC;
           h_val:       out STD_LOGIC_VECTOR(W-1 downto 0);
           h_vld:       out STD_LOGIC;
           tap_select:  out STD_LOGIC_VECTOR(S-1 downto 0);
           next_val:    out STD_LOGIC);
end component Controller_v2;

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


signal top_x:          STD_LOGIC_VECTOR(W-1 downto 0):= (others => '0');
signal top_x_vld:      STD_LOGIC:= '0';                     
signal top_h_val:      STD_LOGIC_VECTOR(W-1 downto 0):= (others => '0');
signal top_h_vld:      STD_LOGIC:= '0';                     
signal top_tap_select: STD_LOGIC_VECTOR(S-1 downto 0):= (others => '0');
signal top_next_val:   STD_LOGIC:= '0';

type t_top_h_array is array(0 to N-1) of std_logic_vector(W-1 downto 0);
signal top_h_array : t_top_h_array := (others => (others => '0'));
type t_top_h_vld_array is array(0 to N-1) of std_logic;
signal top_h_vld_array: t_top_h_vld_array := (others => '0');
signal h_counter: integer range 0 to N-1 := 0;


constant y_max_counter: integer := N-1;
type t_y_array is array(0 to N-1) of std_logic_vector((2*W)-1 downto 0);
signal y_array : t_y_array := (others => (others => '0'));
signal y_vld_array: std_logic_vector(0 to N-1) := (others => '0');

type t_x_out_array is array(0 to N-1) of std_logic_vector(W-1 downto 0);
signal x_out_array: t_x_out_array := (others => (others => '0'));
type t_x_out_vld_array is array(0 to N-1) of std_logic;
signal x_out_vld_array : t_x_out_vld_array := (others => '0');

signal top_y_out: signed((2*2*W)-1 downto 0) := (others => '0');

begin

controller_logic: Controller_v2 generic map(
                D => D,
                N => N,
                W => W,
                K => K,
                L => L,
                S => S)
              port map(
                clk        => clk      , 
                rst        => rst      , 
                data_in    => data_in  , 
                data_ivld  => data_ivld, 
                x          => top_x        , 
                x_vld      => top_x_vld    , 
                h_val      => top_h_val    ,                
                h_vld      => top_h_vld    , 
                tap_select => top_tap_select,          
                next_val   => top_next_val);   

next_val <= top_next_val;

process(top_h_vld, top_h_val) is
begin
    if top_h_vld = '1' then
        top_h_array(to_integer(unsigned(top_tap_select))) <= top_h_val;
        top_h_vld_array(to_integer(unsigned(top_tap_select))) <= top_h_vld;
    end if;
end process;




first_tap: tap
    generic map(
            D => D,
            N => N,
            W => W,
            K => K,
            L => L)
    port map(
            clk     => clk,
            rst     => rst,
            h_in    => top_h_array(0),
            h_vld   => top_h_vld_array(0),
            x_in    => top_x,
            x_vld   => top_x_vld,
            x_out   => x_out_array(0),
            x_out_vld => x_out_vld_array(0),
            y_out => y_array(0),
            y_out_vld => y_vld_array(0));


--resolve x_in x_vld in         
gen: for i in 1 to N-1 generate
    tap_comp: tap
        generic map(
            D => D,
            N => N,
            W => W,
            K => K,
            L => L)
        port map(
            clk     => clk,
            rst     => rst,
            h_in    => top_h_array(i),
            h_vld   => top_h_vld_array(i),
            x_in    => x_out_array(i-1),
            x_vld   => x_out_vld_array(i-1),
            x_out   => x_out_array(i),
            x_out_vld => x_out_vld_array(i),
            y_out   => y_array(i),
            y_out_vld => y_vld_array(i));
end generate;            


accumulate: process(clk) is
    variable total: signed((2*2*W)-1 downto 0) := (others => '0');
begin
    
    --all other signals are being reset by the components
    if rising_edge(clk) then
        
        if signed(y_vld_array) = to_signed(-1, y_vld_array'length) then
            total := (others => '0');
            for i in 0 to y_max_counter loop
                total := total + signed(y_array(i));
            end loop;
            data_ovld <= '1';
        else
            total := (others => '0');
            data_ovld <= '0';
        end if;
    end if;
    data_out <= std_logic_vector(total);
end process; 


end Behavioral;

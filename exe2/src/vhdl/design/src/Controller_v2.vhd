----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2023 06:21:10 PM
-- Design Name: 
-- Module Name: Controller_v2 - Behavioral
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

entity Controller_v2 is
Generic (    D: positive := 32;
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
end Controller_v2;

architecture Behavioral of Controller_v2 is

type state_type is (reset, wait_first, send_h, last_send_h, send_x, last_send_x, hold);
signal state: state_type := reset;
signal clk_cycle_counter: integer range 0 to N := 0;

signal tmp_select : unsigned(S-1 downto 0) := (others => '0');
signal h_x_flag: std_logic := '0'; --0 means we send h, 1 means we send x

type t_split_data is array(0 to N-1) of std_logic_vector(W-1 downto 0);
signal split_data: t_split_data := (others => (others => '0'));

begin
slice: process(data_ivld) is
begin
    if falling_edge(data_ivld) then    
        for i in 0 to N-1 loop
                split_data(N-1-i) <= data_in(W*(i+1)-1 downto W*i);
        end loop;
    end if;
end process;

clock_process: process(clk,rst) is
begin
        if (rst = '1') then
            state <= reset;
        elsif rising_edge(clk) then
            case state is
                when reset =>
                    clk_cycle_counter <= 0;
                    tmp_select <= (others => '0');
                    h_x_flag <= '0';
                    next_val <= '1';
                    state <= wait_first;
             
                when wait_first =>
                    if data_ivld = '1' then
                        state <= send_h;
                    end if;
                    next_val <= '0';
                   
                when send_h=>
                   
                    next_val <= '0';
                    h_val <= split_data(clk_cycle_counter);
                    h_vld <= '1';
                    tmp_select <= tmp_select + 1;
                    tap_select <= std_logic_vector(tmp_select);
                    clk_cycle_counter <= clk_cycle_counter + 1;
                   
                    if(clk_cycle_counter = N-4) then
                        state <= last_send_h;
                        h_x_flag <= '1';
                    end if;
                    
                   
                    
                when last_send_h=>
                    if(h_x_flag = '1') then
                        next_val <= '1';
                        h_x_flag <= '0';
                    else
                        next_val <= '0';
                    end if;
                    
                    h_val <= split_data(clk_cycle_counter);
                    tmp_select <= tmp_select + 1;
                    tap_select <= std_logic_vector(tmp_select);
                    clk_cycle_counter <= clk_cycle_counter + 1;
                    
                    if(clk_cycle_counter = N-1) then
                        state <= send_x;
                        clk_cycle_counter <= 0;
                    end if;
                    
                when send_x =>
                        
                        --hacky hold position 
                        --find better way
                        if(unsigned(data_in) = 0) then
                            state <= hold;
                        end if;
                        h_vld <= '0';
                        if(clk_cycle_counter = N-4) then
                            state <= last_send_x;
                            h_x_flag <= '1';
                        end if;
                        
                        x <= split_data(clk_cycle_counter);
                        clk_cycle_counter <= clk_cycle_counter + 1;
                        
                when last_send_x =>
                        --hacky hold position 
                        --find better way
                        if(unsigned(data_in) = 0) then
                            state <= hold;
                        end if;
                        if(h_x_flag = '1') then
                            next_val <= '1';
                            h_x_flag <= '0';
                        else
                            next_val <= '0';
                        end if;
                        
                        x <= split_data(clk_cycle_counter);
                        x_vld <= '1';
                        clk_cycle_counter <= clk_cycle_counter + 1;
                        
                        if(clk_cycle_counter = N-1) then
                            state <= send_x;
                            clk_cycle_counter <= 0;
                        end if;  
                 when hold =>
                        next_val <= '0';
                        x_vld <='0';
--                        if(data_ivld = '1') then
--                            state <= send_x; 
--                        end if;
            end case;
        end if;
end process;          

   
end Behavioral;

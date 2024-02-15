----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2023 08:15:41 PM
-- Design Name: 
-- Module Name: system - Behavioral
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

entity system is
    generic (
             D: positive := 32;
             N: positive := 4;
             W: positive := 8;
             K: positive := 5;
             L: positive := 3;
             S: positive := 2;
             rom_size: positive := 12;
             LEDS_DATA_OUT_SIZE: positive := 8;
             ADDRESS_WIDTH : positive := 8);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           switches: in STD_LOGIC_VECTOR(ADDRESS_WIDTH-1 downto 0);
           data_out : out STD_LOGIC_VECTOR (LEDS_DATA_OUT_SIZE-1 downto 0));
end system;

architecture Behavioral of system is

component ROM_mem is
  Generic (rom_size: positive := 3;
           cell_size: positive := 32);
  port (next_val : in  std_logic;
        clk      : in  std_logic;
        rst      : in  std_logic;
        mem_out  : out std_logic_vector(cell_size-1 downto 0);
        mem_vld  : out std_logic);
end component ROM_mem;

component fir_filter_A is
    generic (
             D: positive := 32;
             N: positive := 4;
             W: positive := 8;
             K: positive := 5;
             L: positive := 3;
             S: positive := 2);
    Port (  clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            data_in: in STD_LOGIC_VECTOR(D-1 downto 0);
            data_ivld: in STD_LOGIC;
            data_ovld: out STD_LOGIC;
            data_out : out STD_LOGIC_VECTOR ((2*2*W)-1 downto 0);
            next_val : out STD_LOGIC);
end component fir_filter_A;

component RAM_mem is
  generic(DATA_WIDTH    : integer := 16;
          BRAM_SIZE     : integer := 256; -- 2 ** ADDRESS_WIDTH
          ADDRESS_WIDTH : integer := 8);
  port(data_in   : in  std_logic_vector(DATA_WIDTH-1 downto 0);     -- Data to write at the BRAM
       addr_w_in : in  std_logic_vector(ADDRESS_WIDTH-1 downto 0);  -- Address to write to the BRAM
       addr_r_in : in  std_logic_vector(ADDRESS_WIDTH-1 downto 0);  -- Address to read from the BRAM        
       wrt_en_in : in  std_logic;  -- Enable the write process
       clk       : in  std_logic;  -- Clock
       data_out  : out std_logic_vector(DATA_WIDTH-1 downto 0)); -- Data from the read address
end component RAM_mem;

constant FINAL_DATA_LENGTH : integer := 2*2*W;
signal top_rom_data_out: std_logic_vector(D-1 downto 0) := (others => '0');
signal top_rom_vld : std_logic := '0';

signal top_fir_data_out: std_logic_vector(FINAL_DATA_LENGTH-1 downto 0) := (others => '0');
signal top_fir_data_vld: std_logic := '0';
signal top_next_val : std_logic := '0';

signal top_ram_addr_w_counter: unsigned(ADDRESS_WIDTH-1 downto 0) := (others => '0');
signal top_data_ram_out: std_logic_vector(FINAL_DATA_LENGTH-1 downto 0) := (others => '0');

begin


ROM_MEMORY: ROM_mem
            generic map(
                rom_size =>  rom_size,
                cell_size => D)
            port map(
                next_val => top_next_val,
                clk => clk,
                rst => rst,
                mem_out => top_rom_data_out,
                mem_vld => top_rom_vld);
                
                
FIR_FILTER: fir_filter_A
            generic map(
                D => D,
                N => N,
                W => W,
                K => K,
                L => L,
                S => S)
            port map(
                clk => clk,
                rst => rst,
                data_in => top_rom_data_out,
                data_ivld => top_rom_vld,
                data_out => top_fir_data_out,
                data_ovld => top_fir_data_vld,
                next_val => top_next_val);
               

process(clk) is
begin
    if(rst = '1') then
        top_ram_addr_w_counter <= (others => '0');
    elsif rising_edge(clk) then
        if(top_fir_data_vld = '1') then
            top_ram_addr_w_counter <= top_ram_addr_w_counter + 1;
        end if;
    end if;
    
end process;
       
RAM_MEMORY: RAM_mem
            generic map(
                DATA_WIDTH => FINAL_DATA_LENGTH,
                BRAM_SIZE  => 2**ADDRESS_WIDTH,
                ADDRESS_WIDTH => ADDRESS_WIDTH)
            port map(
                data_in => top_fir_data_out,
                addr_w_in => std_logic_vector(top_ram_addr_w_counter),
                addr_r_in => switches,
                wrt_en_in => top_fir_data_vld,
                clk => clk,
                data_out => top_data_ram_out);

data_out <= top_data_ram_out(LEDS_DATA_OUT_SIZE-1 downto 0);    
end Behavioral;

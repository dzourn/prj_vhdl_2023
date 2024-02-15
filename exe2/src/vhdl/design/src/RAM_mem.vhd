library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity RAM_mem is
  generic(DATA_WIDTH    : integer := 16;
          BRAM_SIZE     : integer := 256; -- 2 ** ADDRESS_WIDTH
          ADDRESS_WIDTH : integer := 8);
  port(data_in   : in  std_logic_vector(DATA_WIDTH-1 downto 0);     -- Data to write at the BRAM
       addr_w_in : in  std_logic_vector(ADDRESS_WIDTH-1 downto 0);  -- Address to write to the BRAM
       addr_r_in : in  std_logic_vector(ADDRESS_WIDTH-1 downto 0);  -- Address to read from the BRAM        
       wrt_en_in : in  std_logic;  -- Enable the write process
       clk       : in  std_logic;  -- Clock
       data_out  : out std_logic_vector(DATA_WIDTH-1 downto 0)); -- Data from the read address
end RAM_mem;

architecture Behavioral of RAM_mem is
  type ram_type is array ((BRAM_SIZE-1) downto 0) of std_logic_vector((DATA_WIDTH-1) downto 0);
  signal ram : ram_type := (others => (others => '0'));
begin

process (clk)
begin
    if rising_edge(clk) then
      data_out <= ram(conv_integer(addr_r_in));
      if (wrt_en_in = '1') then
        ram(conv_integer(addr_w_in)) <= data_in;
      end if;
    end if;
  end process;
end Behavioral;
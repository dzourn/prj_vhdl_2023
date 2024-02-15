library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ROM_mem is
  Generic (rom_size: positive := 12;
           cell_size: positive := 32);
  port (next_val : in  std_logic;
        clk      : in  std_logic;
        rst      : in  std_logic;
        mem_out  : out std_logic_vector(cell_size-1 downto 0);
        mem_vld  : out std_logic);
end ROM_mem;

architecture behavioral of ROM_mem is

  type ram_type is array (0 to rom_size-1) of std_logic_vector(cell_size-1 downto 0);

  signal ROM_mem : ram_type := ("00000000000000000000000000000000",
                                "01001001011011111100000111110010",
                                "11110011111011011011110101000000",
                                "01111101011101011010101111101011",
                                -----------------------------------
                                "00000000000000000000000000000000",
                                "00000000000000000000000000000000",
                                "00000000000000000000000000000000",
                                "00000000000000000000000000000000",
                                "00000000000000000000000000000000",
                                "00000000000000000000000000000000",
                                "00000000000000000000000000000000",
                                
                                "00000000000000000000000000000000"
                                );

  signal count   : integer range 0 to 11;

begin

  rom : process(clk)
  begin
    if rising_edge(clk)then
      if rst = '1' then
        count   <= 0;
        mem_vld <= '0';
        mem_out <= (others => '0');
      else
        if(next_val = '1')then
          if count >= 11 then
            count <= 4;
          else
            count <= count + 1;
          end if;
          mem_vld <= '1';
        else
          mem_vld <= '0';
        end if;
        mem_out <= ROM_mem(count);
       
      end if;
    end if;
  end process;

end behavioral;
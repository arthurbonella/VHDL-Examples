----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:05:58 11/17/2020 
-- Design Name: 
-- Module Name:    johnsons_counter_8bits - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity johnsons_counter_8bits is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  enable: in STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (7 downto 0));
end johnsons_counter_8bits;

architecture Behavioral of johnsons_counter_8bits is
	signal count_reg: STD_LOGIC_VECTOR(7 downto 0);
begin
  -- descreva aqui a arquitetura para gerar a contagem seguindo a tabela quando enable = '1'
    process(clk, reset)
    begin 
		if(reset = '1') then
			--reset
         count_reg <= "00000000";       
      elsif (clk'event and clk = '1') then
			if (enable = '1') then  
				--shifta de 7 à 1 para direita
				count_reg(6 downto 0) <= count_reg(7 downto 1);
				--inverte bit 0 e coloca na posição 7
				count_reg(7) <= not count_reg(0);
				--como não tem referencia, estou usando a ordem da tabela do slide 3/11
			end if;
      end if;                      
    end process;
    count <= count_reg;
end Behavioral;


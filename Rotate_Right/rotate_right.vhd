library ieee;
use ieee.std_logic_1164.all;
entity rotate_right is
   port(
      a: in std_logic_vector(7 downto 0);
      amt: in std_logic_vector(2 downto 0);
      y: out std_logic_vector(7 downto 0)
   );
end rotate_right;

architecture one_level_arch of rotate_right is
begin
   with amt select
       y<= a                             when "000",
           a(0) & a(7 downto 1)          when "001",
           a(1 downto 0) & a(7 downto 2) when "010",
           a(2 downto 0) & a(7 downto 3) when "011",
           a(3 downto 0) & a(7 downto 4) when "100",
           a(4 downto 0) & a(7 downto 5) when "101",
           a(5 downto 0) & a(7 downto 6) when "110",
           a(6 downto 0) & a(7) when others; -- 111
end one_level_arch;

architecture multi_level_arch of rotate_right is
-- insira aqui os sinais que recebem os sinais intermediários
	signal aux1,aux2,aux3: std_logic_vector(7 downto 0);

begin
   -- primeiro nível, desloca 0 ou 1 bit

	
	aux1 <= a(0) & a(7 downto 1) when amt(0) = '1' else a;


   -- segundo nível, desloca 0 ou 2 bits 
	
	
	aux2 <= aux1(1 downto 0) & aux1(7 downto 2) when amt(1) = '1' else aux1;


   -- terceiro nível, desloca 0 ou 4 bits 


	aux3 <= aux2(3 downto 0) & aux2(7 downto 4) when amt(2) = '1' else aux2; 


   -- gerar a saída a partir da saída do terceiro nível

	y <= aux3;
	
end multi_level_arch;
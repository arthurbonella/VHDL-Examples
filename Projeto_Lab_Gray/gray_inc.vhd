library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity g_inc is
   port(
      g: in std_logic_vector(3 downto 0);
      g1: out std_logic_vector(3 downto 0)
   );
end g_inc ;

architecture direct_arch of g_inc is
begin
   with g select
      g1 <= "0001" when "0000",
            "0011" when "0001",
            "0010" when "0011",
            "0110" when "0010",
            "0111" when "0110",
            "0101" when "0111",
            "0100" when "0101",
            "1100" when "0100",
            "1101" when "1100",
            "1111" when "1101",
            "1110" when "1111",
            "1010" when "1110",
            "1011" when "1010",
            "1001" when "1011",
            "1000" when "1001",
            "0000" when others; -- "1000"
end direct_arch;

architecture indirect_arch of g_inc is
-- crie aqui os sinais intermediários que recebem os resultados de cada nível
	signal aux1,aux2: std_logic_vector(3 downto 0);

begin
   -- primeiro nível, conversão de Gray para binário
	
	aux1 <= g xor ('0' & aux1(3 downto 1));

   -- segundo nível, incrementador binário

	aux2 <= std_logic_vector((unsigned(aux1)) + 1);

   -- terceiro nível, conversão de binário para Gray

	g1 <= aux2 xor ('0' & aux2(3 downto 1));

end indirect_arch;


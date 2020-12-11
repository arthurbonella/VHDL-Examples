--=============================
-- Listing 4.4
--=============================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity simple_alu is
   port(
      ctrl: in  std_logic_vector(2 downto 0);
      src0, src1: in std_logic_vector(7 downto 0);
      result: out std_logic_vector(7 downto 0)
   );
end simple_alu;

architecture cond_arch of simple_alu is
   signal sum, diff, inc: std_logic_vector(7 downto 0);
begin
   inc <= std_logic_vector(signed(src0)+1);
   sum <= std_logic_vector(signed(src0)+signed(src1));
   diff <= std_logic_vector(signed(src0)-signed(src1));
   result <= inc  when ctrl(2)='0' else
             sum  when ctrl(1 downto 0)="00" else
             diff when ctrl(1 downto 0)="01" else
             src0 and src1 when ctrl(1 downto 0)="10" else
             src0 or src1;
end cond_arch;


--=============================
-- Listing 4.8
--=============================
architecture sel_arch of simple_alu is
   signal sum, diff, inc: std_logic_vector(7 downto 0);
begin
   inc <= std_logic_vector(signed(src0)+1);
   sum <= std_logic_vector(signed(src0)+signed(src1));
   diff <= std_logic_vector(signed(src0)-signed(src1));
   with ctrl select
      result <= inc           when "000"|"001"|"010"|"011",
                sum           when "100",
                diff          when "101",
                src0 and src1 when "110",
                src0 or src1  when others; -- "111"
end sel_arch;

--=============================
-- Listing 5.4
--=============================
architecture if_arch of simple_alu is
   signal src0s, src1s: signed(7 downto 0);
begin
   src0s <= signed(src0);
   src1s <= signed(src1);
   process(ctrl,src0,src1,src0s,src1s)
   begin
     if (ctrl(2)='0') then
        result <= std_logic_vector(src0s + 1);
     elsif (ctrl(1 downto 0)="00")then
        result <=  std_logic_vector(src0s + src1s);
     elsif (ctrl(1 downto 0)="01")then
        result <= std_logic_vector(src0s - src1s);
     elsif (ctrl(1 downto 0)="10")then
        result <= src0 and src1 ;
     else
        result <= src0 or src1;
     end if;
   end process;
end if_arch;


--=============================
-- Listing 5.9
--=============================
architecture case_arch of simple_alu is
   signal src0s, src1s: signed(7 downto 0);
begin
   src0s <= signed(src0);
   src1s <= signed(src1);
   process(ctrl,src0,src1,src0s,src1s)
   begin
      case ctrl is
         when "000"|"001"|"010"|"011" =>
            result <=  std_logic_vector(src0s + 1);
         when "100" =>
            result <=  std_logic_vector(src0s + src1s);
         when "101" =>
            result <= std_logic_vector(src0s - src1s);
         when "110" =>
            result <= src0 and src1;
         when others =>    -- "111"
            result <= src0 or src1;
      end case;
   end process;
end case_arch ;
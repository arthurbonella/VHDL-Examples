-- Listing 4.12
library ieee;
use ieee.std_logic_1164.all;

entity car_detect_tb is
end car_detect_tb;

architecture arch of car_detect_tb is
   constant T: time := 20 ns; -- clk period
   signal clk, reset: std_logic;
	signal inc, dec, SE, SI: std_logic;
begin
   --**************************
   -- instantiation
   --**************************
   car_detect_unit: entity work.car_detect(Behavioral)
      port map(clk=>clk, 
		         reset=>reset, 
               SI =>SI,
               SE =>SE,
               inc =>inc,
               dec =>dec);  
   --**************************
   -- clock
   --**************************
   -- 20 ns clock running forever
   process
   begin
      clk <= '0';
      wait for T/2;
      clk <= '1';
      wait for T/2;
   end process;
   --**************************
   -- reset
   --**************************
   -- reset asserted for T/2
   reset <= '1', '0' after T/2;

   --**************************
   -- other stimulus
   --**************************
   process
   begin
		SI <= '0';
		SE <= '0';
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		SI <= '0';
		SE <= '1';
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		SI <= '1';
		SE <= '1';
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		SI <= '1';
		SE <= '0';
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		SI <= '0';
		SE <= '0';
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		SI <= '0';
		SE <= '0';
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		SI <= '1';
		SE <= '0';
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		SI <= '1';
		SE <= '1';
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		SI <= '0';
		SE <= '1';
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		SI <= '0';
		SE <= '0';
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);
		wait until falling_edge(clk);

--      for i in 1 to 10 loop -- count 10 clocks
--         wait until falling_edge(clk);
--      end loop;
      --**************************
      -- terminate simulation
      --**************************
      assert false
         report "Simulation Completed"
       severity failure;
   end process ;
end arch;

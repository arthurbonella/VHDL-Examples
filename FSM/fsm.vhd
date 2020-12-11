----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:38:03 11/22/2020 
-- Design Name: 
-- Module Name:    fsm - Behavioral 
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

entity fsm is
	Port(
		clk,reset,timer_tick : in  STD_LOGIC;
		dig : out STD_LOGIC_VECTOR (1 downto 0);
		letter : out STD_LOGIC_VECTOR (7 downto 0)
	);
end fsm;

architecture Behavioral of fsm is
	type eg_state_type is (s0, s1, s2, s3);
	signal state_reg, state_next : eg_state_type;
	
begin

	--registrador de estado
	process(clk, reset)
	begin
		if(reset = '1') then
			state_reg <= s0;
		elsif (clk'event and clk = '1') then
			state_reg <= state_next;
		end if;
	end process;
	
	--logica de proximo estado
	process(state_reg,timer_tick)
	begin
		case state_reg is
			when s0 =>
				if timer_tick = '1' then
					state_next <= s1;
				else
					state_next <= s0;
				end if;
			when s1 =>
				if timer_tick = '1' then
					state_next <= s2;
				else
					state_next <= s1;
				end if;
			when s2 =>
				if timer_tick = '1' then
					state_next <= s3;
				else
					state_next <= s2;
				end if;
			when s3 =>
				if timer_tick = '1' then
					state_next <= s0;
				else
					state_next <= s3;
				end if;
		end case;
	end process;
	
	--saida logica Moore
	process(state_reg)
	begin
		case state_reg is
			when s0 =>
				dig <= "11";
				letter <= "01001010"; --J
			when s1 =>
				dig <= "10";
				letter <= "01001111"; --O
			when s2 =>
				dig <= "01";
				letter <= "01001010"; --J
			when s3 =>
				dig <= "00";
				letter <= "01001111"; --O
		end case;
	end process;
	
	--¦¦¦¦¦ ¦¦¯¯¯¦ ¦¦¦¦¦ ¦¦¯¯¯¦
	--¦_¦¦¦ ¦¦¦¦¦¦ ¦_¦¦¦ ¦¦¦¦¦¦
	--¦¦__¦ ¦¦___¦ ¦¦__¦ ¦¦___¦

end Behavioral;


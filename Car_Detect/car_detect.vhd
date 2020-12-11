----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:27:56 12/09/2020 
-- Design Name: 
-- Module Name:    car_detect - Behavioral 
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

entity car_detect is
	Port(
		clk : in  STD_LOGIC;
      reset : in  STD_LOGIC;
      SI: in STD_LOGIC;
		SE: in STD_LOGIC;
		inc: out STD_LOGIC;
		dec: out STD_LOGIC
	);
end car_detect;

architecture Behavioral of car_detect is
	type eg_state_type is (s00,s10s,s01e,s11s,s11e,s01s,s10e,saiu,entrou);
	signal state_reg, state_next : eg_state_type;
begin

process(clk, reset)
	begin
		if(reset = '1') then
			state_reg <= s00;
		elsif (clk'event and clk = '1') then
			state_reg <= state_next;
		end if;
	end process;
	
	process(state_reg, SI, SE)
	begin
		case state_reg is
			when s00 =>  
				if (SI = '1' and SE = '0') then
					state_next <= s10s;
				elsif (SI = '0' and SE = '1') then
					state_next <= s01e;
				else
					state_next <= s00;
				end if;-- ok
			when s10s =>
				if (SI = '1' and SE = '1') then
					state_next <= s11s;
				elsif (SI = '0' and SE = '0') then
					state_next <= s00;
				else
					state_next <= s10s;
				end if;--ok
			when s01e =>
				if (SI = '1' and SE = '1') then
					state_next <= s11e;
				elsif (SI = '0' and SE = '0') then
					state_next <= s00;
				else
					state_next <= s01e;
				end if;--ok
			when s11s =>
				if (SI = '0' and SE = '1') then
					state_next <= s01s;
				elsif (SI = '1' and SE = '0') then
					state_next <= s10s;
				else
					state_next <= s11s;
				end if;--ok
			when s11e =>
				if (SI = '1' and SE = '0') then
					state_next <= s10e;
				elsif (SI = '0' and SE = '1') then
					state_next <= s01e;
				else
					state_next <= s11e;
				end if;--ok
			when s01s =>
				if (SI = '0' and SE = '0') then
					state_next <= saiu;
				elsif (SI = '1' and SE = '1') then
					state_next <= s11s;
				else
					state_next <= s01s;
				end if;--ok
			when s10e =>                  
				if (SI = '0' and SE = '0') then
					state_next <= entrou;
				elsif (SI = '1' and SE = '1') then
					state_next <= s11e;
				else
					state_next <= s10e;
				end if;--ok
			when saiu =>
				state_next <= s00;--ok
			when entrou =>
				state_next <= s00;--ok
		end case;
	end process;
	
	process(state_reg)
	begin
		case state_reg is
			when s00 =>  
				inc <= '0';
				dec <= '0';
			when s10s => 
				inc <= '0';
				dec <= '0';
			when s01e => 
				inc <= '0';
				dec <= '0';
			when s11s => 
				inc <= '0';
				dec <= '0';
			when s11e =>
				inc <= '0';
				dec <= '0';			
			when s01s =>
				inc <= '0';
				dec <= '0';			
			when s10e => 
				inc <= '0';
				dec <= '0';
			when saiu => 
				inc <= '0';
				dec <= '1';
			when entrou => 
				inc <= '1';
				dec <= '0';
		end case;
	end process;


end Behavioral;


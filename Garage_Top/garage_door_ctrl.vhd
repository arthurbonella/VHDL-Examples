----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:27:40 12/09/2020 
-- Design Name: 
-- Module Name:    garage_door_ctrl - Behavioral 
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

entity garage_door_ctrl is
	Port(
		clk,reset: in STD_LOGIC;
		IV: in STD_LOGIC;
		SI,SE: in STD_LOGIC;
		Tick: in STD_LOGIC;
		A,F: in STD_LOGIC;
		L,start: out STD_LOGIC;
		m: out STD_LOGIC_VECTOR (1 downto 0)
		);
end garage_door_ctrl;

architecture Behavioral of garage_door_ctrl is
	type eg_state_type is (fechado, abrindo, aberto, verifica, fechando);
	signal state_reg, state_next : eg_state_type;
begin

	process(clk, reset)
	begin
		if(reset = '1') then
			state_reg <= fechado;
		elsif (clk'event and clk = '1') then
			state_reg <= state_next;
		end if;
	end process;
	
	process(state_reg, Tick, IV,A, SI, SE, F)
	begin
		case state_reg is
			when fechado =>
				if (IV = '1') then
					state_next <= abrindo;
				else
					state_next <= fechado;
				end if;
			when abrindo =>
				if (A = '1')then
					state_next <= aberto;
				else
					state_next <= abrindo;
				end if;
			when aberto =>
				if Tick = '1' then
					state_next <= verifica;
				else
					state_next <= aberto;
				end if;
			when verifica =>
				if (not(SI = '1' or SE = '1'))then
					state_next <= fechando;
				else
					state_next <= verifica;
				end if;
			when fechando =>
				if F = '1' then
					state_next <= fechado;
				elsif ((not F = '1')and((SE = '1')or(SI = '1'))) then
					state_next <= abrindo;
				else
					state_next <= fechando;
				end if;
		end case;
	end process;
	
	process(state_reg)
	begin
		case state_reg is
			when fechado =>  
				L <= '0';
				m <= "00";
				start <= '0';
			when abrindo =>
				L <= '1';
				m <= "01";
				start <= '1';
			when aberto =>
				L <= '1';
				m <= "00";
				start <= '0';
			when verifica =>
				L <= '1';
				m <= "00";
				start <= '0';
			when fechando =>
				L <= '1';
				m <= "10";
				start <= '0';
		end case;
	end process;


end Behavioral;


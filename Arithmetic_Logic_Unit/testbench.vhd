-- TestBench Template 

  library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

  entity testbench IS
  end testbench;

  architecture behavior_tb of testbench is 
	 signal src0,src1,result:  std_logic_vector(7 downto 0);
	 signal ctrl: std_logic_vector(2 downto 0);
  begin

  -- Component Instantiation
  uut: entity work.simple_alu(case_arch) 
  port map (ctrl=>ctrl, src0=>src0,src1=>src1,result=>result);

  --  Test Bench Statements
   process
   begin
      ctrl<="000";
	
		for i in 1 to 8 loop
		
			src0 <= "00000001"; --  src0
			src1 <= "00000010"; --  src1
			--
			case ctrl is
				when "000"|"001"|"010"|"011" =>
					if not (result = "00000010") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when "100" =>
					if not (result = "00000011") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when "101" =>
					if not (result = "11111111") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when "110" =>
					if not (result = "00000000") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when others =>
					if not (result = "00000011") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
			end case;
			--
			wait for 200 ns;
			src0 <= "00000001"; --  src0
 			src1 <= "11111110"; -- -src1
			
			--
			case ctrl is
				when "000"|"001"|"010"|"011" =>
					if not (result = "00000010") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when "100" =>
					if not (result = "11111111") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when "101" =>
					if not (result = "00000011") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when "110" =>
					if not (result = "00000000") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when others =>
					if not (result = "11111111") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
			end case;
			--
			
			wait for 200 ns;
			src0 <= "11111111"; -- -src0
			src1 <= "00000010"; --  src1 
			
			--
			case ctrl is
				when "000"|"001"|"010"|"011" =>
					if not (result = "00000000") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when "100" =>
					if not (result = "00000001") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when "101" =>
					if not (result = "11111101") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when "110" =>
					if not (result = "00000010") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when others =>
					if not (result = "11111111") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
			end case;
			--
			
			wait for 200 ns;
			src0 <= "11111111"; -- -src0
			src1 <= "11111110"; -- -src1
			
			--
			case ctrl is
				when "000"|"001"|"010"|"011" =>
					if not (result = "00000000") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when "100" =>
					if not (result = "11111101") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when "101" =>
					if not (result = "00000001") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when "110" =>
					if not (result = "11111110") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
				when others =>
					if not (result = "11111111") then
					assert true
						report"Unexpected Value"
						severity note;
					end if;
			end case;
			--
		
			wait for 200 ns;
	
			ctrl <= std_logic_vector(unsigned(ctrl)+1);
			
		end loop;

      assert false
         report "Simulation Completed"
         severity failure;		
   end process;
  --  Test Bench Statements
end behavior_tb;
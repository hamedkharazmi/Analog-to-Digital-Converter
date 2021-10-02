library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
----------------------------------------
entity output_TestBench is
end entity output_TestBench;
----------------------------------------
architecture TestBench of output_TestBench is 
signal S_clk  : std_logic := '1';
signal S_ld   : std_logic := '1';
signal S_Din  : std_logic_vector(7 downto 0) := "00000000";
signal S_Dout : std_logic_vector(7 downto 0);
begin
	output1: entity work.output(behav_output) 
	                generic map(8)
	                port map(S_clk, S_ld, S_Din, S_Dout);
	process is
	begin
	   S_clk <= not S_clk;
	   wait for 10 ns;
	   if(now >= 500ns) then wait;
	   end if;
   end process;
	
	process is
      variable seed1, seed2  : positive;
      variable rand , rand2  : real;
   begin
      for i in S_Din'range loop
          uniform(seed1, seed2, rand);
          uniform(seed2, seed1, rand2);
          if rand > 0.5 then
             S_Din(i) <= '1';
          else
             S_Din(i) <= '0';
          end if;     
       end loop;
       if rand2 > 0.5 then
          S_ld <= '1';
       else
          S_ld <= '0';
       end if;
       wait for 10 ns;
       if(now = 500 ns) then wait;
	    end if;
    end process;
end architecture TestBench;
----------------------------------------
	

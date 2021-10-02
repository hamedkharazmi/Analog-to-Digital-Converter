library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
----------------------------------------
entity ADC_TestBench is
end entity ADC_TestBench;
----------------------------------------
architecture TestBench of ADC_TestBench is 
signal S_Vin   : real;
signal S_clk   : std_logic := '1';
signal S_start : std_logic;
signal S_Done  : std_logic;
signal S_Dout  : std_logic_vector(7 downto 0);
begin
	ADC1: entity work.ADC(behav_ADC) 
	             generic map(8, 5.0)
	             port map(S_Vin, S_clk, S_start, S_Done, S_Dout);
   process is
	begin
	   S_clk <= not S_clk;
	   wait for 10 ns;
	   if(now >= 500ns) then wait;
	   end if;
   end process;

	process is
   variable seed1, seed2  : positive;
   variable rand, rand2   : real; 
   variable range_of_rand : real := 5.0;
   begin
      uniform(seed1, seed2, rand);
      uniform(seed2, seed1, rand2);
      S_Vin <= rand  * range_of_rand;
      
      if rand2 > 0.5 then
          S_start <= '1';
      else
          S_start <= '0';
      end if;
      if(now = 500 ns) then wait;
	   end if;
	   wait for 10 ns;
   end process;
end architecture TestBench;
----------------------------------------
	

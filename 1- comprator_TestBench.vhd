library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.math_real.all;
----------------------------------------
entity comprator_TestBench is
end entity comprator_TestBench;
----------------------------------------
architecture TestBench of comprator_TestBench is 
signal S_DACin  : real := 0.2;
signal S_Vin    : real := 0.5;
signal S_GT     : std_logic;
begin
    comp1: entity work.comprator(behav_comprator)
	               port map(S_DACin, S_Vin, S_GT);
    process is
       variable seed1, seed2  : positive;
       variable rand, rand2   : real; 
       variable range_of_rand : real := 5.0;
    begin
       uniform(seed1, seed2, rand);
       uniform(seed2, seed1, rand2);
       S_DACin <= rand  * range_of_rand;
       S_Vin   <= rand2 * range_of_rand;
       wait for 10 ns;
       if(now = 500 ns) then wait;
	    end if;
    end process;
end architecture TestBench;
----------------------------------------
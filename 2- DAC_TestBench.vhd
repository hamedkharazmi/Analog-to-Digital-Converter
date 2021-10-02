library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
----------------------------------------
entity DAC_TestBench is
end entity DAC_TestBench;
----------------------------------------
architecture TestBench of DAC_TestBench is
signal S_DIGITAL : std_logic_vector(7 downto 0) := "00000000";
signal S_ANALOG  : real;
begin
    DAC1: entity work.DAC(behav_DAC)
                 generic map(8, 5.0)
	              port map(S_DIGITAL, S_ANALOG);
    process is
       variable seed1, seed2  : positive;
       variable rand          : real;
    begin
       for i in S_DIGITAL'range loop
          uniform(seed1, seed2, rand);
          if rand > 0.5 then
             S_DIGITAL(i) <= '1';
          else
             S_DIGITAL(i) <= '0';
          end if;     
       end loop;
       wait for 10 ns;
       if(now = 500 ns) then wait;
	    end if;
    end process;
end architecture TestBench;
----------------------------------------
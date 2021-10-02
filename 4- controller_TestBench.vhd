library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
----------------------------------------
entity controller_TestBench is
end entity controller_TestBench;
----------------------------------------
architecture TestBench of controller_TestBench is 
signal S_start : std_logic := '1';
signal S_clk   : std_logic := '1';
signal S_GT    : std_logic := '1';
signal S_ld    : std_logic;
signal S_done  : std_logic;
signal S_Dout  : std_logic_vector(7 downto 0);
begin
	controller1: entity work.controller(behav_controller)
	                    generic map(8)
	                    port map(S_start, S_GT, S_clk, S_ld, S_Done, S_Dout);
   process is
	begin
	   S_clk <= not S_clk;
	   wait for 5 ns;
	   if(now >= 200ns) then wait;
	   end if;
   end process;
   process is
	begin
	   S_start <= '1';
	   S_GT    <= '1';
	   wait for 5 ns;
	   S_GT    <= '0';
	   wait for 5 ns;
	   S_GT    <= '1';
	   wait for 5 ns;
	   S_start <= '0';
	   S_GT    <= '1';
	   wait for 5 ns;
	   S_GT    <= '1';
	   wait for 5 ns;
	   S_start <= '1';
	   S_GT    <= '1';
	   wait for 5 ns;
	   S_GT    <= '1';
	   wait for 5 ns;
	   S_start <= '1';
	   S_GT    <= '0';
	   wait for 5 ns;
	   S_GT    <= '0';
	   wait for 5 ns;
	   S_GT    <= '0';
	   wait for 5 ns;
	   S_start <= '1';
	   S_GT    <= '1';
	   wait for 5 ns;
	   S_start <= '0';
	   S_GT    <= '1';
	   wait for 5 ns;
	   S_start <= '1';
	   S_GT    <= '1';
	   wait for 5 ns;
	   if(now >= 200ns) then wait;
	   end if;
  end process;
end architecture TestBench;
----------------------------------------   
library IEEE;
use IEEE.std_logic_1164.all;
----------------------------------------
entity controller is
	generic (n  : integer :=8 );
	port(	start : in  std_logic;
	      GT    : in  std_logic;
	      clk   : in  std_logic;
	      ld    : out std_logic;
	      Done  : out std_logic;
	      Dout  : out std_logic_vector(n-1 downto 0) );
end entity controller;
----------------------------------------
architecture behav_controller of controller is
signal ST : std_logic := '1';
begin
	process is
	begin
		wait on start;
		if (start = '1' and ST = '1') then
			for i in n-1 downto 0 loop
				Dout(i) <= '1';
				wait on clk;
				if (GT = '1') then
					Dout(i) <= '0';
				else
					Dout(i) <= '1';
				end if;
			end loop;
			Done <= '1';
			ld   <= '1';
			ST   <= '0';
		elsif (start = '0') then
			Done <= '0';
			ld   <= '0';
			ST   <= '1';
			for i in n-1 downto 0 loop
				Dout(i) <= '0';
			end loop;
		end if;
	end process;
end architecture behav_controller;
----------------------------------------
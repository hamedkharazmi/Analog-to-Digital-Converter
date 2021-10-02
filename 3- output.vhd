library IEEE;
use IEEE.std_logic_1164.all;
----------------------------------------
entity output is
	generic (n     : integer :=8 );
	port( clk, ld  : in   std_logic;
	      Din      : in   std_logic_vector(n-1 downto 0);
	      Dout     : out  std_logic_vector(n-1 downto 0) );
end entity output;
----------------------------------------
architecture behav_output of output is 
begin
   process (clk) is
   begin
	   if(clk'EVENT and clk = '1') then
         if (ld = '1') then
		      Dout <= Din;
		   end if;	
	   end if;
   end process;
end architecture behav_output;
----------------------------------------
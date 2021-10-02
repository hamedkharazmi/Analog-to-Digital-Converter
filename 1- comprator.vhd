library IEEE;
use IEEE.std_logic_1164.all;
----------------------------------------
entity comprator is 
  port (DACin, Vin : in  real;
        GT         : out std_logic );
end entity comprator;
----------------------------------------
architecture behav_comprator of comprator is 
begin
   comp_process: process (DACin, Vin)  
   begin
	   if DACin > Vin then
		   GT <= '1';
	   else	
	      GT <= '0';
	   end if;
   end process;
end architecture behav_comprator;
----------------------------------------

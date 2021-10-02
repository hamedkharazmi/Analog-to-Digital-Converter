library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
----------------------------------------
entity DAC is
	generic (n    : integer := 8   ;
	         vref : real    := 5.0);
	port (DIGITAL : in  std_logic_vector (n-1 downto 0);
	      ANALOG  : out real );
end entity DAC;
----------------------------------------
architecture behav_DAC of DAC is 
begin
   ANALOG <= real(CONV_INTEGER(unsigned(DIGITAL))) * vref/real(2**n);
end architecture behav_DAC;
----------------------------------------
	

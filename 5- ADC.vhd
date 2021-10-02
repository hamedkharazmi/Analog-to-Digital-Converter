library IEEE;
use IEEE.std_logic_1164.all;
----------------------------------------
entity ADC is
   generic (n    : integer := 8   ;
	         Vref : real    := 5.0);
	port(	Vin     : in    real;
	      clk     : in    std_logic;
	      start   : in    std_logic;
	      Done    : out   std_logic;
	      Dout    : out   std_logic_vector(n-1 downto 0) );
end entity ADC;
----------------------------------------
architecture behav_ADC of ADC is 
signal DACin   : real;
signal GT      : std_logic;
signal DIGITAL : std_logic_vector(n-1 downto 0);
signal ld      : std_logic;
begin
	comprator1: entity work.comprator(behav_comprator)
	port map(DACin, Vin, GT);
	    
	controller1: entity work.controller(behav_controller)
	generic map(n)
	port map(start, GT, clk, ld, Done, DIGITAL);
	
	DAC1: entity work.DAC(behav_DAC)
	generic map (n, Vref)
	port map(DIGITAL, DACin);
	
	output1: entity work.output(behav_output) 
	generic map(n)
	port map(clk, ld, DIGITAL, Dout);
end architecture behav_ADC;
----------------------------------------
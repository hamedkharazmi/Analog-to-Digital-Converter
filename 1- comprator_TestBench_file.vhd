library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.math_real.all;
use std.textio.all;
use IEEE.std_logic_arith.all;
----------------------------------------
entity comprator_file is
end entity comprator_file;
----------------------------------------
architecture TestBench_file of comprator_file is 
signal S_DACin  : real := 0.0;
signal S_Vin    : real := 0.0;
signal S_GT     : std_logic;
begin
   comp1: entity work.comprator(behav_comprator)
	              port map(S_DACin, S_Vin, S_GT);
   process is
   variable line_var, line_var2 : line;
   file text_var, text_var2 : text;
   variable num, num2  : real;
   variable G : integer;
   begin
      file_open(text_var,"files/comprator_file_input.txt", read_mode);
      file_open(text_var2,"files/comprator_file_output.txt", write_mode);
      while not endfile (text_var) loop
         readline(text_var, line_var);
         read(line_var, num);
         S_DACin <= num;
         read(line_var, num2);
         S_Vin   <= num2;
         report "DACin: " & real'image(S_DACin) & " Vin: " & real'image(S_Vin) & " GT: " & std_logic'image(S_GT);
         G := CONV_INTEGER(S_GT);
         write(line_var2, G); 
         writeline(text_var2, line_var2);
         wait for 5ns;
      end loop; 
      file_close(text_var);
      file_close(text_var2);
      wait;    
   end process;
end architecture TestBench_file;
----------------------------------------
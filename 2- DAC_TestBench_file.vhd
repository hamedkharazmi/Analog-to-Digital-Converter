library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use IEEE.std_logic_arith.all;
use std.textio.all;
----------------------------------------
entity DAC_file is
end entity DAC_file;
----------------------------------------
architecture TestBench_file of DAC_file is
signal S_DIGITAL : std_logic_vector(7 downto 0) := "00000000";
signal S_ANALOG  : real;
begin
   DAC1: entity work.DAC(behav_DAC)
                generic map(8, 5.0)
	             port map(S_DIGITAL, S_ANALOG);
   process is
   variable line_var, line_var2 : line;
   file text_var, text_var2 : text;
   variable inp  : integer;
   variable outp : real;
   begin
      file_open(text_var,"files/DAC_file_input.txt", read_mode);
      file_open(text_var2,"files/DAC_file_output.txt", write_mode);
      while not endfile (text_var) loop
         readline(text_var, line_var);
         read(line_var, inp);
         S_DIGITAL <= CONV_STD_LOGIC_VECTOR(inp,8);
         report "DIGITAL: " & integer'image(inp) & " ANALOG: " & real'image(S_ANALOG);
         outp := S_ANALOG;
         write(line_var2, outp); 
         writeline(text_var2, line_var2);
         wait for 5ns;
      end loop; 
      file_close(text_var);
      file_close(text_var2);
      wait;    
   end process;
end architecture TestBench_file;
----------------------------------------
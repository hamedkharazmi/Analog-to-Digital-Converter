library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use IEEE.std_logic_arith.all;
use std.textio.all;
----------------------------------------
entity ADC_file is
end entity ADC_file;
----------------------------------------
architecture TestBench_file of ADC_file is 
signal S_Vin   : real := 0.0;
signal S_clk   : std_logic := '1';
signal S_start : std_logic := '1';
signal S_Done  : std_logic;
signal S_Dout  : std_logic_vector(7 downto 0);
begin
   ADC1: entity work.ADC(behav_ADC) 
	             generic map(8, 5.0)
	             port map(S_Vin, S_clk, S_start, S_Done, S_Dout);
   process is
   variable line_var, line_var2 : line;
   file text_var, text_var2  : text;
   variable num : real;
   variable num2, num3  : integer;
   variable outp : integer;
   begin
      file_open(text_var, "files/ADC_file_input.txt", read_mode);
      file_open(text_var2,"files/ADC_file_output.txt", write_mode);
      while not endfile (text_var) loop
         readline(text_var, line_var);
         read(line_var, num);
         S_Vin <= num;
         read(line_var, num2);
         if (num2 = 1) then
            S_clk <= '1';
         elsif (num2 = 0) then
            S_clk <= '0';
         end if;
         read(line_var, num3);
         if (num3 = 1) then
            S_start <= '1';
         elsif (num3 = 0) then
            S_start <= '0';
         end if;
         report "Vin: " & real'image(num) & " clk: " & integer'image(num2) & " start: " & integer'image(num3) & " Done: " & std_logic'image(S_Done);
         for i in 7 downto 0 loop
            if (S_Dout(i) = '1') then
               outp := 1;
               write(line_var2, outp);
            elsif (S_Dout(i) = '0') then
               outp := 0;
               write(line_var2, outp);
               end if;
            end loop;
            writeline(text_var2, line_var2);
         wait for 5ns;
         end loop; 
      file_close(text_var);
      file_close(text_var2);
      wait;    
   end process;
end architecture TestBench_file;
----------------------------------------
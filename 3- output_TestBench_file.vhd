library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use IEEE.std_logic_arith.all;
use std.textio.all;
----------------------------------------
entity output_file is
end entity output_file;
----------------------------------------
architecture TestBench_file of output_file is 
signal S_clk  : std_logic := '0';
signal S_ld   : std_logic := '0';
signal S_Din  : std_logic_vector(7 downto 0) :="00000000";
signal S_Dout : std_logic_vector(7 downto 0);
type arr is array (0 to 1) of std_logic;
signal temp : arr;
begin
   output1: entity work.output(behav_output) 
	                generic map(8)
	                port map(S_clk, S_ld, S_Din, S_Dout);
	temp(0)<= '0';
   temp(1)<= '0';
   process is
   variable line_var, line_var2 : line;
   file text_var, text_var2  : text;
   variable num, num2, num3  : integer;
   variable outp : integer;
   begin
      file_open(text_var, "files/output_file_input.txt", read_mode);
      file_open(text_var2,"files/output_file_output.txt", write_mode);
      while not endfile (text_var) loop
         readline(text_var, line_var);
         read(line_var, num);
         if (num = 1) then
            S_clk <= '1';
            temp(0) <= temp(1);
            temp(1) <= '1';
         elsif (num = 0) then
            S_clk <= '0';
            temp(0) <= temp(1);
            temp(1) <= '0';
         end if;
         read(line_var, num2);
         if (num2 = 1) then
            S_ld <= '1';
         elsif (num2 = 0) then
            S_ld <= '0';
         end if;
         read(line_var, num3);
         S_Din  <= CONV_STD_LOGIC_VECTOR(num3,8);
         if (temp(0) = '0' and S_clk = '1') then
            if (S_ld = '1') then
               for i in 7 downto 0 loop
                  if (S_Din(i) = '1') then
                     outp := 1;
                     write(line_var2, outp);
                  elsif (S_Din(i) = '0') then
                     outp := 0;
                     write(line_var2, outp);
                  end if;
               end loop;
                  writeline(text_var2, line_var2);
                  report "clk: " & integer'image(num) & " ld: " & integer'image(num2) & " Din: " & integer'image(num3) & " Dout: " & integer'image(num3);
            end if;
         end if;
         wait for 5ns;
      end loop; 
      file_close(text_var);
      file_close(text_var2);
      wait;    
   end process;
end architecture TestBench_file;
----------------------------------------
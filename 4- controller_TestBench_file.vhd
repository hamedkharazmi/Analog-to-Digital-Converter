library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
use IEEE.std_logic_arith.all;
use std.textio.all;
----------------------------------------
entity controller_file is
end entity controller_file;
----------------------------------------
architecture TestBench_file of controller_file is 
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
   variable line_var : line;
   file text_var  : text;
   variable num, num2, num3  : integer;
   begin
      file_open(text_var, "files/controller_file_input.txt", read_mode);
      while not endfile (text_var) loop
         readline(text_var, line_var);
         read(line_var, num);
         if (num = 1) then
            S_start <= '1';
         elsif (num = 0) then
            S_start <= '0';
         end if;
         read(line_var, num2);
         if (num2 = 1) then
            S_clk <= '1';
         elsif (num2 = 0) then
            S_clk <= '0';
         end if;
         if (num3 = 1) then
            S_GT <= '1';
         elsif (num3 = 0) then
            S_GT <= '0';
         end if;
         report "start: " & integer'image(num) & " clk: " & integer'image(num2) & " GT: " & integer'image(num3) & " ld: " & std_logic'image(S_ld) & " Done: " & std_logic'image(S_Done);
         wait for 5ns; 
      end loop; 
      file_close(text_var);
      wait;    
   end process;
end architecture TestBench_file;
----------------------------------------   
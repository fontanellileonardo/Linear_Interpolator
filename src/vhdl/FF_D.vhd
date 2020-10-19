-- Flip Flop D
library IEEE;
use IEEE.std_logic_1164.all;  

entity FF_D is				   
	port (
		d	:	in std_ulogic;
		clk	: 	in std_ulogic;
		rst :	in std_ulogic;
		q	: 	out	std_ulogic
	);
end FF_D; 
			   
architecture beh of FF_D is
begin
	process(clk)
	begin
		if rising_edge(clk) then  
			if (rst = '1') then
				q <= '0';
			else
				q <= d;
			end if;
		end if;
	end process;
end beh;
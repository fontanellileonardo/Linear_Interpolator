-- Multiplexer 4to1
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
	generic (n : positive := 16); 
    port ( 
		sel	: in  std_ulogic_vector(1 downto 0);    
        x1	: in  std_ulogic_vector(n-1 downto 0);   
        x2	: in  std_ulogic_vector(n-1 downto 0);   
        x3 	: in  std_ulogic_vector(n-1 downto 0);   
        x4	: in  std_ulogic_vector(n-1 downto 0);   
       	y 	: out std_ulogic_vector(n-1 downto 0)
	);
		   
end MUX;

architecture beh of MUX is
begin
	main: process (sel) is
	begin
		case sel is
			when "00" => y <= x1;
			when "01" => y <= x2;
			when "10" => y <= x3;
			when "11" => y <= x4;
			when others => y <= "0000000000000000";
		end case;
	end process;	
end beh;
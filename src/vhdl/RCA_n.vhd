-- Ripple Carry Adder: it adds a and b std_ulogic_vectors of 16 bits giving the sum s
library IEEE;
use IEEE.std_logic_1164.all;   

entity RCA is
	generic (n : positive := 16); 
	port (
		a	:	in std_ulogic_vector(n-1 downto 0);
		b	:	in std_ulogic_vector(n-1 downto 0);
		cin	:	in std_ulogic;
		s	:	out std_ulogic_vector(n-1 downto 0);
		cout:	out std_ulogic
	);
end RCA;  

architecture beh of RCA is

begin
	combinational: process(a,b,cin)
	variable c: std_ulogic;
	begin
		c := cin;
		for i in 0 to n-1 loop
			s(i)<= a(i) xor b(i) xor c;
			c 	:= (a(i) and b(i)) or (a(i) and c) or (b(i) and c);
		end loop;
		cout <= c;
	end process combinational;
end beh;


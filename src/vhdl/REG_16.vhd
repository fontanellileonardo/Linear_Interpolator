--16 bit register
library IEEE;
use IEEE.std_logic_1164.all;  

-----------------------------
--   Entity declaration    --
-----------------------------

entity REG_16 is 
	generic (n : positive := 16); 
	port ( 
		d_reg	: in std_ulogic_vector(n-1 downto 0);
		rst		: in std_ulogic;
		clk		: in std_ulogic;
		q_reg	: out std_ulogic_vector(n-1 downto 0)
	);
end REG_16;		

-----------------------------
-- Architecture definition --
-----------------------------

architecture str of REG_16 is

	component FF_D
		port (
			d	: in std_ulogic; 
			clk	: in std_ulogic; 
			rst	: in std_ulogic; 
			q	: out std_ulogic
		);
	end component;
	
	signal q_sig	: std_ulogic_vector(n-1 downto 0);
	signal rst_sig	: std_ulogic;
	begin	
		gen_reg: 
   		for i in 0 to n-1 generate
      		ffd : FF_D port map(d_reg(i), clk, rst, q_sig(i));
   		end generate gen_reg;	  
		q_reg <= q_sig;
end str;
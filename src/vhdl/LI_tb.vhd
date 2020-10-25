-----------------------------
--        Testbench        --
-----------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity LI_tb is
end LI_tb;

-----------------------------
-- Architecture definition --
-----------------------------

architecture test of LI_tb is

	component LI is
		generic(n : positive := 16);
		port ( 											 							   
			input	:	in std_ulogic_vector(n-1 downto 0); 	  				  			   
			output	:	out std_ulogic_vector(n-1 downto 0);
			clk		:	in std_ulogic
		);					
	end component;

-----------------------------
--         Signals         --
-----------------------------
	constant clk_p  :  time     := 8 ns;  -- clock period
	
-- INPUT SIGNALS
	type array_of_input is array (0 to 15) of std_ulogic_vector(15 downto 0); 
	signal s_input	:	array_of_input := ("0000000000000111", "0000000000010011", "0000100000011010", "0000000010100001", "0000000010001100", "0000000000100000", "0000000000101001", "0000000001010111", "0000001001101011", "0000001100100100", "0000000011110001", "0000000000111111", "0000000001001010", "0000000001001110", "0000010101111111", "0000010101110101");
	signal s_in		:	std_ulogic_vector(15 downto 0) := "0000000000000111";
	signal s_clk	: 	std_ulogic := '0'; 
	signal i		:	integer := 0;  
	
-- OUTPUT SIGNAL
	signal s_out	:	std_ulogic_vector(15 downto 0);	
	
	begin
		 				  
		iDUT : LI port map(s_in, s_out, s_clk);	
		s_clk <= not s_clk after clk_p/2;
		i <= i+1 after 4*clk_p;							--input must change every 4 clock signals
		s_in <= s_input(i);			
		
end test;

-- Intermediate combinatorial net to calculate the four output values
library IEEE;				 
use ieee.numeric_std.all;
use IEEE.std_logic_1164.all;

entity RC is
	generic (n : positive := 16);
	port(
		input	:	in std_ulogic_vector(n-1 downto 0); 
		old_in	:	in std_ulogic_vector(n-1 downto 0);  
		out0	:	out std_ulogic_vector(n-1 downto 0);  
		out1	:	out std_ulogic_vector(n-1 downto 0);  
		out2	:	out std_ulogic_vector(n-1 downto 0);  
		out3	:	out std_ulogic_vector(n-1 downto 0)
	);
end RC;	  

architecture rtl of RC is

	-- COMPONENT DECLARATION
	component RCA is			 	-- RCA to sum signals
		port (
			a	:	in std_ulogic_vector(n-1 downto 0);
			b	:	in std_ulogic_vector(n-1 downto 0);
			cin	:	in std_ulogic;
			s	:	out std_ulogic_vector(n-1 downto 0);
			cout:	out std_ulogic
		);
	end component RCA;
	
	type array_of_string is array (0 to 3) of std_ulogic_vector(15 downto 0);	-- array of string type declaration
	
	signal out_array	:	array_of_string;	-- to save the outputs of RCAs
	signal yn1			:	array_of_string;
	signal yn2			:	array_of_string;
	
	-- signals to store shifted input
	signal i1sh2		:	std_ulogic_vector(15 downto 0);	 	-- first input shifted by one position (divided by two)
	signal i2sh2		:	std_ulogic_vector(15 downto 0);		-- second input shifted by one position
	signal i1sh4		:	std_ulogic_vector(15 downto 0);		-- first input shifted by two positions (divided by four)
	signal i2sh4		: 	std_ulogic_vector(15 downto 0);		-- second input shifted by two positions
	
	-- unuseful but necessary signals
	signal s_cout		:	std_ulogic_vector(3 downto 0);		
	signal s_cin, s_cout1, s_cout2	: 	std_ulogic := '0';
	
	begin
		
		main: process(input)
		begin
			-- in1 and in2 shifted (to divide per two)	 
			i1sh2(15) <= '0'; i1sh2(14 downto 0) <= input(15 downto 1);
			i2sh2(15) <= '0'; i2sh2(14 downto 0) <= old_in(15 downto 1);
			
			-- in1 and in2 double shifted (to divide per four)						   				   
			i1sh4(15) <= '0'; i1sh4(14) <= '0'; i1sh4(13 downto 0) <= input(15 downto 2);
			i2sh4(15) <= '0'; i2sh4(14) <= '0'; i2sh4(13 downto 0) <= old_in(15 downto 2); 
						  
			yn2(0) <= old_in;	-- yn2(0) must take the 'actual' old_in	
		end process; 
		
		-- u = 0
		yn1(0) <= "0000000000000000";    
							 
		-- u = 1/4
		yn1(1) <= i1sh4;
		SUM1 : RCA port map(i2sh4, i2sh2, s_cin, yn2(1), s_cout1);
			
		-- u = 2/4
		yn1(2) <= i1sh2;
		yn2(2) <= i2sh2;  
		
		-- u = 3/4 
		yn2(3) <= i2sh4;
		SUM2 : RCA port map(i1sh4, i1sh2, s_cin, yn1(3), s_cout2);
			
		-- four Ripple Carry Adders to generate the four output signals
		gen_RCA: 
		for i in 0 to 3 generate
			fin_sum : RCA port map(yn1(i), yn2(i), s_cin, out_array(i), s_cout(i));
		end generate gen_RCA;
		
		out0 <= out_array(0);
		out1 <= out_array(1);
		out2 <= out_array(2);
		out3 <= out_array(3);
	
end rtl;

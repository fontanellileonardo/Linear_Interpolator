-----------------------------
--   Linear Interpolator   --
-----------------------------
library IEEE;				 
use ieee.numeric_std.all;
use IEEE.std_logic_1164.all;

entity LI is
	generic (n : positive := 16);
	port(
		input	:	in std_ulogic_vector(n-1 downto 0); 
		output	:	out std_ulogic_vector(n-1 downto 0); 
		clk		:	in std_ulogic
	);
end LI;		 

architecture beh of LI is

    -----------------------------
    --  Component Declaration  --
    -----------------------------

    -- This register is the one that saves the previous input
	component REG_16 is 	
		port ( 
			d_reg	: in std_ulogic_vector(n-1 downto 0);
			rst 	: in std_ulogic;
			clk		: in std_ulogic;
			q_reg	: out std_ulogic_vector(n-1 downto 0)
		);
	end component REG_16;	
    
    -- Multiplexer that select the correct output
	component MUX is
		port(  
			sel	: in  std_ulogic_vector(1 downto 0);    
	        x1	: in  std_ulogic_vector(n-1 downto 0);   
	        x2	: in  std_ulogic_vector(n-1 downto 0);   
	        x3 	: in  std_ulogic_vector(n-1 downto 0);   
	        x4	: in  std_ulogic_vector(n-1 downto 0);   
	       	y 	: out std_ulogic_vector(n-1 downto 0)
		);
    end component MUX;
    
    -- Combinatorial net that calculates the outputs.
    -- The inputs are the the current point and the previous one.
	component RC is
	port(
		input	:	in std_ulogic_vector(n-1 downto 0); 
		old_in	:	in std_ulogic_vector(n-1 downto 0);
		out0	:	out std_ulogic_vector(n-1 downto 0);  
		out1	:	out std_ulogic_vector(n-1 downto 0);  
		out2	:	out std_ulogic_vector(n-1 downto 0);  
		out3	:	out std_ulogic_vector(n-1 downto 0)
	);
	end component RC;
    
    -- Declaration of the array of string type
	type array_of_string is array (0 to 3) of std_ulogic_vector(15 downto 0);	
	
    -----------------------------
    --         Signals         --
    -----------------------------
    
	signal old_input 	: 	std_ulogic_vector(15 downto 0); 					-- to store the previous input value
	signal sel_s		:	std_ulogic_vector(1 downto 0) := "11"; 				-- multiplexer selector
	signal rst			:	std_ulogic := '0';
	-- Output Signal - Save the 4 outputs
	signal out_array	:	array_of_string;
	
	begin  		 
		-- register to update old_input 
		reg: REG_16 port map(input, rst, clk, old_input);
		-- Calculates the output
		res: RC port map(input, old_input, out_array(0), out_array(1), out_array(2), out_array(3));

		COUNTER_P : process(clk)	-- process to count clocks
		begin																								   
			if(rising_edge(clk)) then 
				 case sel_s is
        			when "00" => sel_s <= "01";
			        when "01" => sel_s <= "10";
			        when "10" => sel_s <= "11";
			        when "11" => sel_s <= "00";	
					when others => sel_s <= "00";
				end case;
			end if;	  														
		end process; 
		
		-- multiplexer to select correct output
		choose: MUX port map(sel_s, out_array(0), out_array(1), out_array(2), out_array(3), output);  
		
end beh;

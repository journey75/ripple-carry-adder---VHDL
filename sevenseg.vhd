LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity sevenseg is
port( M: IN std_logic_vector(4 downto 0);
--clk: IN std_logic;
HEX0: OUT std_logic_vector(6 downto 0);
HEX1: OUT std_logic_vector(6 downto 0));
end sevenseg;
--Begin the architecture,
architecture seg of sevenseg is
begin
		
	--with M(3 downto 0) select
	--	HEX0 <= "1111110" when "0000",
	--		   "0110000" when "0001",
  	--		   "1101101" when "0010",
	--			"1111001" when "0011",
	--			"0110011" when "0100",
	--			"1011011" when "0101",
	--			"1011111" when "0110",
	--			"1110000" when "0111",
	--			"1111111" when "1000",
	--			"1111011" when "1001",
	--			"0000000" when others;1001100
												--0110011
	with M(3 downto 0) select
	HEX0 <= "1000000" when "0000",
			   "1111001" when "0001",
  			   "0100100" when "0010",
				"0110000" when "0011",
				"0011001" when "0100",
				"0010010" when "0101",
				"0000010" when "0110",
				"1111000" when "0111",
				"0000000" when "1000",
				"0010000" when "1001",
				"1111111" when others;
	
	with M(4) select
		HEX1 <= "1111001" when '1',
				"1111111" when others;
	
	
	
end seg;
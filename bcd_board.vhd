LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity bcd_board is
port(SW: in std_logic_vector(9 downto 0); 
LEDR: out std_logic_vector(9 downto 0);
HEX5: out std_logic_vector(6 downto 0);
HEX4: out std_logic_vector(6 downto 0);
HEX3: out std_logic_vector(6 downto 0);
HEX2: out std_logic_vector(6 downto 0);
HEX1: out std_logic_vector(6 downto 0);
HEX0: out std_logic_vector(6 downto 0));
end bcd_board;

--Begin the architecture,
architecture board of bcd_board is
-------------------------------------------------
component bcd_adder is
port( 
a: in std_logic_vector(3 downto 0);
b: in std_logic_vector(3 downto 0);
ci: in std_logic;
cout: out std_logic; --LED
sum: out std_logic_vector (3 downto 0);--LED
error: out std_logic; --LED
sg1: out std_logic_vector(6 downto 0);
sg2: out std_logic_vector(6 downto 0);
sg3: out std_logic_vector(6 downto 0);
sg4: out std_logic_vector(6 downto 0);
sg5: out std_logic_vector(6 downto 0);
sg6: out std_logic_vector(6 downto 0));
end component bcd_adder;
--------------------------------------------------
begin
	
	board_map: component bcd_adder
	port map(a => SW(7 downto 4),
	b => SW(3 downto 0),
	ci => SW(8),
	sum => LEDR(3 downto 0),
	cout => LEDR(4),
	error => LEDR(9),
	sg2 => HEX5,
	sg1 => HEX4,
	sg4 => HEX3,
	sg3 => HEX2,
	sg6 => HEX1,
	sg5 => HEX0);
	
end board;
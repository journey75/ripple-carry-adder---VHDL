LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity bcd_adder is
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
end bcd_adder;

--Begin the architecture,
architecture main of bcd_adder is

--signal c: std_logic_vector((width-2) downto 0);
 signal carry1: std_logic_vector(4 downto 0);
 signal carry2: std_logic_vector(4 downto 0);
 signal carry3: std_logic_vector(3 downto 0);
 signal carry4: std_logic;
 signal carry5: std_logic_vector(4 downto 0);
 --signal carry6: std_logic_vector(4 downto 0);
 signal sum_sig: std_logic_vector(4 downto 0);
-------------------------------------------------
component rip_adder
	generic(width:integer:=4);
	port(a,b: in std_logic_vector((width-1) downto 0);
		ci: in std_logic;
		so: out std_logic_vector((width-1) downto 0); 
		co: out std_logic);
end component rip_adder;

component bcdconverter
	port( V: IN std_logic_vector(4 downto 0);
	M: OUT std_logic_vector(4 downto 0));
end component bcdconverter;

component sevenseg
	port( M: IN std_logic_vector(4 downto 0);
	HEX0: OUT std_logic_vector(6 downto 0);
	HEX1: OUT std_logic_vector(6 downto 0));
end component sevenseg;

--------------------------------------------------
begin
	
	BCD1: component bcdconverter
	port map(V(3 downto 0) => a,
	V(4) => '0',
	M => carry1);
	
	BCD2: component bcdconverter
	port map(V(3 downto 0) => b,
	V(4) => '0',
	M => carry2);
	
	SG1_S: component sevenseg
	port map( M => carry1(4 downto 0),
	HEX0 => sg1,
	HEX1 => sg2);
	
	SG2_S: component sevenseg
	port map( M => carry2(4 downto 0),
	HEX0 => sg3,
	HEX1 => sg4);
	
	--this is the adder portion
	BCD_ADD: component rip_adder
	port map(a => a,
	b => b,
	ci => ci,
	so => carry3,
	co => carry4);
	---------------------------
	sum <= carry3; --sum intercepts so signal
	cout <= carry4; --cout intercepts co sigal
	
	sum_sig <= carry4 & carry3;
	error <= '1' when sum_sig > "10011" else
				'0';
	---------------------------
	BCD3: component bcdconverter
	port map(V => sum_sig(4 downto 0),
	M => carry5);
	
	SG3_S: component sevenseg
	port map( M => carry5(4 downto 0),
	HEX0 => sg5,
	HEX1 => sg6);
	
			
	
end main;
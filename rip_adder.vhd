LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity rip_adder is

generic(width:integer:=4);
port( 
a,b: in std_logic_vector((width-1) downto 0);
ci: in std_logic;
so: out std_logic_vector((width-1) downto 0); 
co: out std_logic);
end rip_adder;

--Begin the architecture,
architecture rip of rip_adder is

--signal c: std_logic_vector((width-2) downto 0);
signal c: signed((width-2) downto 0) := (others =>  '0');

component adder
	port(a,b,ci: in std_logic;
	s,co: out std_logic);
end component adder;


begin
	
	--go from the adder - > to the new part
	-- here is our first part-----------------
	adder_first: component adder
	port map(a => a(0),
	b => b(0),
	ci => ci,
	s => so(0),
	co => c(0));
	
	--here we take care of the middle portion and make it dynamic
	
	middle_part: for i in 1 to width-2 generate
			add: component adder
				port map(a => a(i),
				b => b(i),
				ci => c(i-1),
				s => so(i),
				co => c(i));
	end generate middle_part;
	
	--here is the last part-----------------
	adder_final: component adder
	port map(a => a(width-1),
	b => b(width-1),
	ci => c(width-2),
	s => so(width-1),
	co => co);
	
end rip;
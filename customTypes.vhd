package customTypes is 
	
	subtype ledtype is natural range 0 to 4;
	type ledarray is array (0 to 24) of ledtype; -- Game will have maximum of 25 items to remember
	
	type state is (easy, medium, hard, extreme, hell);
	type bool is (true, false);
	
end package;
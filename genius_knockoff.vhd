library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use work.customTypes.all;

entity genius_knockoff is
	port(
		clk, rst : in std_logic;
		btn0, btn1, btn2, btn3 : in std_logic; -- Game buttons
		led0, led1, led2, led3 : out std_logic -- Visual representation for players
	);
end entity;

architecture game of genius_knockoff is
	
	--Signals for gameplay
	signal gameleds: ledarray := (1, 3, 4, 2, 3, 1, 4, 2, 3, 1, 4, 3, 2, 4, 1, 4, 3, 2, 2, 4, 3, 3, 4, 1, 2);
	signal difficulty : state := easy;
	signal usermode : bool := false;
	signal wrong_active : bool := false;
	signal led_on : bool := false;
	
	--Dependent on difficulty
	impure function array_range return natural is
	begin
		case difficulty is
			when easy =>
				return 5;
			when medium =>
				return 10;
			when hard =>
				return 15;
			when extreme =>
				return 20;
			when hell =>
				return 25;
		end case;
	end function;
	
	--Array return
	impure function array_value(i : integer) return natural is
		variable returnable : natural; 
	begin
		returnable := gameleds(i);
		return returnable;
	end function;
	
	--Procedure to increment difficulty
	procedure change_difficulty is
	begin
	
		case difficulty is
			when easy =>
				difficulty <= medium;
			when medium =>
				difficulty <= hard;
			when hard =>
				difficulty <= extreme;
			when extreme =>
				difficulty <= hell;
			when hell =>
				difficulty <= easy;
		end case;
		
	end procedure;
	
	-- Turn on all leds
	procedure all_leds_on is
	begin
	
		led0 <= '1';
		led1 <= '1';
		led2 <= '1';
		led3 <= '1';
		led_on <= true;
		
	end procedure;
	
	-- Turn off all leds
	procedure all_leds_off is
	begin
		
		led0 <= '0';
		led1 <= '0';
		led2 <= '0';
		led3 <= '0';
		led_on <= false;
		
	end procedure;
	
	--Procedure to set wrong choice in game
	procedure wrong_choice is
	begin
		
		all_leds_on;
		wrong_active <= true;
		
	end procedure;
		
begin
	process(clk, rst)
		variable i : integer := 0;
		variable size : integer := 5;
		
	begin
	
		if rst = '1' then
			all_leds_off;
			difficulty <= easy;
			usermode <= false;
			wrong_active <= false;
			led_on <= false;
		elsif clk'event and clk = '1' then
		
			-- Section for Led presentation
			if usermode = false then
			
				-- Clear user inputs
				if led_on = true then -- Make sure no Led came on from User Input
					all_leds_off;
				end if;
				if wrong_active = true then
					wrong_active <= false;
				end if;
				
				size := array_range;
				if i < size then -- Show the led while variable for control lower then size
					case gameleds(i) is -- Run the array reading expected led
						when 1	=> 
							led0 <= '1';
							led1 <= '0';
							led2 <= '0';
							led3 <= '0';
						when 2	=>
							led0 <= '0';
							led1 <= '1';
							led2 <= '0';
							led3 <= '0';
						when 3	=>
							led0 <= '0';
							led1 <= '0';
							led2 <= '1';
							led3 <= '0';
						when 4	=>
							led0 <= '0';
							led1 <= '0';
							led2 <= '0';
							led3 <= '1';
						when others =>
							led0 <= '0';
							led1 <= '0';
							led2 <= '0';
							led3 <= '0';
					end case;
					i := i + 1; -- To keep loop running
				else -- Reset variable for control, and set gamemode to user input
				
					all_leds_off;
					
					i := 0;
					usermode <= true;
				end if;
				
			-- Section for User input
			else
				size := array_range;
				
				if led_on = true then -- Check to keep leds off after each round
					all_leds_off;
				end if;
						
				if i < size then -- While still not on size, play the game
					if wrong_active = true then
						
						i := i + 1; -- To keep loop running
						
					elsif btn0 = '1' then
					
						if array_value(i) = 1 then -- Correct Button Pressed
							led0 <= '1';
							led_on <= true;
						else -- Wrong Button Pressed
							wrong_choice;
						end if;
						
						i := i + 1; -- To keep loop running
						
					elsif btn1 = '1' then
					
						if array_value(i) = 2 then -- Correct Button Pressed
							led1 <= '1';
							led_on <= true;
						else -- Wrong Button Pressed
							wrong_choice;
						end if;
						
						i := i + 1; -- To keep loop running
						
					elsif btn2 = '1' then
					
						if array_value(i) = 3 then -- Correct Button Pressed
							led2 <= '1';
							led_on <= true;
						else -- Wrong Button Pressed
							wrong_choice;
						end if;
						
						i := i + 1; -- To keep loop running
						
					elsif btn3 = '1' then
					
						if array_value(i) = 4 then -- Correct Button Pressed
							led3 <= '1';
							led_on <= true;
						else -- Wrong Button Pressed
							wrong_choice;
						end if;
						
						i := i + 1; -- To keep loop running
						
					end if;
					
				else -- Reset variable for control and gamemode
					i := 0;
					usermode <= false; -- Reset game to LedMode
					
					if wrong_active = false then -- Next Round Difficulty dependent on wrong pressed
						change_difficulty; -- Increment Difficulty
					else
						difficulty <= easy;
					end if;
					
				end if;
			end if;
		end if;
		
	end process;
	
end game;

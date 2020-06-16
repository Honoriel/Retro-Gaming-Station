----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/11/2020 10:42:08 PM
-- Design Name: 
-- Module Name: ArrowGame - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Defined_Values.all;

entity ArrowGame is
  Port (clock, start, rhythm, Game_On, move: in std_logic;
        Up_button_Pressed, Down_button_Pressed, Left_Button_Pressed, Right_Button_Pressed: in std_logic;
        selection_input: in std_logic_vector(1 downto 0);
        Up_xPos: out integer range (H_Total - H_Display + 10) to (H_Total - 30);
        Right_xPos: out integer range (H_Total - H_Display +10) to (H_Total - 30);
        Left_xPos: out integer range (H_Total - H_Display + 10) to (H_Total - 30);
        Down_xPos: out integer range (H_Total - H_Display + 10) to (H_Total - 30);
        newGame, play, PlayerWon, PlayerLost, on_combo : out std_logic;
        success: out std_logic_vector(1 downto 0);
        point: out integer range 0 to 151);
end ArrowGame;

architecture Behavioral of ArrowGame is

signal UP_currentX: integer range H_Total - H_Display + 10 to H_Total - 50:= Arrows_INIT_X;
signal RIGHT_currentX: integer range H_Total - H_Display +10 to H_Total - 50:= Arrows_INIT_X;
signal LEFT_currentX: integer range H_Total - H_Display + 10 to H_Total - 50:= Arrows_INIT_X;
signal DOWN_currentX: integer range H_Total - H_Display + 10 to H_Total - 50:= Arrows_INIT_X;

signal Selected_tab:std_logic_vector (205 downto 0);
constant note_tab1: std_logic_vector (205 downto 0) := "00000010100010010100011000011001110110001010011001111000101110001011010010110100001110010000010000100010001010001001010001100001100111011000101001100111100010111000101101001011010000111001000001000010001000";
constant note_tab2: std_logic_vector (205 downto 0) := "00000010010101010100101010100101010100100101001010010101010010101010100000100100100101001010010100101111001001010010101001010010010100100010010010010001001000100100100100100100010010010100100100100100100100";
constant note_tab3: std_logic_vector (205 downto 0) := "00000001010100111110001000100100010010101010100101010100101010100100101001010010101010010101010100000100100100101001100010010010100100100110010010010011100101010101010101011100100100101001010110101110010111";
constant note_tab4: std_logic_vector (205 downto 0) := "00000010100101011001010010010010010101011011010110101100110010100100100110010010010011100101010101010101011101010010111010010100100100101110101011010010111101010111101001011110101010001001010101001010101010";  

signal comboChecker: integer range 0 to 10 := 0;
signal currentPoint: integer range 0 to 151 :=0;
signal currentNote: integer range 0 to 210 :=0;
signal playingCurrent: std_logic:= '0';
signal UP_Button_pressed_enough, LEFT_Button_pressed_enough, RIGHT_Button_pressed_enough, DOWN_Button_pressed_enough: boolean := false;
signal UP_Buttoncheck, LEFT_Buttoncheck, RIGHT_Buttoncheck, DOWN_Buttoncheck: integer;
signal resetCurrent: std_logic:= '1';
signal Game_END, WIN, LOSE: std_logic:= '0';

begin








process(rhythm, move, clock)
variable UP_Note_Flag,UP_FLAG_CHECK, RIGHT_Note_Flag,RIGHT_FLAG_CHECK, LEFT_Note_Flag,LEFT_FLAG_CHECK, DOWN_Note_Flag,DOWN_FLAG_CHECK, Up_Note_Correct, Left_Note_Correct, Right_Note_Correct, Down_Note_Correct, Combo, ONE_NOTE, ONE_NOTEwCOMBO, TWO_NOTE, TWO_NOTEwCOMBO, THREE_NOTE, THREE_NOTEwCOMBO, FOUR_NOTE, FOUR_NOTEwCOMBO: boolean := false;

   begin
if rising_edge(clock) then   
if Up_button_Pressed ='1' then
    UP_Buttoncheck <= UP_Buttoncheck+1;
else
    UP_Buttoncheck <= 0; 
    end if;

if LEFT_button_Pressed ='1' then
    LEFT_Buttoncheck <= LEFT_Buttoncheck+1;
else
    LEFT_Buttoncheck <= 0; 
    end if;

if RIGHT_button_Pressed ='1' then
    RIGHT_Buttoncheck <= RIGHT_Buttoncheck+1;
else
    RIGHT_Buttoncheck <= 0; 
    end if;

if DOWN_button_Pressed ='1' then
    DOWN_Buttoncheck <= DOWN_Buttoncheck+1;
else
    DOWN_Buttoncheck <= 0; 
    end if;
end if;
--Check of Correct Play Combinations
FOUR_NOTEwCOMBO := Up_Note_Correct and Left_Note_Correct and RIGHT_Note_Correct and DOWN_Note_Correct and Combo;
FOUR_NOTE  := Up_Note_Correct and Left_Note_Correct and RIGHT_Note_Correct and DOWN_Note_Correct;
THREE_NOTEwCOMBO := ((Up_Note_Correct and Left_Note_Correct and RIGHT_Note_Correct) or (Left_Note_Correct and RIGHT_Note_Correct and DOWN_Note_Correct) or (Up_Note_Correct and RIGHT_Note_Correct and DOWN_Note_Correct) or (Up_Note_Correct and Left_Note_Correct and DOWN_Note_Correct)) and COMBO;
THREE_NOTE := ((Up_Note_Correct and Left_Note_Correct and RIGHT_Note_Correct) or (Left_Note_Correct and RIGHT_Note_Correct and DOWN_Note_Correct) or (Up_Note_Correct and RIGHT_Note_Correct and DOWN_Note_Correct) or (Up_Note_Correct and Left_Note_Correct and DOWN_Note_Correct)) ;
TWO_NOTEwCOMBO := ((Up_Note_Correct and Left_Note_Correct) or (Up_Note_Correct and RIGHT_Note_Correct) or (Up_Note_Correct and DOWN_Note_Correct) or (LEFT_Note_Correct and RIGHT_Note_Correct)or (LEFT_Note_Correct and DOWN_Note_Correct)or (RIGHT_Note_Correct and DOWN_Note_Correct)) and COMBO;
TWO_NOTE :=((Up_Note_Correct and Left_Note_Correct) or (Up_Note_Correct and RIGHT_Note_Correct) or (Up_Note_Correct and DOWN_Note_Correct) or (LEFT_Note_Correct and RIGHT_Note_Correct)or (LEFT_Note_Correct and DOWN_Note_Correct)or (RIGHT_Note_Correct and DOWN_Note_Correct)) ; 
ONE_NOTEwCOMBO := (Up_Note_Correct or Left_Note_Correct or RIGHT_Note_Correct or DOWN_Note_Correct) and COMBO;
ONE_NOTE := (Up_Note_Correct or Left_Note_Correct or RIGHT_Note_Correct or DOWN_Note_Correct) ;

COMBO := combochecker > 4;
--Check of Correct Input at the right moment
Up_Note_Correct := (UP_CurrentX < H_Total - H_Display + 59) and (UP_CurrentX > H_Total - H_Display + 33)and UP_ButtonCheck > 0  and UP_ButtonCheck < 3500000;            
Left_Note_Correct := (LEFT_CurrentX < H_Total - H_Display + 59) and (LEFT_CurrentX > H_Total - H_Display + 33)and LEFT_ButtonCheck > 0  and LEFT_ButtonCheck<3500000;    
RIGHT_Note_Correct := (RIGHT_CurrentX < H_Total - H_Display + 59) and (RIGHT_CurrentX > H_Total - H_Display + 33)and RIGHT_ButtonCheck > 0 and RIGHT_ButtonCheck <3500000;
DOWN_Note_Correct := (DOWN_CurrentX < H_Total - H_Display + 59) and (DOWN_CurrentX > H_Total - H_Display + 33)and Down_ButtonCheck >0 and Down_ButtonCheck<3500000;

UP_FLAG_CHECK:= UP_CURRENTX < ARROWS_INIT_X ;
UP_NOTE_FLAG := Selected_tab(CurrentNote)='1' or UP_FLAG_CHECK;     

LEFT_FLAG_CHECK:= LEFT_CURRENTX < ARROWS_INIT_X ;
LEFT_NOTE_FLAG := Selected_tab(CurrentNote+1)='1' or LEFT_FLAG_CHECK;     

RIGHT_FLAG_CHECK:= RIGHT_CURRENTX < ARROWS_INIT_X ;
RIGHT_NOTE_FLAG := Selected_tab(CurrentNote+2)='1' or RIGHT_FLAG_CHECK;     

DOWN_FLAG_CHECK:= DOWN_CURRENTX < ARROWS_INIT_X ;
DOWN_NOTE_FLAG := Selected_tab(CurrentNote+3)='1' or DOWN_FLAG_CHECK;   

if playingcurrent = '1' then
                
                if FOUR_NOTEwCOMBO then
                    currentPoint <= currentPoint + 8;
                    combochecker <= combochecker +4;
                elsif FOUR_NOTE then
                    currentPoint <= currentPoint + 4;
                    combochecker <= combochecker +4;
                elsif THREE_NOTEwCOMBO then
                    currentPoint <= currentPoint + 6;
                    combochecker <= combochecker +3;
                elsif THREE_NOTE then
                    currentPoint <= currentPoint + 3;
                    combochecker <= combochecker +3;
                    
                elsif TWO_NOTEwCOMBO then
                    currentPoint <= currentPoint + 4;
                    combochecker <= combochecker +2;
                elsif TWO_NOTE then
                    currentPoint <= currentPoint + 2;
                    combochecker <= combochecker +2;
                elsif ONE_NOTEwCOMBO then
                    currentPoint <= currentPoint + 2;
                    combochecker <= combochecker +1;
                elsif ONE_NOTE then
                    currentPoint <= currentPoint + 1;
                    combochecker <= combochecker +1;
                end if;
                end if;
                     
       
       if COMBO then
        on_combo <= '1';
       else
        on_combo <= '0';
       end if; 
           

       if rising_edge(rhythm) then 
           with selection_input select Selected_tab <=
                    note_tab1    when "00",
                    note_tab2    when "01",
                    note_tab3    when "10",
                    note_tab4    when others;
                    
                    
                    
           if playingCurrent = '1' then
                CurrentNote<= CurrentNote +4;
           else currentNote <= 0;
           end if;
       end if;
       
       if rising_edge(move) then 
       
        if game_on ='1' then
            --Reset Logic
           if WIN = '1' or LOSE ='1' then
               UP_currentX <= Arrows_INIT_X;
               RIGHT_currentX <= Arrows_INIT_X;
               LEFT_currentX <= Arrows_INIT_X;
               DOWN_currentX <= Arrows_INIT_X;
               playingCurrent <= '0';
               resetCurrent <= '1';
           elsif start = '1' and playingCurrent ='0' then
               playingCurrent <= '1';
               CurrentPoint <= 0;
               Combochecker <= 0;
               resetCurrent <= '0';
           end if;
           if currentPoint >= 60 and currentNote > 196 and not(UP_Note_Flag or LEFT_Note_Flag or RIGHT_Note_Flag or DOWN_Note_Flag)then
                    WIN <= '1';
           elsif start ='1'then 
                    WIN <= '0';
           end if;
           
           if currentNOTE > 196 and currentPoint < 60 and not(UP_Note_Flag or LEFT_Note_Flag or RIGHT_Note_Flag or DOWN_Note_Flag)then
                    LOSE <= '1';
           elsif start ='1' then
                     LOSE <='0';
           end if;
  
           if playingcurrent = '1' then
                
                
                if UP_Note_Flag then
                    if Up_Note_Correct  then
                        UP_CURRENTX <= Arrows_INIT_X;
                    elsif(UP_CurrentX < H_Total - H_Display + 15)  then
                        UP_CURRENTX <= Arrows_INIT_X;
                        combochecker <= 0;
                    else
                        UP_CURRENTX <= UP_CURRENTX -1 ;                        
                    end if;
                end if;
                
                
                
                if LEFT_Note_Flag then
                    
                    if LEFT_Note_Correct   then
                        LEFT_CURRENTX <= Arrows_INIT_X;
                    
                    elsif (LEFT_CurrentX < H_Total - H_Display + 15) then
                        LEFT_CURRENTX <= Arrows_INIT_X;
                        combochecker <= 0;
                    else
                        LEFT_CURRENTX <= LEFT_CURRENTX -1 ;                        
                    end if;
                end if;
                
                
                
                if RIGHT_Note_Flag then
                    
                    if RIGHT_Note_Correct   then
                        RIGHT_CURRENTX <= Arrows_INIT_X;
                        
                    elsif (RIGHT_CurrentX < H_Total - H_Display + 15)  then
                        RIGHT_CURRENTX <= Arrows_INIT_X;
                        combochecker <= 0;
                    else
                        RIGHT_CURRENTX <= RIGHT_CURRENTX -1 ;                        
                    end if;
                end if;
                
                if DOWN_Note_Flag then
                
                    if DOWN_Note_Correct then
                        DOWN_CURRENTX <= Arrows_INIT_X;
                    
                    elsif (DOWN_CurrentX < H_Total - H_Display + 15)  then
                        DOWN_CURRENTX <= Arrows_INIT_X;
                        combochecker <= 0;
                    else
                        DOWN_CURRENTX <= DOWN_CURRENTX -1 ;                        
                    end if;
                end if;
                
           
           
           
       end if;
       else 
               UP_currentX <= Arrows_INIT_X;
               RIGHT_currentX <= Arrows_INIT_X;
               LEFT_currentX <= Arrows_INIT_X;
               DOWN_currentX <= Arrows_INIT_X;
               playingCurrent <= '0';
               resetCurrent <= '1'; 
               Lose <= '0';
               WIN <= '0';
       end if;    
       end if;
   end process;
   
   success <="00" when  (CurrentPoint < 60) else                             
             "01" when ((CurrentPoint >= 60) and (CurrentPoint < 80)) else      
             "10" when ((CurrentPoint >= 80) and (CurrentPoint < 100)) else     
             "11" ;                                             
   
   Up_xPos<= UP_currentX;
   Right_xPos <= RIGHT_currentX;
   Left_xPos<= LEFT_currentX;
   Down_xPos<= DOWN_currentX;
    point <= CurrentPoint;
    play <= playingCurrent;
    newGame <= resetCurrent;
    PlayerLost <= LOSE;
    playerWon <= WIN;
end Behavioral;

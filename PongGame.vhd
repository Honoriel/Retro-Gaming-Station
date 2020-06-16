----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2020 11:26:08 AM
-- Design Name: 
-- Module Name: PongGame - Behavioral
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

entity PongGame is
  Port (start, move, Game_On: in std_logic;
        paddleWidth: in integer;
        WinCondition: in integer;
        paddlePos, paddleAIPos: in integer range H_Total - H_Display + 1 to H_Total - Width_Player;
        AIPoint, PlayerPoint: out integer range 0 to 3;
        xPos: out integer range H_Total - H_Display + 1 to H_Total - Ball_Size;
        yPos: out integer range V_Total - V_Display + 1 to V_Total;
        newGame, play, AIWon, PlayerWon, PlayerScored, AIScored: out std_logic);
end PongGame;

architecture Behavioral of PongGame is
--Intermediate signals
signal currentX: integer range H_Total - H_Display + 1 to H_Total - Ball_Size:= BALL_INITIAL_X;
signal currentY: integer range V_Total - V_Display + 1 to V_Total:= BALL_INITIAL_Y;
signal playingCurrent: std_logic:= '0';
signal resetCurrent: std_logic:= '1';
signal AICurrentPoint, PlayerCurrentPoint: integer range 0 to 3 :=0;
signal playerWins, AIWins, AIScores, PlayerScores,Increment_Flag: std_logic:= '0';	
begin

 process(move)
 variable wallHorizontalBounce, paddleSurfaceBounce, paddleAISurfaceBounce: boolean := false; 
 variable H_Velocity: integer:= -1; -- -1: left & up 1: right & down 
 variable V_Velocity: integer:= -1; -- -1: left & up 1: right & down 
    begin
     --Win/Lose conditions
            
        if rising_edge(move) then 
        if game_on ='1' then

            if currentY <= V_FPorch + V_SPulse + V_BPorch + 1 then
                playerScores <= '1';
            elsif start = '1' then
                playerScores <= '0';
            end if;
            if currentY >= V_Total then
                AIScores <= '1';
            elsif start = '1' then
                AIScores <= '0';
            end if;
            
            if playerCurrentPoint = WinCondition then
                PlayerWins <= '1';
                AICurrentPoint <= 0;
                PlayerCurrentPoint <= 0;
            elsif start ='1' then
                PlayerWins <= '0';
            end if;
            
            if AICurrentPoint = WinCondition then
                AIWins <= '1';
                AICurrentPoint <= 0;
                PlayerCurrentPoint <= 0;
            elsif start ='1' then
                AIWins <= '0';
            end if;
            
            --Reset Logic
            if AIScores ='1' then
                currentX <= BALL_INITIAL_X;
                currentY <= BALL_INITIAL_Y;
                if  Increment_Flag = '0' then
                    AICurrentPoint <= AICurrentPoint +1;
                    Increment_Flag <= '1';
                end if;
                playingCurrent <= '0';
                resetCurrent <= '1';
            elsif start = '1' then
                Increment_Flag <= '0' ;
                playingCurrent <= '1';
                resetCurrent <= '0';
            end if;
            if PLAYERScores ='1' then
                currentX <= BALL_INITIAL_X;
                currentY <= BALL_INITIAL_Y;
                if  Increment_Flag = '0' then
                    PlayerCurrentPoint <= PlayerCurrentPoint +1;
                    Increment_Flag <= '1';
                end if;
                playingCurrent <= '0';
                resetCurrent <= '1';
            elsif start = '1' then
                Increment_Flag <= '0' ;
                playingCurrent <= '1';
                resetCurrent <= '0';
            end if;
       
            
          
                
            
            --Collision 
            wallHorizontalBounce := currentX <= H_FPorch + H_SPulse + H_BPorch + 1 or currentX >= H_Total - Ball_Size;
            paddleSurfaceBounce := currentY > V_Total - PADDLE_HEIGHT - Ball_Size and 
                                   currentX > paddlePos - Ball_Size and 
                                   currentX < paddlePos + paddleWidth ;
            paddleAISurfaceBounce := currentY < V_FPorch + V_SPulse + V_BPorch + PADDLE_HEIGHT and 
                                     currentX > paddleAIPos - Ball_Size and 
                                     currentX < paddleAIPos + Width_Player ;
            
            --Next state logics for the position and velocity of the ball                      
            if wallHorizontalBounce then
               H_Velocity := - H_Velocity;
            elsif playingCurrent = '0' then
               H_Velocity := -1; 
            end if;
            if paddleSurfaceBounce or paddleAISurfaceBounce then
                V_Velocity :=  - V_Velocity;
            elsif playingCurrent = '0' then
                V_Velocity := -1;
            end if;
            if playingCurrent = '1' then
                currentX <= currentX + H_Velocity;
                currentY <= currentY + V_Velocity;
            end if;
            else
            currentX <= BALL_INITIAL_X;
            currentY <= BALL_INITIAL_Y;
            playingCurrent <= '0';
            resetCurrent <= '1';
            AIWins <= '0';
            AIScores <= '0';
            PlayerScores <= '0';
            AIcurrentPoint <= 0;
            PLayerCurrentPoint <= 0;
            playerWins <= '0';
            end if;
        end if;
    end process;
    
    PlayerScored <= PlayerScores;
    AIScored <= AIScores;
    AIPoint <= AICurrentPoint;
    PlayerPoint <= PlayerCurrentPoint;
    xPos <= currentX;
    yPos <= currentY;
    play <= playingCurrent;
    newGame <= resetCurrent;
    AIWon <= AIWins;
    playerWon <= playerWins;
end Behavioral;



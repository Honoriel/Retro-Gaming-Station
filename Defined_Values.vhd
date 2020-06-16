----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2020 11:55:58 PM
-- Design Name: 
-- Module Name: Defined_Values - Behavioral
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

package Defined_Values is
                                                                                                                                       
    constant H_Display: integer:= 640;                                                                                                 
    constant H_FPorch: integer:= 16;                                                                                                   
    constant H_SPulse: integer:= 96;                                                                                                   
    constant H_BPorch: integer:= 48;                                                                                                   
    constant H_Total: integer:= H_Display + H_FPorch + H_SPulse + H_BPorch; --800                                                      
                                                                                                                                       
    constant V_Display: integer:= 480;                                                                                                 
    constant V_FPorch: integer:= 10;                                                                                                   
    constant V_SPulse: integer:= 2;                                                                                                    
    constant V_BPorch: integer:= 33;                                                                                                   
    constant V_Total: integer:= V_Display + V_FPorch + V_SPulse + V_BPorch; --525                                                      
                                                                                                                                       
    constant Width_Player: integer:= 80;                                                                                          
    constant PADDLE_HEIGHT: integer:= 12;                                                                                              
    constant Prescaler_paddle: integer:= 40000; -- adjust the speed of the paddle of the player                                                   
                                                                                                                                       
    constant Arrows_INIT_X: integer := H_Total - 50;                                                                                   
                                                                                                                                       
                                                                                                                                       
    constant Ball_size: integer:= 11;                                                                                                  
    constant Ball_Initial_X: integer:= H_FPorch + H_SPulse + H_BPorch + (H_Display - Ball_size) / 2;                               
    constant Ball_Initial_Y: integer:=  V_FPorch + V_SPulse + V_BPorch + (V_Display- Ball_size)/2;                                                                                            
    constant Prescaler_Moving_Object: integer:= 35000; --adjust the speed of the ball and arrows                                       
                                                                                                                                       
    constant default_rhythm: integer := 9000000;                                                                                      
    
end Defined_Values;

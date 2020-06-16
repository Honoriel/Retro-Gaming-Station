----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2020 08:55:48 PM
-- Design Name: 
-- Module Name: VGA_Main - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_Main is
        Port (clock, centerButton, upButton, leftButton, rightButton, downButton: in std_logic;
                difficultyControl: in std_logic_vector(1 downto 0);
                Reset_main: in std_logic;
                hSync, vSync: out std_logic;
                VGARed, VGAGreen, VGABlue: out std_logic_vector(3 downto 0));
end VGA_Main;
    
architecture Behavioral of VGA_Main is

component ClockDivider is
    Port (InClock: in std_logic;
          OutClock: out std_logic);
end component;
  
component Games_Images is
    Port (clock, left, right,up_button, down_button, start_button, reset_main: in std_logic;
          difficultyControl: in std_logic_vector(1 downto 0);
          hSync, vSync: out std_logic; 
          r, g, b: out std_logic_vector(3 downto 0));
end component;

signal VGAClock: std_logic;
   
begin
    --port-mappings
    Component1: ClockDivider 
                    port map(Inclock => clock,
                             Outclock => VGAClock);
    Component2: Games_Images
                        port map(clock => VGAClock,
                                 up_button => upbutton,
                                 down_button => downbutton,   
                                 left => leftButton,
                                 right => rightButton,
                                 start_button => centerButton,
                                 reset_main => reset_main,
                                 difficultyControl => difficultyControl,
                                 hSync => hSync,
                                 vSync => vSync,
                                 r => VGARed,
                                 g => VGAGreen,
                                 b => VGABlue);
                                 

end Behavioral;


----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 02/18/2019 01:43:01 PM
-- Design Name:
-- Module Name: EX1 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity mux2to1 is
  port ( A,B : in std_logic_vector(7 downto 0);
         SEL : in std_logic;
         mux_out : out std_logic_vector(7 downto 0));
end mux2to1;
architecture mux2to1 of mux2to1 is
begin
    --mux_out <= A WHEN SEL ='1' ELSE
    --    B;
    
with SEL select
    mux_out <= A when '1',
               B when '0',
               (others => '0') when others;
end mux2to1;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity regA is
  port ( reg_in : in std_logic_vector(7 downto 0);
         CLK, LDA : in std_logic;
         reg_out : out std_logic_vector(7 downto 0));
end regA;

architecture regA of regA is
begin
    process(CLK) begin
    if (rising_edge(clk) AND LDA = '1') then
        reg_out <= reg_in;
    end if;
end process;
end regA;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX1 is
    Port (LDA, SEL, CLK : in std_logic;
      A, B : in std_logic_vector(7 downto 0);
      F : out std_logic_vector(7 downto 0));
end EX1;

architecture Behavioral of EX1 is
component mux2to1
    Port ( A, B : in std_logic_vector(7 downto 0);
           SEL : in std_logic;
           mux_out : out std_logic_vector(7 downto 0));
end component;
component regA
    Port (CLK, LDA : in std_logic;
          reg_in : in std_logic_vector(7 downto 0);
          reg_out : out std_logic_vector(7 downto 0));
end component;


    signal mux_out : std_logic_vector(7 downto 0);
begin
MuxName: mux2to1 port map (A => A,
                         B => B,
                         SEL => SEL,
                         mux_out => mux_out);

RegName: regA port map ( reg_in => mux_out,
                         CLK => CLK,
                         LDA => LDA,
                         reg_out => F);
end Behavioral;

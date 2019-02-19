----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 02/18/2019 06:29:55 PM
-- Design Name:
-- Module Name: EX4 - Behavioral
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

entity reg is
  port ( reg_in : in std_logic_vector(7 downto 0);
         CLK, LD : in std_logic;
         reg_out : out std_logic_vector(7 downto 0));
end reg;

architecture reg of reg is
begin
    process(CLK) begin
    if (rising_edge(clk) AND LD = '1') then
        reg_out <= reg_in;
    end if;
end process;
end reg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND_gate is
  port ( A, B : in std_logic;
         and_out : out std_logic);
end AND_gate;

architecture AND_gate of AND_gate is
begin
    process(A, B) begin
         if (A = '1' AND B = '1') then
            and_out <= '1';
         else and_out <= '0';
        end if;
    end process;
end AND_gate;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NOT_gate is
  port ( A : in std_logic;
         not_out : out std_logic);
end NOT_gate;

architecture NOT_gate of NOT_gate is
begin
        not_out <= not A;
end NOT_gate;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX4 is
    Port (LDA, LDB, S1, S0, CLK, RD : in std_logic;
      X, Y : in std_logic_vector(7 downto 0);
      RA, RB : out std_logic_vector(7 downto 0));
end EX4;

architecture Behavioral of EX4 is
component mux2to1
    Port ( A, B : in std_logic_vector(7 downto 0);
           SEL : in std_logic;
           mux_out : out std_logic_vector(7 downto 0));
end component;
component reg
    Port (CLK, LD : in std_logic;
          reg_in : in std_logic_vector(7 downto 0);
          reg_out : out std_logic_vector(7 downto 0));
end component;
component AND_gate
    Port (A, B : in std_logic;
          and_out : out std_logic);
end component;
component NOT_gate
    Port (A : in std_logic;
          not_out : out std_logic);
end component;
    signal AND1_out, AND2_out, NOT_out : std_logic;
    signal mux1_out, mux2_out, RegA_out, RegB_out : std_logic_vector(7 downto 0);
--    signal mux1_out, mux2_out, regA_out, regB_out : std_logic_vector(7 downto 0);
begin
Mux1: mux2to1 port map (A => X,
                         B => Y,
                         SEL => S1,
                         mux_out => mux1_out);
                         
Mux2: mux2to1 port map ( A => regB_out,
                         B => Y,
                         SEL => S0,
                         mux_out => mux2_out);

RegA: reg port map ( reg_in => mux2_out,
                         CLK => CLK,
                         LD => AND2_out,
                         reg_out => regA_out);
                         
RegB: reg port map ( reg_in => mux1_out,
                     CLK => CLK,
                     LD => AND1_out,
                     reg_out => regB_out);
                     
AND1: AND_gate port map ( A => LDB,
                          B => NOT_out,
                          AND_out => AND1_out);
                                               
AND2: AND_gate port map ( A => LDA,
                          B => RD,
                          AND_out => AND2_out);
                          
NOT1: NOT_gate port map ( A => RD,
                          NOT_out => NOT_out);
                     
RB <= regB_out;
RA <= regA_out;
                         
end Behavioral;

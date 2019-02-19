----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 02/18/2019 07:03:57 PM
-- Design Name:
-- Module Name: EX5 - Behavioral
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

entity dec1to2 is
  Port ( DS : in std_logic;
         dec_out1, dec_out0 : out std_logic);
end dec1to2;

architecture dec1to2 of dec1to2 is
begin
process (DS)
begin
    if (DS = '1') then
        dec_out0 <= '0';
        dec_out1 <= '1';
    elsif (DS = '0') then
        dec_out0 <= '1';
        dec_out1 <= '0';
    else
        dec_out0 <= '0';
        dec_out1 <= '1';
    end if;

end process;

end dec1to2;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX5 is
    Port ( SL1, SL2, CLK : in std_logic;
      A, B, C : in std_logic_vector(7 downto 0);
      RAX, RBX : out std_logic_vector(7 downto 0));
end EX5;

architecture Behavioral of EX5 is
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

component dec1to2
  Port ( DS : in std_logic;
         dec_out1, dec_out0 : out std_logic);
end component;


    signal mux_out, regA_out, regB_out : std_logic_vector(7 downto 0);
    signal dec_out1, dec_out0 : std_logic;
begin
Mux1: mux2to1 port map (A => B,
                         B => C,
                         SEL => SL2,
                         mux_out => mux_out);

Decoder: dec1to2 port map ( DS => SL1,
                            dec_out1 => dec_out1,
                            dec_out0 => dec_out0);

RegA: reg port map ( reg_in => A,
                         CLK => CLK,
                         LD => dec_out1,
                         reg_out => regA_out);
                         
RegB: reg port map ( reg_in => mux_out,
                     CLK => CLK,
                     LD => dec_out0,
                     reg_out => regB_out);

RAX <= regA_out;                    
RBX <= regB_out;
                         
end Behavioral;

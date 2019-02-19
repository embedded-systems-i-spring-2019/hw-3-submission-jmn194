----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 02/18/2019 04:56:04 PM
-- Design Name:
-- Module Name: EX2 - Behavioral
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

entity mux4to1 is
  Port ( X, Y, Z, reg_out : in std_logic_vector(7 downto 0);
         MS : in std_logic_vector(1 downto 0);
         mux_out : out std_logic_vector(7 downto 0));
end mux4to1;

architecture mux4to1 of mux4to1 is
begin
process (MS, X, Y, Z, reg_out)
begin
   case MS is
      when "00" => mux_out <= X;
      when "01" => mux_out <= Y;
      when "10" => mux_out <= Z;
      when "11" => mux_out <= reg_out;
      when others => mux_out <= X;
   end case;
end process;

end mux4to1;

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

entity reg is
  Port ( reg_in : in std_logic_vector(7 downto 0);
         CLK, LDA : in std_logic;
         reg_out : out std_logic_vector(7 downto 0));
end reg;

architecture reg of reg is
begin
    process(CLK) begin
    if (rising_edge(CLK) AND LDA = '1') then
        reg_out <= reg_in;
    end if;
end process;
end reg;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity EX2 is
  Port ( DS, CLK : in std_logic;
         X, Y, Z : in std_logic_vector(7 downto 0);
         MS : in std_logic_vector(1 downto 0);
         RA, RB : out std_logic_vector(7 downto 0));
end EX2;

architecture Behavioral of EX2 is
component mux4to1
  Port ( X, Y, Z, reg_out : in std_logic_vector(7 downto 0);
         MS : in std_logic_vector(1 downto 0);
         mux_out : out std_logic_vector(7 downto 0));
end component;

component dec1to2
  Port ( DS : in std_logic;
         dec_out1, dec_out0 : out std_logic);
end component;

component reg
  Port ( reg_in : in std_logic_vector(7 downto 0);
         CLK, LDA : in std_logic;
         reg_out : out std_logic_vector(7 downto 0));
end component;

--component regB
--  Port ( regB_in : in std_logic_vector(7 downto 0);
--         CLK, LDA : in std_logic;
--         regB_out : out std_logic_vector(7 downto 0));
--end component;

    signal mux_out, regA_out, regB_out : std_logic_vector(7 downto 0);
    signal dec_out1, dec_out0 : std_logic;

begin
Mux_4To1: mux4to1 port map ( X => X,
                             Y => Y,
                             Z => Z,
                             reg_out => regB_out,
                             MS => MS,
                             mux_out => mux_out);
                             
Decoder: dec1to2 port map ( DS => DS,
                            dec_out1 => dec_out1,
                            dec_out0 => dec_out0);

RegA: reg port map (reg_in => mux_out,
                    CLK => CLK,
                    LDA => dec_out0,
                    reg_out => regA_out);

RegB: reg port map (reg_in => regA_out,
                    CLK => CLK,
                    LDA => dec_out1,
                    reg_out => regB_out);

RA <= regA_out;
RB <= regB_out;

end Behavioral;

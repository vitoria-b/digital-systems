--******************************************************************************
--        Written by Vitoria B. for Digital Systems and Reconfigurable         *
--      Devices course (EEL 510389) from the postgraduate program at the       *
--           Department of Electrical and Electronics Engineering              *
--                at the Federal University of Santa Catarina.                 *
--******************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity shifter is
port (
input : in std_logic_vector(7 downto 0);
shift_cntrl : in std_logic_vector(1 downto 0);
shift_out : out std_logic_vector(15 downto 0)
);
end entity shifter;

architecture logic of shifter is
begin
process(input, shift_cntrl)
begin
if shift_cntrl="00" then
shift_out(7 downto 0) <= input;
elsif shift_cntrl="01" then
shift_out(11 downto 4) <= input (7 downto 0);
elsif shift_cntrl="10" then
shift_out(15 downto 8) <= input (7 downto 0);
elsif shift_cntrl="11" then
shift_out(7 downto 0) <= input (7 downto 0);
end if;
end process;
end architecture logic;
--******************************************************************************
--        Written by Vitoria B. for Digital Systems and Reconfigurable         *
--      Devices course (EEL 510389) from the postgraduate program at the       *
--           Department of Electrical and Electronics Engineering              *
--                at the Federal University of Santa Catarina.                 *
--******************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter is
port (
clk : in std_logic;
aclr_n : in std_logic;
count_out : out std_logic_vector (1 downto 0)
);
end entity counter;

architecture count of counter is
begin
process (clk, aclr_n)
	variable q_var : std_logic_vector (1 downto 0);
begin
	if aclr_n = '0' then
	q_var := "00";
	elsif rising_edge (clk) then
	q_var := q_var + 1;
	end if;
	count_out <= q_var;
end process;
end architecture count;
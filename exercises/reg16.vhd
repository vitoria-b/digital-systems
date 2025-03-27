--******************************************************************************
--        Written by Vitoria B. for Digital Systems and Reconfigurable         *
--      Devices course (EEL 510389) from the postgraduate program at the       *
--           Department of Electrical and Electronics Engineering              *
--                at the Federal University of Santa Catarina.                 *
--******************************************************************************

LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity reg16 is
	PORT (
			clk, clk_ena, sclr_n : IN STD_LOGIC;
			datain: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			reg_out : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
end entity reg16;

ARCHITECTURE logic OF reg16 IS
BEGIN
process (clk, clk_ena, sclr_n, datain)
begin
	IF rising_edge (clk) THEN
		IF clk_ena = '1' THEN
			IF sclr_n = '0' THEN
				reg_out <= (OTHERS => '0');
			ELSE 
				reg_out <= datain;
			END IF;
		END IF;
	END IF;
end process;
END ARCHITECTURE logic;
--******************************************************************************
--        Written by Vitoria B. for Digital Systems and Reconfigurable         *
--      Devices course (EEL 510389) from the postgraduate program at the       *
--           Department of Electrical and Electronics Engineering              *
--                at the Federal University of Santa Catarina.                 *
--******************************************************************************


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY adder IS
	PORT (
		dataa, datab : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		sum : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
END ENTITY adder;

ARCHITECTURE logic of adder IS
BEGIN
	sum <= dataa + datab;
END ARCHITECTURE logic;
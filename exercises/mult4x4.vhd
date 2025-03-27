--******************************************************************************
--        Written by Vitoria B. for Digital Systems and Reconfigurable         *
--      Devices course (EEL 510389) from the postgraduate program at the       *
--           Department of Electrical and Electronics Engineering              *
--                at the Federal University of Santa Catarina.                 *
--******************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mult4x4 IS
	PORT (
		dataa, datab : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		product : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
END ENTITY mult4x4;

ARCHITECTURE logic OF mult4x4 IS
BEGIN
	product <= dataa * datab;
END ARCHITECTURE logic;
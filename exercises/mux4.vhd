--******************************************************************************
--        Written by Vitoria B. for Digital Systems and Reconfigurable         *
--      Devices course (EEL 510389) from the postgraduate program at the       *
--           Department of Electrical and Electronics Engineering              *
--                at the Federal University of Santa Catarina.                 *
--******************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux4 IS
	PORT (
	mux_in_a, mux_in_b : IN std_logic_vector (3 downto 0);
	mux_sel : IN std_logic;
	mux_out : OUT std_logic_vector (3 downto 0)
	);
END ENTITY mux4;

ARCHITECTURE logic OF mux4 IS 
BEGIN 
PROCESS(mux_in_a, mux_in_b, mux_sel)
BEGIN
	IF mux_sel='0' THEN
		mux_out <= mux_in_a;
	ELSIF mux_sel='1' THEN
		mux_out <= mux_in_b;
	END IF;
END PROCESS;
END ARCHITECTURE logic;
	
--******************************************************************************
--                                                                             *
--                  Copyright (C) 2009 Altera Corporation                      *
--                                                                             *
-- ALTERA, ARRIA, CYCLONE, HARDCOPY, MAX, MEGACORE, NIOS, QUARTUS & STRATIX    *
-- are Reg. U.S. Pat. & Tm. Off. and Altera marks in and outside the U.S.      *
--                                                                             *
-- All information provided herein is provided on an "as is" basis,            *
-- without warranty of any kind.                                               *
--                                                                             *
-- Module Name: mult8x8                        File Name: mult8x8.vhd          *
--                                                                             *
-- Module Function: This file contains the top level module for the            *
--                  8x8 multiplier                                             *
--                                                                             *
-- REVISION HISTORY:                                                           *
--  Revision 1.0    11/24/2009 - Initial Revision  for QII 9.1                 *
--******************************************************************************

-- Insert library and use clauses
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Begin entity declaration for top-level "mult8x8"
ENTITY mult8x8 IS
	-- Begin port declartion
	PORT (
		-- Declare control inputs "clk", "start" and "reset_a"
		clk, start, reset_a : IN STD_LOGIC;
		
		-- Declare data inputs "dataa" and "datab"
		dataa, datab : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

		-- Declare multiplier output "product8x8_out"
		product8x8_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		
		-- Declare seven segment display outputs
		seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g, done_flag : OUT STD_LOGIC
	);
-- End entity
END ENTITY mult8x8;

--  Begin architecture 
ARCHITECTURE logic OF mult8x8 IS

	-- Declare all lower level components
	COMPONENT adder
		PORT (  
			dataa, datab : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			sum : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT adder;
	

	COMPONENT mult4x4 
		PORT (
			dataa, datab : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			product : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
			);
	END COMPONENT mult4x4;
	

	COMPONENT mux4 
		PORT ( 
			mux_in_a, mux_in_b: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			mux_sel : IN STD_LOGIC;
			mux_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT mux4;

	
	COMPONENT shifter
		port (
		input : in std_logic_vector(7 downto 0);
		shift_cntrl : in std_logic_vector(1 downto 0);
		shift_out : out std_logic_vector(15 downto 0)
		);
	END COMPONENT shifter;

	
	COMPONENT seven_segment_cntrl
		PORT (
			input : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g : OUT STD_LOGIC
		);
	END COMPONENT seven_segment_cntrl;
	
	COMPONENT reg16
		PORT (
			clk, clk_ena, sclr_n : IN STD_LOGIC;
			datain: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			reg_out : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT reg16;	
	
	COMPONENT counter
		PORT (
			clk, aclr_n : IN STD_LOGIC;
			count_out : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
		);
	END COMPONENT counter;	
	
	COMPONENT mult_control
		PORT (
			clk, reset_a, start : IN STD_LOGIC;
			count : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			input_sel, shift_sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			state_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			done, clk_ena, sclr_n : OUT STD_LOGIC
		);
	END COMPONENT mult_control;	
	
	-- Declare internal signals to use as wires to connect blocks
	SIGNAL aout, bout : std_logic_vector(3 DOWNTO 0);
 
	SIGNAL shift_out, sum, product8x8 : std_logic_vector(15 DOWNTO 0);
	SIGNAL count, shift : std_logic_vector(1 DOWNTO 0);
	SIGNAL state_out : std_logic_vector(2 DOWNTO 0);
	SIGNAL clk_ena, sclr_n, start_n : std_logic;
	SIGNAL sel : std_logic_vector(1 DOWNTO 0);
	SIGNAL product : STD_LOGIC_VECTOR(7 DOWNTO 0);



BEGIN
	-- Start SIGNAL requires inversion before connecting to counter
	start_n <= not(start);

	--  Connect blocks per schematic
	u1: mux4 PORT MAP (mux_in_a => dataa(3 DOWNTO 0), mux_in_b => dataa(7 DOWNTO 4), mux_sel => sel(1),
						mux_out => aout);

	u2: mux4 PORT MAP (mux_in_a => datab(3 DOWNTO 0), mux_in_b => datab(7 DOWNTO 4), mux_sel => sel(0),
						mux_out => bout);

	u3: mult4x4 PORT MAP (dataa(3 DOWNTO 0) => aout, datab(3 DOWNTO 0) => bout, product(7 DOWNTO 0) => product(7 DOWNTO 0));
	
	u4: shifter PORT MAP (input(7 downto 0) => product(7 DOWNTO 0), shift_cntrl => shift, shift_out(15 downto 0) => shift_out(15 downto 0));
	
	u5: counter PORT MAP (clk => clk, aclr_n => start_n, count_out => count);

	u6: mult_control PORT MAP (clk => clk, reset_a => reset_a, start => start, count => count,
							input_sel => sel, shift_sel => shift, state_out => state_out,
							done => done_flag, clk_ena => clk_ena, sclr_n => sclr_n);

	u7: reg16 PORT MAP (clk => clk, sclr_n => sclr_n, clk_ena => clk_ena, datain => sum,
						reg_out => product8x8);

	u8: adder PORT MAP (dataa => shift_out, datab => product8x8, sum => sum);

	u9: seven_segment_cntrl PORT MAP (input => state_out, seg_a => seg_a, seg_b => seg_b, seg_c => seg_c, seg_d => seg_d,
							seg_e => seg_e, seg_f => seg_f, seg_g => seg_g);
							
	product8x8_out <= product8x8;

-- End architecture
END ARCHITECTURE logic;
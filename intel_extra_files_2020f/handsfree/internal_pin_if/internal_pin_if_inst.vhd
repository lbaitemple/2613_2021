	component internal_pin_if is
		port (
			clk_clk                      : in  std_logic                     := 'X';             -- clk
			led31_to_0_export            : in  std_logic_vector(31 downto 0) := (others => 'X'); -- export
			led63_to_32_export           : in  std_logic_vector(31 downto 0) := (others => 'X'); -- export
			pbs11_to_10_sws9_to_0_export : out std_logic_vector(11 downto 0);                    -- export
			reset_reset_n                : in  std_logic                     := 'X';             -- reset_n
			param1_export                : out std_logic_vector(31 downto 0);                    -- export
			param2_export                : out std_logic_vector(31 downto 0);                    -- export
			param3_export                : out std_logic_vector(31 downto 0)                     -- export
		);
	end component internal_pin_if;

	u0 : component internal_pin_if
		port map (
			clk_clk                      => CONNECTED_TO_clk_clk,                      --                   clk.clk
			led31_to_0_export            => CONNECTED_TO_led31_to_0_export,            --            led31_to_0.export
			led63_to_32_export           => CONNECTED_TO_led63_to_32_export,           --           led63_to_32.export
			pbs11_to_10_sws9_to_0_export => CONNECTED_TO_pbs11_to_10_sws9_to_0_export, -- pbs11_to_10_sws9_to_0.export
			reset_reset_n                => CONNECTED_TO_reset_reset_n,                --                 reset.reset_n
			param1_export                => CONNECTED_TO_param1_export,                --                param1.export
			param2_export                => CONNECTED_TO_param2_export,                --                param2.export
			param3_export                => CONNECTED_TO_param3_export                 --                param3.export
		);


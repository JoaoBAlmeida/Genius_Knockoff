library verilog;
use verilog.vl_types.all;
entity genius_knockoff_vlg_sample_tst is
    port(
        btn0            : in     vl_logic;
        btn1            : in     vl_logic;
        btn2            : in     vl_logic;
        btn3            : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end genius_knockoff_vlg_sample_tst;

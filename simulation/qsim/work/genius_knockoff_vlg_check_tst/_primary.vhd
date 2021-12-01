library verilog;
use verilog.vl_types.all;
entity genius_knockoff_vlg_check_tst is
    port(
        led0            : in     vl_logic;
        led1            : in     vl_logic;
        led2            : in     vl_logic;
        led3            : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end genius_knockoff_vlg_check_tst;

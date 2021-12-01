library verilog;
use verilog.vl_types.all;
entity genius_knockoff is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        btn0            : in     vl_logic;
        btn1            : in     vl_logic;
        btn2            : in     vl_logic;
        btn3            : in     vl_logic;
        led0            : out    vl_logic;
        led1            : out    vl_logic;
        led2            : out    vl_logic;
        led3            : out    vl_logic
    );
end genius_knockoff;

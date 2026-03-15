module ClockModule(
  input   clock,
  input   reset,
  output  io_clk // @[\\src\\main\\scala\\vga\\ClockModule.scala 12:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] clockCount; // @[\\src\\main\\scala\\vga\\ClockModule.scala 14:27]
  wire [1:0] _clockCount_T_1 = clockCount + 2'h1; // @[\\src\\main\\scala\\vga\\ClockModule.scala 15:28]
  assign io_clk = clockCount == 2'h3; // @[\\src\\main\\scala\\vga\\ClockModule.scala 16:25]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\ClockModule.scala 14:27]
      clockCount <= 2'h0; // @[\\src\\main\\scala\\vga\\ClockModule.scala 14:27]
    end else begin
      clockCount <= _clockCount_T_1; // @[\\src\\main\\scala\\vga\\ClockModule.scala 15:14]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  clockCount = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Buffer(
  output [1:0] io_col_R, // @[\\src\\main\\scala\\vga\\Buffer.scala 26:14]
  output [1:0] io_col_G, // @[\\src\\main\\scala\\vga\\Buffer.scala 26:14]
  output [1:0] io_col_B, // @[\\src\\main\\scala\\vga\\Buffer.scala 26:14]
  input  [9:0] io_indexX, // @[\\src\\main\\scala\\vga\\Buffer.scala 26:14]
  input  [9:0] io_indexY // @[\\src\\main\\scala\\vga\\Buffer.scala 26:14]
);
  wire [9:0] _curcolour_T_1 = io_indexX + io_indexY; // @[\\src\\main\\scala\\vga\\Buffer.scala 29:30]
  wire [9:0] _GEN_0 = _curcolour_T_1 % 10'h4; // @[\\src\\main\\scala\\vga\\Buffer.scala 29:43]
  wire [2:0] curcolour = _GEN_0[2:0]; // @[\\src\\main\\scala\\vga\\Buffer.scala 29:43]
  wire  valid = io_indexY < 10'h1e0 & io_indexX < 10'h280; // @[\\src\\main\\scala\\vga\\Buffer.scala 32:33]
  wire [2:0] _io_col_R_T = valid ? curcolour : 3'h0; // @[\\src\\main\\scala\\vga\\Buffer.scala 33:18]
  assign io_col_R = _io_col_R_T[1:0]; // @[\\src\\main\\scala\\vga\\Buffer.scala 33:12]
  assign io_col_G = _io_col_R_T[1:0]; // @[\\src\\main\\scala\\vga\\Buffer.scala 34:12]
  assign io_col_B = _io_col_R_T[1:0]; // @[\\src\\main\\scala\\vga\\Buffer.scala 35:12]
endmodule
module VGAModule(
  input        clock,
  input        reset,
  output [1:0] io_col_R, // @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
  output [1:0] io_col_G, // @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
  output [1:0] io_col_B, // @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
  output       io_hsync, // @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
  output       io_vsync // @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  slowClock_clock; // @[\\src\\main\\scala\\vga\\VGAModule.scala 18:25]
  wire  slowClock_reset; // @[\\src\\main\\scala\\vga\\VGAModule.scala 18:25]
  wire  slowClock_io_clk; // @[\\src\\main\\scala\\vga\\VGAModule.scala 18:25]
  wire [1:0] buf__io_col_R; // @[\\src\\main\\scala\\vga\\VGAModule.scala 24:19]
  wire [1:0] buf__io_col_G; // @[\\src\\main\\scala\\vga\\VGAModule.scala 24:19]
  wire [1:0] buf__io_col_B; // @[\\src\\main\\scala\\vga\\VGAModule.scala 24:19]
  wire [9:0] buf__io_indexX; // @[\\src\\main\\scala\\vga\\VGAModule.scala 24:19]
  wire [9:0] buf__io_indexY; // @[\\src\\main\\scala\\vga\\VGAModule.scala 24:19]
  reg [9:0] hCounter; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  wire  wrap_wrap = hCounter == 10'h31f; // @[src/main/scala/chisel3/util/Counter.scala 73:24]
  wire [9:0] _wrap_value_T_1 = hCounter + 10'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  wire  hWrap = slowClock_io_clk & wrap_wrap; // @[src/main/scala/chisel3/util/Counter.scala 118:{16,23} 117:24]
  wire  _T = hWrap & slowClock_io_clk; // @[\\src\\main\\scala\\vga\\VGAModule.scala 20:40]
  reg [9:0] vCounter; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  wire  wrap_wrap_1 = vCounter == 10'h20c; // @[src/main/scala/chisel3/util/Counter.scala 73:24]
  wire [9:0] _wrap_value_T_3 = vCounter + 10'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  ClockModule slowClock ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 18:25]
    .clock(slowClock_clock),
    .reset(slowClock_reset),
    .io_clk(slowClock_io_clk)
  );
  Buffer buf_ ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 24:19]
    .io_col_R(buf__io_col_R),
    .io_col_G(buf__io_col_G),
    .io_col_B(buf__io_col_B),
    .io_indexX(buf__io_indexX),
    .io_indexY(buf__io_indexY)
  );
  assign io_col_R = buf__io_col_R; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:12]
  assign io_col_G = buf__io_col_G; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:12]
  assign io_col_B = buf__io_col_B; // @[\\src\\main\\scala\\vga\\VGAModule.scala 31:12]
  assign io_hsync = hCounter > 10'h28f & hCounter < 10'h2f0 ? 1'h0 : 1'h1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 34:18]
  assign io_vsync = vCounter > 10'h1e9 & vCounter < 10'h1ec ? 1'h0 : 1'h1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 35:18]
  assign slowClock_clock = clock;
  assign slowClock_reset = reset;
  assign buf__io_indexX = hCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 27:17]
  assign buf__io_indexY = vCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 28:17]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      hCounter <= 10'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (slowClock_io_clk) begin // @[src/main/scala/chisel3/util/Counter.scala 118:16]
      if (wrap_wrap) begin // @[src/main/scala/chisel3/util/Counter.scala 87:20]
        hCounter <= 10'h0; // @[src/main/scala/chisel3/util/Counter.scala 87:28]
      end else begin
        hCounter <= _wrap_value_T_1; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
      end
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      vCounter <= 10'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (_T) begin // @[src/main/scala/chisel3/util/Counter.scala 118:16]
      if (wrap_wrap_1) begin // @[src/main/scala/chisel3/util/Counter.scala 87:20]
        vCounter <= 10'h0; // @[src/main/scala/chisel3/util/Counter.scala 87:28]
      end else begin
        vCounter <= _wrap_value_T_3; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  hCounter = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  vCounter = _RAND_1[9:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

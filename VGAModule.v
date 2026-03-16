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
module PaddleObj(
  input         clock,
  input         reset,
  input         io_input, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 14:14]
  input  [11:0] io_pos_0, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 14:14]
  input  [11:0] io_pos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 14:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 14:14]
  output [11:0] io_paddlePos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 14:14]
  input         io_updateLogic // @[\\src\\main\\scala\\vga\\PaddleObj.scala 14:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [11:0] curPos_1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:23]
  reg [11:0] velocity; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 17:25]
  wire [5:0] _velocity_T_2 = 6'sh0 - 6'sh14; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 21:19]
  wire [11:0] _velocity_T_5 = $signed(velocity) + 12'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 23:28]
  wire [11:0] _GEN_0 = io_input ? $signed({{6{_velocity_T_2[5]}},_velocity_T_2}) : $signed(_velocity_T_5); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:21 21:16 23:16]
  wire [11:0] _curPos_1_T_2 = $signed(curPos_1) + $signed(velocity); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:32]
  wire [9:0] _curPos_1_T_5 = 10'sh1e0 - 10'sh28; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:52]
  wire [11:0] _GEN_6 = {{2{_curPos_1_T_5[9]}},_curPos_1_T_5}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:43]
  wire [11:0] _inSquare_T_2 = $signed(io_pos_0) - 12'sh50; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:30]
  wire [11:0] _inSquare_T_6 = 12'sh0 - $signed(_inSquare_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:43]
  wire [11:0] _inSquare_T_7 = $signed(_inSquare_T_2) < 12'sh0 ? $signed(_inSquare_T_6) : $signed(_inSquare_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:43]
  wire [11:0] _inSquare_T_11 = $signed(io_pos_1) - $signed(curPos_1); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:92]
  wire [11:0] _inSquare_T_15 = 12'sh0 - $signed(_inSquare_T_11); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:105]
  wire [11:0] _inSquare_T_16 = $signed(_inSquare_T_11) < 12'sh0 ? $signed(_inSquare_T_15) : $signed(_inSquare_T_11); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:105]
  assign io_inbound = $signed(_inSquare_T_7) < 12'sha & $signed(_inSquare_T_16) < 12'sh28; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:77]
  assign io_paddlePos_1 = curPos_1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 42:16]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:23]
      curPos_1 <= 12'shf0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:23]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
      if ($signed(_curPos_1_T_2) > $signed(_GEN_6)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:21]
        curPos_1 <= {{2{_curPos_1_T_5[9]}},_curPos_1_T_5};
      end else if ($signed(_curPos_1_T_2) < 12'sh28) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:125]
        curPos_1 <= 12'sh28;
      end else begin
        curPos_1 <= _curPos_1_T_2;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 17:25]
      velocity <= 12'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 17:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
      if ($signed(curPos_1) == 12'sh28) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:54]
        velocity <= 12'sh14; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:16]
      end else if ($signed(curPos_1) == $signed(_GEN_6)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:70]
        velocity <= -12'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 30:16]
      end else begin
        velocity <= _GEN_0;
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
  curPos_1 = _RAND_0[11:0];
  _RAND_1 = {1{`RANDOM}};
  velocity = _RAND_1[11:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PaddleObj_1(
  input         clock,
  input         reset,
  input         io_input, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 14:14]
  input  [11:0] io_pos_0, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 14:14]
  input  [11:0] io_pos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 14:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 14:14]
  output [11:0] io_paddlePos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 14:14]
  input         io_updateLogic // @[\\src\\main\\scala\\vga\\PaddleObj.scala 14:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [11:0] curPos_1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:23]
  reg [11:0] velocity; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 17:25]
  wire [5:0] _velocity_T_2 = 6'sh0 - 6'sh14; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 21:19]
  wire [11:0] _velocity_T_5 = $signed(velocity) + 12'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 23:28]
  wire [11:0] _GEN_0 = io_input ? $signed({{6{_velocity_T_2[5]}},_velocity_T_2}) : $signed(_velocity_T_5); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:21 21:16 23:16]
  wire [11:0] _curPos_1_T_2 = $signed(curPos_1) + $signed(velocity); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:32]
  wire [9:0] _curPos_1_T_5 = 10'sh1e0 - 10'sh28; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:52]
  wire [11:0] _GEN_6 = {{2{_curPos_1_T_5[9]}},_curPos_1_T_5}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:43]
  wire [11:0] _inSquare_T_2 = $signed(io_pos_0) - 12'sh230; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:30]
  wire [11:0] _inSquare_T_6 = 12'sh0 - $signed(_inSquare_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:43]
  wire [11:0] _inSquare_T_7 = $signed(_inSquare_T_2) < 12'sh0 ? $signed(_inSquare_T_6) : $signed(_inSquare_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:43]
  wire [11:0] _inSquare_T_11 = $signed(io_pos_1) - $signed(curPos_1); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:92]
  wire [11:0] _inSquare_T_15 = 12'sh0 - $signed(_inSquare_T_11); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:105]
  wire [11:0] _inSquare_T_16 = $signed(_inSquare_T_11) < 12'sh0 ? $signed(_inSquare_T_15) : $signed(_inSquare_T_11); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:105]
  assign io_inbound = $signed(_inSquare_T_7) < 12'sha & $signed(_inSquare_T_16) < 12'sh28; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:77]
  assign io_paddlePos_1 = curPos_1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 42:16]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:23]
      curPos_1 <= 12'shf0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:23]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
      if ($signed(_curPos_1_T_2) > $signed(_GEN_6)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:21]
        curPos_1 <= {{2{_curPos_1_T_5[9]}},_curPos_1_T_5};
      end else if ($signed(_curPos_1_T_2) < 12'sh28) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:125]
        curPos_1 <= 12'sh28;
      end else begin
        curPos_1 <= _curPos_1_T_2;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 17:25]
      velocity <= 12'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 17:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
      if ($signed(curPos_1) == 12'sh28) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:54]
        velocity <= 12'sh14; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:16]
      end else if ($signed(curPos_1) == $signed(_GEN_6)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:70]
        velocity <= -12'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 30:16]
      end else begin
        velocity <= _GEN_0;
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
  curPos_1 = _RAND_0[11:0];
  _RAND_1 = {1{`RANDOM}};
  velocity = _RAND_1[11:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BallObj(
  input         clock,
  input         reset,
  input  [11:0] io_pos_0, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  input  [11:0] io_pos_1, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  input  [11:0] io_P1Pos_1, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  input  [11:0] io_P2Pos_1, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  output        io_outLeftBound, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  output        io_outRightBound // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [11:0] ballSpeed; // @[\\src\\main\\scala\\vga\\Ball.scala 18:26]
  reg [11:0] curPos_0; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
  reg [11:0] curPos_1; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
  reg [11:0] velocity_0; // @[\\src\\main\\scala\\vga\\Ball.scala 21:25]
  reg [11:0] velocity_1; // @[\\src\\main\\scala\\vga\\Ball.scala 21:25]
  reg  outLeftBound; // @[\\src\\main\\scala\\vga\\Ball.scala 23:29]
  reg  outRightBound; // @[\\src\\main\\scala\\vga\\Ball.scala 24:30]
  wire [9:0] _velocity_1_T_3 = 10'sh1e0 - 10'sha; // @[\\src\\main\\scala\\vga\\Ball.scala 29:97]
  wire [11:0] _GEN_16 = {{2{_velocity_1_T_3[9]}},_velocity_1_T_3}; // @[\\src\\main\\scala\\vga\\Ball.scala 29:88]
  wire [11:0] _velocity_1_T_7 = 12'sh0 - $signed(ballSpeed); // @[\\src\\main\\scala\\vga\\Ball.scala 29:127]
  wire [11:0] _curPos_0_T_2 = $signed(curPos_0) + $signed(velocity_0); // @[\\src\\main\\scala\\vga\\Ball.scala 30:28]
  wire [11:0] _curPos_1_T_2 = $signed(curPos_1) + $signed(velocity_1); // @[\\src\\main\\scala\\vga\\Ball.scala 31:28]
  wire [11:0] _T_13 = $signed(io_P1Pos_1) - $signed(curPos_1); // @[\\src\\main\\scala\\vga\\Ball.scala 34:200]
  wire [11:0] _T_17 = 12'sh0 - $signed(_T_13); // @[\\src\\main\\scala\\vga\\Ball.scala 34:213]
  wire [11:0] _T_18 = $signed(_T_13) < 12'sh0 ? $signed(_T_17) : $signed(_T_13); // @[\\src\\main\\scala\\vga\\Ball.scala 34:213]
  wire [10:0] _T_30 = 11'sh280 - 11'sh64; // @[\\src\\main\\scala\\vga\\Ball.scala 37:59]
  wire [11:0] _GEN_17 = {{1{_T_30[10]}},_T_30}; // @[\\src\\main\\scala\\vga\\Ball.scala 37:50]
  wire [10:0] _T_35 = 11'sh280 - 11'sh50; // @[\\src\\main\\scala\\vga\\Ball.scala 37:175]
  wire [11:0] _GEN_18 = {{1{_T_35[10]}},_T_35}; // @[\\src\\main\\scala\\vga\\Ball.scala 37:166]
  wire [11:0] _T_40 = $signed(io_P2Pos_1) - $signed(curPos_1); // @[\\src\\main\\scala\\vga\\Ball.scala 37:228]
  wire [11:0] _T_44 = 12'sh0 - $signed(_T_40); // @[\\src\\main\\scala\\vga\\Ball.scala 37:241]
  wire [11:0] _T_45 = $signed(_T_40) < 12'sh0 ? $signed(_T_44) : $signed(_T_40); // @[\\src\\main\\scala\\vga\\Ball.scala 37:241]
  wire [11:0] _ballSpeed_T_2 = $signed(ballSpeed) + 12'sh1; // @[\\src\\main\\scala\\vga\\Ball.scala 39:30]
  wire  _T_48 = $signed(curPos_0) > 12'sh280; // @[\\src\\main\\scala\\vga\\Ball.scala 44:20]
  wire  _T_49 = $signed(curPos_0) < 12'sh0; // @[\\src\\main\\scala\\vga\\Ball.scala 49:20]
  wire [11:0] _inSquare_T_2 = $signed(io_pos_0) - $signed(curPos_0); // @[\\src\\main\\scala\\vga\\Ball.scala 58:30]
  wire [11:0] _inSquare_T_6 = 12'sh0 - $signed(_inSquare_T_2); // @[\\src\\main\\scala\\vga\\Ball.scala 58:43]
  wire [11:0] _inSquare_T_7 = $signed(_inSquare_T_2) < 12'sh0 ? $signed(_inSquare_T_6) : $signed(_inSquare_T_2); // @[\\src\\main\\scala\\vga\\Ball.scala 58:43]
  wire [11:0] _inSquare_T_11 = $signed(io_pos_1) - $signed(curPos_1); // @[\\src\\main\\scala\\vga\\Ball.scala 58:91]
  wire [11:0] _inSquare_T_15 = 12'sh0 - $signed(_inSquare_T_11); // @[\\src\\main\\scala\\vga\\Ball.scala 58:104]
  wire [11:0] _inSquare_T_16 = $signed(_inSquare_T_11) < 12'sh0 ? $signed(_inSquare_T_15) : $signed(_inSquare_T_11); // @[\\src\\main\\scala\\vga\\Ball.scala 58:104]
  assign io_inbound = $signed(_inSquare_T_7) < 12'sha & $signed(_inSquare_T_16) < 12'sha; // @[\\src\\main\\scala\\vga\\Ball.scala 58:76]
  assign io_outLeftBound = outLeftBound; // @[\\src\\main\\scala\\vga\\Ball.scala 67:19]
  assign io_outRightBound = outRightBound; // @[\\src\\main\\scala\\vga\\Ball.scala 66:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 18:26]
      ballSpeed <= 12'sh2; // @[\\src\\main\\scala\\vga\\Ball.scala 18:26]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 27:24]
      if (!($signed(velocity_0) < 12'sh0 & $signed(curPos_0) > 12'sh50 & $signed(curPos_0) < 12'sh64 & $signed(_T_18) < 12'sh28
        )) begin // @[\\src\\main\\scala\\vga\\Ball.scala 34:249]
        if ($signed(velocity_0) > 12'sh0 & $signed(curPos_0) > $signed(_GEN_17) & $signed(curPos_0) < $signed(_GEN_18)
           & $signed(_T_45) < 12'sh28) begin // @[\\src\\main\\scala\\vga\\Ball.scala 37:277]
          ballSpeed <= _ballSpeed_T_2; // @[\\src\\main\\scala\\vga\\Ball.scala 39:17]
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
      curPos_0 <= 12'sh140; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 27:24]
      if ($signed(velocity_0) < 12'sh0 & $signed(curPos_0) > 12'sh50 & $signed(curPos_0) < 12'sh64 & $signed(_T_18) < 12'sh28
        ) begin // @[\\src\\main\\scala\\vga\\Ball.scala 34:249]
        curPos_0 <= 12'sh64; // @[\\src\\main\\scala\\vga\\Ball.scala 36:17]
      end else if ($signed(velocity_0) > 12'sh0 & $signed(curPos_0) > $signed(_GEN_17) & $signed(curPos_0) < $signed(
        _GEN_18) & $signed(_T_45) < 12'sh28) begin // @[\\src\\main\\scala\\vga\\Ball.scala 37:277]
        curPos_0 <= {{1{_T_30[10]}},_T_30}; // @[\\src\\main\\scala\\vga\\Ball.scala 40:17]
      end else begin
        curPos_0 <= _curPos_0_T_2; // @[\\src\\main\\scala\\vga\\Ball.scala 30:15]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
      curPos_1 <= 12'shf0; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 27:24]
      curPos_1 <= _curPos_1_T_2; // @[\\src\\main\\scala\\vga\\Ball.scala 31:15]
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 21:25]
      velocity_0 <= 12'sh1; // @[\\src\\main\\scala\\vga\\Ball.scala 21:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 27:24]
      if ($signed(velocity_0) < 12'sh0 & $signed(curPos_0) > 12'sh50 & $signed(curPos_0) < 12'sh64 & $signed(_T_18) < 12'sh28
        ) begin // @[\\src\\main\\scala\\vga\\Ball.scala 34:249]
        velocity_0 <= ballSpeed; // @[\\src\\main\\scala\\vga\\Ball.scala 35:19]
      end else if ($signed(velocity_0) > 12'sh0 & $signed(curPos_0) > $signed(_GEN_17) & $signed(curPos_0) < $signed(
        _GEN_18) & $signed(_T_45) < 12'sh28) begin // @[\\src\\main\\scala\\vga\\Ball.scala 37:277]
        velocity_0 <= _velocity_1_T_7; // @[\\src\\main\\scala\\vga\\Ball.scala 38:19]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 21:25]
      velocity_1 <= 12'sh1; // @[\\src\\main\\scala\\vga\\Ball.scala 21:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 27:24]
      if ($signed(curPos_1) < 12'sha) begin // @[\\src\\main\\scala\\vga\\Ball.scala 29:23]
        velocity_1 <= ballSpeed;
      end else if ($signed(curPos_1) > $signed(_GEN_16)) begin // @[\\src\\main\\scala\\vga\\Ball.scala 29:77]
        velocity_1 <= _velocity_1_T_7;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 23:29]
      outLeftBound <= 1'h0; // @[\\src\\main\\scala\\vga\\Ball.scala 23:29]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 27:24]
      outLeftBound <= _T_49;
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 24:30]
      outRightBound <= 1'h0; // @[\\src\\main\\scala\\vga\\Ball.scala 24:30]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 27:24]
      outRightBound <= _T_48;
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
  ballSpeed = _RAND_0[11:0];
  _RAND_1 = {1{`RANDOM}};
  curPos_0 = _RAND_1[11:0];
  _RAND_2 = {1{`RANDOM}};
  curPos_1 = _RAND_2[11:0];
  _RAND_3 = {1{`RANDOM}};
  velocity_0 = _RAND_3[11:0];
  _RAND_4 = {1{`RANDOM}};
  velocity_1 = _RAND_4[11:0];
  _RAND_5 = {1{`RANDOM}};
  outLeftBound = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  outRightBound = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GraphicsProcessor(
  input         clock,
  output [1:0]  io_col_R, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  output [1:0]  io_col_G, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  output [1:0]  io_col_B, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  input  [11:0] io_indexX, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  input  [11:0] io_indexY, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  input         io_input1, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  input         io_input2, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  input         io_screenDone // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
);
  wire  P1_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:18]
  wire  P1_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:18]
  wire  P1_io_input; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:18]
  wire [11:0] P1_io_pos_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:18]
  wire [11:0] P1_io_pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:18]
  wire  P1_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:18]
  wire [11:0] P1_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:18]
  wire  P1_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:18]
  wire  P2_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P2_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P2_io_input; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire [11:0] P2_io_pos_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire [11:0] P2_io_pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P2_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire [11:0] P2_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P2_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  Ball_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:20]
  wire  Ball_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:20]
  wire [11:0] Ball_io_pos_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:20]
  wire [11:0] Ball_io_pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:20]
  wire  Ball_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:20]
  wire [11:0] Ball_io_P1Pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:20]
  wire [11:0] Ball_io_P2Pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:20]
  wire  Ball_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:20]
  wire  Ball_io_outLeftBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:20]
  wire  Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:20]
  wire [1:0] _GEN_2 = Ball_io_inbound ? 2'h3 : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 67:32 70:14 75:14]
  wire [1:0] _GEN_4 = P2_io_inbound ? 2'h3 : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 63:30 65:14]
  wire [1:0] _GEN_5 = P2_io_inbound ? 2'h0 : _GEN_2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 63:30 66:14]
  PaddleObj P1 ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 31:18]
    .clock(P1_clock),
    .reset(P1_reset),
    .io_input(P1_io_input),
    .io_pos_0(P1_io_pos_0),
    .io_pos_1(P1_io_pos_1),
    .io_inbound(P1_io_inbound),
    .io_paddlePos_1(P1_io_paddlePos_1),
    .io_updateLogic(P1_io_updateLogic)
  );
  PaddleObj_1 P2 ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
    .clock(P2_clock),
    .reset(P2_reset),
    .io_input(P2_io_input),
    .io_pos_0(P2_io_pos_0),
    .io_pos_1(P2_io_pos_1),
    .io_inbound(P2_io_inbound),
    .io_paddlePos_1(P2_io_paddlePos_1),
    .io_updateLogic(P2_io_updateLogic)
  );
  BallObj Ball ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:20]
    .clock(Ball_clock),
    .reset(Ball_reset),
    .io_pos_0(Ball_io_pos_0),
    .io_pos_1(Ball_io_pos_1),
    .io_inbound(Ball_io_inbound),
    .io_P1Pos_1(Ball_io_P1Pos_1),
    .io_P2Pos_1(Ball_io_P2Pos_1),
    .io_updateLogic(Ball_io_updateLogic),
    .io_outLeftBound(Ball_io_outLeftBound),
    .io_outRightBound(Ball_io_outRightBound)
  );
  assign io_col_R = P1_io_inbound ? 2'h3 : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 59:24 60:14]
  assign io_col_G = P1_io_inbound ? 2'h0 : _GEN_4; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 59:24 61:14]
  assign io_col_B = P1_io_inbound ? 2'h0 : _GEN_5; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 59:24 62:14]
  assign P1_clock = clock;
  assign P1_reset = Ball_io_outLeftBound | Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 48:30]
  assign P1_io_input = io_input1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:15]
  assign P1_io_pos_0 = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 29:36]
  assign P1_io_pos_1 = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 29:53]
  assign P1_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:21]
  assign P2_clock = clock;
  assign P2_reset = Ball_io_outLeftBound | Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 48:30]
  assign P2_io_input = io_input2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:15]
  assign P2_io_pos_0 = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 29:36]
  assign P2_io_pos_1 = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 29:53]
  assign P2_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 39:21]
  assign Ball_clock = clock;
  assign Ball_reset = Ball_io_outLeftBound | Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 48:30]
  assign Ball_io_pos_0 = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 29:36]
  assign Ball_io_pos_1 = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 29:53]
  assign Ball_io_P1Pos_1 = P1_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 42:17]
  assign Ball_io_P2Pos_1 = P2_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 43:17]
  assign Ball_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 45:23]
endmodule
module GraphicsManager(
  input        clock,
  output [1:0] io_col_R, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  output [1:0] io_col_G, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  output [1:0] io_col_B, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input  [9:0] io_indexX, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input  [9:0] io_indexY, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input        io_screenDone, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input        io_input1, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input        io_input2 // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
);
  wire  gpu_clock; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [1:0] gpu_io_col_R; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [1:0] gpu_io_col_G; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [1:0] gpu_io_col_B; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [11:0] gpu_io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [11:0] gpu_io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire  gpu_io_input1; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire  gpu_io_input2; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire  gpu_io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire  valid = io_indexY < 10'h1e0 & io_indexX < 10'h280; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 42:33]
  GraphicsProcessor gpu ( // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
    .clock(gpu_clock),
    .io_col_R(gpu_io_col_R),
    .io_col_G(gpu_io_col_G),
    .io_col_B(gpu_io_col_B),
    .io_indexX(gpu_io_indexX),
    .io_indexY(gpu_io_indexY),
    .io_input1(gpu_io_input1),
    .io_input2(gpu_io_input2),
    .io_screenDone(gpu_io_screenDone)
  );
  assign io_col_R = valid ? gpu_io_col_R : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 43:18]
  assign io_col_G = valid ? gpu_io_col_G : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 44:18]
  assign io_col_B = valid ? gpu_io_col_B : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 45:18]
  assign gpu_clock = clock;
  assign gpu_io_indexX = {{2'd0}, io_indexX}; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 33:17]
  assign gpu_io_indexY = {{2'd0}, io_indexY}; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 34:17]
  assign gpu_io_input1 = io_input1; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 36:17]
  assign gpu_io_input2 = io_input2; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 37:17]
  assign gpu_io_screenDone = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 35:21]
endmodule
module VGAModule(
  input        clock,
  input        reset,
  output [1:0] io_col_R, // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
  output [1:0] io_col_G, // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
  output [1:0] io_col_B, // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
  output       io_hsync, // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
  output       io_vsync, // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
  input        io_input1, // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
  input        io_input2 // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  slowClock_clock; // @[\\src\\main\\scala\\vga\\VGAModule.scala 20:25]
  wire  slowClock_reset; // @[\\src\\main\\scala\\vga\\VGAModule.scala 20:25]
  wire  slowClock_io_clk; // @[\\src\\main\\scala\\vga\\VGAModule.scala 20:25]
  wire  graphics_clock; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire [1:0] graphics_io_col_R; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire [1:0] graphics_io_col_G; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire [1:0] graphics_io_col_B; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire [9:0] graphics_io_indexX; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire [9:0] graphics_io_indexY; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire  graphics_io_screenDone; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire  graphics_io_input1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  wire  graphics_io_input2; // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
  reg [9:0] hCounter; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  wire  wrap_wrap = hCounter == 10'h31f; // @[src/main/scala/chisel3/util/Counter.scala 73:24]
  wire [9:0] _wrap_value_T_1 = hCounter + 10'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  wire  hWrap = slowClock_io_clk & wrap_wrap; // @[src/main/scala/chisel3/util/Counter.scala 118:{16,23} 117:24]
  wire  _T = hWrap & slowClock_io_clk; // @[\\src\\main\\scala\\vga\\VGAModule.scala 22:40]
  reg [9:0] vCounter; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  wire  wrap_wrap_1 = vCounter == 10'h20c; // @[src/main/scala/chisel3/util/Counter.scala 73:24]
  wire [9:0] _wrap_value_T_3 = vCounter + 10'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  ClockModule slowClock ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 20:25]
    .clock(slowClock_clock),
    .reset(slowClock_reset),
    .io_clk(slowClock_io_clk)
  );
  GraphicsManager graphics ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 26:24]
    .clock(graphics_clock),
    .io_col_R(graphics_io_col_R),
    .io_col_G(graphics_io_col_G),
    .io_col_B(graphics_io_col_B),
    .io_indexX(graphics_io_indexX),
    .io_indexY(graphics_io_indexY),
    .io_screenDone(graphics_io_screenDone),
    .io_input1(graphics_io_input1),
    .io_input2(graphics_io_input2)
  );
  assign io_col_R = graphics_io_col_R; // @[\\src\\main\\scala\\vga\\VGAModule.scala 34:12]
  assign io_col_G = graphics_io_col_G; // @[\\src\\main\\scala\\vga\\VGAModule.scala 35:12]
  assign io_col_B = graphics_io_col_B; // @[\\src\\main\\scala\\vga\\VGAModule.scala 36:12]
  assign io_hsync = hCounter > 10'h28f & hCounter < 10'h2f0 ? 1'h0 : 1'h1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 39:18]
  assign io_vsync = vCounter > 10'h1e9 & vCounter < 10'h1ec ? 1'h0 : 1'h1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 40:18]
  assign slowClock_clock = clock;
  assign slowClock_reset = reset;
  assign graphics_clock = clock;
  assign graphics_io_indexX = hCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:22]
  assign graphics_io_indexY = vCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:22]
  assign graphics_io_screenDone = _T & wrap_wrap_1; // @[src/main/scala/chisel3/util/Counter.scala 118:{16,23} 117:24]
  assign graphics_io_input1 = io_input1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 32:22]
  assign graphics_io_input2 = io_input2; // @[\\src\\main\\scala\\vga\\VGAModule.scala 33:22]
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

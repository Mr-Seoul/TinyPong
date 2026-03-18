module PaddleObj(
  input         clock,
  input         reset,
  input         io_input, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  input  [10:0] io_pos_0, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  input  [10:0] io_pos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output [10:0] io_paddlePos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output        io_sideX, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output [10:0] io_absX // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:24]
  reg [10:0] velocity; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:25]
  wire [9:0] bottomWall = 10'sh1e0 - 10'sh32; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 22:27]
  wire [4:0] _velocity_T_2 = 5'sh0 - 5'sha; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:19]
  wire [10:0] _GEN_5 = {{1{bottomWall[9]}},bottomWall}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 31:26]
  wire [10:0] _velocity_T_5 = $signed(velocity) + 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:28]
  wire [10:0] _GEN_0 = $signed(curPosY) == $signed(_GEN_5) ? $signed(11'sh0) : $signed(_velocity_T_5); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 31:42 32:16 34:16]
  wire [10:0] newPos = $signed(curPosY) + $signed(velocity); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:26]
  wire [10:0] diffX = $signed(io_pos_0) - 11'sh50; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 42:25]
  wire [10:0] _absX_T_3 = 11'sh0 - $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:20]
  wire [10:0] absX = $signed(diffX) < 11'sh0 ? $signed(_absX_T_3) : $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:24]
  wire [10:0] _absY_T_2 = $signed(io_pos_1) - $signed(curPosY); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:25]
  wire [10:0] _absY_T_6 = 11'sh0 - $signed(_absY_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:36]
  wire [10:0] absY = $signed(_absY_T_2) < 11'sh0 ? $signed(_absY_T_6) : $signed(_absY_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:40]
  assign io_inbound = absX < 11'hc & absY < 11'h32; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 47:54]
  assign io_paddlePos_1 = curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 53:{26,26}]
  assign io_sideX = diffX[10]; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 51:25]
  assign io_absX = $signed(diffX) < 11'sh0 ? $signed(_absX_T_3) : $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:24]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:24]
      curPosY <= 11'shf0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:24]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 25:25]
      if ($signed(newPos) > $signed(_GEN_5)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:19]
        curPosY <= {{1{bottomWall[9]}},bottomWall};
      end else if ($signed(newPos) < 11'sh32) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:55]
        curPosY <= 11'sh32;
      end else begin
        curPosY <= newPos;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:25]
      velocity <= 11'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 25:25]
      if (io_input) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:21]
        velocity <= {{6{_velocity_T_2[4]}},_velocity_T_2}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:16]
      end else if ($signed(curPosY) == 11'sh32) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:39]
        velocity <= 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 30:16]
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
  curPosY = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  velocity = _RAND_1[10:0];
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
  input         io_input, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  input  [10:0] io_pos_0, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  input  [10:0] io_pos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output [10:0] io_paddlePos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output        io_sideX, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output [10:0] io_absX // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:24]
  reg [10:0] velocity; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:25]
  wire [9:0] bottomWall = 10'sh1e0 - 10'sh32; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 22:27]
  wire [4:0] _velocity_T_2 = 5'sh0 - 5'sha; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:19]
  wire [10:0] _GEN_5 = {{1{bottomWall[9]}},bottomWall}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 31:26]
  wire [10:0] _velocity_T_5 = $signed(velocity) + 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:28]
  wire [10:0] _GEN_0 = $signed(curPosY) == $signed(_GEN_5) ? $signed(11'sh0) : $signed(_velocity_T_5); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 31:42 32:16 34:16]
  wire [10:0] newPos = $signed(curPosY) + $signed(velocity); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:26]
  wire [10:0] diffX = $signed(io_pos_0) - 11'sh230; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 42:25]
  wire [10:0] _absX_T_3 = 11'sh0 - $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:20]
  wire [10:0] absX = $signed(diffX) < 11'sh0 ? $signed(_absX_T_3) : $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:24]
  wire [10:0] _absY_T_2 = $signed(io_pos_1) - $signed(curPosY); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:25]
  wire [10:0] _absY_T_6 = 11'sh0 - $signed(_absY_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:36]
  wire [10:0] absY = $signed(_absY_T_2) < 11'sh0 ? $signed(_absY_T_6) : $signed(_absY_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:40]
  assign io_inbound = absX < 11'hc & absY < 11'h32; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 47:54]
  assign io_paddlePos_1 = curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 53:{26,26}]
  assign io_sideX = diffX[10]; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 51:25]
  assign io_absX = $signed(diffX) < 11'sh0 ? $signed(_absX_T_3) : $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:24]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:24]
      curPosY <= 11'shf0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:24]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 25:25]
      if ($signed(newPos) > $signed(_GEN_5)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:19]
        curPosY <= {{1{bottomWall[9]}},bottomWall};
      end else if ($signed(newPos) < 11'sh32) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:55]
        curPosY <= 11'sh32;
      end else begin
        curPosY <= newPos;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:25]
      velocity <= 11'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 25:25]
      if (io_input) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:21]
        velocity <= {{6{_velocity_T_2[4]}},_velocity_T_2}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:16]
      end else if ($signed(curPosY) == 11'sh32) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:39]
        velocity <= 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 30:16]
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
  curPosY = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  velocity = _RAND_1[10:0];
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
  input  [10:0] io_pos_0, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  input  [10:0] io_pos_1, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  input  [10:0] io_P1Pos_1, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
  input  [10:0] io_P2Pos_1, // @[\\src\\main\\scala\\vga\\Ball.scala 16:14]
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
`endif // RANDOMIZE_REG_INIT
  reg [5:0] ballSpeed; // @[\\src\\main\\scala\\vga\\Ball.scala 18:26]
  reg [10:0] curPos_0; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
  reg [10:0] curPos_1; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
  reg  goingRight; // @[\\src\\main\\scala\\vga\\Ball.scala 21:27]
  reg  goingDown; // @[\\src\\main\\scala\\vga\\Ball.scala 22:26]
  wire [9:0] _goingDown_T_3 = 10'sh1e0 - 10'sha; // @[\\src\\main\\scala\\vga\\Ball.scala 27:89]
  wire [10:0] _GEN_11 = {{1{_goingDown_T_3[9]}},_goingDown_T_3}; // @[\\src\\main\\scala\\vga\\Ball.scala 27:80]
  wire  _goingDown_T_5 = $signed(curPos_1) > $signed(_GEN_11) ? 1'h0 : goingDown; // @[\\src\\main\\scala\\vga\\Ball.scala 27:69]
  wire [10:0] _GEN_12 = {{5{ballSpeed[5]}},ballSpeed}; // @[\\src\\main\\scala\\vga\\Ball.scala 28:44]
  wire [10:0] _curPos_0_T_2 = $signed(curPos_0) + $signed(_GEN_12); // @[\\src\\main\\scala\\vga\\Ball.scala 28:44]
  wire [10:0] _curPos_0_T_5 = $signed(curPos_0) - $signed(_GEN_12); // @[\\src\\main\\scala\\vga\\Ball.scala 28:67]
  wire [10:0] _curPos_1_T_2 = $signed(curPos_1) + $signed(_GEN_12); // @[\\src\\main\\scala\\vga\\Ball.scala 29:43]
  wire [10:0] _curPos_1_T_5 = $signed(curPos_1) - $signed(_GEN_12); // @[\\src\\main\\scala\\vga\\Ball.scala 29:66]
  wire [10:0] _T_7 = $signed(io_P1Pos_1) - $signed(curPos_1); // @[\\src\\main\\scala\\vga\\Ball.scala 41:90]
  wire [10:0] _T_11 = 11'sh0 - $signed(_T_7); // @[\\src\\main\\scala\\vga\\Ball.scala 41:103]
  wire [10:0] _T_12 = $signed(_T_7) < 11'sh0 ? $signed(_T_11) : $signed(_T_7); // @[\\src\\main\\scala\\vga\\Ball.scala 41:103]
  wire  _goingDown_T_11 = ballSpeed[1] ^ ballSpeed[0] ^ goingDown ^ goingRight; // @[\\src\\main\\scala\\vga\\Ball.scala 43:55]
  wire [10:0] _T_21 = $signed(io_P2Pos_1) - $signed(curPos_1); // @[\\src\\main\\scala\\vga\\Ball.scala 44:95]
  wire [10:0] _T_25 = 11'sh0 - $signed(_T_21); // @[\\src\\main\\scala\\vga\\Ball.scala 44:108]
  wire [10:0] _T_26 = $signed(_T_21) < 11'sh0 ? $signed(_T_25) : $signed(_T_21); // @[\\src\\main\\scala\\vga\\Ball.scala 44:108]
  wire [5:0] _ballSpeed_T_2 = $signed(ballSpeed) + 6'sh1; // @[\\src\\main\\scala\\vga\\Ball.scala 47:30]
  wire  _GEN_0 = goingRight & $signed(curPos_0) < 11'sh246 & $signed(curPos_0) > 11'sh21a & $signed(_T_26) < 11'sh3c ? 1'h0
     : goingRight; // @[\\src\\main\\scala\\vga\\Ball.scala 44:128 45:18 21:27]
  wire  _GEN_1 = goingRight & $signed(curPos_0) < 11'sh246 & $signed(curPos_0) > 11'sh21a & $signed(_T_26) < 11'sh3c ?
    _goingDown_T_11 : $signed(curPos_1) < 11'sha | _goingDown_T_5; // @[\\src\\main\\scala\\vga\\Ball.scala 44:128 27:15 46:17]
  wire  _GEN_3 = ~goingRight & $signed(curPos_0) < 11'sh66 & $signed(curPos_0) > 11'sh3a & $signed(_T_12) < 11'sh3c |
    _GEN_0; // @[\\src\\main\\scala\\vga\\Ball.scala 41:123 42:18]
  wire  _GEN_4 = ~goingRight & $signed(curPos_0) < 11'sh66 & $signed(curPos_0) > 11'sh3a & $signed(_T_12) < 11'sh3c ?
    ballSpeed[1] ^ ballSpeed[0] ^ goingDown ^ goingRight : _GEN_1; // @[\\src\\main\\scala\\vga\\Ball.scala 41:123 43:17]
  wire  _GEN_6 = io_updateLogic ? _GEN_4 : goingDown; // @[\\src\\main\\scala\\vga\\Ball.scala 25:24 22:26]
  wire  _GEN_9 = io_updateLogic ? _GEN_3 : goingRight; // @[\\src\\main\\scala\\vga\\Ball.scala 25:24 21:27]
  wire [10:0] diffX = $signed(io_pos_0) - $signed(curPos_0); // @[\\src\\main\\scala\\vga\\Ball.scala 52:25]
  wire [10:0] diffY = $signed(io_pos_1) - $signed(curPos_1); // @[\\src\\main\\scala\\vga\\Ball.scala 53:25]
  wire [10:0] _absX_T_3 = 11'sh0 - $signed(diffX); // @[\\src\\main\\scala\\vga\\Ball.scala 54:20]
  wire [10:0] absX = $signed(diffX) < 11'sh0 ? $signed(_absX_T_3) : $signed(diffX); // @[\\src\\main\\scala\\vga\\Ball.scala 54:24]
  wire [10:0] _absY_T_3 = 11'sh0 - $signed(diffY); // @[\\src\\main\\scala\\vga\\Ball.scala 55:20]
  wire [10:0] absY = $signed(diffY) < 11'sh0 ? $signed(_absY_T_3) : $signed(diffY); // @[\\src\\main\\scala\\vga\\Ball.scala 55:24]
  wire  inSquare = absX < 11'ha & absY < 11'ha; // @[\\src\\main\\scala\\vga\\Ball.scala 56:53]
  wire [10:0] _inDiamond_T_1 = absX + absY; // @[\\src\\main\\scala\\vga\\Ball.scala 57:24]
  wire  inDiamond = _inDiamond_T_1 < 11'hf; // @[\\src\\main\\scala\\vga\\Ball.scala 57:31]
  assign io_inbound = inSquare & inDiamond; // @[\\src\\main\\scala\\vga\\Ball.scala 59:26]
  assign io_outLeftBound = $signed(curPos_0) < 11'sh0; // @[\\src\\main\\scala\\vga\\Ball.scala 63:32]
  assign io_outRightBound = $signed(curPos_0) > 11'sh280; // @[\\src\\main\\scala\\vga\\Ball.scala 62:33]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 18:26]
      ballSpeed <= 6'sh2; // @[\\src\\main\\scala\\vga\\Ball.scala 18:26]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 25:24]
      if (!(~goingRight & $signed(curPos_0) < 11'sh66 & $signed(curPos_0) > 11'sh3a & $signed(_T_12) < 11'sh3c)) begin // @[\\src\\main\\scala\\vga\\Ball.scala 41:123]
        if (goingRight & $signed(curPos_0) < 11'sh246 & $signed(curPos_0) > 11'sh21a & $signed(_T_26) < 11'sh3c) begin // @[\\src\\main\\scala\\vga\\Ball.scala 44:128]
          ballSpeed <= _ballSpeed_T_2; // @[\\src\\main\\scala\\vga\\Ball.scala 47:17]
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
      curPos_0 <= 11'sh140; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 25:24]
      if (goingRight) begin // @[\\src\\main\\scala\\vga\\Ball.scala 28:21]
        curPos_0 <= _curPos_0_T_2;
      end else begin
        curPos_0 <= _curPos_0_T_5;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
      curPos_1 <= 11'shf0; // @[\\src\\main\\scala\\vga\\Ball.scala 20:23]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 25:24]
      if (goingDown) begin // @[\\src\\main\\scala\\vga\\Ball.scala 29:21]
        curPos_1 <= _curPos_1_T_2;
      end else begin
        curPos_1 <= _curPos_1_T_5;
      end
    end
    goingRight <= reset | _GEN_9; // @[\\src\\main\\scala\\vga\\Ball.scala 21:{27,27}]
    goingDown <= reset | _GEN_6; // @[\\src\\main\\scala\\vga\\Ball.scala 22:{26,26}]
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
  ballSpeed = _RAND_0[5:0];
  _RAND_1 = {1{`RANDOM}};
  curPos_0 = _RAND_1[10:0];
  _RAND_2 = {1{`RANDOM}};
  curPos_1 = _RAND_2[10:0];
  _RAND_3 = {1{`RANDOM}};
  goingRight = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  goingDown = _RAND_4[0:0];
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
  output [1:0]  io_col_R, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  output [1:0]  io_col_G, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  output [1:0]  io_col_B, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  input  [10:0] io_indexX, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  input  [10:0] io_indexY, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  input         io_input1, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  input         io_input2, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
  input         io_screenDone // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 32:14]
);
  wire  P1_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P1_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P1_io_input; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire [10:0] P1_io_pos_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire [10:0] P1_io_pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P1_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire [10:0] P1_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P1_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P1_io_sideX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire [10:0] P1_io_absX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
  wire  P2_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_io_input; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire [10:0] P2_io_pos_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire [10:0] P2_io_pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire [10:0] P2_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_io_sideX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire [10:0] P2_io_absX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  Ball_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  Ball_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire [10:0] Ball_io_pos_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire [10:0] Ball_io_pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  Ball_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire [10:0] Ball_io_P1Pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire [10:0] Ball_io_P2Pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  Ball_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  Ball_io_outLeftBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  XOR0 = io_indexX[0] ^ io_indexY[0]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 58:27]
  wire  XOR1 = io_indexX[1] ^ io_indexY[1]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 59:27]
  wire  XOR2 = io_indexX[2] ^ io_indexY[2]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 60:27]
  wire  XOR3 = io_indexX[3] ^ io_indexY[3]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 61:27]
  wire  XOR4 = io_indexX[4] ^ io_indexY[4]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 62:27]
  wire  XOR5 = io_indexX[5] ^ io_indexY[5]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 63:27]
  wire [3:0] BaysianDither = {io_indexY[0],XOR1,io_indexY[1],XOR0}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:68]
  wire [10:0] _GEN_4 = P2_io_inbound ? P2_io_absX : 11'h0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 76:30 77:15]
  wire [10:0] inputAbsX = P1_io_inbound ? P1_io_absX : _GEN_4; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 71:24 72:15]
  wire [10:0] _GEN_12 = {{7'd0}, BaysianDither}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 69:28]
  wire  dithered = inputAbsX <= _GEN_12; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 69:28]
  wire [1:0] _io_col_R_T = {dithered,dithered}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 73:20]
  wire [1:0] _io_col_R_T_2 = ~P1_io_sideX ? 2'h3 : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 73:46]
  wire [1:0] _io_col_R_T_3 = _io_col_R_T | _io_col_R_T_2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 73:40]
  wire [1:0] _io_col_G_T_1 = P2_io_sideX ? 2'h3 : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 79:46]
  wire [1:0] _io_col_G_T_2 = _io_col_R_T | _io_col_G_T_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 79:40]
  wire  _io_col_G_T_3 = XOR4 ^ XOR1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 90:24]
  wire  _io_col_B_T = XOR3 ^ XOR0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 91:24]
  wire  _GEN_1 = Ball_io_inbound ? 1'h0 : XOR5 ^ XOR2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 81:32 83:14 89:14]
  wire [1:0] _GEN_2 = Ball_io_inbound ? 2'h3 : {{1'd0}, _io_col_G_T_3}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 81:32 84:14 90:14]
  wire [1:0] _GEN_3 = Ball_io_inbound ? 2'h3 : {{1'd0}, _io_col_B_T}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 81:32 85:14 91:14]
  wire  _GEN_5 = P2_io_inbound ? 1'h0 : _GEN_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 76:30 78:14]
  wire [1:0] _GEN_6 = P2_io_inbound ? _io_col_G_T_2 : _GEN_2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 76:30 79:14]
  wire [1:0] _GEN_7 = P2_io_inbound ? 2'h0 : _GEN_3; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 76:30 80:14]
  PaddleObj P1 ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
    .clock(P1_clock),
    .reset(P1_reset),
    .io_input(P1_io_input),
    .io_pos_0(P1_io_pos_0),
    .io_pos_1(P1_io_pos_1),
    .io_inbound(P1_io_inbound),
    .io_paddlePos_1(P1_io_paddlePos_1),
    .io_updateLogic(P1_io_updateLogic),
    .io_sideX(P1_io_sideX),
    .io_absX(P1_io_absX)
  );
  PaddleObj_1 P2 ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
    .clock(P2_clock),
    .reset(P2_reset),
    .io_input(P2_io_input),
    .io_pos_0(P2_io_pos_0),
    .io_pos_1(P2_io_pos_1),
    .io_inbound(P2_io_inbound),
    .io_paddlePos_1(P2_io_paddlePos_1),
    .io_updateLogic(P2_io_updateLogic),
    .io_sideX(P2_io_sideX),
    .io_absX(P2_io_absX)
  );
  BallObj Ball ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
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
  assign io_col_R = P1_io_inbound ? _io_col_R_T_3 : {{1'd0}, _GEN_5}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 71:24 73:14]
  assign io_col_G = P1_io_inbound ? 2'h0 : _GEN_6; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 71:24 74:14]
  assign io_col_B = P1_io_inbound ? 2'h0 : _GEN_7; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 71:24 75:14]
  assign P1_clock = clock;
  assign P1_reset = Ball_io_outLeftBound | Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 53:46]
  assign P1_io_input = io_input1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:15]
  assign P1_io_pos_0 = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:36]
  assign P1_io_pos_1 = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:53]
  assign P1_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 39:21]
  assign P2_clock = clock;
  assign P2_reset = Ball_io_outLeftBound | Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 53:46]
  assign P2_io_input = io_input2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 42:15]
  assign P2_io_pos_0 = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:36]
  assign P2_io_pos_1 = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:53]
  assign P2_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 44:21]
  assign Ball_clock = clock;
  assign Ball_reset = Ball_io_outLeftBound | Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 53:46]
  assign Ball_io_pos_0 = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:36]
  assign Ball_io_pos_1 = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:53]
  assign Ball_io_P1Pos_1 = P1_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 47:17]
  assign Ball_io_P2Pos_1 = P2_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 48:17]
  assign Ball_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 50:23]
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
  wire [10:0] gpu_io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [10:0] gpu_io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
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
  assign gpu_io_indexX = {{1'd0}, io_indexX}; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 33:17]
  assign gpu_io_indexY = {{1'd0}, io_indexY}; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 34:17]
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
  wire  graphics_clock; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire [1:0] graphics_io_col_R; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire [1:0] graphics_io_col_G; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire [1:0] graphics_io_col_B; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire [9:0] graphics_io_indexX; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire [9:0] graphics_io_indexY; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire  graphics_io_screenDone; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire  graphics_io_input1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  wire  graphics_io_input2; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
  reg [9:0] hCounter; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  wire  wrap_wrap = hCounter == 10'h31f; // @[src/main/scala/chisel3/util/Counter.scala 73:24]
  wire [9:0] _wrap_value_T_1 = hCounter + 10'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  reg [9:0] vCounter; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  wire  wrap_wrap_1 = vCounter == 10'h20c; // @[src/main/scala/chisel3/util/Counter.scala 73:24]
  wire [9:0] _wrap_value_T_3 = vCounter + 10'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  GraphicsManager graphics ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:24]
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
  assign io_col_R = graphics_io_col_R; // @[\\src\\main\\scala\\vga\\VGAModule.scala 37:12]
  assign io_col_G = graphics_io_col_G; // @[\\src\\main\\scala\\vga\\VGAModule.scala 38:12]
  assign io_col_B = graphics_io_col_B; // @[\\src\\main\\scala\\vga\\VGAModule.scala 39:12]
  assign io_hsync = hCounter > 10'h28f & hCounter < 10'h2f0 ? 1'h0 : 1'h1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 42:18]
  assign io_vsync = vCounter > 10'h1e9 & vCounter < 10'h1ec ? 1'h0 : 1'h1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 43:18]
  assign graphics_clock = clock;
  assign graphics_io_indexX = hCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 32:22]
  assign graphics_io_indexY = vCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 33:22]
  assign graphics_io_screenDone = wrap_wrap & wrap_wrap_1; // @[src/main/scala/chisel3/util/Counter.scala 118:{16,23} 117:24]
  assign graphics_io_input1 = io_input1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 35:22]
  assign graphics_io_input2 = io_input2; // @[\\src\\main\\scala\\vga\\VGAModule.scala 36:22]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      hCounter <= 10'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (wrap_wrap) begin // @[src/main/scala/chisel3/util/Counter.scala 87:20]
      hCounter <= 10'h0; // @[src/main/scala/chisel3/util/Counter.scala 87:28]
    end else begin
      hCounter <= _wrap_value_T_1; // @[src/main/scala/chisel3/util/Counter.scala 77:15]
    end
    if (reset) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      vCounter <= 10'h0; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
    end else if (wrap_wrap) begin // @[src/main/scala/chisel3/util/Counter.scala 118:16]
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

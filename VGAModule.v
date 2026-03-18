module PaddleObj(
  input         clock,
  input         reset,
  input         io_input, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input  [10:0] io_pos_0, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input  [10:0] io_pos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output [10:0] io_paddlePos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output        io_sideX // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
  reg [10:0] velocity; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
  wire [9:0] bottomWall = 10'sh1e0 - 10'sh28; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 21:27]
  wire [4:0] _velocity_T_2 = 5'sh0 - 5'sha; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:19]
  wire [10:0] _GEN_5 = {{1{bottomWall[9]}},bottomWall}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:26]
  wire [10:0] _velocity_T_5 = $signed(velocity) + 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 33:28]
  wire [10:0] _GEN_0 = $signed(curPosY) == 11'sh28 ? $signed(11'sh0) : $signed(_velocity_T_5); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 30:39 31:16 33:16]
  wire [10:0] newPos = $signed(curPosY) + $signed(velocity); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 37:26]
  wire [10:0] diffX = $signed(io_pos_0) - 11'sh50; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 41:25]
  wire [10:0] _absX_T_3 = 11'sh0 - $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 42:20]
  wire [10:0] absX = $signed(diffX) < 11'sh0 ? $signed(_absX_T_3) : $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 42:20]
  wire [10:0] _absY_T_2 = $signed(io_pos_1) - $signed(curPosY); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:25]
  wire [10:0] _absY_T_6 = 11'sh0 - $signed(_absY_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:36]
  wire [10:0] absY = $signed(_absY_T_2) < 11'sh0 ? $signed(_absY_T_6) : $signed(_absY_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:36]
  assign io_inbound = $signed(absX) < 11'sha & $signed(absY) < 11'sh28; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:54]
  assign io_paddlePos_1 = curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 51:{26,26}]
  assign io_sideX = diffX[10]; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 49:25]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
      curPosY <= 11'shf0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 24:25]
      if ($signed(newPos) > $signed(_GEN_5)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:19]
        curPosY <= {{1{bottomWall[9]}},bottomWall};
      end else if ($signed(newPos) < 11'sh28) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:55]
        curPosY <= 11'sh28;
      end else begin
        curPosY <= newPos;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
      velocity <= 11'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 24:25]
      if (io_input) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:21]
        velocity <= {{6{_velocity_T_2[4]}},_velocity_T_2}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:16]
      end else if ($signed(curPosY) == $signed(_GEN_5)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:42]
        velocity <= 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:16]
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
  input         io_input, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input  [10:0] io_pos_0, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input  [10:0] io_pos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output [10:0] io_paddlePos_1, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
  output        io_sideX // @[\\src\\main\\scala\\vga\\PaddleObj.scala 15:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
  reg [10:0] velocity; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
  wire [9:0] bottomWall = 10'sh1e0 - 10'sh28; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 21:27]
  wire [4:0] _velocity_T_2 = 5'sh0 - 5'sha; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:19]
  wire [10:0] _GEN_5 = {{1{bottomWall[9]}},bottomWall}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:26]
  wire [10:0] _velocity_T_5 = $signed(velocity) + 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 33:28]
  wire [10:0] _GEN_0 = $signed(curPosY) == 11'sh28 ? $signed(11'sh0) : $signed(_velocity_T_5); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 30:39 31:16 33:16]
  wire [10:0] newPos = $signed(curPosY) + $signed(velocity); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 37:26]
  wire [10:0] diffX = $signed(io_pos_0) - 11'sh230; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 41:25]
  wire [10:0] _absX_T_3 = 11'sh0 - $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 42:20]
  wire [10:0] absX = $signed(diffX) < 11'sh0 ? $signed(_absX_T_3) : $signed(diffX); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 42:20]
  wire [10:0] _absY_T_2 = $signed(io_pos_1) - $signed(curPosY); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:25]
  wire [10:0] _absY_T_6 = 11'sh0 - $signed(_absY_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:36]
  wire [10:0] absY = $signed(_absY_T_2) < 11'sh0 ? $signed(_absY_T_6) : $signed(_absY_T_2); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:36]
  assign io_inbound = $signed(absX) < 11'sha & $signed(absY) < 11'sh28; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:54]
  assign io_paddlePos_1 = curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 51:{26,26}]
  assign io_sideX = diffX[10]; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 49:25]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
      curPosY <= 11'shf0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 18:24]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 24:25]
      if ($signed(newPos) > $signed(_GEN_5)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:19]
        curPosY <= {{1{bottomWall[9]}},bottomWall};
      end else if ($signed(newPos) < 11'sh28) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:55]
        curPosY <= 11'sh28;
      end else begin
        curPosY <= newPos;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
      velocity <= 11'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 24:25]
      if (io_input) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 26:21]
        velocity <= {{6{_velocity_T_2[4]}},_velocity_T_2}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:16]
      end else if ($signed(curPosY) == $signed(_GEN_5)) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:42]
        velocity <= 11'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:16]
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
  input  [10:0] io_pos_0, // @[\\src\\main\\scala\\vga\\Ball.scala 18:14]
  input  [10:0] io_pos_1, // @[\\src\\main\\scala\\vga\\Ball.scala 18:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\Ball.scala 18:14]
  input  [10:0] io_P1Pos_1, // @[\\src\\main\\scala\\vga\\Ball.scala 18:14]
  input  [10:0] io_P2Pos_1, // @[\\src\\main\\scala\\vga\\Ball.scala 18:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\Ball.scala 18:14]
  output        io_outLeftBound, // @[\\src\\main\\scala\\vga\\Ball.scala 18:14]
  output        io_outRightBound, // @[\\src\\main\\scala\\vga\\Ball.scala 18:14]
  output        io_sideX, // @[\\src\\main\\scala\\vga\\Ball.scala 18:14]
  output        io_sideY // @[\\src\\main\\scala\\vga\\Ball.scala 18:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [10:0] ballSpeed; // @[\\src\\main\\scala\\vga\\Ball.scala 20:26]
  reg [10:0] curPos_0; // @[\\src\\main\\scala\\vga\\Ball.scala 22:23]
  reg [10:0] curPos_1; // @[\\src\\main\\scala\\vga\\Ball.scala 22:23]
  reg [10:0] velocity_0; // @[\\src\\main\\scala\\vga\\Ball.scala 23:25]
  reg [10:0] velocity_1; // @[\\src\\main\\scala\\vga\\Ball.scala 23:25]
  wire [9:0] _velocity_1_T_3 = 10'sh1e0 - 10'sha; // @[\\src\\main\\scala\\vga\\Ball.scala 28:97]
  wire [10:0] _GEN_13 = {{1{_velocity_1_T_3[9]}},_velocity_1_T_3}; // @[\\src\\main\\scala\\vga\\Ball.scala 28:88]
  wire [10:0] _velocity_1_T_7 = 11'sh0 - $signed(ballSpeed); // @[\\src\\main\\scala\\vga\\Ball.scala 28:127]
  wire [10:0] _velocity_1_T_8 = $signed(curPos_1) > $signed(_GEN_13) ? $signed(_velocity_1_T_7) : $signed(velocity_1); // @[\\src\\main\\scala\\vga\\Ball.scala 28:77]
  wire [10:0] _velocity_1_T_9 = $signed(curPos_1) < 11'sha ? $signed(ballSpeed) : $signed(_velocity_1_T_8); // @[\\src\\main\\scala\\vga\\Ball.scala 28:23]
  wire [10:0] _curPos_0_T_2 = $signed(curPos_0) + $signed(velocity_0); // @[\\src\\main\\scala\\vga\\Ball.scala 29:28]
  wire [10:0] _curPos_1_T_2 = $signed(curPos_1) + $signed(velocity_1); // @[\\src\\main\\scala\\vga\\Ball.scala 30:28]
  wire [10:0] newYSpeed = velocity_1[0] ^ velocity_0[1] ? $signed(ballSpeed) : $signed(_velocity_1_T_7); // @[\\src\\main\\scala\\vga\\Ball.scala 32:24]
  wire  goingLeft = $signed(velocity_0) < 11'sh0; // @[\\src\\main\\scala\\vga\\Ball.scala 35:33]
  wire [7:0] _rightPaddledist_T = 3'sh2 * 5'sha; // @[\\src\\main\\scala\\vga\\Ball.scala 36:72]
  wire [7:0] _rightPaddledist_T_3 = 8'sh50 + $signed(_rightPaddledist_T); // @[\\src\\main\\scala\\vga\\Ball.scala 36:67]
  wire [7:0] _rightPaddledist_T_6 = $signed(_rightPaddledist_T_3) + 8'sha; // @[\\src\\main\\scala\\vga\\Ball.scala 36:100]
  wire [10:0] _GEN_14 = {{3{_rightPaddledist_T_6[7]}},_rightPaddledist_T_6}; // @[\\src\\main\\scala\\vga\\Ball.scala 36:34]
  wire [10:0] _rightPaddledist_T_9 = 11'sh280 - $signed(_GEN_14); // @[\\src\\main\\scala\\vga\\Ball.scala 36:34]
  wire [10:0] rightPaddledist = $signed(_rightPaddledist_T_9) - $signed(curPos_0); // @[\\src\\main\\scala\\vga\\Ball.scala 36:130]
  wire [10:0] leftPaddledist = $signed(curPos_0) - $signed(_GEN_14); // @[\\src\\main\\scala\\vga\\Ball.scala 37:36]
  wire [10:0] _T_6 = $signed(io_P1Pos_1) - $signed(curPos_1); // @[\\src\\main\\scala\\vga\\Ball.scala 38:144]
  wire [10:0] _T_10 = 11'sh0 - $signed(_T_6); // @[\\src\\main\\scala\\vga\\Ball.scala 38:157]
  wire [10:0] _T_11 = $signed(_T_6) < 11'sh0 ? $signed(_T_10) : $signed(_T_6); // @[\\src\\main\\scala\\vga\\Ball.scala 38:157]
  wire [10:0] _T_21 = $signed(io_P2Pos_1) - $signed(curPos_1); // @[\\src\\main\\scala\\vga\\Ball.scala 42:153]
  wire [10:0] _T_25 = 11'sh0 - $signed(_T_21); // @[\\src\\main\\scala\\vga\\Ball.scala 42:166]
  wire [10:0] _T_26 = $signed(_T_21) < 11'sh0 ? $signed(_T_25) : $signed(_T_21); // @[\\src\\main\\scala\\vga\\Ball.scala 42:166]
  wire [10:0] _ballSpeed_T_2 = $signed(ballSpeed) + 11'sh1; // @[\\src\\main\\scala\\vga\\Ball.scala 45:30]
  wire [10:0] _curPos_0_T_17 = 11'sh280 - 11'sh64; // @[\\src\\main\\scala\\vga\\Ball.scala 46:26]
  wire [10:0] diffX = $signed(io_pos_0) - $signed(curPos_0); // @[\\src\\main\\scala\\vga\\Ball.scala 54:25]
  wire [10:0] diffY = $signed(io_pos_1) - $signed(curPos_1); // @[\\src\\main\\scala\\vga\\Ball.scala 55:25]
  wire [10:0] _absX_T_3 = 11'sh0 - $signed(diffX); // @[\\src\\main\\scala\\vga\\Ball.scala 56:20]
  wire [10:0] absX = $signed(diffX) < 11'sh0 ? $signed(_absX_T_3) : $signed(diffX); // @[\\src\\main\\scala\\vga\\Ball.scala 56:20]
  wire [10:0] _absY_T_3 = 11'sh0 - $signed(diffY); // @[\\src\\main\\scala\\vga\\Ball.scala 57:20]
  wire [10:0] absY = $signed(diffY) < 11'sh0 ? $signed(_absY_T_3) : $signed(diffY); // @[\\src\\main\\scala\\vga\\Ball.scala 57:20]
  wire  inSquare = $signed(absX) < 11'sha & $signed(absY) < 11'sha; // @[\\src\\main\\scala\\vga\\Ball.scala 58:53]
  wire [10:0] _inDiamond_T_2 = $signed(absX) + $signed(absY); // @[\\src\\main\\scala\\vga\\Ball.scala 59:24]
  wire  inDiamond = $signed(_inDiamond_T_2) < 11'shf; // @[\\src\\main\\scala\\vga\\Ball.scala 59:31]
  assign io_inbound = inSquare & inDiamond; // @[\\src\\main\\scala\\vga\\Ball.scala 61:26]
  assign io_outLeftBound = $signed(curPos_0) < 11'sh0; // @[\\src\\main\\scala\\vga\\Ball.scala 67:32]
  assign io_outRightBound = $signed(curPos_0) > 11'sh280; // @[\\src\\main\\scala\\vga\\Ball.scala 66:33]
  assign io_sideX = diffX[10]; // @[\\src\\main\\scala\\vga\\Ball.scala 62:25]
  assign io_sideY = diffY[10]; // @[\\src\\main\\scala\\vga\\Ball.scala 63:25]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 20:26]
      ballSpeed <= 11'sh2; // @[\\src\\main\\scala\\vga\\Ball.scala 20:26]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 26:24]
      if (!(goingLeft & $signed(leftPaddledist) > 11'sh28 & $signed(leftPaddledist) < 11'sh0 & $signed(_T_11) < 11'sh28
        )) begin // @[\\src\\main\\scala\\vga\\Ball.scala 38:193]
        if (~goingLeft & $signed(rightPaddledist) > 11'sh28 & $signed(rightPaddledist) < 11'sh0 & $signed(_T_26) < 11'sh28
          ) begin // @[\\src\\main\\scala\\vga\\Ball.scala 42:202]
          ballSpeed <= _ballSpeed_T_2; // @[\\src\\main\\scala\\vga\\Ball.scala 45:17]
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 22:23]
      curPos_0 <= 11'sh140; // @[\\src\\main\\scala\\vga\\Ball.scala 22:23]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 26:24]
      if (goingLeft & $signed(leftPaddledist) > 11'sh28 & $signed(leftPaddledist) < 11'sh0 & $signed(_T_11) < 11'sh28
        ) begin // @[\\src\\main\\scala\\vga\\Ball.scala 38:193]
        curPos_0 <= 11'sh64; // @[\\src\\main\\scala\\vga\\Ball.scala 41:17]
      end else if (~goingLeft & $signed(rightPaddledist) > 11'sh28 & $signed(rightPaddledist) < 11'sh0 & $signed(_T_26)
         < 11'sh28) begin // @[\\src\\main\\scala\\vga\\Ball.scala 42:202]
        curPos_0 <= _curPos_0_T_17; // @[\\src\\main\\scala\\vga\\Ball.scala 46:17]
      end else begin
        curPos_0 <= _curPos_0_T_2; // @[\\src\\main\\scala\\vga\\Ball.scala 29:15]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 22:23]
      curPos_1 <= 11'shf0; // @[\\src\\main\\scala\\vga\\Ball.scala 22:23]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 26:24]
      curPos_1 <= _curPos_1_T_2; // @[\\src\\main\\scala\\vga\\Ball.scala 30:15]
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 23:25]
      velocity_0 <= 11'sh1; // @[\\src\\main\\scala\\vga\\Ball.scala 23:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 26:24]
      if (goingLeft & $signed(leftPaddledist) > 11'sh28 & $signed(leftPaddledist) < 11'sh0 & $signed(_T_11) < 11'sh28
        ) begin // @[\\src\\main\\scala\\vga\\Ball.scala 38:193]
        velocity_0 <= ballSpeed; // @[\\src\\main\\scala\\vga\\Ball.scala 39:19]
      end else if (~goingLeft & $signed(rightPaddledist) > 11'sh28 & $signed(rightPaddledist) < 11'sh0 & $signed(_T_26)
         < 11'sh28) begin // @[\\src\\main\\scala\\vga\\Ball.scala 42:202]
        velocity_0 <= _velocity_1_T_7; // @[\\src\\main\\scala\\vga\\Ball.scala 43:19]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 23:25]
      velocity_1 <= 11'sh1; // @[\\src\\main\\scala\\vga\\Ball.scala 23:25]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 26:24]
      if (goingLeft & $signed(leftPaddledist) > 11'sh28 & $signed(leftPaddledist) < 11'sh0 & $signed(_T_11) < 11'sh28
        ) begin // @[\\src\\main\\scala\\vga\\Ball.scala 38:193]
        velocity_1 <= newYSpeed; // @[\\src\\main\\scala\\vga\\Ball.scala 40:19]
      end else if (~goingLeft & $signed(rightPaddledist) > 11'sh28 & $signed(rightPaddledist) < 11'sh0 & $signed(_T_26)
         < 11'sh28) begin // @[\\src\\main\\scala\\vga\\Ball.scala 42:202]
        velocity_1 <= newYSpeed; // @[\\src\\main\\scala\\vga\\Ball.scala 44:19]
      end else begin
        velocity_1 <= _velocity_1_T_9; // @[\\src\\main\\scala\\vga\\Ball.scala 28:17]
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
  ballSpeed = _RAND_0[10:0];
  _RAND_1 = {1{`RANDOM}};
  curPos_0 = _RAND_1[10:0];
  _RAND_2 = {1{`RANDOM}};
  curPos_1 = _RAND_2[10:0];
  _RAND_3 = {1{`RANDOM}};
  velocity_0 = _RAND_3[10:0];
  _RAND_4 = {1{`RANDOM}};
  velocity_1 = _RAND_4[10:0];
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
  wire  P2_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_io_input; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire [10:0] P2_io_pos_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire [10:0] P2_io_pos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire [10:0] P2_io_paddlePos_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
  wire  P2_io_sideX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:18]
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
  wire  Ball_io_sideX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  Ball_io_sideY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:20]
  wire  dithered = io_indexX[2] ^ io_indexY[2]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 59:31]
  wire  circleShadow = Ball_io_sideX | ~Ball_io_sideY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 60:36]
  wire [1:0] _io_col_R_T = P1_io_sideX ? 2'h3 : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 63:32]
  wire [1:0] _GEN_9 = {{1'd0}, dithered}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 63:26]
  wire [1:0] _io_col_R_T_1 = _GEN_9 | _io_col_R_T; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 63:26]
  wire [1:0] _io_col_G_T_1 = ~P2_io_sideX ? 2'h3 : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 68:32]
  wire [1:0] _io_col_G_T_2 = _GEN_9 | _io_col_G_T_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 68:26]
  wire [1:0] _io_col_B_T = circleShadow ? 2'h3 : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 73:32]
  wire [1:0] _io_col_B_T_1 = _GEN_9 | _io_col_B_T; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 73:26]
  wire  _io_col_B_T_8 = io_indexX[3] ^ io_indexY[3] ^ (io_indexX[0] ^ io_indexY[0]); // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 78:47]
  wire  _GEN_0 = Ball_io_inbound ? 1'h0 : io_indexX[5] ^ io_indexY[5] ^ dithered; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 70:32 71:14 76:14]
  wire  _GEN_1 = Ball_io_inbound ? 1'h0 : io_indexX[4] ^ io_indexY[4] ^ (io_indexX[1] ^ io_indexY[1]); // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 70:32 72:14 77:14]
  wire [1:0] _GEN_2 = Ball_io_inbound ? _io_col_B_T_1 : {{1'd0}, _io_col_B_T_8}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 70:32 73:14 78:14]
  wire  _GEN_3 = P2_io_inbound ? 1'h0 : _GEN_0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:30 67:14]
  wire [1:0] _GEN_4 = P2_io_inbound ? _io_col_G_T_2 : {{1'd0}, _GEN_1}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:30 68:14]
  wire [1:0] _GEN_5 = P2_io_inbound ? 2'h0 : _GEN_2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:30 69:14]
  PaddleObj P1 ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 36:18]
    .clock(P1_clock),
    .reset(P1_reset),
    .io_input(P1_io_input),
    .io_pos_0(P1_io_pos_0),
    .io_pos_1(P1_io_pos_1),
    .io_inbound(P1_io_inbound),
    .io_paddlePos_1(P1_io_paddlePos_1),
    .io_updateLogic(P1_io_updateLogic),
    .io_sideX(P1_io_sideX)
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
    .io_sideX(P2_io_sideX)
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
    .io_outRightBound(Ball_io_outRightBound),
    .io_sideX(Ball_io_sideX),
    .io_sideY(Ball_io_sideY)
  );
  assign io_col_R = P1_io_inbound ? _io_col_R_T_1 : {{1'd0}, _GEN_3}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 62:24 63:14]
  assign io_col_G = P1_io_inbound ? 2'h0 : _GEN_4; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 62:24 64:14]
  assign io_col_B = P1_io_inbound ? 2'h0 : _GEN_5; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 62:24 65:14]
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
  reg [9:0] vCounter; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  wire  wrap_wrap_1 = vCounter == 10'h20c; // @[src/main/scala/chisel3/util/Counter.scala 73:24]
  wire [9:0] _wrap_value_T_3 = vCounter + 10'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
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
  assign graphics_clock = clock;
  assign graphics_io_indexX = hCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 29:22]
  assign graphics_io_indexY = vCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:22]
  assign graphics_io_screenDone = wrap_wrap & wrap_wrap_1; // @[src/main/scala/chisel3/util/Counter.scala 118:{16,23} 117:24]
  assign graphics_io_input1 = io_input1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 32:22]
  assign graphics_io_input2 = io_input2; // @[\\src\\main\\scala\\vga\\VGAModule.scala 33:22]
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

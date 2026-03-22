module resetSynchronizer(
  input   clock,
  input   reset,
  output  io_syncReset // @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 11:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  resetReg1; // @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 15:28]
  reg  resetReg2; // @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 16:28]
  assign io_syncReset = resetReg2; // @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 20:31]
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 15:28]
      resetReg1 <= 1'h1; // @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 15:28]
    end else begin
      resetReg1 <= 1'h0; // @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 17:15]
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 16:28]
      resetReg2 <= 1'h1; // @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 16:28]
    end else begin
      resetReg2 <= resetReg1; // @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 18:15]
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
  resetReg1 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  resetReg2 = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    resetReg1 = 1'h1;
  end
  if (reset) begin
    resetReg2 = 1'h1;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PaddleLeftObj(
  input         clock,
  input         reset,
  input         io_input, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  input  [10:0] io_posX, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  input  [9:0]  io_posY, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output [9:0]  io_paddlePosY, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output [4:0]  io_diffX // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:24]
  reg [5:0] velocity; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:25]
  wire [4:0] _velocity_T_2 = 5'sh0 - 5'sh8; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:19]
  wire [5:0] _velocity_T_5 = $signed(velocity) + 6'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:28]
  wire [9:0] _GEN_5 = {{4{velocity[5]}},velocity}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:26]
  wire [9:0] newPos = $signed(curPosY) + $signed(_GEN_5); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:26]
  wire [10:0] diffX = 11'sh50 - $signed(io_posX); // @[\\src\\main\\scala\\vga\\PaddleLeftObj.scala 4:20]
  wire [7:0] _Top_T_2 = 8'sh0 - 8'sh64; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:14]
  wire [9:0] _GEN_6 = {{2{_Top_T_2[7]}},_Top_T_2}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:44]
  wire [9:0] Top = $signed(_GEN_6) + $signed(curPosY); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:44]
  wire  inXBound = ~diffX[10] & $signed(diffX) <= 11'sh10; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 47:31]
  wire  inYBound = $signed(io_posY) >= $signed(Top) & $signed(io_posY) <= $signed(curPosY); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:35]
  assign io_inbound = inXBound & inYBound; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 51:27]
  assign io_paddlePosY = curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 54:17]
  assign io_diffX = diffX[4:0]; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 44:20]
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 25:25]
      curPosY <= 10'shf0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:{19,55}]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:24]
      if ($signed(newPos) > 10'sh1e0) begin
        curPosY <= 10'sh1e0;
      end else if ($signed(newPos) < 10'sh64) begin
        curPosY <= 10'sh64;
      end else begin
        curPosY <= newPos;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 25:25]
      velocity <= 6'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:21 28:16 29:39 30:16 31:42 32:16 34:16]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:25]
      if (io_input) begin
        velocity <= {{1{_velocity_T_2[4]}},_velocity_T_2};
      end else if ($signed(curPosY) == 10'sh64) begin
        velocity <= 6'sh1;
      end else if ($signed(curPosY) == 10'sh1e0) begin
        velocity <= 6'sh0;
      end else begin
        velocity <= _velocity_T_5;
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
  curPosY = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  velocity = _RAND_1[5:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    curPosY = 10'shf0;
  end
  if (reset) begin
    velocity = 6'sh0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PaddleRightObj(
  input         clock,
  input         reset,
  input         io_input, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  input  [10:0] io_posX, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  input  [9:0]  io_posY, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output [9:0]  io_paddlePosY, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
  output [4:0]  io_diffX // @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:24]
  reg [5:0] velocity; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:25]
  wire [4:0] _velocity_T_2 = 5'sh0 - 5'sh8; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:19]
  wire [5:0] _velocity_T_5 = $signed(velocity) + 6'sh1; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:28]
  wire [9:0] _GEN_5 = {{4{velocity[5]}},velocity}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:26]
  wire [9:0] newPos = $signed(curPosY) + $signed(_GEN_5); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:26]
  wire [10:0] diffX = $signed(io_posX) - 11'sh230; // @[\\src\\main\\scala\\vga\\PaddleRightObj.scala 4:20]
  wire [7:0] _Top_T_2 = 8'sh0 - 8'sh64; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:14]
  wire [9:0] _GEN_6 = {{2{_Top_T_2[7]}},_Top_T_2}; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:44]
  wire [9:0] Top = $signed(_GEN_6) + $signed(curPosY); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:44]
  wire  inXBound = ~diffX[10] & $signed(diffX) <= 11'sh10; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 47:31]
  wire  inYBound = $signed(io_posY) >= $signed(Top) & $signed(io_posY) <= $signed(curPosY); // @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:35]
  assign io_inbound = inXBound & inYBound; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 51:27]
  assign io_paddlePosY = curPosY; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 54:17]
  assign io_diffX = diffX[4:0]; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 44:20]
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 25:25]
      curPosY <= 10'shf0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:{19,55}]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:24]
      if ($signed(newPos) > 10'sh1e0) begin
        curPosY <= 10'sh1e0;
      end else if ($signed(newPos) < 10'sh64) begin
        curPosY <= 10'sh64;
      end else begin
        curPosY <= newPos;
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 25:25]
      velocity <= 6'sh0; // @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:21 28:16 29:39 30:16 31:42 32:16 34:16]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:25]
      if (io_input) begin
        velocity <= {{1{_velocity_T_2[4]}},_velocity_T_2};
      end else if ($signed(curPosY) == 10'sh64) begin
        velocity <= 6'sh1;
      end else if ($signed(curPosY) == 10'sh1e0) begin
        velocity <= 6'sh0;
      end else begin
        velocity <= _velocity_T_5;
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
  curPosY = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  velocity = _RAND_1[5:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    curPosY = 10'shf0;
  end
  if (reset) begin
    velocity = 6'sh0;
  end
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
  input  [10:0] io_posX, // @[\\src\\main\\scala\\vga\\Ball.scala 17:14]
  input  [9:0]  io_posY, // @[\\src\\main\\scala\\vga\\Ball.scala 17:14]
  output        io_inbound, // @[\\src\\main\\scala\\vga\\Ball.scala 17:14]
  input  [9:0]  io_P1PosY, // @[\\src\\main\\scala\\vga\\Ball.scala 17:14]
  input  [9:0]  io_P2PosY, // @[\\src\\main\\scala\\vga\\Ball.scala 17:14]
  input         io_updateLogic, // @[\\src\\main\\scala\\vga\\Ball.scala 17:14]
  output        io_outLeftBound, // @[\\src\\main\\scala\\vga\\Ball.scala 17:14]
  output        io_outRightBound // @[\\src\\main\\scala\\vga\\Ball.scala 17:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [5:0] ballSpeed; // @[\\src\\main\\scala\\vga\\Ball.scala 19:26]
  reg [10:0] curPosX; // @[\\src\\main\\scala\\vga\\Ball.scala 21:24]
  reg [9:0] curPosY; // @[\\src\\main\\scala\\vga\\Ball.scala 22:24]
  reg  goingRight; // @[\\src\\main\\scala\\vga\\Ball.scala 24:27]
  reg  goingDown; // @[\\src\\main\\scala\\vga\\Ball.scala 25:26]
  wire [9:0] _goingDown_T_3 = 10'sh1e0 - 10'sh10; // @[\\src\\main\\scala\\vga\\Ball.scala 30:63]
  wire  _goingDown_T_5 = $signed(curPosY) > $signed(_goingDown_T_3) ? 1'h0 : goingDown; // @[\\src\\main\\scala\\vga\\Ball.scala 30:45]
  wire [5:0] _speedX_T_2 = 6'sh0 - $signed(ballSpeed); // @[\\src\\main\\scala\\vga\\Ball.scala 31:45]
  wire [5:0] speedX = goingRight ? $signed(ballSpeed) : $signed(_speedX_T_2); // @[\\src\\main\\scala\\vga\\Ball.scala 31:21]
  wire [5:0] speedY = goingDown ? $signed(ballSpeed) : $signed(_speedX_T_2); // @[\\src\\main\\scala\\vga\\Ball.scala 32:21]
  wire [10:0] _GEN_11 = {{5{speedX[5]}},speedX}; // @[\\src\\main\\scala\\vga\\Ball.scala 33:24]
  wire [10:0] _curPosX_T_2 = $signed(curPosX) + $signed(_GEN_11); // @[\\src\\main\\scala\\vga\\Ball.scala 33:24]
  wire [9:0] _GEN_12 = {{4{speedY[5]}},speedY}; // @[\\src\\main\\scala\\vga\\Ball.scala 34:24]
  wire [9:0] _curPosY_T_2 = $signed(curPosY) + $signed(_GEN_12); // @[\\src\\main\\scala\\vga\\Ball.scala 34:24]
  wire [9:0] P1Top = $signed(io_P1PosY) - 10'sh6c; // @[\\src\\main\\scala\\vga\\Ball.scala 39:74]
  wire [9:0] P1Bottom = $signed(io_P1PosY) + 10'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 40:29]
  wire [9:0] P2Top = $signed(io_P2PosY) - 10'sh6c; // @[\\src\\main\\scala\\vga\\Ball.scala 44:74]
  wire [9:0] P2Bottom = $signed(io_P2PosY) + 10'sh8; // @[\\src\\main\\scala\\vga\\Ball.scala 45:30]
  wire  newDir = ballSpeed[1] ^ ballSpeed[0] ^ goingDown ^ goingRight; // @[\\src\\main\\scala\\vga\\Ball.scala 47:53]
  wire [5:0] _ballSpeed_T_2 = $signed(ballSpeed) + 6'sh1; // @[\\src\\main\\scala\\vga\\Ball.scala 55:37]
  wire  _GEN_0 = goingRight & $signed(curPosX) < 11'sh240 & $signed(curPosX) > 11'sh220 & $signed(curPosY) < $signed(
    P2Bottom) & $signed(curPosY) > $signed(P2Top) ? 1'h0 : goingRight; // @[\\src\\main\\scala\\vga\\Ball.scala 52:122 53:18 24:27]
  wire  _GEN_3 = ~goingRight & $signed(curPosX) < 11'sh50 & $signed(curPosX) > 11'sh30 & $signed(curPosY) < $signed(
    P1Bottom) & $signed(curPosY) > $signed(P1Top) | _GEN_0; // @[\\src\\main\\scala\\vga\\Ball.scala 49:117 50:18]
  wire [10:0] _inSquareX_T_3 = $signed(curPosX) + 11'sh10; // @[\\src\\main\\scala\\vga\\Ball.scala 60:60]
  wire  inSquareX = $signed(io_posX) >= $signed(curPosX) & $signed(io_posX) < $signed(_inSquareX_T_3); // @[\\src\\main\\scala\\vga\\Ball.scala 60:39]
  wire [9:0] _inSquareY_T_3 = $signed(curPosY) + 10'sh10; // @[\\src\\main\\scala\\vga\\Ball.scala 61:60]
  wire  inSquareY = $signed(io_posY) >= $signed(curPosY) & $signed(io_posY) < $signed(_inSquareY_T_3); // @[\\src\\main\\scala\\vga\\Ball.scala 61:39]
  assign io_inbound = inSquareX & inSquareY; // @[\\src\\main\\scala\\vga\\Ball.scala 62:28]
  assign io_outLeftBound = $signed(curPosX) <= 11'sh0; // @[\\src\\main\\scala\\vga\\Ball.scala 67:30]
  assign io_outRightBound = $signed(curPosX) > 11'sh280; // @[\\src\\main\\scala\\vga\\Ball.scala 66:31]
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 28:24]
      ballSpeed <= 6'sh2; // @[\\src\\main\\scala\\vga\\Ball.scala 49:117 19:26 52:122 55:17 19:26]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 19:26]
      if (!(~goingRight & $signed(curPosX) < 11'sh50 & $signed(curPosX) > 11'sh30 & $signed(curPosY) < $signed(P1Bottom)
         & $signed(curPosY) > $signed(P1Top))) begin
        if (goingRight & $signed(curPosX) < 11'sh240 & $signed(curPosX) > 11'sh220 & $signed(curPosY) < $signed(P2Bottom
          ) & $signed(curPosY) > $signed(P2Top)) begin
          ballSpeed <= _ballSpeed_T_2;
        end
      end
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 28:24]
      curPosX <= 11'sh140; // @[\\src\\main\\scala\\vga\\Ball.scala 33:13]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 21:24]
      curPosX <= _curPosX_T_2;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 28:24]
      curPosY <= 10'sh40; // @[\\src\\main\\scala\\vga\\Ball.scala 34:13]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 22:24]
      curPosY <= _curPosY_T_2;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 28:24]
      goingRight <= 1'h1;
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 24:27]
      goingRight <= _GEN_3;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\Ball.scala 28:24]
      goingDown <= 1'h1; // @[\\src\\main\\scala\\vga\\Ball.scala 49:117 51:17 52:122 30:15 54:17]
    end else if (io_updateLogic) begin // @[\\src\\main\\scala\\vga\\Ball.scala 25:26]
      if (~goingRight & $signed(curPosX) < 11'sh50 & $signed(curPosX) > 11'sh30 & $signed(curPosY) < $signed(P1Bottom)
         & $signed(curPosY) > $signed(P1Top)) begin
        goingDown <= newDir;
      end else if (goingRight & $signed(curPosX) < 11'sh240 & $signed(curPosX) > 11'sh220 & $signed(curPosY) < $signed(
        P2Bottom) & $signed(curPosY) > $signed(P2Top)) begin
        goingDown <= newDir;
      end else begin
        goingDown <= $signed(curPosY) < 10'sh0 | _goingDown_T_5;
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
  ballSpeed = _RAND_0[5:0];
  _RAND_1 = {1{`RANDOM}};
  curPosX = _RAND_1[10:0];
  _RAND_2 = {1{`RANDOM}};
  curPosY = _RAND_2[9:0];
  _RAND_3 = {1{`RANDOM}};
  goingRight = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  goingDown = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    ballSpeed = 6'sh2;
  end
  if (reset) begin
    curPosX = 11'sh140;
  end
  if (reset) begin
    curPosY = 10'sh40;
  end
  if (reset) begin
    goingRight = 1'h1;
  end
  if (reset) begin
    goingDown = 1'h1;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GraphicsProcessor(
  input         clock,
  input         reset,
  output [1:0]  io_col_R, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  output [1:0]  io_col_G, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  output [1:0]  io_col_B, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  input  [10:0] io_indexX, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  input  [9:0]  io_indexY, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  input         io_input1, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  input         io_input2, // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
  input         io_screenDone // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  P1_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:20]
  wire  P1_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:20]
  wire  P1_io_input; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:20]
  wire [10:0] P1_io_posX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:20]
  wire [9:0] P1_io_posY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:20]
  wire  P1_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:20]
  wire [9:0] P1_io_paddlePosY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:20]
  wire  P1_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:20]
  wire [4:0] P1_io_diffX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:20]
  wire  P2_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 43:20]
  wire  P2_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 43:20]
  wire  P2_io_input; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 43:20]
  wire [10:0] P2_io_posX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 43:20]
  wire [9:0] P2_io_posY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 43:20]
  wire  P2_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 43:20]
  wire [9:0] P2_io_paddlePosY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 43:20]
  wire  P2_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 43:20]
  wire [4:0] P2_io_diffX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 43:20]
  wire  Ball_clock; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 49:22]
  wire  Ball_reset; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 49:22]
  wire [10:0] Ball_io_posX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 49:22]
  wire [9:0] Ball_io_posY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 49:22]
  wire  Ball_io_inbound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 49:22]
  wire [9:0] Ball_io_P1PosY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 49:22]
  wire [9:0] Ball_io_P2PosY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 49:22]
  wire  Ball_io_updateLogic; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 49:22]
  wire  Ball_io_outLeftBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 49:22]
  wire  Ball_io_outRightBound; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 49:22]
  reg  gameOver; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 33:25]
  wire  XOR0 = io_indexX[0] ^ io_indexY[0]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 58:29]
  wire  XOR1 = io_indexX[1] ^ io_indexY[1]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 59:29]
  wire  XOR2 = io_indexX[2] ^ io_indexY[2]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 60:29]
  wire  XOR3 = io_indexX[3] ^ io_indexY[3]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 61:29]
  wire  XOR4 = io_indexX[4] ^ io_indexY[4]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 62:29]
  wire  XOR5 = io_indexX[5] ^ io_indexY[5]; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 63:29]
  wire [3:0] BaysianDither = {io_indexY[0],XOR1,io_indexY[1],XOR0}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:70]
  wire [4:0] _GEN_4 = P2_io_inbound ? P2_io_diffX : 5'h0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 75:32 76:17]
  wire [4:0] inputAbsX = P1_io_inbound ? P1_io_diffX : _GEN_4; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 70:26 71:17]
  wire [4:0] _GEN_12 = {{1'd0}, BaysianDither}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 68:31]
  wire  dithered = inputAbsX <= _GEN_12; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 68:31]
  wire [1:0] _io_col_R_T = {dithered,1'h1}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 72:22]
  wire  _io_col_G_T_1 = XOR4 ^ XOR1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 89:26]
  wire  _io_col_B_T = XOR3 ^ XOR0; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 90:26]
  wire  _GEN_1 = Ball_io_inbound ? 1'h0 : XOR5 ^ XOR2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 80:34 82:16 88:16]
  wire [1:0] _GEN_2 = Ball_io_inbound ? 2'h3 : {{1'd0}, _io_col_G_T_1}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 80:34 83:16 89:16]
  wire [1:0] _GEN_3 = Ball_io_inbound ? 2'h3 : {{1'd0}, _io_col_B_T}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 80:34 84:16 90:16]
  wire  _GEN_5 = P2_io_inbound ? 1'h0 : _GEN_1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 75:32 77:16]
  wire [1:0] _GEN_6 = P2_io_inbound ? _io_col_R_T : _GEN_2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 75:32 78:16]
  wire [1:0] _GEN_7 = P2_io_inbound ? 2'h0 : _GEN_3; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 75:32 79:16]
  PaddleLeftObj P1 ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:20]
    .clock(P1_clock),
    .reset(P1_reset),
    .io_input(P1_io_input),
    .io_posX(P1_io_posX),
    .io_posY(P1_io_posY),
    .io_inbound(P1_io_inbound),
    .io_paddlePosY(P1_io_paddlePosY),
    .io_updateLogic(P1_io_updateLogic),
    .io_diffX(P1_io_diffX)
  );
  PaddleRightObj P2 ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 43:20]
    .clock(P2_clock),
    .reset(P2_reset),
    .io_input(P2_io_input),
    .io_posX(P2_io_posX),
    .io_posY(P2_io_posY),
    .io_inbound(P2_io_inbound),
    .io_paddlePosY(P2_io_paddlePosY),
    .io_updateLogic(P2_io_updateLogic),
    .io_diffX(P2_io_diffX)
  );
  BallObj Ball ( // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 49:22]
    .clock(Ball_clock),
    .reset(Ball_reset),
    .io_posX(Ball_io_posX),
    .io_posY(Ball_io_posY),
    .io_inbound(Ball_io_inbound),
    .io_P1PosY(Ball_io_P1PosY),
    .io_P2PosY(Ball_io_P2PosY),
    .io_updateLogic(Ball_io_updateLogic),
    .io_outLeftBound(Ball_io_outLeftBound),
    .io_outRightBound(Ball_io_outRightBound)
  );
  assign io_col_R = P1_io_inbound ? _io_col_R_T : {{1'd0}, _GEN_5}; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 70:26 72:16]
  assign io_col_G = P1_io_inbound ? 2'h0 : _GEN_6; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 70:26 73:16]
  assign io_col_B = P1_io_inbound ? 2'h0 : _GEN_7; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 70:26 74:16]
  assign P1_clock = clock;
  assign P1_reset = reset | gameOver; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:52]
  assign P1_io_input = io_input1; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 38:17]
  assign P1_io_posX = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 29:29]
  assign P1_io_posY = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 30:29]
  assign P1_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:23]
  assign P2_clock = clock;
  assign P2_reset = reset | gameOver; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:52]
  assign P2_io_input = io_input2; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 44:17]
  assign P2_io_posX = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 29:29]
  assign P2_io_posY = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 30:29]
  assign P2_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 47:23]
  assign Ball_clock = clock;
  assign Ball_reset = reset | gameOver; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:52]
  assign Ball_io_posX = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 29:29]
  assign Ball_io_posY = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 30:29]
  assign Ball_io_P1PosY = P1_io_paddlePosY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 50:20]
  assign Ball_io_P2PosY = P2_io_paddlePosY; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 51:20]
  assign Ball_io_updateLogic = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 54:25]
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 55:38]
      gameOver <= 1'h0;
    end else begin
      gameOver <= Ball_io_outLeftBound | Ball_io_outRightBound;
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
  gameOver = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    gameOver = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GraphicsManager(
  input         clock,
  input         reset,
  output [1:0]  io_col_R, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  output [1:0]  io_col_G, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  output [1:0]  io_col_B, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input  [10:0] io_indexX, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input  [9:0]  io_indexY, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input         io_screenDone, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input         io_input1, // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
  input         io_input2 // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]
);
  wire  gpu_clock; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire  gpu_reset; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [1:0] gpu_io_col_R; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [1:0] gpu_io_col_G; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [1:0] gpu_io_col_B; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [10:0] gpu_io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire [9:0] gpu_io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire  gpu_io_input1; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire  gpu_io_input2; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire  gpu_io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
  wire  valid = io_indexY < 10'h1e0 & io_indexX < 11'h280; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 40:33]
  GraphicsProcessor gpu ( // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
    .clock(gpu_clock),
    .reset(gpu_reset),
    .io_col_R(gpu_io_col_R),
    .io_col_G(gpu_io_col_G),
    .io_col_B(gpu_io_col_B),
    .io_indexX(gpu_io_indexX),
    .io_indexY(gpu_io_indexY),
    .io_input1(gpu_io_input1),
    .io_input2(gpu_io_input2),
    .io_screenDone(gpu_io_screenDone)
  );
  assign io_col_R = valid ? gpu_io_col_R : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 41:18]
  assign io_col_G = valid ? gpu_io_col_G : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 42:18]
  assign io_col_B = valid ? gpu_io_col_B : 2'h0; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 43:18]
  assign gpu_clock = clock;
  assign gpu_reset = reset;
  assign gpu_io_indexX = io_indexX; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 33:17]
  assign gpu_io_indexY = io_indexY; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 34:17]
  assign gpu_io_input1 = io_input1; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 36:17]
  assign gpu_io_input2 = io_input2; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 37:17]
  assign gpu_io_screenDone = io_screenDone; // @[\\src\\main\\scala\\vga\\GraphicsManager.scala 35:21]
endmodule
module DebouncerModule(
  input   clock,
  input   reset,
  input   io_in, // @[\\src\\main\\scala\\vga\\Debouncer.scala 12:14]
  output  io_out // @[\\src\\main\\scala\\vga\\Debouncer.scala 12:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  sync0; // @[\\src\\main\\scala\\vga\\Debouncer.scala 15:22]
  reg  sync1; // @[\\src\\main\\scala\\vga\\Debouncer.scala 16:22]
  reg  sync2; // @[\\src\\main\\scala\\vga\\Debouncer.scala 17:22]
  reg [18:0] count; // @[\\src\\main\\scala\\vga\\Debouncer.scala 19:22]
  reg  out; // @[\\src\\main\\scala\\vga\\Debouncer.scala 23:20]
  wire [18:0] _count_T_1 = count + 19'h1; // @[\\src\\main\\scala\\vga\\Debouncer.scala 28:20]
  assign io_out = out; // @[\\src\\main\\scala\\vga\\Debouncer.scala 24:10]
  always @(posedge clock) begin
    sync0 <= io_in; // @[\\src\\main\\scala\\vga\\Debouncer.scala 15:22]
    sync1 <= sync0; // @[\\src\\main\\scala\\vga\\Debouncer.scala 16:22]
    sync2 <= sync1; // @[\\src\\main\\scala\\vga\\Debouncer.scala 17:22]
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\Debouncer.scala 27:24]
      count <= 19'h0; // @[\\src\\main\\scala\\vga\\Debouncer.scala 28:11]
    end else if (sync2 != out) begin // @[\\src\\main\\scala\\vga\\Debouncer.scala 33:11]
      count <= _count_T_1;
    end else begin
      count <= 19'h0;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin // @[\\src\\main\\scala\\vga\\Debouncer.scala 27:24]
      out <= 1'h0; // @[\\src\\main\\scala\\vga\\Debouncer.scala 29:31 30:11 23:20]
    end else if (sync2 != out) begin // @[\\src\\main\\scala\\vga\\Debouncer.scala 23:20]
      if (count == 19'h7ffff) begin
        out <= sync2;
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
  sync0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  sync1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  sync2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  count = _RAND_3[18:0];
  _RAND_4 = {1{`RANDOM}};
  out = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    count = 19'h0;
  end
  if (reset) begin
    out = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module VGATimingModule(
  output        io_hsync, // @[\\src\\main\\scala\\vga\\VGATimingModule.scala 13:14]
  output        io_vsync, // @[\\src\\main\\scala\\vga\\VGATimingModule.scala 13:14]
  input  [10:0] io_indexX, // @[\\src\\main\\scala\\vga\\VGATimingModule.scala 13:14]
  input  [9:0]  io_indexY // @[\\src\\main\\scala\\vga\\VGATimingModule.scala 13:14]
);
  assign io_hsync = io_indexX > 11'h28f & io_indexX < 11'h2f0 ? 1'h0 : 1'h1; // @[\\src\\main\\scala\\vga\\VGATimingModule.scala 16:18]
  assign io_vsync = io_indexY > 10'h1e9 & io_indexY < 10'h1ec ? 1'h0 : 1'h1; // @[\\src\\main\\scala\\vga\\VGATimingModule.scala 17:18]
endmodule
module VGAModule(
  input        clock,
  input        reset,
  output [1:0] io_col_R, // @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
  output [1:0] io_col_G, // @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
  output [1:0] io_col_B, // @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
  output       io_hsync, // @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
  output       io_vsync, // @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
  input        io_input1, // @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
  input        io_input2 // @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  resetModule_clock; // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:27]
  wire  resetModule_reset; // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:27]
  wire  resetModule_io_syncReset; // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:27]
  wire  graphics_clock; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:26]
  wire  graphics_reset; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:26]
  wire [1:0] graphics_io_col_R; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:26]
  wire [1:0] graphics_io_col_G; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:26]
  wire [1:0] graphics_io_col_B; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:26]
  wire [10:0] graphics_io_indexX; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:26]
  wire [9:0] graphics_io_indexY; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:26]
  wire  graphics_io_screenDone; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:26]
  wire  graphics_io_input1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:26]
  wire  graphics_io_input2; // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:26]
  wire  debouncer1_clock; // @[\\src\\main\\scala\\vga\\VGAModule.scala 33:28]
  wire  debouncer1_reset; // @[\\src\\main\\scala\\vga\\VGAModule.scala 33:28]
  wire  debouncer1_io_in; // @[\\src\\main\\scala\\vga\\VGAModule.scala 33:28]
  wire  debouncer1_io_out; // @[\\src\\main\\scala\\vga\\VGAModule.scala 33:28]
  wire  debouncer2_clock; // @[\\src\\main\\scala\\vga\\VGAModule.scala 34:28]
  wire  debouncer2_reset; // @[\\src\\main\\scala\\vga\\VGAModule.scala 34:28]
  wire  debouncer2_io_in; // @[\\src\\main\\scala\\vga\\VGAModule.scala 34:28]
  wire  debouncer2_io_out; // @[\\src\\main\\scala\\vga\\VGAModule.scala 34:28]
  wire  TimingModule_io_hsync; // @[\\src\\main\\scala\\vga\\VGAModule.scala 49:30]
  wire  TimingModule_io_vsync; // @[\\src\\main\\scala\\vga\\VGAModule.scala 49:30]
  wire [10:0] TimingModule_io_indexX; // @[\\src\\main\\scala\\vga\\VGAModule.scala 49:30]
  wire [9:0] TimingModule_io_indexY; // @[\\src\\main\\scala\\vga\\VGAModule.scala 49:30]
  reg [9:0] hCounter; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  wire  wrap_wrap = hCounter == 10'h31f; // @[src/main/scala/chisel3/util/Counter.scala 73:24]
  wire [9:0] _wrap_value_T_1 = hCounter + 10'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  reg [9:0] vCounter; // @[src/main/scala/chisel3/util/Counter.scala 61:40]
  wire  wrap_wrap_1 = vCounter == 10'h20c; // @[src/main/scala/chisel3/util/Counter.scala 73:24]
  wire [9:0] _wrap_value_T_3 = vCounter + 10'h1; // @[src/main/scala/chisel3/util/Counter.scala 77:24]
  resetSynchronizer resetModule ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 17:27]
    .clock(resetModule_clock),
    .reset(resetModule_reset),
    .io_syncReset(resetModule_io_syncReset)
  );
  GraphicsManager graphics ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 30:26]
    .clock(graphics_clock),
    .reset(graphics_reset),
    .io_col_R(graphics_io_col_R),
    .io_col_G(graphics_io_col_G),
    .io_col_B(graphics_io_col_B),
    .io_indexX(graphics_io_indexX),
    .io_indexY(graphics_io_indexY),
    .io_screenDone(graphics_io_screenDone),
    .io_input1(graphics_io_input1),
    .io_input2(graphics_io_input2)
  );
  DebouncerModule debouncer1 ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 33:28]
    .clock(debouncer1_clock),
    .reset(debouncer1_reset),
    .io_in(debouncer1_io_in),
    .io_out(debouncer1_io_out)
  );
  DebouncerModule debouncer2 ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 34:28]
    .clock(debouncer2_clock),
    .reset(debouncer2_reset),
    .io_in(debouncer2_io_in),
    .io_out(debouncer2_io_out)
  );
  VGATimingModule TimingModule ( // @[\\src\\main\\scala\\vga\\VGAModule.scala 49:30]
    .io_hsync(TimingModule_io_hsync),
    .io_vsync(TimingModule_io_vsync),
    .io_indexX(TimingModule_io_indexX),
    .io_indexY(TimingModule_io_indexY)
  );
  assign io_col_R = graphics_io_col_R; // @[\\src\\main\\scala\\vga\\VGAModule.scala 44:14]
  assign io_col_G = graphics_io_col_G; // @[\\src\\main\\scala\\vga\\VGAModule.scala 45:14]
  assign io_col_B = graphics_io_col_B; // @[\\src\\main\\scala\\vga\\VGAModule.scala 46:14]
  assign io_hsync = TimingModule_io_hsync; // @[\\src\\main\\scala\\vga\\VGAModule.scala 52:14]
  assign io_vsync = TimingModule_io_vsync; // @[\\src\\main\\scala\\vga\\VGAModule.scala 53:14]
  assign resetModule_clock = clock;
  assign resetModule_reset = reset;
  assign graphics_clock = clock;
  assign graphics_reset = resetModule_io_syncReset;
  assign graphics_io_indexX = {{1'd0}, hCounter}; // @[\\src\\main\\scala\\vga\\VGAModule.scala 39:24]
  assign graphics_io_indexY = vCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 40:24]
  assign graphics_io_screenDone = wrap_wrap & wrap_wrap_1; // @[src/main/scala/chisel3/util/Counter.scala 118:{16,23} 117:24]
  assign graphics_io_input1 = debouncer1_io_out; // @[\\src\\main\\scala\\vga\\VGAModule.scala 42:24]
  assign graphics_io_input2 = debouncer2_io_out; // @[\\src\\main\\scala\\vga\\VGAModule.scala 43:24]
  assign debouncer1_clock = clock;
  assign debouncer1_reset = resetModule_io_syncReset;
  assign debouncer1_io_in = io_input1; // @[\\src\\main\\scala\\vga\\VGAModule.scala 35:22]
  assign debouncer2_clock = clock;
  assign debouncer2_reset = resetModule_io_syncReset;
  assign debouncer2_io_in = io_input2; // @[\\src\\main\\scala\\vga\\VGAModule.scala 36:22]
  assign TimingModule_io_indexX = {{1'd0}, hCounter}; // @[\\src\\main\\scala\\vga\\VGAModule.scala 50:28]
  assign TimingModule_io_indexY = vCounter; // @[\\src\\main\\scala\\vga\\VGAModule.scala 51:28]
  always @(posedge clock or posedge resetModule_io_syncReset) begin
    if (resetModule_io_syncReset) begin // @[src/main/scala/chisel3/util/Counter.scala 87:20]
      hCounter <= 10'h0; // @[src/main/scala/chisel3/util/Counter.scala 87:28]
    end else if (wrap_wrap) begin // @[src/main/scala/chisel3/util/Counter.scala 77:15]
      hCounter <= 10'h0;
    end else begin
      hCounter <= _wrap_value_T_1;
    end
  end
  always @(posedge clock or posedge resetModule_io_syncReset) begin
    if (resetModule_io_syncReset) begin // @[src/main/scala/chisel3/util/Counter.scala 118:16]
      vCounter <= 10'h0; // @[src/main/scala/chisel3/util/Counter.scala 77:15 87:{20,28}]
    end else if (wrap_wrap) begin // @[src/main/scala/chisel3/util/Counter.scala 61:40]
      if (wrap_wrap_1) begin
        vCounter <= 10'h0;
      end else begin
        vCounter <= _wrap_value_T_3;
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
  if (resetModule_io_syncReset) begin
    hCounter = 10'h0;
  end
  if (resetModule_io_syncReset) begin
    vCounter = 10'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

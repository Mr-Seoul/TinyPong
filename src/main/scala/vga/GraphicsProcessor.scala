package vga

import chisel3._

object PongSettings {
  val paddleHeight  = 40 //Note that due to how absolutes work, this is half the size (think of it as a radius)
  val paddleWidth = 10
  val ballRadius  = 10
  val paddleWallDist = 80
  val paddleJumpSpeed = 10
  val paddleGravity = 1
  val ballSpeed = 2
  val ballRounding = 2*ballRadius - 5 //5 pixels of rounding
  val paddleRounding = paddleHeight + paddleWidth - 5
}

object DataSettings {
  val width = 11
}

class GraphicsProcessorIO extends Bundle {
  val col = new Col
  val indexX = Input(UInt(DataSettings.width.W))
  val indexY = Input(UInt(DataSettings.width.W))
  val input1 = Input(Bool())
  val input2 = Input(Bool())
  val screenDone = Input(Bool())
}

class GraphicsProcessor extends Module {
  val io = IO(new GraphicsProcessorIO)

  val indexPos = VecInit(io.indexX.asSInt,io.indexY.asSInt)

  val P1 = Module(new PaddleObj(PongSettings.paddleWallDist,240))
  P1.io.input := io.input1
  P1.io.pos := indexPos
  P1.io.updateLogic := io.screenDone

  val P2 = Module(new PaddleObj(640 - PongSettings.paddleWallDist,240))
  P2.io.input := io.input2
  P2.io.pos := indexPos
  P2.io.updateLogic := io.screenDone

  val Ball = Module(new BallObj(320,240))
  Ball.io.P1Pos := P1.io.paddlePos
  Ball.io.P2Pos := P2.io.paddlePos
  Ball.io.pos := indexPos
  Ball.io.updateLogic := io.screenDone

  //if out of bounds, reset everything to initial position
  val resetEverything = Ball.io.outLeftBound || Ball.io.outRightBound
  P1.reset := resetEverything
  P2.reset := resetEverything
  Ball.reset := resetEverything

  //Output current colour depending on object position
  when (P1.io.inbound) {
    io.col.R := 3.U
    io.col.G := 0.U
    io.col.B := 0.U
  } .elsewhen(P2.io.inbound) {
    io.col.R := 0.U
    io.col.G := 3.U
    io.col.B := 0.U
  } .elsewhen(Ball.io.inbound) {
    io.col.R := 0.U
    io.col.G := 0.U
    io.col.B := 3.U
  } .otherwise {
    //More interesting Background
    io.col.R := (io.indexX(5) ^ io.indexY(5)) ^ (io.indexX(2) ^ io.indexY(2))
    io.col.G := (io.indexX(4) ^ io.indexY(4)) ^ (io.indexX(1) ^ io.indexY(1))
    io.col.B := (io.indexX(3) ^ io.indexY(3)) ^ (io.indexX(0) ^ io.indexY(0))
  }
}
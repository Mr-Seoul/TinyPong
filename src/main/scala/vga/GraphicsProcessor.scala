package vga

import Chisel.Cat
import chisel3._
import chisel3.util.Fill

object PongSettings {
  val paddleHeight  = 100
  val paddleWidth = 16
  val ballRadius  = 8
  val paddleWallDist = 64
  val paddleJumpSpeed = 8
  val paddleGravity = 1
  val ballSpeed = 2
}

class GraphicsProcessorIO extends Bundle {
  val col = new Col
  val indexX = Input(UInt(11.W))
  val indexY = Input(UInt(10.W))
  val input1 = Input(Bool())
  val input2 = Input(Bool())
  val screenDone = Input(Bool())
}

class GraphicsProcessor extends Module {
  val io = IO(new GraphicsProcessorIO)

  val indexPosX = io.indexX.asSInt
  val indexPosY = io.indexY.asSInt

  //if out of bounds, reset the game
  val gameOver = RegInit(0.B)
  val resetEverything = (reset.asBool || gameOver).asAsyncReset

  withReset(resetEverything) {
    val P1 = Module(new PaddleLeftObj(PongSettings.paddleWallDist + PongSettings.paddleWidth,240))
    P1.io.input := io.input1
    P1.io.posX := indexPosX
    P1.io.posY := indexPosY
    P1.io.updateLogic := io.screenDone

    val P2 = Module(new PaddleRightObj(640 - PongSettings.paddleWallDist - PongSettings.paddleWidth,240))
    P2.io.input := io.input2
    P2.io.posX := indexPosX
    P2.io.posY := indexPosY
    P2.io.updateLogic := io.screenDone

    val Ball = Module(new BallObj(320,64))
    Ball.io.P1PosY := P1.io.paddlePosY
    Ball.io.P2PosY := P2.io.paddlePosY
    Ball.io.posX := indexPosX
    Ball.io.posY := indexPosY
    Ball.io.updateLogic := io.screenDone
    gameOver := Ball.io.outLeftBound || Ball.io.outRightBound

    //Xor Precomputation (This is reused a bit and I don't trust the GDS synthesyzer to see that)
    val XOR0 = io.indexX(0) ^ io.indexY(0)
    val XOR1 = io.indexX(1) ^ io.indexY(1)
    val XOR2 = io.indexX(2) ^ io.indexY(2)
    val XOR3 = io.indexX(3) ^ io.indexY(3)
    val XOR4 = io.indexX(4) ^ io.indexY(4)
    val XOR5 = io.indexX(5) ^ io.indexY(5)

    //Output current colour depending on object position, and dithering if applicable
    val BaysianDither = VecInit(XOR0,io.indexY(1),XOR1,io.indexY(0)).asUInt
    val inputAbsX = Wire(UInt(5.W))
    val dithered =  inputAbsX <= BaysianDither

    when (P1.io.inbound) {
      inputAbsX := P1.io.diffX.asUInt
      io.col.R := Cat(dithered,1.U)
      io.col.G := 0.U
      io.col.B := 0.U
    } .elsewhen(P2.io.inbound) {
      inputAbsX := P2.io.diffX.asUInt
      io.col.R := 0.U
      io.col.G := Cat(dithered,1.U)
      io.col.B := 0.U
    } .elsewhen(Ball.io.inbound) {
      inputAbsX := 0.U
      io.col.R := 0.U
      io.col.G := 3.U
      io.col.B := 3.U
    } .otherwise {
      inputAbsX := 0.U
      //More interesting Background (Found this pattern when experimenting, pretty cool)
      io.col.R := (XOR5) ^ (XOR2)
      io.col.G := (XOR4) ^ (XOR1)
      io.col.B := (XOR3) ^ (XOR0)
    }
  }
}
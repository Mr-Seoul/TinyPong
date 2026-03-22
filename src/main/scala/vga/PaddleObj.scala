package vga

import chisel3._

class PaddleObjIO() extends Bundle {
  val input = Input(Bool())
  val posX = Input(SInt(11.W))
  val posY = Input(SInt(10.W))
  val inbound = Output(Bool())
  val paddlePosY = Output(SInt(10.W))
  val updateLogic = Input(Bool())
  val diffX = Output(UInt(5.W))
}

class PaddleObj(startX: Int,startY: Int) extends Module {
  val io = IO(new PaddleObjIO())

  val curPosX = startX.S(11.W)
  val curPosY = RegInit(startY.S(10.W))
  val velocity = RegInit(0.S(6.W))

  val topWall = PongSettings.paddleHeight.S
  val bottomWall = 480.S

  when (io.updateLogic) {
    //Gravity logic
    when (io.input) {
      velocity := -PongSettings.paddleJumpSpeed.S
    } .elsewhen (curPosY === topWall) {
      velocity := PongSettings.paddleGravity.S
    } .elsewhen (curPosY === bottomWall) {
      velocity := 0.S
    } .otherwise {
      velocity := velocity + PongSettings.paddleGravity.S
    }

    //Clamp position inbetween two top walls
    val newPos = curPosY + velocity
    curPosY := Mux(newPos > bottomWall, bottomWall,Mux(newPos < topWall, topWall, newPos))
  }

  //XBounds
  val diffX = Wire(SInt(11.W))
  io.diffX := diffX(4, 0).asUInt
  val inXBound = (!diffX(10)) && (diffX <= PongSettings.paddleWidth.S)

  //YBounds
  val Top = (-PongSettings.paddleHeight.S) + curPosY
  val Bottom = curPosY
  val inYBound = (io.posY >= Top) && (io.posY <= Bottom)

  //Bound detection
  val inSquare = inXBound && inYBound
  io.inbound := inSquare

  io.paddlePosY := curPosY
}
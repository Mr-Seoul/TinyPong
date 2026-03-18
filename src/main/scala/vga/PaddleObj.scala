package vga

import chisel3._

class PaddleObjIO() extends Bundle {
  val input = Input(Bool())
  val pos = Input(Vec(2,SInt(DataSettings.width.W)))
  val inbound = Output(Bool())
  val paddlePos = Output(Vec(2,SInt(DataSettings.width.W)))
  val updateLogic = Input(Bool())
  val sideX = Output(Bool())
  val absX = Output(UInt(DataSettings.width.W))
}

class PaddleObj(startX: Int,startY: Int) extends Module {
  val io = IO(new PaddleObjIO())

  val curPosX = startX.S(DataSettings.width.W)
  val curPosY = RegInit(startY.S(DataSettings.width.W))
  val velocity = RegInit(0.S(DataSettings.width.W))

  val bottomWall = (480.S - PongSettings.paddleHeight.S)
  val topWall = PongSettings.paddleHeight.S

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

  val diffX = io.pos(0) - curPosX
  val absX = diffX.abs.asUInt
  io.absX := absX
  val absY = (io.pos(1) - curPosY).abs.asUInt

  val inSquare = (absX < PongSettings.paddleWidth.U) && (absY < PongSettings.paddleHeight.U)
  //val inDiamond = absX + absY < PongSettings.paddleRounding.S

  io.inbound := inSquare
  io.sideX := diffX.head(1).asBool

  io.paddlePos := VecInit(curPosX,curPosY)
}
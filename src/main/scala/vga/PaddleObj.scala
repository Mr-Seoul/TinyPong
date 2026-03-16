package vga

import chisel3._

class PaddleObjIO() extends Bundle {
  val input = Input(Bool())
  val pos = Input(Vec(2,SInt(12.W)))
  val inbound = Output(Bool())
  val paddlePos = Output(Vec(2,SInt(12.W)))
  val updateLogic = Input(Bool())
}

class PaddleObj(startX: Int,startY: Int) extends Module {
  val io = IO(new PaddleObjIO())

  val curPos = RegInit(VecInit(startX.S(12.W), startY.S(12.W)))
  val velocity = RegInit(0.S(12.W))

  when (io.updateLogic) {
    //Make logic better here, it's fragmented rn which makes it unpredictable
    when (io.input) {
      velocity := -PongSettings.paddleJumpSpeed.S
    } .otherwise {
      velocity := velocity + PongSettings.paddleGravity.S
    }
    //Clamp position inbetween two top walls
    curPos(1) := Mux(curPos(1) + velocity > (480.S - PongSettings.paddleHeight.S), (480.S - PongSettings.paddleHeight.S),Mux(curPos(1) + velocity < PongSettings.paddleHeight.S, PongSettings.paddleHeight.S, curPos(1) + velocity))
    when (curPos(1) === PongSettings.paddleHeight.S) {
      velocity := PongSettings.paddleJumpSpeed.S
    } .elsewhen(curPos(1) === (480.S - PongSettings.paddleHeight.S)) {
      velocity := -1.S
    }
  }

  val inSquare = ((io.pos(0) - curPos(0)).abs < PongSettings.paddleWidth.S) && ((io.pos(1) - curPos(1)).abs < PongSettings.paddleHeight.S)
  //val inDiamond = (io.pos(0) - curPos(0)).abs + (io.pos(1) - curPos(1)).abs < PongSettings.paddleRounding.S
  when (inSquare) {
    io.inbound := 1.B
  } .otherwise {
    io.inbound := 0.B
  }

  io.paddlePos := curPos
}
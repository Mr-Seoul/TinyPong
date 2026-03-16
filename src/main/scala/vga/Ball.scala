package vga

import chisel3._

class BallObjIO() extends Bundle {
  val pos = Input(Vec(2,SInt(12.W)))
  val inbound = Output(Bool())
  val P1Pos = Input(Vec(2,SInt(12.W)))
  val P2Pos = Input(Vec(2,SInt(12.W)))
  val updateLogic = Input(Bool())
  val outLeftBound = Output(Bool())
  val outRightBound = Output(Bool())
}

class BallObj(startX: Int,startY: Int) extends Module {
  val io = IO(new BallObjIO())

  val ballSpeed = RegInit(PongSettings.ballSpeed.S(12.W))

  val curPos = RegInit(VecInit(startX.S(12.W), startY.S(12.W)))
  val velocity = RegInit(VecInit(1.S(12.W), 1.S(12.W)))

  val outLeftBound = RegInit(0.B)
  val outRightBound = RegInit(0.B)

  //Game Logic
  when(io.updateLogic) {
    //Bouncing off top and bottom wall
    velocity(1) := Mux(curPos(1) < PongSettings.ballRadius.S, ballSpeed, Mux(curPos(1) > (480.S - PongSettings.ballRadius.S), -ballSpeed, velocity(1)))
    curPos(0) := curPos(0) + velocity(0)
    curPos(1) := curPos(1) + velocity(1)
    //Bouncing off paddles
    //LeftSide
    when((velocity(0) < 0.S) && (curPos(0) > PongSettings.paddleWallDist.S) && (curPos(0) < (PongSettings.paddleWallDist.S + PongSettings.paddleWidth.S + PongSettings.ballRadius.S)) && ((io.P1Pos(1) - curPos(1)).abs < PongSettings.paddleHeight.S)) {
      velocity(0) := ballSpeed
      curPos(0) := PongSettings.paddleWallDist.S + PongSettings.paddleWidth.S + PongSettings.ballRadius.S
    }.elsewhen((velocity(0) > 0.S) && (curPos(0) > (640.S - (PongSettings.paddleWallDist.S + PongSettings.paddleWidth.S + PongSettings.ballRadius.S))) && (curPos(0) < (640.S - (PongSettings.paddleWallDist.S))) && ((io.P2Pos(1) - curPos(1)).abs < PongSettings.paddleHeight.S)) {
      velocity(0) := -ballSpeed
      ballSpeed := ballSpeed + 1.S
      curPos(0) := 640.S - (PongSettings.paddleWallDist.S + PongSettings.paddleWidth.S + PongSettings.ballRadius.S)
    }

    //Check for game over
    when(curPos(0) > 640.S) {
      outRightBound := 1.B
    }.otherwise {
      outRightBound := 0.B
    }
    when(curPos(0) < 0.S) {
      outLeftBound := 1.B
    }.otherwise {
      outLeftBound := 0.B
    }
  }


  //Update inbound
  val inSquare = ((io.pos(0) - curPos(0)).abs < PongSettings.ballRadius.S) && ((io.pos(1) - curPos(1)).abs < PongSettings.ballRadius.S)
  //val inDiamond = (io.pos(0) - curPos(0)).abs + (io.pos(1) - curPos(1)).abs < PongSettings.ballRounding.S
  when (inSquare) {
    io.inbound := 1.B
  } .otherwise {
    io.inbound := 0.B
  }

  io.outRightBound := outRightBound
  io.outLeftBound := outLeftBound
}
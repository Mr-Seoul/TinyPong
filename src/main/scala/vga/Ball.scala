package vga

import chisel3._

class BallObjIO() extends Bundle {
  val pos = Input(Vec(2,SInt(DataSettings.width.W)))
  val inbound = Output(Bool())
  val P1Pos = Input(Vec(2,SInt(DataSettings.width.W)))
  val P2Pos = Input(Vec(2,SInt(DataSettings.width.W)))
  val updateLogic = Input(Bool())
  val outLeftBound = Output(Bool())
  val outRightBound = Output(Bool())
}

class BallObj(startX: Int,startY: Int) extends Module {
  val io = IO(new BallObjIO())

  val ballSpeed = RegInit(PongSettings.ballSpeed.S(DataSettings.width.W))

  val curPos = RegInit(VecInit(startX.S(DataSettings.width.W), startY.S(DataSettings.width.W)))
  val velocity = RegInit(VecInit(1.S(DataSettings.width.W), 1.S(DataSettings.width.W)))

  val outLeftBound = RegInit(0.B)
  val outRightBound = RegInit(0.B)

  //Game Logic
  when(io.updateLogic) {
    //Bouncing off top and bottom wall
    velocity(1) := Mux(curPos(1) < PongSettings.ballRadius.S, ballSpeed, Mux(curPos(1) > (480.S - PongSettings.ballRadius.S), -ballSpeed, velocity(1)))
    curPos(0) := curPos(0) + velocity(0)
    curPos(1) := curPos(1) + velocity(1)

    //Bouncing off paddles
    val goingLeft = velocity(0) < 0.S
    val rightPaddledist = (640.S - (PongSettings.paddleWallDist.S + 2.S*PongSettings.paddleWidth.S + PongSettings.ballRadius.S)) - curPos(0)
    val leftPaddledist = curPos(0) - (PongSettings.paddleWallDist.S + 2.S*PongSettings.paddleWidth.S + PongSettings.ballRadius.S)
    when(goingLeft && (leftPaddledist > (2*PongSettings.paddleWidth + 2*PongSettings.ballRadius).S) && (leftPaddledist < 0.S) && ((io.P1Pos(1) - curPos(1)).abs < PongSettings.paddleHeight.S)) {
      velocity(0) := ballSpeed
      curPos(0) := PongSettings.paddleWallDist.S + PongSettings.paddleWidth.S + PongSettings.ballRadius.S
    }.elsewhen(!goingLeft && (rightPaddledist > (2*PongSettings.paddleWidth + 2*PongSettings.ballRadius).S) && (rightPaddledist < 0.S) && ((io.P2Pos(1) - curPos(1)).abs < PongSettings.paddleHeight.S)) {
      velocity(0) := -ballSpeed
      ballSpeed := ballSpeed + 1.S //Speed up ball
      curPos(0) := 640.S - (PongSettings.paddleWallDist.S + PongSettings.paddleWidth.S + PongSettings.ballRadius.S)
    }

    //Check for game over
    outRightBound := curPos(0) > 640.S
    outLeftBound := curPos(0) < 0.S
  }

  //Update inbound
  val absX = (io.pos(0) - curPos(0)).abs
  val absY = (io.pos(1) - curPos(1)).abs
  val inSquare = (absX < PongSettings.ballRadius.S) && (absY < PongSettings.ballRadius.S)
  val inDiamond = absX + absY < PongSettings.ballRounding.S

  io.inbound := inSquare && inDiamond

  io.outRightBound := outRightBound
  io.outLeftBound := outLeftBound
}
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

  val ballSpeed = RegInit(PongSettings.ballSpeed.S(6.W))

  val curPos = RegInit(VecInit(startX.S(DataSettings.width.W), startY.S(DataSettings.width.W)))
  val goingRight = RegInit(1.B)
  val goingDown = RegInit(1.B)

  //Game Logic
  when(io.updateLogic) {
    //Bouncing off top and bottom wall
    goingDown := Mux(curPos(1) < PongSettings.ballRadius.S, 1.B, Mux(curPos(1) > (480.S - PongSettings.ballRadius.S), 0.B, goingDown))
    curPos(0) := Mux(goingRight, curPos(0) + ballSpeed, curPos(0) - ballSpeed)
    curPos(1) := Mux(goingDown, curPos(1) + ballSpeed, curPos(1) - ballSpeed)

    //Bouncing off paddles
    val topBoundary = PongSettings.paddleHeight.S + PongSettings.ballRadius.S

    val P1Left = (PongSettings.paddleWallDist - PongSettings.paddleWidth - PongSettings.ballRadius).S
    val P1Right = (PongSettings.paddleWallDist + PongSettings.paddleWidth + PongSettings.ballRadius).S

    val P2Left = (640-(PongSettings.paddleWallDist + PongSettings.paddleWidth + PongSettings.ballRadius)).S
    val P2Right = (640 - (PongSettings.paddleWallDist - PongSettings.paddleWidth - PongSettings.ballRadius)).S


    when(!goingRight && (curPos(0) < (P1Right)) && (curPos(0) > P1Left) && ((io.P1Pos(1) - curPos(1)).abs < topBoundary)) {
      goingRight := 1.B
      goingDown := ballSpeed(1)^ballSpeed(0)^goingDown^goingRight.asBool
    }.elsewhen(goingRight && (curPos(0) < (P2Right)) && (curPos(0) > P2Left) && ((io.P2Pos(1) - curPos(1)).abs < topBoundary)) {
      goingRight := 0.B
      goingDown := ballSpeed(1)^ballSpeed(0)^goingDown^goingRight.asBool
      ballSpeed := ballSpeed + 1.S //Speed up ball
      }
  }

  //Update inbound
  val diffX = io.pos(0) - curPos(0)
  val diffY = io.pos(1) - curPos(1)
  val absX = diffX.abs.asUInt
  val absY = diffY.abs.asUInt
  val inSquare = (absX < PongSettings.ballRadius.U) && (absY < PongSettings.ballRadius.U)
  val inDiamond = absX + absY < PongSettings.ballRounding.U

  io.inbound := inSquare && inDiamond

  //Check for game over
  io.outRightBound := curPos(0) > 640.S
  io.outLeftBound := curPos(0) <= 0.S
}
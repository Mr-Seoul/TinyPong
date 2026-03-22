package vga

import chisel3._

class BallObjIO() extends Bundle {
  val posX = Input(SInt(11.W))
  val posY = Input(SInt(10.W))
  val inbound = Output(Bool())
  val P1PosY = Input(SInt(10.W))
  val P2PosY = Input(SInt(10.W))
  val updateLogic = Input(Bool())
  val outLeftBound = Output(Bool())
  val outRightBound = Output(Bool())
}

class BallObj(startX: Int,startY: Int) extends Module {
  val io = IO(new BallObjIO())

  val ballSpeed = RegInit(PongSettings.ballSpeed.S(6.W))

  val curPosX = RegInit(startX.S(11.W))
  val curPosY = RegInit(startY.S(10.W))

  val goingRight = RegInit(1.B)
  val goingDown = RegInit(1.B)

  //Game Logic
  when(io.updateLogic) {
    //Bouncing off top and bottom wall (This will clip into the walls, but saves on area)
    goingDown := Mux(curPosY < 0.S, 1.B, Mux(curPosY > (480.S - (2*PongSettings.ballRadius).S), 0.B, goingDown))
    val speedX = Mux(goingRight, ballSpeed, -ballSpeed)
    val speedY = Mux(goingDown, ballSpeed, -ballSpeed)
    curPosX := curPosX + speedX
    curPosY := curPosY + speedY

    //Bouncing off paddles (This will clip into the paddles, but saves on logic gates / area utilisation)
    val P1Left = (PongSettings.paddleWallDist - PongSettings.paddleWidth).S
    val P1Right = (PongSettings.paddleWallDist + 2*PongSettings.ballRadius).S
    val P1Top = (-PongSettings.paddleHeight - PongSettings.ballRadius).S + io.P1PosY
    val P1Bottom= io.P1PosY + PongSettings.ballRadius.S

    val P2Left = (640-(PongSettings.paddleWallDist + PongSettings.paddleWidth + 2*PongSettings.ballRadius)).S
    val P2Right = (640 -(PongSettings.paddleWallDist)).S
    val P2Top = (-PongSettings.paddleHeight - PongSettings.ballRadius).S + io.P2PosY
    val P2Bottom = io.P2PosY + PongSettings.ballRadius.S

    val newDir = ballSpeed(1)^ballSpeed(0)^goingDown^goingRight

    when(!goingRight && (curPosX < (P1Right)) && (curPosX > P1Left) && (curPosY < (P1Bottom)) && (curPosY > P1Top)) {
      goingRight := 1.B
      goingDown := newDir
    }.elsewhen(goingRight && (curPosX < (P2Right)) && (curPosX > P2Left) && (curPosY < (P2Bottom)) && (curPosY > P2Top)) {
      goingRight := 0.B
      goingDown := newDir
      ballSpeed := ballSpeed.asSInt + 1.S //Speed up ball
    }
  }

  //Update bounds (check if inside square)
  val inSquareX = (io.posX >= curPosX && io.posX < curPosX + (2*PongSettings.ballRadius).S)
  val inSquareY = (io.posY >= curPosY && io.posY < curPosY + (2*PongSettings.ballRadius).S)
  val inSquare = inSquareX && inSquareY
  io.inbound := inSquare

  //Check for game over (CurposX < 0 is more optimal due to not needing to check for 0 (only the signage), but if the ball position is stuck at (0,0), it will reset)
  io.outRightBound := curPosX > 640.S
  io.outLeftBound := curPosX <= 0.S
}
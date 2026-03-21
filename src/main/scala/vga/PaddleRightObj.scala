package vga

class PaddleRightObj(startX: Int,startY: Int) extends PaddleObj(startX: Int,startY: Int) {
  diffX := io.posX - curPosX
}
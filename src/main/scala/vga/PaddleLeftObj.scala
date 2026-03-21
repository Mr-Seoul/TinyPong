package vga

class PaddleLeftObj(startX: Int,startY: Int) extends PaddleObj(startX: Int,startY: Int) {
  diffX := curPosX - io.posX
}
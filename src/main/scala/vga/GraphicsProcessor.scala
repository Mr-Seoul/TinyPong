package vga

import chisel3._

class GraphicsProcessorIO extends Bundle {
  val col = new Col
  val indexX = Input(UInt(10.W))
  val indexY = Input(UInt(10.W))
}

class GraphicsProcessor extends Module {
  val io = IO(new GraphicsProcessorIO)
  val curcolour = (io.indexX + io.indexY) % 4.U
  io.col.R := curcolour
  io.col.G := curcolour
  io.col.B := curcolour
}
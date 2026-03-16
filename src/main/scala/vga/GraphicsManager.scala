package vga

import chisel3._

class Col extends Bundle {
  val R = UInt(2.W)
  val G = UInt(2.W)
  val B = UInt(2.W)

  def default: Col = {
    val res = Wire(new Col)
    res.R := 0.U
    res.G := 0.U
    res.B := 0.U
    res
  }
}
// Index is from the vga, xy is from the processing unit.
class GraphicsManagerIO extends Bundle {
  val col = new Col
  val indexX = Input(UInt(10.W))
  val indexY = Input(UInt(10.W))
  val screenDone = Input(Bool())
  val input1 = Input(Bool())
  val input2 = Input(Bool())
}

class GraphicsManager extends Module {
  val io = IO(new GraphicsManagerIO)

  //Base graphics
  val gpu = Module(new GraphicsProcessor)
  gpu.io.indexX := io.indexX
  gpu.io.indexY := io.indexY
  gpu.io.screenDone := io.screenDone
  gpu.io.input1 := io.input1
  gpu.io.input2 := io.input2

  //Add filters here later. Maybe a noise filter to make it more realistic?

  //Right now I have a strobe effect as a MVP. Later I will read from the buffer array once some logic is implemented
  val valid = io.indexY < 480.U && io.indexX < 640.U
  io.col.R := Mux(valid,gpu.io.col.R,0.U)
  io.col.G := Mux(valid,gpu.io.col.G,0.U)
  io.col.B := Mux(valid,gpu.io.col.B,0.U)
}


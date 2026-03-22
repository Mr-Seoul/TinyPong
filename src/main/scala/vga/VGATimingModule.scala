package vga

import chisel3._

class VGATimingIO extends Bundle {
  val hsync = Output(Bool())
  val vsync = Output(Bool())
  val indexX = Input(UInt(11.W))
  val indexY = Input(UInt(10.W))
}

class VGATimingModule extends Module {
  val io = IO(new VGATimingIO)

  //Sync signals
  io.hsync := Mux(io.indexX > 655.U && io.indexX < 752.U,0.U,1.U)
  io.vsync := Mux(io.indexY > 489.U && io.indexY < 492.U,0.U,1.U)
}
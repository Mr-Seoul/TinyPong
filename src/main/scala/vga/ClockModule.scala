package vga

import chisel3._
import chisel3.util.Counter

class ClockIO extends Bundle {
  val clk = Output(Bool())
}

//Slows 100 Mhz clock to 25 mhz clock for FPGA
class ClockModule extends Module {
  val io = IO(new ClockIO)

  val clockCount = RegInit(0.U(2.W))
  clockCount := clockCount + 1.U
  io.clk := clockCount === 3.U
}
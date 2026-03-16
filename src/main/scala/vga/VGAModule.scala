package vga

import chisel3._
import chisel3.util.Counter

class VGAIO extends Bundle {
  val col = Output(new Col)
  val hsync = Output(Bool())
  val vsync = Output(Bool())
  //val Hdebug = Output(UInt(10.W))
  //val Vdebug = Output(UInt(10.W))
  val input1 = Input(Bool())
  val input2 = Input(Bool())
}

class VGAModule extends Module {
  val io = IO(new VGAIO)

  //Clock module and counters
  val slowClock = Module(new ClockModule)
  val (hCounter,hWrap) = Counter(slowClock.io.clk,800)
  val (vCounter,vWrap) = Counter(hWrap && slowClock.io.clk, 525)

  //io.Hdebug := hCounter
  //io.Vdebug := vCounter
  val graphics = Module(new GraphicsManager())

  //Default IO
  graphics.io.indexX := hCounter
  graphics.io.indexY := vCounter
  graphics.io.screenDone := vWrap
  graphics.io.input1 := io.input1
  graphics.io.input2 := io.input2
  io.col.R := graphics.io.col.R
  io.col.G := graphics.io.col.G
  io.col.B := graphics.io.col.B

  //Sync signals
  io.hsync := Mux(hCounter > 655.U && hCounter < 752.U,0.U,1.U)
  io.vsync := Mux(vCounter > 489.U && vCounter < 492.U,0.U,1.U)
}

object Main extends App {
  emitVerilog(new VGAModule)
}
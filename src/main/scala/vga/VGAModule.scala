package vga

import chisel3._
import chisel3.util.Counter

class VGAIO extends Bundle {
  val col = Output(new Col)
  val hsync = Output(Bool())
  val vsync = Output(Bool())
  val input1 = Input(Bool())
  val input2 = Input(Bool())
}

class VGAModule extends Module {
  val io = IO(new VGAIO)

  val resetModule = Module(new resetSynchronizer())
  val syncReset = resetModule.io.syncReset

  withReset(syncReset) {
    //Clock module and counters (For FPGA)
    //val slowClock = Module(new ClockModule)
    //val (hCounter,hWrap) = Counter(slowClock.io.clk,800)
    //val (vCounter,vWrap) = Counter(hWrap && slowClock.io.clk, 525)

    //Clock module and counters (For Tiny Tapeout)
    val (hCounter,hWrap) = Counter(1.B,800)
    val (vCounter,vWrap) = Counter(hWrap, 525)

    val graphics = Module(new GraphicsManager())

    //Default IO for graphics
    graphics.io.indexX := hCounter
    graphics.io.indexY := vCounter
    graphics.io.screenDone := vWrap

    //Input Debouncing
    val debouncer1 = Module(new DebouncerModule(19))
    val debouncer2 = Module(new DebouncerModule(19))
    debouncer1.io.in := io.input1
    debouncer2.io.in := io.input2

    //Graphics and colour output
    graphics.io.input1 := debouncer1.io.out
    graphics.io.input2 := debouncer2.io.out
    io.col.R := graphics.io.col.R
    io.col.G := graphics.io.col.G
    io.col.B := graphics.io.col.B

    //Sync signals (following VGA standard)
    val TimingModule = Module(new VGATimingModule)
    TimingModule.io.indexX := hCounter
    TimingModule.io.indexY := vCounter
    io.hsync := TimingModule.io.hsync
    io.vsync := TimingModule.io.vsync
  }
}

object Main extends App {
  emitVerilog(new VGAModule)
}
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

    //Input Debouncing (19 bits were chosen for 20 ms of deboucning)
    val debouncer1 = Module(new DebouncerModule(19))
    val debouncer2 = Module(new DebouncerModule(19))
    debouncer1.io.in := io.input1
    debouncer2.io.in := io.input2

    //Default IO for graphics (connect the graphics manager)
    graphics.io.indexX := hCounter
    graphics.io.indexY := vCounter
    graphics.io.screenDone := vWrap
    graphics.io.input1 := debouncer1.io.out
    graphics.io.input2 := debouncer2.io.out
    val rReg = RegInit(0.U(2.W))
    val gReg = RegInit(0.U(2.W))
    val bReg = RegInit(0.U(2.W))
    rReg := graphics.io.col.R
    gReg := graphics.io.col.G
    bReg := graphics.io.col.B

    //Sync signals (following VGA standard)
    val TimingModule = Module(new VGATimingModule)
    TimingModule.io.indexX := hCounter
    TimingModule.io.indexY := vCounter
    val hSyncReg = RegInit(1.U(1.W))
    val vSyncReg = RegInit(1.U(1.W))
    hSyncReg := TimingModule.io.hsync
    vSyncReg := TimingModule.io.vsync

    //Register the outputs (just in case)
    io.col.R := rReg
    io.col.G := gReg
    io.col.B := bReg
    io.hsync := hSyncReg
    io.vsync := vSyncReg
  }
}

object Main extends App {
  emitVerilog(new VGAModule)
}
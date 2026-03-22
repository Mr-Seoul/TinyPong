package vga

import chisel3._
import chisel3.util.Counter

class DebouncerIO extends Bundle {
  val in = Input(Bool())
  val out = Output(Bool())
}

class DebouncerModule(maxRegSize : Int) extends Module {
  val io = IO(new DebouncerIO)

  //Syncing pipeline (3 registers may be a bit much, but at least the output is stable)
  val sync0 = RegNext(io.in)
  val sync1 = RegNext(sync0)
  val sync2 = RegNext(sync1)

  val count = RegInit(0.U(maxRegSize.W))
  val maxVal = (1 << maxRegSize) - 1

  //Output
  val out = RegInit(0.B)
  io.out := out

  //Debouncing logic (If the input is different from before, change if stable for long enough)
  when (sync2 =/= out) {
    count := count + 1.U
    when (count === maxVal.U) {
      out := sync2
    }
  } .otherwise {
    count := 0.U
  }
}
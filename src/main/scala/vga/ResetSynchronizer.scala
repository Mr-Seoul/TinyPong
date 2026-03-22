package vga

import chisel3._
import chisel3.util.Counter

class resetSynchronizerIO extends Bundle {
  val syncReset = Output(AsyncReset())
}

class resetSynchronizer extends Module {
  val io = IO(new resetSynchronizerIO)

  withReset(reset.asAsyncReset) {
    //Reset Pipeline. Delays the reset clock to make sure that the signal is cleanish
    val resetReg1 = RegInit(1.B)
    val resetReg2 = RegInit(1.B)
    resetReg1 := 0.B
    resetReg2 := resetReg1

    io.syncReset := resetReg2.asAsyncReset
  }
}
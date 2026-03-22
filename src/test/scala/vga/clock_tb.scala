import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import vga.ClockModule


class clock_tb extends AnyFlatSpec with ChiselScalatestTester {
  it should "clock every 4 cycles" in {
    test(new ClockModule) { dut =>
      dut.clock.setTimeout(0)
      for (i <- 0 until 1000) {
        if (i % 4 == 3) {
          dut.io.clk.expect(1.B)
        } else {
          dut.io.clk.expect(0.B)
        }
        dut.clock.step()
      }
    }
  }
}
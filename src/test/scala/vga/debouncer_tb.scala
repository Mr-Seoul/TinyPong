import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import vga.DebouncerModule


class debouncer_tb extends AnyFlatSpec with ChiselScalatestTester {
  it should "debounce 1s " in {
    test(new DebouncerModule(5)) { dut =>
      dut.clock.setTimeout(0)
      dut.reset.poke(1.B)
      dut.clock.step()
      dut.reset.poke(0.B)
      dut.clock.step()

      dut.io.in.poke(1.B)
      dut.clock.step(35)
      dut.io.out.expect(1.B)

      dut.clock.step(19)
      dut.io.in.poke(0.B)
      dut.clock.step(1)
      dut.io.in.poke(1.B)
      dut.clock.step(15)
      dut.io.out.expect(1.B)
    }
  }
  it should "debounce 0s " in {
    test(new DebouncerModule(5)) { dut =>
      dut.clock.setTimeout(0)
      dut.reset.poke(1.B)
      dut.clock.step()
      dut.reset.poke(0.B)
      dut.clock.step()

      dut.io.in.poke(0.B)
      dut.clock.step(35)
      dut.io.out.expect(0.B)

      dut.clock.step(19)
      dut.io.in.poke(1.B)
      dut.clock.step(1)
      dut.io.in.poke(0.B)
      dut.clock.step(15)
      dut.io.out.expect(0.B)
    }
  }
}
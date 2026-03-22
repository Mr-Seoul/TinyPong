import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import vga.BallObj

class ball_tb extends AnyFlatSpec with ChiselScalatestTester {
  it should "not falsely detect out of bounds" in {
    test(new BallObj(320,240)) { dut =>
      dut.clock.setTimeout(0)
      dut.clock.step()
      dut.io.outLeftBound.expect(0.B)
      dut.io.outRightBound.expect(0.B)
    }
  }
  it should "detect left out of bounds" in {
    test(new BallObj(-100,240)) { dut =>
      dut.clock.setTimeout(0)
      dut.clock.step()
      dut.io.outLeftBound.expect(1.B)
      dut.io.outRightBound.expect(0.B)
    }
  }
  it should "detect right out of bounds" in {
    test(new BallObj(700,240)) { dut =>
      dut.clock.setTimeout(0)
      dut.clock.step()
      dut.io.outLeftBound.expect(0.B)
      dut.io.outRightBound.expect(1.B)
    }
  }
}
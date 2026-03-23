import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import scala.util.Random
import vga.VGATimingModule

class vgatiming_tb extends AnyFlatSpec with ChiselScalatestTester {
  it should "hsync" in {
    test(new VGATimingModule) { dut =>
      dut.clock.setTimeout(0)

      val nums = Seq.fill(10000)(Random.nextInt(10000))
      for (i <- nums) {
        val x = i % 800
        val y = i / 800
        dut.io.indexX.poke(x.U)
        dut.io.indexY.poke(y.U)
        dut.clock.step()
        if (x > 655 && x < 752) {
          dut.io.hsync.expect(0.U)
        } else {
          dut.io.hsync.expect(1.U)
        }
      }

    }
  }
  it should "vsync" in {
    test(new VGATimingModule) { dut =>
      dut.clock.setTimeout(0)

      val nums = Seq.fill(10000)(Random.nextInt(10000))
      for (i <- nums) {
        val x = i % 800
        val y = i / 800
        dut.io.indexX.poke(x.U)
        dut.io.indexY.poke(y.U)
        if (y > 489 && y < 492) {
          dut.io.vsync.expect(0.U)
        } else {
          dut.io.vsync.expect(1.U)
        }
        dut.clock.step()
      }
    }
  }
}
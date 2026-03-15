
import chisel3._
import chisel3.experimental.BundleLiterals._
import org.scalatest.freespec.AnyFreeSpec
import org.scalatest.matchers.must.Matchers
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import scala.util.Random

import vga.VGAModule
import vga.GraphicsManager

class graphicsmanager_tb extends AnyFlatSpec with ChiselScalatestTester {
  it should "not write data in inactive area" in {
    test(new GraphicsManager) { dut =>
      dut.clock.setTimeout(0)

      val nums = Seq.fill(10000)(Random.nextInt(10000))
      for (i <- nums) {
        val x = i % 800
        val y = i / 800
        val expectedval = (x+y) % 4
        dut.io.indexX.poke(x.U)
        dut.io.indexY.poke(y.U)
        if (x < 640 && y < 480) {
          //Data doesn't matter here
        } else {
          //NO DATA IN THE INACTIVE AREA
          dut.io.col.R.expect(0.U)
          dut.io.col.G.expect(0.U)
          dut.io.col.B.expect(0.U)
        }
        //Because of slowed clock cycle
        for (i <- 0 until 4) {
          dut.clock.step()
        }
      }
    }
  }
}

class vga_tb extends AnyFlatSpec with ChiselScalatestTester {
  it should "hsync" in {
    test(new VGAModule) { dut =>
      dut.clock.setTimeout(0)

      val max = 10
      for (i <- 0 until 800*max) {
        if (dut.io.Hdebug.peekInt() > 655 && dut.io.Hdebug.peekInt() < 752) {
          dut.io.hsync.expect(0.U)
        } else {
          dut.io.hsync.expect(1.U)
        }
        //Because of slowed clock cycle
        for (i <- 0 until 4) {
          dut.clock.step()
        }
      }
    }
  }
  it should "vsync" in {
    test(new VGAModule) { dut =>
      dut.clock.setTimeout(0)

      for (i <- 0 to 800*525) {
        if (dut.io.Vdebug.peekInt() > 489 && dut.io.Vdebug.peekInt() < 492) {
          dut.io.vsync.expect(0.U)
        } else {
          dut.io.vsync.expect(1.U)
        }
        //Because of slowed clock cycle
        for (i <- 0 until 4) {
          dut.clock.step()
        }
      }
    }
  }
}
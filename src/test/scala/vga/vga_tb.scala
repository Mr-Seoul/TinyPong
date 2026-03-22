
import chisel3._
import chisel3.experimental.BundleLiterals._
import org.scalatest.freespec.AnyFreeSpec
import org.scalatest.matchers.must.Matchers
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import scala.util.Random

import vga.VGAModule
import vga.GraphicsManager
import vga.ClockModule
import vga.DebouncerModule

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
        dut.clock.step()
      }
    }
  }
}

class vga_tb extends AnyFlatSpec with ChiselScalatestTester {
  it should "hsync" in {
    test(new VGAModule) { dut =>
      dut.clock.setTimeout(0)

      var hCounter = 0

      val max = 10
      for (i <- 0 until 800*max) {
        if (hCounter > 655 && hCounter < 752) {
          dut.io.hsync.expect(0.U)
        } else {
          dut.io.hsync.expect(1.U)
        }
        dut.clock.step()
        hCounter += 1
        if (hCounter >= 800) {
          hCounter = 0
        }
      }
    }
  }
  it should "vsync" in {
    test(new VGAModule) { dut =>
      dut.clock.setTimeout(0)

      var hCounter = 0
      var vCounter = 0

      for (i <- 0 to 800*525) {
        if (vCounter > 489 && vCounter < 492) {
          dut.io.vsync.expect(0.U)
        } else {
          dut.io.vsync.expect(1.U)
        }
        dut.clock.step()
        hCounter += 1
        if (hCounter >= 800) {
          hCounter = 0
          vCounter += 1
          if (vCounter >= 528) {
            vCounter = 0
          }
        }
      }
    }
  }
}

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

class debouncer_tb extends AnyFlatSpec with ChiselScalatestTester {
  it should "Debounce 1s " in {
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
  it should "Debounce 0s " in {
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

//Write test cases for paddle and ball
//Paddle: Test for jumping and clipping the boundaries
//Ball: Test for moving, bouncing, and game over logic
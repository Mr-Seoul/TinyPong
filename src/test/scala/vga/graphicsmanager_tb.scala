import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import scala.util.Random
import vga.GraphicsManager

class graphicsmanager_tb extends AnyFlatSpec with ChiselScalatestTester {
  it should "not write data in inactive area" in {
    test(new GraphicsManager) { dut =>
      dut.clock.setTimeout(0)

      val nums = Seq.fill(10000)(Random.nextInt(10000))
      for (i <- nums) {
        val x = i % 800
        val y = i / 800
        dut.io.indexX.poke(x.U)
        dut.io.indexY.poke(y.U)
        dut.clock.step()
        if (x < 640 && y < 480) {
          //Data doesn't matter here
        } else {
          //NO DATA IN THE INACTIVE AREA
          dut.io.col.R.expect(0.U)
          dut.io.col.G.expect(0.U)
          dut.io.col.B.expect(0.U)
        }
      }
    }
  }
}
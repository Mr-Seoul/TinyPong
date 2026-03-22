import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

import vga.{PaddleRightObj, PongSettings}

class rightPaddle_tb extends AnyFlatSpec with ChiselScalatestTester {
  it should "jump" in {
    test(new PaddleRightObj(600,240)) { dut =>
      dut.io.input.poke(1.B)
      dut.clock.step()
      dut.io.updateLogic.poke(1.B)
      dut.clock.step()
      dut.io.input.poke(0.B)
      dut.io.updateLogic.poke(0.B)
      dut.clock.step()
      dut.io.updateLogic.poke(1.B)
      dut.clock.step()
      dut.io.updateLogic.poke(0.B)
      dut.clock.step()
      dut.io.paddlePosY.expect((240 - PongSettings.paddleJumpSpeed).S)
      dut.io.updateLogic.poke(1.B)
      dut.clock.step()
      dut.io.updateLogic.poke(0.B)
      dut.clock.step()
      dut.io.input.poke(0.B)
      dut.io.paddlePosY.expect((240 - 2*PongSettings.paddleJumpSpeed+1).S)
    }
  }
  it should "fall (with gravity)" in {
    test(new PaddleRightObj(600,240)) { dut =>
      dut.io.input.poke(0.B)
      dut.io.updateLogic.poke(1.B)
      dut.clock.step()
      dut.io.updateLogic.poke(0.B)
      dut.clock.step()
      dut.io.updateLogic.poke(1.B)
      dut.clock.step()
      dut.io.updateLogic.poke(0.B)
      dut.clock.step()
      dut.io.paddlePosY.expect(241.S) // 240 + 1
      dut.io.updateLogic.poke(1.B)
      dut.clock.step()
      dut.io.updateLogic.poke(0.B)
      dut.clock.step()
      dut.io.paddlePosY.expect(243.S) //241 + 2
    }
  }
  it should "not clip top boundary" in {
    test(new PaddleRightObj(600,240)) { dut =>
      for (i <- 0 until 32) {//Make sure it reaches top
        dut.io.input.poke(1.B)
        dut.io.updateLogic.poke(1.B)
        dut.clock.step()
        dut.io.updateLogic.poke(0.B)
        dut.clock.step()
      }
      dut.io.paddlePosY.expect(PongSettings.paddleHeight.S)
      dut.clock.step()
      dut.io.paddlePosY.expect(PongSettings.paddleHeight.S)
    }
  }
  it should "not clip bottom boundary" in {
    test(new PaddleRightObj(600,240)) { dut =>
      dut.io.input.poke(0.B)
      for (i <- 0 until 32) {//Make sure it reaches bottom
        dut.io.updateLogic.poke(1.B)
        dut.clock.step(1)
        dut.io.updateLogic.poke(0.B)
        dut.clock.step(1)
      }

      dut.io.paddlePosY.expect(480.S)
      dut.clock.step()
      dut.io.paddlePosY.expect(480.S)
    }
  }
}
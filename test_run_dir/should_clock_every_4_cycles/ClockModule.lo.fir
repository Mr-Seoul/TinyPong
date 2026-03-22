FIRRTL version 1.2.0
circuit ClockModule :
  module ClockModule :
    input clock : Clock
    input reset : UInt<1>
    output io_clk : UInt<1> @[\\src\\main\\scala\\vga\\ClockModule.scala 12:14]

    reg clockCount : UInt<2>, clock with :
      reset => (UInt<1>("h0"), clockCount) @[\\src\\main\\scala\\vga\\ClockModule.scala 14:27]
    node _clockCount_T = add(clockCount, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\ClockModule.scala 15:28]
    node _clockCount_T_1 = tail(_clockCount_T, 1) @[\\src\\main\\scala\\vga\\ClockModule.scala 15:28]
    node _io_clk_T = eq(clockCount, UInt<2>("h3")) @[\\src\\main\\scala\\vga\\ClockModule.scala 16:24]
    io_clk <= _io_clk_T @[\\src\\main\\scala\\vga\\ClockModule.scala 16:10]
    clockCount <= mux(reset, UInt<2>("h0"), _clockCount_T_1) @[\\src\\main\\scala\\vga\\ClockModule.scala 14:{27,27} 15:14]

FIRRTL version 1.2.0
circuit DebouncerModule :
  module DebouncerModule :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<1> @[\\src\\main\\scala\\vga\\Debouncer.scala 12:14]
    output io_out : UInt<1> @[\\src\\main\\scala\\vga\\Debouncer.scala 12:14]

    reg sync0 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sync0) @[\\src\\main\\scala\\vga\\Debouncer.scala 15:22]
    reg sync1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sync1) @[\\src\\main\\scala\\vga\\Debouncer.scala 16:22]
    reg sync2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sync2) @[\\src\\main\\scala\\vga\\Debouncer.scala 17:22]
    reg count : UInt<5>, clock with :
      reset => (UInt<1>("h0"), count) @[\\src\\main\\scala\\vga\\Debouncer.scala 22:22]
    reg out : UInt<1>, clock with :
      reset => (UInt<1>("h0"), out) @[\\src\\main\\scala\\vga\\Debouncer.scala 26:20]
    node _T = neq(sync2, out) @[\\src\\main\\scala\\vga\\Debouncer.scala 30:15]
    node _count_T = add(count, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\Debouncer.scala 31:20]
    node _count_T_1 = tail(_count_T, 1) @[\\src\\main\\scala\\vga\\Debouncer.scala 31:20]
    node _T_1 = eq(count, UInt<5>("h1f")) @[\\src\\main\\scala\\vga\\Debouncer.scala 32:17]
    node _GEN_0 = mux(_T_1, sync2, out) @[\\src\\main\\scala\\vga\\Debouncer.scala 32:31 33:11 26:20]
    node _GEN_1 = mux(_T, _count_T_1, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\Debouncer.scala 30:24 31:11 36:11]
    node _GEN_2 = mux(_T, _GEN_0, out) @[\\src\\main\\scala\\vga\\Debouncer.scala 26:20 30:24]
    io_out <= out @[\\src\\main\\scala\\vga\\Debouncer.scala 27:10]
    sync0 <= mux(reset, UInt<1>("h0"), io_in) @[\\src\\main\\scala\\vga\\Debouncer.scala 15:{22,22} 18:9]
    sync1 <= mux(reset, UInt<1>("h0"), sync0) @[\\src\\main\\scala\\vga\\Debouncer.scala 16:{22,22} 19:9]
    sync2 <= mux(reset, UInt<1>("h0"), sync1) @[\\src\\main\\scala\\vga\\Debouncer.scala 17:{22,22} 20:9]
    count <= mux(reset, UInt<5>("h0"), _GEN_1) @[\\src\\main\\scala\\vga\\Debouncer.scala 22:{22,22}]
    out <= mux(reset, UInt<1>("h0"), _GEN_2) @[\\src\\main\\scala\\vga\\Debouncer.scala 26:{20,20}]

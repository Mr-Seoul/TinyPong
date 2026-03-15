FIRRTL version 1.2.0
circuit VGAModule :
  module ClockModule :
    input clock : Clock
    input reset : Reset
    output io : { clk : UInt<1>} @[\\src\\main\\scala\\vga\\ClockModule.scala 12:14]

    reg clockCount : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[\\src\\main\\scala\\vga\\ClockModule.scala 14:27]
    node _clockCount_T = add(clockCount, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\ClockModule.scala 15:28]
    node _clockCount_T_1 = tail(_clockCount_T, 1) @[\\src\\main\\scala\\vga\\ClockModule.scala 15:28]
    clockCount <= _clockCount_T_1 @[\\src\\main\\scala\\vga\\ClockModule.scala 15:14]
    node _io_clk_T = eq(clockCount, UInt<2>("h3")) @[\\src\\main\\scala\\vga\\ClockModule.scala 16:25]
    io.clk <= _io_clk_T @[\\src\\main\\scala\\vga\\ClockModule.scala 16:10]

  module Buffer :
    input clock : Clock
    input reset : Reset
    output io : { col : { R : UInt<2>, G : UInt<2>, B : UInt<2>}, flip indexX : UInt<10>, flip indexY : UInt<10>} @[\\src\\main\\scala\\vga\\Buffer.scala 26:14]

    smem bufferarray : { R : UInt<2>, G : UInt<2>, B : UInt<2>} [307200] @[\\src\\main\\scala\\vga\\Buffer.scala 27:32]
    node _curcolour_T = add(io.indexX, io.indexY) @[\\src\\main\\scala\\vga\\Buffer.scala 29:30]
    node _curcolour_T_1 = tail(_curcolour_T, 1) @[\\src\\main\\scala\\vga\\Buffer.scala 29:30]
    node curcolour = rem(_curcolour_T_1, UInt<3>("h4")) @[\\src\\main\\scala\\vga\\Buffer.scala 29:43]
    node _valid_T = lt(io.indexY, UInt<9>("h1e0")) @[\\src\\main\\scala\\vga\\Buffer.scala 32:25]
    node _valid_T_1 = lt(io.indexX, UInt<10>("h280")) @[\\src\\main\\scala\\vga\\Buffer.scala 32:46]
    node valid = and(_valid_T, _valid_T_1) @[\\src\\main\\scala\\vga\\Buffer.scala 32:33]
    node _io_col_R_T = mux(valid, curcolour, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\Buffer.scala 33:18]
    io.col.R <= _io_col_R_T @[\\src\\main\\scala\\vga\\Buffer.scala 33:12]
    node _io_col_G_T = mux(valid, curcolour, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\Buffer.scala 34:18]
    io.col.G <= _io_col_G_T @[\\src\\main\\scala\\vga\\Buffer.scala 34:12]
    node _io_col_B_T = mux(valid, curcolour, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\Buffer.scala 35:18]
    io.col.B <= _io_col_B_T @[\\src\\main\\scala\\vga\\Buffer.scala 35:12]

  module VGAModule :
    input clock : Clock
    input reset : UInt<1>
    output io : { col : { R : UInt<2>, G : UInt<2>, B : UInt<2>}, hsync : UInt<1>, vsync : UInt<1>} @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]

    inst slowClock of ClockModule @[\\src\\main\\scala\\vga\\VGAModule.scala 18:25]
    slowClock.clock <= clock
    slowClock.reset <= reset
    reg hCounter : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[src/main/scala/chisel3/util/Counter.scala 61:40]
    wire hWrap : UInt<1> @[src/main/scala/chisel3/util/Counter.scala 117:24]
    hWrap <= UInt<1>("h0") @[src/main/scala/chisel3/util/Counter.scala 117:24]
    when slowClock.io.clk : @[src/main/scala/chisel3/util/Counter.scala 118:16]
      node wrap_wrap = eq(hCounter, UInt<10>("h31f")) @[src/main/scala/chisel3/util/Counter.scala 73:24]
      node _wrap_value_T = add(hCounter, UInt<1>("h1")) @[src/main/scala/chisel3/util/Counter.scala 77:24]
      node _wrap_value_T_1 = tail(_wrap_value_T, 1) @[src/main/scala/chisel3/util/Counter.scala 77:24]
      hCounter <= _wrap_value_T_1 @[src/main/scala/chisel3/util/Counter.scala 77:15]
      when wrap_wrap : @[src/main/scala/chisel3/util/Counter.scala 87:20]
        hCounter <= UInt<1>("h0") @[src/main/scala/chisel3/util/Counter.scala 87:28]
      hWrap <= wrap_wrap @[src/main/scala/chisel3/util/Counter.scala 118:23]
    node _T = and(hWrap, slowClock.io.clk) @[\\src\\main\\scala\\vga\\VGAModule.scala 20:40]
    reg vCounter : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[src/main/scala/chisel3/util/Counter.scala 61:40]
    wire vWrap : UInt<1> @[src/main/scala/chisel3/util/Counter.scala 117:24]
    vWrap <= UInt<1>("h0") @[src/main/scala/chisel3/util/Counter.scala 117:24]
    when _T : @[src/main/scala/chisel3/util/Counter.scala 118:16]
      node wrap_wrap_1 = eq(vCounter, UInt<10>("h20c")) @[src/main/scala/chisel3/util/Counter.scala 73:24]
      node _wrap_value_T_2 = add(vCounter, UInt<1>("h1")) @[src/main/scala/chisel3/util/Counter.scala 77:24]
      node _wrap_value_T_3 = tail(_wrap_value_T_2, 1) @[src/main/scala/chisel3/util/Counter.scala 77:24]
      vCounter <= _wrap_value_T_3 @[src/main/scala/chisel3/util/Counter.scala 77:15]
      when wrap_wrap_1 : @[src/main/scala/chisel3/util/Counter.scala 87:20]
        vCounter <= UInt<1>("h0") @[src/main/scala/chisel3/util/Counter.scala 87:28]
      vWrap <= wrap_wrap_1 @[src/main/scala/chisel3/util/Counter.scala 118:23]
    inst buf of Buffer @[\\src\\main\\scala\\vga\\VGAModule.scala 24:19]
    buf.clock <= clock
    buf.reset <= reset
    buf.io.indexX <= hCounter @[\\src\\main\\scala\\vga\\VGAModule.scala 27:17]
    buf.io.indexY <= vCounter @[\\src\\main\\scala\\vga\\VGAModule.scala 28:17]
    io.col.R <= buf.io.col.R @[\\src\\main\\scala\\vga\\VGAModule.scala 29:12]
    io.col.G <= buf.io.col.G @[\\src\\main\\scala\\vga\\VGAModule.scala 30:12]
    io.col.B <= buf.io.col.B @[\\src\\main\\scala\\vga\\VGAModule.scala 31:12]
    node _io_hsync_T = gt(hCounter, UInt<10>("h28f")) @[\\src\\main\\scala\\vga\\VGAModule.scala 34:28]
    node _io_hsync_T_1 = lt(hCounter, UInt<10>("h2f0")) @[\\src\\main\\scala\\vga\\VGAModule.scala 34:48]
    node _io_hsync_T_2 = and(_io_hsync_T, _io_hsync_T_1) @[\\src\\main\\scala\\vga\\VGAModule.scala 34:36]
    node _io_hsync_T_3 = mux(_io_hsync_T_2, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 34:18]
    io.hsync <= _io_hsync_T_3 @[\\src\\main\\scala\\vga\\VGAModule.scala 34:12]
    node _io_vsync_T = gt(vCounter, UInt<9>("h1e9")) @[\\src\\main\\scala\\vga\\VGAModule.scala 35:28]
    node _io_vsync_T_1 = lt(vCounter, UInt<9>("h1ec")) @[\\src\\main\\scala\\vga\\VGAModule.scala 35:48]
    node _io_vsync_T_2 = and(_io_vsync_T, _io_vsync_T_1) @[\\src\\main\\scala\\vga\\VGAModule.scala 35:36]
    node _io_vsync_T_3 = mux(_io_vsync_T_2, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 35:18]
    io.vsync <= _io_vsync_T_3 @[\\src\\main\\scala\\vga\\VGAModule.scala 35:12]


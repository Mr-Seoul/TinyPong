FIRRTL version 1.2.0
circuit VGAModule :
  module ClockModule :
    input clock : Clock
    input reset : UInt<1>
    output io_clk : UInt<1> @[\\src\\main\\scala\\vga\\ClockModule.scala 12:14]

    reg clockCount : UInt<2>, clock with :
      reset => (UInt<1>("h0"), clockCount) @[\\src\\main\\scala\\vga\\ClockModule.scala 14:27]
    node _clockCount_T = add(clockCount, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\ClockModule.scala 15:28]
    node _clockCount_T_1 = tail(_clockCount_T, 1) @[\\src\\main\\scala\\vga\\ClockModule.scala 15:28]
    node _io_clk_T = eq(clockCount, UInt<2>("h3")) @[\\src\\main\\scala\\vga\\ClockModule.scala 16:25]
    io_clk <= _io_clk_T @[\\src\\main\\scala\\vga\\ClockModule.scala 16:10]
    clockCount <= mux(reset, UInt<2>("h0"), _clockCount_T_1) @[\\src\\main\\scala\\vga\\ClockModule.scala 14:{27,27} 15:14]

  module GraphicsProcessor :
    input clock : Clock
    input reset : UInt<1>
    output io_col_R : UInt<2> @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 12:14]
    output io_col_G : UInt<2> @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 12:14]
    output io_col_B : UInt<2> @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 12:14]
    input io_indexX : UInt<10> @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 12:14]
    input io_indexY : UInt<10> @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 12:14]

    node _curcolour_T = add(io_indexX, io_indexY) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 13:30]
    node _curcolour_T_1 = tail(_curcolour_T, 1) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 13:30]
    node curcolour = rem(_curcolour_T_1, UInt<3>("h4")) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 13:43]
    io_col_R <= bits(curcolour, 1, 0) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 14:12]
    io_col_G <= bits(curcolour, 1, 0) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 15:12]
    io_col_B <= bits(curcolour, 1, 0) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 16:12]

  module GraphicsManager :
    input clock : Clock
    input reset : UInt<1>
    output io_col_R : UInt<2> @[\\src\\main\\scala\\vga\\GraphicsManager.scala 26:14]
    output io_col_G : UInt<2> @[\\src\\main\\scala\\vga\\GraphicsManager.scala 26:14]
    output io_col_B : UInt<2> @[\\src\\main\\scala\\vga\\GraphicsManager.scala 26:14]
    input io_indexX : UInt<10> @[\\src\\main\\scala\\vga\\GraphicsManager.scala 26:14]
    input io_indexY : UInt<10> @[\\src\\main\\scala\\vga\\GraphicsManager.scala 26:14]

    inst gpu of GraphicsProcessor @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:19]
    node _valid_T = lt(io_indexY, UInt<9>("h1e0")) @[\\src\\main\\scala\\vga\\GraphicsManager.scala 36:25]
    node _valid_T_1 = lt(io_indexX, UInt<10>("h280")) @[\\src\\main\\scala\\vga\\GraphicsManager.scala 36:46]
    node valid = and(_valid_T, _valid_T_1) @[\\src\\main\\scala\\vga\\GraphicsManager.scala 36:33]
    node _io_col_R_T = mux(valid, gpu.io_col_R, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\GraphicsManager.scala 37:18]
    node _io_col_G_T = mux(valid, gpu.io_col_R, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\GraphicsManager.scala 38:18]
    node _io_col_B_T = mux(valid, gpu.io_col_R, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\GraphicsManager.scala 39:18]
    io_col_R <= _io_col_R_T @[\\src\\main\\scala\\vga\\GraphicsManager.scala 37:12]
    io_col_G <= _io_col_G_T @[\\src\\main\\scala\\vga\\GraphicsManager.scala 38:12]
    io_col_B <= _io_col_B_T @[\\src\\main\\scala\\vga\\GraphicsManager.scala 39:12]
    gpu.clock <= clock
    gpu.reset <= reset
    gpu.io_indexX <= io_indexX @[\\src\\main\\scala\\vga\\GraphicsManager.scala 30:17]
    gpu.io_indexY <= io_indexY @[\\src\\main\\scala\\vga\\GraphicsManager.scala 31:17]

  module VGAModule :
    input clock : Clock
    input reset : UInt<1>
    output io_col_R : UInt<2> @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
    output io_col_G : UInt<2> @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
    output io_col_B : UInt<2> @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
    output io_hsync : UInt<1> @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
    output io_vsync : UInt<1> @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
    output io_Hdebug : UInt<10> @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]
    output io_Vdebug : UInt<10> @[\\src\\main\\scala\\vga\\VGAModule.scala 15:14]

    inst slowClock of ClockModule @[\\src\\main\\scala\\vga\\VGAModule.scala 18:25]
    inst graphics of GraphicsManager @[\\src\\main\\scala\\vga\\VGAModule.scala 24:24]
    reg hCounter : UInt<10>, clock with :
      reset => (UInt<1>("h0"), hCounter) @[src/main/scala/chisel3/util/Counter.scala 61:40]
    node wrap_wrap = eq(hCounter, UInt<10>("h31f")) @[src/main/scala/chisel3/util/Counter.scala 73:24]
    node _wrap_value_T = add(hCounter, UInt<1>("h1")) @[src/main/scala/chisel3/util/Counter.scala 77:24]
    node _wrap_value_T_1 = tail(_wrap_value_T, 1) @[src/main/scala/chisel3/util/Counter.scala 77:24]
    node _GEN_0 = mux(wrap_wrap, UInt<1>("h0"), _wrap_value_T_1) @[src/main/scala/chisel3/util/Counter.scala 77:15 87:{20,28}]
    node _GEN_1 = mux(slowClock.io_clk, _GEN_0, hCounter) @[src/main/scala/chisel3/util/Counter.scala 118:16 61:40]
    node _GEN_2 = mux(slowClock.io_clk, wrap_wrap, UInt<1>("h0")) @[src/main/scala/chisel3/util/Counter.scala 118:{16,23} 117:24]
    node hWrap = _GEN_2 @[src/main/scala/chisel3/util/Counter.scala 117:24]
    node _T = and(hWrap, slowClock.io_clk) @[\\src\\main\\scala\\vga\\VGAModule.scala 20:40]
    reg vCounter : UInt<10>, clock with :
      reset => (UInt<1>("h0"), vCounter) @[src/main/scala/chisel3/util/Counter.scala 61:40]
    node wrap_wrap_1 = eq(vCounter, UInt<10>("h20c")) @[src/main/scala/chisel3/util/Counter.scala 73:24]
    node _wrap_value_T_2 = add(vCounter, UInt<1>("h1")) @[src/main/scala/chisel3/util/Counter.scala 77:24]
    node _wrap_value_T_3 = tail(_wrap_value_T_2, 1) @[src/main/scala/chisel3/util/Counter.scala 77:24]
    node _GEN_3 = mux(wrap_wrap_1, UInt<1>("h0"), _wrap_value_T_3) @[src/main/scala/chisel3/util/Counter.scala 77:15 87:{20,28}]
    node _GEN_4 = mux(_T, _GEN_3, vCounter) @[src/main/scala/chisel3/util/Counter.scala 118:16 61:40]
    node _GEN_5 = mux(_T, wrap_wrap_1, UInt<1>("h0")) @[src/main/scala/chisel3/util/Counter.scala 118:{16,23} 117:24]
    node _io_hsync_T = gt(hCounter, UInt<10>("h28f")) @[\\src\\main\\scala\\vga\\VGAModule.scala 34:28]
    node _io_hsync_T_1 = lt(hCounter, UInt<10>("h2f0")) @[\\src\\main\\scala\\vga\\VGAModule.scala 34:48]
    node _io_hsync_T_2 = and(_io_hsync_T, _io_hsync_T_1) @[\\src\\main\\scala\\vga\\VGAModule.scala 34:36]
    node _io_hsync_T_3 = mux(_io_hsync_T_2, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 34:18]
    node _io_vsync_T = gt(vCounter, UInt<9>("h1e9")) @[\\src\\main\\scala\\vga\\VGAModule.scala 35:28]
    node _io_vsync_T_1 = lt(vCounter, UInt<9>("h1ec")) @[\\src\\main\\scala\\vga\\VGAModule.scala 35:48]
    node _io_vsync_T_2 = and(_io_vsync_T, _io_vsync_T_1) @[\\src\\main\\scala\\vga\\VGAModule.scala 35:36]
    node _io_vsync_T_3 = mux(_io_vsync_T_2, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 35:18]
    node vWrap = _GEN_5 @[src/main/scala/chisel3/util/Counter.scala 117:24]
    io_col_R <= graphics.io_col_R @[\\src\\main\\scala\\vga\\VGAModule.scala 29:12]
    io_col_G <= graphics.io_col_G @[\\src\\main\\scala\\vga\\VGAModule.scala 30:12]
    io_col_B <= graphics.io_col_B @[\\src\\main\\scala\\vga\\VGAModule.scala 31:12]
    io_hsync <= _io_hsync_T_3 @[\\src\\main\\scala\\vga\\VGAModule.scala 34:12]
    io_vsync <= _io_vsync_T_3 @[\\src\\main\\scala\\vga\\VGAModule.scala 35:12]
    io_Hdebug <= hCounter @[\\src\\main\\scala\\vga\\VGAModule.scala 22:13]
    io_Vdebug <= vCounter @[\\src\\main\\scala\\vga\\VGAModule.scala 23:13]
    slowClock.clock <= clock
    slowClock.reset <= reset
    hCounter <= mux(reset, UInt<10>("h0"), _GEN_1) @[src/main/scala/chisel3/util/Counter.scala 61:{40,40}]
    vCounter <= mux(reset, UInt<10>("h0"), _GEN_4) @[src/main/scala/chisel3/util/Counter.scala 61:{40,40}]
    graphics.clock <= clock
    graphics.reset <= reset
    graphics.io_indexX <= hCounter @[\\src\\main\\scala\\vga\\VGAModule.scala 27:22]
    graphics.io_indexY <= vCounter @[\\src\\main\\scala\\vga\\VGAModule.scala 28:22]

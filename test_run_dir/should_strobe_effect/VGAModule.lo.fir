FIRRTL version 1.2.0
circuit VGAModule :
  module Buffer :
    input clock : Clock
    input reset : UInt<1>
    output io_col_R : UInt<2> @[\\src\\main\\scala\\vga\\Buffer.scala 25:14]
    output io_col_G : UInt<2> @[\\src\\main\\scala\\vga\\Buffer.scala 25:14]
    output io_col_B : UInt<2> @[\\src\\main\\scala\\vga\\Buffer.scala 25:14]
    input io_index : UInt<19> @[\\src\\main\\scala\\vga\\Buffer.scala 25:14]

    mem bufferarray_R : @[\\src\\main\\scala\\vga\\Buffer.scala 26:32]
      data-type => UInt<2>
      depth => 307200
      read-latency => 1
      write-latency => 1
      reader => pixel
      read-under-write => undefined
    mem bufferarray_G : @[\\src\\main\\scala\\vga\\Buffer.scala 26:32]
      data-type => UInt<2>
      depth => 307200
      read-latency => 1
      write-latency => 1
      reader => pixel
      read-under-write => undefined
    mem bufferarray_B : @[\\src\\main\\scala\\vga\\Buffer.scala 26:32]
      data-type => UInt<2>
      depth => 307200
      read-latency => 1
      write-latency => 1
      reader => pixel
      read-under-write => undefined
    node _GEN_0 = validif(UInt<1>("h1"), io_index) @[\\src\\main\\scala\\vga\\Buffer.scala 28:{31,31}]
    node _pixel_WIRE = _GEN_0 @[\\src\\main\\scala\\vga\\Buffer.scala 28:31]
    node _pixel_T = or(_pixel_WIRE, UInt<19>("h0")) @[\\src\\main\\scala\\vga\\Buffer.scala 28:31]
    node _pixel_T_1 = bits(_pixel_T, 18, 0) @[\\src\\main\\scala\\vga\\Buffer.scala 28:31]
    node _GEN_1 = mux(UInt<1>("h1"), UInt<1>("h1"), UInt<1>("h0")) @[\\src\\main\\scala\\vga\\Buffer.scala 28:{31,31} 26:32]
    node _GEN_2 = validif(UInt<1>("h1"), _pixel_T_1) @[\\src\\main\\scala\\vga\\Buffer.scala 28:{31,31}]
    node _GEN_3 = validif(UInt<1>("h1"), clock) @[\\src\\main\\scala\\vga\\Buffer.scala 28:{31,31}]
    node curcolour = rem(io_index, UInt<3>("h4")) @[\\src\\main\\scala\\vga\\Buffer.scala 30:28]
    node indexX = rem(io_index, UInt<10>("h320")) @[\\src\\main\\scala\\vga\\Buffer.scala 31:25]
    node indexY = div(io_index, UInt<10>("h320")) @[\\src\\main\\scala\\vga\\Buffer.scala 32:25]
    node _T = gt(indexY, UInt<5>("h16")) @[\\src\\main\\scala\\vga\\Buffer.scala 35:16]
    node _T_1 = lt(indexY, UInt<9>("h1f6")) @[\\src\\main\\scala\\vga\\Buffer.scala 35:33]
    node _T_2 = and(_T, _T_1) @[\\src\\main\\scala\\vga\\Buffer.scala 35:23]
    node _T_3 = gt(indexX, UInt<7>("h50")) @[\\src\\main\\scala\\vga\\Buffer.scala 35:51]
    node _T_4 = and(_T_2, _T_3) @[\\src\\main\\scala\\vga\\Buffer.scala 35:41]
    node _T_5 = lt(indexX, UInt<10>("h2d0")) @[\\src\\main\\scala\\vga\\Buffer.scala 35:68]
    node _T_6 = and(_T_4, _T_5) @[\\src\\main\\scala\\vga\\Buffer.scala 35:58]
    node _GEN_4 = mux(_T_6, curcolour, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\Buffer.scala 35:77 36:14 40:14]
    node _GEN_5 = mux(_T_6, bufferarray_B.pixel.data, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\Buffer.scala 35:77 38:14 42:14]
    io_col_R <= bits(_GEN_4, 1, 0)
    io_col_G <= bits(_GEN_4, 1, 0)
    io_col_B <= _GEN_5
    bufferarray_R.pixel.addr <= _GEN_2
    bufferarray_G.pixel.addr <= _GEN_2
    bufferarray_B.pixel.addr <= _GEN_2
    bufferarray_R.pixel.en <= _GEN_1
    bufferarray_G.pixel.en <= _GEN_1
    bufferarray_B.pixel.en <= _GEN_1
    bufferarray_R.pixel.clk <= _GEN_3
    bufferarray_G.pixel.clk <= _GEN_3
    bufferarray_B.pixel.clk <= _GEN_3

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

    inst buf of Buffer @[\\src\\main\\scala\\vga\\VGAModule.scala 21:19]
    reg Hcounter : UInt<10>, clock with :
      reset => (UInt<1>("h0"), Hcounter) @[\\src\\main\\scala\\vga\\VGAModule.scala 16:25]
    reg Vcounter : UInt<10>, clock with :
      reset => (UInt<1>("h0"), Vcounter) @[\\src\\main\\scala\\vga\\VGAModule.scala 17:25]
    node _buf_io_index_T = mul(Vcounter, UInt<10>("h280")) @[\\src\\main\\scala\\vga\\VGAModule.scala 24:38]
    node _buf_io_index_T_1 = add(Hcounter, _buf_io_index_T) @[\\src\\main\\scala\\vga\\VGAModule.scala 24:28]
    node _buf_io_index_T_2 = tail(_buf_io_index_T_1, 1) @[\\src\\main\\scala\\vga\\VGAModule.scala 24:28]
    node _T = eq(Hcounter, UInt<10>("h31f")) @[\\src\\main\\scala\\vga\\VGAModule.scala 30:17]
    node _T_1 = eq(Vcounter, UInt<10>("h20c")) @[\\src\\main\\scala\\vga\\VGAModule.scala 32:19]
    node _Vcounter_T = add(Vcounter, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 35:28]
    node _Vcounter_T_1 = tail(_Vcounter_T, 1) @[\\src\\main\\scala\\vga\\VGAModule.scala 35:28]
    node _GEN_0 = mux(_T_1, UInt<1>("h0"), _Vcounter_T_1) @[\\src\\main\\scala\\vga\\VGAModule.scala 32:30 33:16 35:16]
    node _Hcounter_T = add(Hcounter, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 38:26]
    node _Hcounter_T_1 = tail(_Hcounter_T, 1) @[\\src\\main\\scala\\vga\\VGAModule.scala 38:26]
    node _GEN_1 = mux(_T, UInt<1>("h0"), _Hcounter_T_1) @[\\src\\main\\scala\\vga\\VGAModule.scala 30:28 31:14 38:14]
    node _GEN_2 = mux(_T, _GEN_0, Vcounter) @[\\src\\main\\scala\\vga\\VGAModule.scala 17:25 30:28]
    node _io_hsync_T = eq(Hcounter, UInt<10>("h31f")) @[\\src\\main\\scala\\vga\\VGAModule.scala 41:28]
    node _io_hsync_T_1 = mux(_io_hsync_T, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 41:18]
    node _io_vsync_T = eq(Vcounter, UInt<10>("h20c")) @[\\src\\main\\scala\\vga\\VGAModule.scala 42:28]
    node _io_vsync_T_1 = mux(_io_vsync_T, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 42:18]
    io_col_R <= buf.io_col_R @[\\src\\main\\scala\\vga\\VGAModule.scala 25:12]
    io_col_G <= buf.io_col_G @[\\src\\main\\scala\\vga\\VGAModule.scala 26:12]
    io_col_B <= buf.io_col_B @[\\src\\main\\scala\\vga\\VGAModule.scala 27:12]
    io_hsync <= _io_hsync_T_1 @[\\src\\main\\scala\\vga\\VGAModule.scala 41:12]
    io_vsync <= _io_vsync_T_1 @[\\src\\main\\scala\\vga\\VGAModule.scala 42:12]
    io_Hdebug <= Hcounter @[\\src\\main\\scala\\vga\\VGAModule.scala 19:13]
    io_Vdebug <= Vcounter @[\\src\\main\\scala\\vga\\VGAModule.scala 20:13]
    Hcounter <= mux(reset, UInt<10>("h0"), _GEN_1) @[\\src\\main\\scala\\vga\\VGAModule.scala 16:{25,25}]
    Vcounter <= mux(reset, UInt<10>("h0"), _GEN_2) @[\\src\\main\\scala\\vga\\VGAModule.scala 17:{25,25}]
    buf.clock <= clock
    buf.reset <= reset
    buf.io_index <= bits(_buf_io_index_T_2, 18, 0) @[\\src\\main\\scala\\vga\\VGAModule.scala 24:16]

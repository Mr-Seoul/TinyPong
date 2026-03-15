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
    io_col_R <= bufferarray_R.pixel.data @[\\src\\main\\scala\\vga\\Buffer.scala 30:12]
    io_col_G <= bufferarray_G.pixel.data @[\\src\\main\\scala\\vga\\Buffer.scala 31:12]
    io_col_B <= bufferarray_B.pixel.data @[\\src\\main\\scala\\vga\\Buffer.scala 32:12]
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
    output io_col_R : UInt<2> @[\\src\\main\\scala\\vga\\VGAModule.scala 12:14]
    output io_col_G : UInt<2> @[\\src\\main\\scala\\vga\\VGAModule.scala 12:14]
    output io_col_B : UInt<2> @[\\src\\main\\scala\\vga\\VGAModule.scala 12:14]
    output io_hsync : UInt<1> @[\\src\\main\\scala\\vga\\VGAModule.scala 12:14]
    output io_vsync : UInt<1> @[\\src\\main\\scala\\vga\\VGAModule.scala 12:14]

    inst buf of Buffer @[\\src\\main\\scala\\vga\\VGAModule.scala 15:19]
    reg Hcounter : UInt<10>, clock with :
      reset => (UInt<1>("h0"), Hcounter) @[\\src\\main\\scala\\vga\\VGAModule.scala 13:25]
    reg Vcounter : UInt<10>, clock with :
      reset => (UInt<1>("h0"), Vcounter) @[\\src\\main\\scala\\vga\\VGAModule.scala 14:25]
    node _buf_io_index_T = mul(Vcounter, UInt<10>("h280")) @[\\src\\main\\scala\\vga\\VGAModule.scala 18:38]
    node _buf_io_index_T_1 = add(Hcounter, _buf_io_index_T) @[\\src\\main\\scala\\vga\\VGAModule.scala 18:28]
    node _buf_io_index_T_2 = tail(_buf_io_index_T_1, 1) @[\\src\\main\\scala\\vga\\VGAModule.scala 18:28]
    node _io_col_R_T = rem(Hcounter, UInt<3>("h4")) @[\\src\\main\\scala\\vga\\VGAModule.scala 19:24]
    node _io_col_B_T = rem(Vcounter, UInt<3>("h4")) @[\\src\\main\\scala\\vga\\VGAModule.scala 20:24]
    node _T = sub(UInt<10>("h280"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 25:28]
    node _T_1 = tail(_T, 1) @[\\src\\main\\scala\\vga\\VGAModule.scala 25:28]
    node _T_2 = lt(Hcounter, _T_1) @[\\src\\main\\scala\\vga\\VGAModule.scala 25:19]
    node _Hcounter_T = add(Hcounter, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 26:28]
    node _Hcounter_T_1 = tail(_Hcounter_T, 1) @[\\src\\main\\scala\\vga\\VGAModule.scala 26:28]
    node _GEN_0 = mux(_T_2, _Hcounter_T_1, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\VGAModule.scala 25:36 26:16 29:16]
    node _GEN_1 = mux(_T_2, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 25:36 27:16 30:16]
    node _T_3 = sub(UInt<9>("h1e0"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 32:28]
    node _T_4 = tail(_T_3, 1) @[\\src\\main\\scala\\vga\\VGAModule.scala 32:28]
    node _T_5 = lt(Vcounter, _T_4) @[\\src\\main\\scala\\vga\\VGAModule.scala 32:19]
    node _Vcounter_T = add(Vcounter, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 33:28]
    node _Vcounter_T_1 = tail(_Vcounter_T, 1) @[\\src\\main\\scala\\vga\\VGAModule.scala 33:28]
    node _GEN_2 = mux(_T_5, _Vcounter_T_1, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\VGAModule.scala 32:36 33:16 36:16]
    node _GEN_3 = mux(_T_5, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGAModule.scala 32:36 34:16 37:16]
    io_col_R <= bits(_io_col_R_T, 1, 0) @[\\src\\main\\scala\\vga\\VGAModule.scala 19:12]
    io_col_G <= buf.io_col_G @[\\src\\main\\scala\\vga\\VGAModule.scala 21:12]
    io_col_B <= bits(_io_col_B_T, 1, 0) @[\\src\\main\\scala\\vga\\VGAModule.scala 20:12]
    io_hsync <= _GEN_1
    io_vsync <= _GEN_3
    Hcounter <= mux(reset, UInt<10>("h0"), _GEN_0) @[\\src\\main\\scala\\vga\\VGAModule.scala 13:{25,25}]
    Vcounter <= mux(reset, UInt<10>("h0"), _GEN_2) @[\\src\\main\\scala\\vga\\VGAModule.scala 14:{25,25}]
    buf.clock <= clock
    buf.reset <= reset
    buf.io_index <= bits(_buf_io_index_T_2, 18, 0) @[\\src\\main\\scala\\vga\\VGAModule.scala 18:16]

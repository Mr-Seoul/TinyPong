FIRRTL version 1.2.0
circuit Buffer :
  module Buffer :
    input clock : Clock
    input reset : UInt<1>
    output io_col_R : UInt<2> @[\\src\\main\\scala\\vga\\Buffer.scala 26:14]
    output io_col_G : UInt<2> @[\\src\\main\\scala\\vga\\Buffer.scala 26:14]
    output io_col_B : UInt<2> @[\\src\\main\\scala\\vga\\Buffer.scala 26:14]
    input io_indexX : UInt<10> @[\\src\\main\\scala\\vga\\Buffer.scala 26:14]
    input io_indexY : UInt<10> @[\\src\\main\\scala\\vga\\Buffer.scala 26:14]

    mem bufferarray_R : @[\\src\\main\\scala\\vga\\Buffer.scala 27:32]
      data-type => UInt<2>
      depth => 307200
      read-latency => 1
      write-latency => 1
      read-under-write => undefined
    mem bufferarray_G : @[\\src\\main\\scala\\vga\\Buffer.scala 27:32]
      data-type => UInt<2>
      depth => 307200
      read-latency => 1
      write-latency => 1
      read-under-write => undefined
    mem bufferarray_B : @[\\src\\main\\scala\\vga\\Buffer.scala 27:32]
      data-type => UInt<2>
      depth => 307200
      read-latency => 1
      write-latency => 1
      read-under-write => undefined
    node _curcolour_T = add(io_indexX, io_indexY) @[\\src\\main\\scala\\vga\\Buffer.scala 29:30]
    node _curcolour_T_1 = tail(_curcolour_T, 1) @[\\src\\main\\scala\\vga\\Buffer.scala 29:30]
    node curcolour = rem(_curcolour_T_1, UInt<3>("h4")) @[\\src\\main\\scala\\vga\\Buffer.scala 29:43]
    node _valid_T = lt(io_indexY, UInt<9>("h1e0")) @[\\src\\main\\scala\\vga\\Buffer.scala 32:25]
    node _valid_T_1 = lt(io_indexX, UInt<10>("h280")) @[\\src\\main\\scala\\vga\\Buffer.scala 32:46]
    node valid = and(_valid_T, _valid_T_1) @[\\src\\main\\scala\\vga\\Buffer.scala 32:33]
    node _io_col_R_T = mux(valid, curcolour, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\Buffer.scala 33:18]
    node _io_col_G_T = mux(valid, curcolour, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\Buffer.scala 34:18]
    node _io_col_B_T = mux(valid, curcolour, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\Buffer.scala 35:18]
    io_col_R <= bits(_io_col_R_T, 1, 0) @[\\src\\main\\scala\\vga\\Buffer.scala 33:12]
    io_col_G <= bits(_io_col_G_T, 1, 0) @[\\src\\main\\scala\\vga\\Buffer.scala 34:12]
    io_col_B <= bits(_io_col_B_T, 1, 0) @[\\src\\main\\scala\\vga\\Buffer.scala 35:12]

FIRRTL version 1.2.0
circuit VGATimingModule :
  module VGATimingModule :
    input clock : Clock
    input reset : UInt<1>
    output io_hsync : UInt<1> @[\\src\\main\\scala\\vga\\VGATimingModule.scala 13:14]
    output io_vsync : UInt<1> @[\\src\\main\\scala\\vga\\VGATimingModule.scala 13:14]
    input io_indexX : UInt<11> @[\\src\\main\\scala\\vga\\VGATimingModule.scala 13:14]
    input io_indexY : UInt<10> @[\\src\\main\\scala\\vga\\VGATimingModule.scala 13:14]

    node _io_hsync_T = gt(io_indexX, UInt<10>("h28f")) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 16:29]
    node _io_hsync_T_1 = lt(io_indexX, UInt<10>("h2f0")) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 16:50]
    node _io_hsync_T_2 = and(_io_hsync_T, _io_hsync_T_1) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 16:37]
    node _io_hsync_T_3 = mux(_io_hsync_T_2, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 16:18]
    node _io_vsync_T = gt(io_indexY, UInt<9>("h1e9")) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 17:29]
    node _io_vsync_T_1 = lt(io_indexY, UInt<9>("h1ec")) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 17:50]
    node _io_vsync_T_2 = and(_io_vsync_T, _io_vsync_T_1) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 17:37]
    node _io_vsync_T_3 = mux(_io_vsync_T_2, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 17:18]
    io_hsync <= _io_hsync_T_3 @[\\src\\main\\scala\\vga\\VGATimingModule.scala 16:12]
    io_vsync <= _io_vsync_T_3 @[\\src\\main\\scala\\vga\\VGATimingModule.scala 17:12]

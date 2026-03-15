FIRRTL version 1.2.0
circuit GraphicsManager :
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

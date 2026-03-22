FIRRTL version 1.2.0
circuit VGAModule :
  module resetSynchronizer :
    input clock : Clock
    input reset : Reset
    output io : { syncReset : AsyncReset} @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 11:14]

    node _T = asAsyncReset(reset) @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 13:19]
    reg resetReg1 : UInt<1>, clock with :
      reset => (_T, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 15:28]
    reg resetReg2 : UInt<1>, clock with :
      reset => (_T, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 16:28]
    resetReg1 <= UInt<1>("h0") @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 17:15]
    resetReg2 <= resetReg1 @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 18:15]
    node _io_syncReset_T = asAsyncReset(resetReg2) @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 20:31]
    io.syncReset <= _io_syncReset_T @[\\src\\main\\scala\\vga\\ResetSynchronizer.scala 20:18]

  module PaddleLeftObj :
    input clock : Clock
    input reset : Reset
    output io : { flip input : UInt<1>, flip posX : SInt<11>, flip posY : SInt<10>, inbound : UInt<1>, paddlePosY : SInt<10>, flip updateLogic : UInt<1>, diffX : UInt<5>} @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]

    reg curPosY : SInt<10>, clock with :
      reset => (reset, asSInt(UInt<10>("hf0"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:24]
    reg velocity : SInt<6>, clock with :
      reset => (reset, asSInt(UInt<6>("h0"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:25]
    when io.updateLogic : @[\\src\\main\\scala\\vga\\PaddleObj.scala 25:25]
      when io.input : @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:21]
        node _velocity_T = sub(asSInt(UInt<1>("h0")), asSInt(UInt<5>("h8"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:19]
        node _velocity_T_1 = tail(_velocity_T, 1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:19]
        node _velocity_T_2 = asSInt(_velocity_T_1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:19]
        velocity <= _velocity_T_2 @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:16]
      else :
        node _T = eq(curPosY, asSInt(UInt<8>("h64"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:26]
        when _T : @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:39]
          velocity <= asSInt(UInt<2>("h1")) @[\\src\\main\\scala\\vga\\PaddleObj.scala 30:16]
        else :
          node _T_1 = eq(curPosY, asSInt(UInt<10>("h1e0"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 31:26]
          when _T_1 : @[\\src\\main\\scala\\vga\\PaddleObj.scala 31:42]
            velocity <= asSInt(UInt<1>("h0")) @[\\src\\main\\scala\\vga\\PaddleObj.scala 32:16]
          else :
            node _velocity_T_3 = add(velocity, asSInt(UInt<2>("h1"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:28]
            node _velocity_T_4 = tail(_velocity_T_3, 1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:28]
            node _velocity_T_5 = asSInt(_velocity_T_4) @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:28]
            velocity <= _velocity_T_5 @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:16]
      node _newPos_T = add(curPosY, velocity) @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:26]
      node _newPos_T_1 = tail(_newPos_T, 1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:26]
      node newPos = asSInt(_newPos_T_1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:26]
      node _curPosY_T = gt(newPos, asSInt(UInt<10>("h1e0"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:27]
      node _curPosY_T_1 = lt(newPos, asSInt(UInt<8>("h64"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:63]
      node _curPosY_T_2 = mux(_curPosY_T_1, asSInt(UInt<8>("h64")), newPos) @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:55]
      node _curPosY_T_3 = mux(_curPosY_T, asSInt(UInt<10>("h1e0")), _curPosY_T_2) @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:19]
      curPosY <= _curPosY_T_3 @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:13]
    wire diffX : SInt<11> @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:19]
    node _io_diffX_T = bits(diffX, 4, 0) @[\\src\\main\\scala\\vga\\PaddleObj.scala 44:20]
    io.diffX <= _io_diffX_T @[\\src\\main\\scala\\vga\\PaddleObj.scala 44:12]
    node _inXBound_T = bits(diffX, 10, 10) @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:25]
    node _inXBound_T_1 = eq(_inXBound_T, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:19]
    node _inXBound_T_2 = leq(diffX, asSInt(UInt<6>("h10"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:41]
    node inXBound = and(_inXBound_T_1, _inXBound_T_2) @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:31]
    node _Top_T = sub(asSInt(UInt<1>("h0")), asSInt(UInt<8>("h64"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:14]
    node _Top_T_1 = tail(_Top_T, 1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:14]
    node _Top_T_2 = asSInt(_Top_T_1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:14]
    node _Top_T_3 = add(_Top_T_2, curPosY) @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:44]
    node _Top_T_4 = tail(_Top_T_3, 1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:44]
    node Top = asSInt(_Top_T_4) @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:44]
    node _inYBound_T = geq(io.posY, Top) @[\\src\\main\\scala\\vga\\PaddleObj.scala 50:27]
    node _inYBound_T_1 = leq(io.posY, curPosY) @[\\src\\main\\scala\\vga\\PaddleObj.scala 50:47]
    node inYBound = and(_inYBound_T, _inYBound_T_1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 50:35]
    node inSquare = and(inXBound, inYBound) @[\\src\\main\\scala\\vga\\PaddleObj.scala 53:27]
    io.inbound <= inSquare @[\\src\\main\\scala\\vga\\PaddleObj.scala 54:14]
    io.paddlePosY <= curPosY @[\\src\\main\\scala\\vga\\PaddleObj.scala 56:17]
    node _diffX_T = sub(asSInt(UInt<11>("h50")), io.posX) @[\\src\\main\\scala\\vga\\PaddleLeftObj.scala 4:20]
    node _diffX_T_1 = tail(_diffX_T, 1) @[\\src\\main\\scala\\vga\\PaddleLeftObj.scala 4:20]
    node _diffX_T_2 = asSInt(_diffX_T_1) @[\\src\\main\\scala\\vga\\PaddleLeftObj.scala 4:20]
    diffX <= _diffX_T_2 @[\\src\\main\\scala\\vga\\PaddleLeftObj.scala 4:9]

  module PaddleRightObj :
    input clock : Clock
    input reset : Reset
    output io : { flip input : UInt<1>, flip posX : SInt<11>, flip posY : SInt<10>, inbound : UInt<1>, paddlePosY : SInt<10>, flip updateLogic : UInt<1>, diffX : UInt<5>} @[\\src\\main\\scala\\vga\\PaddleObj.scala 16:14]

    reg curPosY : SInt<10>, clock with :
      reset => (reset, asSInt(UInt<10>("hf0"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 19:24]
    reg velocity : SInt<6>, clock with :
      reset => (reset, asSInt(UInt<6>("h0"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 20:25]
    when io.updateLogic : @[\\src\\main\\scala\\vga\\PaddleObj.scala 25:25]
      when io.input : @[\\src\\main\\scala\\vga\\PaddleObj.scala 27:21]
        node _velocity_T = sub(asSInt(UInt<1>("h0")), asSInt(UInt<5>("h8"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:19]
        node _velocity_T_1 = tail(_velocity_T, 1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:19]
        node _velocity_T_2 = asSInt(_velocity_T_1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:19]
        velocity <= _velocity_T_2 @[\\src\\main\\scala\\vga\\PaddleObj.scala 28:16]
      else :
        node _T = eq(curPosY, asSInt(UInt<8>("h64"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:26]
        when _T : @[\\src\\main\\scala\\vga\\PaddleObj.scala 29:39]
          velocity <= asSInt(UInt<2>("h1")) @[\\src\\main\\scala\\vga\\PaddleObj.scala 30:16]
        else :
          node _T_1 = eq(curPosY, asSInt(UInt<10>("h1e0"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 31:26]
          when _T_1 : @[\\src\\main\\scala\\vga\\PaddleObj.scala 31:42]
            velocity <= asSInt(UInt<1>("h0")) @[\\src\\main\\scala\\vga\\PaddleObj.scala 32:16]
          else :
            node _velocity_T_3 = add(velocity, asSInt(UInt<2>("h1"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:28]
            node _velocity_T_4 = tail(_velocity_T_3, 1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:28]
            node _velocity_T_5 = asSInt(_velocity_T_4) @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:28]
            velocity <= _velocity_T_5 @[\\src\\main\\scala\\vga\\PaddleObj.scala 34:16]
      node _newPos_T = add(curPosY, velocity) @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:26]
      node _newPos_T_1 = tail(_newPos_T, 1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:26]
      node newPos = asSInt(_newPos_T_1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 38:26]
      node _curPosY_T = gt(newPos, asSInt(UInt<10>("h1e0"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:27]
      node _curPosY_T_1 = lt(newPos, asSInt(UInt<8>("h64"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:63]
      node _curPosY_T_2 = mux(_curPosY_T_1, asSInt(UInt<8>("h64")), newPos) @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:55]
      node _curPosY_T_3 = mux(_curPosY_T, asSInt(UInt<10>("h1e0")), _curPosY_T_2) @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:19]
      curPosY <= _curPosY_T_3 @[\\src\\main\\scala\\vga\\PaddleObj.scala 39:13]
    wire diffX : SInt<11> @[\\src\\main\\scala\\vga\\PaddleObj.scala 43:19]
    node _io_diffX_T = bits(diffX, 4, 0) @[\\src\\main\\scala\\vga\\PaddleObj.scala 44:20]
    io.diffX <= _io_diffX_T @[\\src\\main\\scala\\vga\\PaddleObj.scala 44:12]
    node _inXBound_T = bits(diffX, 10, 10) @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:25]
    node _inXBound_T_1 = eq(_inXBound_T, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:19]
    node _inXBound_T_2 = leq(diffX, asSInt(UInt<6>("h10"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:41]
    node inXBound = and(_inXBound_T_1, _inXBound_T_2) @[\\src\\main\\scala\\vga\\PaddleObj.scala 45:31]
    node _Top_T = sub(asSInt(UInt<1>("h0")), asSInt(UInt<8>("h64"))) @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:14]
    node _Top_T_1 = tail(_Top_T, 1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:14]
    node _Top_T_2 = asSInt(_Top_T_1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:14]
    node _Top_T_3 = add(_Top_T_2, curPosY) @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:44]
    node _Top_T_4 = tail(_Top_T_3, 1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:44]
    node Top = asSInt(_Top_T_4) @[\\src\\main\\scala\\vga\\PaddleObj.scala 48:44]
    node _inYBound_T = geq(io.posY, Top) @[\\src\\main\\scala\\vga\\PaddleObj.scala 50:27]
    node _inYBound_T_1 = leq(io.posY, curPosY) @[\\src\\main\\scala\\vga\\PaddleObj.scala 50:47]
    node inYBound = and(_inYBound_T, _inYBound_T_1) @[\\src\\main\\scala\\vga\\PaddleObj.scala 50:35]
    node inSquare = and(inXBound, inYBound) @[\\src\\main\\scala\\vga\\PaddleObj.scala 53:27]
    io.inbound <= inSquare @[\\src\\main\\scala\\vga\\PaddleObj.scala 54:14]
    io.paddlePosY <= curPosY @[\\src\\main\\scala\\vga\\PaddleObj.scala 56:17]
    node _diffX_T = sub(io.posX, asSInt(UInt<11>("h230"))) @[\\src\\main\\scala\\vga\\PaddleRightObj.scala 4:20]
    node _diffX_T_1 = tail(_diffX_T, 1) @[\\src\\main\\scala\\vga\\PaddleRightObj.scala 4:20]
    node _diffX_T_2 = asSInt(_diffX_T_1) @[\\src\\main\\scala\\vga\\PaddleRightObj.scala 4:20]
    diffX <= _diffX_T_2 @[\\src\\main\\scala\\vga\\PaddleRightObj.scala 4:9]

  module BallObj :
    input clock : Clock
    input reset : Reset
    output io : { flip posX : SInt<11>, flip posY : SInt<10>, inbound : UInt<1>, flip P1PosY : SInt<10>, flip P2PosY : SInt<10>, flip updateLogic : UInt<1>, outLeftBound : UInt<1>, outRightBound : UInt<1>} @[\\src\\main\\scala\\vga\\Ball.scala 17:14]

    reg ballSpeed : SInt<6>, clock with :
      reset => (reset, asSInt(UInt<6>("h2"))) @[\\src\\main\\scala\\vga\\Ball.scala 19:26]
    reg curPosX : SInt<11>, clock with :
      reset => (reset, asSInt(UInt<11>("h140"))) @[\\src\\main\\scala\\vga\\Ball.scala 21:24]
    reg curPosY : SInt<10>, clock with :
      reset => (reset, asSInt(UInt<10>("h40"))) @[\\src\\main\\scala\\vga\\Ball.scala 22:24]
    reg goingRight : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\Ball.scala 24:27]
    reg goingDown : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\Ball.scala 25:26]
    when io.updateLogic : @[\\src\\main\\scala\\vga\\Ball.scala 28:24]
      node _goingDown_T = lt(curPosY, asSInt(UInt<1>("h0"))) @[\\src\\main\\scala\\vga\\Ball.scala 30:30]
      node _goingDown_T_1 = sub(asSInt(UInt<10>("h1e0")), asSInt(UInt<6>("h10"))) @[\\src\\main\\scala\\vga\\Ball.scala 30:63]
      node _goingDown_T_2 = tail(_goingDown_T_1, 1) @[\\src\\main\\scala\\vga\\Ball.scala 30:63]
      node _goingDown_T_3 = asSInt(_goingDown_T_2) @[\\src\\main\\scala\\vga\\Ball.scala 30:63]
      node _goingDown_T_4 = gt(curPosY, _goingDown_T_3) @[\\src\\main\\scala\\vga\\Ball.scala 30:54]
      node _goingDown_T_5 = mux(_goingDown_T_4, UInt<1>("h0"), goingDown) @[\\src\\main\\scala\\vga\\Ball.scala 30:45]
      node _goingDown_T_6 = mux(_goingDown_T, UInt<1>("h1"), _goingDown_T_5) @[\\src\\main\\scala\\vga\\Ball.scala 30:21]
      goingDown <= _goingDown_T_6 @[\\src\\main\\scala\\vga\\Ball.scala 30:15]
      node _speedX_T = sub(asSInt(UInt<1>("h0")), ballSpeed) @[\\src\\main\\scala\\vga\\Ball.scala 31:45]
      node _speedX_T_1 = tail(_speedX_T, 1) @[\\src\\main\\scala\\vga\\Ball.scala 31:45]
      node _speedX_T_2 = asSInt(_speedX_T_1) @[\\src\\main\\scala\\vga\\Ball.scala 31:45]
      node speedX = mux(goingRight, ballSpeed, _speedX_T_2) @[\\src\\main\\scala\\vga\\Ball.scala 31:21]
      node _speedY_T = sub(asSInt(UInt<1>("h0")), ballSpeed) @[\\src\\main\\scala\\vga\\Ball.scala 32:44]
      node _speedY_T_1 = tail(_speedY_T, 1) @[\\src\\main\\scala\\vga\\Ball.scala 32:44]
      node _speedY_T_2 = asSInt(_speedY_T_1) @[\\src\\main\\scala\\vga\\Ball.scala 32:44]
      node speedY = mux(goingDown, ballSpeed, _speedY_T_2) @[\\src\\main\\scala\\vga\\Ball.scala 32:21]
      node _curPosX_T = add(curPosX, speedX) @[\\src\\main\\scala\\vga\\Ball.scala 33:24]
      node _curPosX_T_1 = tail(_curPosX_T, 1) @[\\src\\main\\scala\\vga\\Ball.scala 33:24]
      node _curPosX_T_2 = asSInt(_curPosX_T_1) @[\\src\\main\\scala\\vga\\Ball.scala 33:24]
      curPosX <= _curPosX_T_2 @[\\src\\main\\scala\\vga\\Ball.scala 33:13]
      node _curPosY_T = add(curPosY, speedY) @[\\src\\main\\scala\\vga\\Ball.scala 34:24]
      node _curPosY_T_1 = tail(_curPosY_T, 1) @[\\src\\main\\scala\\vga\\Ball.scala 34:24]
      node _curPosY_T_2 = asSInt(_curPosY_T_1) @[\\src\\main\\scala\\vga\\Ball.scala 34:24]
      curPosY <= _curPosY_T_2 @[\\src\\main\\scala\\vga\\Ball.scala 34:13]
      node _P1Top_T = add(asSInt(UInt<8>("h94")), io.P1PosY) @[\\src\\main\\scala\\vga\\Ball.scala 39:74]
      node _P1Top_T_1 = tail(_P1Top_T, 1) @[\\src\\main\\scala\\vga\\Ball.scala 39:74]
      node P1Top = asSInt(_P1Top_T_1) @[\\src\\main\\scala\\vga\\Ball.scala 39:74]
      node _P1Bottom_T = add(io.P1PosY, asSInt(UInt<5>("h8"))) @[\\src\\main\\scala\\vga\\Ball.scala 40:29]
      node _P1Bottom_T_1 = tail(_P1Bottom_T, 1) @[\\src\\main\\scala\\vga\\Ball.scala 40:29]
      node P1Bottom = asSInt(_P1Bottom_T_1) @[\\src\\main\\scala\\vga\\Ball.scala 40:29]
      node _P2Top_T = add(asSInt(UInt<8>("h94")), io.P2PosY) @[\\src\\main\\scala\\vga\\Ball.scala 44:74]
      node _P2Top_T_1 = tail(_P2Top_T, 1) @[\\src\\main\\scala\\vga\\Ball.scala 44:74]
      node P2Top = asSInt(_P2Top_T_1) @[\\src\\main\\scala\\vga\\Ball.scala 44:74]
      node _P2Bottom_T = add(io.P2PosY, asSInt(UInt<5>("h8"))) @[\\src\\main\\scala\\vga\\Ball.scala 45:30]
      node _P2Bottom_T_1 = tail(_P2Bottom_T, 1) @[\\src\\main\\scala\\vga\\Ball.scala 45:30]
      node P2Bottom = asSInt(_P2Bottom_T_1) @[\\src\\main\\scala\\vga\\Ball.scala 45:30]
      node _newDir_T = bits(ballSpeed, 1, 1) @[\\src\\main\\scala\\vga\\Ball.scala 47:27]
      node _newDir_T_1 = bits(ballSpeed, 0, 0) @[\\src\\main\\scala\\vga\\Ball.scala 47:40]
      node _newDir_T_2 = xor(_newDir_T, _newDir_T_1) @[\\src\\main\\scala\\vga\\Ball.scala 47:30]
      node _newDir_T_3 = xor(_newDir_T_2, goingDown) @[\\src\\main\\scala\\vga\\Ball.scala 47:43]
      node newDir = xor(_newDir_T_3, goingRight) @[\\src\\main\\scala\\vga\\Ball.scala 47:53]
      node _T = eq(goingRight, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\Ball.scala 49:10]
      node _T_1 = lt(curPosX, asSInt(UInt<8>("h50"))) @[\\src\\main\\scala\\vga\\Ball.scala 49:34]
      node _T_2 = and(_T, _T_1) @[\\src\\main\\scala\\vga\\Ball.scala 49:22]
      node _T_3 = gt(curPosX, asSInt(UInt<7>("h30"))) @[\\src\\main\\scala\\vga\\Ball.scala 49:59]
      node _T_4 = and(_T_2, _T_3) @[\\src\\main\\scala\\vga\\Ball.scala 49:47]
      node _T_5 = lt(curPosY, P1Bottom) @[\\src\\main\\scala\\vga\\Ball.scala 49:81]
      node _T_6 = and(_T_4, _T_5) @[\\src\\main\\scala\\vga\\Ball.scala 49:69]
      node _T_7 = gt(curPosY, P1Top) @[\\src\\main\\scala\\vga\\Ball.scala 49:107]
      node _T_8 = and(_T_6, _T_7) @[\\src\\main\\scala\\vga\\Ball.scala 49:95]
      when _T_8 : @[\\src\\main\\scala\\vga\\Ball.scala 49:117]
        goingRight <= UInt<1>("h1") @[\\src\\main\\scala\\vga\\Ball.scala 50:18]
        goingDown <= newDir @[\\src\\main\\scala\\vga\\Ball.scala 51:17]
      else :
        node _T_9 = lt(curPosX, asSInt(UInt<11>("h240"))) @[\\src\\main\\scala\\vga\\Ball.scala 52:39]
        node _T_10 = and(goingRight, _T_9) @[\\src\\main\\scala\\vga\\Ball.scala 52:27]
        node _T_11 = gt(curPosX, asSInt(UInt<11>("h220"))) @[\\src\\main\\scala\\vga\\Ball.scala 52:64]
        node _T_12 = and(_T_10, _T_11) @[\\src\\main\\scala\\vga\\Ball.scala 52:52]
        node _T_13 = lt(curPosY, P2Bottom) @[\\src\\main\\scala\\vga\\Ball.scala 52:86]
        node _T_14 = and(_T_12, _T_13) @[\\src\\main\\scala\\vga\\Ball.scala 52:74]
        node _T_15 = gt(curPosY, P2Top) @[\\src\\main\\scala\\vga\\Ball.scala 52:112]
        node _T_16 = and(_T_14, _T_15) @[\\src\\main\\scala\\vga\\Ball.scala 52:100]
        when _T_16 : @[\\src\\main\\scala\\vga\\Ball.scala 52:122]
          goingRight <= UInt<1>("h0") @[\\src\\main\\scala\\vga\\Ball.scala 53:18]
          goingDown <= newDir @[\\src\\main\\scala\\vga\\Ball.scala 54:17]
          node _ballSpeed_T = add(ballSpeed, asSInt(UInt<2>("h1"))) @[\\src\\main\\scala\\vga\\Ball.scala 55:37]
          node _ballSpeed_T_1 = tail(_ballSpeed_T, 1) @[\\src\\main\\scala\\vga\\Ball.scala 55:37]
          node _ballSpeed_T_2 = asSInt(_ballSpeed_T_1) @[\\src\\main\\scala\\vga\\Ball.scala 55:37]
          ballSpeed <= _ballSpeed_T_2 @[\\src\\main\\scala\\vga\\Ball.scala 55:17]
    node _inSquareX_T = geq(io.posX, curPosX) @[\\src\\main\\scala\\vga\\Ball.scala 60:28]
    node _inSquareX_T_1 = add(curPosX, asSInt(UInt<6>("h10"))) @[\\src\\main\\scala\\vga\\Ball.scala 60:60]
    node _inSquareX_T_2 = tail(_inSquareX_T_1, 1) @[\\src\\main\\scala\\vga\\Ball.scala 60:60]
    node _inSquareX_T_3 = asSInt(_inSquareX_T_2) @[\\src\\main\\scala\\vga\\Ball.scala 60:60]
    node _inSquareX_T_4 = lt(io.posX, _inSquareX_T_3) @[\\src\\main\\scala\\vga\\Ball.scala 60:50]
    node inSquareX = and(_inSquareX_T, _inSquareX_T_4) @[\\src\\main\\scala\\vga\\Ball.scala 60:39]
    node _inSquareY_T = geq(io.posY, curPosY) @[\\src\\main\\scala\\vga\\Ball.scala 61:28]
    node _inSquareY_T_1 = add(curPosY, asSInt(UInt<6>("h10"))) @[\\src\\main\\scala\\vga\\Ball.scala 61:60]
    node _inSquareY_T_2 = tail(_inSquareY_T_1, 1) @[\\src\\main\\scala\\vga\\Ball.scala 61:60]
    node _inSquareY_T_3 = asSInt(_inSquareY_T_2) @[\\src\\main\\scala\\vga\\Ball.scala 61:60]
    node _inSquareY_T_4 = lt(io.posY, _inSquareY_T_3) @[\\src\\main\\scala\\vga\\Ball.scala 61:50]
    node inSquareY = and(_inSquareY_T, _inSquareY_T_4) @[\\src\\main\\scala\\vga\\Ball.scala 61:39]
    node inSquare = and(inSquareX, inSquareY) @[\\src\\main\\scala\\vga\\Ball.scala 62:28]
    io.inbound <= inSquare @[\\src\\main\\scala\\vga\\Ball.scala 63:14]
    node _io_outRightBound_T = gt(curPosX, asSInt(UInt<11>("h280"))) @[\\src\\main\\scala\\vga\\Ball.scala 66:31]
    io.outRightBound <= _io_outRightBound_T @[\\src\\main\\scala\\vga\\Ball.scala 66:20]
    node _io_outLeftBound_T = leq(curPosX, asSInt(UInt<1>("h0"))) @[\\src\\main\\scala\\vga\\Ball.scala 67:30]
    io.outLeftBound <= _io_outLeftBound_T @[\\src\\main\\scala\\vga\\Ball.scala 67:19]

  module GraphicsProcessor :
    input clock : Clock
    input reset : Reset
    output io : { col : { R : UInt<2>, G : UInt<2>, B : UInt<2>}, flip indexX : UInt<11>, flip indexY : UInt<10>, flip input1 : UInt<1>, flip input2 : UInt<1>, flip screenDone : UInt<1>} @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 27:14]

    node indexPosX = asSInt(io.indexX) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 29:29]
    node indexPosY = asSInt(io.indexY) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 30:29]
    reg gameOver : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 33:25]
    node _resetEverything_T = asUInt(reset) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:32]
    node _resetEverything_T_1 = or(_resetEverything_T, gameOver) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:39]
    node resetEverything = asAsyncReset(_resetEverything_T_1) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 34:52]
    inst P1 of PaddleLeftObj @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 37:20]
    P1.clock <= clock
    P1.reset <= resetEverything
    P1.io.input <= io.input1 @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 38:17]
    P1.io.posX <= indexPosX @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 39:16]
    P1.io.posY <= indexPosY @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 40:16]
    P1.io.updateLogic <= io.screenDone @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 41:23]
    inst P2 of PaddleRightObj @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 43:20]
    P2.clock <= clock
    P2.reset <= resetEverything
    P2.io.input <= io.input2 @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 44:17]
    P2.io.posX <= indexPosX @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 45:16]
    P2.io.posY <= indexPosY @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 46:16]
    P2.io.updateLogic <= io.screenDone @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 47:23]
    inst Ball of BallObj @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 49:22]
    Ball.clock <= clock
    Ball.reset <= resetEverything
    Ball.io.P1PosY <= P1.io.paddlePosY @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 50:20]
    Ball.io.P2PosY <= P2.io.paddlePosY @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 51:20]
    Ball.io.posX <= indexPosX @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 52:18]
    Ball.io.posY <= indexPosY @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 53:18]
    Ball.io.updateLogic <= io.screenDone @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 54:25]
    node _gameOver_T = or(Ball.io.outLeftBound, Ball.io.outRightBound) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 55:38]
    gameOver <= _gameOver_T @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 55:14]
    node _XOR0_T = bits(io.indexX, 0, 0) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 58:25]
    node _XOR0_T_1 = bits(io.indexY, 0, 0) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 58:40]
    node XOR0 = xor(_XOR0_T, _XOR0_T_1) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 58:29]
    node _XOR1_T = bits(io.indexX, 1, 1) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 59:25]
    node _XOR1_T_1 = bits(io.indexY, 1, 1) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 59:40]
    node XOR1 = xor(_XOR1_T, _XOR1_T_1) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 59:29]
    node _XOR2_T = bits(io.indexX, 2, 2) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 60:25]
    node _XOR2_T_1 = bits(io.indexY, 2, 2) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 60:40]
    node XOR2 = xor(_XOR2_T, _XOR2_T_1) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 60:29]
    node _XOR3_T = bits(io.indexX, 3, 3) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 61:25]
    node _XOR3_T_1 = bits(io.indexY, 3, 3) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 61:40]
    node XOR3 = xor(_XOR3_T, _XOR3_T_1) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 61:29]
    node _XOR4_T = bits(io.indexX, 4, 4) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 62:25]
    node _XOR4_T_1 = bits(io.indexY, 4, 4) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 62:40]
    node XOR4 = xor(_XOR4_T, _XOR4_T_1) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 62:29]
    node _XOR5_T = bits(io.indexX, 5, 5) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 63:25]
    node _XOR5_T_1 = bits(io.indexY, 5, 5) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 63:40]
    node XOR5 = xor(_XOR5_T, _XOR5_T_1) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 63:29]
    node _BaysianDither_T = bits(io.indexY, 1, 1) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:47]
    node _BaysianDither_T_1 = bits(io.indexY, 0, 0) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:65]
    wire _BaysianDither_WIRE : UInt<1>[4] @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:32]
    _BaysianDither_WIRE[0] <= XOR0 @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:32]
    _BaysianDither_WIRE[1] <= _BaysianDither_T @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:32]
    _BaysianDither_WIRE[2] <= XOR1 @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:32]
    _BaysianDither_WIRE[3] <= _BaysianDither_T_1 @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:32]
    node BaysianDither_lo = cat(_BaysianDither_WIRE[1], _BaysianDither_WIRE[0]) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:70]
    node BaysianDither_hi = cat(_BaysianDither_WIRE[3], _BaysianDither_WIRE[2]) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:70]
    node BaysianDither = cat(BaysianDither_hi, BaysianDither_lo) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 66:70]
    wire inputAbsX : UInt<5> @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 67:25]
    node dithered = leq(inputAbsX, BaysianDither) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 68:31]
    when P1.io.inbound : @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 70:26]
      inputAbsX <= P1.io.diffX @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 71:17]
      node _io_col_R_T = cat(dithered, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 72:22]
      io.col.R <= _io_col_R_T @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 72:16]
      io.col.G <= UInt<1>("h0") @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 73:16]
      io.col.B <= UInt<1>("h0") @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 74:16]
    else :
      when P2.io.inbound : @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 75:32]
        inputAbsX <= P2.io.diffX @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 76:17]
        io.col.R <= UInt<1>("h0") @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 77:16]
        node _io_col_G_T = cat(dithered, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 78:22]
        io.col.G <= _io_col_G_T @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 78:16]
        io.col.B <= UInt<1>("h0") @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 79:16]
      else :
        when Ball.io.inbound : @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 80:34]
          inputAbsX <= UInt<1>("h0") @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 81:17]
          io.col.R <= UInt<1>("h0") @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 82:16]
          io.col.G <= UInt<2>("h3") @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 83:16]
          io.col.B <= UInt<2>("h3") @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 84:16]
        else :
          inputAbsX <= UInt<1>("h0") @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 86:17]
          node _io_col_R_T_1 = xor(XOR5, XOR2) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 88:26]
          io.col.R <= _io_col_R_T_1 @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 88:16]
          node _io_col_G_T_1 = xor(XOR4, XOR1) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 89:26]
          io.col.G <= _io_col_G_T_1 @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 89:16]
          node _io_col_B_T = xor(XOR3, XOR0) @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 90:26]
          io.col.B <= _io_col_B_T @[\\src\\main\\scala\\vga\\GraphicsProcessor.scala 90:16]


  module GraphicsManager :
    input clock : Clock
    input reset : Reset
    output io : { col : { R : UInt<2>, G : UInt<2>, B : UInt<2>}, flip indexX : UInt<11>, flip indexY : UInt<10>, flip screenDone : UInt<1>, flip input1 : UInt<1>, flip input2 : UInt<1>} @[\\src\\main\\scala\\vga\\GraphicsManager.scala 29:14]

    inst gpu of GraphicsProcessor @[\\src\\main\\scala\\vga\\GraphicsManager.scala 32:19]
    gpu.clock <= clock
    gpu.reset <= reset
    gpu.io.indexX <= io.indexX @[\\src\\main\\scala\\vga\\GraphicsManager.scala 33:17]
    gpu.io.indexY <= io.indexY @[\\src\\main\\scala\\vga\\GraphicsManager.scala 34:17]
    gpu.io.screenDone <= io.screenDone @[\\src\\main\\scala\\vga\\GraphicsManager.scala 35:21]
    gpu.io.input1 <= io.input1 @[\\src\\main\\scala\\vga\\GraphicsManager.scala 36:17]
    gpu.io.input2 <= io.input2 @[\\src\\main\\scala\\vga\\GraphicsManager.scala 37:17]
    node _valid_T = lt(io.indexY, UInt<9>("h1e0")) @[\\src\\main\\scala\\vga\\GraphicsManager.scala 40:25]
    node _valid_T_1 = lt(io.indexX, UInt<10>("h280")) @[\\src\\main\\scala\\vga\\GraphicsManager.scala 40:46]
    node valid = and(_valid_T, _valid_T_1) @[\\src\\main\\scala\\vga\\GraphicsManager.scala 40:33]
    node _io_col_R_T = mux(valid, gpu.io.col.R, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\GraphicsManager.scala 41:18]
    io.col.R <= _io_col_R_T @[\\src\\main\\scala\\vga\\GraphicsManager.scala 41:12]
    node _io_col_G_T = mux(valid, gpu.io.col.G, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\GraphicsManager.scala 42:18]
    io.col.G <= _io_col_G_T @[\\src\\main\\scala\\vga\\GraphicsManager.scala 42:12]
    node _io_col_B_T = mux(valid, gpu.io.col.B, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\GraphicsManager.scala 43:18]
    io.col.B <= _io_col_B_T @[\\src\\main\\scala\\vga\\GraphicsManager.scala 43:12]

  module DebouncerModule :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, out : UInt<1>} @[\\src\\main\\scala\\vga\\Debouncer.scala 12:14]

    reg sync0 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sync0) @[\\src\\main\\scala\\vga\\Debouncer.scala 15:22]
    sync0 <= io.in @[\\src\\main\\scala\\vga\\Debouncer.scala 15:22]
    reg sync1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sync1) @[\\src\\main\\scala\\vga\\Debouncer.scala 16:22]
    sync1 <= sync0 @[\\src\\main\\scala\\vga\\Debouncer.scala 16:22]
    reg sync2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sync2) @[\\src\\main\\scala\\vga\\Debouncer.scala 17:22]
    sync2 <= sync1 @[\\src\\main\\scala\\vga\\Debouncer.scala 17:22]
    reg count : UInt<19>, clock with :
      reset => (reset, UInt<19>("h0")) @[\\src\\main\\scala\\vga\\Debouncer.scala 19:22]
    reg out : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\Debouncer.scala 23:20]
    io.out <= out @[\\src\\main\\scala\\vga\\Debouncer.scala 24:10]
    node _T = neq(sync2, out) @[\\src\\main\\scala\\vga\\Debouncer.scala 27:15]
    when _T : @[\\src\\main\\scala\\vga\\Debouncer.scala 27:24]
      node _count_T = add(count, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\Debouncer.scala 28:20]
      node _count_T_1 = tail(_count_T, 1) @[\\src\\main\\scala\\vga\\Debouncer.scala 28:20]
      count <= _count_T_1 @[\\src\\main\\scala\\vga\\Debouncer.scala 28:11]
      node _T_1 = eq(count, UInt<19>("h7ffff")) @[\\src\\main\\scala\\vga\\Debouncer.scala 29:17]
      when _T_1 : @[\\src\\main\\scala\\vga\\Debouncer.scala 29:31]
        out <= sync2 @[\\src\\main\\scala\\vga\\Debouncer.scala 30:11]
    else :
      count <= UInt<1>("h0") @[\\src\\main\\scala\\vga\\Debouncer.scala 33:11]


  module DebouncerModule_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, out : UInt<1>} @[\\src\\main\\scala\\vga\\Debouncer.scala 12:14]

    reg sync0 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sync0) @[\\src\\main\\scala\\vga\\Debouncer.scala 15:22]
    sync0 <= io.in @[\\src\\main\\scala\\vga\\Debouncer.scala 15:22]
    reg sync1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sync1) @[\\src\\main\\scala\\vga\\Debouncer.scala 16:22]
    sync1 <= sync0 @[\\src\\main\\scala\\vga\\Debouncer.scala 16:22]
    reg sync2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), sync2) @[\\src\\main\\scala\\vga\\Debouncer.scala 17:22]
    sync2 <= sync1 @[\\src\\main\\scala\\vga\\Debouncer.scala 17:22]
    reg count : UInt<19>, clock with :
      reset => (reset, UInt<19>("h0")) @[\\src\\main\\scala\\vga\\Debouncer.scala 19:22]
    reg out : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\vga\\Debouncer.scala 23:20]
    io.out <= out @[\\src\\main\\scala\\vga\\Debouncer.scala 24:10]
    node _T = neq(sync2, out) @[\\src\\main\\scala\\vga\\Debouncer.scala 27:15]
    when _T : @[\\src\\main\\scala\\vga\\Debouncer.scala 27:24]
      node _count_T = add(count, UInt<1>("h1")) @[\\src\\main\\scala\\vga\\Debouncer.scala 28:20]
      node _count_T_1 = tail(_count_T, 1) @[\\src\\main\\scala\\vga\\Debouncer.scala 28:20]
      count <= _count_T_1 @[\\src\\main\\scala\\vga\\Debouncer.scala 28:11]
      node _T_1 = eq(count, UInt<19>("h7ffff")) @[\\src\\main\\scala\\vga\\Debouncer.scala 29:17]
      when _T_1 : @[\\src\\main\\scala\\vga\\Debouncer.scala 29:31]
        out <= sync2 @[\\src\\main\\scala\\vga\\Debouncer.scala 30:11]
    else :
      count <= UInt<1>("h0") @[\\src\\main\\scala\\vga\\Debouncer.scala 33:11]


  module VGATimingModule :
    input clock : Clock
    input reset : Reset
    output io : { hsync : UInt<1>, vsync : UInt<1>, flip indexX : UInt<11>, flip indexY : UInt<10>} @[\\src\\main\\scala\\vga\\VGATimingModule.scala 13:14]

    node _io_hsync_T = gt(io.indexX, UInt<10>("h28f")) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 16:29]
    node _io_hsync_T_1 = lt(io.indexX, UInt<10>("h2f0")) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 16:50]
    node _io_hsync_T_2 = and(_io_hsync_T, _io_hsync_T_1) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 16:37]
    node _io_hsync_T_3 = mux(_io_hsync_T_2, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 16:18]
    io.hsync <= _io_hsync_T_3 @[\\src\\main\\scala\\vga\\VGATimingModule.scala 16:12]
    node _io_vsync_T = gt(io.indexY, UInt<9>("h1e9")) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 17:29]
    node _io_vsync_T_1 = lt(io.indexY, UInt<9>("h1ec")) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 17:50]
    node _io_vsync_T_2 = and(_io_vsync_T, _io_vsync_T_1) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 17:37]
    node _io_vsync_T_3 = mux(_io_vsync_T_2, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\vga\\VGATimingModule.scala 17:18]
    io.vsync <= _io_vsync_T_3 @[\\src\\main\\scala\\vga\\VGATimingModule.scala 17:12]

  module VGAModule :
    input clock : Clock
    input reset : UInt<1>
    output io : { col : { R : UInt<2>, G : UInt<2>, B : UInt<2>}, hsync : UInt<1>, vsync : UInt<1>, flip input1 : UInt<1>, flip input2 : UInt<1>} @[\\src\\main\\scala\\vga\\VGAModule.scala 16:14]

    inst resetModule of resetSynchronizer @[\\src\\main\\scala\\vga\\VGAModule.scala 18:27]
    resetModule.clock <= clock
    resetModule.reset <= reset
    reg hCounter : UInt<10>, clock with :
      reset => (resetModule.io.syncReset, UInt<10>("h0")) @[src/main/scala/chisel3/util/Counter.scala 61:40]
    wire hWrap : UInt<1> @[src/main/scala/chisel3/util/Counter.scala 117:24]
    hWrap <= UInt<1>("h0") @[src/main/scala/chisel3/util/Counter.scala 117:24]
    when UInt<1>("h1") : @[src/main/scala/chisel3/util/Counter.scala 118:16]
      node wrap_wrap = eq(hCounter, UInt<10>("h31f")) @[src/main/scala/chisel3/util/Counter.scala 73:24]
      node _wrap_value_T = add(hCounter, UInt<1>("h1")) @[src/main/scala/chisel3/util/Counter.scala 77:24]
      node _wrap_value_T_1 = tail(_wrap_value_T, 1) @[src/main/scala/chisel3/util/Counter.scala 77:24]
      hCounter <= _wrap_value_T_1 @[src/main/scala/chisel3/util/Counter.scala 77:15]
      when wrap_wrap : @[src/main/scala/chisel3/util/Counter.scala 87:20]
        hCounter <= UInt<1>("h0") @[src/main/scala/chisel3/util/Counter.scala 87:28]
      hWrap <= wrap_wrap @[src/main/scala/chisel3/util/Counter.scala 118:23]
    reg vCounter : UInt<10>, clock with :
      reset => (resetModule.io.syncReset, UInt<10>("h0")) @[src/main/scala/chisel3/util/Counter.scala 61:40]
    wire vWrap : UInt<1> @[src/main/scala/chisel3/util/Counter.scala 117:24]
    vWrap <= UInt<1>("h0") @[src/main/scala/chisel3/util/Counter.scala 117:24]
    when hWrap : @[src/main/scala/chisel3/util/Counter.scala 118:16]
      node wrap_wrap_1 = eq(vCounter, UInt<10>("h20c")) @[src/main/scala/chisel3/util/Counter.scala 73:24]
      node _wrap_value_T_2 = add(vCounter, UInt<1>("h1")) @[src/main/scala/chisel3/util/Counter.scala 77:24]
      node _wrap_value_T_3 = tail(_wrap_value_T_2, 1) @[src/main/scala/chisel3/util/Counter.scala 77:24]
      vCounter <= _wrap_value_T_3 @[src/main/scala/chisel3/util/Counter.scala 77:15]
      when wrap_wrap_1 : @[src/main/scala/chisel3/util/Counter.scala 87:20]
        vCounter <= UInt<1>("h0") @[src/main/scala/chisel3/util/Counter.scala 87:28]
      vWrap <= wrap_wrap_1 @[src/main/scala/chisel3/util/Counter.scala 118:23]
    inst graphics of GraphicsManager @[\\src\\main\\scala\\vga\\VGAModule.scala 31:26]
    graphics.clock <= clock
    graphics.reset <= resetModule.io.syncReset
    graphics.io.indexX <= hCounter @[\\src\\main\\scala\\vga\\VGAModule.scala 34:24]
    graphics.io.indexY <= vCounter @[\\src\\main\\scala\\vga\\VGAModule.scala 35:24]
    graphics.io.screenDone <= vWrap @[\\src\\main\\scala\\vga\\VGAModule.scala 36:28]
    inst debouncer1 of DebouncerModule @[\\src\\main\\scala\\vga\\VGAModule.scala 39:28]
    debouncer1.clock <= clock
    debouncer1.reset <= resetModule.io.syncReset
    inst debouncer2 of DebouncerModule_1 @[\\src\\main\\scala\\vga\\VGAModule.scala 40:28]
    debouncer2.clock <= clock
    debouncer2.reset <= resetModule.io.syncReset
    debouncer1.io.in <= io.input1 @[\\src\\main\\scala\\vga\\VGAModule.scala 41:22]
    debouncer2.io.in <= io.input2 @[\\src\\main\\scala\\vga\\VGAModule.scala 42:22]
    graphics.io.input1 <= debouncer1.io.out @[\\src\\main\\scala\\vga\\VGAModule.scala 45:24]
    graphics.io.input2 <= debouncer2.io.out @[\\src\\main\\scala\\vga\\VGAModule.scala 46:24]
    io.col.R <= graphics.io.col.R @[\\src\\main\\scala\\vga\\VGAModule.scala 47:14]
    io.col.G <= graphics.io.col.G @[\\src\\main\\scala\\vga\\VGAModule.scala 48:14]
    io.col.B <= graphics.io.col.B @[\\src\\main\\scala\\vga\\VGAModule.scala 49:14]
    inst TimingModule of VGATimingModule @[\\src\\main\\scala\\vga\\VGAModule.scala 52:30]
    TimingModule.clock <= clock
    TimingModule.reset <= resetModule.io.syncReset
    TimingModule.io.indexX <= hCounter @[\\src\\main\\scala\\vga\\VGAModule.scala 53:28]
    TimingModule.io.indexY <= vCounter @[\\src\\main\\scala\\vga\\VGAModule.scala 54:28]
    io.hsync <= TimingModule.io.hsync @[\\src\\main\\scala\\vga\\VGAModule.scala 55:14]
    io.vsync <= TimingModule.io.vsync @[\\src\\main\\scala\\vga\\VGAModule.scala 56:14]


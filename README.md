# TinyPong #
## Architecture ##

<img width="645" height="802" alt="image" src="https://github.com/user-attachments/assets/34e8130f-abe8-4c4e-962d-f70ff5663652" />


The project begins with 2 counters in the VGA module which represent x and y pixels. This drives the graphics manager, which handles the requirement for no colour data in the inactive area, and the VGA timings module, which takes care of the Hsync and Vsync timings. The reset synchronizer is initialized in the top module, to make its reset output propogate to the entire design.

The graphics processing unit checks if the pixel is inside the paddles or ball, and if so, outputs the relevant colour. If not, it does a XOR background which gives a more complex appearance than a blank background despite only using a couple of Xor gates.  

The ball and paddle objects handle if a pixel is inside their bounds and their game logic. The inputs from external buttons are debounced to make the system more stable.

## How to test ##
You can run the test cases with ```sbt test```, or compile the chisel to verilog with ```sbt run```. 

## Tiny Tapeout Preliminary Results ##
You can see the 3d render here: https://gds-viewer.tinytapeout.com/?model=https://mr-seoul.github.io/TinyTapeOutGDS/tinytapeout.oas&pdk=ihp-sg13g2

The chip has a 63% logic utilisation (before routing), and a 92% overall utilisation. The cocotb tests pass, works on my FPGA, and the STA/GLS don't give any errors besides one large fanout (likely the synched reset being funneled to all registers, which isn't an issue overall).

You can check the chip here in their verilog simulator: https://vga-playground.com/?repo=Mr-Seoul/TinyTapeOutGDS

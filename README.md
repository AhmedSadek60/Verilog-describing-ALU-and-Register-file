# Verilog-describing-ALU-and-Register-file
This is a part of the MIPS processor schematic. Here we only have the register file and the alu. 
Initially create your separate components in separate modules. 
create the register file as a memory/2d-array in verilog. 
The register file should perform a write operation every clock cycle only if the “write_enable” signal is set to true, 
while it performs read operations all time without delays(combinational circuit). 
![alt text](https://github.com/AhmedSadek60/Verilog-describing-ALU-and-Register-file/blob/master/pic.png)

Then create your alu. The alu should perform basic operations depending on the opcode provided from the 4-bits signal 
[0 : add , 1 : sub , 2 : and , 3 : or, 4 : shift left , 5 : shift right logical, 6: shift right arithmetic,
 7 : greater_than , 8 : less_than ]. You should test both positive and negative numbers. 
you then should create a test bench for this circuit that will enable you to set data and monitor the results. 
Using this testbench, fill the register file with some numbers of your choice, by letting the “mux_ctrl” signal be zero 
to enable the data from the external “wd” signal to flow into the “write_data” port of the register file. 
After that you will have to test your implementation. 
In the test_bench, let the mux_ctrl signal = 1 to enable writing data from the alu.
Test with different inputs and see if the final result is correct. 

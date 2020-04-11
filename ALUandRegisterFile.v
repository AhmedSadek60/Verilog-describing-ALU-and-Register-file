module RegisterFile(
    register_clk,
    read_reg1,
    read_reg2,
    write_reg,
    data_store,
    write_enable,
    read_data1,
    read_data2) ;

input register_clk ;                     // Clock of register
input [4:0] read_reg1,read_reg2;         // reads the data from registers
input [4:0]write_reg;                    // write_reg is to  write on register 
input write_enable;                      // Enable or disable writing on register
//input [31:0]W1;                          // W1 carries the information to be written
input [31:0] data_store;                 // Written results are stored in it
//reg address1,address2;                   // Determines the address of register in register file
reg [31:0] registers[31:0];              // 32 registers each of 32-bit

output [31:0] read_data1,read_data2; // inputs of ALU

assign read_data1 = registers[read_reg1];
assign read_data2 = registers[read_reg2];

always @(register_clk)
begin

 if (write_enable)
        registers[write_reg] <= data_store;
end



endmodule

module Mux(wd, write_ctrl , result , W1);

input write_ctrl;
input [31:0] wd ;
input [31:0] result;
output [31:0] W1;

assign W1 = (write_ctrl == 1)? result : wd;
//if(write_ctrl==1) begin  W1 <= result; end
//else begin W1<=wd; end 

endmodule


module ALU (r1 , r2 , out , shift , OP );

input  [31 : 0] r1,r2;
input [4:0] shift;
input [3:0] OP;

output reg [31 : 0] out;

reg counter_ALU=0;                      // Counter used to reach each bit in the OP code
reg weight_ALU=8;                       // Used to decide the weight of each bit                    
integer out_real;

always @ (r1 or r2 or OP)
begin

case (OP)
0 : begin out = r1 + r2; end  //addition
1 : begin out = r1 - r2;   end      // Subtraction
2 : begin out = r1 & r2;   end      // AND
3 : begin out = r1 | r2;   end      // OR
4 : begin out = r1 << shift ;end     // Shift Left
5 : begin out = r1 >> shift ;end     // Shift Right
6 : begin out = r1 >>> shift;end     // Shift Right Arithmatically

//Checks if they're equal. If they're not it compares and gets the larger value.
7: begin if (r1==r2)begin $display("They are equal");end
    else if (r1 > r2) begin out=r1; end 
    else begin out=r2; end    
    end            

//Checks if they're equal. If they're not it compares and gets the smaller value.
8 :begin if (r1==r2)  begin $display("They are equal");end 
    else if (r1 < r2) begin out=r1;end 
    else begin out=r2;end
   end 

endcase
end
endmodule


module elBench();

reg [31:0] A,B;
wire [31:0] W1, out1, out2;
reg [4:0] s;
wire [31:0] C;
reg [3:0] operation;
reg register_clk;
reg [4:0] address_of_register1 , address_of_register2, write_reg_address;
reg write_permission;

reg mux_enable;
reg [31:0] mux_wd;
always
begin
#5 register_clk = ~register_clk;
end

initial
begin
register_clk=1;
$display ("First input      Second input        oeration          output    Mux Selection");
$monitor ("%d        %d        %d        %d          %d", A,B,operation,C,s);
$display ("------------------------------------------------------------------------------");


//addition
#10
A=2;
B=1;
s = 00000;
operation =0000;
address_of_register1=5;
address_of_register2=4;
write_reg_address=15;
write_permission=1;
mux_enable=1;
mux_wd=30;

//subtract
#10
A=2;
B=1;
s = 00000;
operation =0001;
address_of_register1=5;
address_of_register2=4;
write_reg_address=15;
write_permission=1;
mux_enable=1;
mux_wd=30;

//and
#10
A=2;
B=1;
s = 00000;
operation =2;
address_of_register1=5;
address_of_register2=4;
write_reg_address=15;
write_permission=1;
mux_enable=1;
mux_wd=30;

//or
#10
A=2;
B=1;
s = 00000;
operation =3;
address_of_register1=5;
address_of_register2=4;
write_reg_address=15;
write_permission=1;
mux_enable=1;
mux_wd=30;

//shift left
#10
A=2;
B=1;
s = B;
operation =4;
address_of_register1=5;
address_of_register2=4;
write_reg_address=15;
write_permission=1;
mux_enable=1;
mux_wd=30;

//shift right
#10
A=2;
B=1;
s = B;
operation =5;
address_of_register1=5;
address_of_register2=4;
write_reg_address=15;
write_permission=1;
mux_enable=1;
mux_wd=30;

//shift right arithmatically
#10
A=2;
B=-1;
s = B;
operation =6;
address_of_register1=5;
address_of_register2=4;
write_reg_address=15;
write_permission=1;
mux_enable=1;
mux_wd=30;

//greater than
#10
A=2;
B=1;
s = 00000;
operation =7;
address_of_register1=5;
address_of_register2=4;
write_reg_address=15;
write_permission=1;
mux_enable=1;
mux_wd=30;

// less than
#10
A=2;
B=1;
s = 00000;
operation =8;
address_of_register1=5;
address_of_register2=4;
write_reg_address=15;
write_permission=1;
mux_enable=1;
mux_wd=30;
end

Mux M1(mux_wd,mux_enable,C, W1);
RegisterFile Regist1 (register_clk, address_of_register1, address_of_register2, write_reg_address, W1, write_permission, out1, out2);
ALU A1 (A,B,C,s, operation);
endmodule

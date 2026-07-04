module gate_logic(a,b,and_out,or_out,nand_out,nor_out,notb_out,xor_out,xnor_out); //define gate logic by gate level model 
  input a,b;
  output and_out,or_out,nand_out,nor_out,notb_out,xor_out,xnor_out;
  and a1 (and_out,a,b);
  or o1(or_out,a,b);
  nand n1(nand_out,a,b);
  nor n2(nor_out,a,b);
  not n3(notb_out,b);
  xor x1(xor_out,a,b);
  xnor x2 (xnor_out,a,b);
endmodule
// Testbench //
module tb1( );        //define testbench module
 reg a,b;              // define the input buffer   
 wire and_out,or_out,nand_out,nor_out,notb_out,xor_out,xnor_out;  // define the output as wire connection
gate_logic uut(
 .a(a),  //buffer
 .b(b),
 .and_out(and_out),     // AND gate    
 .or_out(or_out),       // OR gate  
 .notb_out(notb_out),   // NOT gate     
 .nand_out(nand_out),   // NAND gate 
 .nor_out(nor_out),     //NOR gate   
 .xor_out(xor_out),     //XOR gate
 .xnor_out(xnor_out)    //XNOR gate  
);
initial              // start from here once a while
begin                // start here
a=0; b=0; #10       // start with (0,0) with 10ns 
a=0; b=1; #10       
a=1; b=0; #10
a=1; b=1; #10       // start with (1,1) with 40ns 
a=0; b=0; #10
$finish;
end
endmodule

--------------------------------------------------------------------------------------------------------
// define logic gates by data flow model

module gate_logic(a,b,and_out,or_out,nand_out,nor_out,notb_out,xor_out,xnor_out);
   input a,b;
   output and_out,or_out,nand_out,nor_out,notb_out,xor_out,xnor_out;
   and a1 (and_out,a,b);
   or o1(or_out,a,b);
   nand n1(nand_out,a,b);
   nor n2(nor_out,a,b);
   not n3(notb_out,b);
   xor x1(xor_out,a,b);
   xnor x2 (xnor_out,a,b);
endmodule

// Testbench

module tb2( );
reg a,b;
wire and_out,or_out,nand_out,nor_out,notb_out,xor_out,xnor_out;
data_flow uut(
 .a(a),
 .b(b),
 .and_out(and_out),
 .or_out(or_out),
 .notb_out(notb_out),
 .nand_out(nand_out),
 .nor_out(nor_out),
 .xor_out(xor_out),
 .xnor_out(xnor_out)
 );
initial
begin
a=0; b=0; #10
a=0; b=1; #10
a=1; b=0; #10
a=1; b=1; #10
a=0; b=0; #10
$finish;
end
endmodule

---------------------------------------------------------------------------------------------------------------------
// define half adder module
module half_adder(input a, b, output sum, carry );
  assign sum=a^b;
  assign carry= a&b;
endmodule

// define the testbench

module tb1();
reg a,b; wire sum,carry;
half_adder uut(a,b,sum,carry);
initial
begin
a=0;b=0; #10
a=0;b=1; #10
a=1;b=0; #10
a=1;b=1;#10
$finish;
end
endmodule

----------------------------------------------------------------------------------------------------------------------------
//define full adder
module full_adder(input a,b,c,output sum, carry);
  assign sum= a^b^c;
  assign w1=a&b;
  assign w2=b&c;
  assign w3=a&c;
  assign carry=w1|w2|w3;
endmodule

// define testbench of full adder

module tb2();
reg a,b,c; wire sum,carry;
full_adder uut(a,b,c ,sum,carry);
initial
begin
a=0;b=0;c=0; #10
a=0;b=0;c=1; #10
a=0;b=1;c=0; #10
a=0;b=1;c=1; #10
a=1;b=0;c=0; #10
a=1;b=0;c=1; #10
a=1;b=1;c=0; #10
a=1;b=1;c=1; #10
$finish;
end
endmodule
------------------------------------------------------------------------------------------------------------------------------
// full adder using two half adder
module full_addr(input a,b,c, output sum, carry);
  half_adder h1(a,b,w1,w2);
  half_adder h2(w1,c,sum,w3);
  assign carry=w2|w3;
endmodule

//define the testbench to satisfy design module is correctly working
module tb3( );
  reg a,b,c; wire sum,carry;
  full_addr uut(a,b,c,sum,carry);
initial
begin
 for ( integer count = 0; count < 8; count = count + 1)
 begin
 {a, b, c}= count[2:0];
 #10;
 end
 $finish;
 end
endmodule

--------------------------------------------------------------------------------------------------------------------------
//define half subtractor

module half_subtractor( input a,b,output d,bo);
  assign d=a^b;
  assign bo=(~a)&b;
endmodule

//define testbench for tesing the design
module tb4();
reg a,b; wire d,bo;
half_subtractor uut(a,b,d,bo);
initial
begin
a=0;b=0; #10
a=0;b=1; #10
a=1;b=0; #10
a=1;b=1;#10
$finish;
end
endmodule

------------------------------------------------------------------------------------------------------------------------
//define full subtractor
module full_subtractor(input a,b,c ,output d, bo );
assign d=a^b^c;
assign w1=(~a)&b;
assign w2=(~a)&c;
assign w3=b&c;
assign bo= w1|w2|w3;
endmodule

//define testbench to test design
module tb5( );
reg a,b,c ; wire d, bo;
full_subtractor uut(a,b,c ,d,bo);
initial
begin
a=0;b=0;c=0; #10
a=0;b=0;c=1; #10
a=0;b=1;c=0; #10
a=0;b=1;c=1; #10
a=1;b=0;c=0; #10
a=1;b=0;c=1; #10
a=1;b=1;c=0; #10
a=1;b=1;c=1; #10
$finish;
end
endmodule
------------------------------------------------------------------------------------------------------------------------
//define the full subtractor by half subtractor
module full_sub(input a,b,c,output d,bo);
half_subtractor h1(a,b,w1,w2);
half_subtractor h2(w1,c,d,w3);
assign bo= w2|w3;
endmodule
// define testbech
module tb6( );
reg a,b,c; wire d,bo;
full_sub uut(a,b,c ,d,bo);
initial
begin
a=0;b=0;c=0; #10
a=0;b=0;c=1; #10
a=0;b=1;c=0; #10
a=0;b=1;c=1; #10
a=1;b=0;c=0; #10
a=1;b=0;c=1; #10
a=1;b=1;c=0; #10
a=1;b=1;c=1; #10
$finish;
end
endmodule
--------------------------------------------------------------------------------------------------------------------------
//define ripple carrry adder in 4 bit
module ripple_carry_addr(a,b,cin, sum,carry );
input [3:0] a,b;
input cin;
output [3:0] sum;
output carry;
wire[2:0] c;
full_adder f1(a[0],b[0],cin,sum[0],c[0]);
full_adder f2(a[1],b[1],c[0],sum[1],c[1]);
full_adder f3(a[2],b[2],c[1],sum[2],c[2]);
full_adder f4(a[3],b[3],c[2],sum[3],carry);
endmodule
//define testbench
module tb7( );
reg [3:0] a,b; reg cin;wire [3:0] sum;wire carry;
ripple_carry_addr uut (a,b, cin,sum,carry);
initial begin
a=4'b0000; b=4'b0101; cin=0; #10
a=4'b0110; b=4'b0101; cin=1; #10
a=4'b0110; b=4'b1111; cin=0; #10
a=4'b1111; b=4'b1111; cin=1; #10
$finish;
end
endmodule
-------------------------------------------------------------------------------------------------------------------------
//define 2*1 mux
module x1_mux(a,b,s,out);
input a,b,s;
output out;
assign out=((~s)&a)|(s&b);
endmodule

//define testbench

module tb1( );
reg a,b,s; wire out;
x1_mux uut(a,b,s,out);
initial
begin
a=0;b=1; s=0; #10
a=0;b=1; s=1; #10
a=1;b=0; s=0; #10
a=1;b=0; s=1; #10
$finish;
end
endmodule

-------------------------------------------------------------------------------------------------------------------------
// define 8*1 mux
module eight_x_one_mux(in,sel,out );
input [7:0] in;
input [2:0] sel;
output reg out;
always @ (*)
begin
case(sel)
3'b000: out=in[0];
3'b001: out=in[1];
3'b010: out=in[2];
3'b011: out=in[3];
3'b100: out=in[4];
3'b101: out=in[5];
3'b110: out=in[6];
3'b111: out=in[7];
default: out=0;
endcase
end
endmodule

//define testbench

module tb3(out);
reg [7:0] in;
reg [2:0] sel;
output out;
eight_x_one_mux dut (in,sel,out);
initial
begin
 in=8'b10101010;
 sel=3'b000; #10
 sel=3'b001; #10
 sel=3'b010; #10
 sel=3'b011; #10
 sel=3'b100; #10
 sel=3'b101; #10
 sel=3'b110; #10
 sel=3'b111; #10
 in=8'b11110000;
 sel=3'b000; #10
 sel=3'b001; #10
 sel=3'b010; #10
 sel=3'b011; #10
 sel=3'b100; #10
 sel=3'b101; #10
 sel=3'b110; #10
 sel=3'b111; #10
 $finish;
 end
endmodule

---------------------------------------------------------------------------------------------------------------------------

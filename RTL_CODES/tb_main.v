/*
module tb_top;

 // Inputs
 reg clk;
 reg rst;
 reg [31:0] D1;

 // Outputs
 wire clk_g;
 wire [31:0]Q2;
	

 // Instantiate the Unit Under Test (UUT)
 data_driven_new uut (
  .clk(clk), 
  .rst(rst), 
  .D1(D1), 
  .clk_g(clk_g),
      .Q2(Q2)
 );
	
 always
 #50 clk=~clk;

 initial begin
  // Initialize Inputs
  clk = 0;
  rst = 1;
  #5
  rst = 0;
  D1 = 32'h F0FF00FF;
  #50
  D1 = 32'h 000FFFF0;
  #100
   D1 = 32'h F0FF00FF;
   #50
     D1 = 32'h 000FFFF0;
           #150
     D1 = 32'h F0F0F0F0;
     #200
     D1 = 32'h ABCDEF01;
  // Wait 100 ns for global reset to finish
  
  

      


  // Add stimulus here

 end
	
 initial
 begin
 $dumpfile("tb_top.vcd");
 $dumpvars(1,tb_top.uut);
 end 
      
endmodule*/



module tb_top;

 // Inputs
 reg clk;
 reg rst;
 reg [31:0] D1;

 // Outputs
 wire clk_g;
 wire [31:0] Q2;

 // Instantiate the Unit Under Test (UUT)
 data_driven_new uut (
  .clk(clk), 
  .rst(rst), 
  .D(D1),        // fixed
  .clk_g(clk_g),
  .Q(Q2)         // fixed
 );

 // Clock generation
 always
   #50 clk = ~clk;

 initial begin
  // Initialize Inputs
  clk = 0;
  rst = 1;
  
  #5
  rst = 0;

  D1 = 32'hF0FF00FF;
  #50
  D1 = 32'h000FFFF0;
  #100
  D1 = 32'hF0FF00FF;
  #50
  D1 = 32'h000FFFF0;
  #150
  D1 = 32'hF0F0F0F0;
  #200
  D1 = 32'hABCDEF01;

  // finish simulation after some time
  #200
  $finish;

 end


endmodule



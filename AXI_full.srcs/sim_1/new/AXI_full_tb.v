`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/02 14:01:06
// Design Name: 
// Module Name: AXI_full_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AXI_full_tb();

reg clk = 1;
reg rst_n;
reg txn;

always #5 clk <= !clk;

initial begin
    rst_n <= 0;
    txn <= 0;
    @(posedge clk)
    rst_n <= 1;
    @(posedge clk)
    txn <= 1;
end

design_1_wrapper uut
(
    .m00_axi_aclk_0          (clk),
    .m00_axi_aresetn_0       (rst_n),
    .m00_axi_init_axi_txn_0  (txn)
);

endmodule
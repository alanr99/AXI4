`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/20 15:35:10
// Design Name: 
// Module Name: top_tb
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


module top_tb();

reg     i_sys_clk = 1;
reg     i_sys_rst_n;
wire    o_led;
wire	awvalid;

assign awvalid = uut_top.M_AXI_AWVALID;

always #5 i_sys_clk = !i_sys_clk;

initial begin
    i_sys_rst_n <= 1;
    @(posedge i_sys_clk)
    i_sys_rst_n <= 0;
    @(posedge i_sys_clk)
    i_sys_rst_n <= 1;
    @(posedge i_sys_clk)


    @(posedge awvalid)
    @(posedge awvalid)
    $finish;
end

top uut_top(
    .i_sys_clk(i_sys_clk),
    .i_sys_rst_n(i_sys_rst_n),
    .o_led(o_led)
);
endmodule

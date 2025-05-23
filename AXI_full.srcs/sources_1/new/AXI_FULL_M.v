`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/08 18:13:30
// Design Name: 
// Module Name: AXI_FULL_M
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


module AXI_FULL_M#(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Base address of targeted slave
		parameter  C_M_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		// Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
		parameter integer C_M_AXI_BURST_LEN	= 16,
		// Thread ID Width
		parameter integer C_M_AXI_ID_WIDTH	= 1,
		// Width of Address Bus
		parameter integer C_M_AXI_ADDR_WIDTH	= 32,
		// Width of Data Bus
		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		// Width of User Write Address Bus
		parameter integer C_M_AXI_AWUSER_WIDTH	= 0,
		// Width of User Read Address Bus
		parameter integer C_M_AXI_ARUSER_WIDTH	= 0,
		// Width of User Write Data Bus
		parameter integer C_M_AXI_WUSER_WIDTH	= 0,
		// Width of User Read Data Bus
		parameter integer C_M_AXI_RUSER_WIDTH	= 0,
		// Width of User Response Bus
		parameter integer C_M_AXI_BUSER_WIDTH	= 0
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line

		// Initiate AXI transactions
		input wire  INIT_AXI_TXN,
		// Asserts when transaction is complete
		output wire  TXN_DONE,
		// Asserts when ERROR is detected
		output reg  ERROR,
		// Global Clock Signal.
		input wire  M_AXI_ACLK,
		// Global Reset Singal. This Signal is Active Low
		input wire  M_AXI_ARESETN,
		// Master Interface Write Address ID
		output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_AWID,
		// Master Interface Write Address
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
		// Burst length. The burst length gives the exact number of transfers in a burst
		output wire [7 : 0] M_AXI_AWLEN,
		// Burst size. This signal indicates the size of each transfer in the burst
		output wire [2 : 0] M_AXI_AWSIZE,
		// Burst type. The burst type and the size information, 
    // determine how the address for each transfer within the burst is calculated.
		output wire [1 : 0] M_AXI_AWBURST,
		// Lock type. Provides additional information about the
    // atomic characteristics of the transfer.
		output wire  M_AXI_AWLOCK,
		// Memory type. This signal indicates how transactions
    // are required to progress through a system.
		output wire [3 : 0] M_AXI_AWCACHE,
		// Protection type. This signal indicates the privilege
    // and security level of the transaction, and whether
    // the transaction is a data access or an instruction access.
		output wire [2 : 0] M_AXI_AWPROT,
		// Quality of Service, QoS identifier sent for each write transaction.
		output wire [3 : 0] M_AXI_AWQOS,
		// Optional User-defined signal in the write address channel.
		output wire [C_M_AXI_AWUSER_WIDTH-1 : 0] M_AXI_AWUSER,
		// Write address valid. This signal indicates that
    // the channel is signaling valid write address and control information.
		output wire  M_AXI_AWVALID,
		// Write address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
		input wire  M_AXI_AWREADY,
		// Master Interface Write Data.
		output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
		// Write strobes. This signal indicates which byte
    // lanes hold valid data. There is one write strobe
    // bit for each eight bits of the write data bus.
		output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
		// Write last. This signal indicates the last transfer in a write burst.
		output wire  M_AXI_WLAST,
		// Optional User-defined signal in the write data channel.
		output wire [C_M_AXI_WUSER_WIDTH-1 : 0] M_AXI_WUSER,
		// Write valid. This signal indicates that valid write
    // data and strobes are available
		output wire  M_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    // can accept the write data.
		input wire  M_AXI_WREADY,
		// Master Interface Write Response.
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_BID,
		// Write response. This signal indicates the status of the write transaction.
		input wire [1 : 0] M_AXI_BRESP,
		// Optional User-defined signal in the write response channel
		input wire [C_M_AXI_BUSER_WIDTH-1 : 0] M_AXI_BUSER,
		// Write response valid. This signal indicates that the
    // channel is signaling a valid write response.
		input wire  M_AXI_BVALID,
		// Response ready. This signal indicates that the master
    // can accept a write response.
		output wire  M_AXI_BREADY,
		// Master Interface Read Address.
		output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_ARID,
		// Read address. This signal indicates the initial
    // address of a read burst transaction.
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
		// Burst length. The burst length gives the exact number of transfers in a burst
		output wire [7 : 0] M_AXI_ARLEN,
		// Burst size. This signal indicates the size of each transfer in the burst
		output wire [2 : 0] M_AXI_ARSIZE,
		// Burst type. The burst type and the size information, 
    // determine how the address for each transfer within the burst is calculated.
		output wire [1 : 0] M_AXI_ARBURST,
		// Lock type. Provides additional information about the
    // atomic characteristics of the transfer.
		output wire  M_AXI_ARLOCK,
		// Memory type. This signal indicates how transactions
    // are required to progress through a system.
		output wire [3 : 0] M_AXI_ARCACHE,
		// Protection type. This signal indicates the privilege
    // and security level of the transaction, and whether
    // the transaction is a data access or an instruction access.
		output wire [2 : 0] M_AXI_ARPROT,
		// Quality of Service, QoS identifier sent for each read transaction
		output wire [3 : 0] M_AXI_ARQOS,
		// Optional User-defined signal in the read address channel.
		output wire [C_M_AXI_ARUSER_WIDTH-1 : 0] M_AXI_ARUSER,
		// Write address valid. This signal indicates that
    // the channel is signaling valid read address and control information
		output wire  M_AXI_ARVALID,
		// Read address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
		input wire  M_AXI_ARREADY,
		// Read ID tag. This signal is the identification tag
    // for the read data group of signals generated by the slave.
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_RID,
		// Master Read Data
		input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
		// Read response. This signal indicates the status of the read transfer
		input wire [1 : 0] M_AXI_RRESP,
		// Read last. This signal indicates the last transfer in a read burst
		input wire  M_AXI_RLAST,
		// Optional User-defined signal in the read address channel.
		input wire [C_M_AXI_RUSER_WIDTH-1 : 0] M_AXI_RUSER,
		// Read valid. This signal indicates that the channel
    // is signaling the required read data.
		input wire  M_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    // accept the read data and response information.
		output wire  M_AXI_RREADY
    );

function integer clogb2(input integer num);
begin
	for (clogb2 = 0; num > 0; clogb2 = clogb2 + 1)
		num = num >> 1;
end
endfunction

//***********************parameters************************//
parameter 	P_ST_IDLE 			= 'd0,

			P_ST_WRITE_START 	= 'd1,
			P_ST_WRITE_TRANS	= 'd2,
			P_ST_WRITE_END		= 'd3,

			P_ST_READ_START		= 'd4,
			P_ST_READ_TRANS		= 'd5,
			P_ST_READ_END		= 'd6;

//***************************FSM***************************//
reg [7:0]							r_st_current_write;
reg [7:0]							r_st_next_write;
reg [7:0]							r_st_current_read;
reg [7:0]							r_st_next_read;

//*************************register************************//
reg 	[C_M_AXI_ADDR_WIDTH-1:0]	r_m_axi_awaddr			;
reg									r_m_axi_awvalid			;

reg 	[C_M_AXI_ADDR_WIDTH-1:0]	r_m_axi_wdata			;
reg 								r_m_axi_wlast			;
reg 								r_m_axi_wvalid			;
reg 								r_m_axi_bready			;

reg 	[C_M_AXI_ADDR_WIDTH-1:0]	r_m_axi_araddr			;
reg									r_m_axi_arvalid			;
reg 								r_m_axi_rready			;

reg 								r_write_start			;
//reg 	[$clogb2(C_M_AXI_BURST_LEN)-1:0]	r_brust_cnt		;
reg 	[7:0]						r_brust_cnt				;
reg 								r_read_start			;
reg 	[C_M_AXI_DATA_WIDTH-1:0]	r_m_axi_read_data		;
//***************************wire**************************//

//**********************combinational**********************//
assign M_AXI_AWID		= 0									;
assign M_AXI_AWLEN		= C_M_AXI_BURST_LEN - 1				;
assign M_AXI_AWSIZE		= clogb2(C_M_AXI_DATA_WIDTH/8 - 1)	;
assign M_AXI_AWBURST	= 2'b01								;
assign M_AXI_AWLOCK		= 0									;
assign M_AXI_AWCACHE	= 4'b0010							;
assign M_AXI_AWPROT		= 3'b000							;
assign M_AXI_AWQOS		= 0									;
assign M_AXI_AWUSER		= 0									;
assign M_AXI_AWADDR		= r_m_axi_awaddr + C_M_TARGET_SLAVE_BASE_ADDR;
assign M_AXI_AWVALID	= r_m_axi_awvalid					;

assign M_AXI_WSTRB		= {C_M_AXI_DATA_WIDTH{1'b1}}		;
assign M_AXI_WUSER		= 0									;
assign M_AXI_WDATA		= r_m_axi_wdata						;
assign M_AXI_WLAST		= r_m_axi_wlast						;
assign M_AXI_WVALID		= r_m_axi_wvalid					;

assign M_AXI_BREADY		= r_m_axi_bready					;

assign M_AXI_ARID		= 0									;
assign M_AXI_ARADDR		= r_m_axi_araddr + C_M_TARGET_SLAVE_BASE_ADDR;
assign M_AXI_ARLEN		= C_M_AXI_BURST_LEN - 1				;
assign M_AXI_ARSIZE		= clogb2(C_M_AXI_DATA_WIDTH/8 - 1)	;
assign M_AXI_ARBURST	= 2'b01								;
assign M_AXI_ARLOCK		= 0									;
assign M_AXI_ARCACHE	= 4'b0010							;
assign M_AXI_ARPROT		= 3'b000							;
assign M_AXI_ARQOS		= 0									;
assign M_AXI_ARUSER		= 0									;
assign M_AXI_ARVALID	= r_m_axi_arvalid					;

assign M_AXI_RREADY		= r_m_axi_rready					;



//***********************instantiate***********************//

//*************************process*************************//
//write
always @(posedge M_AXI_ACLK)
	if(!M_AXI_ARESETN)
		r_m_axi_awvalid <= 1'b0;
	else if(r_write_start)
		r_m_axi_awvalid <= 1'b1;
	else if(M_AXI_AWVALID && M_AXI_AWREADY)
		r_m_axi_awvalid <= 1'b0;
	else
		r_m_axi_awvalid <= r_m_axi_awvalid;

always @(posedge M_AXI_ACLK)
	if(!M_AXI_ARESETN)
		r_m_axi_awaddr <= 0;
	else if(r_write_start)
		r_m_axi_awaddr <= 0;
	else
		r_m_axi_awaddr <= 0;

always @(posedge M_AXI_ACLK)
	if(!M_AXI_ARESETN || M_AXI_WLAST)
		r_m_axi_wvalid <= 0;
	else if(M_AXI_AWVALID && M_AXI_AWREADY)
		r_m_axi_wvalid <= 1;
	else
		r_m_axi_wvalid <= r_m_axi_wvalid;

always @(posedge M_AXI_ACLK)
	if(!M_AXI_ARESETN || M_AXI_WLAST)
		r_m_axi_wdata <= 1;
	else if(M_AXI_WREADY && M_AXI_WVALID)
		r_m_axi_wdata <= r_m_axi_wdata + 1;
	else
		r_m_axi_wdata <= r_m_axi_wdata;

always @(posedge M_AXI_ACLK)
	if(!M_AXI_ARESETN)
		r_m_axi_wlast <= 0;
	else if((((r_brust_cnt == C_M_AXI_BURST_LEN - 2) && C_M_AXI_BURST_LEN >= 2) && (M_AXI_WVALID && M_AXI_WREADY))
			|| ((C_M_AXI_BURST_LEN == 1) && (M_AXI_WVALID && !M_AXI_WREADY)))
		r_m_axi_wlast <= 1;
	else
		r_m_axi_wlast <= 0;

always @(posedge M_AXI_ACLK)
	if(!M_AXI_ARESETN || r_m_axi_wlast || r_write_start)
		r_brust_cnt <= 0;
	else if(M_AXI_WVALID && M_AXI_WREADY && r_brust_cnt != C_M_AXI_BURST_LEN - 1)
		r_brust_cnt <= r_brust_cnt + 1;
	else
		r_brust_cnt <= r_brust_cnt;

always @(posedge M_AXI_ACLK)
	if(!M_AXI_ARESETN || r_m_axi_bready)
		r_m_axi_bready <= 0;
	else if(M_AXI_BVALID && !M_AXI_BREADY)
		r_m_axi_bready <= 1;
	else
		r_m_axi_bready <= r_m_axi_bready;

//read

always @(posedge M_AXI_ACLK)
	if(!M_AXI_ARESETN || (M_AXI_ARVALID && M_AXI_ARREADY))
		r_m_axi_arvalid <= 0;
	else if(r_read_start)
		r_m_axi_arvalid <= 1;
	else
		r_m_axi_arvalid <= r_m_axi_arvalid;

always @(posedge M_AXI_ACLK)
	if(!M_AXI_ARESETN)
		r_m_axi_araddr <= 0;
	else if(M_AXI_ARVALID && M_AXI_ARREADY)
		r_m_axi_araddr <= r_m_axi_araddr;
	else
		r_m_axi_araddr <= r_m_axi_araddr;

always @(posedge M_AXI_ACLK)
	if(!M_AXI_ARESETN || M_AXI_RLAST)
		r_m_axi_rready <= 0;
	else if(M_AXI_ARVALID && M_AXI_ARREADY)
		r_m_axi_rready <= 1;
	else
		r_m_axi_rready <= r_m_axi_rready;

always @(posedge M_AXI_ACLK)
	if(!M_AXI_ARESETN)
		r_m_axi_read_data <= 0;
	else if(M_AXI_RVALID && r_m_axi_rready)
		r_m_axi_read_data <= M_AXI_RDATA;
	else
		r_m_axi_read_data <= r_m_axi_read_data;

//write FSM

always @(posedge M_AXI_ACLK)
	if(!M_AXI_ARESETN)
		r_st_current_write <= P_ST_IDLE;
	else
		r_st_current_write <= r_st_next_write;

always @(*)
	case (r_st_current_write)
		P_ST_IDLE			: r_st_next_write = P_ST_WRITE_START;
		P_ST_WRITE_START	: r_st_next_write = r_write_start ? P_ST_WRITE_TRANS : P_ST_WRITE_START;
		P_ST_WRITE_TRANS	: r_st_next_write = r_m_axi_wlast ? P_ST_WRITE_END : P_ST_WRITE_TRANS;
		P_ST_WRITE_END		: r_st_next_write = (r_st_next_read == P_ST_READ_END) ? P_ST_IDLE : P_ST_WRITE_END;
		default				: r_st_next_write = P_ST_IDLE;
	endcase

always @(posedge M_AXI_ACLK)
	if(r_st_current_write == P_ST_WRITE_START)
		r_write_start <= 1;
	else
		r_write_start <= 0;

//read FSM

always @(posedge M_AXI_ACLK)
	if(!M_AXI_ARESETN)
		r_st_current_read <= P_ST_IDLE;
	else
		r_st_current_read <= r_st_next_read;

always @(*)
	case (r_st_current_read)
		P_ST_IDLE			: r_st_next_read = (r_st_current_write == P_ST_WRITE_END) ? P_ST_READ_START : P_ST_IDLE;
		P_ST_READ_START		: r_st_next_read = r_read_start ? P_ST_READ_TRANS : P_ST_READ_START;
		P_ST_READ_TRANS		: r_st_next_read = M_AXI_RLAST ? P_ST_READ_END : P_ST_READ_TRANS;
		P_ST_READ_END		: r_st_next_read = P_ST_IDLE;
		default				: r_st_next_read = P_ST_IDLE;
	endcase

always @(posedge M_AXI_ACLK)
	if(r_st_current_read == P_ST_READ_START)
		r_read_start <= 1;
	else
		r_read_start <= 0;

endmodule

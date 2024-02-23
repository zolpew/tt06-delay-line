/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_zolpew_example_delay_line (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);  
    reg [7:0] y;
    wire [7:0] out1;
    wire [7:0] out2;
    wire [7:0] out3;
    wire [7:0] out4;

    n_30_delay_line jalur1 (.clock(clk), .data(ui_in),.reset_n(rst_n), .out(out1));
    n_45_delay_line jalur2 (.clock(clk), .data(ui_in),.reset_n(rst_n), .out(out2));
    n_60_delay_line jalur3 (.clock(clk), .data(ui_in),.reset_n(rst_n), .out(out3));
    n_90_delay_line jalur4 (.clock(clk), .data(ui_in),.reset_n(rst_n), .out(out4));
    
    always @(out1, out2, out3, out4, uio_in,ena)
        begin
        if (ena) 
            begin
                case(uio_in)
                    8'b00000000: y = out1;
                    8'b00000001: y = out2;
                    8'b00000010: y = out3;
                    8'b00000011: y = out4;
                    default: y = 0;
                endcase
            end
        else begin
                    y = 0;
            end
        end

    assign uo_out = y;
    assign uio_out = 0;
    assign uio_oe  = 0;

endmodule


module n_30_delay_line(input wire clock, input wire [7:0] data, input wire reset_n ,output wire [7:0] out);

    reg [7:0] delay_reg [0:29]; // Array of registers for 30 delay blocks
    reg [7:0] temp [0:29];  // Temporary register
  
    genvar i;
        generate
            for (i = 0; i < 30; i = i + 1) begin : gen_loop
                always @(posedge clock or negedge reset_n) begin
                    if (!reset_n) // If reset_n is low
                        temp[i] <= 8'b00000000;
                        
             
                    else begin
                      
                        if (i==0) begin
                            temp[i] <= data; // First delay block gets the input data
                            delay_reg[i] <= temp[i];
                        end
                        else begin
                            temp[i] <= delay_reg[i - 1]; // Each subsequent delay block gets the output of the previous one
                            delay_reg[i] <= temp[i];
                        end
                    end
                end
            end
        endgenerate

    assign out = delay_reg[29]; // Output is the output of the last delay block


endmodule

module n_45_delay_line(input wire clock, input wire [7:0] data, input wire reset_n,output wire [7:0] out);

    reg [7:0] delay_reg [0:44]; // Array of registers for 30 delay blocks
    reg [7:0] temp [0:44];  // Temporary register


 
    genvar i;
        generate
            for (i = 0; i < 45; i = i + 1) begin : gen_loop
                always @(posedge clock or negedge reset_n) begin
                    if (!reset_n) // If reset_n is low
                        temp[i] <= 8'b00000000;
                        
             
                    else begin
                        if (i==0) begin
                            temp <= data; // First delay block gets the input data
                            delay_reg[i] <= temp[i];
                        end
                        else begin
                            temp[i] <= delay_reg[i - 1]; // Each subsequent delay block gets the output of the previous one
                            delay_reg[i] <= temp[i];
                        end
                    end
                end
            end
        endgenerate
    
    assign out = delay_reg[44]; // Output is the output of the last delay block


endmodule

module n_60_delay_line(input wire clock, input wire [7:0] data, input wire reset_n , output wire [7:0] out);

    reg [7:0] delay_reg [0:59]; // Array of registers for 30 delay blocks
    reg [7:0] temp [0:59];  // Temporary register

    
    genvar i;
        generate
            for (i = 0; i < 60; i = i + 1) begin : gen_loop
                always @(posedge clock or negedge reset_n) begin
                    if (!reset_n) // If reset_n is low
                        temp[i] <= 8'b00000000;
                        
             
                    else begin
                        if (i==0) begin
                            temp[i] <= data; // First delay block gets the input data
                            delay_reg[i] <= temp[i];
                        end
                        else begin
                            temp[i] <= delay_reg[i - 1]; // Each subsequent delay block gets the output of the previous one
                            delay_reg[i] <= temp[i];
                        end
                    end
                end
            end
        endgenerate

    assign out = delay_reg[59]; // Output is the output of the last delay block


endmodule

module n_90_delay_line(input wire clock, input wire [7:0] data, input wire reset_n ,  output wire [7:0] out);

    reg [7:0] delay_reg [0:89]; // Array of registers for 30 delay blocks
    reg [7:0] temp [0:89];  // Temporary register

 
 
    genvar i;
        generate
            for (i = 0; i < 90; i = i + 1) begin : gen_loop
                always @(posedge clock or negedge reset_n) begin
                    if (!reset_n) // If reset_n is low
                        temp[i] <= 8'b00000000;
                        
             
                    else begin
                        if (i==0) begin
                            temp[i] <= data; // First delay block gets the input data
                            delay_reg[i] <= temp[i];
                        end
                        else begin
                            temp <= delay_reg[i - 1]; // Each subsequent delay block gets the output of the previous one
                            delay_reg[i] <= temp[i];
                        end
                    end
                end
            end
        endgenerate

    assign out = delay_reg[89]; // Output is the output of the last delay block


endmodule

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

    n_30_delay_line jalur1 (.clock(clk), .data(ui_in), .out(out1));
    n_45_delay_line jalur2 (.clock(clk), .data(ui_in), .out(out2));
    n_60_delay_line jalur3 (.clock(clk), .data(ui_in), .out(out3));
    n_90_delay_line jalur4 (.clock(clk), .data(ui_in), .out(out4));

    always @(out1, out2, out3, out4, uio_in)
        begin
            case(uio_in)
                8'b00000000: y = out1;
                8'b00000001: y = out2;
                8'b00000010: y = out3;
                8'b00000011: y = out4;
                default: y = 0;
            endcase
        end

    assign uo_out = y;
    assign uio_out = 0;
    assign uio_oe  = 0;

endmodule


module n_30_delay_line(input wire clock, input wire [7:0] data,output wire [7:0] out);

    reg [7:0] delay_reg [0:29]; // Array of registers for 30 delay blocks
    reg [7:0] before_out_test;
    integer i; // Loop variable

    always @(posedge clock) begin
        delay_reg[0] <= data; // First delay block gets the input data
        for (i = 1; i < 30; i = i + 1) begin
            delay_reg[i] <= delay_reg[i - 1]; // Each subsequent delay block gets the output of the previous one
        end
    end

    assign out = delay_reg[29]; // Output is the output of the last delay block


endmodule

module n_45_delay_line(input wire clock, input wire [7:0] data,output wire [7:0] out);

    reg [7:0] delay_reg [0:44]; // Array of registers for 30 delay blocks
    reg [7:0] before_out_test;
    integer i; // Loop variable

    always @(posedge clock) begin
        delay_reg[0] <= data; // First delay block gets the input data
        for (i = 1; i < 45; i = i + 1) begin
            delay_reg[i] <= delay_reg[i - 1]; // Each subsequent delay block gets the output of the previous one


        end
    end

    assign out = delay_reg[44]; // Output is the output of the last delay block


endmodule

module n_60_delay_line(input wire clock, input wire [7:0] data, output wire [7:0] out);

    reg [7:0] delay_reg [0:59]; // Array of registers for 30 delay blocks
    reg [7:0] before_out_test;
    integer i; // Loop variable

    always @(posedge clock) begin
        delay_reg[0] <= data; // First delay block gets the input data
        for (i = 1; i < 60; i = i + 1) begin
            delay_reg[i] <= delay_reg[i - 1]; // Each subsequent delay block gets the output of the previous one


        end
    end

    assign out = delay_reg[59]; // Output is the output of the last delay block


endmodule

module n_90_delay_line(input wire clock, input wire [7:0] data,  output wire [7:0] out);

    reg [7:0] delay_reg [0:89]; // Array of registers for 30 delay blocks
    reg [7:0] before_out_test;
    integer i; // Loop variable

    always @(posedge clock) begin
        delay_reg[0] <= data; // First delay block gets the input data
        for (i = 1; i < 90; i = i + 1) begin
            delay_reg[i] <= delay_reg[i - 1]; // Each subsequent delay block gets the output of the previous one


        end
    end

    assign out = delay_reg[89]; // Output is the output of the last delay block


endmodule

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



    n_30_delay_line jalur1 (.clock(clk), .data(ui_in),.reset_n(rst_n), .out(out1));
 

    
    always @(out1, uio_in,ena)
        begin
        if (ena) 
            begin
                case(uio_in)
                    8'b00000000: y = out1;
              

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

  
    genvar i;
        generate
            for (i = 0; i < 30; i = i + 1) begin : gen_loop
                always @(posedge clock or negedge reset_n) begin
                    if (!reset_n) // If reset_n is low
                        delay_reg[i] <= 8'b00000000;
                        
             
                    else begin
                      
                        if (i==0) begin
                            delay_reg[i] <= data; // First delay block gets the input data
                         
                        end
                        else begin
                            delay_reg[i] <= delay_reg[i - 1]; // Each subsequent delay block gets the output of the previous one
                          
                        end
                    end
                end
            end
        endgenerate

    assign out = delay_reg[29]; // Output is the output of the last delay block


endmodule





`include "defines.svh"
// creating fir filter model:
module fir_filter
(   
    // Ports
    input  logic                 clk,
    input  logic                 rst_n,

    // Input Stream
    input  logic signed [`IN_W-1:0]  i_data, // input in Q1.15 format
    input  logic                    i_valid,
    output logic                    o_ready,

    // Output Stream
    output logic signed [`OUT_W-1:0] o_data,
    output logic                    o_valid,
    input  logic                    i_ready
);

endmodule
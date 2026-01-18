`include "defines.svh"

module shift_reg 
(
    input  logic                   clk,
    input  logic                   rst_n,
    
    // Control signal: high when a new sample is accepted
    input  logic                   i_en,      
    
    // New incoming sample
    input  logic signed [`IN_W-1:0] i_data,    
    
    // Parallel output of all stored samples for the filter taps
    output logic signed [`IN_W-1:0] o_array [0:`N_TAPS-1]
);

    // Internal logic and shift process will be implemented here

endmodule

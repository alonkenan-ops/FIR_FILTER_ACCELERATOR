`include "defines.svh"

module wallace_tree_core (
    input  logic        clk,    // לצורך Pipelining באמצע העץ
    input  logic        rst_n,
    input  logic [31:0] i_all_rows [0:255], // כל ה-256 שורות מכל הטאפים
    output logic [35:0] o_sum_vec,
    output logic [35:0] o_carry_vec
);

endmodule
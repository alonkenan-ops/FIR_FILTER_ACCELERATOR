`include "defines.svh"
// Creating FIR filter model:
module fir_filter
(   
    // Ports
    input  logic                 clk,
    input  logic                 rst_n,

    // Input Stream
    input  logic signed [`IN_W-1:0]  i_data,
    input  logic                    i_valid,
    output logic                    o_ready,

    // Output Stream
    output logic signed [`OUT_W-1:0] o_data,
    output logic                    o_valid,
    input  logic                    i_ready
);

    // Internal signals
    logic signed [`IN_W-1:0] o_array [0:`N_TAPS-1];
    logic signed [`COEF_W-1:0] coefficients [0:`N_TAPS-1];
    logic [31:0] i_all_rows [0:255];  // 256 rows of partial products from all taps
    logic [35:0] o_sum_vec, o_carry_vec;
    logic [35:0] o_result;
    logic data_valid;

    // Valid pipeline for tracking output validity through pipeline stages
    logic [3:0] valid_pipe;

    // ===== Shift Register: stores all 16 tap samples =====
    shift_reg sr_inst (
        .clk(clk),
        .rst_n(rst_n),
        .i_en(i_valid),
        .i_data(i_data),
        .o_array(o_array)
    );

    // ===== Partial Product Generation: 16 taps × 16 coefficients =====
    // Each tap generates 16 rows of partial products (Baugh-Wooley multiplication)
    // Total: 16 taps × 16 rows = 256 rows
    genvar tap_idx;
    generate
        for (tap_idx = 0; tap_idx < `N_TAPS; tap_idx++) begin : pp_gen_loop
            partial_prod_gen pp_inst (
                .i_sample(o_array[tap_idx]),
                .i_coeff(coefficients[tap_idx]),
                .o_rows(i_all_rows[tap_idx*16 +: 16])  // 16 rows per tap → feed into wallace tree input
            );
        end
    endgenerate

    // ===== Wallace Tree: sums all 256 partial product rows =====
    wallace_tree_core wtc_inst (
        .clk(clk),
        .rst_n(rst_n),
        .i_all_rows(i_all_rows),
        .o_sum_vec(o_sum_vec),
        .o_carry_vec(o_carry_vec)
    );

    // ===== Final Adder: adds sum and carry vectors =====
    final_adder fa_inst (
        .i_sum_vec(o_sum_vec),
        .i_carry_vec(o_carry_vec),
        .o_result(o_result)
    );

    // ===== Rounding & Saturation: 36-bit → 16-bit output =====
    rounding_sat rs_inst (
        .i_data(o_result),
        .o_data(o_data)
    );

    // ===== Validity Pipeline: track data_valid through pipeline stages =====
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            valid_pipe <= '0;
        end else begin
            valid_pipe[0] <= i_valid;
            valid_pipe[1] <= valid_pipe[0];
            valid_pipe[2] <= valid_pipe[1];
        end
    end

    // ===== Output Handshake =====
    assign data_valid = valid_pipe[2];  // Output valid after pipeline delay
    assign o_valid = data_valid;
    assign o_ready = i_ready;

endmodule
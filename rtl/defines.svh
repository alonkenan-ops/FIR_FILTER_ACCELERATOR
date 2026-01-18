`ifndef DEFINES_SVH
`define DEFINES_SVH

// Constant Parameters
`define N_TAPS      16
`define IN_W        16
`define COEF_W      16
`define OUT_W       16
`define GUARD_BITS  4

// Calculated Parameters - automathic calc of accumelator width
`define ACC_W       (`IN_W + `COEF_W + `GUARD_BITS)


// --- Wallace Tree Helper Functions ---

/**
 * Full Adder (3:2 Compressor)
 * Inputs: 3 bits
 * Returns: {Carry, Sum}
 */
function automatic logic [1:0] fa(logic a, logic b, logic cin);
    logic s, cout;
    s    = a ^ b ^ cin;
    cout = (a & b) | (b & cin) | (a & cin);
    return {cout, s}; 
endfunction

/**
 * Half Adder (2:2 Compressor)
 * Inputs: 2 bits
 * Returns: {Carry, Sum}
 */
function automatic logic [1:0] ha(logic a, logic b);
    logic s, cout;
    s    = a ^ b;
    cout = a & b;
    return {cout, s};
endfunction

`endif // DEFINES_SVH
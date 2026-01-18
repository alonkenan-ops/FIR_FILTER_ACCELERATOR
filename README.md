FIR\_FILTER\_ACCELERATOR


specs:
1. Data Formats
    * 16-bit
    * signed 2's complmentry 
    * 1.Q 
2. Tap Count:
    * 16-bit
3. Filter Artibutes:
    * band pass filter inbitween 300 - 3000 Hz
    * Coefficient Set:
coeff[ 0] = 16'hffbf; // Decimal: -65
coeff[ 1] = 16'h0018; // Decimal: 24
coeff[ 2] = 16'h0146; // Decimal: 326
coeff[ 3] = 16'h042d; // Decimal: 1069
coeff[ 4] = 16'h0901; // Decimal: 2305
coeff[ 5] = 16'h0efc; // Decimal: 3836
coeff[ 6] = 16'h1485; // Decimal: 5253
coeff[ 7] = 16'h17dc; // Decimal: 6108
coeff[ 8] = 16'h17dc; // Decimal: 6108
coeff[ 9] = 16'h1485; // Decimal: 5253
coeff[10] = 16'h0efc; // Decimal: 3836
coeff[11] = 16'h0901; // Decimal: 2305
coeff[12] = 16'h042d; // Decimal: 1069
coeff[13] = 16'h0146; // Decimal: 326
coeff[14] = 16'h0018; // Decimal: 24
coeff[15] = 16'hffbf; // Decimal: -65
4. Rounding + Saturation
    * Truncation (drop LSBs).
    * Saturation: clamp to min/max of output width on overflow.
5. Latency
    * Total Latency: 4 clock cycles.
        * Architecture: 4-stage Pipeline:
        * Input Registering: Buffering input data and Shift Register update.
        * Multiplication: 16 parallel signed multipliers ($16 \times 16$).
        * Summation (Stage 1): Initial adder tree.
        * Output/Rounding: Final sum, scaling (shift), and output registration.
6. Flow Control
    * The module utilizes a Valid/Ready handshake protocol AXI-Stream compliant
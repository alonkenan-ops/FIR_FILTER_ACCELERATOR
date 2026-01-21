`timescale 1ns/1ps

module fir_tb();

    // 1. הגדרת סיגנלים המקבילים לפורטים של ה-Top
    logic        clk;
    logic        rst_n;
    logic [15:0] i_data;
    logic        i_valid;
    logic        o_ready;
    logic [15:0] o_data;
    logic        o_valid;
    logic        i_ready;

    // 2. יצירת שעון (Clock Generation)
    // מחזור שעון של 10ns (תדר של 100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 3. חיבור המודול הראשי (DUT - Device Under Test)
    // כאן אתה מוודא שכל השמות תואמים למה שכתבת ב-fir_top.sv
    fir_top dut (
        .clk     (clk),
        .rst_n   (rst_n),
        .i_data  (i_data),
        .i_valid (i_valid),
        .o_ready (o_ready),
        .o_data  (o_data),
        .o_valid (o_valid),
        .i_ready (i_ready)
    );

    // 4. תהליך הבדיקה המינימלי
    initial begin
        // אתחול סיגנלים
        rst_n   = 0;
        i_data  = 0;
        i_valid = 0;
        i_ready = 1; // אנחנו תמיד מוכנים לקבל תוצאות ב-TB הזה

        // שחרור Reset אחרי 20 ננו-שנייה
        #20 rst_n = 1;

        // כאן תוכל להוסיף בעתיד הזרקת נתונים
        #100;
        
        $display("Compilation and Initialization Successful!");
        $stop; // עוצר את הסימולציה
    end

endmodule

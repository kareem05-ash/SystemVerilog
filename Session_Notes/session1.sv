//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ******************** First Session Notes ********************
// *************************************************************
// --------------------------- Tasks ---------------------------
// - It can enable other tasks or functions
// - It may be executed in non-zero simularion time
// - It may contain delays, events, or timing control statements
// - It may have zero or more arguments of type (input, output, inout)
// - Default data type of arguments is logic
// - Default direction is input in case of not specified
// - It doesn't return with a value but can pass multiple values through output or inout arguments
// * ===== Task Declaration:
// task task_name(args); begin
//      task body
//      task body
// end
// endtask
// ------------------------ Functions -------------------------
// - It can enable other functions but not other tasks
// - It's executed only at 0 time simulation
// - It mustn't contain any delay, event, or timing control statement
// - It must have at least one input argument
// - It always returns a single value by assigning func_name with the intended return value
// - Default return type is logic
// - Default parameters deirection is input
// * ===== Function Declaration:
// function return_type func_name(args); begin
//      function body
//      function body
//      func_name = your_returned_value
// end
// endfunction
// -------------------------- Steps To Create Verification Plan -----------------------
// 1- Understand the desing specs
// 2- Identify test table features and corner cases
// 3- Define coverage goals
// 4- Plan testbench architecture and tools to be used
// ----------------------------------- Coverage ---------------------------------------
// ------------------------------------------------------------------------------------
// * Code Coverage:                 Measures how tests exercise the desing code
// * Functional Coverage:           Ensures that the desing meets the intended specs
// * Sequential Domain Coverage:    Uses SystemVerilog Assertions to test sequence behavior
// ----- Code Coverage -----
// Types::
//      1- Line Coverage:       Tracks which lines of code were executed
//      2- Condition Coverage:  Tracks if all conditions (e.g., if-else) were executed
//      3- FSM Coverage:        Tracks if all FSM states were visited
// Benifits::
//      1- Identifies untested parts of the desing
//      2- Helps improving testbench quality
// _____________________________________________________________________________________
// ------------------------------------ Strings In SystemVerilog ------------------------------------
// To declare any string, use 'string' key word; e.g., string my_str = "Kareem Ashraf";
//      - Concatenation:        str1 = "Hello"; str2 = "World"; result = str1 + ", " + str2;
//      - Concatenation:        str1 = {"Kareem", " Ashraf"};
//      - Compariso:            if(str1 == str2)    your_code;
//      - Substring Extraction: sub = str1.substr(0, 3);    // sub = Hel    // NOTE: Bounds are included
//      - UpperCase output:     my_str = "kareem".toupper();    // my_str => KAREEM
// ______________________________________________________________________________________
// ----------------------------------- 2-State Datatype ---------------------------------
// - Only supports 0 & 1 values not like 4-state datatypes(0, 1, x, & z)
// - Advantages:
//      1. Faster simulation adn less memory usage compared to 4-state datatype
//      2. Easier to interface with C/C++ functions, making them suitable for gate-level models
// - bit is unsigned
// - byte, shortint, int, and longint are signed
// - Initial values are 0
// - x & z values are resolved to 0
// Examples for 2-state datatypes:
//      1. bit      -> 1-bit (packed array)
//      2. byte     -> 8-bit (character)
//      3. shortint -> 16-bit
//      4. int      -> 32-bit
// Examples for 4-state datatypes:
//      1. logic    -> 1-bit (packed array)
//      2. integer  -> 32-bit
//      3. time     -> 64-bit (unsigned)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Example for tasks
module task_ex;
    logic z;
    task AND2_1(input logic in1, in2, output logic out); begin
        out = in1 & in2;    // 2 input AND Gate
    end
    endtask
    initial begin
        AND2_1(1, 0, z);
        $display("The Value of z: %d. Expected: %d", z, 1'd0);
    end
endmodule

// Example for functions
module func_ex;
    function logic AND2_1(input logic in1, in2);begin
        AND2_1 = in1 & in2;     // 2 input AND Gate
    end
    endfunction
    initial begin
        logic out = AND2_1(1, 0);
        $display("The Vlue of out: %d. Expected Value: %d", out, 1'd0);
    end
endmodule

// Example on strings & 2-state datatypes vs. 4-state datatypes
string str1 = "Verification";
string str2 = "SystemVerilog";
string str3 = str1 + " " + str2;                // str3 = "Verification SystemVerilog"
int str_length = str3.len();                    // 25D
bit found = (str3.substr(0, 5) == "Verif")      // found = 0
// str3.substr(0, 5) returns: "Verifi" not "Verif"
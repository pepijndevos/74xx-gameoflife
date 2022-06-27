`timescale 1ns / 1ps

(* top =  1  *)
module gameoflife_tb ();
  reg [8:0] inputs;
  wire out;
  gameoflife dut (
    .i0(inputs[0]),
    .i1(inputs[1]),
    .i2(inputs[2]),
    .i3(inputs[3]),
    .i4(inputs[4]),
    .i5(inputs[5]),
    .i6(inputs[6]),
    .i7(inputs[7]),
    .mid(inputs[8]),
    .alive(out)
  );
 
  integer i;
  integer popcnt;
  initial begin
    $dumpfile("gameoflife.vcd");
    $dumpvars(0,gameoflife_tb);
    inputs = 9'b0;
    for (i=0; i<512; i=i+1) begin
        inputs = i;
        popcnt = inputs[0]+inputs[1]+inputs[2]+inputs[3]+inputs[4]+inputs[5]+inputs[6]+inputs[7];
        #1;
        if ((popcnt == 3 && out == 0) ||
            (popcnt == 2 && inputs[8] && out == 0) ||
            (popcnt >  3 && out) ||
            (popcnt <  2 && out))
        begin
            $display("ASSERTION FAILED in %m");
            $finish;
        end
    end
  end
endmodule
module CombAssume(
    input  cond
);
always @* begin
    assume(cond);
end
endmodule
    
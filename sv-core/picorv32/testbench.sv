module testbench (
        input clock,
        input reset
    );

    (* keep *) wire         commit_valid;
    (* keep *) wire         commit_excp;
    (* keep *) wire  [31:0] commit_inst;
    (* keep *) wire  [31:0] commit_pc;
    (* keep *) wire  [31:0] commit_npc;

    (* keep *) wire  [4:0]  writeback_rs1Addr;
    (* keep *) wire  [4:0]  writeback_rs2Addr;
    (* keep *) wire  [31:0] writeback_rs1Data;
    (* keep *) wire  [31:0] writeback_rs2Data;
    (* keep *) wire  [4:0]  writeback_rdAddr;
    (* keep *) wire  [31:0] writeback_rdData;
    (* keep *) wire         writeback_csrWr;
    (* keep *) wire  [11:0] writeback_csrAddr;
    (* keep *) wire  [63:0] writeback_csrNdata;

    (* keep *) wire         mem_read_valid;
    (* keep *) wire  [31:0] mem_read_addr;
    (* keep *) wire  [5:0]  mem_read_memWidth;
    (* keep *) wire  [31:0] mem_read_data;
    (* keep *) wire         mem_write_valid;
    (* keep *) wire  [31:0] mem_write_addr;
    (* keep *) wire  [5:0]  mem_write_memWidth;
    (* keep *) wire  [31:0] mem_write_data;

    wrapper dut (
                .clock(clock),
                .reset(reset),

                .commit_valid(commit_valid),
                .commit_excp(commit_excp),
                .commit_inst(commit_inst),
                .commit_pc(commit_pc),
                .commit_npc(commit_npc),

                .writeback_rs1Addr(writeback_rs1Addr),
                .writeback_rs2Addr(writeback_rs2Addr),
                .writeback_rs1Data(writeback_rs1Data),
                .writeback_rs2Data(writeback_rs2Data),
                .writeback_rdAddr(writeback_rdAddr),
                .writeback_rdData(writeback_rdData),
                .writeback_csrWr(writeback_csrWr),
                .writeback_csrAddr(writeback_csrAddr),
                .writeback_csrNdata(writeback_csrNdata),

                .mem_read_valid(mem_read_valid),
                .mem_read_addr(mem_read_addr),
                .mem_read_memWidth(mem_read_memWidth),
                .mem_read_data(mem_read_data),
                .mem_write_valid(mem_write_valid),
                .mem_write_addr(mem_write_addr),
                .mem_write_memWidth(mem_write_memWidth),
                .mem_write_data(mem_write_data)
            );

    WriteBackChecker spec (
                         .clock(clock),
                         .reset(reset),

                         .commit_valid(commit_valid),
                         .commit_excp(commit_excp),
                         .commit_inst(commit_inst),
                         .commit_pc(commit_pc),
                         .commit_npc(commit_npc),

                         .writeback_rs1Addr(writeback_rs1Addr),
                         .writeback_rs2Addr(writeback_rs2Addr),
                         .writeback_rs1Data(writeback_rs1Data),
                         .writeback_rs2Data(writeback_rs2Data),
                         .writeback_rdAddr(writeback_rdAddr),
                         .writeback_rdData(writeback_rdData),
                         .writeback_csrWr(writeback_csrWr),
                         .writeback_csrAddr(writeback_csrAddr),
                         .writeback_csrNdata(writeback_csrNdata),

                         .mem_read_valid(mem_read_valid),
                         .mem_read_addr(mem_read_addr),
                         .mem_read_memWidth(mem_read_memWidth),
                         .mem_read_data(mem_read_data),
                         .mem_write_valid(mem_write_valid),
                         .mem_write_addr(mem_write_addr),
                         .mem_write_memWidth(mem_write_memWidth),
                         .mem_write_data(mem_write_data)
                     );

`ifdef YOSYS

    always_comb assume (reset == $initstate);
`endif

    InstAssume instAssume (
                   .valid(commit_valid),
                   .inst(commit_inst)
               );

    reg [7:0] cycle_reg = 0;
    wire [7:0] cycle = reset ? 8'd 0 : cycle_reg;

    always @(posedge clock) begin
        cycle_reg <= reset ? 8'd 1 : cycle_reg + (cycle_reg != 8'h ff);
    end

    wire check = (cycle == `RISCV_FORMAL_CHECK_CYCLE);

    always @* begin
        if (!reset && check) begin
            assume(commit_valid);
        end
    end


endmodule

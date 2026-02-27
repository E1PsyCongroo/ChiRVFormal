module testbench (
        input clock,
        input reset
    );

`ifdef YOSYS

    always_comb assume (reset == $initstate);
`endif

    (* keep *) wire trap;

`ifdef YOSYS

    (* keep *) rand reg mem_ready;
    (* keep *) rand reg [31:0] mem_rdata;
`else
    (* keep *) wire mem_ready;
    (* keep *) wire [31:0] mem_rdata;
`endif

    (* keep *) wire        mem_valid;
    (* keep *) wire        mem_instr;
    (* keep *) wire [31:0] mem_addr;
    (* keep *) wire [31:0] mem_wdata;
    (* keep *) wire [3:0]  mem_wstrb;

    (* keep *) wire        rvfi_valid;
    (* keep *) wire [63:0] rvfi_order;
    (* keep *) wire [31:0] rvfi_insn;
    (* keep *) wire        rvfi_trap;
    (* keep *) wire        rvfi_halt;
    (* keep *) wire        rvfi_intr;
    (* keep *) wire [ 1:0] rvfi_mode;
    (* keep *) wire [ 1:0] rvfi_ixl;
    (* keep *) wire [ 4:0] rvfi_rs1_addr;
    (* keep *) wire [ 4:0] rvfi_rs2_addr;
    (* keep *) wire [31:0] rvfi_rs1_rdata;
    (* keep *) wire [31:0] rvfi_rs2_rdata;
    (* keep *) wire [ 4:0] rvfi_rd_addr;
    (* keep *) wire [31:0] rvfi_rd_wdata;
    (* keep *) wire [31:0] rvfi_pc_rdata;
    (* keep *) wire [31:0] rvfi_pc_wdata;
    (* keep *) wire [31:0] rvfi_mem_addr;
    (* keep *) wire [ 3:0] rvfi_mem_rmask;
    (* keep *) wire [ 3:0] rvfi_mem_wmask;
    (* keep *) wire [31:0] rvfi_mem_rdata;
    (* keep *) wire [31:0] rvfi_mem_wdata;
    (* keep *) wire [63:0] rvfi_csr_mcycle_rmask;
    (* keep *) wire [63:0] rvfi_csr_mcycle_wmask;
    (* keep *) wire [63:0] rvfi_csr_mcycle_rdata;
    (* keep *) wire [63:0] rvfi_csr_mcycle_wdata;
    (* keep *) wire [63:0] rvfi_csr_minstret_rmask;
    (* keep *) wire [63:0] rvfi_csr_minstret_wmask;
    (* keep *) wire [63:0] rvfi_csr_minstret_rdata;
    (* keep *) wire [63:0] rvfi_csr_minstret_wdata;

    picorv32 #(  .ENABLE_REGS_DUALPORT(1),
                 .BARREL_SHIFTER(1),
                 .COMPRESSED_ISA(1),
                 .ENABLE_FAST_MUL(1),
                 .ENABLE_DIV(1),
                 .REGS_INIT_ZERO(1),
                 .PROGADDR_RESET(32'h8000_0000)
              ) uut (
                 .clk       (clock    ),
                 .resetn    (!reset   ),
                 .trap      (trap     ),

                 .mem_valid (mem_valid),
                 .mem_instr (mem_instr),
                 .mem_ready (mem_ready),
                 .mem_addr  (mem_addr ),
                 .mem_wdata (mem_wdata),
                 .mem_wstrb (mem_wstrb),
                 .mem_rdata (mem_rdata),

                 .rvfi_valid     (rvfi_valid    ),
                 .rvfi_order     (rvfi_order    ),
                 .rvfi_insn      (rvfi_insn     ),
                 .rvfi_trap      (rvfi_trap     ),
                 .rvfi_halt      (rvfi_halt     ),
                 .rvfi_intr      (rvfi_intr     ),
                 .rvfi_mode      (rvfi_mode     ),
                 .rvfi_ixl       (rvfi_ixl      ),
                 .rvfi_rs1_addr  (rvfi_rs1_addr ),
                 .rvfi_rs2_addr  (rvfi_rs2_addr ),
                 .rvfi_rs1_rdata (rvfi_rs1_rdata),
                 .rvfi_rs2_rdata (rvfi_rs2_rdata),
                 .rvfi_rd_addr   (rvfi_rd_addr  ),
                 .rvfi_rd_wdata  (rvfi_rd_wdata ),
                 .rvfi_pc_rdata  (rvfi_pc_rdata ),
                 .rvfi_pc_wdata  (rvfi_pc_wdata ),
                 .rvfi_mem_addr  (rvfi_mem_addr ),
                 .rvfi_mem_rmask (rvfi_mem_rmask),
                 .rvfi_mem_wmask (rvfi_mem_wmask),
                 .rvfi_mem_rdata (rvfi_mem_rdata),
                 .rvfi_mem_wdata (rvfi_mem_wdata),
                 .rvfi_csr_mcycle_rmask(rvfi_csr_mcycle_rmask),
                 .rvfi_csr_mcycle_wmask(rvfi_csr_mcycle_rmask),
                 .rvfi_csr_mcycle_rdata(rvfi_csr_mcycle_rmask),
                 .rvfi_csr_mcycle_wdata(rvfi_csr_mcycle_rmask),
                 .rvfi_csr_minstret_rmask(rvfi_csr_mcycle_rmask),
                 .rvfi_csr_minstret_wmask(rvfi_csr_mcycle_rmask),
                 .rvfi_csr_minstret_rdata(rvfi_csr_mcycle_rmask),
                 .rvfi_csr_minstret_wdata(rvfi_csr_mcycle_rmask)
             );

    wire [5:0] mem_read_width = 6'd32;
    reg [5:0] mem_write_width;

    always @* begin
        case (rvfi_mem_wmask)
            4'b0001, 4'b0010, 4'b0100, 4'b1000: mem_write_width = 6'd8;
            4'b0011, 4'b1100: mem_write_width = 6'd16;
            default: mem_write_width = 6'd32;
        endcase
    end

    WriteBackChecker spec (
                      .clock(clock),
                      .reset(reset),
                      .commit_valid(rvfi_valid),
                      .commit_inst(rvfi_insn),
                      .commit_pc(rvfi_pc_rdata),
                      .commit_npc(rvfi_pc_wdata),

                      .writeback_valid(rvfi_rd_addr != 0),
                      .writeback_dest(rvfi_rd_addr),
                      .writeback_data(rvfi_rd_wdata),
                      .writeback_r1Addr(rvfi_rs1_addr),
                      .writeback_r2Addr(rvfi_rs2_addr),
                      .writeback_r1Data(rvfi_rs1_rdata),
                      .writeback_r2Data(rvfi_rs2_rdata),
                      .writeback_csrAddr('b0),
                      .writeback_csrNdata('b0),
                      .writeback_csrWr('b0),

                      .mem_read_valid(rvfi_valid && |rvfi_mem_rmask),
                      .mem_read_addr(rvfi_mem_addr),
                      .mem_read_memWidth(mem_read_width),
                      .mem_read_data(rvfi_mem_rdata),
                      .mem_write_valid(rvfi_valid && |rvfi_mem_wmask),
                      .mem_write_addr(rvfi_mem_addr),
                      .mem_write_memWidth(mem_write_width),
                      .mem_write_data(rvfi_mem_wdata)
                  );

    InstAssume instAssume (
        .valid(rvfi_valid),
        .inst(rvfi_insn)
    );

    always @* begin
        if (rvfi_valid) begin
            assume(rvfi_trap == 0 && rvfi_intr == 0 && rvfi_halt == 0);
        end
    end

endmodule

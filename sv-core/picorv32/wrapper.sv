module wrapper (
    input clock,
    input reset,

    output        commit_valid,
    output        commit_excp,
    output [31:0] commit_inst,
    output [31:0] commit_pc,
    output [31:0] commit_npc,

    output [ 4:0] writeback_rs1Addr,
    output [ 4:0] writeback_rs2Addr,
    output [31:0] writeback_rs1Data,
    output [31:0] writeback_rs2Data,
    output [ 4:0] writeback_rdAddr,
    output [31:0] writeback_rdData,
    output        writeback_csrWr,
    output [11:0] writeback_csrAddr,
    output [63:0] writeback_csrNdata,

    output        mem_read_valid,
    output [31:0] mem_read_addr,
    output [ 5:0] mem_read_memWidth,
    output [31:0] mem_read_data,
    output        mem_write_valid,
    output [31:0] mem_write_addr,
    output [ 5:0] mem_write_memWidth,
    output [31:0] mem_write_data
);

  (* keep *)wire        trap;

  (* keep *)rand reg mem_ready;
  (* keep *)rand reg [31:0] mem_rdata;

  (* keep *)wire        mem_valid;
  (* keep *)wire        mem_instr;
  (* keep *)wire [31:0] mem_addr;
  (* keep *)wire [31:0] mem_wdata;
  (* keep *)wire [ 3:0] mem_wstrb;

  (* keep *)rand reg [31:0] irq;

  (* keep *)wire        rvfi_valid;
  (* keep *)wire [63:0] rvfi_order;
  (* keep *)wire [31:0] rvfi_insn;
  (* keep *)wire        rvfi_trap;
  (* keep *)wire        rvfi_halt;
  (* keep *)wire        rvfi_intr;
  (* keep *)wire [ 1:0] rvfi_mode;
  (* keep *)wire [ 1:0] rvfi_ixl;
  (* keep *)wire [ 4:0] rvfi_rs1_addr;
  (* keep *)wire [ 4:0] rvfi_rs2_addr;
  (* keep *)wire [31:0] rvfi_rs1_rdata;
  (* keep *)wire [31:0] rvfi_rs2_rdata;
  (* keep *)wire [ 4:0] rvfi_rd_addr;
  (* keep *)wire [31:0] rvfi_rd_wdata;
  (* keep *)wire [31:0] rvfi_pc_rdata;
  (* keep *)wire [31:0] rvfi_pc_wdata;
  (* keep *)wire [31:0] rvfi_mem_addr;
  (* keep *)wire [ 3:0] rvfi_mem_rmask;
  (* keep *)wire [ 3:0] rvfi_mem_wmask;
  (* keep *)wire [31:0] rvfi_mem_rdata;
  (* keep *)wire [31:0] rvfi_mem_wdata;
	(* keep *)wire [31:0] rvfi_mem_read_addr;
	(* keep *)wire [ 5:0] rvfi_mem_read_width;
	(* keep *)wire [31:0] rvfi_mem_write_addr;
	(* keep *)wire [ 5:0] rvfi_mem_write_width;
  (* keep *)wire [63:0] rvfi_csr_mcycle_rmask;
  (* keep *)wire [63:0] rvfi_csr_mcycle_wmask;
  (* keep *)wire [63:0] rvfi_csr_mcycle_rdata;
  (* keep *)wire [63:0] rvfi_csr_mcycle_wdata;
  (* keep *)wire [63:0] rvfi_csr_minstret_rmask;
  (* keep *)wire [63:0] rvfi_csr_minstret_wmask;
  (* keep *)wire [63:0] rvfi_csr_minstret_rdata;
  (* keep *)wire [63:0] rvfi_csr_minstret_wdata;

  picorv32 #(
      .ENABLE_REGS_DUALPORT(1),
      .BARREL_SHIFTER(1),
      .COMPRESSED_ISA(1),
      .CATCH_MISALIGN(1),
      .CATCH_ILLINSN(1),
      .ENABLE_FAST_MUL(1),
      .ENABLE_DIV(1),
`ifdef PICORV32_TESTTRAP
      .ENABLE_IRQ(1),
`endif
      .ENABLE_IRQ_TIMER(0),
      .REGS_INIT_ZERO(1),
      .PROGADDR_RESET(32'h8000_0000),
      .PROGADDR_IRQ(32'h8000_8000)
  ) uut (
      .clk   (clock),
      .resetn(!reset),
      .trap  (trap),

      .mem_valid(mem_valid),
      .mem_instr(mem_instr),
      .mem_ready(mem_ready),
      .mem_addr (mem_addr),
      .mem_wdata(mem_wdata),
      .mem_wstrb(mem_wstrb),
      .mem_rdata(mem_rdata),

      .irq(32'b0),

      .rvfi_valid(rvfi_valid),
      .rvfi_order(rvfi_order),
      .rvfi_insn (rvfi_insn),
      .rvfi_trap (rvfi_trap),
      .rvfi_halt (rvfi_halt),
      .rvfi_intr (rvfi_intr),
      .rvfi_mode (rvfi_mode),
      .rvfi_ixl  (rvfi_ixl),

      .rvfi_rs1_addr (rvfi_rs1_addr),
      .rvfi_rs2_addr (rvfi_rs2_addr),
      .rvfi_rs1_rdata(rvfi_rs1_rdata),
      .rvfi_rs2_rdata(rvfi_rs2_rdata),
      .rvfi_rd_addr  (rvfi_rd_addr),
      .rvfi_rd_wdata (rvfi_rd_wdata),

      .rvfi_pc_rdata(rvfi_pc_rdata),
      .rvfi_pc_wdata(rvfi_pc_wdata),

      .rvfi_mem_addr (rvfi_mem_addr),
      .rvfi_mem_rmask(rvfi_mem_rmask),
      .rvfi_mem_wmask(rvfi_mem_wmask),
      .rvfi_mem_rdata(rvfi_mem_rdata),
      .rvfi_mem_wdata(rvfi_mem_wdata),

	    .rvfi_mem_read_addr(rvfi_mem_read_addr),
	    .rvfi_mem_read_width(rvfi_mem_read_width),
	    .rvfi_mem_write_addr(rvfi_mem_write_addr),
	    .rvfi_mem_write_width(rvfi_mem_write_width),


      .rvfi_csr_mcycle_rmask  (rvfi_csr_mcycle_rmask),
      .rvfi_csr_mcycle_wmask  (rvfi_csr_mcycle_wmask),
      .rvfi_csr_mcycle_rdata  (rvfi_csr_mcycle_rdata),
      .rvfi_csr_mcycle_wdata  (rvfi_csr_mcycle_wdata),
      .rvfi_csr_minstret_rmask(rvfi_csr_minstret_rmask),
      .rvfi_csr_minstret_wmask(rvfi_csr_minstret_wmask),
      .rvfi_csr_minstret_rdata(rvfi_csr_minstret_rdata),
      .rvfi_csr_minstret_wdata(rvfi_csr_minstret_wdata)
  );

  assign commit_valid = rvfi_valid;
  assign commit_excp = rvfi_trap;
  assign commit_inst = rvfi_insn;
  assign commit_pc = rvfi_pc_rdata;
  assign commit_npc = rvfi_pc_wdata;

  assign writeback_rs1Addr = rvfi_rs1_addr;
  assign writeback_rs2Addr = rvfi_rs2_addr;
  assign writeback_rs1Data = rvfi_rs1_rdata;
  assign writeback_rs2Data = rvfi_rs2_rdata;
  assign writeback_rdAddr = rvfi_rd_addr;
  assign writeback_rdData = rvfi_rd_wdata;
  assign writeback_csrWr = 'b0;
  assign writeback_csrAddr = 'b0;
  assign writeback_csrNdata = 'b0;

  assign mem_read_valid = (rvfi_valid && |rvfi_mem_rmask);
  assign mem_read_memWidth = rvfi_mem_read_width;
  assign mem_read_addr = rvfi_mem_read_addr;
  assign mem_read_data = rvfi_mem_rdata;

  assign mem_write_valid = (rvfi_valid && |rvfi_mem_wmask);
  assign mem_write_memWidth = rvfi_mem_write_width;
  assign mem_write_addr = rvfi_mem_write_addr;
  assign mem_write_data = rvfi_mem_wdata >> (rvfi_mem_write_addr[1:0] * 8);

  always @* begin
    if (!reset && rvfi_valid) begin
      assume (!rvfi_halt);
`ifndef PICORV32_TESTTRAP
      assume (!rvfi_trap);
`endif

    end
  end

`ifdef PICORV32_FAIRNESS
  reg [2:0] mem_wait = 0;
  always @(posedge clock) begin
    mem_wait <= {mem_wait, mem_valid && !mem_ready};
    assume (~mem_wait || trap);
  end
`endif

endmodule

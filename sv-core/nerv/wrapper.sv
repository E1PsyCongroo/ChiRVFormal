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
    output [31:0] mem_write_data,

    output [ 1:0] mode,
    output [31:0] csr_mvendorid,
    output [31:0] csr_marchid,
    output [31:0] csr_mimpid,
    output [31:0] csr_mhartid,
    output [31:0] csr_mconfigptr,
    output [31:0] csr_mstatus,
    output [31:0] csr_misa,
    output [31:0] csr_mie,
    output [31:0] csr_mtvec,
    output [31:0] csr_mstatush,
    output [31:0] csr_mscratch,
    output [31:0] csr_mepc,
    output [31:0] csr_mcause,
    output [31:0] csr_mip,
    output [31:0] csr_mtval,
    output [31:0] csr_mseccfg,
    output [31:0] csr_mseccfgh,
    output [31:0] csr_pmpcfg0,
    output [31:0] csr_pmpcfg1,
    output [31:0] csr_pmpcfg2,
    output [31:0] csr_pmpcfg3,
    output [31:0] csr_pmpcfg4,
    output [31:0] csr_pmpcfg5,
    output [31:0] csr_pmpcfg6,
    output [31:0] csr_pmpcfg7,
    output [31:0] csr_pmpcfg8,
    output [31:0] csr_pmpcfg9,
    output [31:0] csr_pmpcfg10,
    output [31:0] csr_pmpcfg11,
    output [31:0] csr_pmpcfg12,
    output [31:0] csr_pmpcfg13,
    output [31:0] csr_pmpcfg14,
    output [31:0] csr_pmpcfg15,
    output [31:0] csr_pmpaddr0,
    output [31:0] csr_pmpaddr1,
    output [31:0] csr_pmpaddr2,
    output [31:0] csr_pmpaddr3,
    output [31:0] csr_pmpaddr4,
    output [31:0] csr_pmpaddr5,
    output [31:0] csr_pmpaddr6,
    output [31:0] csr_pmpaddr7,
    output [31:0] csr_pmpaddr8,
    output [31:0] csr_pmpaddr9,
    output [31:0] csr_pmpaddr10,
    output [31:0] csr_pmpaddr11,
    output [31:0] csr_pmpaddr12,
    output [31:0] csr_pmpaddr13,
    output [31:0] csr_pmpaddr14,
    output [31:0] csr_pmpaddr15,
    output [31:0] csr_pmpaddr16,
    output [31:0] csr_pmpaddr17,
    output [31:0] csr_pmpaddr18,
    output [31:0] csr_pmpaddr19,
    output [31:0] csr_pmpaddr20,
    output [31:0] csr_pmpaddr21,
    output [31:0] csr_pmpaddr22,
    output [31:0] csr_pmpaddr23,
    output [31:0] csr_pmpaddr24,
    output [31:0] csr_pmpaddr25,
    output [31:0] csr_pmpaddr26,
    output [31:0] csr_pmpaddr27,
    output [31:0] csr_pmpaddr28,
    output [31:0] csr_pmpaddr29,
    output [31:0] csr_pmpaddr30,
    output [31:0] csr_pmpaddr31,
    output [31:0] csr_pmpaddr32,
    output [31:0] csr_pmpaddr33,
    output [31:0] csr_pmpaddr34,
    output [31:0] csr_pmpaddr35,
    output [31:0] csr_pmpaddr36,
    output [31:0] csr_pmpaddr37,
    output [31:0] csr_pmpaddr38,
    output [31:0] csr_pmpaddr39,
    output [31:0] csr_pmpaddr40,
    output [31:0] csr_pmpaddr41,
    output [31:0] csr_pmpaddr42,
    output [31:0] csr_pmpaddr43,
    output [31:0] csr_pmpaddr44,
    output [31:0] csr_pmpaddr45,
    output [31:0] csr_pmpaddr46,
    output [31:0] csr_pmpaddr47,
    output [31:0] csr_pmpaddr48,
    output [31:0] csr_pmpaddr49,
    output [31:0] csr_pmpaddr50,
    output [31:0] csr_pmpaddr51,
    output [31:0] csr_pmpaddr52,
    output [31:0] csr_pmpaddr53,
    output [31:0] csr_pmpaddr54,
    output [31:0] csr_pmpaddr55,
    output [31:0] csr_pmpaddr56,
    output [31:0] csr_pmpaddr57,
    output [31:0] csr_pmpaddr58,
    output [31:0] csr_pmpaddr59,
    output [31:0] csr_pmpaddr60,
    output [31:0] csr_pmpaddr61,
    output [31:0] csr_pmpaddr62,
    output [31:0] csr_pmpaddr63,
    output [31:0] csr_mcycle,
    output [31:0] csr_minstret,
    output [31:0] csr_mhpmcounter3,
    output [31:0] csr_mhpmcounter4,
    output [31:0] csr_mhpmcounter5,
    output [31:0] csr_mhpmcounter6,
    output [31:0] csr_mhpmcounter7,
    output [31:0] csr_mhpmcounter8,
    output [31:0] csr_mhpmcounter9,
    output [31:0] csr_mhpmcounter10,
    output [31:0] csr_mhpmcounter11,
    output [31:0] csr_mhpmcounter12,
    output [31:0] csr_mhpmcounter13,
    output [31:0] csr_mhpmcounter14,
    output [31:0] csr_mhpmcounter15,
    output [31:0] csr_mhpmcounter16,
    output [31:0] csr_mhpmcounter17,
    output [31:0] csr_mhpmcounter18,
    output [31:0] csr_mhpmcounter19,
    output [31:0] csr_mhpmcounter20,
    output [31:0] csr_mhpmcounter21,
    output [31:0] csr_mhpmcounter22,
    output [31:0] csr_mhpmcounter23,
    output [31:0] csr_mhpmcounter24,
    output [31:0] csr_mhpmcounter25,
    output [31:0] csr_mhpmcounter26,
    output [31:0] csr_mhpmcounter27,
    output [31:0] csr_mhpmcounter28,
    output [31:0] csr_mhpmcounter29,
    output [31:0] csr_mhpmcounter30,
    output [31:0] csr_mhpmcounter31,
    output [31:0] csr_mcycleh,
    output [31:0] csr_minstreth,
    output [31:0] csr_mhpmcounter3h,
    output [31:0] csr_mhpmcounter4h,
    output [31:0] csr_mhpmcounter5h,
    output [31:0] csr_mhpmcounter6h,
    output [31:0] csr_mhpmcounter7h,
    output [31:0] csr_mhpmcounter8h,
    output [31:0] csr_mhpmcounter9h,
    output [31:0] csr_mhpmcounter10h,
    output [31:0] csr_mhpmcounter11h,
    output [31:0] csr_mhpmcounter12h,
    output [31:0] csr_mhpmcounter13h,
    output [31:0] csr_mhpmcounter14h,
    output [31:0] csr_mhpmcounter15h,
    output [31:0] csr_mhpmcounter16h,
    output [31:0] csr_mhpmcounter17h,
    output [31:0] csr_mhpmcounter18h,
    output [31:0] csr_mhpmcounter19h,
    output [31:0] csr_mhpmcounter20h,
    output [31:0] csr_mhpmcounter21h,
    output [31:0] csr_mhpmcounter22h,
    output [31:0] csr_mhpmcounter23h,
    output [31:0] csr_mhpmcounter24h,
    output [31:0] csr_mhpmcounter25h,
    output [31:0] csr_mhpmcounter26h,
    output [31:0] csr_mhpmcounter27h,
    output [31:0] csr_mhpmcounter28h,
    output [31:0] csr_mhpmcounter29h,
    output [31:0] csr_mhpmcounter30h,
    output [31:0] csr_mhpmcounter31h,
    output [31:0] csr_mcountinhibit,
    output [31:0] csr_mhpmevent3,
    output [31:0] csr_mhpmevent4,
    output [31:0] csr_mhpmevent5,
    output [31:0] csr_mhpmevent6,
    output [31:0] csr_mhpmevent7,
    output [31:0] csr_mhpmevent8,
    output [31:0] csr_mhpmevent9,
    output [31:0] csr_mhpmevent10,
    output [31:0] csr_mhpmevent11,
    output [31:0] csr_mhpmevent12,
    output [31:0] csr_mhpmevent13,
    output [31:0] csr_mhpmevent14,
    output [31:0] csr_mhpmevent15,
    output [31:0] csr_mhpmevent16,
    output [31:0] csr_mhpmevent17,
    output [31:0] csr_mhpmevent18,
    output [31:0] csr_mhpmevent19,
    output [31:0] csr_mhpmevent20,
    output [31:0] csr_mhpmevent21,
    output [31:0] csr_mhpmevent22,
    output [31:0] csr_mhpmevent23,
    output [31:0] csr_mhpmevent24,
    output [31:0] csr_mhpmevent25,
    output [31:0] csr_mhpmevent26,
    output [31:0] csr_mhpmevent27,
    output [31:0] csr_mhpmevent28,
    output [31:0] csr_mhpmevent29,
    output [31:0] csr_mhpmevent30,
    output [31:0] csr_mhpmevent31,
    output [31:0] csr_mhpmevent3h,
    output [31:0] csr_mhpmevent4h,
    output [31:0] csr_mhpmevent5h,
    output [31:0] csr_mhpmevent6h,
    output [31:0] csr_mhpmevent7h,
    output [31:0] csr_mhpmevent8h,
    output [31:0] csr_mhpmevent9h,
    output [31:0] csr_mhpmevent10h,
    output [31:0] csr_mhpmevent11h,
    output [31:0] csr_mhpmevent12h,
    output [31:0] csr_mhpmevent13h,
    output [31:0] csr_mhpmevent14h,
    output [31:0] csr_mhpmevent15h,
    output [31:0] csr_mhpmevent16h,
    output [31:0] csr_mhpmevent17h,
    output [31:0] csr_mhpmevent18h,
    output [31:0] csr_mhpmevent19h,
    output [31:0] csr_mhpmevent20h,
    output [31:0] csr_mhpmevent21h,
    output [31:0] csr_mhpmevent22h,
    output [31:0] csr_mhpmevent23h,
    output [31:0] csr_mhpmevent24h,
    output [31:0] csr_mhpmevent25h,
    output [31:0] csr_mhpmevent26h,
    output [31:0] csr_mhpmevent27h,
    output [31:0] csr_mhpmevent28h,
    output [31:0] csr_mhpmevent29h,
    output [31:0] csr_mhpmevent30h,
    output [31:0] csr_mhpmevent31h
);

  (* keep *)rand reg stall;
  (* keep *)rand reg [31:0] imem_data;
  (* keep *)rand reg [31:0] dmem_rdata;
  (* keep *)rand reg [31:0] irq;

`ifdef NERV_FAULT
  (* keep *)rand reg imem_fault;
  (* keep *)rand reg dmem_fault;
`else
  wire imem_fault = 0;
  wire dmem_fault = 0;
`endif

  (* keep *)wire        trap;

  (* keep *)wire [31:0] imem_addr;

  (* keep *)wire        dmem_valid;
  (* keep *)wire [31:0] dmem_addr;
  (* keep *)wire [ 3:0] dmem_wstrb;
  (* keep *)wire [31:0] dmem_wdata;

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

  (* keep *)wire [31:0] rvfi_csr_mvendorid_rdata;
  (* keep *)wire [31:0] rvfi_csr_marchid_rdata;
  (* keep *)wire [31:0] rvfi_csr_mimpid_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhartid_rdata;
  (* keep *)wire [31:0] rvfi_csr_mconfigptr_rdata;

  (* keep *)wire [31:0] rvfi_csr_mstatus_rdata;
  (* keep *)wire [31:0] rvfi_csr_misa_rdata;
  (* keep *)wire [31:0] rvfi_csr_mie_rdata;
  (* keep *)wire [31:0] rvfi_csr_mtvec_rdata;
  (* keep *)wire [31:0] rvfi_csr_mstatush_rdata;

  (* keep *)wire [31:0] rvfi_csr_mscratch_rdata;
  (* keep *)wire [31:0] rvfi_csr_mepc_rdata;
  (* keep *)wire [31:0] rvfi_csr_mcause_rdata;
  (* keep *)wire [31:0] rvfi_csr_mtval_rdata;
  (* keep *)wire [31:0] rvfi_csr_mip_rdata;

  (* keep *)wire [31:0] rvfi_csr_pmpcfg0_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg1_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg2_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg3_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg4_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg5_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg6_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg7_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg8_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg9_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg10_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg11_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg12_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg13_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg14_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpcfg15_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr0_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr1_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr2_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr3_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr4_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr5_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr6_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr7_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr8_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr9_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr10_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr11_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr12_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr13_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr14_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr15_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr16_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr17_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr18_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr19_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr20_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr21_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr22_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr23_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr24_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr25_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr26_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr27_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr28_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr29_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr30_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr31_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr32_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr33_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr34_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr35_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr36_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr37_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr38_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr39_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr40_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr41_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr42_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr43_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr44_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr45_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr46_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr47_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr48_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr49_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr50_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr51_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr52_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr53_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr54_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr55_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr56_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr57_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr58_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr59_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr60_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr61_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr62_rdata;
  (* keep *)wire [31:0] rvfi_csr_pmpaddr63_rdata;

  (* keep *)wire [31:0] rvfi_csr_mcycle_rdata;
  (* keep *)wire [31:0] rvfi_csr_minstret_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter3_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter4_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter5_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter6_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter7_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter8_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter9_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter10_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter11_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter12_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter13_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter14_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter15_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter16_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter17_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter18_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter19_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter20_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter21_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter22_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter23_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter24_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter25_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter26_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter27_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter28_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter29_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter30_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter31_rdata;
  (* keep *)wire [31:0] rvfi_csr_mcycleh_rdata;
  (* keep *)wire [31:0] rvfi_csr_minstreth_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter3h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter4h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter5h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter6h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter7h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter8h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter9h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter10h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter11h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter12h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter13h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter14h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter15h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter16h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter17h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter18h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter19h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter20h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter21h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter22h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter23h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter24h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter25h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter26h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter27h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter28h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter29h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter30h_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmcounter31h_rdata;

  (* keep *)wire [31:0] rvfi_csr_mhpmevent3_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent4_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent5_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent6_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent7_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent8_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent9_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent10_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent11_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent12_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent13_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent14_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent15_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent16_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent17_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent18_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent19_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent20_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent21_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent22_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent23_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent24_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent25_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent26_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent27_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent28_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent29_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent30_rdata;
  (* keep *)wire [31:0] rvfi_csr_mhpmevent31_rdata;

  nerv #(
      .RESET_ADDR(32'h8000_0000),
      .NUMREGS(32)
  ) uut (
      .clock(clock),
      .reset(reset),
      .stall(stall),
      .trap (trap),

      .imem_addr(imem_addr),
      .imem_data(imem_data),

      .dmem_valid(dmem_valid),
      .dmem_addr (dmem_addr),
      .dmem_wstrb(dmem_wstrb),
      .dmem_wdata(dmem_wdata),
      .dmem_rdata(dmem_rdata),

`ifdef NERV_FAULT
      .imem_fault(imem_fault),
      .dmem_fault(dmem_fault),
`endif

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

      .rvfi_csr_mvendorid_rdata(rvfi_csr_mvendorid_rdata),
      .rvfi_csr_marchid_rdata(rvfi_csr_marchid_rdata),
      .rvfi_csr_mimpid_rdata(rvfi_csr_mimpid_rdata),
      .rvfi_csr_mhartid_rdata(rvfi_csr_mhartid_rdata),
      .rvfi_csr_mconfigptr_rdata(rvfi_csr_mconfigptr_rdata),

      .rvfi_csr_mstatus_rdata(rvfi_csr_mstatus_rdata),
      .rvfi_csr_misa_rdata(rvfi_csr_misa_rdata),
      .rvfi_csr_mie_rdata(rvfi_csr_mie_rdata),
      .rvfi_csr_mtvec_rdata(rvfi_csr_mtvec_rdata),
      .rvfi_csr_mstatush_rdata(rvfi_csr_mstatush_rdata),

      .rvfi_csr_mscratch_rdata(rvfi_csr_mscratch_rdata),
      .rvfi_csr_mepc_rdata(rvfi_csr_mepc_rdata),
      .rvfi_csr_mcause_rdata(rvfi_csr_mcause_rdata),
      .rvfi_csr_mtval_rdata(rvfi_csr_mtval_rdata),
      .rvfi_csr_mip_rdata(rvfi_csr_mip_rdata),

      .rvfi_csr_pmpcfg0_rdata  (rvfi_csr_pmpcfg0_rdata),
      .rvfi_csr_pmpcfg1_rdata  (rvfi_csr_pmpcfg1_rdata),
      .rvfi_csr_pmpcfg2_rdata  (rvfi_csr_pmpcfg2_rdata),
      .rvfi_csr_pmpcfg3_rdata  (rvfi_csr_pmpcfg3_rdata),
      .rvfi_csr_pmpcfg4_rdata  (rvfi_csr_pmpcfg4_rdata),
      .rvfi_csr_pmpcfg5_rdata  (rvfi_csr_pmpcfg5_rdata),
      .rvfi_csr_pmpcfg6_rdata  (rvfi_csr_pmpcfg6_rdata),
      .rvfi_csr_pmpcfg7_rdata  (rvfi_csr_pmpcfg7_rdata),
      .rvfi_csr_pmpcfg8_rdata  (rvfi_csr_pmpcfg8_rdata),
      .rvfi_csr_pmpcfg9_rdata  (rvfi_csr_pmpcfg9_rdata),
      .rvfi_csr_pmpcfg10_rdata (rvfi_csr_pmpcfg10_rdata),
      .rvfi_csr_pmpcfg11_rdata (rvfi_csr_pmpcfg11_rdata),
      .rvfi_csr_pmpcfg12_rdata (rvfi_csr_pmpcfg12_rdata),
      .rvfi_csr_pmpcfg13_rdata (rvfi_csr_pmpcfg13_rdata),
      .rvfi_csr_pmpcfg14_rdata (rvfi_csr_pmpcfg14_rdata),
      .rvfi_csr_pmpcfg15_rdata (rvfi_csr_pmpcfg15_rdata),
      .rvfi_csr_pmpaddr0_rdata (rvfi_csr_pmpaddr0_rdata),
      .rvfi_csr_pmpaddr1_rdata (rvfi_csr_pmpaddr1_rdata),
      .rvfi_csr_pmpaddr2_rdata (rvfi_csr_pmpaddr2_rdata),
      .rvfi_csr_pmpaddr3_rdata (rvfi_csr_pmpaddr3_rdata),
      .rvfi_csr_pmpaddr4_rdata (rvfi_csr_pmpaddr4_rdata),
      .rvfi_csr_pmpaddr5_rdata (rvfi_csr_pmpaddr5_rdata),
      .rvfi_csr_pmpaddr6_rdata (rvfi_csr_pmpaddr6_rdata),
      .rvfi_csr_pmpaddr7_rdata (rvfi_csr_pmpaddr7_rdata),
      .rvfi_csr_pmpaddr8_rdata (rvfi_csr_pmpaddr8_rdata),
      .rvfi_csr_pmpaddr9_rdata (rvfi_csr_pmpaddr9_rdata),
      .rvfi_csr_pmpaddr10_rdata(rvfi_csr_pmpaddr10_rdata),
      .rvfi_csr_pmpaddr11_rdata(rvfi_csr_pmpaddr11_rdata),
      .rvfi_csr_pmpaddr12_rdata(rvfi_csr_pmpaddr12_rdata),
      .rvfi_csr_pmpaddr13_rdata(rvfi_csr_pmpaddr13_rdata),
      .rvfi_csr_pmpaddr14_rdata(rvfi_csr_pmpaddr14_rdata),
      .rvfi_csr_pmpaddr15_rdata(rvfi_csr_pmpaddr15_rdata),
      .rvfi_csr_pmpaddr16_rdata(rvfi_csr_pmpaddr16_rdata),
      .rvfi_csr_pmpaddr17_rdata(rvfi_csr_pmpaddr17_rdata),
      .rvfi_csr_pmpaddr18_rdata(rvfi_csr_pmpaddr18_rdata),
      .rvfi_csr_pmpaddr19_rdata(rvfi_csr_pmpaddr19_rdata),
      .rvfi_csr_pmpaddr20_rdata(rvfi_csr_pmpaddr20_rdata),
      .rvfi_csr_pmpaddr21_rdata(rvfi_csr_pmpaddr21_rdata),
      .rvfi_csr_pmpaddr22_rdata(rvfi_csr_pmpaddr22_rdata),
      .rvfi_csr_pmpaddr23_rdata(rvfi_csr_pmpaddr23_rdata),
      .rvfi_csr_pmpaddr24_rdata(rvfi_csr_pmpaddr24_rdata),
      .rvfi_csr_pmpaddr25_rdata(rvfi_csr_pmpaddr25_rdata),
      .rvfi_csr_pmpaddr26_rdata(rvfi_csr_pmpaddr26_rdata),
      .rvfi_csr_pmpaddr27_rdata(rvfi_csr_pmpaddr27_rdata),
      .rvfi_csr_pmpaddr28_rdata(rvfi_csr_pmpaddr28_rdata),
      .rvfi_csr_pmpaddr29_rdata(rvfi_csr_pmpaddr29_rdata),
      .rvfi_csr_pmpaddr30_rdata(rvfi_csr_pmpaddr30_rdata),
      .rvfi_csr_pmpaddr31_rdata(rvfi_csr_pmpaddr31_rdata),
      .rvfi_csr_pmpaddr32_rdata(rvfi_csr_pmpaddr32_rdata),
      .rvfi_csr_pmpaddr33_rdata(rvfi_csr_pmpaddr33_rdata),
      .rvfi_csr_pmpaddr34_rdata(rvfi_csr_pmpaddr34_rdata),
      .rvfi_csr_pmpaddr35_rdata(rvfi_csr_pmpaddr35_rdata),
      .rvfi_csr_pmpaddr36_rdata(rvfi_csr_pmpaddr36_rdata),
      .rvfi_csr_pmpaddr37_rdata(rvfi_csr_pmpaddr37_rdata),
      .rvfi_csr_pmpaddr38_rdata(rvfi_csr_pmpaddr38_rdata),
      .rvfi_csr_pmpaddr39_rdata(rvfi_csr_pmpaddr39_rdata),
      .rvfi_csr_pmpaddr40_rdata(rvfi_csr_pmpaddr40_rdata),
      .rvfi_csr_pmpaddr41_rdata(rvfi_csr_pmpaddr41_rdata),
      .rvfi_csr_pmpaddr42_rdata(rvfi_csr_pmpaddr42_rdata),
      .rvfi_csr_pmpaddr43_rdata(rvfi_csr_pmpaddr43_rdata),
      .rvfi_csr_pmpaddr44_rdata(rvfi_csr_pmpaddr44_rdata),
      .rvfi_csr_pmpaddr45_rdata(rvfi_csr_pmpaddr45_rdata),
      .rvfi_csr_pmpaddr46_rdata(rvfi_csr_pmpaddr46_rdata),
      .rvfi_csr_pmpaddr47_rdata(rvfi_csr_pmpaddr47_rdata),
      .rvfi_csr_pmpaddr48_rdata(rvfi_csr_pmpaddr48_rdata),
      .rvfi_csr_pmpaddr49_rdata(rvfi_csr_pmpaddr49_rdata),
      .rvfi_csr_pmpaddr50_rdata(rvfi_csr_pmpaddr50_rdata),
      .rvfi_csr_pmpaddr51_rdata(rvfi_csr_pmpaddr51_rdata),
      .rvfi_csr_pmpaddr52_rdata(rvfi_csr_pmpaddr52_rdata),
      .rvfi_csr_pmpaddr53_rdata(rvfi_csr_pmpaddr53_rdata),
      .rvfi_csr_pmpaddr54_rdata(rvfi_csr_pmpaddr54_rdata),
      .rvfi_csr_pmpaddr55_rdata(rvfi_csr_pmpaddr55_rdata),
      .rvfi_csr_pmpaddr56_rdata(rvfi_csr_pmpaddr56_rdata),
      .rvfi_csr_pmpaddr57_rdata(rvfi_csr_pmpaddr57_rdata),
      .rvfi_csr_pmpaddr58_rdata(rvfi_csr_pmpaddr58_rdata),
      .rvfi_csr_pmpaddr59_rdata(rvfi_csr_pmpaddr59_rdata),
      .rvfi_csr_pmpaddr60_rdata(rvfi_csr_pmpaddr60_rdata),
      .rvfi_csr_pmpaddr61_rdata(rvfi_csr_pmpaddr61_rdata),
      .rvfi_csr_pmpaddr62_rdata(rvfi_csr_pmpaddr62_rdata),
      .rvfi_csr_pmpaddr63_rdata(rvfi_csr_pmpaddr63_rdata),

      .rvfi_csr_mcycle_rdata(rvfi_csr_mcycle_rdata),
      .rvfi_csr_minstret_rdata(rvfi_csr_minstret_rdata),
      .rvfi_csr_mhpmcounter3_rdata(rvfi_csr_mhpmcounter3_rdata),
      .rvfi_csr_mhpmcounter4_rdata(rvfi_csr_mhpmcounter4_rdata),
      .rvfi_csr_mhpmcounter5_rdata(rvfi_csr_mhpmcounter5_rdata),
      .rvfi_csr_mhpmcounter6_rdata(rvfi_csr_mhpmcounter6_rdata),
      .rvfi_csr_mhpmcounter7_rdata(rvfi_csr_mhpmcounter7_rdata),
      .rvfi_csr_mhpmcounter8_rdata(rvfi_csr_mhpmcounter8_rdata),
      .rvfi_csr_mhpmcounter9_rdata(rvfi_csr_mhpmcounter9_rdata),
      .rvfi_csr_mhpmcounter10_rdata(rvfi_csr_mhpmcounter10_rdata),
      .rvfi_csr_mhpmcounter11_rdata(rvfi_csr_mhpmcounter11_rdata),
      .rvfi_csr_mhpmcounter12_rdata(rvfi_csr_mhpmcounter12_rdata),
      .rvfi_csr_mhpmcounter13_rdata(rvfi_csr_mhpmcounter13_rdata),
      .rvfi_csr_mhpmcounter14_rdata(rvfi_csr_mhpmcounter14_rdata),
      .rvfi_csr_mhpmcounter15_rdata(rvfi_csr_mhpmcounter15_rdata),
      .rvfi_csr_mhpmcounter16_rdata(rvfi_csr_mhpmcounter16_rdata),
      .rvfi_csr_mhpmcounter17_rdata(rvfi_csr_mhpmcounter17_rdata),
      .rvfi_csr_mhpmcounter18_rdata(rvfi_csr_mhpmcounter18_rdata),
      .rvfi_csr_mhpmcounter19_rdata(rvfi_csr_mhpmcounter19_rdata),
      .rvfi_csr_mhpmcounter20_rdata(rvfi_csr_mhpmcounter20_rdata),
      .rvfi_csr_mhpmcounter21_rdata(rvfi_csr_mhpmcounter21_rdata),
      .rvfi_csr_mhpmcounter22_rdata(rvfi_csr_mhpmcounter22_rdata),
      .rvfi_csr_mhpmcounter23_rdata(rvfi_csr_mhpmcounter23_rdata),
      .rvfi_csr_mhpmcounter24_rdata(rvfi_csr_mhpmcounter24_rdata),
      .rvfi_csr_mhpmcounter25_rdata(rvfi_csr_mhpmcounter25_rdata),
      .rvfi_csr_mhpmcounter26_rdata(rvfi_csr_mhpmcounter26_rdata),
      .rvfi_csr_mhpmcounter27_rdata(rvfi_csr_mhpmcounter27_rdata),
      .rvfi_csr_mhpmcounter28_rdata(rvfi_csr_mhpmcounter28_rdata),
      .rvfi_csr_mhpmcounter29_rdata(rvfi_csr_mhpmcounter29_rdata),
      .rvfi_csr_mhpmcounter30_rdata(rvfi_csr_mhpmcounter30_rdata),
      .rvfi_csr_mhpmcounter31_rdata(rvfi_csr_mhpmcounter31_rdata),
      .rvfi_csr_mcycleh_rdata(rvfi_csr_mcycleh_rdata),
      .rvfi_csr_minstreth_rdata(rvfi_csr_minstreth_rdata),
      .rvfi_csr_mhpmcounter3h_rdata(rvfi_csr_mhpmcounter3h_rdata),
      .rvfi_csr_mhpmcounter4h_rdata(rvfi_csr_mhpmcounter4h_rdata),
      .rvfi_csr_mhpmcounter5h_rdata(rvfi_csr_mhpmcounter5h_rdata),
      .rvfi_csr_mhpmcounter6h_rdata(rvfi_csr_mhpmcounter6h_rdata),
      .rvfi_csr_mhpmcounter7h_rdata(rvfi_csr_mhpmcounter7h_rdata),
      .rvfi_csr_mhpmcounter8h_rdata(rvfi_csr_mhpmcounter8h_rdata),
      .rvfi_csr_mhpmcounter9h_rdata(rvfi_csr_mhpmcounter9h_rdata),
      .rvfi_csr_mhpmcounter10h_rdata(rvfi_csr_mhpmcounter10h_rdata),
      .rvfi_csr_mhpmcounter11h_rdata(rvfi_csr_mhpmcounter11h_rdata),
      .rvfi_csr_mhpmcounter12h_rdata(rvfi_csr_mhpmcounter12h_rdata),
      .rvfi_csr_mhpmcounter13h_rdata(rvfi_csr_mhpmcounter13h_rdata),
      .rvfi_csr_mhpmcounter14h_rdata(rvfi_csr_mhpmcounter14h_rdata),
      .rvfi_csr_mhpmcounter15h_rdata(rvfi_csr_mhpmcounter15h_rdata),
      .rvfi_csr_mhpmcounter16h_rdata(rvfi_csr_mhpmcounter16h_rdata),
      .rvfi_csr_mhpmcounter17h_rdata(rvfi_csr_mhpmcounter17h_rdata),
      .rvfi_csr_mhpmcounter18h_rdata(rvfi_csr_mhpmcounter18h_rdata),
      .rvfi_csr_mhpmcounter19h_rdata(rvfi_csr_mhpmcounter19h_rdata),
      .rvfi_csr_mhpmcounter20h_rdata(rvfi_csr_mhpmcounter20h_rdata),
      .rvfi_csr_mhpmcounter21h_rdata(rvfi_csr_mhpmcounter21h_rdata),
      .rvfi_csr_mhpmcounter22h_rdata(rvfi_csr_mhpmcounter22h_rdata),
      .rvfi_csr_mhpmcounter23h_rdata(rvfi_csr_mhpmcounter23h_rdata),
      .rvfi_csr_mhpmcounter24h_rdata(rvfi_csr_mhpmcounter24h_rdata),
      .rvfi_csr_mhpmcounter25h_rdata(rvfi_csr_mhpmcounter25h_rdata),
      .rvfi_csr_mhpmcounter26h_rdata(rvfi_csr_mhpmcounter26h_rdata),
      .rvfi_csr_mhpmcounter27h_rdata(rvfi_csr_mhpmcounter27h_rdata),
      .rvfi_csr_mhpmcounter28h_rdata(rvfi_csr_mhpmcounter28h_rdata),
      .rvfi_csr_mhpmcounter29h_rdata(rvfi_csr_mhpmcounter29h_rdata),
      .rvfi_csr_mhpmcounter30h_rdata(rvfi_csr_mhpmcounter30h_rdata),
      .rvfi_csr_mhpmcounter31h_rdata(rvfi_csr_mhpmcounter31h_rdata),

      .rvfi_csr_mhpmevent3_rdata (rvfi_csr_mhpmevent3_rdata),
      .rvfi_csr_mhpmevent4_rdata (rvfi_csr_mhpmevent4_rdata),
      .rvfi_csr_mhpmevent5_rdata (rvfi_csr_mhpmevent5_rdata),
      .rvfi_csr_mhpmevent6_rdata (rvfi_csr_mhpmevent6_rdata),
      .rvfi_csr_mhpmevent7_rdata (rvfi_csr_mhpmevent7_rdata),
      .rvfi_csr_mhpmevent8_rdata (rvfi_csr_mhpmevent8_rdata),
      .rvfi_csr_mhpmevent9_rdata (rvfi_csr_mhpmevent9_rdata),
      .rvfi_csr_mhpmevent10_rdata(rvfi_csr_mhpmevent10_rdata),
      .rvfi_csr_mhpmevent11_rdata(rvfi_csr_mhpmevent11_rdata),
      .rvfi_csr_mhpmevent12_rdata(rvfi_csr_mhpmevent12_rdata),
      .rvfi_csr_mhpmevent13_rdata(rvfi_csr_mhpmevent13_rdata),
      .rvfi_csr_mhpmevent14_rdata(rvfi_csr_mhpmevent14_rdata),
      .rvfi_csr_mhpmevent15_rdata(rvfi_csr_mhpmevent15_rdata),
      .rvfi_csr_mhpmevent16_rdata(rvfi_csr_mhpmevent16_rdata),
      .rvfi_csr_mhpmevent17_rdata(rvfi_csr_mhpmevent17_rdata),
      .rvfi_csr_mhpmevent18_rdata(rvfi_csr_mhpmevent18_rdata),
      .rvfi_csr_mhpmevent19_rdata(rvfi_csr_mhpmevent19_rdata),
      .rvfi_csr_mhpmevent20_rdata(rvfi_csr_mhpmevent20_rdata),
      .rvfi_csr_mhpmevent21_rdata(rvfi_csr_mhpmevent21_rdata),
      .rvfi_csr_mhpmevent22_rdata(rvfi_csr_mhpmevent22_rdata),
      .rvfi_csr_mhpmevent23_rdata(rvfi_csr_mhpmevent23_rdata),
      .rvfi_csr_mhpmevent24_rdata(rvfi_csr_mhpmevent24_rdata),
      .rvfi_csr_mhpmevent25_rdata(rvfi_csr_mhpmevent25_rdata),
      .rvfi_csr_mhpmevent26_rdata(rvfi_csr_mhpmevent26_rdata),
      .rvfi_csr_mhpmevent27_rdata(rvfi_csr_mhpmevent27_rdata),
      .rvfi_csr_mhpmevent28_rdata(rvfi_csr_mhpmevent28_rdata),
      .rvfi_csr_mhpmevent29_rdata(rvfi_csr_mhpmevent29_rdata),
      .rvfi_csr_mhpmevent30_rdata(rvfi_csr_mhpmevent30_rdata),
      .rvfi_csr_mhpmevent31_rdata(rvfi_csr_mhpmevent31_rdata),
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

  function [1:0] mask2offset;
    input [3:0] mask;
    begin
      casex (mask)
        4'b???1: mask2offset = 0;
        4'b??10: mask2offset = 1;
        4'b?100: mask2offset = 2;
        4'b1000: mask2offset = 3;
        default: mask2offset = 0;
      endcase
    end
  endfunction

  function [5:0] mask2width;
    input [3:0] mask;
    begin
      case (mask)
        4'b0001, 4'b0010, 4'b0100, 4'b1000: mask2width = 6'd8;
        4'b0011, 4'b1100: mask2width = 6'd16;
        default: mask2width = 6'd32;
      endcase
    end
  endfunction

  assign mem_read_valid = (rvfi_valid && |rvfi_mem_rmask);
  assign mem_read_memWidth = mask2width(rvfi_mem_rmask);
  assign mem_read_addr = rvfi_mem_addr + mask2offset(rvfi_mem_rmask);
  assign mem_read_data = rvfi_mem_rdata;

  assign mem_write_valid = (rvfi_valid && |rvfi_mem_wmask);
  assign mem_write_memWidth = mask2width(rvfi_mem_wmask);
  assign mem_write_addr = rvfi_mem_addr + mask2offset(rvfi_mem_wmask);
  assign mem_write_data = rvfi_mem_wdata >> (mask2offset(rvfi_mem_wmask) * 8);

  assign mode = rvfi_mode;
  assign csr_mvendorid = rvfi_csr_mvendorid_rdata;
  assign csr_marchid = rvfi_csr_marchid_rdata;
  assign csr_mimpid = rvfi_csr_mimpid_rdata;
  assign csr_mhartid = rvfi_csr_mhartid_rdata;
  assign csr_mconfigptr = rvfi_csr_mconfigptr_rdata;
  assign csr_mstatus = rvfi_csr_mstatus_rdata;
  assign csr_misa = rvfi_csr_misa_rdata;
  assign csr_mie = rvfi_csr_mie_rdata;
  assign csr_mtvec = rvfi_csr_mtvec_rdata;
  assign csr_mstatush = rvfi_csr_mstatush_rdata;
  assign csr_mscratch = rvfi_csr_mscratch_rdata;
  assign csr_mepc = rvfi_csr_mepc_rdata;
  assign csr_mcause = rvfi_csr_mcause_rdata;
  assign csr_mip = rvfi_csr_mip_rdata;
  assign csr_mtval = rvfi_csr_mtval_rdata;
  assign csr_mseccfg = 32'b0;
  assign csr_mseccfgh = 32'b0;
  assign csr_pmpcfg0 = rvfi_csr_pmpcfg0_rdata;
  assign csr_pmpcfg1 = rvfi_csr_pmpcfg1_rdata;
  assign csr_pmpcfg2 = rvfi_csr_pmpcfg2_rdata;
  assign csr_pmpcfg3 = rvfi_csr_pmpcfg3_rdata;
  assign csr_pmpcfg4 = rvfi_csr_pmpcfg4_rdata;
  assign csr_pmpcfg5 = rvfi_csr_pmpcfg5_rdata;
  assign csr_pmpcfg6 = rvfi_csr_pmpcfg6_rdata;
  assign csr_pmpcfg7 = rvfi_csr_pmpcfg7_rdata;
  assign csr_pmpcfg8 = rvfi_csr_pmpcfg8_rdata;
  assign csr_pmpcfg9 = rvfi_csr_pmpcfg9_rdata;
  assign csr_pmpcfg10 = rvfi_csr_pmpcfg10_rdata;
  assign csr_pmpcfg11 = rvfi_csr_pmpcfg11_rdata;
  assign csr_pmpcfg12 = rvfi_csr_pmpcfg12_rdata;
  assign csr_pmpcfg13 = rvfi_csr_pmpcfg13_rdata;
  assign csr_pmpcfg14 = rvfi_csr_pmpcfg14_rdata;
  assign csr_pmpcfg15 = rvfi_csr_pmpcfg15_rdata;
  assign csr_pmpaddr0 = rvfi_csr_pmpaddr0_rdata;
  assign csr_pmpaddr1 = rvfi_csr_pmpaddr1_rdata;
  assign csr_pmpaddr2 = rvfi_csr_pmpaddr2_rdata;
  assign csr_pmpaddr3 = rvfi_csr_pmpaddr3_rdata;
  assign csr_pmpaddr4 = rvfi_csr_pmpaddr4_rdata;
  assign csr_pmpaddr5 = rvfi_csr_pmpaddr5_rdata;
  assign csr_pmpaddr6 = rvfi_csr_pmpaddr6_rdata;
  assign csr_pmpaddr7 = rvfi_csr_pmpaddr7_rdata;
  assign csr_pmpaddr8 = rvfi_csr_pmpaddr8_rdata;
  assign csr_pmpaddr9 = rvfi_csr_pmpaddr9_rdata;
  assign csr_pmpaddr10 = rvfi_csr_pmpaddr10_rdata;
  assign csr_pmpaddr11 = rvfi_csr_pmpaddr11_rdata;
  assign csr_pmpaddr12 = rvfi_csr_pmpaddr12_rdata;
  assign csr_pmpaddr13 = rvfi_csr_pmpaddr13_rdata;
  assign csr_pmpaddr14 = rvfi_csr_pmpaddr14_rdata;
  assign csr_pmpaddr15 = rvfi_csr_pmpaddr15_rdata;
  assign csr_pmpaddr16 = rvfi_csr_pmpaddr16_rdata;
  assign csr_pmpaddr17 = rvfi_csr_pmpaddr17_rdata;
  assign csr_pmpaddr18 = rvfi_csr_pmpaddr18_rdata;
  assign csr_pmpaddr19 = rvfi_csr_pmpaddr19_rdata;
  assign csr_pmpaddr20 = rvfi_csr_pmpaddr20_rdata;
  assign csr_pmpaddr21 = rvfi_csr_pmpaddr21_rdata;
  assign csr_pmpaddr22 = rvfi_csr_pmpaddr22_rdata;
  assign csr_pmpaddr23 = rvfi_csr_pmpaddr23_rdata;
  assign csr_pmpaddr24 = rvfi_csr_pmpaddr24_rdata;
  assign csr_pmpaddr25 = rvfi_csr_pmpaddr25_rdata;
  assign csr_pmpaddr26 = rvfi_csr_pmpaddr26_rdata;
  assign csr_pmpaddr27 = rvfi_csr_pmpaddr27_rdata;
  assign csr_pmpaddr28 = rvfi_csr_pmpaddr28_rdata;
  assign csr_pmpaddr29 = rvfi_csr_pmpaddr29_rdata;
  assign csr_pmpaddr30 = rvfi_csr_pmpaddr30_rdata;
  assign csr_pmpaddr31 = rvfi_csr_pmpaddr31_rdata;
  assign csr_pmpaddr32 = rvfi_csr_pmpaddr32_rdata;
  assign csr_pmpaddr33 = rvfi_csr_pmpaddr33_rdata;
  assign csr_pmpaddr34 = rvfi_csr_pmpaddr34_rdata;
  assign csr_pmpaddr35 = rvfi_csr_pmpaddr35_rdata;
  assign csr_pmpaddr36 = rvfi_csr_pmpaddr36_rdata;
  assign csr_pmpaddr37 = rvfi_csr_pmpaddr37_rdata;
  assign csr_pmpaddr38 = rvfi_csr_pmpaddr38_rdata;
  assign csr_pmpaddr39 = rvfi_csr_pmpaddr39_rdata;
  assign csr_pmpaddr40 = rvfi_csr_pmpaddr40_rdata;
  assign csr_pmpaddr41 = rvfi_csr_pmpaddr41_rdata;
  assign csr_pmpaddr42 = rvfi_csr_pmpaddr42_rdata;
  assign csr_pmpaddr43 = rvfi_csr_pmpaddr43_rdata;
  assign csr_pmpaddr44 = rvfi_csr_pmpaddr44_rdata;
  assign csr_pmpaddr45 = rvfi_csr_pmpaddr45_rdata;
  assign csr_pmpaddr46 = rvfi_csr_pmpaddr46_rdata;
  assign csr_pmpaddr47 = rvfi_csr_pmpaddr47_rdata;
  assign csr_pmpaddr48 = rvfi_csr_pmpaddr48_rdata;
  assign csr_pmpaddr49 = rvfi_csr_pmpaddr49_rdata;
  assign csr_pmpaddr50 = rvfi_csr_pmpaddr50_rdata;
  assign csr_pmpaddr51 = rvfi_csr_pmpaddr51_rdata;
  assign csr_pmpaddr52 = rvfi_csr_pmpaddr52_rdata;
  assign csr_pmpaddr53 = rvfi_csr_pmpaddr53_rdata;
  assign csr_pmpaddr54 = rvfi_csr_pmpaddr54_rdata;
  assign csr_pmpaddr55 = rvfi_csr_pmpaddr55_rdata;
  assign csr_pmpaddr56 = rvfi_csr_pmpaddr56_rdata;
  assign csr_pmpaddr57 = rvfi_csr_pmpaddr57_rdata;
  assign csr_pmpaddr58 = rvfi_csr_pmpaddr58_rdata;
  assign csr_pmpaddr59 = rvfi_csr_pmpaddr59_rdata;
  assign csr_pmpaddr60 = rvfi_csr_pmpaddr60_rdata;
  assign csr_pmpaddr61 = rvfi_csr_pmpaddr61_rdata;
  assign csr_pmpaddr62 = rvfi_csr_pmpaddr62_rdata;
  assign csr_pmpaddr63 = rvfi_csr_pmpaddr63_rdata;
  assign csr_mcycle = rvfi_csr_mcycle_rdata;
  assign csr_minstret = rvfi_csr_minstret_rdata;
  assign csr_mhpmcounter3 = rvfi_csr_mhpmcounter3_rdata;
  assign csr_mhpmcounter4 = rvfi_csr_mhpmcounter4_rdata;
  assign csr_mhpmcounter5 = rvfi_csr_mhpmcounter5_rdata;
  assign csr_mhpmcounter6 = rvfi_csr_mhpmcounter6_rdata;
  assign csr_mhpmcounter7 = rvfi_csr_mhpmcounter7_rdata;
  assign csr_mhpmcounter8 = rvfi_csr_mhpmcounter8_rdata;
  assign csr_mhpmcounter9 = rvfi_csr_mhpmcounter9_rdata;
  assign csr_mhpmcounter10 = rvfi_csr_mhpmcounter10_rdata;
  assign csr_mhpmcounter11 = rvfi_csr_mhpmcounter11_rdata;
  assign csr_mhpmcounter12 = rvfi_csr_mhpmcounter12_rdata;
  assign csr_mhpmcounter13 = rvfi_csr_mhpmcounter13_rdata;
  assign csr_mhpmcounter14 = rvfi_csr_mhpmcounter14_rdata;
  assign csr_mhpmcounter15 = rvfi_csr_mhpmcounter15_rdata;
  assign csr_mhpmcounter16 = rvfi_csr_mhpmcounter16_rdata;
  assign csr_mhpmcounter17 = rvfi_csr_mhpmcounter17_rdata;
  assign csr_mhpmcounter18 = rvfi_csr_mhpmcounter18_rdata;
  assign csr_mhpmcounter19 = rvfi_csr_mhpmcounter19_rdata;
  assign csr_mhpmcounter20 = rvfi_csr_mhpmcounter20_rdata;
  assign csr_mhpmcounter21 = rvfi_csr_mhpmcounter21_rdata;
  assign csr_mhpmcounter22 = rvfi_csr_mhpmcounter22_rdata;
  assign csr_mhpmcounter23 = rvfi_csr_mhpmcounter23_rdata;
  assign csr_mhpmcounter24 = rvfi_csr_mhpmcounter24_rdata;
  assign csr_mhpmcounter25 = rvfi_csr_mhpmcounter25_rdata;
  assign csr_mhpmcounter26 = rvfi_csr_mhpmcounter26_rdata;
  assign csr_mhpmcounter27 = rvfi_csr_mhpmcounter27_rdata;
  assign csr_mhpmcounter28 = rvfi_csr_mhpmcounter28_rdata;
  assign csr_mhpmcounter29 = rvfi_csr_mhpmcounter29_rdata;
  assign csr_mhpmcounter30 = rvfi_csr_mhpmcounter30_rdata;
  assign csr_mhpmcounter31 = rvfi_csr_mhpmcounter31_rdata;
  assign csr_mcycleh = rvfi_csr_mcycleh_rdata;
  assign csr_minstreth = rvfi_csr_minstreth_rdata;
  assign csr_mhpmcounter3h = rvfi_csr_mhpmcounter3h_rdata;
  assign csr_mhpmcounter4h = rvfi_csr_mhpmcounter4h_rdata;
  assign csr_mhpmcounter5h = rvfi_csr_mhpmcounter5h_rdata;
  assign csr_mhpmcounter6h = rvfi_csr_mhpmcounter6h_rdata;
  assign csr_mhpmcounter7h = rvfi_csr_mhpmcounter7h_rdata;
  assign csr_mhpmcounter8h = rvfi_csr_mhpmcounter8h_rdata;
  assign csr_mhpmcounter9h = rvfi_csr_mhpmcounter9h_rdata;
  assign csr_mhpmcounter10h = rvfi_csr_mhpmcounter10h_rdata;
  assign csr_mhpmcounter11h = rvfi_csr_mhpmcounter11h_rdata;
  assign csr_mhpmcounter12h = rvfi_csr_mhpmcounter12h_rdata;
  assign csr_mhpmcounter13h = rvfi_csr_mhpmcounter13h_rdata;
  assign csr_mhpmcounter14h = rvfi_csr_mhpmcounter14h_rdata;
  assign csr_mhpmcounter15h = rvfi_csr_mhpmcounter15h_rdata;
  assign csr_mhpmcounter16h = rvfi_csr_mhpmcounter16h_rdata;
  assign csr_mhpmcounter17h = rvfi_csr_mhpmcounter17h_rdata;
  assign csr_mhpmcounter18h = rvfi_csr_mhpmcounter18h_rdata;
  assign csr_mhpmcounter19h = rvfi_csr_mhpmcounter19h_rdata;
  assign csr_mhpmcounter20h = rvfi_csr_mhpmcounter20h_rdata;
  assign csr_mhpmcounter21h = rvfi_csr_mhpmcounter21h_rdata;
  assign csr_mhpmcounter22h = rvfi_csr_mhpmcounter22h_rdata;
  assign csr_mhpmcounter23h = rvfi_csr_mhpmcounter23h_rdata;
  assign csr_mhpmcounter24h = rvfi_csr_mhpmcounter24h_rdata;
  assign csr_mhpmcounter25h = rvfi_csr_mhpmcounter25h_rdata;
  assign csr_mhpmcounter26h = rvfi_csr_mhpmcounter26h_rdata;
  assign csr_mhpmcounter27h = rvfi_csr_mhpmcounter27h_rdata;
  assign csr_mhpmcounter28h = rvfi_csr_mhpmcounter28h_rdata;
  assign csr_mhpmcounter29h = rvfi_csr_mhpmcounter29h_rdata;
  assign csr_mhpmcounter30h = rvfi_csr_mhpmcounter30h_rdata;
  assign csr_mhpmcounter31h = rvfi_csr_mhpmcounter31h_rdata;
  assign csr_mhpmevent3 = rvfi_csr_mhpmevent3_rdata;
  assign csr_mhpmevent4 = rvfi_csr_mhpmevent4_rdata;
  assign csr_mhpmevent5 = rvfi_csr_mhpmevent5_rdata;
  assign csr_mhpmevent6 = rvfi_csr_mhpmevent6_rdata;
  assign csr_mhpmevent7 = rvfi_csr_mhpmevent7_rdata;
  assign csr_mhpmevent8 = rvfi_csr_mhpmevent8_rdata;
  assign csr_mhpmevent9 = rvfi_csr_mhpmevent9_rdata;
  assign csr_mhpmevent10 = rvfi_csr_mhpmevent10_rdata;
  assign csr_mhpmevent11 = rvfi_csr_mhpmevent11_rdata;
  assign csr_mhpmevent12 = rvfi_csr_mhpmevent12_rdata;
  assign csr_mhpmevent13 = rvfi_csr_mhpmevent13_rdata;
  assign csr_mhpmevent14 = rvfi_csr_mhpmevent14_rdata;
  assign csr_mhpmevent15 = rvfi_csr_mhpmevent15_rdata;
  assign csr_mhpmevent16 = rvfi_csr_mhpmevent16_rdata;
  assign csr_mhpmevent17 = rvfi_csr_mhpmevent17_rdata;
  assign csr_mhpmevent18 = rvfi_csr_mhpmevent18_rdata;
  assign csr_mhpmevent19 = rvfi_csr_mhpmevent19_rdata;
  assign csr_mhpmevent20 = rvfi_csr_mhpmevent20_rdata;
  assign csr_mhpmevent21 = rvfi_csr_mhpmevent21_rdata;
  assign csr_mhpmevent22 = rvfi_csr_mhpmevent22_rdata;
  assign csr_mhpmevent23 = rvfi_csr_mhpmevent23_rdata;
  assign csr_mhpmevent24 = rvfi_csr_mhpmevent24_rdata;
  assign csr_mhpmevent25 = rvfi_csr_mhpmevent25_rdata;
  assign csr_mhpmevent26 = rvfi_csr_mhpmevent26_rdata;
  assign csr_mhpmevent27 = rvfi_csr_mhpmevent27_rdata;
  assign csr_mhpmevent28 = rvfi_csr_mhpmevent28_rdata;
  assign csr_mhpmevent29 = rvfi_csr_mhpmevent29_rdata;
  assign csr_mhpmevent30 = rvfi_csr_mhpmevent30_rdata;
  assign csr_mhpmevent31 = rvfi_csr_mhpmevent31_rdata;
  assign csr_mhpmevent3h = 32'b0;
  assign csr_mhpmevent4h = 32'b0;
  assign csr_mhpmevent5h = 32'b0;
  assign csr_mhpmevent6h = 32'b0;
  assign csr_mhpmevent7h = 32'b0;
  assign csr_mhpmevent8h = 32'b0;
  assign csr_mhpmevent9h = 32'b0;
  assign csr_mhpmevent10h = 32'b0;
  assign csr_mhpmevent11h = 32'b0;
  assign csr_mhpmevent12h = 32'b0;
  assign csr_mhpmevent13h = 32'b0;
  assign csr_mhpmevent14h = 32'b0;
  assign csr_mhpmevent15h = 32'b0;
  assign csr_mhpmevent16h = 32'b0;
  assign csr_mhpmevent17h = 32'b0;
  assign csr_mhpmevent18h = 32'b0;
  assign csr_mhpmevent19h = 32'b0;
  assign csr_mhpmevent20h = 32'b0;
  assign csr_mhpmevent21h = 32'b0;
  assign csr_mhpmevent22h = 32'b0;
  assign csr_mhpmevent23h = 32'b0;
  assign csr_mhpmevent24h = 32'b0;
  assign csr_mhpmevent25h = 32'b0;
  assign csr_mhpmevent26h = 32'b0;
  assign csr_mhpmevent27h = 32'b0;
  assign csr_mhpmevent28h = 32'b0;
  assign csr_mhpmevent29h = 32'b0;
  assign csr_mhpmevent30h = 32'b0;
  assign csr_mhpmevent31h = 32'b0;

//   always @* begin
//     if (!reset && rvfi_valid) begin
// `ifndef NERV_TESTTRAP
//       assume (!rvfi_trap);
// `endif
//     end
//   end

`ifdef NERV_FAIRNESS
  reg [2:0] stalled = 0;
  always @(posedge clock) begin
    stalled <= {stalled, stall};
    assume (~stalled);
  end
`endif

endmodule

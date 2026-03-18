module testbench (
    input clock,
    input reset
);

  (* keep *)wire        commit_valid;
  (* keep *)wire        commit_excp;
  (* keep *)wire [31:0] commit_inst;
  (* keep *)wire [31:0] commit_pc;
  (* keep *)wire [31:0] commit_npc;

  (* keep *)wire [ 4:0] writeback_rs1Addr;
  (* keep *)wire [ 4:0] writeback_rs2Addr;
  (* keep *)wire [31:0] writeback_rs1Data;
  (* keep *)wire [31:0] writeback_rs2Data;
  (* keep *)wire [ 4:0] writeback_rdAddr;
  (* keep *)wire [31:0] writeback_rdData;
  (* keep *)wire        writeback_csrWr;
  (* keep *)wire [11:0] writeback_csrAddr;
  (* keep *)wire [63:0] writeback_csrNdata;

  (* keep *)wire        mem_read_valid;
  (* keep *)wire [31:0] mem_read_addr;
  (* keep *)wire [ 5:0] mem_read_memWidth;
  (* keep *)wire [31:0] mem_read_data;
  (* keep *)wire        mem_write_valid;
  (* keep *)wire [31:0] mem_write_addr;
  (* keep *)wire [ 5:0] mem_write_memWidth;
  (* keep *)wire [31:0] mem_write_data;

  (* keep *)wire [ 1:0] mode;
  (* keep *)wire [31:0] csr_mvendorid;
  (* keep *)wire [31:0] csr_marchid;
  (* keep *)wire [31:0] csr_mimpid;
  (* keep *)wire [31:0] csr_mhartid;
  (* keep *)wire [31:0] csr_mconfigptr;
  (* keep *)wire [31:0] csr_mstatus;
  (* keep *)wire [31:0] csr_misa;
  (* keep *)wire [31:0] csr_medeleg;
  (* keep *)wire [31:0] csr_mideleg;
  (* keep *)wire [31:0] csr_mie;
  (* keep *)wire [31:0] csr_mtvec;
  (* keep *)wire [31:0] csr_mcounteren;
  (* keep *)wire [31:0] csr_mstatush;
  (* keep *)wire [31:0] csr_medelegh;
  (* keep *)wire [31:0] csr_mscratch;
  (* keep *)wire [31:0] csr_mepc;
  (* keep *)wire [31:0] csr_mcause;
  (* keep *)wire [31:0] csr_mip;
  (* keep *)wire [31:0] csr_mtval;
  (* keep *)wire [31:0] csr_menvcfg;
  (* keep *)wire [31:0] csr_menvcfgh;
  (* keep *)wire [31:0] csr_mseccfg;
  (* keep *)wire [31:0] csr_mseccfgh;
  (* keep *)wire [31:0] csr_pmpcfg0;
  (* keep *)wire [31:0] csr_pmpcfg1;
  (* keep *)wire [31:0] csr_pmpcfg2;
  (* keep *)wire [31:0] csr_pmpcfg3;
  (* keep *)wire [31:0] csr_pmpcfg4;
  (* keep *)wire [31:0] csr_pmpcfg5;
  (* keep *)wire [31:0] csr_pmpcfg6;
  (* keep *)wire [31:0] csr_pmpcfg7;
  (* keep *)wire [31:0] csr_pmpcfg8;
  (* keep *)wire [31:0] csr_pmpcfg9;
  (* keep *)wire [31:0] csr_pmpcfg10;
  (* keep *)wire [31:0] csr_pmpcfg11;
  (* keep *)wire [31:0] csr_pmpcfg12;
  (* keep *)wire [31:0] csr_pmpcfg13;
  (* keep *)wire [31:0] csr_pmpcfg14;
  (* keep *)wire [31:0] csr_pmpcfg15;
  (* keep *)wire [31:0] csr_pmpaddr0;
  (* keep *)wire [31:0] csr_pmpaddr1;
  (* keep *)wire [31:0] csr_pmpaddr2;
  (* keep *)wire [31:0] csr_pmpaddr3;
  (* keep *)wire [31:0] csr_pmpaddr4;
  (* keep *)wire [31:0] csr_pmpaddr5;
  (* keep *)wire [31:0] csr_pmpaddr6;
  (* keep *)wire [31:0] csr_pmpaddr7;
  (* keep *)wire [31:0] csr_pmpaddr8;
  (* keep *)wire [31:0] csr_pmpaddr9;
  (* keep *)wire [31:0] csr_pmpaddr10;
  (* keep *)wire [31:0] csr_pmpaddr11;
  (* keep *)wire [31:0] csr_pmpaddr12;
  (* keep *)wire [31:0] csr_pmpaddr13;
  (* keep *)wire [31:0] csr_pmpaddr14;
  (* keep *)wire [31:0] csr_pmpaddr15;
  (* keep *)wire [31:0] csr_pmpaddr16;
  (* keep *)wire [31:0] csr_pmpaddr17;
  (* keep *)wire [31:0] csr_pmpaddr18;
  (* keep *)wire [31:0] csr_pmpaddr19;
  (* keep *)wire [31:0] csr_pmpaddr20;
  (* keep *)wire [31:0] csr_pmpaddr21;
  (* keep *)wire [31:0] csr_pmpaddr22;
  (* keep *)wire [31:0] csr_pmpaddr23;
  (* keep *)wire [31:0] csr_pmpaddr24;
  (* keep *)wire [31:0] csr_pmpaddr25;
  (* keep *)wire [31:0] csr_pmpaddr26;
  (* keep *)wire [31:0] csr_pmpaddr27;
  (* keep *)wire [31:0] csr_pmpaddr28;
  (* keep *)wire [31:0] csr_pmpaddr29;
  (* keep *)wire [31:0] csr_pmpaddr30;
  (* keep *)wire [31:0] csr_pmpaddr31;
  (* keep *)wire [31:0] csr_pmpaddr32;
  (* keep *)wire [31:0] csr_pmpaddr33;
  (* keep *)wire [31:0] csr_pmpaddr34;
  (* keep *)wire [31:0] csr_pmpaddr35;
  (* keep *)wire [31:0] csr_pmpaddr36;
  (* keep *)wire [31:0] csr_pmpaddr37;
  (* keep *)wire [31:0] csr_pmpaddr38;
  (* keep *)wire [31:0] csr_pmpaddr39;
  (* keep *)wire [31:0] csr_pmpaddr40;
  (* keep *)wire [31:0] csr_pmpaddr41;
  (* keep *)wire [31:0] csr_pmpaddr42;
  (* keep *)wire [31:0] csr_pmpaddr43;
  (* keep *)wire [31:0] csr_pmpaddr44;
  (* keep *)wire [31:0] csr_pmpaddr45;
  (* keep *)wire [31:0] csr_pmpaddr46;
  (* keep *)wire [31:0] csr_pmpaddr47;
  (* keep *)wire [31:0] csr_pmpaddr48;
  (* keep *)wire [31:0] csr_pmpaddr49;
  (* keep *)wire [31:0] csr_pmpaddr50;
  (* keep *)wire [31:0] csr_pmpaddr51;
  (* keep *)wire [31:0] csr_pmpaddr52;
  (* keep *)wire [31:0] csr_pmpaddr53;
  (* keep *)wire [31:0] csr_pmpaddr54;
  (* keep *)wire [31:0] csr_pmpaddr55;
  (* keep *)wire [31:0] csr_pmpaddr56;
  (* keep *)wire [31:0] csr_pmpaddr57;
  (* keep *)wire [31:0] csr_pmpaddr58;
  (* keep *)wire [31:0] csr_pmpaddr59;
  (* keep *)wire [31:0] csr_pmpaddr60;
  (* keep *)wire [31:0] csr_pmpaddr61;
  (* keep *)wire [31:0] csr_pmpaddr62;
  (* keep *)wire [31:0] csr_pmpaddr63;
  (* keep *)wire [31:0] csr_mcycle;
  (* keep *)wire [31:0] csr_minstret;
  (* keep *)wire [31:0] csr_mhpmcounter3;
  (* keep *)wire [31:0] csr_mhpmcounter4;
  (* keep *)wire [31:0] csr_mhpmcounter5;
  (* keep *)wire [31:0] csr_mhpmcounter6;
  (* keep *)wire [31:0] csr_mhpmcounter7;
  (* keep *)wire [31:0] csr_mhpmcounter8;
  (* keep *)wire [31:0] csr_mhpmcounter9;
  (* keep *)wire [31:0] csr_mhpmcounter10;
  (* keep *)wire [31:0] csr_mhpmcounter11;
  (* keep *)wire [31:0] csr_mhpmcounter12;
  (* keep *)wire [31:0] csr_mhpmcounter13;
  (* keep *)wire [31:0] csr_mhpmcounter14;
  (* keep *)wire [31:0] csr_mhpmcounter15;
  (* keep *)wire [31:0] csr_mhpmcounter16;
  (* keep *)wire [31:0] csr_mhpmcounter17;
  (* keep *)wire [31:0] csr_mhpmcounter18;
  (* keep *)wire [31:0] csr_mhpmcounter19;
  (* keep *)wire [31:0] csr_mhpmcounter20;
  (* keep *)wire [31:0] csr_mhpmcounter21;
  (* keep *)wire [31:0] csr_mhpmcounter22;
  (* keep *)wire [31:0] csr_mhpmcounter23;
  (* keep *)wire [31:0] csr_mhpmcounter24;
  (* keep *)wire [31:0] csr_mhpmcounter25;
  (* keep *)wire [31:0] csr_mhpmcounter26;
  (* keep *)wire [31:0] csr_mhpmcounter27;
  (* keep *)wire [31:0] csr_mhpmcounter28;
  (* keep *)wire [31:0] csr_mhpmcounter29;
  (* keep *)wire [31:0] csr_mhpmcounter30;
  (* keep *)wire [31:0] csr_mhpmcounter31;
  (* keep *)wire [31:0] csr_mcycleh;
  (* keep *)wire [31:0] csr_minstreth;
  (* keep *)wire [31:0] csr_mhpmcounter3h;
  (* keep *)wire [31:0] csr_mhpmcounter4h;
  (* keep *)wire [31:0] csr_mhpmcounter5h;
  (* keep *)wire [31:0] csr_mhpmcounter6h;
  (* keep *)wire [31:0] csr_mhpmcounter7h;
  (* keep *)wire [31:0] csr_mhpmcounter8h;
  (* keep *)wire [31:0] csr_mhpmcounter9h;
  (* keep *)wire [31:0] csr_mhpmcounter10h;
  (* keep *)wire [31:0] csr_mhpmcounter11h;
  (* keep *)wire [31:0] csr_mhpmcounter12h;
  (* keep *)wire [31:0] csr_mhpmcounter13h;
  (* keep *)wire [31:0] csr_mhpmcounter14h;
  (* keep *)wire [31:0] csr_mhpmcounter15h;
  (* keep *)wire [31:0] csr_mhpmcounter16h;
  (* keep *)wire [31:0] csr_mhpmcounter17h;
  (* keep *)wire [31:0] csr_mhpmcounter18h;
  (* keep *)wire [31:0] csr_mhpmcounter19h;
  (* keep *)wire [31:0] csr_mhpmcounter20h;
  (* keep *)wire [31:0] csr_mhpmcounter21h;
  (* keep *)wire [31:0] csr_mhpmcounter22h;
  (* keep *)wire [31:0] csr_mhpmcounter23h;
  (* keep *)wire [31:0] csr_mhpmcounter24h;
  (* keep *)wire [31:0] csr_mhpmcounter25h;
  (* keep *)wire [31:0] csr_mhpmcounter26h;
  (* keep *)wire [31:0] csr_mhpmcounter27h;
  (* keep *)wire [31:0] csr_mhpmcounter28h;
  (* keep *)wire [31:0] csr_mhpmcounter29h;
  (* keep *)wire [31:0] csr_mhpmcounter30h;
  (* keep *)wire [31:0] csr_mhpmcounter31h;
  (* keep *)wire [31:0] csr_mcountinhibit;
  (* keep *)wire [31:0] csr_mhpmevent3;
  (* keep *)wire [31:0] csr_mhpmevent4;
  (* keep *)wire [31:0] csr_mhpmevent5;
  (* keep *)wire [31:0] csr_mhpmevent6;
  (* keep *)wire [31:0] csr_mhpmevent7;
  (* keep *)wire [31:0] csr_mhpmevent8;
  (* keep *)wire [31:0] csr_mhpmevent9;
  (* keep *)wire [31:0] csr_mhpmevent10;
  (* keep *)wire [31:0] csr_mhpmevent11;
  (* keep *)wire [31:0] csr_mhpmevent12;
  (* keep *)wire [31:0] csr_mhpmevent13;
  (* keep *)wire [31:0] csr_mhpmevent14;
  (* keep *)wire [31:0] csr_mhpmevent15;
  (* keep *)wire [31:0] csr_mhpmevent16;
  (* keep *)wire [31:0] csr_mhpmevent17;
  (* keep *)wire [31:0] csr_mhpmevent18;
  (* keep *)wire [31:0] csr_mhpmevent19;
  (* keep *)wire [31:0] csr_mhpmevent20;
  (* keep *)wire [31:0] csr_mhpmevent21;
  (* keep *)wire [31:0] csr_mhpmevent22;
  (* keep *)wire [31:0] csr_mhpmevent23;
  (* keep *)wire [31:0] csr_mhpmevent24;
  (* keep *)wire [31:0] csr_mhpmevent25;
  (* keep *)wire [31:0] csr_mhpmevent26;
  (* keep *)wire [31:0] csr_mhpmevent27;
  (* keep *)wire [31:0] csr_mhpmevent28;
  (* keep *)wire [31:0] csr_mhpmevent29;
  (* keep *)wire [31:0] csr_mhpmevent30;
  (* keep *)wire [31:0] csr_mhpmevent31;
  (* keep *)wire [31:0] csr_mhpmevent3h;
  (* keep *)wire [31:0] csr_mhpmevent4h;
  (* keep *)wire [31:0] csr_mhpmevent5h;
  (* keep *)wire [31:0] csr_mhpmevent6h;
  (* keep *)wire [31:0] csr_mhpmevent7h;
  (* keep *)wire [31:0] csr_mhpmevent8h;
  (* keep *)wire [31:0] csr_mhpmevent9h;
  (* keep *)wire [31:0] csr_mhpmevent10h;
  (* keep *)wire [31:0] csr_mhpmevent11h;
  (* keep *)wire [31:0] csr_mhpmevent12h;
  (* keep *)wire [31:0] csr_mhpmevent13h;
  (* keep *)wire [31:0] csr_mhpmevent14h;
  (* keep *)wire [31:0] csr_mhpmevent15h;
  (* keep *)wire [31:0] csr_mhpmevent16h;
  (* keep *)wire [31:0] csr_mhpmevent17h;
  (* keep *)wire [31:0] csr_mhpmevent18h;
  (* keep *)wire [31:0] csr_mhpmevent19h;
  (* keep *)wire [31:0] csr_mhpmevent20h;
  (* keep *)wire [31:0] csr_mhpmevent21h;
  (* keep *)wire [31:0] csr_mhpmevent22h;
  (* keep *)wire [31:0] csr_mhpmevent23h;
  (* keep *)wire [31:0] csr_mhpmevent24h;
  (* keep *)wire [31:0] csr_mhpmevent25h;
  (* keep *)wire [31:0] csr_mhpmevent26h;
  (* keep *)wire [31:0] csr_mhpmevent27h;
  (* keep *)wire [31:0] csr_mhpmevent28h;
  (* keep *)wire [31:0] csr_mhpmevent29h;
  (* keep *)wire [31:0] csr_mhpmevent30h;
  (* keep *)wire [31:0] csr_mhpmevent31h;
  (* keep *)wire [31:0] csr_stvec;
  (* keep *)wire [31:0] csr_scounteren;
  (* keep *)wire [31:0] csr_senvcfg;
  (* keep *)wire [31:0] csr_scountinhibit;
  (* keep *)wire [31:0] csr_sscratch;
  (* keep *)wire [31:0] csr_sepc;
  (* keep *)wire [31:0] csr_scause;
  (* keep *)wire [31:0] csr_stval;
  (* keep *)wire [31:0] csr_satp;
  (* keep *)wire [31:0] csr_stimecmp;
  (* keep *)wire [31:0] csr_stimecmph;

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
      .mem_write_data(mem_write_data),

      .mode(mode),
      .csr_mvendorid(csr_mvendorid),
      .csr_marchid(csr_marchid),
      .csr_mimpid(csr_mimpid),
      .csr_mhartid(csr_mhartid),
      .csr_mconfigptr(csr_mconfigptr),
      .csr_mstatus(csr_mstatus),
      .csr_misa(csr_misa),
      .csr_mie(csr_mie),
      .csr_mtvec(csr_mtvec),
      .csr_mstatush(csr_mstatush),
      .csr_mscratch(csr_mscratch),
      .csr_mepc(csr_mepc),
      .csr_mcause(csr_mcause),
      .csr_mip(csr_mip),
      .csr_mtval(csr_mtval),
      .csr_mseccfg(csr_mseccfg),
      .csr_mseccfgh(csr_mseccfgh),
      .csr_pmpcfg0(csr_pmpcfg0),
      .csr_pmpcfg1(csr_pmpcfg1),
      .csr_pmpcfg2(csr_pmpcfg2),
      .csr_pmpcfg3(csr_pmpcfg3),
      .csr_pmpcfg4(csr_pmpcfg4),
      .csr_pmpcfg5(csr_pmpcfg5),
      .csr_pmpcfg6(csr_pmpcfg6),
      .csr_pmpcfg7(csr_pmpcfg7),
      .csr_pmpcfg8(csr_pmpcfg8),
      .csr_pmpcfg9(csr_pmpcfg9),
      .csr_pmpcfg10(csr_pmpcfg10),
      .csr_pmpcfg11(csr_pmpcfg11),
      .csr_pmpcfg12(csr_pmpcfg12),
      .csr_pmpcfg13(csr_pmpcfg13),
      .csr_pmpcfg14(csr_pmpcfg14),
      .csr_pmpcfg15(csr_pmpcfg15),
      .csr_pmpaddr0(csr_pmpaddr0),
      .csr_pmpaddr1(csr_pmpaddr1),
      .csr_pmpaddr2(csr_pmpaddr2),
      .csr_pmpaddr3(csr_pmpaddr3),
      .csr_pmpaddr4(csr_pmpaddr4),
      .csr_pmpaddr5(csr_pmpaddr5),
      .csr_pmpaddr6(csr_pmpaddr6),
      .csr_pmpaddr7(csr_pmpaddr7),
      .csr_pmpaddr8(csr_pmpaddr8),
      .csr_pmpaddr9(csr_pmpaddr9),
      .csr_pmpaddr10(csr_pmpaddr10),
      .csr_pmpaddr11(csr_pmpaddr11),
      .csr_pmpaddr12(csr_pmpaddr12),
      .csr_pmpaddr13(csr_pmpaddr13),
      .csr_pmpaddr14(csr_pmpaddr14),
      .csr_pmpaddr15(csr_pmpaddr15),
      .csr_pmpaddr16(csr_pmpaddr16),
      .csr_pmpaddr17(csr_pmpaddr17),
      .csr_pmpaddr18(csr_pmpaddr18),
      .csr_pmpaddr19(csr_pmpaddr19),
      .csr_pmpaddr20(csr_pmpaddr20),
      .csr_pmpaddr21(csr_pmpaddr21),
      .csr_pmpaddr22(csr_pmpaddr22),
      .csr_pmpaddr23(csr_pmpaddr23),
      .csr_pmpaddr24(csr_pmpaddr24),
      .csr_pmpaddr25(csr_pmpaddr25),
      .csr_pmpaddr26(csr_pmpaddr26),
      .csr_pmpaddr27(csr_pmpaddr27),
      .csr_pmpaddr28(csr_pmpaddr28),
      .csr_pmpaddr29(csr_pmpaddr29),
      .csr_pmpaddr30(csr_pmpaddr30),
      .csr_pmpaddr31(csr_pmpaddr31),
      .csr_pmpaddr32(csr_pmpaddr32),
      .csr_pmpaddr33(csr_pmpaddr33),
      .csr_pmpaddr34(csr_pmpaddr34),
      .csr_pmpaddr35(csr_pmpaddr35),
      .csr_pmpaddr36(csr_pmpaddr36),
      .csr_pmpaddr37(csr_pmpaddr37),
      .csr_pmpaddr38(csr_pmpaddr38),
      .csr_pmpaddr39(csr_pmpaddr39),
      .csr_pmpaddr40(csr_pmpaddr40),
      .csr_pmpaddr41(csr_pmpaddr41),
      .csr_pmpaddr42(csr_pmpaddr42),
      .csr_pmpaddr43(csr_pmpaddr43),
      .csr_pmpaddr44(csr_pmpaddr44),
      .csr_pmpaddr45(csr_pmpaddr45),
      .csr_pmpaddr46(csr_pmpaddr46),
      .csr_pmpaddr47(csr_pmpaddr47),
      .csr_pmpaddr48(csr_pmpaddr48),
      .csr_pmpaddr49(csr_pmpaddr49),
      .csr_pmpaddr50(csr_pmpaddr50),
      .csr_pmpaddr51(csr_pmpaddr51),
      .csr_pmpaddr52(csr_pmpaddr52),
      .csr_pmpaddr53(csr_pmpaddr53),
      .csr_pmpaddr54(csr_pmpaddr54),
      .csr_pmpaddr55(csr_pmpaddr55),
      .csr_pmpaddr56(csr_pmpaddr56),
      .csr_pmpaddr57(csr_pmpaddr57),
      .csr_pmpaddr58(csr_pmpaddr58),
      .csr_pmpaddr59(csr_pmpaddr59),
      .csr_pmpaddr60(csr_pmpaddr60),
      .csr_pmpaddr61(csr_pmpaddr61),
      .csr_pmpaddr62(csr_pmpaddr62),
      .csr_pmpaddr63(csr_pmpaddr63),
      .csr_mcycle(csr_mcycle),
      .csr_minstret(csr_minstret),
      .csr_mhpmcounter3(csr_mhpmcounter3),
      .csr_mhpmcounter4(csr_mhpmcounter4),
      .csr_mhpmcounter5(csr_mhpmcounter5),
      .csr_mhpmcounter6(csr_mhpmcounter6),
      .csr_mhpmcounter7(csr_mhpmcounter7),
      .csr_mhpmcounter8(csr_mhpmcounter8),
      .csr_mhpmcounter9(csr_mhpmcounter9),
      .csr_mhpmcounter10(csr_mhpmcounter10),
      .csr_mhpmcounter11(csr_mhpmcounter11),
      .csr_mhpmcounter12(csr_mhpmcounter12),
      .csr_mhpmcounter13(csr_mhpmcounter13),
      .csr_mhpmcounter14(csr_mhpmcounter14),
      .csr_mhpmcounter15(csr_mhpmcounter15),
      .csr_mhpmcounter16(csr_mhpmcounter16),
      .csr_mhpmcounter17(csr_mhpmcounter17),
      .csr_mhpmcounter18(csr_mhpmcounter18),
      .csr_mhpmcounter19(csr_mhpmcounter19),
      .csr_mhpmcounter20(csr_mhpmcounter20),
      .csr_mhpmcounter21(csr_mhpmcounter21),
      .csr_mhpmcounter22(csr_mhpmcounter22),
      .csr_mhpmcounter23(csr_mhpmcounter23),
      .csr_mhpmcounter24(csr_mhpmcounter24),
      .csr_mhpmcounter25(csr_mhpmcounter25),
      .csr_mhpmcounter26(csr_mhpmcounter26),
      .csr_mhpmcounter27(csr_mhpmcounter27),
      .csr_mhpmcounter28(csr_mhpmcounter28),
      .csr_mhpmcounter29(csr_mhpmcounter29),
      .csr_mhpmcounter30(csr_mhpmcounter30),
      .csr_mhpmcounter31(csr_mhpmcounter31),
      .csr_mcycleh(csr_mcycleh),
      .csr_minstreth(csr_minstreth),
      .csr_mhpmcounter3h(csr_mhpmcounter3h),
      .csr_mhpmcounter4h(csr_mhpmcounter4h),
      .csr_mhpmcounter5h(csr_mhpmcounter5h),
      .csr_mhpmcounter6h(csr_mhpmcounter6h),
      .csr_mhpmcounter7h(csr_mhpmcounter7h),
      .csr_mhpmcounter8h(csr_mhpmcounter8h),
      .csr_mhpmcounter9h(csr_mhpmcounter9h),
      .csr_mhpmcounter10h(csr_mhpmcounter10h),
      .csr_mhpmcounter11h(csr_mhpmcounter11h),
      .csr_mhpmcounter12h(csr_mhpmcounter12h),
      .csr_mhpmcounter13h(csr_mhpmcounter13h),
      .csr_mhpmcounter14h(csr_mhpmcounter14h),
      .csr_mhpmcounter15h(csr_mhpmcounter15h),
      .csr_mhpmcounter16h(csr_mhpmcounter16h),
      .csr_mhpmcounter17h(csr_mhpmcounter17h),
      .csr_mhpmcounter18h(csr_mhpmcounter18h),
      .csr_mhpmcounter19h(csr_mhpmcounter19h),
      .csr_mhpmcounter20h(csr_mhpmcounter20h),
      .csr_mhpmcounter21h(csr_mhpmcounter21h),
      .csr_mhpmcounter22h(csr_mhpmcounter22h),
      .csr_mhpmcounter23h(csr_mhpmcounter23h),
      .csr_mhpmcounter24h(csr_mhpmcounter24h),
      .csr_mhpmcounter25h(csr_mhpmcounter25h),
      .csr_mhpmcounter26h(csr_mhpmcounter26h),
      .csr_mhpmcounter27h(csr_mhpmcounter27h),
      .csr_mhpmcounter28h(csr_mhpmcounter28h),
      .csr_mhpmcounter29h(csr_mhpmcounter29h),
      .csr_mhpmcounter30h(csr_mhpmcounter30h),
      .csr_mhpmcounter31h(csr_mhpmcounter31h),
      .csr_mcountinhibit(csr_mcountinhibit),
      .csr_mhpmevent3(csr_mhpmevent3),
      .csr_mhpmevent4(csr_mhpmevent4),
      .csr_mhpmevent5(csr_mhpmevent5),
      .csr_mhpmevent6(csr_mhpmevent6),
      .csr_mhpmevent7(csr_mhpmevent7),
      .csr_mhpmevent8(csr_mhpmevent8),
      .csr_mhpmevent9(csr_mhpmevent9),
      .csr_mhpmevent10(csr_mhpmevent10),
      .csr_mhpmevent11(csr_mhpmevent11),
      .csr_mhpmevent12(csr_mhpmevent12),
      .csr_mhpmevent13(csr_mhpmevent13),
      .csr_mhpmevent14(csr_mhpmevent14),
      .csr_mhpmevent15(csr_mhpmevent15),
      .csr_mhpmevent16(csr_mhpmevent16),
      .csr_mhpmevent17(csr_mhpmevent17),
      .csr_mhpmevent18(csr_mhpmevent18),
      .csr_mhpmevent19(csr_mhpmevent19),
      .csr_mhpmevent20(csr_mhpmevent20),
      .csr_mhpmevent21(csr_mhpmevent21),
      .csr_mhpmevent22(csr_mhpmevent22),
      .csr_mhpmevent23(csr_mhpmevent23),
      .csr_mhpmevent24(csr_mhpmevent24),
      .csr_mhpmevent25(csr_mhpmevent25),
      .csr_mhpmevent26(csr_mhpmevent26),
      .csr_mhpmevent27(csr_mhpmevent27),
      .csr_mhpmevent28(csr_mhpmevent28),
      .csr_mhpmevent29(csr_mhpmevent29),
      .csr_mhpmevent30(csr_mhpmevent30),
      .csr_mhpmevent31(csr_mhpmevent31),
      .csr_mhpmevent3h(csr_mhpmevent3h),
      .csr_mhpmevent4h(csr_mhpmevent4h),
      .csr_mhpmevent5h(csr_mhpmevent5h),
      .csr_mhpmevent6h(csr_mhpmevent6h),
      .csr_mhpmevent7h(csr_mhpmevent7h),
      .csr_mhpmevent8h(csr_mhpmevent8h),
      .csr_mhpmevent9h(csr_mhpmevent9h),
      .csr_mhpmevent10h(csr_mhpmevent10h),
      .csr_mhpmevent11h(csr_mhpmevent11h),
      .csr_mhpmevent12h(csr_mhpmevent12h),
      .csr_mhpmevent13h(csr_mhpmevent13h),
      .csr_mhpmevent14h(csr_mhpmevent14h),
      .csr_mhpmevent15h(csr_mhpmevent15h),
      .csr_mhpmevent16h(csr_mhpmevent16h),
      .csr_mhpmevent17h(csr_mhpmevent17h),
      .csr_mhpmevent18h(csr_mhpmevent18h),
      .csr_mhpmevent19h(csr_mhpmevent19h),
      .csr_mhpmevent20h(csr_mhpmevent20h),
      .csr_mhpmevent21h(csr_mhpmevent21h),
      .csr_mhpmevent22h(csr_mhpmevent22h),
      .csr_mhpmevent23h(csr_mhpmevent23h),
      .csr_mhpmevent24h(csr_mhpmevent24h),
      .csr_mhpmevent25h(csr_mhpmevent25h),
      .csr_mhpmevent26h(csr_mhpmevent26h),
      .csr_mhpmevent27h(csr_mhpmevent27h),
      .csr_mhpmevent28h(csr_mhpmevent28h),
      .csr_mhpmevent29h(csr_mhpmevent29h),
      .csr_mhpmevent30h(csr_mhpmevent30h),
      .csr_mhpmevent31h(csr_mhpmevent31h)
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
      .mem_write_data(mem_write_data),

      .mode(mode),
      .csr_mvendorid(csr_mvendorid),
      .csr_marchid(csr_marchid),
      .csr_mimpid(csr_mimpid),
      .csr_mhartid(csr_mhartid),
      .csr_mconfigptr(csr_mconfigptr),
      .csr_mstatus(csr_mstatus),
      .csr_misa(csr_misa),
      .csr_mie(csr_mie),
      .csr_mtvec(csr_mtvec),
      .csr_mstatush(csr_mstatush),
      .csr_mscratch(csr_mscratch),
      .csr_mepc(csr_mepc),
      .csr_mcause(csr_mcause),
      .csr_mip(csr_mip),
      .csr_mtval(csr_mtval),
      .csr_mseccfg(csr_mseccfg),
      .csr_mseccfgh(csr_mseccfgh),
      .csr_pmpcfg0(csr_pmpcfg0),
      .csr_pmpcfg1(csr_pmpcfg1),
      .csr_pmpcfg2(csr_pmpcfg2),
      .csr_pmpcfg3(csr_pmpcfg3),
      .csr_pmpcfg4(csr_pmpcfg4),
      .csr_pmpcfg5(csr_pmpcfg5),
      .csr_pmpcfg6(csr_pmpcfg6),
      .csr_pmpcfg7(csr_pmpcfg7),
      .csr_pmpcfg8(csr_pmpcfg8),
      .csr_pmpcfg9(csr_pmpcfg9),
      .csr_pmpcfg10(csr_pmpcfg10),
      .csr_pmpcfg11(csr_pmpcfg11),
      .csr_pmpcfg12(csr_pmpcfg12),
      .csr_pmpcfg13(csr_pmpcfg13),
      .csr_pmpcfg14(csr_pmpcfg14),
      .csr_pmpcfg15(csr_pmpcfg15),
      .csr_pmpaddr0(csr_pmpaddr0),
      .csr_pmpaddr1(csr_pmpaddr1),
      .csr_pmpaddr2(csr_pmpaddr2),
      .csr_pmpaddr3(csr_pmpaddr3),
      .csr_pmpaddr4(csr_pmpaddr4),
      .csr_pmpaddr5(csr_pmpaddr5),
      .csr_pmpaddr6(csr_pmpaddr6),
      .csr_pmpaddr7(csr_pmpaddr7),
      .csr_pmpaddr8(csr_pmpaddr8),
      .csr_pmpaddr9(csr_pmpaddr9),
      .csr_pmpaddr10(csr_pmpaddr10),
      .csr_pmpaddr11(csr_pmpaddr11),
      .csr_pmpaddr12(csr_pmpaddr12),
      .csr_pmpaddr13(csr_pmpaddr13),
      .csr_pmpaddr14(csr_pmpaddr14),
      .csr_pmpaddr15(csr_pmpaddr15),
      .csr_pmpaddr16(csr_pmpaddr16),
      .csr_pmpaddr17(csr_pmpaddr17),
      .csr_pmpaddr18(csr_pmpaddr18),
      .csr_pmpaddr19(csr_pmpaddr19),
      .csr_pmpaddr20(csr_pmpaddr20),
      .csr_pmpaddr21(csr_pmpaddr21),
      .csr_pmpaddr22(csr_pmpaddr22),
      .csr_pmpaddr23(csr_pmpaddr23),
      .csr_pmpaddr24(csr_pmpaddr24),
      .csr_pmpaddr25(csr_pmpaddr25),
      .csr_pmpaddr26(csr_pmpaddr26),
      .csr_pmpaddr27(csr_pmpaddr27),
      .csr_pmpaddr28(csr_pmpaddr28),
      .csr_pmpaddr29(csr_pmpaddr29),
      .csr_pmpaddr30(csr_pmpaddr30),
      .csr_pmpaddr31(csr_pmpaddr31),
      .csr_pmpaddr32(csr_pmpaddr32),
      .csr_pmpaddr33(csr_pmpaddr33),
      .csr_pmpaddr34(csr_pmpaddr34),
      .csr_pmpaddr35(csr_pmpaddr35),
      .csr_pmpaddr36(csr_pmpaddr36),
      .csr_pmpaddr37(csr_pmpaddr37),
      .csr_pmpaddr38(csr_pmpaddr38),
      .csr_pmpaddr39(csr_pmpaddr39),
      .csr_pmpaddr40(csr_pmpaddr40),
      .csr_pmpaddr41(csr_pmpaddr41),
      .csr_pmpaddr42(csr_pmpaddr42),
      .csr_pmpaddr43(csr_pmpaddr43),
      .csr_pmpaddr44(csr_pmpaddr44),
      .csr_pmpaddr45(csr_pmpaddr45),
      .csr_pmpaddr46(csr_pmpaddr46),
      .csr_pmpaddr47(csr_pmpaddr47),
      .csr_pmpaddr48(csr_pmpaddr48),
      .csr_pmpaddr49(csr_pmpaddr49),
      .csr_pmpaddr50(csr_pmpaddr50),
      .csr_pmpaddr51(csr_pmpaddr51),
      .csr_pmpaddr52(csr_pmpaddr52),
      .csr_pmpaddr53(csr_pmpaddr53),
      .csr_pmpaddr54(csr_pmpaddr54),
      .csr_pmpaddr55(csr_pmpaddr55),
      .csr_pmpaddr56(csr_pmpaddr56),
      .csr_pmpaddr57(csr_pmpaddr57),
      .csr_pmpaddr58(csr_pmpaddr58),
      .csr_pmpaddr59(csr_pmpaddr59),
      .csr_pmpaddr60(csr_pmpaddr60),
      .csr_pmpaddr61(csr_pmpaddr61),
      .csr_pmpaddr62(csr_pmpaddr62),
      .csr_pmpaddr63(csr_pmpaddr63),
      .csr_mcycle(csr_mcycle),
      .csr_minstret(csr_minstret),
      .csr_mhpmcounter3(csr_mhpmcounter3),
      .csr_mhpmcounter4(csr_mhpmcounter4),
      .csr_mhpmcounter5(csr_mhpmcounter5),
      .csr_mhpmcounter6(csr_mhpmcounter6),
      .csr_mhpmcounter7(csr_mhpmcounter7),
      .csr_mhpmcounter8(csr_mhpmcounter8),
      .csr_mhpmcounter9(csr_mhpmcounter9),
      .csr_mhpmcounter10(csr_mhpmcounter10),
      .csr_mhpmcounter11(csr_mhpmcounter11),
      .csr_mhpmcounter12(csr_mhpmcounter12),
      .csr_mhpmcounter13(csr_mhpmcounter13),
      .csr_mhpmcounter14(csr_mhpmcounter14),
      .csr_mhpmcounter15(csr_mhpmcounter15),
      .csr_mhpmcounter16(csr_mhpmcounter16),
      .csr_mhpmcounter17(csr_mhpmcounter17),
      .csr_mhpmcounter18(csr_mhpmcounter18),
      .csr_mhpmcounter19(csr_mhpmcounter19),
      .csr_mhpmcounter20(csr_mhpmcounter20),
      .csr_mhpmcounter21(csr_mhpmcounter21),
      .csr_mhpmcounter22(csr_mhpmcounter22),
      .csr_mhpmcounter23(csr_mhpmcounter23),
      .csr_mhpmcounter24(csr_mhpmcounter24),
      .csr_mhpmcounter25(csr_mhpmcounter25),
      .csr_mhpmcounter26(csr_mhpmcounter26),
      .csr_mhpmcounter27(csr_mhpmcounter27),
      .csr_mhpmcounter28(csr_mhpmcounter28),
      .csr_mhpmcounter29(csr_mhpmcounter29),
      .csr_mhpmcounter30(csr_mhpmcounter30),
      .csr_mhpmcounter31(csr_mhpmcounter31),
      .csr_mcycleh(csr_mcycleh),
      .csr_minstreth(csr_minstreth),
      .csr_mhpmcounter3h(csr_mhpmcounter3h),
      .csr_mhpmcounter4h(csr_mhpmcounter4h),
      .csr_mhpmcounter5h(csr_mhpmcounter5h),
      .csr_mhpmcounter6h(csr_mhpmcounter6h),
      .csr_mhpmcounter7h(csr_mhpmcounter7h),
      .csr_mhpmcounter8h(csr_mhpmcounter8h),
      .csr_mhpmcounter9h(csr_mhpmcounter9h),
      .csr_mhpmcounter10h(csr_mhpmcounter10h),
      .csr_mhpmcounter11h(csr_mhpmcounter11h),
      .csr_mhpmcounter12h(csr_mhpmcounter12h),
      .csr_mhpmcounter13h(csr_mhpmcounter13h),
      .csr_mhpmcounter14h(csr_mhpmcounter14h),
      .csr_mhpmcounter15h(csr_mhpmcounter15h),
      .csr_mhpmcounter16h(csr_mhpmcounter16h),
      .csr_mhpmcounter17h(csr_mhpmcounter17h),
      .csr_mhpmcounter18h(csr_mhpmcounter18h),
      .csr_mhpmcounter19h(csr_mhpmcounter19h),
      .csr_mhpmcounter20h(csr_mhpmcounter20h),
      .csr_mhpmcounter21h(csr_mhpmcounter21h),
      .csr_mhpmcounter22h(csr_mhpmcounter22h),
      .csr_mhpmcounter23h(csr_mhpmcounter23h),
      .csr_mhpmcounter24h(csr_mhpmcounter24h),
      .csr_mhpmcounter25h(csr_mhpmcounter25h),
      .csr_mhpmcounter26h(csr_mhpmcounter26h),
      .csr_mhpmcounter27h(csr_mhpmcounter27h),
      .csr_mhpmcounter28h(csr_mhpmcounter28h),
      .csr_mhpmcounter29h(csr_mhpmcounter29h),
      .csr_mhpmcounter30h(csr_mhpmcounter30h),
      .csr_mhpmcounter31h(csr_mhpmcounter31h),
      .csr_mcountinhibit(csr_mcountinhibit),
      .csr_mhpmevent3(csr_mhpmevent3),
      .csr_mhpmevent4(csr_mhpmevent4),
      .csr_mhpmevent5(csr_mhpmevent5),
      .csr_mhpmevent6(csr_mhpmevent6),
      .csr_mhpmevent7(csr_mhpmevent7),
      .csr_mhpmevent8(csr_mhpmevent8),
      .csr_mhpmevent9(csr_mhpmevent9),
      .csr_mhpmevent10(csr_mhpmevent10),
      .csr_mhpmevent11(csr_mhpmevent11),
      .csr_mhpmevent12(csr_mhpmevent12),
      .csr_mhpmevent13(csr_mhpmevent13),
      .csr_mhpmevent14(csr_mhpmevent14),
      .csr_mhpmevent15(csr_mhpmevent15),
      .csr_mhpmevent16(csr_mhpmevent16),
      .csr_mhpmevent17(csr_mhpmevent17),
      .csr_mhpmevent18(csr_mhpmevent18),
      .csr_mhpmevent19(csr_mhpmevent19),
      .csr_mhpmevent20(csr_mhpmevent20),
      .csr_mhpmevent21(csr_mhpmevent21),
      .csr_mhpmevent22(csr_mhpmevent22),
      .csr_mhpmevent23(csr_mhpmevent23),
      .csr_mhpmevent24(csr_mhpmevent24),
      .csr_mhpmevent25(csr_mhpmevent25),
      .csr_mhpmevent26(csr_mhpmevent26),
      .csr_mhpmevent27(csr_mhpmevent27),
      .csr_mhpmevent28(csr_mhpmevent28),
      .csr_mhpmevent29(csr_mhpmevent29),
      .csr_mhpmevent30(csr_mhpmevent30),
      .csr_mhpmevent31(csr_mhpmevent31),
      .csr_mhpmevent3h(csr_mhpmevent3h),
      .csr_mhpmevent4h(csr_mhpmevent4h),
      .csr_mhpmevent5h(csr_mhpmevent5h),
      .csr_mhpmevent6h(csr_mhpmevent6h),
      .csr_mhpmevent7h(csr_mhpmevent7h),
      .csr_mhpmevent8h(csr_mhpmevent8h),
      .csr_mhpmevent9h(csr_mhpmevent9h),
      .csr_mhpmevent10h(csr_mhpmevent10h),
      .csr_mhpmevent11h(csr_mhpmevent11h),
      .csr_mhpmevent12h(csr_mhpmevent12h),
      .csr_mhpmevent13h(csr_mhpmevent13h),
      .csr_mhpmevent14h(csr_mhpmevent14h),
      .csr_mhpmevent15h(csr_mhpmevent15h),
      .csr_mhpmevent16h(csr_mhpmevent16h),
      .csr_mhpmevent17h(csr_mhpmevent17h),
      .csr_mhpmevent18h(csr_mhpmevent18h),
      .csr_mhpmevent19h(csr_mhpmevent19h),
      .csr_mhpmevent20h(csr_mhpmevent20h),
      .csr_mhpmevent21h(csr_mhpmevent21h),
      .csr_mhpmevent22h(csr_mhpmevent22h),
      .csr_mhpmevent23h(csr_mhpmevent23h),
      .csr_mhpmevent24h(csr_mhpmevent24h),
      .csr_mhpmevent25h(csr_mhpmevent25h),
      .csr_mhpmevent26h(csr_mhpmevent26h),
      .csr_mhpmevent27h(csr_mhpmevent27h),
      .csr_mhpmevent28h(csr_mhpmevent28h),
      .csr_mhpmevent29h(csr_mhpmevent29h),
      .csr_mhpmevent30h(csr_mhpmevent30h),
      .csr_mhpmevent31h(csr_mhpmevent31h)
  );

`ifdef YOSYS
  always_comb assume (reset == $initstate);
`endif

  InstAssume instAssume (
      .valid(commit_valid),
      .inst (commit_inst)
  );

  reg  [7:0] cycle_reg = 0;
  wire [7:0] cycle = reset ? 8'd0 : cycle_reg;

  always @(posedge clock) begin
    cycle_reg <= reset ? 8'd1 : cycle_reg + (cycle_reg != 8'hff);
  end

  wire check = (cycle == 8'd10);

  always @* begin
    if (!reset && check) begin
      assume (commit_valid);
    end
  end


endmodule

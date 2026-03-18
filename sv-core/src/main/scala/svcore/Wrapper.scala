package svcore

import chisel3._
import chisel3.util._
import chisel3.experimental._
import rvspeccore.core._
import rvspeccore.checker._
import rvspeccore.core.spec.instset.csr._
import rvspeccore.core.spec.Inst

class WriteBackChecker(enableReg: Boolean = true, singleInstMode: Option[Inst] = None)(implicit config: RVConfig)
    extends Module {
  implicit val XLEN: Int = config.XLEN

  val commit    = IO(Input(InstCommit()))
  val writeback = IO(Input(WriteBack()))
  val mem       = if (config.formal.checkMem) Some(IO(Input(MemIO()))) else None
  val mode      = if (config.formal.checkCSRs) Some(IO(Input(UInt(2.W)))) else None
  val csr =
    if (config.formal.checkCSRs) Some(IO(Input(new Bundle {
      val mvendorid  = CSRInfos.mvendorid.makeUInt
      val marchid    = CSRInfos.marchid.makeUInt
      val mimpid     = CSRInfos.mimpid.makeUInt
      val mhartid    = CSRInfos.mhartid.makeUInt
      val mconfigptr = CSRInfos.mconfigptr.makeUInt

      val mstatus    = CSRInfos.mstatus.makeUInt
      val misa       = CSRInfos.misa.makeUInt
      val medeleg    = if (config.extensions.S) Some(CSRInfos.medeleg.makeUInt) else None
      val mideleg    = if (config.extensions.S) Some(CSRInfos.mideleg.makeUInt) else None
      val mie        = CSRInfos.mie.makeUInt
      val mtvec      = CSRInfos.mtvec.makeUInt
      val mcounteren = if (config.extensions.U) Some(CSRInfos.mcounteren.makeUInt) else None
      val mstatush   = if (XLEN == 32) Some(CSRInfos.mstatush.makeUInt) else None
      val medelegh   = if (config.extensions.S && XLEN == 32) Some(CSRInfos.medelegh.makeUInt) else None

      val mscratch = CSRInfos.mscratch.makeUInt
      val mepc     = CSRInfos.mepc.makeUInt
      val mcause   = CSRInfos.mcause.makeUInt
      val mip      = CSRInfos.mip.makeUInt
      val mtval    = CSRInfos.mtval.makeUInt

      val menvcfg  = if (config.extensions.U) Some(CSRInfos.menvcfg.makeUInt) else None
      val menvcfgh = if (config.extensions.U && XLEN == 32) Some(CSRInfos.menvcfgh.makeUInt) else None
      val mseccfg  = CSRInfos.mseccfg.makeUInt
      val mseccfgh = if (XLEN == 32) Some(CSRInfos.mseccfgh.makeUInt) else None

      val pmpcfg0   = CSRInfos.pmpcfg(0).makeUInt
      val pmpcfg1   = CSRInfos.pmpcfg(1).makeUInt
      val pmpcfg2   = CSRInfos.pmpcfg(2).makeUInt
      val pmpcfg3   = CSRInfos.pmpcfg(3).makeUInt
      val pmpcfg4   = CSRInfos.pmpcfg(4).makeUInt
      val pmpcfg5   = CSRInfos.pmpcfg(5).makeUInt
      val pmpcfg6   = CSRInfos.pmpcfg(6).makeUInt
      val pmpcfg7   = CSRInfos.pmpcfg(7).makeUInt
      val pmpcfg8   = CSRInfos.pmpcfg(8).makeUInt
      val pmpcfg9   = CSRInfos.pmpcfg(9).makeUInt
      val pmpcfg10  = CSRInfos.pmpcfg(10).makeUInt
      val pmpcfg11  = CSRInfos.pmpcfg(11).makeUInt
      val pmpcfg12  = CSRInfos.pmpcfg(12).makeUInt
      val pmpcfg13  = CSRInfos.pmpcfg(13).makeUInt
      val pmpcfg14  = CSRInfos.pmpcfg(14).makeUInt
      val pmpcfg15  = CSRInfos.pmpcfg(15).makeUInt
      val pmpaddr0  = CSRInfos.pmpaddr(0).makeUInt
      val pmpaddr1  = CSRInfos.pmpaddr(1).makeUInt
      val pmpaddr2  = CSRInfos.pmpaddr(2).makeUInt
      val pmpaddr3  = CSRInfos.pmpaddr(3).makeUInt
      val pmpaddr4  = CSRInfos.pmpaddr(4).makeUInt
      val pmpaddr5  = CSRInfos.pmpaddr(5).makeUInt
      val pmpaddr6  = CSRInfos.pmpaddr(6).makeUInt
      val pmpaddr7  = CSRInfos.pmpaddr(7).makeUInt
      val pmpaddr8  = CSRInfos.pmpaddr(8).makeUInt
      val pmpaddr9  = CSRInfos.pmpaddr(9).makeUInt
      val pmpaddr10 = CSRInfos.pmpaddr(10).makeUInt
      val pmpaddr11 = CSRInfos.pmpaddr(11).makeUInt
      val pmpaddr12 = CSRInfos.pmpaddr(12).makeUInt
      val pmpaddr13 = CSRInfos.pmpaddr(13).makeUInt
      val pmpaddr14 = CSRInfos.pmpaddr(14).makeUInt
      val pmpaddr15 = CSRInfos.pmpaddr(15).makeUInt
      val pmpaddr16 = CSRInfos.pmpaddr(16).makeUInt
      val pmpaddr17 = CSRInfos.pmpaddr(17).makeUInt
      val pmpaddr18 = CSRInfos.pmpaddr(18).makeUInt
      val pmpaddr19 = CSRInfos.pmpaddr(19).makeUInt
      val pmpaddr20 = CSRInfos.pmpaddr(20).makeUInt
      val pmpaddr21 = CSRInfos.pmpaddr(21).makeUInt
      val pmpaddr22 = CSRInfos.pmpaddr(22).makeUInt
      val pmpaddr23 = CSRInfos.pmpaddr(23).makeUInt
      val pmpaddr24 = CSRInfos.pmpaddr(24).makeUInt
      val pmpaddr25 = CSRInfos.pmpaddr(25).makeUInt
      val pmpaddr26 = CSRInfos.pmpaddr(26).makeUInt
      val pmpaddr27 = CSRInfos.pmpaddr(27).makeUInt
      val pmpaddr28 = CSRInfos.pmpaddr(28).makeUInt
      val pmpaddr29 = CSRInfos.pmpaddr(29).makeUInt
      val pmpaddr30 = CSRInfos.pmpaddr(30).makeUInt
      val pmpaddr31 = CSRInfos.pmpaddr(31).makeUInt
      val pmpaddr32 = CSRInfos.pmpaddr(32).makeUInt
      val pmpaddr33 = CSRInfos.pmpaddr(33).makeUInt
      val pmpaddr34 = CSRInfos.pmpaddr(34).makeUInt
      val pmpaddr35 = CSRInfos.pmpaddr(35).makeUInt
      val pmpaddr36 = CSRInfos.pmpaddr(36).makeUInt
      val pmpaddr37 = CSRInfos.pmpaddr(37).makeUInt
      val pmpaddr38 = CSRInfos.pmpaddr(38).makeUInt
      val pmpaddr39 = CSRInfos.pmpaddr(39).makeUInt
      val pmpaddr40 = CSRInfos.pmpaddr(40).makeUInt
      val pmpaddr41 = CSRInfos.pmpaddr(41).makeUInt
      val pmpaddr42 = CSRInfos.pmpaddr(42).makeUInt
      val pmpaddr43 = CSRInfos.pmpaddr(43).makeUInt
      val pmpaddr44 = CSRInfos.pmpaddr(44).makeUInt
      val pmpaddr45 = CSRInfos.pmpaddr(45).makeUInt
      val pmpaddr46 = CSRInfos.pmpaddr(46).makeUInt
      val pmpaddr47 = CSRInfos.pmpaddr(47).makeUInt
      val pmpaddr48 = CSRInfos.pmpaddr(48).makeUInt
      val pmpaddr49 = CSRInfos.pmpaddr(49).makeUInt
      val pmpaddr50 = CSRInfos.pmpaddr(50).makeUInt
      val pmpaddr51 = CSRInfos.pmpaddr(51).makeUInt
      val pmpaddr52 = CSRInfos.pmpaddr(52).makeUInt
      val pmpaddr53 = CSRInfos.pmpaddr(53).makeUInt
      val pmpaddr54 = CSRInfos.pmpaddr(54).makeUInt
      val pmpaddr55 = CSRInfos.pmpaddr(55).makeUInt
      val pmpaddr56 = CSRInfos.pmpaddr(56).makeUInt
      val pmpaddr57 = CSRInfos.pmpaddr(57).makeUInt
      val pmpaddr58 = CSRInfos.pmpaddr(58).makeUInt
      val pmpaddr59 = CSRInfos.pmpaddr(59).makeUInt
      val pmpaddr60 = CSRInfos.pmpaddr(60).makeUInt
      val pmpaddr61 = CSRInfos.pmpaddr(61).makeUInt
      val pmpaddr62 = CSRInfos.pmpaddr(62).makeUInt
      val pmpaddr63 = CSRInfos.pmpaddr(63).makeUInt

      val mcycle         = CSRInfos.mcycle.makeUInt
      val minstret       = CSRInfos.minstret.makeUInt
      val mhpmcounter3   = CSRInfos.mhpmcounter(0).makeUInt
      val mhpmcounter4   = CSRInfos.mhpmcounter(1).makeUInt
      val mhpmcounter5   = CSRInfos.mhpmcounter(2).makeUInt
      val mhpmcounter6   = CSRInfos.mhpmcounter(3).makeUInt
      val mhpmcounter7   = CSRInfos.mhpmcounter(4).makeUInt
      val mhpmcounter8   = CSRInfos.mhpmcounter(5).makeUInt
      val mhpmcounter9   = CSRInfos.mhpmcounter(6).makeUInt
      val mhpmcounter10  = CSRInfos.mhpmcounter(7).makeUInt
      val mhpmcounter11  = CSRInfos.mhpmcounter(8).makeUInt
      val mhpmcounter12  = CSRInfos.mhpmcounter(9).makeUInt
      val mhpmcounter13  = CSRInfos.mhpmcounter(10).makeUInt
      val mhpmcounter14  = CSRInfos.mhpmcounter(11).makeUInt
      val mhpmcounter15  = CSRInfos.mhpmcounter(12).makeUInt
      val mhpmcounter16  = CSRInfos.mhpmcounter(13).makeUInt
      val mhpmcounter17  = CSRInfos.mhpmcounter(14).makeUInt
      val mhpmcounter18  = CSRInfos.mhpmcounter(15).makeUInt
      val mhpmcounter19  = CSRInfos.mhpmcounter(16).makeUInt
      val mhpmcounter20  = CSRInfos.mhpmcounter(17).makeUInt
      val mhpmcounter21  = CSRInfos.mhpmcounter(18).makeUInt
      val mhpmcounter22  = CSRInfos.mhpmcounter(19).makeUInt
      val mhpmcounter23  = CSRInfos.mhpmcounter(20).makeUInt
      val mhpmcounter24  = CSRInfos.mhpmcounter(21).makeUInt
      val mhpmcounter25  = CSRInfos.mhpmcounter(22).makeUInt
      val mhpmcounter26  = CSRInfos.mhpmcounter(23).makeUInt
      val mhpmcounter27  = CSRInfos.mhpmcounter(24).makeUInt
      val mhpmcounter28  = CSRInfos.mhpmcounter(25).makeUInt
      val mhpmcounter29  = CSRInfos.mhpmcounter(26).makeUInt
      val mhpmcounter30  = CSRInfos.mhpmcounter(27).makeUInt
      val mhpmcounter31  = CSRInfos.mhpmcounter(28).makeUInt
      val mcycleh        = if (XLEN == 32) Some(CSRInfos.mcycleh.makeUInt) else None
      val minstreth      = if (XLEN == 32) Some(CSRInfos.minstreth.makeUInt) else None
      val mhpmcounter3h  = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(0).makeUInt) else None
      val mhpmcounter4h  = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(1).makeUInt) else None
      val mhpmcounter5h  = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(2).makeUInt) else None
      val mhpmcounter6h  = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(3).makeUInt) else None
      val mhpmcounter7h  = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(4).makeUInt) else None
      val mhpmcounter8h  = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(5).makeUInt) else None
      val mhpmcounter9h  = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(6).makeUInt) else None
      val mhpmcounter10h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(7).makeUInt) else None
      val mhpmcounter11h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(8).makeUInt) else None
      val mhpmcounter12h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(9).makeUInt) else None
      val mhpmcounter13h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(10).makeUInt) else None
      val mhpmcounter14h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(11).makeUInt) else None
      val mhpmcounter15h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(12).makeUInt) else None
      val mhpmcounter16h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(13).makeUInt) else None
      val mhpmcounter17h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(14).makeUInt) else None
      val mhpmcounter18h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(15).makeUInt) else None
      val mhpmcounter19h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(16).makeUInt) else None
      val mhpmcounter20h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(17).makeUInt) else None
      val mhpmcounter21h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(18).makeUInt) else None
      val mhpmcounter22h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(19).makeUInt) else None
      val mhpmcounter23h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(20).makeUInt) else None
      val mhpmcounter24h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(21).makeUInt) else None
      val mhpmcounter25h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(22).makeUInt) else None
      val mhpmcounter26h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(23).makeUInt) else None
      val mhpmcounter27h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(24).makeUInt) else None
      val mhpmcounter28h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(25).makeUInt) else None
      val mhpmcounter29h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(26).makeUInt) else None
      val mhpmcounter30h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(27).makeUInt) else None
      val mhpmcounter31h = if (XLEN == 32) Some(CSRInfos.mhpmcounterh(28).makeUInt) else None

      val mcountinhibit = CSRInfos.mcountinhibit.makeUInt
      val mhpmevent3    = CSRInfos.mhpmevent(0).makeUInt
      val mhpmevent4    = CSRInfos.mhpmevent(1).makeUInt
      val mhpmevent5    = CSRInfos.mhpmevent(2).makeUInt
      val mhpmevent6    = CSRInfos.mhpmevent(3).makeUInt
      val mhpmevent7    = CSRInfos.mhpmevent(4).makeUInt
      val mhpmevent8    = CSRInfos.mhpmevent(5).makeUInt
      val mhpmevent9    = CSRInfos.mhpmevent(6).makeUInt
      val mhpmevent10   = CSRInfos.mhpmevent(7).makeUInt
      val mhpmevent11   = CSRInfos.mhpmevent(8).makeUInt
      val mhpmevent12   = CSRInfos.mhpmevent(9).makeUInt
      val mhpmevent13   = CSRInfos.mhpmevent(10).makeUInt
      val mhpmevent14   = CSRInfos.mhpmevent(11).makeUInt
      val mhpmevent15   = CSRInfos.mhpmevent(12).makeUInt
      val mhpmevent16   = CSRInfos.mhpmevent(13).makeUInt
      val mhpmevent17   = CSRInfos.mhpmevent(14).makeUInt
      val mhpmevent18   = CSRInfos.mhpmevent(15).makeUInt
      val mhpmevent19   = CSRInfos.mhpmevent(16).makeUInt
      val mhpmevent20   = CSRInfos.mhpmevent(17).makeUInt
      val mhpmevent21   = CSRInfos.mhpmevent(18).makeUInt
      val mhpmevent22   = CSRInfos.mhpmevent(19).makeUInt
      val mhpmevent23   = CSRInfos.mhpmevent(20).makeUInt
      val mhpmevent24   = CSRInfos.mhpmevent(21).makeUInt
      val mhpmevent25   = CSRInfos.mhpmevent(22).makeUInt
      val mhpmevent26   = CSRInfos.mhpmevent(23).makeUInt
      val mhpmevent27   = CSRInfos.mhpmevent(24).makeUInt
      val mhpmevent28   = CSRInfos.mhpmevent(25).makeUInt
      val mhpmevent29   = CSRInfos.mhpmevent(26).makeUInt
      val mhpmevent30   = CSRInfos.mhpmevent(27).makeUInt
      val mhpmevent31   = CSRInfos.mhpmevent(28).makeUInt
      val mhpmevent3h   = if (XLEN == 32) Some(CSRInfos.mhpmeventh(0).makeUInt) else None
      val mhpmevent4h   = if (XLEN == 32) Some(CSRInfos.mhpmeventh(1).makeUInt) else None
      val mhpmevent5h   = if (XLEN == 32) Some(CSRInfos.mhpmeventh(2).makeUInt) else None
      val mhpmevent6h   = if (XLEN == 32) Some(CSRInfos.mhpmeventh(3).makeUInt) else None
      val mhpmevent7h   = if (XLEN == 32) Some(CSRInfos.mhpmeventh(4).makeUInt) else None
      val mhpmevent8h   = if (XLEN == 32) Some(CSRInfos.mhpmeventh(5).makeUInt) else None
      val mhpmevent9h   = if (XLEN == 32) Some(CSRInfos.mhpmeventh(6).makeUInt) else None
      val mhpmevent10h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(7).makeUInt) else None
      val mhpmevent11h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(8).makeUInt) else None
      val mhpmevent12h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(9).makeUInt) else None
      val mhpmevent13h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(10).makeUInt) else None
      val mhpmevent14h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(11).makeUInt) else None
      val mhpmevent15h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(12).makeUInt) else None
      val mhpmevent16h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(13).makeUInt) else None
      val mhpmevent17h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(14).makeUInt) else None
      val mhpmevent18h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(15).makeUInt) else None
      val mhpmevent19h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(16).makeUInt) else None
      val mhpmevent20h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(17).makeUInt) else None
      val mhpmevent21h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(18).makeUInt) else None
      val mhpmevent22h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(19).makeUInt) else None
      val mhpmevent23h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(20).makeUInt) else None
      val mhpmevent24h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(21).makeUInt) else None
      val mhpmevent25h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(22).makeUInt) else None
      val mhpmevent26h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(23).makeUInt) else None
      val mhpmevent27h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(24).makeUInt) else None
      val mhpmevent28h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(25).makeUInt) else None
      val mhpmevent29h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(26).makeUInt) else None
      val mhpmevent30h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(27).makeUInt) else None
      val mhpmevent31h  = if (XLEN == 32) Some(CSRInfos.mhpmeventh(28).makeUInt) else None

      val stvec      = if (config.extensions.S) Some(CSRInfos.stvec.makeUInt) else None
      val scounteren = if (config.extensions.S) Some(CSRInfos.scounteren.makeUInt) else None

      val senvcfg = if (config.extensions.S) Some(CSRInfos.senvcfg.makeUInt) else None

      val scountinhibit = if (config.extensions.S) Some(CSRInfos.scountinhibit.makeUInt) else None

      val sscratch = if (config.extensions.S) Some(CSRInfos.sscratch.makeUInt) else None
      val sepc     = if (config.extensions.S) Some(CSRInfos.sepc.makeUInt) else None
      val scause   = if (config.extensions.S) Some(CSRInfos.scause.makeUInt) else None
      val stval    = if (config.extensions.S) Some(CSRInfos.stval.makeUInt) else None

      val satp = if (config.extensions.S) Some(CSRInfos.satp.makeUInt) else None

      val stimecmp  = if (config.extensions.S) Some(CSRInfos.stimecmp.makeUInt) else None
      val stimecmph = if (config.extensions.S && XLEN == 32) Some(CSRInfos.stimecmph.makeUInt) else None
    })))
    else None

  val check = Module(new CheckerWithWB(enableReg, singleInstMode))

  check.io.instCommit := commit
  check.io.writeback  := writeback
  if (config.formal.checkMem) { check.io.mem.get := mem.get }
  if (config.formal.checkCSRs) {
    check.io.privilege.mode := mode.get

    check.io.privilege.csr.mvendorid  := csr.get.mvendorid
    check.io.privilege.csr.marchid    := csr.get.marchid
    check.io.privilege.csr.mimpid     := csr.get.mimpid
    check.io.privilege.csr.mhartid    := csr.get.mhartid
    check.io.privilege.csr.mconfigptr := csr.get.mconfigptr

    check.io.privilege.csr.mstatus    := csr.get.mstatus
    check.io.privilege.csr.misa       := csr.get.misa
    check.io.privilege.csr.medeleg    := csr.get.medeleg.getOrElse(0.U)
    check.io.privilege.csr.mideleg    := csr.get.mideleg.getOrElse(0.U)
    check.io.privilege.csr.mie        := csr.get.mie
    check.io.privilege.csr.mtvec      := csr.get.mtvec
    check.io.privilege.csr.mcounteren := csr.get.mcounteren.getOrElse(0.U)
    check.io.privilege.csr.mstatush   := csr.get.mstatush.getOrElse(0.U)
    check.io.privilege.csr.medelegh   := csr.get.medelegh.getOrElse(0.U)

    check.io.privilege.csr.mscratch := csr.get.mscratch
    check.io.privilege.csr.mepc     := csr.get.mepc
    check.io.privilege.csr.mcause   := csr.get.mcause
    check.io.privilege.csr.mip      := csr.get.mip
    check.io.privilege.csr.mtval    := csr.get.mtval

    check.io.privilege.csr.menvcfg  := csr.get.menvcfg.getOrElse(0.U)
    check.io.privilege.csr.menvcfgh := csr.get.menvcfgh.getOrElse(0.U)
    check.io.privilege.csr.mseccfg  := csr.get.mseccfg
    check.io.privilege.csr.mseccfgh := csr.get.mseccfgh.getOrElse(0.U)

    check.io.privilege.csr.pmpcfg(0)   := csr.get.pmpcfg0
    check.io.privilege.csr.pmpcfg(1)   := csr.get.pmpcfg1
    check.io.privilege.csr.pmpcfg(2)   := csr.get.pmpcfg2
    check.io.privilege.csr.pmpcfg(3)   := csr.get.pmpcfg3
    check.io.privilege.csr.pmpcfg(4)   := csr.get.pmpcfg4
    check.io.privilege.csr.pmpcfg(5)   := csr.get.pmpcfg5
    check.io.privilege.csr.pmpcfg(6)   := csr.get.pmpcfg6
    check.io.privilege.csr.pmpcfg(7)   := csr.get.pmpcfg7
    check.io.privilege.csr.pmpcfg(8)   := csr.get.pmpcfg8
    check.io.privilege.csr.pmpcfg(9)   := csr.get.pmpcfg9
    check.io.privilege.csr.pmpcfg(10)  := csr.get.pmpcfg10
    check.io.privilege.csr.pmpcfg(11)  := csr.get.pmpcfg11
    check.io.privilege.csr.pmpcfg(12)  := csr.get.pmpcfg12
    check.io.privilege.csr.pmpcfg(13)  := csr.get.pmpcfg13
    check.io.privilege.csr.pmpcfg(14)  := csr.get.pmpcfg14
    check.io.privilege.csr.pmpcfg(15)  := csr.get.pmpcfg15
    check.io.privilege.csr.pmpaddr(0)  := csr.get.pmpaddr0
    check.io.privilege.csr.pmpaddr(1)  := csr.get.pmpaddr1
    check.io.privilege.csr.pmpaddr(2)  := csr.get.pmpaddr2
    check.io.privilege.csr.pmpaddr(3)  := csr.get.pmpaddr3
    check.io.privilege.csr.pmpaddr(4)  := csr.get.pmpaddr4
    check.io.privilege.csr.pmpaddr(5)  := csr.get.pmpaddr5
    check.io.privilege.csr.pmpaddr(6)  := csr.get.pmpaddr6
    check.io.privilege.csr.pmpaddr(7)  := csr.get.pmpaddr7
    check.io.privilege.csr.pmpaddr(8)  := csr.get.pmpaddr8
    check.io.privilege.csr.pmpaddr(9)  := csr.get.pmpaddr9
    check.io.privilege.csr.pmpaddr(10) := csr.get.pmpaddr10
    check.io.privilege.csr.pmpaddr(11) := csr.get.pmpaddr11
    check.io.privilege.csr.pmpaddr(12) := csr.get.pmpaddr12
    check.io.privilege.csr.pmpaddr(13) := csr.get.pmpaddr13
    check.io.privilege.csr.pmpaddr(14) := csr.get.pmpaddr14
    check.io.privilege.csr.pmpaddr(15) := csr.get.pmpaddr15
    check.io.privilege.csr.pmpaddr(16) := csr.get.pmpaddr16
    check.io.privilege.csr.pmpaddr(17) := csr.get.pmpaddr17
    check.io.privilege.csr.pmpaddr(18) := csr.get.pmpaddr18
    check.io.privilege.csr.pmpaddr(19) := csr.get.pmpaddr19
    check.io.privilege.csr.pmpaddr(20) := csr.get.pmpaddr20
    check.io.privilege.csr.pmpaddr(21) := csr.get.pmpaddr21
    check.io.privilege.csr.pmpaddr(22) := csr.get.pmpaddr22
    check.io.privilege.csr.pmpaddr(23) := csr.get.pmpaddr23
    check.io.privilege.csr.pmpaddr(24) := csr.get.pmpaddr24
    check.io.privilege.csr.pmpaddr(25) := csr.get.pmpaddr25
    check.io.privilege.csr.pmpaddr(26) := csr.get.pmpaddr26
    check.io.privilege.csr.pmpaddr(27) := csr.get.pmpaddr27
    check.io.privilege.csr.pmpaddr(28) := csr.get.pmpaddr28
    check.io.privilege.csr.pmpaddr(29) := csr.get.pmpaddr29
    check.io.privilege.csr.pmpaddr(30) := csr.get.pmpaddr30
    check.io.privilege.csr.pmpaddr(31) := csr.get.pmpaddr31
    check.io.privilege.csr.pmpaddr(32) := csr.get.pmpaddr32
    check.io.privilege.csr.pmpaddr(33) := csr.get.pmpaddr33
    check.io.privilege.csr.pmpaddr(34) := csr.get.pmpaddr34
    check.io.privilege.csr.pmpaddr(35) := csr.get.pmpaddr35
    check.io.privilege.csr.pmpaddr(36) := csr.get.pmpaddr36
    check.io.privilege.csr.pmpaddr(37) := csr.get.pmpaddr37
    check.io.privilege.csr.pmpaddr(38) := csr.get.pmpaddr38
    check.io.privilege.csr.pmpaddr(39) := csr.get.pmpaddr39
    check.io.privilege.csr.pmpaddr(40) := csr.get.pmpaddr40
    check.io.privilege.csr.pmpaddr(41) := csr.get.pmpaddr41
    check.io.privilege.csr.pmpaddr(42) := csr.get.pmpaddr42
    check.io.privilege.csr.pmpaddr(43) := csr.get.pmpaddr43
    check.io.privilege.csr.pmpaddr(44) := csr.get.pmpaddr44
    check.io.privilege.csr.pmpaddr(45) := csr.get.pmpaddr45
    check.io.privilege.csr.pmpaddr(46) := csr.get.pmpaddr46
    check.io.privilege.csr.pmpaddr(47) := csr.get.pmpaddr47
    check.io.privilege.csr.pmpaddr(48) := csr.get.pmpaddr48
    check.io.privilege.csr.pmpaddr(49) := csr.get.pmpaddr49
    check.io.privilege.csr.pmpaddr(50) := csr.get.pmpaddr50
    check.io.privilege.csr.pmpaddr(51) := csr.get.pmpaddr51
    check.io.privilege.csr.pmpaddr(52) := csr.get.pmpaddr52
    check.io.privilege.csr.pmpaddr(53) := csr.get.pmpaddr53
    check.io.privilege.csr.pmpaddr(54) := csr.get.pmpaddr54
    check.io.privilege.csr.pmpaddr(55) := csr.get.pmpaddr55
    check.io.privilege.csr.pmpaddr(56) := csr.get.pmpaddr56
    check.io.privilege.csr.pmpaddr(57) := csr.get.pmpaddr57
    check.io.privilege.csr.pmpaddr(58) := csr.get.pmpaddr58
    check.io.privilege.csr.pmpaddr(59) := csr.get.pmpaddr59
    check.io.privilege.csr.pmpaddr(60) := csr.get.pmpaddr60
    check.io.privilege.csr.pmpaddr(61) := csr.get.pmpaddr61
    check.io.privilege.csr.pmpaddr(62) := csr.get.pmpaddr62
    check.io.privilege.csr.pmpaddr(63) := csr.get.pmpaddr63

    check.io.privilege.csr.mcycle           := csr.get.mcycle
    check.io.privilege.csr.minstret         := csr.get.minstret
    check.io.privilege.csr.mhpmcounter(0)   := csr.get.mhpmcounter3
    check.io.privilege.csr.mhpmcounter(1)   := csr.get.mhpmcounter4
    check.io.privilege.csr.mhpmcounter(2)   := csr.get.mhpmcounter5
    check.io.privilege.csr.mhpmcounter(3)   := csr.get.mhpmcounter6
    check.io.privilege.csr.mhpmcounter(4)   := csr.get.mhpmcounter7
    check.io.privilege.csr.mhpmcounter(5)   := csr.get.mhpmcounter8
    check.io.privilege.csr.mhpmcounter(6)   := csr.get.mhpmcounter9
    check.io.privilege.csr.mhpmcounter(7)   := csr.get.mhpmcounter10
    check.io.privilege.csr.mhpmcounter(8)   := csr.get.mhpmcounter11
    check.io.privilege.csr.mhpmcounter(9)   := csr.get.mhpmcounter12
    check.io.privilege.csr.mhpmcounter(10)  := csr.get.mhpmcounter13
    check.io.privilege.csr.mhpmcounter(11)  := csr.get.mhpmcounter14
    check.io.privilege.csr.mhpmcounter(12)  := csr.get.mhpmcounter15
    check.io.privilege.csr.mhpmcounter(13)  := csr.get.mhpmcounter16
    check.io.privilege.csr.mhpmcounter(14)  := csr.get.mhpmcounter17
    check.io.privilege.csr.mhpmcounter(15)  := csr.get.mhpmcounter18
    check.io.privilege.csr.mhpmcounter(16)  := csr.get.mhpmcounter19
    check.io.privilege.csr.mhpmcounter(17)  := csr.get.mhpmcounter20
    check.io.privilege.csr.mhpmcounter(18)  := csr.get.mhpmcounter21
    check.io.privilege.csr.mhpmcounter(19)  := csr.get.mhpmcounter22
    check.io.privilege.csr.mhpmcounter(20)  := csr.get.mhpmcounter23
    check.io.privilege.csr.mhpmcounter(21)  := csr.get.mhpmcounter24
    check.io.privilege.csr.mhpmcounter(22)  := csr.get.mhpmcounter25
    check.io.privilege.csr.mhpmcounter(23)  := csr.get.mhpmcounter26
    check.io.privilege.csr.mhpmcounter(24)  := csr.get.mhpmcounter27
    check.io.privilege.csr.mhpmcounter(25)  := csr.get.mhpmcounter28
    check.io.privilege.csr.mhpmcounter(26)  := csr.get.mhpmcounter29
    check.io.privilege.csr.mhpmcounter(27)  := csr.get.mhpmcounter30
    check.io.privilege.csr.mhpmcounter(28)  := csr.get.mhpmcounter31
    check.io.privilege.csr.mcycleh          := csr.get.mcycleh.getOrElse(0.U)
    check.io.privilege.csr.minstreth        := csr.get.minstreth.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(0)  := csr.get.mhpmcounter3h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(1)  := csr.get.mhpmcounter4h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(2)  := csr.get.mhpmcounter5h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(3)  := csr.get.mhpmcounter6h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(4)  := csr.get.mhpmcounter7h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(5)  := csr.get.mhpmcounter8h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(6)  := csr.get.mhpmcounter9h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(7)  := csr.get.mhpmcounter10h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(8)  := csr.get.mhpmcounter11h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(9)  := csr.get.mhpmcounter12h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(10) := csr.get.mhpmcounter13h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(11) := csr.get.mhpmcounter14h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(12) := csr.get.mhpmcounter15h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(13) := csr.get.mhpmcounter16h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(14) := csr.get.mhpmcounter17h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(15) := csr.get.mhpmcounter18h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(16) := csr.get.mhpmcounter19h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(17) := csr.get.mhpmcounter20h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(18) := csr.get.mhpmcounter21h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(19) := csr.get.mhpmcounter22h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(20) := csr.get.mhpmcounter23h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(21) := csr.get.mhpmcounter24h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(22) := csr.get.mhpmcounter25h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(23) := csr.get.mhpmcounter26h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(24) := csr.get.mhpmcounter27h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(25) := csr.get.mhpmcounter28h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(26) := csr.get.mhpmcounter29h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(27) := csr.get.mhpmcounter30h.getOrElse(0.U)
    check.io.privilege.csr.mhpmcounterh(28) := csr.get.mhpmcounter31h.getOrElse(0.U)

    check.io.privilege.csr.mcountinhibit  := csr.get.mcountinhibit
    check.io.privilege.csr.mhpmevent(0)   := csr.get.mhpmevent3
    check.io.privilege.csr.mhpmevent(1)   := csr.get.mhpmevent4
    check.io.privilege.csr.mhpmevent(2)   := csr.get.mhpmevent5
    check.io.privilege.csr.mhpmevent(3)   := csr.get.mhpmevent6
    check.io.privilege.csr.mhpmevent(4)   := csr.get.mhpmevent7
    check.io.privilege.csr.mhpmevent(5)   := csr.get.mhpmevent8
    check.io.privilege.csr.mhpmevent(6)   := csr.get.mhpmevent9
    check.io.privilege.csr.mhpmevent(7)   := csr.get.mhpmevent10
    check.io.privilege.csr.mhpmevent(8)   := csr.get.mhpmevent11
    check.io.privilege.csr.mhpmevent(9)   := csr.get.mhpmevent12
    check.io.privilege.csr.mhpmevent(10)  := csr.get.mhpmevent13
    check.io.privilege.csr.mhpmevent(11)  := csr.get.mhpmevent14
    check.io.privilege.csr.mhpmevent(12)  := csr.get.mhpmevent15
    check.io.privilege.csr.mhpmevent(13)  := csr.get.mhpmevent16
    check.io.privilege.csr.mhpmevent(14)  := csr.get.mhpmevent17
    check.io.privilege.csr.mhpmevent(15)  := csr.get.mhpmevent18
    check.io.privilege.csr.mhpmevent(16)  := csr.get.mhpmevent19
    check.io.privilege.csr.mhpmevent(17)  := csr.get.mhpmevent20
    check.io.privilege.csr.mhpmevent(18)  := csr.get.mhpmevent21
    check.io.privilege.csr.mhpmevent(19)  := csr.get.mhpmevent22
    check.io.privilege.csr.mhpmevent(20)  := csr.get.mhpmevent23
    check.io.privilege.csr.mhpmevent(21)  := csr.get.mhpmevent24
    check.io.privilege.csr.mhpmevent(22)  := csr.get.mhpmevent25
    check.io.privilege.csr.mhpmevent(23)  := csr.get.mhpmevent26
    check.io.privilege.csr.mhpmevent(24)  := csr.get.mhpmevent27
    check.io.privilege.csr.mhpmevent(25)  := csr.get.mhpmevent28
    check.io.privilege.csr.mhpmevent(26)  := csr.get.mhpmevent29
    check.io.privilege.csr.mhpmevent(27)  := csr.get.mhpmevent30
    check.io.privilege.csr.mhpmevent(28)  := csr.get.mhpmevent31
    check.io.privilege.csr.mhpmeventh(0)  := csr.get.mhpmevent3h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(1)  := csr.get.mhpmevent4h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(2)  := csr.get.mhpmevent5h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(3)  := csr.get.mhpmevent6h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(4)  := csr.get.mhpmevent7h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(5)  := csr.get.mhpmevent8h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(6)  := csr.get.mhpmevent9h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(7)  := csr.get.mhpmevent10h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(8)  := csr.get.mhpmevent11h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(9)  := csr.get.mhpmevent12h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(10) := csr.get.mhpmevent13h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(11) := csr.get.mhpmevent14h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(12) := csr.get.mhpmevent15h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(13) := csr.get.mhpmevent16h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(14) := csr.get.mhpmevent17h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(15) := csr.get.mhpmevent18h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(16) := csr.get.mhpmevent19h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(17) := csr.get.mhpmevent20h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(18) := csr.get.mhpmevent21h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(19) := csr.get.mhpmevent22h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(20) := csr.get.mhpmevent23h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(21) := csr.get.mhpmevent24h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(22) := csr.get.mhpmevent25h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(23) := csr.get.mhpmevent26h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(24) := csr.get.mhpmevent27h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(25) := csr.get.mhpmevent28h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(26) := csr.get.mhpmevent29h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(27) := csr.get.mhpmevent30h.getOrElse(0.U)
    check.io.privilege.csr.mhpmeventh(28) := csr.get.mhpmevent31h.getOrElse(0.U)

    check.io.privilege.csr.stvec      := csr.get.stvec.getOrElse(0.U)
    check.io.privilege.csr.scounteren := csr.get.scounteren.getOrElse(0.U)

    check.io.privilege.csr.senvcfg := csr.get.senvcfg.getOrElse(0.U)

    check.io.privilege.csr.scountinhibit := csr.get.scountinhibit.getOrElse(0.U)

    check.io.privilege.csr.sscratch := csr.get.sscratch.getOrElse(0.U)
    check.io.privilege.csr.sepc     := csr.get.sepc.getOrElse(0.U)
    check.io.privilege.csr.scause   := csr.get.scause.getOrElse(0.U)
    check.io.privilege.csr.stval    := csr.get.stval.getOrElse(0.U)

    check.io.privilege.csr.satp := csr.get.satp.getOrElse(0.U)

    check.io.privilege.csr.stimecmp  := csr.get.stimecmp.getOrElse(0.U)
    check.io.privilege.csr.stimecmph := csr.get.stimecmph.getOrElse(0.U)
  } else {
    check.io.privilege.mode := PrivilegeLevel.Machine.asUInt
    check.io.privilege.csr  := CSR.wireInit()
  }

}

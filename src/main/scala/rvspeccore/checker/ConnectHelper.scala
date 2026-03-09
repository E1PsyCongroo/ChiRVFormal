package rvspeccore.checker

import chisel3._
import chisel3.util._
import chisel3.util.experimental.BoringUtils
import rvspeccore.core._
import rvspeccore.core.tool._
import rvspeccore.core.spec.instset.csr._

object ConnectHelper {
  object UniqueId {
    val uniqueIdReg: String   = "ConnectChecker_UniqueIdReg"
    val uniqueIdMem: String   = "ConnectChecker_UniqueIdMem"
    val uniqueIdCSR: String   = "ConnectChecker_UniqueIdCSR"
    val uniqueIdEvent: String = "ConnectChecker_UniqueIdEvent"
    val uniqueIdITLB: String  = "ConnectChecker_UniqueIdITLB"
    val uniqueIdDTLB: String  = "ConnectChecker_UniqueIdDTLB"
  }
  import UniqueId._

  def regNextDelay[T <: Bundle](signal: T, delay: Int): T = {
    delay match {
      case 0 => signal
      case _ => regNextDelay(RegNext(signal), delay - 1)
    }
  }

  def setRegSource(regVec: Vec[UInt]) = {
    BoringUtils.addSource(regVec, uniqueIdReg)
  }

  class MemOneSig()(implicit XLEN: Int) extends Bundle {
    val valid    = Bool()
    val addr     = UInt(XLEN.W)
    val memWidth = UInt(log2Ceil(XLEN + 1).W)
    val data     = UInt(XLEN.W)
  }

  class MemSig()(implicit XLEN: Int) extends Bundle {
    val read  = new MemOneSig
    val write = new MemOneSig
  }
  object MemSig {
    def apply()(implicit XLEN: Int) = new MemSig
  }

  def makeMemSource()(implicit XLEN: Int): MemSig = {
    val mem = Wire(new MemSig)

    mem.read.valid     := false.B
    mem.read.addr      := 0.U
    mem.read.data      := 0.U
    mem.read.memWidth  := 0.U
    mem.write.valid    := false.B
    mem.write.addr     := 0.U
    mem.write.data     := 0.U
    mem.write.memWidth := 0.U

    BoringUtils.addSource(mem, uniqueIdMem)

    mem
  }

  def makeCSRSource()(implicit XLEN: Int, config: RVConfig): CSR = {
    val csr = CSR.wireInit()
    BoringUtils.addSource(csr, uniqueIdCSR)
    csr
  }

  def makeTLBSource(isDTLB: Boolean)(implicit XLEN: Int): TLBSig = {
    val tlbmem = WireInit(0.U.asTypeOf(TLBSig()))
    BoringUtils.addSource(tlbmem, if (isDTLB) uniqueIdDTLB else uniqueIdITLB)
    tlbmem
  }

  def setChecker(
      checker: CheckerWithState,
      memDelay: Int
  )(implicit XLEN: Int, config: RVConfig) = {
    // pc
    checker.io.state.pc := checker.io.instCommit.pc

    // reg
    if (config.formal.arbitraryRegFile) ArbitraryRegFile.init

    val regVec = Wire(Vec(32, UInt(XLEN.W)))
    regVec := DontCare
    BoringUtils.addSink(regVec, uniqueIdReg)
    checker.io.state.reg := regVec

    // csr
    val csr = Wire(CSR())
    csr := DontCare
    BoringUtils.addSink(csr, uniqueIdCSR)
    checker.io.state.privilege.csr  := csr
    checker.io.state.privilege.mode := DontCare

    if (config.formal.checkMem) {
      val mem = Wire(MemSig())
      mem := DontCare
      BoringUtils.addSink(mem, uniqueIdMem)
      checker.io.mem.get := regNextDelay(mem, memDelay)
      if (config.functions.tlb) {
        val dtlbmem = Wire(TLBSig())
        val itlbmem = Wire(TLBSig())
        dtlbmem := DontCare
        itlbmem := DontCare
        BoringUtils.addSink(dtlbmem, uniqueIdDTLB)
        BoringUtils.addSink(itlbmem, uniqueIdITLB)
        checker.io.dtlbmem.get := dtlbmem
        checker.io.itlbmem.get := itlbmem
      }
    }
  }
  def setChecker(checker: CheckerWithState)(implicit XLEN: Int, config: RVConfig): Unit = setChecker(checker, 0)

  def setChecker(
      checker: CheckerWithWB,
      memDelay: Int
  )(implicit XLEN: Int, config: RVConfig) = {
    // init
    val privilege = PrivilegedState.wireInit()
    checker.io.privilege := privilege

    // csr
    val csr = Wire(CSR())
    csr := DontCare
    BoringUtils.addSink(csr, uniqueIdCSR)
    checker.io.privilege.csr := csr

    // mem
    if (config.formal.checkMem) {
      val mem = Wire(MemSig())
      mem := DontCare
      BoringUtils.addSink(mem, uniqueIdMem)
      checker.io.mem.get := regNextDelay(mem, memDelay)
      if (config.functions.tlb) {
        val dtlbmem = Wire(TLBSig())
        val itlbmem = Wire(TLBSig())
        dtlbmem := DontCare
        itlbmem := DontCare
        BoringUtils.addSink(dtlbmem, uniqueIdDTLB)
        BoringUtils.addSink(itlbmem, uniqueIdITLB)
        checker.io.dtlbmem.get := dtlbmem
        checker.io.itlbmem.get := itlbmem
      }
    }
  }
  def setChecker(checker: CheckerWithWB)(implicit XLEN: Int, config: RVConfig): Unit = setChecker(checker, 0)

}

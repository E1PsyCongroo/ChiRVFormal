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

  // val clock     = IO(Input(Clock()))
  // val reset     = IO(Input(Reset()))
  val commit    = IO(Input(InstCommit()))
  val writeback = IO(Input(WriteBack()))
  val mem       = if (config.formal.checkMem) Some(IO(Input(MemIO()))) else None
  val mode      = if (config.formal.checkCSRs) Some(IO(Input(UInt(2.W)))) else None
  val csr       = if (config.formal.checkCSRs) Some(IO(Input(CSR()))) else None

  val check = Module(new CheckerWithWB(enableReg, singleInstMode))

  check.io.instCommit := commit
  check.io.wb         := writeback
  if (config.formal.checkMem) { check.io.mem.get := mem.get }
  if (config.formal.checkCSRs) {
    check.io.privilege.internal.privilegeMode := mode.get
    check.io.privilege.csr                    := csr.get
  } else {
    check.io.privilege.internal.privilegeMode := 3.U
    check.io.privilege.csr                    := CSR.wireInit()
  }

}

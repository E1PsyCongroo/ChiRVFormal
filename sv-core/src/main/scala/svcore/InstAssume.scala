package svcore

import chisel3._
import chisel3.util._
import chisel3.experimental._
import rvspeccore.core._
import rvspeccore.checker._

class CombAssume extends ExtModule with HasExtModuleInline {
  val cond = IO(Input(Bool()))
  setInline(
    "CombAssume.sv",
    """module CombAssume(
      |    input  cond
      |);
      |always @* begin
      |    assume(cond);
      |end
      |endmodule
    """.stripMargin
  )
}

class InstAssume(implicit config: RVConfig) extends RawModule {
  implicit val XLEN: Int = config.XLEN

  val valid      = IO(Input(Bool()))
  val inst       = IO(Input(UInt(config.XLEN.W)))
  val combAssume = Module(new CombAssume)

  val cond = WireDefault(true.B)

  when(valid) {
    // change here to add more instructions to be assumed
    cond := RVI.regImm(inst) ||
      RVI.regReg(inst) ||
      RVI.control(inst) ||
      RVI.loadStore(inst) ||
      RVC(inst)
  }

  combAssume.cond := cond
}

package svcore

import scala.io.Source
import scala.util.Try
import upickle.default._
import upickle.core.Abort
import rvspeccore.core.RVConfig

case class Extensions(value: Either[String, Seq[String]])

object Extensions {
  private def normalize(seq: Seq[String]): Seq[String] = seq.filter(_.nonEmpty).distinct

  implicit val rw: ReadWriter[Extensions] = {
    readwriter[ujson.Value].bimap[Extensions](
      {
        case Extensions(Left(s))    => ujson.Str(s)
        case Extensions(Right(seq)) => ujson.Arr.from(normalize(seq).map(ujson.Str(_)))
      },
      {
        case ujson.Str(s) => Extensions(Left(s))
        case ujson.Arr(arr) =>
          Extensions(Right(normalize(arr.map {
            case ujson.Str(s) => s
            case other =>
              throw Abort(s"expected array of strings, found element ${other.getClass().getSimpleName()}($other)")
          })))
        case other =>
          throw Abort(s"expected string | array[string] | null, got ${other.getClass.getSimpleName()}($other)")
      }
    )
  }
}

case class RefConfig(
    xlen: Int,
    extensions: Extensions = Extensions(Right(Seq.empty)),
    fakeExtensions: Extensions = Extensions(Right(Seq.empty)),
    initValue: Map[String, String] = Map.empty,
    functions: Seq[String] = Seq.empty,
    formal: Seq[String] = Seq.empty,
    regDelay: Boolean = true,
    singleInstMode: Option[String] = None
) {
  def toRVConfig: RVConfig = {
    RVConfig(
      XLEN = xlen,
      extensions = extensions.value.fold(identity, _.mkString("")),
      fakeExtensions = fakeExtensions.value.fold(identity, _.mkString("")),
      initValue = initValue,
      functions = functions,
      formal = formal
    )
  }
}

object RefConfig {
  private val baseRW: ReadWriter[RefConfig] = macroRW

  implicit val rw: ReadWriter[RefConfig] = {
    readwriter[ujson.Value].bimap[RefConfig](
      (rc: RefConfig) => writeJs(rc)(baseRW),
      {
        case obj: ujson.Obj =>
          obj.value.foreach {
            case ("singleInstMode", _) => None
            case (key, ujson.Null)     => throw Abort(s"field '$key' must not be null")
            case _                     =>
          }
          read[RefConfig](obj)(baseRW)
        case other =>
          throw Abort(s"expected JSON object, got ${other.getClass().getSimpleName()}($other)")
      }
    )
  }
}

object JsonTool {
  def readConfigFromFile(filePath: String): Try[RefConfig] = Try {
    val source = Source.fromFile(filePath)
    try source.mkString
    finally source.close()
  }.flatMap(json => Try(read[RefConfig](ujson.read(json))))
}

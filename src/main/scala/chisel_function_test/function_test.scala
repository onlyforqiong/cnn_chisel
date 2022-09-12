package cnn


import chisel3._
import chisel3.stage.ChiselStage
import chisel3.experimental._
import chisel3.util._
import firrtl.PrimOps
import scala.math._
import scala.reflect.runtime.Macros
import chisel3.experimental.FixedPoint
class Myemp(length: Int) extends Module {
  val io = IO(new Bundle {
   val in = Input(UInt(8.W))
   val valid = Input(Bool())
   val out = Output(UInt(8.W))
   val consts = Input(Vec(length, UInt(8.W)))
  })
  val taps = Seq(io.in) ++ Seq.fill(length - 1)(RegInit(0.U(8.W)))
  taps.zip(taps.tail).foreach { case (a, b) => when (io.valid) { b := a } }
  io.out := taps.zip(io.consts).map { case (a, b) => a * b }.reduce(_ + _)
 }

 class Mul_Matrix (width:Int,length:Int) extends Module with basic_macro{
  val io = IO(new Bundle {
    val in = Input(new matrix_bundle(width,length))//Input(Vec(length * length,(FixedPoint(fixpoint_num_length.W,BinaryPoint_place.BP))))
    val valid = Input(Bool())
    val out = Output(FixedPoint(fixpoint_num_length.W,BinaryPoint_place.BP))
    val consts = Input(new matrix_bundle(width,length))//Input(Vec(length * length, (FixedPoint(fixpoint_num_length.W,BinaryPoint_place.BP))))
  })
  io.out := Mux(io.valid,Matrix_Mul(io.in,io.consts),0.F(fixpoint_num_length.W,BinaryPoint_place.BP))
  
  // val test_mul = Module(new )

 }

 object chisel_func_test extends App{
    (new ChiselStage).emitVerilog(new Mul_Matrix(3,3))
}

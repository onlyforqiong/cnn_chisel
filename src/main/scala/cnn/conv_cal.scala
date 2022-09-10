package cnn

import chisel3._
import chisel3.stage.ChiselStage
import chisel3.experimental._
import chisel3.util._
import firrtl.PrimOps
import scala.math._
import scala.reflect.runtime.Macros
import chisel3.experimental.FixedPoint

class conv_cal(width : Int,length : Int,cnn_kernel_width:Int,channel:Int) extends Module  with basic_macro {
    val io = IO(new Bundle {
        val data_in = Input(UInt(data_interface_length.W))
        val data_valid = Input(Bool())
        val conv_start = Input(Bool())
        val data_out = Output(UInt(data_interface_length.W))
    })
    // val Mul


}

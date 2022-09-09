package cnn

import chisel3._
import chisel3.stage.ChiselStage
import chisel3.util._
import firrtl.PrimOps
import scala.math._
import scala.reflect.runtime.Macros



trait basic_macro  {

    val fixpoint_num_length = 16
    class matrix_bundle(width:Int , length:Int) extends Bundle {
        val matrix_port = Vec(width * length,Input(SInt(fixpoint_num_length.W)))
        // conv_port.toSeq
    }
    //乘法只用得到其中的一些位宽
    //定点的有符号数
    def fixpoint_mul(a :SInt,b: SInt) : SInt = {
        (a * b)(a.getWidth -1 ,0).asSInt
    } 
    def fixpoint_div(a :SInt,b: SInt) : SInt = {
        (a / b)(a.getWidth -1 ,0).asSInt
    }
    def fixpoint_add(a :SInt,b: SInt) : SInt = {
        (a + b)
    }
    def fixpoint_sub(a :SInt,b: SInt) : SInt = {
        (a - b)
    }
    def fixpoint_relu(a :SInt) : SInt = {
        Mux(a(a.getWidth - 1),0.asSInt,a)
    }
    def Matrix_Mul(data:matrix_bundle,const : matrix_bundle) : SInt = {
        val mul_data = data.matrix_port.zip(const.matrix_port).
    }


    
}



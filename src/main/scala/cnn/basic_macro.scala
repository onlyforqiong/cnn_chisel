package cnn

import chisel3._
import chisel3.stage.ChiselStage
import chisel3.experimental._
import chisel3.util._
import firrtl.PrimOps
import scala.math._
import scala.reflect.runtime.Macros
import chisel3.experimental.FixedPoint



trait basic_macro  {

    val fixpoint_num_length = 16
    val BinaryPoint_place = 8
    class matrix_bundle(width:Int , length:Int) extends Bundle {
        val matrix_port = Vec(width * length,(FixedPoint(fixpoint_num_length.W,BinaryPoint_place.BP)))
        //                                                                                         .toSeq
    }

    def fixpoint_relu(a :FixedPoint) : FixedPoint = {
        Mux(a < 0.F(fixpoint_num_length.W,BinaryPoint_place.BP),0.F(fixpoint_num_length.W,BinaryPoint_place.BP),a)
    }
    def List_Cal(a:Seq[FixedPoint],op:(FixedPoint,FixedPoint) => FixedPoint,start:Int,end:Int) : FixedPoint = {
        if(start == end) {
            RegNext(a(start))
        }else if(start == (end - 1)) {
            RegNext(op(a(start),a(end)))
        }else{
            RegNext(op(List_Cal(a,op,start,((end + start)/ 2 - 1)) , List_Cal(a,op,(start + end)/2,end)))
        }
    }
    def Matrix_Mul(data:matrix_bundle,const : matrix_bundle) : FixedPoint = {
        val mul_data_reg  = Seq.fill(const.matrix_port.length)(RegInit(0.F(fixpoint_num_length.W,BinaryPoint_place.BP)))
        data.matrix_port.zip(const.matrix_port).zipWithIndex.foreach{case((a,b),index) =>
            mul_data_reg(index) := a * b//0.F(fixpoint_num_length.W,BinaryPoint_place.BP)
        }
        val fixpoint_add  = (x:FixedPoint , y:FixedPoint) => x + y
        // val 
        List_Cal(mul_data_reg,fixpoint_add,0,mul_data_reg.length - 1)
    }
  
}



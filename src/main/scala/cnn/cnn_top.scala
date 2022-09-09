package cnn

import chisel3._
import chisel3.stage._
import chisel3.util._

class cnn_top extends Module  {
        
    val io = IO(new Bundle { 

        val ctrl  = Input(UInt(24.W)) // 使用独热码来进行控制

        val in1   = Input(UInt(32.W))
        val in2   = Input(UInt(32.W))

        val result = Output(UInt(32.W))
        val overflow = Output(UInt(1.W))

    })
    
}

object cnn_top_test extends App{
    (new ChiselStage).emitVerilog(new cnn_top)
}


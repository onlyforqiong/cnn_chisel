/*************************************************************************
	> File Name: light.cpp
	> Author: amoscykl
	> Mail: amoscykl@163.com 
	> Created Time: 2022年03月16日 星期三 00时25分07秒
 ************************************************************************/
#define Vtop VMul_Matrix

#include<iostream>
#include<fixed_point.h>
// #include<nvboard.h>
//#include<Vlight.h>
#include<VMul_Matrix.h>
#include<verilated.h>
#include<verilated_vcd_c.h>
// extern "C" {
#include<tensorflow/c/c_api.h>
// }

#include<bitset>

using namespace std;



const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
VerilatedVcdC* tfp = NULL;



template <class T>
void step_and_dump_wave(T *top){
	top->eval();
	contextp->timeInc(1);
	tfp->dump(contextp->time());
}
template<class T>
void sim_init(T * top) {
	tfp = new VerilatedVcdC;
	contextp->debug(0);
	contextp->randReset(2);
	contextp->traceEverOn(true);
	top->trace(tfp, 0);
	tfp->open("dump.vcd");	
}
template<class T>
void single_cycle(T * top) {
	top->clock = 1; top->eval();step_and_dump_wave(top);
	top->clock = 0; top->eval();step_and_dump_wave(top);
}

template<class T>
void reset(T *top , int n) {
	top->reset = 1;
	while(n -- > 0) single_cycle(top);
	top->reset = 0;
}
int16_t mul_const[9];
int16_t mul_in[9];

int main(int argc,char ** argv,char** env) {
	// printf("Hello from TensorFlow C library version %s\n", TF_Version());
	// printf("sbsbssbs\n");
	// cout<<"sbsbsb"<<endl;
	if(false && argc && argv && env) {}
	Verilated::mkdir("logs");
    Vtop * top = new Vtop;
	sim_init(top);
	reset(top,10);

	//初始化
	
	for(int i = 0; i < 9 ; i++){
		mul_const[i] = random() % 10 << 8;
		cout<<mul_const[i]<<endl;
	}
	
	top->io_consts_matrix_port_0 = mul_const[0];
	top->io_consts_matrix_port_1 = mul_const[1];
	top->io_consts_matrix_port_2 = mul_const[2];	
	top->io_consts_matrix_port_3 = mul_const[3];
	top->io_consts_matrix_port_4 = mul_const[4];
	top->io_consts_matrix_port_5 = mul_const[5];
	top->io_consts_matrix_port_6 = mul_const[6];
	top->io_consts_matrix_port_7 = mul_const[7];
	top->io_consts_matrix_port_8 = mul_const[8];
	
	step_and_dump_wave(top);
	top->io_valid = 1;
	
	while(1){
		int16_t answer = 0;
		for(int i = 0; i < 9 ; i++){
			mul_in[i] = i << 8;
			// cout << mul_in[i] << endl;
			answer +=  q_mul(mul_in[i] , mul_const[i]);
		}
		memcpy(&top->io_in_matrix_port_0,mul_in,sizeof(int16_t)*9);
		int16_t cal_answer = 0;
		cal_answer = top->io_out;
		
		printf("%d\n",(int16_t)answer);
		cout << cal_answer<<"   "<<answer <<endl;
		single_cycle(top);
		// printf("reset = %d\n",top->reset);
		
   }


	tfp->close();

}



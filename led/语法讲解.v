//语法讲解
//VERILOG是一个逻辑编程语言，主要用于人工智能和计算机科学领域。它的语法和结构与其他编程语言有很大的不同。
//以下是VERILOG的一些基本语法规则和结构：
//`timescale指令：用于指定时间单位和精度。仅在仿真时使用。
//`timescale 1ns/1ps
//代码注释：
//单行注释使用
//块注释使用
///* 注释内容 */
//模块定义：使用module关键字定义一个模块，模块名后面可以跟参数列表。
//module module_name (input1, input2, ...);
/*
模块定义：

module 模块名 (
 //端口列表--两种类型：wire 和 reg；
//默认wire型
//输入端口：只有wire，不会是reg型
//输出端口：可以是wire,也可以是reg，默认也是wire,按风格output时，加上wire可以。

    output              输出端口1
    output              输出端口2
    output              输出端口3

    input               输入端口1
    input               输入端口2
    input               输入端口3
) ;
// wire型的 输出 端口，使用assign赋值
// 对于输入端口，绝对不能赋值，只能使用输入端口的值
endmodule
*/

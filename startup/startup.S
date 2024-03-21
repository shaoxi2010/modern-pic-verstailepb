#include <asm/linkage.h>

.section .text.entry
ENTRY(_start)
	/* 
	 * ARM寄存器的r0-r7各模式都是共享的，故该段汇编采用以下设计
	 * 1. 使用r0-r3用于传递参数，符合apsc
	 * 2. 使用r4-r6用于内部使用
	 * 3. 使用r7用于relocate偏移地址，即entry位置，不要使用r7
	 */
	stmfd sp!, {r4-r7}  //将变化值保存在原始栈上
	/* 获取entry入口地址 */
	sub r7, pc, #12 //前面命令+4，PC是流水线取指令地址+8，所以减12

	/* 将旧栈地址保存，汇编使用是相对地址*/
	str sp, .Lstack

	/* 将dcache数据清理 */
.L_dcache_flush:
	mrc p15, 0, r15, c7, c10, 3 // test and clean D-cache
	bne .L_dcache_flush
	mov r4, #0
	mcr p15, 0, r4, c7, c7, 0 // invalidate cache

	/* 执行got偏移，执行后C变量才是正确的 */
	ldr	r5, =__got_start__
	add r5, r7
	ldr r6, =__got_end__
	add r6, r7

	subs r6, r5
	ble	.L_got_loop_done
.L_got_loop:
	subs r6, #4
	ldr r4, [r5, r6]
	add r4, r7
	str r4, [r5, r6]
	bgt	.L_got_loop
.L_got_loop_done:

#if defined(FORCE_SVC)
	/* 强制切换模式，切换后sp、lr属于svc状态 */
	mrs	r4,cpsr
	ldr r4, .Lmode
	bic	r4,#0x1f
	orr	r4,#0xd3
	msr	cpsr,r4
#endif

	/* 设置为内部栈 */
	ldr r4, =__stack__
	add sp, r7, r4 //新栈地址

	/* 清理bss段数据 */
	ldr	r5, =__bss_start__
	add r5, r7
	ldr	r6, =__bss_end__
	add r6, r7

	movs r4, #0
	subs r6, r5
	ble	.L_bss_loop_done

.L_bss_loop:
	subs r6, #4
	str	r4, [r5, r6]
	bgt	.L_bss_loop
.L_bss_loop_done:

	/* 调用主函数，内部会自动压栈 */
	bl	main

#if defined(FORCE_SVC)
	/* 恢复到之前运行的状态 */
	mrs	r4,cpsr
	ldr r5,.Lmode
	and r5,#0x7f
	bic	r4,#0x7f
	orr	r4,r5
	msr	cpsr,r4
#endif
	ldr sp, .Lstack //恢复旧栈地址
	/* 恢复之前的寄存器状态 */
	ldmfd sp!, {r4-r7}
	bx  lr

.Lstack:
	.word  0x00000000
#if defined(FORCE_SVC)
.Lmode:
	.word  0x00000000
#endif
ENDPROC(_start)

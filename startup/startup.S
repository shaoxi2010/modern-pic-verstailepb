#include <asm/linkage.h>

.section .text.entry
ENTRY(_start)
	/* save retrun address and stack */
	str lr, .Lreturn
	str sp, .Lstack
	/* get entry point */
	sub lr, pc, #16 //前面命令+8，PC是流水线取指令地址+8，所以减16
	str lr, .Lentry

#if defined(FORCE_SVC)
	/* set the cpu to SVC32 mode */
	mrs	r4,cpsr
	bic	r4,r0,#0x1f
	orr	r4,r0,#0xd3
	msr	cpsr,r4
#endif
	/* set the stack pointer */
	ldr lr, .Lentry
	ldr r4, =__stack__
	add sp, lr, r4

	/*  Single BSS section scheme.
	 *
	 *  The BSS section is specified by following symbols
	 *    __bss_start__: start of the BSS section.
	 *    __bss_end__: end of the BSS section.
	 *
	 *  Both addresses must be aligned to 4 bytes boundary.
	*/
	ldr	r5, =__bss_start__
	add r5, r5, lr
	ldr	r6, =__bss_end__
	add r6, r6, lr

	movs r4, #0
	subs r6, r5
	ble	.L_bss_loop_done

.L_bss_loop:
	subs r6, #4
	str	r4, [r5, r6]
	bgt	.L_bss_loop
.L_bss_loop_done:

	/* relocate got section */
	ldr	r5, =__got_start__
	add r5, r5, lr
	ldr r6, =__got_end__
	add r6, r6, lr

	subs r6, r5
	ble	.L_got_loop_done
.L_got_loop:
	subs r6, #4
	ldr r4, [r5, r6]
	add r4, r4, lr
	str r4, [r5, r6]
	bgt	.L_got_loop
.L_got_loop_done:

	/* call the C program */
	bl	main

	/* return to caller */
	ldr sp, .Lstack
	ldr lr, .Lreturn
	bx  lr
.Lentry:
	.word  0x00000000
.Lreturn:
	.word  0x00000000
.Lstack:
	.word  0x00000000

ENDPROC(_start)

OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm",
              "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)

SECTIONS
{
	.entry : {*(.text.entry)}
	. = ALIGN(0x800);
	__stack__ = .;
	.text : {*(.text*)}
	.rodata : {*(.rodata*)}
	.data : {*(.data*)}
	. = ALIGN(4);
	/* 变量偏移表 */
	__got_start__ = .;
	.got :{*(.got)}
	__got_end__ = .;
	. = ALIGN(4);
	.got.plt : {*(.got.plt*)}
	. = ALIGN(4);
	__bss_start__ = .;
	.bss : {*(.bss*)}
	. = ALIGN(4);
	__bss_end__ = .;
	/DISCARD/ : {
		/* ifunc */
		*(.igot.plt*)
		*(.iplt*)
		*
	}
}
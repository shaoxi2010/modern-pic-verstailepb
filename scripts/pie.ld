OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm",
              "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SEARCH_DIR("=//arm-none-eabi/lib"); SEARCH_DIR("=/usr/local/lib"); SEARCH_DIR("=/lib"); SEARCH_DIR("=/usr/lib");

SECTIONS
{
	.entry : {*(.text.entry)}
	. = ALIGN(0x800);
	__stack__ = .;
	.text : {*(.text*)}
	.rodata : {*(.rodata*)}
	.data : {*(.data*)}
	. = ALIGN(4);
	__bss_start__ = .;
	.bss : {*(.bss*)}
	. = ALIGN(4);
	__bss_end__ = .;
}
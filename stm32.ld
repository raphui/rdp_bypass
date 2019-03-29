ENTRY(start)

SECTIONS
{
	.text 0x20000000 :
	{
		*(.text)
		*(.text.*)
	}

	.rodata :
	{
		*(.rodata)
		*(.rodata1)
		*(.rodata.*)
	}

	.data :
	{
		*(.data)
		*(.data1)
		*(.data.*)
	}

	.bss :
	{
		*(.bss)
		*(.bss.*)
		*(.sbss)
		*(.sbss.*)
		*(COMMON)
	}

	PROVIDE(flash_base = 0x8000000);
	PROVIDE(dhcs = 0xE000EDF0);
	PROVIDE(pattern = 0xDEADBEEF);
	PROVIDE(rcc = 0x40021048);
	PROVIDE(dma = 0x40020000);
	_end = . ;
}

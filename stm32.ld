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

	_end = . ;
	PROVIDE(flash_base = 0x8000000);
	PROVIDE(dhcs = 0xE000EDF0);
}

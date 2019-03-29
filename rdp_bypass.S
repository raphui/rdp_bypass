.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.word _end
.word flash_base
.word dhcs

.global start
start:
	ldr r0, =dhcs
	ldr r0, [r0]
	and r0, r0, #1
#	cmp r0, #1
#	beq start

	bl dma_transfer
	b end

#	ldr r0, =flash_base
#	ldr r1, =_end
#	mov r2, #0x800
#loop:
#	ldr r3, [r0]
#	cmp r2, #0
#	beq end
#	str r3, [r1]
#	add r0, r0, #4
#	add r1, r1, #4
#	sub r2, r2, #4
#	b loop
end:
	b end

.size start, .-start

.global dma_transfer
dma_transfer:
	# enable DMA1 bit in RCC
	ldr r0, =rcc
	ldr r1, [r0]
	orr r1, r1, #1
	str r1, [r0]

	# configure DMA1 Channel 1 NDTR
	ldr r0, =dma
	mov r2, #0x800
	str r2, [r0, #0xC]

	# configure DMA1 Channel 1 CPAR
	ldr r0, =dma
	ldr r1, =flash_base
	str r1, [r0, #0x10]

	# configure DMA1 Channel 1 CMAR
	ldr r0, =dma
	ldr r1, =_end
	str r1, [r0, #0x14]

	# configure DMA1 Channel 1 CCR
	ldr r0, =dma
	ldr r1, [r0, #0x8]

	#MEM2MEM
	orr r1, r1, #0x4000

	#MSIZE
	orr r1, r1, #0x800

	#PSIZE
	orr r1, r1, #0x200

	#MINC
	orr r1, r1, #0x80

	#PINC
	orr r1, r1, #0x40

	#EN
	orr r1, r1, #0x1
	str r1, [r0, #0x8]
	bx lr

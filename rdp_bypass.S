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
	and r0, r0, #1
	cmp r0, #1
	beq start

	ldr r0, =flash_base
	ldr r1, =_end
	mov r2, #0x800
	cmp r2, #0
	beq end
	str r0, [r1]
	add r0, r0, #4
	sub r2, r2, #4
	b start
end:
	b end

.size start, .-start

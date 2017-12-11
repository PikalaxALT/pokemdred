	.include "asm/macros.inc"
	.include "constants/constants.inc"

	.syntax unified

	.set gUnknown_03004000, 0x03004000 @ Remove this once this object is made linkable

	.text

	thumb_func_start sub_80001DC
sub_80001DC: @ 80001DC
	mov r0, sp
	bx lr
	thumb_func_end sub_80001DC

	thumb_func_start sub_80001E0
sub_80001E0:
	ldr r0, =gUnknown_03004000
	bx lr
	.pool
	thumb_func_end sub_80001E0

	.arm
	.align 2, 0
	.global armsub_80001E8
armsub_80001E8:
	push {r4-r11}
	mov r12, REG_BASE
	ldr r11, =gUnknown_0202DCF8
	add r10, r11, 0x40
	mov r9, INTR_FLAG_VBLANK
	mov r8, 0
	strb r8, [r12, OFFSET_REG_IME]
	ldm r10, {r0-r7}
	stmia r10!, {r4-r7}
	stmia r10!, {r0-r3}
	ldr r0, [r11, 4]
	str r8, [r11, 4]
	strb r9, [r12, OFFSET_REG_IME]
	pop {r4-r11}
	bx lr

	.pool

	arm_func_start armsub_8000228
armsub_8000228:
	mov r12, REG_BASE
	add r12, OFFSET_REG_SIOMLT_RECV
	ldm r12, {r0,r1}
	push {r7-r11}
	ldr r11, =gUnknown_0202DCF8
	mov r9, 0xFE
	add r9, 0xFE00
	ldrh r3, [r12, 0x8] @ REG_SIOCNT
	and r3, 0x40 @ SIO_ERROR
	strb r3, [r11, 0x9]
	ldr r10, [r11, 0x14]
	adds r3, r10, 1
	blt _08000284
	bne _08000278
	strh r9, [r12, 0x0A] @ REG_SIODATA8
	add r8, r11, 0x28
	ldm r8, {r2,r3}
	mov r7, r2
	stm r8, {r3,r7}
	b _08000284
_08000278:
	ldr r3, [r11, 0x2C]
	ldr r2, [r3, r10, lsl 1]
	strh r2, [r12, 0x0A] @ REG_SIODATA8
_08000284:
	cmp r10, 0x0B
	addlt r10, 1
	strlt r10, [r11, 0x14]
	push {r0,r1,r5,r6}
	mov r6, 3
_08000298:
	add r8, r11, 0x18
	add r8, r8, r6, lsl 2
	ldr r10, [r8]
	lsl r3, r6, 1
	ldrh r5, [sp, r3]
	cmp r5, r9
	bne _080002C8
	cmp r10, 9
	ble _080002C8
	mov r0, 1
	sub r10, r0, 2
	b _080002F4
_080002C8:
	ldr r0, [r8, 0x18]
	lsl r3, r10, 1
	strh r5, [r0, r3]
	cmp r10, 9
	bne _080002F4
	ldr r1, [r8, 0x28]
	str r0, [r8, 0x28]
	str r1, [r8, 0x18]
	add r3, r11, 4
	mov r0, 1
	strb r0, [r3, r6]
_080002F4:
	cmp r10, 0x0B
	addlt r10, 1
	str r10, [r8]
	subs r6, 1
	bge _08000298
	ldrb r0, [r11]
	cmp r0, 0
	beq _08000334
	ldr r7, =REG_TM3CNT_H
	mov r0, 0
	strh r0, [r7]
	ldrh r0, [r12, 0x8] @ REG_SIOCNT
	orr r0, 0x80 @ SIO_START
	strh r0, [r12, 0x8] @ REG_SIOCNT
	mov r0, 0xc0 @ TIMER_ENABLE | TIMER_INTR_ENABLE
	strh r0, [r7]
_08000334:
	add sp, 8
	pop {r5-r11}
	bx lr
	.pool
	arm_func_end armsub_8000228

	.align 2, 0 @ don't pad with nop

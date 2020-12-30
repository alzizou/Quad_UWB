	.cpu cortex-m4
	.eabi_attribute 27, 1
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"deca_device.c"
	.text
.Ltext0:
	.section	.bss.dw1000local,"aw",%nobits
	.align	2
	.type	dw1000local, %object
	.size	dw1000local, 56
dw1000local:
	.space	56
	.section	.data.pdw1000local,"aw"
	.align	2
	.type	pdw1000local, %object
	.size	pdw1000local, 4
pdw1000local:
	.word	dw1000local
	.section	.text.dwt_setlocaldataptr,"ax",%progbits
	.align	1
	.global	dwt_setlocaldataptr
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setlocaldataptr, %function
dwt_setlocaldataptr:
.LFB0:
	.file 1 "C:\\Users\\ali\\Desktop\\Ali_Safaei\\5_GeoLocation_UWB\\UWB_sensors\\DWM1001\\Source_Code\\dwm1001_exm\\deca_driver\\deca_device.c"
	.loc 1 100 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
.LCFI0:
	str	r0, [sp, #4]
	.loc 1 102 8
	ldr	r3, [sp, #4]
	cmp	r3, #0
	bne	.L2
	.loc 1 104 16
	mov	r3, #-1
	b	.L3
.L2:
	.loc 1 107 20
	ldr	r2, [sp, #4]
	mov	r3, r2
	lsls	r3, r3, #3
	subs	r3, r3, r2
	lsls	r3, r3, #3
	ldr	r2, .L4
	add	r3, r3, r2
	.loc 1 107 18
	ldr	r2, .L4+4
	str	r3, [r2]
	.loc 1 109 12
	movs	r3, #0
.L3:
	.loc 1 110 1
	mov	r0, r3
	add	sp, sp, #8
.LCFI1:
	@ sp needed
	bx	lr
.L5:
	.align	2
.L4:
	.word	dw1000local
	.word	pdw1000local
.LFE0:
	.size	dwt_setlocaldataptr, .-dwt_setlocaldataptr
	.section	.text.dwt_initialise,"ax",%progbits
	.align	1
	.global	dwt_initialise
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_initialise, %function
dwt_initialise:
.LFB1:
	.loc 1 143 1
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
.LCFI2:
	sub	sp, sp, #24
.LCFI3:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 1 144 12
	movs	r3, #0
	strh	r3, [sp, #22]	@ movhi
	.loc 1 145 12
	movs	r3, #0
	str	r3, [sp, #16]
	.loc 1 147 17
	ldr	r3, .L13
	ldr	r3, [r3]
	.loc 1 147 29
	movs	r2, #0
	strb	r2, [r3, #17]
	.loc 1 148 17
	ldr	r3, .L13
	ldr	r3, [r3]
	.loc 1 148 29
	movs	r2, #0
	strb	r2, [r3, #26]
	.loc 1 149 17
	ldr	r3, .L13
	ldr	r3, [r3]
	.loc 1 149 30
	movs	r2, #0
	strh	r2, [r3, #24]	@ movhi
	.loc 1 151 17
	ldr	r3, .L13
	ldr	r3, [r3]
	.loc 1 151 28
	movs	r2, #0
	str	r2, [r3, #40]
	.loc 1 152 17
	ldr	r3, .L13
	ldr	r3, [r3]
	.loc 1 152 26
	movs	r2, #0
	str	r2, [r3, #44]
	.loc 1 153 17
	ldr	r3, .L13
	ldr	r3, [r3]
	.loc 1 153 26
	movs	r2, #0
	str	r2, [r3, #48]
	.loc 1 154 17
	ldr	r3, .L13
	ldr	r3, [r3]
	.loc 1 154 27
	movs	r2, #0
	str	r2, [r3, #52]
	.loc 1 157 26
	bl	dwt_readdevid
	mov	r2, r0
	.loc 1 157 8
	ldr	r3, .L13+4
	cmp	r2, r3
	beq	.L7
	.loc 1 159 16
	mov	r3, #-1
	b	.L8
.L7:
	.loc 1 163 5
	bl	dwt_softreset
	.loc 1 165 5
	movs	r0, #0
	bl	_dwt_enableclocks
	.loc 1 168 5
	movs	r2, #4
	movs	r1, #0
	movs	r0, #36
	bl	dwt_write8bitoffsetreg
	.loc 1 171 16
	movs	r0, #30
	bl	_dwt_otpread
	mov	r3, r0
	.loc 1 171 14
	strh	r3, [sp, #22]	@ movhi
	.loc 1 172 26
	ldrh	r3, [sp, #22]
	lsrs	r3, r3, #8
	uxth	r2, r3
	.loc 1 172 17
	ldr	r3, .L13
	ldr	r3, [r3]
	.loc 1 172 26
	uxtb	r2, r2
	strb	r2, [r3, #9]
	.loc 1 175 16
	movs	r0, #4
	bl	_dwt_otpread
	str	r0, [sp, #16]
	.loc 1 176 18
	ldr	r3, [sp, #16]
	uxtb	r3, r3
	.loc 1 176 7
	cmp	r3, #0
	beq	.L9
	.loc 1 179 9
	movs	r2, #2
	movs	r1, #18
	movs	r0, #45
	bl	dwt_write8bitoffsetreg
	.loc 1 180 34
	ldr	r3, .L13
	ldr	r3, [r3]
	ldrh	r2, [r3, #24]
	ldr	r3, .L13
	ldr	r3, [r3]
	orr	r2, r2, #4096
	uxth	r2, r2
	strh	r2, [r3, #24]	@ movhi
.L9:
	.loc 1 184 17
	ldr	r3, .L13
	ldr	r4, [r3]
	.loc 1 184 28
	movs	r0, #6
	bl	_dwt_otpread
	mov	r3, r0
	.loc 1 184 26
	str	r3, [r4]
	.loc 1 185 17
	ldr	r3, .L13
	ldr	r4, [r3]
	.loc 1 185 27
	movs	r0, #7
	bl	_dwt_otpread
	mov	r3, r0
	.loc 1 185 25
	str	r3, [r4, #4]
	.loc 1 188 41
	ldrh	r3, [sp, #22]	@ movhi
	uxtb	r2, r3
	.loc 1 188 17
	ldr	r3, .L13
	ldr	r3, [r3]
	.loc 1 188 41
	and	r2, r2, #31
	uxtb	r2, r2
	.loc 1 188 30
	strb	r2, [r3, #16]
	.loc 1 189 22
	ldr	r3, .L13
	ldr	r3, [r3]
	ldrb	r3, [r3, #16]	@ zero_extendqisi2
	.loc 1 189 8
	cmp	r3, #0
	bne	.L10
	.loc 1 191 21
	ldr	r3, .L13
	ldr	r3, [r3]
	.loc 1 191 34
	movs	r2, #16
	strb	r2, [r3, #16]
.L10:
	.loc 1 194 33
	ldr	r3, .L13
	ldr	r3, [r3]
	.loc 1 194 5
	ldrb	r3, [r3, #16]	@ zero_extendqisi2
	mov	r0, r3
	bl	dwt_setxtaltrim
	.loc 1 197 15
	ldrh	r3, [sp, #6]
	and	r3, r3, #1
	.loc 1 197 7
	cmp	r3, #0
	beq	.L11
	.loc 1 199 9
	bl	_dwt_loaducodefromrom
	.loc 1 200 34
	ldr	r3, .L13
	ldr	r3, [r3]
	ldrh	r2, [r3, #24]
	ldr	r3, .L13
	ldr	r3, [r3]
	orr	r2, r2, #2048
	uxth	r2, r2
	strh	r2, [r3, #24]	@ movhi
	b	.L12
.L11:
.LBB2:
	.loc 1 204 23
	movs	r1, #5
	movs	r0, #54
	bl	dwt_read16bitoffsetreg
	mov	r3, r0
	strh	r3, [sp, #14]	@ movhi
	.loc 1 205 14
	ldrh	r3, [sp, #14]	@ movhi
	bic	r3, r3, #512
	strh	r3, [sp, #14]	@ movhi
	.loc 1 206 9
	ldrh	r3, [sp, #14]
	mov	r2, r3
	movs	r1, #5
	movs	r0, #54
	bl	dwt_write16bitoffsetreg
.L12:
.LBE2:
	.loc 1 209 5
	movs	r0, #1
	bl	_dwt_enableclocks
	.loc 1 212 5
	movs	r2, #0
	movs	r1, #10
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 215 17
	ldr	r3, .L13
	ldr	r4, [r3]
	.loc 1 215 31
	movs	r1, #0
	movs	r0, #4
	bl	dwt_read32bitoffsetreg
	mov	r3, r0
	.loc 1 215 29
	str	r3, [r4, #20]
	.loc 1 217 12
	movs	r3, #0
.L8:
	.loc 1 219 1
	mov	r0, r3
	add	sp, sp, #24
.LCFI4:
	@ sp needed
	pop	{r4, pc}
.L14:
	.align	2
.L13:
	.word	pdw1000local
	.word	-557186768
.LFE1:
	.size	dwt_initialise, .-dwt_initialise
	.section	.text.dwt_otprevision,"ax",%progbits
	.align	1
	.global	dwt_otprevision
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_otprevision, %function
dwt_otprevision:
.LFB2:
	.loc 1 235 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 236 24
	ldr	r3, .L17
	ldr	r3, [r3]
	ldrb	r3, [r3, #9]	@ zero_extendqisi2
	.loc 1 237 1
	mov	r0, r3
	bx	lr
.L18:
	.align	2
.L17:
	.word	pdw1000local
.LFE2:
	.size	dwt_otprevision, .-dwt_otprevision
	.section	.text.dwt_setfinegraintxseq,"ax",%progbits
	.align	1
	.global	dwt_setfinegraintxseq
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setfinegraintxseq, %function
dwt_setfinegraintxseq:
.LFB3:
	.loc 1 252 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI5:
	sub	sp, sp, #12
.LCFI6:
	str	r0, [sp, #4]
	.loc 1 253 8
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L20
	.loc 1 255 9
	movw	r2, #2932
	movs	r1, #38
	movs	r0, #54
	bl	dwt_write16bitoffsetreg
	.loc 1 261 1
	b	.L22
.L20:
	.loc 1 259 9
	movs	r2, #0
	movs	r1, #38
	movs	r0, #54
	bl	dwt_write16bitoffsetreg
.L22:
	.loc 1 261 1
	nop
	add	sp, sp, #12
.LCFI7:
	@ sp needed
	ldr	pc, [sp], #4
.LFE3:
	.size	dwt_setfinegraintxseq, .-dwt_setfinegraintxseq
	.section	.text.dwt_setlnapamode,"ax",%progbits
	.align	1
	.global	dwt_setlnapamode
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setlnapamode, %function
dwt_setlnapamode:
.LFB4:
	.loc 1 281 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI8:
	sub	sp, sp, #20
.LCFI9:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 282 24
	movs	r1, #0
	movs	r0, #38
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 283 15
	ldr	r3, [sp, #12]
	bic	r3, r3, #1032192
	str	r3, [sp, #12]
	.loc 1 284 8
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L24
	.loc 1 286 19
	ldr	r3, [sp, #12]
	orr	r3, r3, #262144
	str	r3, [sp, #12]
.L24:
	.loc 1 288 8
	ldr	r3, [sp]
	cmp	r3, #0
	beq	.L25
	.loc 1 290 19
	ldr	r3, [sp, #12]
	orr	r3, r3, #81920
	str	r3, [sp, #12]
.L25:
	.loc 1 292 5
	ldr	r2, [sp, #12]
	movs	r1, #0
	movs	r0, #38
	bl	dwt_write32bitoffsetreg
	.loc 1 293 1
	nop
	add	sp, sp, #20
.LCFI10:
	@ sp needed
	ldr	pc, [sp], #4
.LFE4:
	.size	dwt_setlnapamode, .-dwt_setlnapamode
	.section	.text.dwt_setgpiodirection,"ax",%progbits
	.align	1
	.global	dwt_setgpiodirection
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setgpiodirection, %function
dwt_setgpiodirection:
.LFB5:
	.loc 1 309 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI11:
	sub	sp, sp, #20
.LCFI12:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 311 12
	ldr	r2, [sp]
	ldr	r3, [sp, #4]
	orrs	r3, r3, r2
	str	r3, [sp, #12]
	.loc 1 313 12
	ldr	r3, [sp, #12]
	uxtb	r3, r3
	strb	r3, [sp, #8]
	.loc 1 314 23
	ldr	r3, [sp, #12]
	lsrs	r3, r3, #8
	.loc 1 314 12
	uxtb	r3, r3
	strb	r3, [sp, #9]
	.loc 1 315 23
	ldr	r3, [sp, #12]
	lsrs	r3, r3, #16
	.loc 1 315 12
	uxtb	r3, r3
	strb	r3, [sp, #10]
	.loc 1 317 5
	add	r3, sp, #8
	movs	r2, #3
	movs	r1, #8
	movs	r0, #38
	bl	dwt_writetodevice
	.loc 1 318 1
	nop
	add	sp, sp, #20
.LCFI13:
	@ sp needed
	ldr	pc, [sp], #4
.LFE5:
	.size	dwt_setgpiodirection, .-dwt_setgpiodirection
	.section	.text.dwt_setgpiovalue,"ax",%progbits
	.align	1
	.global	dwt_setgpiovalue
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setgpiovalue, %function
dwt_setgpiovalue:
.LFB6:
	.loc 1 334 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI14:
	sub	sp, sp, #20
.LCFI15:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 336 12
	ldr	r2, [sp]
	ldr	r3, [sp, #4]
	orrs	r3, r3, r2
	str	r3, [sp, #12]
	.loc 1 338 12
	ldr	r3, [sp, #12]
	uxtb	r3, r3
	strb	r3, [sp, #8]
	.loc 1 339 23
	ldr	r3, [sp, #12]
	lsrs	r3, r3, #8
	.loc 1 339 12
	uxtb	r3, r3
	strb	r3, [sp, #9]
	.loc 1 340 23
	ldr	r3, [sp, #12]
	lsrs	r3, r3, #16
	.loc 1 340 12
	uxtb	r3, r3
	strb	r3, [sp, #10]
	.loc 1 342 5
	add	r3, sp, #8
	movs	r2, #3
	movs	r1, #12
	movs	r0, #38
	bl	dwt_writetodevice
	.loc 1 343 1
	nop
	add	sp, sp, #20
.LCFI16:
	@ sp needed
	ldr	pc, [sp], #4
.LFE6:
	.size	dwt_setgpiovalue, .-dwt_setgpiovalue
	.section	.text.dwt_getpartid,"ax",%progbits
	.align	1
	.global	dwt_getpartid
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_getpartid, %function
dwt_getpartid:
.LFB7:
	.loc 1 359 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 360 24
	ldr	r3, .L30
	ldr	r3, [r3]
	ldr	r3, [r3]
	.loc 1 361 1
	mov	r0, r3
	bx	lr
.L31:
	.align	2
.L30:
	.word	pdw1000local
.LFE7:
	.size	dwt_getpartid, .-dwt_getpartid
	.section	.text.dwt_getlotid,"ax",%progbits
	.align	1
	.global	dwt_getlotid
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_getlotid, %function
dwt_getlotid:
.LFB8:
	.loc 1 377 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 378 24
	ldr	r3, .L34
	ldr	r3, [r3]
	ldr	r3, [r3, #4]
	.loc 1 379 1
	mov	r0, r3
	bx	lr
.L35:
	.align	2
.L34:
	.word	pdw1000local
.LFE8:
	.size	dwt_getlotid, .-dwt_getlotid
	.section	.text.dwt_readdevid,"ax",%progbits
	.align	1
	.global	dwt_readdevid
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readdevid, %function
dwt_readdevid:
.LFB9:
	.loc 1 393 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI17:
	.loc 1 394 12
	movs	r1, #0
	movs	r0, #0
	bl	dwt_read32bitoffsetreg
	mov	r3, r0
	.loc 1 395 1
	mov	r0, r3
	pop	{r3, pc}
.LFE9:
	.size	dwt_readdevid, .-dwt_readdevid
	.section	.text.dwt_configuretxrf,"ax",%progbits
	.align	1
	.global	dwt_configuretxrf
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_configuretxrf, %function
dwt_configuretxrf:
.LFB10:
	.loc 1 412 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI18:
	sub	sp, sp, #12
.LCFI19:
	str	r0, [sp, #4]
	.loc 1 415 5
	ldr	r3, [sp, #4]
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #11
	movs	r0, #42
	bl	dwt_write8bitoffsetreg
	.loc 1 418 5
	ldr	r3, [sp, #4]
	ldr	r3, [r3, #4]
	mov	r2, r3
	movs	r1, #0
	movs	r0, #30
	bl	dwt_write32bitoffsetreg
	.loc 1 420 1
	nop
	add	sp, sp, #12
.LCFI20:
	@ sp needed
	ldr	pc, [sp], #4
.LFE10:
	.size	dwt_configuretxrf, .-dwt_configuretxrf
	.section	.text.dwt_configure,"ax",%progbits
	.align	1
	.global	dwt_configure
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_configure, %function
dwt_configure:
.LFB11:
	.loc 1 438 1
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI21:
	sub	sp, sp, #28
.LCFI22:
	str	r0, [sp, #4]
	.loc 1 439 11
	movs	r3, #0
	strb	r3, [sp, #23]
	.loc 1 440 11
	movs	r3, #0
	strb	r3, [sp, #22]
	.loc 1 441 11
	ldr	r3, [sp, #4]
	ldrb	r3, [r3]
	strb	r3, [sp, #19]
	.loc 1 443 43
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #5]	@ zero_extendqisi2
	mov	r2, r3
	.loc 1 443 12
	ldr	r3, .L50
	ldrh	r3, [r3, r2, lsl #1]	@ movhi
	strh	r3, [sp, #20]	@ movhi
	.loc 1 444 28
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	.loc 1 444 11
	subs	r3, r3, #1
	strb	r3, [sp, #18]
	.loc 1 445 49
	ldrb	r3, [sp, #19]	@ zero_extendqisi2
	cmp	r3, #4
	beq	.L40
	.loc 1 445 49 is_stmt 0 discriminator 2
	ldrb	r3, [sp, #19]	@ zero_extendqisi2
	cmp	r3, #7
	bne	.L41
.L40:
	.loc 1 445 49 discriminator 3
	movs	r3, #1
	b	.L42
.L41:
	.loc 1 445 49 discriminator 4
	movs	r3, #0
.L42:
	.loc 1 445 11 is_stmt 1 discriminator 6
	strb	r3, [sp, #17]
	.loc 1 462 29 discriminator 6
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #7]	@ zero_extendqisi2
	.loc 1 462 7 discriminator 6
	cmp	r3, #0
	bne	.L43
	.loc 1 464 33
	ldr	r3, .L50+4
	ldr	r3, [r3]
	ldr	r2, [r3, #20]
	ldr	r3, .L50+4
	ldr	r3, [r3]
	orr	r2, r2, #4194304
	str	r2, [r3, #20]
	.loc 1 465 15
	ldrh	r3, [sp, #20]
	lsrs	r3, r3, #3
	strh	r3, [sp, #20]	@ movhi
	b	.L44
.L43:
	.loc 1 469 33
	ldr	r3, .L50+4
	ldr	r3, [r3]
	ldr	r2, [r3, #20]
	ldr	r3, .L50+4
	ldr	r3, [r3]
	bic	r2, r2, #4194304
	str	r2, [r3, #20]
.L44:
	.loc 1 472 17
	ldr	r3, .L50+4
	ldr	r3, [r3]
	.loc 1 472 38
	ldr	r2, [sp, #4]
	ldrb	r2, [r2, #8]	@ zero_extendqisi2
	.loc 1 472 30
	strb	r2, [r3, #8]
	.loc 1 474 29
	ldr	r3, .L50+4
	ldr	r3, [r3]
	ldr	r2, [r3, #20]
	ldr	r3, .L50+4
	ldr	r3, [r3]
	bic	r2, r2, #196608
	str	r2, [r3, #20]
	.loc 1 475 29
	ldr	r3, .L50+4
	ldr	r3, [r3]
	ldr	r1, [r3, #20]
	.loc 1 475 62
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #8]	@ zero_extendqisi2
	.loc 1 475 72
	lsls	r3, r3, #16
	.loc 1 475 53
	and	r2, r3, #196608
	.loc 1 475 29
	ldr	r3, .L50+4
	ldr	r3, [r3]
	orrs	r2, r2, r1
	str	r2, [r3, #20]
	.loc 1 477 5
	ldr	r3, .L50+4
	ldr	r3, [r3]
	ldr	r3, [r3, #20]
	mov	r2, r3
	movs	r1, #0
	movs	r0, #4
	bl	dwt_write32bitoffsetreg
	.loc 1 479 5
	ldrh	r3, [sp, #20]
	mov	r2, r3
	movw	r1, #10244
	movs	r0, #46
	bl	dwt_write16bitoffsetreg
	.loc 1 481 5
	ldrb	r3, [sp, #18]	@ zero_extendqisi2
	mov	r0, r3
	bl	_dwt_configlde
	.loc 1 484 78
	ldrb	r3, [sp, #19]	@ zero_extendqisi2
	ldr	r2, .L50+8
	ldrb	r3, [r2, r3]	@ zero_extendqisi2
	mov	r2, r3
	.loc 1 484 5
	ldr	r3, .L50+12
	ldr	r3, [r3, r2, lsl #2]
	mov	r2, r3
	movs	r1, #7
	movs	r0, #43
	bl	dwt_write32bitoffsetreg
	.loc 1 485 79
	ldrb	r3, [sp, #19]	@ zero_extendqisi2
	ldr	r2, .L50+8
	ldrb	r3, [r2, r3]	@ zero_extendqisi2
	mov	r2, r3
	.loc 1 485 5
	ldr	r3, .L50+16
	ldrb	r3, [r3, r2]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #11
	movs	r0, #43
	bl	dwt_write8bitoffsetreg
	.loc 1 488 5
	ldrb	r3, [sp, #17]	@ zero_extendqisi2
	ldr	r2, .L50+20
	ldrb	r3, [r2, r3]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #11
	movs	r0, #40
	bl	dwt_write8bitoffsetreg
	.loc 1 492 77
	ldrb	r3, [sp, #19]	@ zero_extendqisi2
	ldr	r2, .L50+8
	ldrb	r3, [r2, r3]	@ zero_extendqisi2
	mov	r2, r3
	.loc 1 492 5
	ldr	r3, .L50+24
	ldr	r3, [r3, r2, lsl #2]
	mov	r2, r3
	movs	r1, #12
	movs	r0, #40
	bl	dwt_write32bitoffsetreg
	.loc 1 496 73
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #7]	@ zero_extendqisi2
	mov	r0, r3
	.loc 1 496 91
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #6]	@ zero_extendqisi2
	mov	r1, r3
	.loc 1 496 5
	ldr	r2, .L50+28
	lsls	r3, r0, #1
	add	r3, r3, r1
	ldrh	r3, [r2, r3, lsl #1]
	mov	r2, r3
	movs	r1, #2
	movs	r0, #39
	bl	dwt_write16bitoffsetreg
	.loc 1 499 5
	ldrb	r3, [sp, #18]	@ zero_extendqisi2
	ldr	r2, .L50+32
	ldrh	r3, [r2, r3, lsl #1]
	mov	r2, r3
	movs	r1, #4
	movs	r0, #39
	bl	dwt_write16bitoffsetreg
	.loc 1 501 14
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #7]	@ zero_extendqisi2
	.loc 1 501 7
	cmp	r3, #0
	bne	.L45
	.loc 1 503 9
	movs	r2, #100
	movs	r1, #6
	movs	r0, #39
	bl	dwt_write16bitoffsetreg
	b	.L46
.L45:
	.loc 1 507 18
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #2]	@ zero_extendqisi2
	.loc 1 507 11
	cmp	r3, #4
	bne	.L47
	.loc 1 509 13
	movs	r2, #16
	movs	r1, #6
	movs	r0, #39
	bl	dwt_write16bitoffsetreg
	.loc 1 510 13
	movs	r2, #16
	movs	r1, #38
	movs	r0, #39
	bl	dwt_write8bitoffsetreg
	b	.L46
.L47:
	.loc 1 514 13
	movs	r2, #32
	movs	r1, #6
	movs	r0, #39
	bl	dwt_write16bitoffsetreg
	.loc 1 515 13
	movs	r2, #40
	movs	r1, #38
	movs	r0, #39
	bl	dwt_write8bitoffsetreg
.L46:
	.loc 1 520 5
	ldrb	r3, [sp, #18]	@ zero_extendqisi2
	.loc 1 520 94
	ldr	r2, [sp, #4]
	ldrb	r2, [r2, #3]	@ zero_extendqisi2
	mov	r1, r2
	.loc 1 520 5
	ldr	r2, .L50+36
	lsls	r3, r3, #2
	add	r3, r3, r1
	ldr	r3, [r2, r3, lsl #2]
	mov	r2, r3
	movs	r1, #8
	movs	r0, #39
	bl	dwt_write32bitoffsetreg
	.loc 1 524 14
	ldr	r3, [sp, #4]
	ldrh	r3, [r3, #10]
	.loc 1 524 7
	cmp	r3, #0
	bne	.L48
	.loc 1 526 23
	ldr	r3, [sp, #4]
	movw	r2, #4161
	strh	r2, [r3, #10]	@ movhi
.L48:
	.loc 1 528 5
	ldr	r3, [sp, #4]
	ldrh	r3, [r3, #10]
	mov	r2, r3
	movs	r1, #32
	movs	r0, #39
	bl	dwt_write16bitoffsetreg
	.loc 1 531 5
	ldr	r3, .L50+40
	ldr	r3, [r3]
	mov	r2, r3
	movs	r1, #12
	movs	r0, #35
	bl	dwt_write32bitoffsetreg
	.loc 1 532 5
	ldrb	r3, [sp, #18]	@ zero_extendqisi2
	ldr	r2, .L50+40
	lsls	r3, r3, #1
	add	r3, r3, r2
	ldrh	r3, [r3, #4]
	mov	r2, r3
	movs	r1, #4
	movs	r0, #35
	bl	dwt_write16bitoffsetreg
	.loc 1 535 14
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #6]	@ zero_extendqisi2
	.loc 1 535 7
	cmp	r3, #0
	beq	.L49
	.loc 1 538 67
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #7]	@ zero_extendqisi2
	mov	r2, r3
	.loc 1 538 9
	ldr	r3, .L50+44
	ldrb	r3, [r3, r2]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #0
	movs	r0, #33
	bl	dwt_write8bitoffsetreg
	.loc 1 539 22
	movs	r3, #3
	strb	r3, [sp, #23]
	.loc 1 540 20
	movs	r3, #1
	strb	r3, [sp, #22]
.L49:
	.loc 1 542 47
	ldrb	r3, [sp, #19]	@ zero_extendqisi2
	.loc 1 542 39
	and	r2, r3, #15
	.loc 1 543 47
	ldrb	r3, [sp, #19]	@ zero_extendqisi2
	lsls	r3, r3, #4
	.loc 1 543 39
	uxtb	r3, r3
	.loc 1 542 76
	orrs	r2, r2, r3
	.loc 1 544 47
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	.loc 1 544 53
	lsls	r3, r3, #18
	.loc 1 544 38
	and	r3, r3, #786432
	.loc 1 543 76
	orrs	r2, r2, r3
	.loc 1 545 68
	ldrb	r3, [sp, #23]	@ zero_extendqisi2
	lsls	r3, r3, #20
	.loc 1 545 52
	and	r3, r3, #3145728
	.loc 1 544 81
	orrs	r2, r2, r3
	.loc 1 546 46
	ldrb	r3, [sp, #22]	@ zero_extendqisi2
	lsls	r3, r3, #17
	.loc 1 546 32
	and	r3, r3, #131072
	.loc 1 545 96
	orrs	r2, r2, r3
	.loc 1 547 48
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #4]	@ zero_extendqisi2
	.loc 1 547 57
	lsls	r3, r3, #22
	.loc 1 547 39
	and	r3, r3, #130023424
	.loc 1 546 73
	orrs	r3, r3, r2
	.loc 1 548 48
	ldr	r2, [sp, #4]
	ldrb	r2, [r2, #5]	@ zero_extendqisi2
	.loc 1 548 57
	lsls	r2, r2, #27
	.loc 1 542 12
	orrs	r3, r3, r2
	str	r3, [sp, #12]
	.loc 1 550 5
	ldr	r2, [sp, #12]
	movs	r1, #0
	movs	r0, #31
	bl	dwt_write32bitoffsetreg
	.loc 1 553 37
	ldr	r3, [sp, #4]
	ldrb	r2, [r3, #2]	@ zero_extendqisi2
	.loc 1 553 62
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #1]	@ zero_extendqisi2
	.loc 1 553 54
	orrs	r3, r3, r2
	uxtb	r3, r3
	.loc 1 553 69
	lsls	r2, r3, #16
	.loc 1 553 102
	ldr	r3, [sp, #4]
	ldrb	r3, [r3, #7]	@ zero_extendqisi2
	.loc 1 553 113
	lsls	r3, r3, #13
	.loc 1 553 93
	orrs	r2, r2, r3
	.loc 1 553 17
	ldr	r3, .L50+4
	ldr	r3, [r3]
	.loc 1 553 27
	str	r2, [r3, #12]
	.loc 1 554 5
	ldr	r3, .L50+4
	ldr	r3, [r3]
	ldr	r3, [r3, #12]
	mov	r2, r3
	movs	r1, #0
	movs	r0, #8
	bl	dwt_write32bitoffsetreg
	.loc 1 560 5
	movs	r2, #66
	movs	r1, #0
	movs	r0, #13
	bl	dwt_write8bitoffsetreg
	.loc 1 561 1
	nop
	add	sp, sp, #28
.LCFI23:
	@ sp needed
	ldr	pc, [sp], #4
.L51:
	.align	2
.L50:
	.word	lde_replicaCoeff
	.word	pdw1000local
	.word	chan_idx
	.word	fs_pll_cfg
	.word	fs_pll_tune
	.word	rx_config
	.word	tx_config
	.word	sftsh
	.word	dtune1
	.word	digital_bb_config
	.word	agc_config
	.word	dwnsSFDlen
.LFE11:
	.size	dwt_configure, .-dwt_configure
	.section	.text.dwt_setrxantennadelay,"ax",%progbits
	.align	1
	.global	dwt_setrxantennadelay
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setrxantennadelay, %function
dwt_setrxantennadelay:
.LFB12:
	.loc 1 577 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI24:
	sub	sp, sp, #12
.LCFI25:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 1 579 5
	ldrh	r3, [sp, #6]
	mov	r2, r3
	movw	r1, #6148
	movs	r0, #46
	bl	dwt_write16bitoffsetreg
	.loc 1 580 1
	nop
	add	sp, sp, #12
.LCFI26:
	@ sp needed
	ldr	pc, [sp], #4
.LFE12:
	.size	dwt_setrxantennadelay, .-dwt_setrxantennadelay
	.section	.text.dwt_settxantennadelay,"ax",%progbits
	.align	1
	.global	dwt_settxantennadelay
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_settxantennadelay, %function
dwt_settxantennadelay:
.LFB13:
	.loc 1 596 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI27:
	sub	sp, sp, #12
.LCFI28:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 1 598 5
	ldrh	r3, [sp, #6]
	mov	r2, r3
	movs	r1, #0
	movs	r0, #24
	bl	dwt_write16bitoffsetreg
	.loc 1 599 1
	nop
	add	sp, sp, #12
.LCFI29:
	@ sp needed
	ldr	pc, [sp], #4
.LFE13:
	.size	dwt_settxantennadelay, .-dwt_settxantennadelay
	.section	.text.dwt_writetxdata,"ax",%progbits
	.align	1
	.global	dwt_writetxdata
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_writetxdata, %function
dwt_writetxdata:
.LFB14:
	.loc 1 622 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI30:
	sub	sp, sp, #12
.LCFI31:
	mov	r3, r0
	str	r1, [sp]
	strh	r3, [sp, #6]	@ movhi
	mov	r3, r2	@ movhi
	strh	r3, [sp, #4]	@ movhi
	.loc 1 629 25
	ldrh	r2, [sp, #4]
	ldrh	r3, [sp, #6]
	add	r3, r3, r2
	.loc 1 629 8
	cmp	r3, #1024
	bgt	.L55
	.loc 1 632 71
	ldrh	r3, [sp, #6]
	subs	r3, r3, #2
	.loc 1 632 9
	mov	r2, r3
	ldrh	r1, [sp, #4]
	ldr	r3, [sp]
	movs	r0, #9
	bl	dwt_writetodevice
	.loc 1 633 16
	movs	r3, #0
	b	.L56
.L55:
	.loc 1 637 16
	mov	r3, #-1
.L56:
	.loc 1 639 1
	mov	r0, r3
	add	sp, sp, #12
.LCFI32:
	@ sp needed
	ldr	pc, [sp], #4
.LFE14:
	.size	dwt_writetxdata, .-dwt_writetxdata
	.section	.text.dwt_writetxfctrl,"ax",%progbits
	.align	1
	.global	dwt_writetxfctrl
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_writetxfctrl, %function
dwt_writetxfctrl:
.LFB15:
	.loc 1 659 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI33:
	sub	sp, sp, #20
.LCFI34:
	mov	r3, r0
	str	r2, [sp]
	strh	r3, [sp, #6]	@ movhi
	mov	r3, r1	@ movhi
	strh	r3, [sp, #4]	@ movhi
	.loc 1 667 32
	ldr	r3, .L58
	ldr	r3, [r3]
	ldr	r2, [r3, #12]
	.loc 1 667 42
	ldrh	r3, [sp, #6]
	orrs	r3, r3, r2
	.loc 1 667 76
	ldrh	r2, [sp, #4]
	lsls	r2, r2, #22
	.loc 1 667 58
	orrs	r3, r3, r2
	.loc 1 667 113
	ldr	r2, [sp]
	lsls	r2, r2, #15
	.loc 1 667 12
	orrs	r3, r3, r2
	str	r3, [sp, #12]
	.loc 1 668 5
	ldr	r2, [sp, #12]
	movs	r1, #0
	movs	r0, #8
	bl	dwt_write32bitoffsetreg
	.loc 1 669 1
	nop
	add	sp, sp, #20
.LCFI35:
	@ sp needed
	ldr	pc, [sp], #4
.L59:
	.align	2
.L58:
	.word	pdw1000local
.LFE15:
	.size	dwt_writetxfctrl, .-dwt_writetxfctrl
	.section	.text.dwt_readrxdata,"ax",%progbits
	.align	1
	.global	dwt_readrxdata
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readrxdata, %function
dwt_readrxdata:
.LFB16:
	.loc 1 687 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI36:
	sub	sp, sp, #12
.LCFI37:
	str	r0, [sp, #4]
	mov	r3, r1
	strh	r3, [sp, #2]	@ movhi
	mov	r3, r2	@ movhi
	strh	r3, [sp]	@ movhi
	.loc 1 688 5
	ldrh	r2, [sp, #2]
	ldrh	r1, [sp]
	ldr	r3, [sp, #4]
	movs	r0, #17
	bl	dwt_readfromdevice
	.loc 1 689 1
	nop
	add	sp, sp, #12
.LCFI38:
	@ sp needed
	ldr	pc, [sp], #4
.LFE16:
	.size	dwt_readrxdata, .-dwt_readrxdata
	.section	.text.dwt_readaccdata,"ax",%progbits
	.align	1
	.global	dwt_readaccdata
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readaccdata, %function
dwt_readaccdata:
.LFB17:
	.loc 1 709 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI39:
	sub	sp, sp, #12
.LCFI40:
	str	r0, [sp, #4]
	mov	r3, r1
	strh	r3, [sp, #2]	@ movhi
	mov	r3, r2	@ movhi
	strh	r3, [sp]	@ movhi
	.loc 1 711 5
	movs	r0, #7
	bl	_dwt_enableclocks
	.loc 1 713 5
	ldrh	r2, [sp, #2]
	ldrh	r1, [sp]
	ldr	r3, [sp, #4]
	movs	r0, #37
	bl	dwt_readfromdevice
	.loc 1 715 5
	movs	r0, #8
	bl	_dwt_enableclocks
	.loc 1 716 1
	nop
	add	sp, sp, #12
.LCFI41:
	@ sp needed
	ldr	pc, [sp], #4
.LFE17:
	.size	dwt_readaccdata, .-dwt_readaccdata
	.section	.text.dwt_readcarrierintegrator,"ax",%progbits
	.align	1
	.global	dwt_readcarrierintegrator
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readcarrierintegrator, %function
dwt_readcarrierintegrator:
.LFB18:
	.loc 1 736 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI42:
	sub	sp, sp, #20
.LCFI43:
	.loc 1 737 13
	movs	r3, #0
	str	r3, [sp, #12]
	.loc 1 743 5
	add	r3, sp, #4
	movs	r2, #3
	movs	r1, #40
	movs	r0, #39
	bl	dwt_readfromdevice
	.loc 1 745 12
	movs	r3, #2
	str	r3, [sp, #8]
	.loc 1 745 5
	b	.L63
.L64:
	.loc 1 747 26 discriminator 3
	ldr	r3, [sp, #12]
	lsls	r3, r3, #8
	.loc 1 747 40 discriminator 3
	add	r1, sp, #4
	ldr	r2, [sp, #8]
	add	r2, r2, r1
	ldrb	r2, [r2]	@ zero_extendqisi2
	.loc 1 747 16 discriminator 3
	add	r3, r3, r2
	str	r3, [sp, #12]
	.loc 1 745 29 discriminator 3
	ldr	r3, [sp, #8]
	subs	r3, r3, #1
	str	r3, [sp, #8]
.L63:
	.loc 1 745 5 discriminator 1
	ldr	r3, [sp, #8]
	cmp	r3, #0
	bge	.L64
	.loc 1 750 16
	ldr	r3, [sp, #12]
	and	r3, r3, #1048576
	.loc 1 750 8
	cmp	r3, #0
	beq	.L65
	.loc 1 750 47 discriminator 1
	ldr	r3, [sp, #12]
	mvn	r3, r3, lsl #12
	mvn	r3, r3, lsr #12
	str	r3, [sp, #12]
	b	.L66
.L65:
	.loc 1 751 17
	ldr	r3, [sp, #12]
	ubfx	r3, r3, #0, #21
	str	r3, [sp, #12]
.L66:
	.loc 1 753 12
	ldr	r3, [sp, #12]
	.loc 1 754 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI44:
	@ sp needed
	ldr	pc, [sp], #4
.LFE18:
	.size	dwt_readcarrierintegrator, .-dwt_readcarrierintegrator
	.section	.text.dwt_readdiagnostics,"ax",%progbits
	.align	1
	.global	dwt_readdiagnostics
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readdiagnostics, %function
dwt_readdiagnostics:
.LFB19:
	.loc 1 769 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI45:
	sub	sp, sp, #12
.LCFI46:
	str	r0, [sp, #4]
	.loc 1 771 30
	movs	r1, #5
	movs	r0, #21
	bl	dwt_read16bitoffsetreg
	mov	r3, r0
	mov	r2, r3
	.loc 1 771 28
	ldr	r3, [sp, #4]
	strh	r2, [r3, #14]	@ movhi
	.loc 1 774 29
	movs	r1, #0
	movs	r0, #46
	bl	dwt_read16bitoffsetreg
	mov	r3, r0
	mov	r2, r3
	.loc 1 774 27
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
	.loc 1 777 53
	ldr	r3, [sp, #4]
	adds	r3, r3, #4
	.loc 1 777 5
	movs	r2, #8
	movs	r1, #0
	movs	r0, #18
	bl	dwt_readfromdevice
	.loc 1 779 34
	movs	r1, #7
	movs	r0, #21
	bl	dwt_read16bitoffsetreg
	mov	r3, r0
	mov	r2, r3
	.loc 1 779 32
	ldr	r3, [sp, #4]
	strh	r2, [r3, #2]	@ movhi
	.loc 1 781 34
	movs	r1, #0
	movs	r0, #16
	bl	dwt_read32bitoffsetreg
	mov	r3, r0
	.loc 1 781 88
	lsrs	r3, r3, #20
	uxth	r3, r3
	ubfx	r3, r3, #0, #12
	uxth	r2, r3
	.loc 1 781 31
	ldr	r3, [sp, #4]
	strh	r2, [r3, #12]	@ movhi
	.loc 1 782 1
	nop
	add	sp, sp, #12
.LCFI47:
	@ sp needed
	ldr	pc, [sp], #4
.LFE19:
	.size	dwt_readdiagnostics, .-dwt_readdiagnostics
	.section	.text.dwt_readtxtimestamp,"ax",%progbits
	.align	1
	.global	dwt_readtxtimestamp
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readtxtimestamp, %function
dwt_readtxtimestamp:
.LFB20:
	.loc 1 797 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI48:
	sub	sp, sp, #12
.LCFI49:
	str	r0, [sp, #4]
	.loc 1 798 5
	ldr	r3, [sp, #4]
	movs	r2, #5
	movs	r1, #0
	movs	r0, #23
	bl	dwt_readfromdevice
	.loc 1 799 1
	nop
	add	sp, sp, #12
.LCFI50:
	@ sp needed
	ldr	pc, [sp], #4
.LFE20:
	.size	dwt_readtxtimestamp, .-dwt_readtxtimestamp
	.section	.text.dwt_readtxtimestamphi32,"ax",%progbits
	.align	1
	.global	dwt_readtxtimestamphi32
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readtxtimestamphi32, %function
dwt_readtxtimestamphi32:
.LFB21:
	.loc 1 813 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI51:
	.loc 1 814 12
	movs	r1, #1
	movs	r0, #23
	bl	dwt_read32bitoffsetreg
	mov	r3, r0
	.loc 1 815 1
	mov	r0, r3
	pop	{r3, pc}
.LFE21:
	.size	dwt_readtxtimestamphi32, .-dwt_readtxtimestamphi32
	.section	.text.dwt_readtxtimestamplo32,"ax",%progbits
	.align	1
	.global	dwt_readtxtimestamplo32
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readtxtimestamplo32, %function
dwt_readtxtimestamplo32:
.LFB22:
	.loc 1 829 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI52:
	.loc 1 830 12
	movs	r1, #0
	movs	r0, #23
	bl	dwt_read32bitoffsetreg
	mov	r3, r0
	.loc 1 831 1
	mov	r0, r3
	pop	{r3, pc}
.LFE22:
	.size	dwt_readtxtimestamplo32, .-dwt_readtxtimestamplo32
	.section	.text.dwt_readrxtimestamp,"ax",%progbits
	.align	1
	.global	dwt_readrxtimestamp
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readrxtimestamp, %function
dwt_readrxtimestamp:
.LFB23:
	.loc 1 846 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI53:
	sub	sp, sp, #12
.LCFI54:
	str	r0, [sp, #4]
	.loc 1 847 5
	ldr	r3, [sp, #4]
	movs	r2, #5
	movs	r1, #0
	movs	r0, #21
	bl	dwt_readfromdevice
	.loc 1 848 1
	nop
	add	sp, sp, #12
.LCFI55:
	@ sp needed
	ldr	pc, [sp], #4
.LFE23:
	.size	dwt_readrxtimestamp, .-dwt_readrxtimestamp
	.section	.text.dwt_readrxtimestamphi32,"ax",%progbits
	.align	1
	.global	dwt_readrxtimestamphi32
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readrxtimestamphi32, %function
dwt_readrxtimestamphi32:
.LFB24:
	.loc 1 862 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI56:
	.loc 1 863 12
	movs	r1, #1
	movs	r0, #21
	bl	dwt_read32bitoffsetreg
	mov	r3, r0
	.loc 1 864 1
	mov	r0, r3
	pop	{r3, pc}
.LFE24:
	.size	dwt_readrxtimestamphi32, .-dwt_readrxtimestamphi32
	.section	.text.dwt_readrxtimestamplo32,"ax",%progbits
	.align	1
	.global	dwt_readrxtimestamplo32
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readrxtimestamplo32, %function
dwt_readrxtimestamplo32:
.LFB25:
	.loc 1 878 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI57:
	.loc 1 879 12
	movs	r1, #0
	movs	r0, #21
	bl	dwt_read32bitoffsetreg
	mov	r3, r0
	.loc 1 880 1
	mov	r0, r3
	pop	{r3, pc}
.LFE25:
	.size	dwt_readrxtimestamplo32, .-dwt_readrxtimestamplo32
	.section	.text.dwt_readsystimestamphi32,"ax",%progbits
	.align	1
	.global	dwt_readsystimestamphi32
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readsystimestamphi32, %function
dwt_readsystimestamphi32:
.LFB26:
	.loc 1 894 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI58:
	.loc 1 895 12
	movs	r1, #1
	movs	r0, #6
	bl	dwt_read32bitoffsetreg
	mov	r3, r0
	.loc 1 896 1
	mov	r0, r3
	pop	{r3, pc}
.LFE26:
	.size	dwt_readsystimestamphi32, .-dwt_readsystimestamphi32
	.section	.text.dwt_readsystime,"ax",%progbits
	.align	1
	.global	dwt_readsystime
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readsystime, %function
dwt_readsystime:
.LFB27:
	.loc 1 912 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI59:
	sub	sp, sp, #12
.LCFI60:
	str	r0, [sp, #4]
	.loc 1 913 5
	ldr	r3, [sp, #4]
	movs	r2, #5
	movs	r1, #0
	movs	r0, #6
	bl	dwt_readfromdevice
	.loc 1 914 1
	nop
	add	sp, sp, #12
.LCFI61:
	@ sp needed
	ldr	pc, [sp], #4
.LFE27:
	.size	dwt_readsystime, .-dwt_readsystime
	.section	.text.dwt_writetodevice,"ax",%progbits
	.align	1
	.global	dwt_writetodevice
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_writetodevice, %function
dwt_writetodevice:
.LFB28:
	.loc 1 946 1
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI62:
	sub	sp, sp, #28
.LCFI63:
	str	r2, [sp, #8]
	str	r3, [sp, #4]
	mov	r3, r0	@ movhi
	strh	r3, [sp, #14]	@ movhi
	mov	r3, r1	@ movhi
	strh	r3, [sp, #12]	@ movhi
	.loc 1 948 11
	movs	r3, #0
	str	r3, [sp, #20]
	.loc 1 954 8
	ldrh	r3, [sp, #12]
	cmp	r3, #0
	bne	.L83
	.loc 1 956 23
	ldrh	r3, [sp, #14]	@ movhi
	uxtb	r2, r3
	.loc 1 956 19
	ldr	r3, [sp, #20]
	adds	r1, r3, #1
	str	r1, [sp, #20]
	.loc 1 956 23
	orn	r2, r2, #127
	uxtb	r2, r2
	add	r1, sp, #24
	add	r3, r3, r1
	strb	r2, [r3, #-8]
	b	.L84
.L83:
	.loc 1 963 23
	ldrh	r3, [sp, #14]	@ movhi
	uxtb	r2, r3
	.loc 1 963 19
	ldr	r3, [sp, #20]
	adds	r1, r3, #1
	str	r1, [sp, #20]
	.loc 1 963 23
	orn	r2, r2, #63
	uxtb	r2, r2
	add	r1, sp, #24
	add	r3, r3, r1
	strb	r2, [r3, #-8]
	.loc 1 965 12
	ldrh	r3, [sp, #12]
	cmp	r3, #127
	bhi	.L85
	.loc 1 967 23
	ldr	r3, [sp, #20]
	adds	r2, r3, #1
	str	r2, [sp, #20]
	.loc 1 967 29
	ldrh	r2, [sp, #12]	@ movhi
	uxtb	r2, r2
	.loc 1 967 27
	add	r1, sp, #24
	add	r3, r3, r1
	strb	r2, [r3, #-8]
	b	.L84
.L85:
	.loc 1 971 36
	ldrh	r3, [sp, #12]	@ movhi
	uxtb	r2, r3
	.loc 1 971 23
	ldr	r3, [sp, #20]
	adds	r1, r3, #1
	str	r1, [sp, #20]
	.loc 1 971 27
	orn	r2, r2, #127
	uxtb	r2, r2
	add	r1, sp, #24
	add	r3, r3, r1
	strb	r2, [r3, #-8]
	.loc 1 972 30
	ldrh	r3, [sp, #12]
	lsrs	r3, r3, #7
	uxth	r1, r3
	.loc 1 972 23
	ldr	r3, [sp, #20]
	adds	r2, r3, #1
	str	r2, [sp, #20]
	.loc 1 972 30
	uxtb	r2, r1
	.loc 1 972 27
	add	r1, sp, #24
	add	r3, r3, r1
	strb	r2, [r3, #-8]
.L84:
	.loc 1 977 5
	ldr	r3, [sp, #20]
	uxth	r0, r3
	add	r1, sp, #16
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #8]
	bl	writetospi
	.loc 1 978 1
	nop
	add	sp, sp, #28
.LCFI64:
	@ sp needed
	ldr	pc, [sp], #4
.LFE28:
	.size	dwt_writetodevice, .-dwt_writetodevice
	.section	.text.dwt_readfromdevice,"ax",%progbits
	.align	1
	.global	dwt_readfromdevice
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readfromdevice, %function
dwt_readfromdevice:
.LFB29:
	.loc 1 1010 1
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI65:
	sub	sp, sp, #28
.LCFI66:
	str	r2, [sp, #8]
	str	r3, [sp, #4]
	mov	r3, r0	@ movhi
	strh	r3, [sp, #14]	@ movhi
	mov	r3, r1	@ movhi
	strh	r3, [sp, #12]	@ movhi
	.loc 1 1012 11
	movs	r3, #0
	str	r3, [sp, #20]
	.loc 1 1018 8
	ldrh	r3, [sp, #12]
	cmp	r3, #0
	bne	.L87
	.loc 1 1020 19
	ldr	r3, [sp, #20]
	adds	r2, r3, #1
	str	r2, [sp, #20]
	.loc 1 1020 25
	ldrh	r2, [sp, #14]	@ movhi
	uxtb	r2, r2
	.loc 1 1020 23
	add	r1, sp, #24
	add	r3, r3, r1
	strb	r2, [r3, #-8]
	b	.L88
.L87:
	.loc 1 1027 25
	ldrh	r3, [sp, #14]	@ movhi
	uxtb	r2, r3
	.loc 1 1027 19
	ldr	r3, [sp, #20]
	adds	r1, r3, #1
	str	r1, [sp, #20]
	.loc 1 1027 25
	orr	r2, r2, #64
	uxtb	r2, r2
	.loc 1 1027 23
	add	r1, sp, #24
	add	r3, r3, r1
	strb	r2, [r3, #-8]
	.loc 1 1029 12
	ldrh	r3, [sp, #12]
	cmp	r3, #127
	bhi	.L89
	.loc 1 1031 23
	ldr	r3, [sp, #20]
	adds	r2, r3, #1
	str	r2, [sp, #20]
	.loc 1 1031 29
	ldrh	r2, [sp, #12]	@ movhi
	uxtb	r2, r2
	.loc 1 1031 27
	add	r1, sp, #24
	add	r3, r3, r1
	strb	r2, [r3, #-8]
	b	.L88
.L89:
	.loc 1 1035 36
	ldrh	r3, [sp, #12]	@ movhi
	uxtb	r2, r3
	.loc 1 1035 23
	ldr	r3, [sp, #20]
	adds	r1, r3, #1
	str	r1, [sp, #20]
	.loc 1 1035 27
	orn	r2, r2, #127
	uxtb	r2, r2
	add	r1, sp, #24
	add	r3, r3, r1
	strb	r2, [r3, #-8]
	.loc 1 1036 30
	ldrh	r3, [sp, #12]
	lsrs	r3, r3, #7
	uxth	r1, r3
	.loc 1 1036 23
	ldr	r3, [sp, #20]
	adds	r2, r3, #1
	str	r2, [sp, #20]
	.loc 1 1036 30
	uxtb	r2, r1
	.loc 1 1036 27
	add	r1, sp, #24
	add	r3, r3, r1
	strb	r2, [r3, #-8]
.L88:
	.loc 1 1041 5
	ldr	r3, [sp, #20]
	uxth	r0, r3
	add	r1, sp, #16
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #8]
	bl	readfromspi
	.loc 1 1042 1
	nop
	add	sp, sp, #28
.LCFI67:
	@ sp needed
	ldr	pc, [sp], #4
.LFE29:
	.size	dwt_readfromdevice, .-dwt_readfromdevice
	.section	.text.dwt_read32bitoffsetreg,"ax",%progbits
	.align	1
	.global	dwt_read32bitoffsetreg
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_read32bitoffsetreg, %function
dwt_read32bitoffsetreg:
.LFB30:
	.loc 1 1060 1
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI68:
	sub	sp, sp, #28
.LCFI69:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 1061 13
	movs	r3, #0
	str	r3, [sp, #20]
	.loc 1 1065 5
	ldr	r3, [sp, #4]
	uxth	r0, r3
	ldr	r3, [sp]
	uxth	r1, r3
	add	r3, sp, #12
	movs	r2, #4
	bl	dwt_readfromdevice
	.loc 1 1067 12
	movs	r3, #3
	str	r3, [sp, #16]
	.loc 1 1067 5
	b	.L91
.L92:
	.loc 1 1069 26 discriminator 3
	ldr	r3, [sp, #20]
	lsls	r3, r3, #8
	.loc 1 1069 40 discriminator 3
	add	r1, sp, #12
	ldr	r2, [sp, #16]
	add	r2, r2, r1
	ldrb	r2, [r2]	@ zero_extendqisi2
	.loc 1 1069 16 discriminator 3
	add	r3, r3, r2
	str	r3, [sp, #20]
	.loc 1 1067 29 discriminator 3
	ldr	r3, [sp, #16]
	subs	r3, r3, #1
	str	r3, [sp, #16]
.L91:
	.loc 1 1067 5 discriminator 1
	ldr	r3, [sp, #16]
	cmp	r3, #0
	bge	.L92
	.loc 1 1071 12
	ldr	r3, [sp, #20]
	.loc 1 1073 1
	mov	r0, r3
	add	sp, sp, #28
.LCFI70:
	@ sp needed
	ldr	pc, [sp], #4
.LFE30:
	.size	dwt_read32bitoffsetreg, .-dwt_read32bitoffsetreg
	.section	.text.dwt_read16bitoffsetreg,"ax",%progbits
	.align	1
	.global	dwt_read16bitoffsetreg
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_read16bitoffsetreg, %function
dwt_read16bitoffsetreg:
.LFB31:
	.loc 1 1089 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI71:
	sub	sp, sp, #20
.LCFI72:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 1090 13
	movs	r3, #0
	strh	r3, [sp, #14]	@ movhi
	.loc 1 1093 5
	ldr	r3, [sp, #4]
	uxth	r0, r3
	ldr	r3, [sp]
	uxth	r1, r3
	add	r3, sp, #12
	movs	r2, #2
	bl	dwt_readfromdevice
	.loc 1 1095 21
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 1 1095 25
	lsls	r3, r3, #8
	uxth	r2, r3
	.loc 1 1095 39
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	uxth	r3, r3
	.loc 1 1095 12
	add	r3, r3, r2
	strh	r3, [sp, #14]	@ movhi
	.loc 1 1096 12
	ldrh	r3, [sp, #14]
	.loc 1 1098 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI73:
	@ sp needed
	ldr	pc, [sp], #4
.LFE31:
	.size	dwt_read16bitoffsetreg, .-dwt_read16bitoffsetreg
	.section	.text.dwt_read8bitoffsetreg,"ax",%progbits
	.align	1
	.global	dwt_read8bitoffsetreg
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_read8bitoffsetreg, %function
dwt_read8bitoffsetreg:
.LFB32:
	.loc 1 1114 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI74:
	sub	sp, sp, #20
.LCFI75:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 1117 5
	ldr	r3, [sp, #4]
	uxth	r0, r3
	ldr	r3, [sp]
	uxth	r1, r3
	add	r3, sp, #15
	movs	r2, #1
	bl	dwt_readfromdevice
	.loc 1 1119 12
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	.loc 1 1120 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI76:
	@ sp needed
	ldr	pc, [sp], #4
.LFE32:
	.size	dwt_read8bitoffsetreg, .-dwt_read8bitoffsetreg
	.section	.text.dwt_write8bitoffsetreg,"ax",%progbits
	.align	1
	.global	dwt_write8bitoffsetreg
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_write8bitoffsetreg, %function
dwt_write8bitoffsetreg:
.LFB33:
	.loc 1 1137 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI77:
	sub	sp, sp, #20
.LCFI78:
	str	r0, [sp, #12]
	str	r1, [sp, #8]
	mov	r3, r2
	strb	r3, [sp, #7]
	.loc 1 1138 5
	ldr	r3, [sp, #12]
	uxth	r0, r3
	ldr	r3, [sp, #8]
	uxth	r1, r3
	add	r3, sp, #7
	movs	r2, #1
	bl	dwt_writetodevice
	.loc 1 1139 1
	nop
	add	sp, sp, #20
.LCFI79:
	@ sp needed
	ldr	pc, [sp], #4
.LFE33:
	.size	dwt_write8bitoffsetreg, .-dwt_write8bitoffsetreg
	.section	.text.dwt_write16bitoffsetreg,"ax",%progbits
	.align	1
	.global	dwt_write16bitoffsetreg
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_write16bitoffsetreg, %function
dwt_write16bitoffsetreg:
.LFB34:
	.loc 1 1156 1
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI80:
	sub	sp, sp, #28
.LCFI81:
	str	r0, [sp, #12]
	str	r1, [sp, #8]
	mov	r3, r2
	strh	r3, [sp, #6]	@ movhi
	.loc 1 1159 15
	ldrh	r3, [sp, #6]	@ movhi
	uxtb	r3, r3
	strb	r3, [sp, #20]
	.loc 1 1160 15
	ldrh	r3, [sp, #6]
	lsrs	r3, r3, #8
	uxth	r3, r3
	uxtb	r3, r3
	strb	r3, [sp, #21]
	.loc 1 1162 5
	ldr	r3, [sp, #12]
	uxth	r0, r3
	ldr	r3, [sp, #8]
	uxth	r1, r3
	add	r3, sp, #20
	movs	r2, #2
	bl	dwt_writetodevice
	.loc 1 1163 1
	nop
	add	sp, sp, #28
.LCFI82:
	@ sp needed
	ldr	pc, [sp], #4
.LFE34:
	.size	dwt_write16bitoffsetreg, .-dwt_write16bitoffsetreg
	.section	.text.dwt_write32bitoffsetreg,"ax",%progbits
	.align	1
	.global	dwt_write32bitoffsetreg
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_write32bitoffsetreg, %function
dwt_write32bitoffsetreg:
.LFB35:
	.loc 1 1180 1
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI83:
	sub	sp, sp, #28
.LCFI84:
	str	r0, [sp, #12]
	str	r1, [sp, #8]
	str	r2, [sp, #4]
	.loc 1 1184 13
	movs	r3, #0
	str	r3, [sp, #20]
	.loc 1 1184 5
	b	.L101
.L102:
	.loc 1 1186 19 discriminator 3
	ldr	r3, [sp, #4]
	uxtb	r1, r3
	add	r2, sp, #16
	ldr	r3, [sp, #20]
	add	r3, r3, r2
	mov	r2, r1
	strb	r2, [r3]
	.loc 1 1187 16 discriminator 3
	ldr	r3, [sp, #4]
	lsrs	r3, r3, #8
	str	r3, [sp, #4]
	.loc 1 1184 28 discriminator 3
	ldr	r3, [sp, #20]
	adds	r3, r3, #1
	str	r3, [sp, #20]
.L101:
	.loc 1 1184 5 discriminator 1
	ldr	r3, [sp, #20]
	cmp	r3, #3
	ble	.L102
	.loc 1 1190 5
	ldr	r3, [sp, #12]
	uxth	r0, r3
	ldr	r3, [sp, #8]
	uxth	r1, r3
	add	r3, sp, #16
	movs	r2, #4
	bl	dwt_writetodevice
	.loc 1 1191 1
	nop
	add	sp, sp, #28
.LCFI85:
	@ sp needed
	ldr	pc, [sp], #4
.LFE35:
	.size	dwt_write32bitoffsetreg, .-dwt_write32bitoffsetreg
	.section	.text.dwt_enableframefilter,"ax",%progbits
	.align	1
	.global	dwt_enableframefilter
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_enableframefilter, %function
dwt_enableframefilter:
.LFB36:
	.loc 1 1214 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI86:
	sub	sp, sp, #20
.LCFI87:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 1 1215 39
	movs	r1, #0
	movs	r0, #4
	bl	dwt_read32bitoffsetreg
	mov	r3, r0
	.loc 1 1215 12
	bic	r3, r3, #263192576
	bic	r3, r3, #524288
	str	r3, [sp, #12]
	.loc 1 1217 7
	ldrh	r3, [sp, #6]
	cmp	r3, #0
	beq	.L104
	.loc 1 1220 19
	ldr	r3, [sp, #12]
	bic	r3, r3, #510
	str	r3, [sp, #12]
	.loc 1 1221 30
	ldrh	r3, [sp, #6]
	and	r2, r3, #510
	.loc 1 1221 19
	ldr	r3, [sp, #12]
	orrs	r3, r3, r2
	orr	r3, r3, #1
	str	r3, [sp, #12]
	b	.L105
.L104:
	.loc 1 1225 19
	ldr	r3, [sp, #12]
	bic	r3, r3, #1
	str	r3, [sp, #12]
.L105:
	.loc 1 1228 17
	ldr	r3, .L106
	ldr	r3, [r3]
	.loc 1 1228 29
	ldr	r2, [sp, #12]
	str	r2, [r3, #20]
	.loc 1 1229 5
	ldr	r2, [sp, #12]
	movs	r1, #0
	movs	r0, #4
	bl	dwt_write32bitoffsetreg
	.loc 1 1230 1
	nop
	add	sp, sp, #20
.LCFI88:
	@ sp needed
	ldr	pc, [sp], #4
.L107:
	.align	2
.L106:
	.word	pdw1000local
.LFE36:
	.size	dwt_enableframefilter, .-dwt_enableframefilter
	.section	.text.dwt_setpanid,"ax",%progbits
	.align	1
	.global	dwt_setpanid
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setpanid, %function
dwt_setpanid:
.LFB37:
	.loc 1 1245 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI89:
	sub	sp, sp, #12
.LCFI90:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 1 1247 5
	ldrh	r3, [sp, #6]
	mov	r2, r3
	movs	r1, #2
	movs	r0, #3
	bl	dwt_write16bitoffsetreg
	.loc 1 1248 1
	nop
	add	sp, sp, #12
.LCFI91:
	@ sp needed
	ldr	pc, [sp], #4
.LFE37:
	.size	dwt_setpanid, .-dwt_setpanid
	.section	.text.dwt_setaddress16,"ax",%progbits
	.align	1
	.global	dwt_setaddress16
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setaddress16, %function
dwt_setaddress16:
.LFB38:
	.loc 1 1263 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI92:
	sub	sp, sp, #12
.LCFI93:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 1 1265 5
	ldrh	r3, [sp, #6]
	mov	r2, r3
	movs	r1, #0
	movs	r0, #3
	bl	dwt_write16bitoffsetreg
	.loc 1 1266 1
	nop
	add	sp, sp, #12
.LCFI94:
	@ sp needed
	ldr	pc, [sp], #4
.LFE38:
	.size	dwt_setaddress16, .-dwt_setaddress16
	.section	.text.dwt_seteui,"ax",%progbits
	.align	1
	.global	dwt_seteui
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_seteui, %function
dwt_seteui:
.LFB39:
	.loc 1 1281 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI95:
	sub	sp, sp, #12
.LCFI96:
	str	r0, [sp, #4]
	.loc 1 1282 5
	ldr	r3, [sp, #4]
	movs	r2, #8
	movs	r1, #0
	movs	r0, #1
	bl	dwt_writetodevice
	.loc 1 1283 1
	nop
	add	sp, sp, #12
.LCFI97:
	@ sp needed
	ldr	pc, [sp], #4
.LFE39:
	.size	dwt_seteui, .-dwt_seteui
	.section	.text.dwt_geteui,"ax",%progbits
	.align	1
	.global	dwt_geteui
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_geteui, %function
dwt_geteui:
.LFB40:
	.loc 1 1298 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI98:
	sub	sp, sp, #12
.LCFI99:
	str	r0, [sp, #4]
	.loc 1 1299 5
	ldr	r3, [sp, #4]
	movs	r2, #8
	movs	r1, #0
	movs	r0, #1
	bl	dwt_readfromdevice
	.loc 1 1300 1
	nop
	add	sp, sp, #12
.LCFI100:
	@ sp needed
	ldr	pc, [sp], #4
.LFE40:
	.size	dwt_geteui, .-dwt_geteui
	.section	.text.dwt_otpread,"ax",%progbits
	.align	1
	.global	dwt_otpread
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_otpread, %function
dwt_otpread:
.LFB41:
	.loc 1 1317 1
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
.LCFI101:
	sub	sp, sp, #24
.LCFI102:
	str	r0, [sp, #12]
	str	r1, [sp, #8]
	mov	r3, r2
	strb	r3, [sp, #7]
	.loc 1 1320 5
	movs	r0, #0
	bl	_dwt_enableclocks
	.loc 1 1322 10
	movs	r3, #0
	str	r3, [sp, #20]
	.loc 1 1322 5
	b	.L113
.L114:
	.loc 1 1324 20 discriminator 3
	ldr	r2, [sp, #20]
	ldr	r3, [sp, #12]
	adds	r1, r2, r3
	.loc 1 1324 14 discriminator 3
	ldr	r3, [sp, #20]
	lsls	r3, r3, #2
	ldr	r2, [sp, #8]
	adds	r4, r2, r3
	.loc 1 1324 20 discriminator 3
	mov	r0, r1
	bl	_dwt_otpread
	mov	r3, r0
	.loc 1 1324 18 discriminator 3
	str	r3, [r4]
	.loc 1 1322 25 discriminator 3
	ldr	r3, [sp, #20]
	adds	r3, r3, #1
	str	r3, [sp, #20]
.L113:
	.loc 1 1322 15 discriminator 1
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	.loc 1 1322 5 discriminator 1
	ldr	r2, [sp, #20]
	cmp	r2, r3
	blt	.L114
	.loc 1 1327 5
	movs	r0, #1
	bl	_dwt_enableclocks
	.loc 1 1329 5
	nop
	.loc 1 1330 1
	add	sp, sp, #24
.LCFI103:
	@ sp needed
	pop	{r4, pc}
.LFE41:
	.size	dwt_otpread, .-dwt_otpread
	.section	.text._dwt_otpread,"ax",%progbits
	.align	1
	.global	_dwt_otpread
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	_dwt_otpread, %function
_dwt_otpread:
.LFB42:
	.loc 1 1345 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI104:
	sub	sp, sp, #20
.LCFI105:
	str	r0, [sp, #4]
	.loc 1 1349 5
	ldr	r3, [sp, #4]
	uxth	r3, r3
	mov	r2, r3
	movs	r1, #4
	movs	r0, #45
	bl	dwt_write16bitoffsetreg
	.loc 1 1352 5
	movs	r2, #3
	movs	r1, #6
	movs	r0, #45
	bl	dwt_write8bitoffsetreg
	.loc 1 1353 5
	movs	r2, #0
	movs	r1, #6
	movs	r0, #45
	bl	dwt_write8bitoffsetreg
	.loc 1 1356 16
	movs	r1, #10
	movs	r0, #45
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 1359 12
	ldr	r3, [sp, #12]
	.loc 1 1360 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI106:
	@ sp needed
	ldr	pc, [sp], #4
.LFE42:
	.size	_dwt_otpread, .-_dwt_otpread
	.section	.text._dwt_otpsetmrregs,"ax",%progbits
	.align	1
	.global	_dwt_otpsetmrregs
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	_dwt_otpsetmrregs, %function
_dwt_otpsetmrregs:
.LFB43:
	.loc 1 1383 1
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI107:
	sub	sp, sp, #36
.LCFI108:
	str	r0, [sp, #4]
	.loc 1 1386 12
	movs	r3, #0
	str	r3, [sp, #28]
	.loc 1 1386 18
	movs	r3, #0
	str	r3, [sp, #24]
	.loc 1 1386 24
	movs	r3, #0
	str	r3, [sp, #20]
	.loc 1 1390 15
	movs	r3, #3
	strb	r3, [sp, #12]
	.loc 1 1391 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #7
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1394 16
	ldr	r3, [sp, #4]
	and	r3, r3, #15
	.loc 1 1394 5
	cmp	r3, #5
	bhi	.L119
	adr	r2, .L121
	ldr	pc, [r2, r3, lsl #2]
	.p2align 2
.L121:
	.word	.L126+1
	.word	.L125+1
	.word	.L124+1
	.word	.L123+1
	.word	.L122+1
	.word	.L120+1
	.p2align 1
.L126:
	.loc 1 1396 12
	movs	r3, #0
	str	r3, [sp, #20]
	.loc 1 1397 12
	movs	r3, #0
	str	r3, [sp, #28]
	.loc 1 1398 12
	movs	r3, #0
	str	r3, [sp, #24]
	.loc 1 1399 9
	b	.L127
.L125:
	.loc 1 1401 12
	movw	r3, #4132
	str	r3, [sp, #20]
	.loc 1 1402 12
	movw	r3, #37408
	str	r3, [sp, #28]
	.loc 1 1403 12
	movs	r3, #14
	str	r3, [sp, #24]
	.loc 1 1404 9
	b	.L127
.L124:
	.loc 1 1406 12
	movw	r3, #6180
	str	r3, [sp, #20]
	.loc 1 1407 12
	movw	r3, #37408
	str	r3, [sp, #28]
	.loc 1 1408 12
	movs	r3, #3
	str	r3, [sp, #24]
	.loc 1 1409 9
	b	.L127
.L123:
	.loc 1 1411 12
	movw	r3, #6180
	str	r3, [sp, #20]
	.loc 1 1412 12
	movw	r3, #37408
	str	r3, [sp, #28]
	.loc 1 1413 12
	movs	r3, #78
	str	r3, [sp, #24]
	.loc 1 1414 9
	b	.L127
.L122:
	.loc 1 1416 12
	movs	r3, #0
	str	r3, [sp, #20]
	.loc 1 1417 12
	movs	r3, #0
	str	r3, [sp, #28]
	.loc 1 1418 12
	movs	r3, #3
	str	r3, [sp, #24]
	.loc 1 1419 9
	b	.L127
.L120:
	.loc 1 1421 12
	movs	r3, #36
	str	r3, [sp, #20]
	.loc 1 1422 12
	movs	r3, #0
	str	r3, [sp, #28]
	.loc 1 1423 12
	movs	r3, #3
	str	r3, [sp, #24]
	.loc 1 1424 9
	b	.L127
.L119:
	.loc 1 1426 16
	mov	r3, #-1
	b	.L131
.L127:
	.loc 1 1429 15
	ldr	r3, [sp, #28]
	uxtb	r3, r3
	strb	r3, [sp, #12]
	.loc 1 1430 31
	ldr	r3, [sp, #28]
	lsrs	r3, r3, #8
	.loc 1 1430 15
	uxtb	r3, r3
	strb	r3, [sp, #13]
	.loc 1 1431 5
	add	r3, sp, #12
	movs	r2, #2
	movs	r1, #0
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1435 15
	movs	r3, #8
	strb	r3, [sp, #12]
	.loc 1 1436 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #6
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1441 15
	movs	r3, #2
	strb	r3, [sp, #12]
	.loc 1 1442 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #7
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1445 15
	movs	r3, #136
	strb	r3, [sp, #12]
	.loc 1 1446 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #6
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1448 15
	movs	r3, #128
	strb	r3, [sp, #12]
	.loc 1 1449 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #6
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1451 15
	movs	r3, #0
	strb	r3, [sp, #12]
	.loc 1 1452 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #6
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1457 15
	movs	r3, #5
	strb	r3, [sp, #12]
	.loc 1 1458 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #7
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1460 15
	ldr	r3, [sp, #24]
	uxtb	r3, r3
	strb	r3, [sp, #12]
	.loc 1 1461 31
	ldr	r3, [sp, #24]
	lsrs	r3, r3, #8
	.loc 1 1461 15
	uxtb	r3, r3
	strb	r3, [sp, #13]
	.loc 1 1462 5
	add	r3, sp, #12
	movs	r2, #2
	movs	r1, #0
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1465 15
	movs	r3, #8
	strb	r3, [sp, #12]
	.loc 1 1466 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #6
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1471 15
	movs	r3, #4
	strb	r3, [sp, #12]
	.loc 1 1472 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #7
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1475 15
	movs	r3, #136
	strb	r3, [sp, #12]
	.loc 1 1476 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #6
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1478 15
	movs	r3, #128
	strb	r3, [sp, #12]
	.loc 1 1479 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #6
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1481 15
	movs	r3, #0
	strb	r3, [sp, #12]
	.loc 1 1482 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #6
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1487 15
	movs	r3, #1
	strb	r3, [sp, #12]
	.loc 1 1488 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #7
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1491 15
	ldr	r3, [sp, #20]
	uxtb	r3, r3
	strb	r3, [sp, #12]
	.loc 1 1492 30
	ldr	r3, [sp, #20]
	lsrs	r3, r3, #8
	.loc 1 1492 15
	uxtb	r3, r3
	strb	r3, [sp, #13]
	.loc 1 1493 5
	add	r3, sp, #12
	movs	r2, #2
	movs	r1, #0
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1496 15
	movs	r3, #8
	strb	r3, [sp, #12]
	.loc 1 1497 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #6
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1500 5
	movs	r0, #10
	bl	deca_sleep
	.loc 1 1502 15
	movs	r3, #0
	strb	r3, [sp, #12]
	.loc 1 1503 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #7
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1507 15
	movs	r3, #1
	strb	r3, [sp, #12]
	.loc 1 1508 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #6
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1509 15
	movs	r3, #2
	strb	r3, [sp, #12]
	.loc 1 1510 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #7
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1512 15
	movs	r3, #4
	strb	r3, [sp, #12]
	.loc 1 1513 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #7
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1514 5
	movs	r0, #100
	bl	deca_sleep
	.loc 1 1517 15
	movs	r3, #0
	strb	r3, [sp, #12]
	.loc 1 1518 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #7
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1520 15
	movs	r3, #0
	strb	r3, [sp, #12]
	.loc 1 1521 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #6
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1523 5
	movs	r0, #10
	bl	deca_sleep
	.loc 1 1525 15
	ldr	r3, [sp, #4]
	and	r3, r3, #15
	.loc 1 1525 8
	cmp	r3, #1
	beq	.L129
	.loc 1 1525 37 discriminator 1
	ldr	r3, [sp, #4]
	and	r3, r3, #15
	.loc 1 1525 29 discriminator 1
	cmp	r3, #2
	bne	.L130
.L129:
	.loc 1 1528 9
	add	r3, sp, #16
	movs	r2, #1
	movs	r1, #8
	movs	r0, #45
	bl	dwt_readfromdevice
.L130:
	.loc 1 1531 12
	movs	r3, #0
.L131:
	.loc 1 1532 1 discriminator 1
	mov	r0, r3
	add	sp, sp, #36
.LCFI109:
	@ sp needed
	ldr	pc, [sp], #4
.LFE43:
	.size	_dwt_otpsetmrregs, .-_dwt_otpsetmrregs
	.section	.text._dwt_otpprogword32,"ax",%progbits
	.align	1
	.global	_dwt_otpprogword32
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	_dwt_otpprogword32, %function
_dwt_otpprogword32:
.LFB44:
	.loc 1 1549 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI110:
	sub	sp, sp, #20
.LCFI111:
	str	r0, [sp, #4]
	mov	r3, r1
	strh	r3, [sp, #2]	@ movhi
	.loc 1 1555 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #8
	movs	r0, #45
	bl	dwt_readfromdevice
	.loc 1 1557 15
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	.loc 1 1557 19
	and	r3, r3, #2
	.loc 1 1557 7
	cmp	r3, #0
	bne	.L133
	.loc 1 1559 16
	mov	r3, #-1
	b	.L137
.L133:
	.loc 1 1563 22
	ldr	r3, [sp, #4]
	lsrs	r3, r3, #24
	.loc 1 1563 15
	uxtb	r3, r3
	strb	r3, [sp, #11]
	.loc 1 1564 22
	ldr	r3, [sp, #4]
	lsrs	r3, r3, #16
	.loc 1 1564 15
	uxtb	r3, r3
	strb	r3, [sp, #10]
	.loc 1 1565 22
	ldr	r3, [sp, #4]
	lsrs	r3, r3, #8
	.loc 1 1565 15
	uxtb	r3, r3
	strb	r3, [sp, #9]
	.loc 1 1566 15
	ldr	r3, [sp, #4]
	uxtb	r3, r3
	strb	r3, [sp, #8]
	.loc 1 1567 5
	add	r3, sp, #8
	movs	r2, #4
	movs	r1, #0
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1570 30
	ldrh	r3, [sp, #2]
	lsrs	r3, r3, #8
	uxth	r3, r3
	uxtb	r3, r3
	and	r3, r3, #7
	uxtb	r3, r3
	.loc 1 1570 15
	strb	r3, [sp, #9]
	.loc 1 1571 15
	ldrh	r3, [sp, #2]	@ movhi
	uxtb	r3, r3
	strb	r3, [sp, #8]
	.loc 1 1572 5
	add	r3, sp, #8
	movs	r2, #2
	movs	r1, #4
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1575 15
	movs	r3, #64
	strb	r3, [sp, #8]
	.loc 1 1576 5
	add	r3, sp, #8
	movs	r2, #1
	movs	r1, #6
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1577 15
	movs	r3, #0
	strb	r3, [sp, #8]
	.loc 1 1578 5
	add	r3, sp, #8
	movs	r2, #1
	movs	r1, #6
	movs	r0, #45
	bl	dwt_writetodevice
	.loc 1 1581 14
	movs	r3, #0
	strb	r3, [sp, #15]
	.loc 1 1582 10
	b	.L135
.L136:
	.loc 1 1584 9
	movs	r0, #1
	bl	deca_sleep
	.loc 1 1585 9
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #8
	movs	r0, #45
	bl	dwt_readfromdevice
	.loc 1 1587 19
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	.loc 1 1587 23
	and	r3, r3, #1
	.loc 1 1587 11
	cmp	r3, #0
	beq	.L135
	.loc 1 1589 22
	movs	r3, #1
	strb	r3, [sp, #15]
.L135:
	.loc 1 1582 10
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L136
	.loc 1 1593 12
	movs	r3, #0
.L137:
	.loc 1 1594 1 discriminator 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI112:
	@ sp needed
	ldr	pc, [sp], #4
.LFE44:
	.size	_dwt_otpprogword32, .-_dwt_otpprogword32
	.section	.text.dwt_otpwriteandverify,"ax",%progbits
	.align	1
	.global	dwt_otpwriteandverify
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_otpwriteandverify, %function
dwt_otpwriteandverify:
.LFB45:
	.loc 1 1610 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI113:
	sub	sp, sp, #20
.LCFI114:
	str	r0, [sp, #4]
	mov	r3, r1
	strh	r3, [sp, #2]	@ movhi
	.loc 1 1611 9
	movs	r3, #0
	str	r3, [sp, #12]
	.loc 1 1612 9
	movs	r3, #0
	str	r3, [sp, #8]
	.loc 1 1614 5
	movs	r0, #0
	bl	_dwt_enableclocks
	.loc 1 1621 5
	movs	r0, #1
	bl	_dwt_otpsetmrregs
.L142:
	.loc 1 1626 9
	ldrh	r3, [sp, #2]
	mov	r1, r3
	ldr	r0, [sp, #4]
	bl	_dwt_otpprogword32
	.loc 1 1628 12
	ldrh	r3, [sp, #2]
	mov	r0, r3
	bl	_dwt_otpread
	mov	r2, r0
	.loc 1 1628 11
	ldr	r3, [sp, #4]
	cmp	r3, r2
	beq	.L145
	.loc 1 1632 14
	ldr	r3, [sp, #8]
	adds	r3, r3, #1
	str	r3, [sp, #8]
	.loc 1 1633 11
	ldr	r3, [sp, #8]
	cmp	r3, #5
	beq	.L146
	.loc 1 1626 9
	b	.L142
.L145:
	.loc 1 1630 13
	nop
	b	.L140
.L146:
	.loc 1 1635 13
	nop
.L140:
	.loc 1 1641 5
	movs	r0, #4
	bl	_dwt_otpsetmrregs
	.loc 1 1643 8
	ldrh	r3, [sp, #2]
	mov	r0, r3
	bl	_dwt_otpread
	mov	r2, r0
	.loc 1 1643 7
	ldr	r3, [sp, #4]
	cmp	r3, r2
	beq	.L143
	.loc 1 1645 17
	mov	r3, #-1
	str	r3, [sp, #12]
.L143:
	.loc 1 1648 5
	movs	r0, #0
	bl	_dwt_otpsetmrregs
	.loc 1 1650 12
	ldr	r3, [sp, #12]
	.loc 1 1651 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI115:
	@ sp needed
	ldr	pc, [sp], #4
.LFE45:
	.size	dwt_otpwriteandverify, .-dwt_otpwriteandverify
	.section	.text._dwt_aonconfigupload,"ax",%progbits
	.align	1
	.global	_dwt_aonconfigupload
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	_dwt_aonconfigupload, %function
_dwt_aonconfigupload:
.LFB46:
	.loc 1 1665 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI116:
	.loc 1 1666 5
	movs	r2, #4
	movs	r1, #2
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1667 5
	movs	r2, #0
	movs	r1, #2
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1668 1
	nop
	pop	{r3, pc}
.LFE46:
	.size	_dwt_aonconfigupload, .-_dwt_aonconfigupload
	.section	.text._dwt_aonarrayupload,"ax",%progbits
	.align	1
	.global	_dwt_aonarrayupload
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	_dwt_aonarrayupload, %function
_dwt_aonarrayupload:
.LFB47:
	.loc 1 1683 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI117:
	.loc 1 1684 5
	movs	r2, #0
	movs	r1, #2
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1685 5
	movs	r2, #2
	movs	r1, #2
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1686 1
	nop
	pop	{r3, pc}
.LFE47:
	.size	_dwt_aonarrayupload, .-_dwt_aonarrayupload
	.section	.text.dwt_entersleep,"ax",%progbits
	.align	1
	.global	dwt_entersleep
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_entersleep, %function
dwt_entersleep:
.LFB48:
	.loc 1 1701 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI118:
	.loc 1 1703 5
	bl	_dwt_aonarrayupload
	.loc 1 1704 1
	nop
	pop	{r3, pc}
.LFE48:
	.size	dwt_entersleep, .-dwt_entersleep
	.section	.text.dwt_configuresleepcnt,"ax",%progbits
	.align	1
	.global	dwt_configuresleepcnt
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_configuresleepcnt, %function
dwt_configuresleepcnt:
.LFB49:
	.loc 1 1721 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI119:
	sub	sp, sp, #12
.LCFI120:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 1 1723 5
	movs	r0, #0
	bl	_dwt_enableclocks
	.loc 1 1726 5
	movs	r2, #0
	movs	r1, #6
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1727 5
	movs	r2, #0
	movs	r1, #10
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1730 5
	bl	_dwt_aonconfigupload
	.loc 1 1733 5
	ldrh	r3, [sp, #6]
	mov	r2, r3
	movs	r1, #8
	movs	r0, #44
	bl	dwt_write16bitoffsetreg
	.loc 1 1734 5
	bl	_dwt_aonconfigupload
	.loc 1 1737 5
	movs	r2, #1
	movs	r1, #10
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1738 5
	bl	_dwt_aonconfigupload
	.loc 1 1741 5
	movs	r0, #1
	bl	_dwt_enableclocks
	.loc 1 1742 1
	nop
	add	sp, sp, #12
.LCFI121:
	@ sp needed
	ldr	pc, [sp], #4
.LFE49:
	.size	dwt_configuresleepcnt, .-dwt_configuresleepcnt
	.section	.text.dwt_calibratesleepcnt,"ax",%progbits
	.align	1
	.global	dwt_calibratesleepcnt
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_calibratesleepcnt, %function
dwt_calibratesleepcnt:
.LFB50:
	.loc 1 1759 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI122:
	sub	sp, sp, #12
.LCFI123:
	.loc 1 1763 5
	movs	r2, #4
	movs	r1, #10
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1764 5
	bl	_dwt_aonconfigupload
	.loc 1 1767 5
	movs	r2, #0
	movs	r1, #10
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1768 5
	bl	_dwt_aonconfigupload
	.loc 1 1771 5
	movs	r0, #0
	bl	_dwt_enableclocks
	.loc 1 1773 5
	movs	r0, #1
	bl	deca_sleep
	.loc 1 1777 5
	movs	r2, #118
	movs	r1, #4
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1780 5
	movs	r2, #128
	movs	r1, #2
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1783 5
	movs	r2, #136
	movs	r1, #2
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1786 14
	movs	r1, #3
	movs	r0, #44
	bl	dwt_read8bitoffsetreg
	mov	r3, r0
	.loc 1 1786 12
	strh	r3, [sp, #6]	@ movhi
	.loc 1 1787 12
	ldrh	r3, [sp, #6]	@ movhi
	lsls	r3, r3, #8
	strh	r3, [sp, #6]	@ movhi
	.loc 1 1790 5
	movs	r2, #117
	movs	r1, #4
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1793 5
	movs	r2, #128
	movs	r1, #2
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1796 5
	movs	r2, #136
	movs	r1, #2
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1799 15
	movs	r1, #3
	movs	r0, #44
	bl	dwt_read8bitoffsetreg
	mov	r3, r0
	uxth	r2, r3
	.loc 1 1799 12
	ldrh	r3, [sp, #6]	@ movhi
	orrs	r3, r3, r2
	strh	r3, [sp, #6]	@ movhi
	.loc 1 1802 5
	movs	r2, #0
	movs	r1, #2
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1805 5
	movs	r0, #1
	bl	_dwt_enableclocks
	.loc 1 1809 12
	ldrh	r3, [sp, #6]
	.loc 1 1810 1
	mov	r0, r3
	add	sp, sp, #12
.LCFI124:
	@ sp needed
	ldr	pc, [sp], #4
.LFE50:
	.size	dwt_calibratesleepcnt, .-dwt_calibratesleepcnt
	.section	.text.dwt_configuresleep,"ax",%progbits
	.align	1
	.global	dwt_configuresleep
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_configuresleep, %function
dwt_configuresleep:
.LFB51:
	.loc 1 1846 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI125:
	sub	sp, sp, #12
.LCFI126:
	mov	r3, r0
	mov	r2, r1
	strh	r3, [sp, #6]	@ movhi
	mov	r3, r2
	strb	r3, [sp, #5]
	.loc 1 1848 25
	ldr	r3, .L154
	ldr	r3, [r3]
	ldrh	r2, [r3, #24]
	.loc 1 1848 10
	ldrh	r3, [sp, #6]	@ movhi
	orrs	r3, r3, r2
	strh	r3, [sp, #6]	@ movhi
	.loc 1 1849 5
	ldrh	r3, [sp, #6]
	mov	r2, r3
	movs	r1, #0
	movs	r0, #44
	bl	dwt_write16bitoffsetreg
	.loc 1 1851 5
	ldrb	r3, [sp, #5]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #6
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 1852 1
	nop
	add	sp, sp, #12
.LCFI127:
	@ sp needed
	ldr	pc, [sp], #4
.L155:
	.align	2
.L154:
	.word	pdw1000local
.LFE51:
	.size	dwt_configuresleep, .-dwt_configuresleep
	.section	.text.dwt_entersleepaftertx,"ax",%progbits
	.align	1
	.global	dwt_entersleepaftertx
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_entersleepaftertx, %function
dwt_entersleepaftertx:
.LFB52:
	.loc 1 1871 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI128:
	sub	sp, sp, #20
.LCFI129:
	str	r0, [sp, #4]
	.loc 1 1872 18
	movs	r1, #4
	movs	r0, #54
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 1874 7
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L157
	.loc 1 1876 13
	ldr	r3, [sp, #12]
	orr	r3, r3, #2048
	str	r3, [sp, #12]
	b	.L158
.L157:
	.loc 1 1880 13
	ldr	r3, [sp, #12]
	bic	r3, r3, #2048
	str	r3, [sp, #12]
.L158:
	.loc 1 1882 5
	ldr	r2, [sp, #12]
	movs	r1, #4
	movs	r0, #54
	bl	dwt_write32bitoffsetreg
	.loc 1 1883 1
	nop
	add	sp, sp, #20
.LCFI130:
	@ sp needed
	ldr	pc, [sp], #4
.LFE52:
	.size	dwt_entersleepaftertx, .-dwt_entersleepaftertx
	.section	.text.dwt_spicswakeup,"ax",%progbits
	.align	1
	.global	dwt_spicswakeup
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_spicswakeup, %function
dwt_spicswakeup:
.LFB53:
	.loc 1 1910 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI131:
	sub	sp, sp, #12
.LCFI132:
	str	r0, [sp, #4]
	mov	r3, r1
	strh	r3, [sp, #2]	@ movhi
	.loc 1 1911 8
	bl	dwt_readdevid
	mov	r2, r0
	.loc 1 1911 7
	ldr	r3, .L165
	cmp	r2, r3
	beq	.L160
	.loc 1 1914 9
	ldrh	r2, [sp, #2]
	ldr	r3, [sp, #4]
	movs	r1, #0
	movs	r0, #0
	bl	dwt_readfromdevice
	.loc 1 1918 9
	movs	r0, #5
	bl	deca_sleep
	.loc 1 1925 8
	bl	dwt_readdevid
	mov	r2, r0
	.loc 1 1925 7
	ldr	r3, .L165
	cmp	r2, r3
	beq	.L163
	b	.L164
.L160:
	.loc 1 1922 16
	movs	r3, #0
	b	.L162
.L164:
	.loc 1 1927 16
	mov	r3, #-1
	b	.L162
.L163:
	.loc 1 1930 12
	movs	r3, #0
.L162:
	.loc 1 1931 1
	mov	r0, r3
	add	sp, sp, #12
.LCFI133:
	@ sp needed
	ldr	pc, [sp], #4
.L166:
	.align	2
.L165:
	.word	-557186768
.LFE53:
	.size	dwt_spicswakeup, .-dwt_spicswakeup
	.section	.text._dwt_configlde,"ax",%progbits
	.align	1
	.global	_dwt_configlde
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	_dwt_configlde, %function
_dwt_configlde:
.LFB54:
	.loc 1 1946 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI134:
	sub	sp, sp, #12
.LCFI135:
	str	r0, [sp, #4]
	.loc 1 1947 5
	movs	r2, #109
	movw	r1, #2054
	movs	r0, #46
	bl	dwt_write8bitoffsetreg
	.loc 1 1949 7
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L168
	.loc 1 1951 9
	movw	r2, #1543
	movw	r1, #6150
	movs	r0, #46
	bl	dwt_write16bitoffsetreg
	.loc 1 1957 1
	b	.L170
.L168:
	.loc 1 1955 9
	movw	r2, #5639
	movw	r1, #6150
	movs	r0, #46
	bl	dwt_write16bitoffsetreg
.L170:
	.loc 1 1957 1
	nop
	add	sp, sp, #12
.LCFI136:
	@ sp needed
	ldr	pc, [sp], #4
.LFE54:
	.size	_dwt_configlde, .-_dwt_configlde
	.section	.text._dwt_loaducodefromrom,"ax",%progbits
	.align	1
	.global	_dwt_loaducodefromrom
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	_dwt_loaducodefromrom, %function
_dwt_loaducodefromrom:
.LFB55:
	.loc 1 1972 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI137:
	.loc 1 1974 5
	movs	r0, #14
	bl	_dwt_enableclocks
	.loc 1 1977 5
	mov	r2, #32768
	movs	r1, #6
	movs	r0, #45
	bl	dwt_write16bitoffsetreg
	.loc 1 1979 5
	movs	r0, #1
	bl	deca_sleep
	.loc 1 1982 5
	movs	r0, #1
	bl	_dwt_enableclocks
	.loc 1 1983 1
	nop
	pop	{r3, pc}
.LFE55:
	.size	_dwt_loaducodefromrom, .-_dwt_loaducodefromrom
	.section	.text.dwt_loadopsettabfromotp,"ax",%progbits
	.align	1
	.global	dwt_loadopsettabfromotp
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_loadopsettabfromotp, %function
dwt_loadopsettabfromotp:
.LFB56:
	.loc 1 2001 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI138:
	sub	sp, sp, #20
.LCFI139:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 1 2002 28
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	lsls	r3, r3, #5
	.loc 1 2002 52
	sxth	r3, r3
	and	r3, r3, #96
	sxth	r3, r3
	.loc 1 2002 75
	orr	r3, r3, #1
	sxth	r3, r3
	.loc 1 2002 12
	strh	r3, [sp, #14]	@ movhi
	.loc 1 2005 5
	movs	r0, #14
	bl	_dwt_enableclocks
	.loc 1 2007 5
	ldrh	r3, [sp, #14]
	mov	r2, r3
	movs	r1, #18
	movs	r0, #45
	bl	dwt_write16bitoffsetreg
	.loc 1 2010 5
	movs	r0, #1
	bl	_dwt_enableclocks
	.loc 1 2012 1
	nop
	add	sp, sp, #20
.LCFI140:
	@ sp needed
	ldr	pc, [sp], #4
.LFE56:
	.size	dwt_loadopsettabfromotp, .-dwt_loadopsettabfromotp
	.section	.text.dwt_setsmarttxpower,"ax",%progbits
	.align	1
	.global	dwt_setsmarttxpower
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setsmarttxpower, %function
dwt_setsmarttxpower:
.LFB57:
	.loc 1 2027 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
.LCFI141:
	sub	sp, sp, #8
.LCFI142:
	str	r0, [sp, #4]
	.loc 1 2029 17
	ldr	r3, .L176
	ldr	r4, [r3]
	.loc 1 2029 31
	movs	r1, #0
	movs	r0, #4
	bl	dwt_read32bitoffsetreg
	mov	r3, r0
	.loc 1 2029 29
	str	r3, [r4, #20]
	.loc 1 2032 7
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L174
	.loc 1 2034 33
	ldr	r3, .L176
	ldr	r3, [r3]
	ldr	r2, [r3, #20]
	ldr	r3, .L176
	ldr	r3, [r3]
	bic	r2, r2, #262144
	str	r2, [r3, #20]
	b	.L175
.L174:
	.loc 1 2038 33
	ldr	r3, .L176
	ldr	r3, [r3]
	ldr	r2, [r3, #20]
	ldr	r3, .L176
	ldr	r3, [r3]
	orr	r2, r2, #262144
	str	r2, [r3, #20]
.L175:
	.loc 1 2041 5
	ldr	r3, .L176
	ldr	r3, [r3]
	ldr	r3, [r3, #20]
	mov	r2, r3
	movs	r1, #0
	movs	r0, #4
	bl	dwt_write32bitoffsetreg
	.loc 1 2042 1
	nop
	add	sp, sp, #8
.LCFI143:
	@ sp needed
	pop	{r4, pc}
.L177:
	.align	2
.L176:
	.word	pdw1000local
.LFE57:
	.size	dwt_setsmarttxpower, .-dwt_setsmarttxpower
	.section	.text.dwt_enableautoack,"ax",%progbits
	.align	1
	.global	dwt_enableautoack
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_enableautoack, %function
dwt_enableautoack:
.LFB58:
	.loc 1 2060 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI144:
	sub	sp, sp, #12
.LCFI145:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 1 2062 5
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #3
	movs	r0, #26
	bl	dwt_write8bitoffsetreg
	.loc 1 2064 29
	ldr	r3, .L179
	ldr	r3, [r3]
	ldr	r2, [r3, #20]
	ldr	r3, .L179
	ldr	r3, [r3]
	orr	r2, r2, #1073741824
	str	r2, [r3, #20]
	.loc 1 2065 5
	ldr	r3, .L179
	ldr	r3, [r3]
	ldr	r3, [r3, #20]
	mov	r2, r3
	movs	r1, #0
	movs	r0, #4
	bl	dwt_write32bitoffsetreg
	.loc 1 2066 1
	nop
	add	sp, sp, #12
.LCFI146:
	@ sp needed
	ldr	pc, [sp], #4
.L180:
	.align	2
.L179:
	.word	pdw1000local
.LFE58:
	.size	dwt_enableautoack, .-dwt_enableautoack
	.section	.text.dwt_setdblrxbuffmode,"ax",%progbits
	.align	1
	.global	dwt_setdblrxbuffmode
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setdblrxbuffmode, %function
dwt_setdblrxbuffmode:
.LFB59:
	.loc 1 2081 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI147:
	sub	sp, sp, #12
.LCFI148:
	str	r0, [sp, #4]
	.loc 1 2082 7
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L182
	.loc 1 2085 33
	ldr	r3, .L184
	ldr	r3, [r3]
	ldr	r2, [r3, #20]
	ldr	r3, .L184
	ldr	r3, [r3]
	bic	r2, r2, #4096
	str	r2, [r3, #20]
	.loc 1 2086 21
	ldr	r3, .L184
	ldr	r3, [r3]
	.loc 1 2086 33
	movs	r2, #1
	strb	r2, [r3, #17]
	b	.L183
.L182:
	.loc 1 2091 33
	ldr	r3, .L184
	ldr	r3, [r3]
	ldr	r2, [r3, #20]
	ldr	r3, .L184
	ldr	r3, [r3]
	orr	r2, r2, #4096
	str	r2, [r3, #20]
	.loc 1 2092 21
	ldr	r3, .L184
	ldr	r3, [r3]
	.loc 1 2092 33
	movs	r2, #0
	strb	r2, [r3, #17]
.L183:
	.loc 1 2095 5
	ldr	r3, .L184
	ldr	r3, [r3]
	ldr	r3, [r3, #20]
	mov	r2, r3
	movs	r1, #0
	movs	r0, #4
	bl	dwt_write32bitoffsetreg
	.loc 1 2096 1
	nop
	add	sp, sp, #12
.LCFI149:
	@ sp needed
	ldr	pc, [sp], #4
.L185:
	.align	2
.L184:
	.word	pdw1000local
.LFE59:
	.size	dwt_setdblrxbuffmode, .-dwt_setdblrxbuffmode
	.section	.text.dwt_setrxaftertxdelay,"ax",%progbits
	.align	1
	.global	dwt_setrxaftertxdelay
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setrxaftertxdelay, %function
dwt_setrxaftertxdelay:
.LFB60:
	.loc 1 2111 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI150:
	sub	sp, sp, #20
.LCFI151:
	str	r0, [sp, #4]
	.loc 1 2112 18
	movs	r1, #0
	movs	r0, #26
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 2114 9
	ldr	r3, [sp, #12]
	lsrs	r3, r3, #20
	lsls	r3, r3, #20
	str	r3, [sp, #12]
	.loc 1 2116 25
	ldr	r3, [sp, #4]
	ubfx	r3, r3, #0, #20
	.loc 1 2116 9
	ldr	r2, [sp, #12]
	orrs	r3, r3, r2
	str	r3, [sp, #12]
	.loc 1 2118 5
	ldr	r2, [sp, #12]
	movs	r1, #0
	movs	r0, #26
	bl	dwt_write32bitoffsetreg
	.loc 1 2119 1
	nop
	add	sp, sp, #20
.LCFI152:
	@ sp needed
	ldr	pc, [sp], #4
.LFE60:
	.size	dwt_setrxaftertxdelay, .-dwt_setrxaftertxdelay
	.section	.text.dwt_setcallbacks,"ax",%progbits
	.align	1
	.global	dwt_setcallbacks
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setcallbacks, %function
dwt_setcallbacks:
.LFB61:
	.loc 1 2140 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #16
.LCFI153:
	str	r0, [sp, #12]
	str	r1, [sp, #8]
	str	r2, [sp, #4]
	str	r3, [sp]
	.loc 1 2141 17
	ldr	r3, .L188
	ldr	r3, [r3]
	.loc 1 2141 28
	ldr	r2, [sp, #12]
	str	r2, [r3, #40]
	.loc 1 2142 17
	ldr	r3, .L188
	ldr	r3, [r3]
	.loc 1 2142 26
	ldr	r2, [sp, #8]
	str	r2, [r3, #44]
	.loc 1 2143 17
	ldr	r3, .L188
	ldr	r3, [r3]
	.loc 1 2143 26
	ldr	r2, [sp, #4]
	str	r2, [r3, #48]
	.loc 1 2144 17
	ldr	r3, .L188
	ldr	r3, [r3]
	.loc 1 2144 27
	ldr	r2, [sp]
	str	r2, [r3, #52]
	.loc 1 2145 1
	nop
	add	sp, sp, #16
.LCFI154:
	@ sp needed
	bx	lr
.L189:
	.align	2
.L188:
	.word	pdw1000local
.LFE61:
	.size	dwt_setcallbacks, .-dwt_setcallbacks
	.section	.text.dwt_checkirq,"ax",%progbits
	.align	1
	.global	dwt_checkirq
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_checkirq, %function
dwt_checkirq:
.LFB62:
	.loc 1 2159 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI155:
	.loc 1 2160 13
	movs	r1, #0
	movs	r0, #15
	bl	dwt_read8bitoffsetreg
	mov	r3, r0
	.loc 1 2160 69
	and	r3, r3, #1
	uxtb	r3, r3
	.loc 1 2161 1
	mov	r0, r3
	pop	{r3, pc}
.LFE62:
	.size	dwt_checkirq, .-dwt_checkirq
	.section	.text.dwt_isr,"ax",%progbits
	.align	1
	.global	dwt_isr
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_isr, %function
dwt_isr:
.LFB63:
	.loc 1 2188 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
.LCFI156:
	sub	sp, sp, #16
.LCFI157:
	.loc 1 2189 33
	ldr	r3, .L203
	ldr	r4, [r3]
	.loc 1 2189 51
	movs	r1, #0
	movs	r0, #15
	bl	dwt_read32bitoffsetreg
	mov	r3, r0
	.loc 1 2189 49
	str	r3, [r4, #28]
	.loc 1 2189 12
	ldr	r3, [r4, #28]
	str	r3, [sp, #8]
	.loc 1 2192 15
	ldr	r3, [sp, #8]
	and	r3, r3, #16384
	.loc 1 2192 7
	cmp	r3, #0
	beq	.L193
.LBB3:
	.loc 1 2197 9
	mov	r2, #28416
	movs	r1, #0
	movs	r0, #15
	bl	dwt_write32bitoffsetreg
	.loc 1 2199 21
	ldr	r3, .L203
	ldr	r3, [r3]
	.loc 1 2199 39
	movs	r2, #0
	strb	r2, [r3, #36]
	.loc 1 2202 19
	movs	r1, #0
	movs	r0, #16
	bl	dwt_read16bitoffsetreg
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 1 2205 13
	ldrh	r3, [sp, #6]	@ movhi
	ubfx	r3, r3, #0, #10
	strh	r3, [sp, #14]	@ movhi
	.loc 1 2206 24
	ldr	r3, .L203
	ldr	r3, [r3]
	ldrb	r3, [r3, #8]	@ zero_extendqisi2
	.loc 1 2206 11
	cmp	r3, #0
	bne	.L194
	.loc 1 2208 17
	ldrh	r3, [sp, #14]	@ movhi
	and	r3, r3, #127
	strh	r3, [sp, #14]	@ movhi
.L194:
	.loc 1 2210 21
	ldr	r3, .L203
	ldr	r3, [r3]
	.loc 1 2210 41
	ldrh	r2, [sp, #14]	@ movhi
	strh	r2, [r3, #32]	@ movhi
	.loc 1 2213 12
	ldrsh	r3, [sp, #6]
	.loc 1 2213 11
	cmp	r3, #0
	bge	.L195
	.loc 1 2215 43
	ldr	r3, .L203
	ldr	r3, [r3]
	ldrb	r2, [r3, #36]	@ zero_extendqisi2
	ldr	r3, .L203
	ldr	r3, [r3]
	orr	r2, r2, #1
	uxtb	r2, r2
	strb	r2, [r3, #36]
.L195:
	.loc 1 2219 72
	ldr	r3, .L203
	ldr	r3, [r3]
	.loc 1 2219 80
	adds	r3, r3, #34
	.loc 1 2219 9
	movs	r2, #2
	movs	r1, #0
	movs	r0, #17
	bl	dwt_readfromdevice
	.loc 1 2225 20
	ldr	r3, [sp, #8]
	and	r3, r3, #8
	.loc 1 2225 11
	cmp	r3, #0
	beq	.L196
	.loc 1 2225 55 discriminator 1
	ldr	r3, .L203
	ldr	r3, [r3]
	.loc 1 2225 69 discriminator 1
	ldrb	r3, [r3, #34]	@ zero_extendqisi2
	.loc 1 2225 73 discriminator 1
	and	r3, r3, #32
	.loc 1 2225 38 discriminator 1
	cmp	r3, #0
	bne	.L196
	.loc 1 2227 13
	movs	r2, #8
	movs	r1, #0
	movs	r0, #15
	bl	dwt_write32bitoffsetreg
	.loc 1 2228 41
	ldr	r3, .L203
	ldr	r3, [r3]
	ldr	r2, [r3, #28]
	ldr	r3, .L203
	ldr	r3, [r3]
	bic	r2, r2, #8
	str	r2, [r3, #28]
	.loc 1 2229 25
	ldr	r3, .L203
	ldr	r3, [r3]
	.loc 1 2229 37
	movs	r2, #0
	strb	r2, [r3, #26]
.L196:
	.loc 1 2233 24
	ldr	r3, .L203
	ldr	r3, [r3]
	ldr	r3, [r3, #44]
	.loc 1 2233 11
	cmp	r3, #0
	beq	.L197
	.loc 1 2235 25
	ldr	r3, .L203
	ldr	r3, [r3]
	ldr	r3, [r3, #44]
	.loc 1 2235 47
	ldr	r2, .L203
	ldr	r2, [r2]
	.loc 1 2235 34
	adds	r2, r2, #28
	.loc 1 2235 13
	mov	r0, r2
	blx	r3
.LVL0:
.L197:
	.loc 1 2238 25
	ldr	r3, .L203
	ldr	r3, [r3]
	ldrb	r3, [r3, #17]	@ zero_extendqisi2
	.loc 1 2238 12
	cmp	r3, #0
	beq	.L193
	.loc 1 2241 13
	movs	r2, #1
	movs	r1, #3
	movs	r0, #13
	bl	dwt_write8bitoffsetreg
.L193:
.LBE3:
	.loc 1 2246 15
	ldr	r3, [sp, #8]
	and	r3, r3, #128
	.loc 1 2246 7
	cmp	r3, #0
	beq	.L198
	.loc 1 2248 9
	movs	r2, #248
	movs	r1, #0
	movs	r0, #15
	bl	dwt_write32bitoffsetreg
	.loc 1 2255 20
	ldr	r3, [sp, #8]
	and	r3, r3, #8
	.loc 1 2255 11
	cmp	r3, #0
	beq	.L199
	.loc 1 2255 53 discriminator 1
	ldr	r3, .L203
	ldr	r3, [r3]
	ldrb	r3, [r3, #26]	@ zero_extendqisi2
	.loc 1 2255 38 discriminator 1
	cmp	r3, #0
	beq	.L199
	.loc 1 2257 13
	bl	dwt_forcetrxoff
	.loc 1 2258 13
	bl	dwt_rxreset
.L199:
	.loc 1 2262 24
	ldr	r3, .L203
	ldr	r3, [r3]
	ldr	r3, [r3, #40]
	.loc 1 2262 11
	cmp	r3, #0
	beq	.L198
	.loc 1 2264 25
	ldr	r3, .L203
	ldr	r3, [r3]
	ldr	r3, [r3, #40]
	.loc 1 2264 49
	ldr	r2, .L203
	ldr	r2, [r2]
	.loc 1 2264 36
	adds	r2, r2, #28
	.loc 1 2264 13
	mov	r0, r2
	blx	r3
.LVL1:
.L198:
	.loc 1 2269 15
	ldr	r3, [sp, #8]
	and	r3, r3, #2228224
	.loc 1 2269 7
	cmp	r3, #0
	beq	.L200
	.loc 1 2271 9
	mov	r2, #131072
	movs	r1, #0
	movs	r0, #15
	bl	dwt_write32bitoffsetreg
	.loc 1 2273 21
	ldr	r3, .L203
	ldr	r3, [r3]
	.loc 1 2273 33
	movs	r2, #0
	strb	r2, [r3, #26]
	.loc 1 2278 9
	bl	dwt_forcetrxoff
	.loc 1 2279 9
	bl	dwt_rxreset
	.loc 1 2282 24
	ldr	r3, .L203
	ldr	r3, [r3]
	ldr	r3, [r3, #48]
	.loc 1 2282 11
	cmp	r3, #0
	beq	.L200
	.loc 1 2284 25
	ldr	r3, .L203
	ldr	r3, [r3]
	ldr	r3, [r3, #48]
	.loc 1 2284 47
	ldr	r2, .L203
	ldr	r2, [r2]
	.loc 1 2284 34
	adds	r2, r2, #28
	.loc 1 2284 13
	mov	r0, r2
	blx	r3
.LVL2:
.L200:
	.loc 1 2289 15
	ldr	r2, [sp, #8]
	ldr	r3, .L203+4
	ands	r3, r3, r2
	.loc 1 2289 7
	cmp	r3, #0
	beq	.L202
	.loc 1 2291 9
	ldr	r2, .L203+4
	movs	r1, #0
	movs	r0, #15
	bl	dwt_write32bitoffsetreg
	.loc 1 2293 21
	ldr	r3, .L203
	ldr	r3, [r3]
	.loc 1 2293 33
	movs	r2, #0
	strb	r2, [r3, #26]
	.loc 1 2298 9
	bl	dwt_forcetrxoff
	.loc 1 2299 9
	bl	dwt_rxreset
	.loc 1 2302 24
	ldr	r3, .L203
	ldr	r3, [r3]
	ldr	r3, [r3, #52]
	.loc 1 2302 11
	cmp	r3, #0
	beq	.L202
	.loc 1 2304 25
	ldr	r3, .L203
	ldr	r3, [r3]
	ldr	r3, [r3, #52]
	.loc 1 2304 48
	ldr	r2, .L203
	ldr	r2, [r2]
	.loc 1 2304 35
	adds	r2, r2, #28
	.loc 1 2304 13
	mov	r0, r2
	blx	r3
.LVL3:
.L202:
	.loc 1 2307 1
	nop
	add	sp, sp, #16
.LCFI158:
	@ sp needed
	pop	{r4, pc}
.L204:
	.align	2
.L203:
	.word	pdw1000local
	.word	604344320
.LFE63:
	.size	dwt_isr, .-dwt_isr
	.section	.text.dwt_lowpowerlistenisr,"ax",%progbits
	.align	1
	.global	dwt_lowpowerlistenisr
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_lowpowerlistenisr, %function
dwt_lowpowerlistenisr:
.LFB64:
	.loc 1 2325 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
.LCFI159:
	sub	sp, sp, #16
.LCFI160:
	.loc 1 2326 33
	ldr	r3, .L211
	ldr	r4, [r3]
	.loc 1 2326 51
	movs	r1, #0
	movs	r0, #15
	bl	dwt_read32bitoffsetreg
	mov	r3, r0
	.loc 1 2326 49
	str	r3, [r4, #28]
	.loc 1 2326 12
	ldr	r3, [r4, #28]
	str	r3, [sp, #8]
	.loc 1 2333 5
	movs	r0, #0
	bl	dwt_setlowpowerlistening
	.loc 1 2335 5
	mov	r2, #28416
	movs	r1, #0
	movs	r0, #15
	bl	dwt_write32bitoffsetreg
	.loc 1 2337 17
	ldr	r3, .L211
	ldr	r3, [r3]
	.loc 1 2337 35
	movs	r2, #0
	strb	r2, [r3, #36]
	.loc 1 2340 15
	movs	r1, #0
	movs	r0, #16
	bl	dwt_read16bitoffsetreg
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 1 2343 9
	ldrh	r3, [sp, #6]	@ movhi
	ubfx	r3, r3, #0, #10
	strh	r3, [sp, #14]	@ movhi
	.loc 1 2344 20
	ldr	r3, .L211
	ldr	r3, [r3]
	ldrb	r3, [r3, #8]	@ zero_extendqisi2
	.loc 1 2344 7
	cmp	r3, #0
	bne	.L206
	.loc 1 2346 13
	ldrh	r3, [sp, #14]	@ movhi
	and	r3, r3, #127
	strh	r3, [sp, #14]	@ movhi
.L206:
	.loc 1 2348 17
	ldr	r3, .L211
	ldr	r3, [r3]
	.loc 1 2348 37
	ldrh	r2, [sp, #14]	@ movhi
	strh	r2, [r3, #32]	@ movhi
	.loc 1 2351 8
	ldrsh	r3, [sp, #6]
	.loc 1 2351 7
	cmp	r3, #0
	bge	.L207
	.loc 1 2353 39
	ldr	r3, .L211
	ldr	r3, [r3]
	ldrb	r2, [r3, #36]	@ zero_extendqisi2
	ldr	r3, .L211
	ldr	r3, [r3]
	orr	r2, r2, #1
	uxtb	r2, r2
	strb	r2, [r3, #36]
.L207:
	.loc 1 2357 68
	ldr	r3, .L211
	ldr	r3, [r3]
	.loc 1 2357 76
	adds	r3, r3, #34
	.loc 1 2357 5
	movs	r2, #2
	movs	r1, #0
	movs	r0, #17
	bl	dwt_readfromdevice
	.loc 1 2363 16
	ldr	r3, [sp, #8]
	and	r3, r3, #8
	.loc 1 2363 7
	cmp	r3, #0
	beq	.L208
	.loc 1 2363 51 discriminator 1
	ldr	r3, .L211
	ldr	r3, [r3]
	.loc 1 2363 65 discriminator 1
	ldrb	r3, [r3, #34]	@ zero_extendqisi2
	.loc 1 2363 69 discriminator 1
	and	r3, r3, #32
	.loc 1 2363 34 discriminator 1
	cmp	r3, #0
	bne	.L208
	.loc 1 2365 9
	movs	r2, #8
	movs	r1, #0
	movs	r0, #15
	bl	dwt_write32bitoffsetreg
	.loc 1 2366 37
	ldr	r3, .L211
	ldr	r3, [r3]
	ldr	r2, [r3, #28]
	ldr	r3, .L211
	ldr	r3, [r3]
	bic	r2, r2, #8
	str	r2, [r3, #28]
	.loc 1 2367 21
	ldr	r3, .L211
	ldr	r3, [r3]
	.loc 1 2367 33
	movs	r2, #0
	strb	r2, [r3, #26]
.L208:
	.loc 1 2371 20
	ldr	r3, .L211
	ldr	r3, [r3]
	ldr	r3, [r3, #44]
	.loc 1 2371 7
	cmp	r3, #0
	beq	.L210
	.loc 1 2373 21
	ldr	r3, .L211
	ldr	r3, [r3]
	ldr	r3, [r3, #44]
	.loc 1 2373 43
	ldr	r2, .L211
	ldr	r2, [r2]
	.loc 1 2373 30
	adds	r2, r2, #28
	.loc 1 2373 9
	mov	r0, r2
	blx	r3
.LVL4:
.L210:
	.loc 1 2375 1
	nop
	add	sp, sp, #16
.LCFI161:
	@ sp needed
	pop	{r4, pc}
.L212:
	.align	2
.L211:
	.word	pdw1000local
.LFE64:
	.size	dwt_lowpowerlistenisr, .-dwt_lowpowerlistenisr
	.section	.text.dwt_setleds,"ax",%progbits
	.align	1
	.global	dwt_setleds
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setleds, %function
dwt_setleds:
.LFB65:
	.loc 1 2395 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI162:
	sub	sp, sp, #20
.LCFI163:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 1 2398 14
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	and	r3, r3, #1
	.loc 1 2398 8
	cmp	r3, #0
	beq	.L214
	.loc 1 2401 15
	movs	r1, #0
	movs	r0, #38
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 2402 13
	ldr	r3, [sp, #12]
	bic	r3, r3, #15360
	str	r3, [sp, #12]
	.loc 1 2403 13
	ldr	r3, [sp, #12]
	orr	r3, r3, #5120
	str	r3, [sp, #12]
	.loc 1 2404 9
	ldr	r2, [sp, #12]
	movs	r1, #0
	movs	r0, #38
	bl	dwt_write32bitoffsetreg
	.loc 1 2407 15
	movs	r1, #0
	movs	r0, #54
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 2408 13
	ldr	r3, [sp, #12]
	orr	r3, r3, #8650752
	str	r3, [sp, #12]
	.loc 1 2409 9
	ldr	r2, [sp, #12]
	movs	r1, #0
	movs	r0, #54
	bl	dwt_write32bitoffsetreg
	.loc 1 2412 13
	mov	r3, #272
	str	r3, [sp, #12]
	.loc 1 2414 18
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	and	r3, r3, #2
	.loc 1 2414 12
	cmp	r3, #0
	beq	.L215
	.loc 1 2416 17
	ldr	r3, [sp, #12]
	orr	r3, r3, #983040
	str	r3, [sp, #12]
.L215:
	.loc 1 2418 9
	ldr	r2, [sp, #12]
	movs	r1, #40
	movs	r0, #54
	bl	dwt_write32bitoffsetreg
	.loc 1 2420 17
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	and	r3, r3, #2
	.loc 1 2420 11
	cmp	r3, #0
	beq	.L218
	.loc 1 2422 17
	ldr	r3, [sp, #12]
	bic	r3, r3, #983040
	str	r3, [sp, #12]
	.loc 1 2423 13
	ldr	r2, [sp, #12]
	movs	r1, #40
	movs	r0, #54
	bl	dwt_write32bitoffsetreg
	.loc 1 2433 1
	b	.L218
.L214:
	.loc 1 2429 15
	movs	r1, #0
	movs	r0, #38
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 2430 13
	ldr	r3, [sp, #12]
	bic	r3, r3, #15360
	str	r3, [sp, #12]
	.loc 1 2431 9
	ldr	r2, [sp, #12]
	movs	r1, #0
	movs	r0, #38
	bl	dwt_write32bitoffsetreg
.L218:
	.loc 1 2433 1
	nop
	add	sp, sp, #20
.LCFI164:
	@ sp needed
	ldr	pc, [sp], #4
.LFE65:
	.size	dwt_setleds, .-dwt_setleds
	.section	.text._dwt_enableclocks,"ax",%progbits
	.align	1
	.global	_dwt_enableclocks
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	_dwt_enableclocks, %function
_dwt_enableclocks:
.LFB66:
	.loc 1 2448 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI165:
	sub	sp, sp, #20
.LCFI166:
	str	r0, [sp, #4]
	.loc 1 2451 5
	add	r3, sp, #12
	movs	r2, #2
	movs	r1, #0
	movs	r0, #54
	bl	dwt_readfromdevice
	.loc 1 2452 5
	ldr	r3, [sp, #4]
	cmp	r3, #14
	bhi	.L232
	adr	r2, .L222
	ldr	pc, [r2, r3, lsl #2]
	.p2align 2
.L222:
	.word	.L230+1
	.word	.L229+1
	.word	.L228+1
	.word	.L232+1
	.word	.L232+1
	.word	.L232+1
	.word	.L232+1
	.word	.L227+1
	.word	.L226+1
	.word	.L232+1
	.word	.L232+1
	.word	.L225+1
	.word	.L224+1
	.word	.L223+1
	.word	.L221+1
	.p2align 1
.L229:
	.loc 1 2456 20
	movs	r3, #0
	strb	r3, [sp, #12]
	.loc 1 2457 25
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	.loc 1 2457 29
	bic	r3, r3, #1
	uxtb	r3, r3
	.loc 1 2457 20
	strb	r3, [sp, #13]
	.loc 1 2459 9
	b	.L231
.L230:
	.loc 1 2463 33
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	sxtb	r3, r3
	.loc 1 2463 37
	bic	r3, r3, #3
	sxtb	r3, r3
	.loc 1 2463 27
	orr	r3, r3, #1
	sxtb	r3, r3
	uxtb	r3, r3
	.loc 1 2463 20
	strb	r3, [sp, #12]
	.loc 1 2465 9
	b	.L231
.L228:
	.loc 1 2469 33
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	sxtb	r3, r3
	.loc 1 2469 37
	bic	r3, r3, #3
	sxtb	r3, r3
	.loc 1 2469 27
	orr	r3, r3, #2
	sxtb	r3, r3
	uxtb	r3, r3
	.loc 1 2469 20
	strb	r3, [sp, #12]
	.loc 1 2471 9
	b	.L231
.L227:
	.loc 1 2474 33
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	sxtb	r3, r3
	.loc 1 2474 37
	bic	r3, r3, #76
	sxtb	r3, r3
	.loc 1 2474 27
	orr	r3, r3, #72
	sxtb	r3, r3
	uxtb	r3, r3
	.loc 1 2474 20
	strb	r3, [sp, #12]
	.loc 1 2475 32
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	.loc 1 2475 20
	orn	r3, r3, #127
	uxtb	r3, r3
	strb	r3, [sp, #13]
	.loc 1 2477 9
	b	.L231
.L226:
	.loc 1 2480 25
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	.loc 1 2480 29
	bic	r3, r3, #76
	uxtb	r3, r3
	.loc 1 2480 20
	strb	r3, [sp, #12]
	.loc 1 2481 32
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	.loc 1 2481 27
	and	r3, r3, #127
	uxtb	r3, r3
	.loc 1 2481 20
	strb	r3, [sp, #13]
	.loc 1 2483 9
	b	.L231
.L225:
	.loc 1 2486 32
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	.loc 1 2486 20
	orr	r3, r3, #2
	uxtb	r3, r3
	strb	r3, [sp, #13]
	.loc 1 2488 9
	b	.L231
.L224:
	.loc 1 2491 25
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	.loc 1 2491 29
	bic	r3, r3, #2
	uxtb	r3, r3
	.loc 1 2491 20
	strb	r3, [sp, #13]
	.loc 1 2493 9
	b	.L231
.L223:
	.loc 1 2496 33
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	sxtb	r3, r3
	.loc 1 2496 37
	bic	r3, r3, #48
	sxtb	r3, r3
	.loc 1 2496 27
	orr	r3, r3, #32
	sxtb	r3, r3
	uxtb	r3, r3
	.loc 1 2496 20
	strb	r3, [sp, #12]
	.loc 1 2498 9
	b	.L231
.L221:
	.loc 1 2501 20
	movs	r3, #1
	strb	r3, [sp, #12]
	.loc 1 2502 20
	movs	r3, #3
	strb	r3, [sp, #13]
	.loc 1 2504 9
	b	.L231
.L232:
	.loc 1 2506 9
	nop
.L231:
	.loc 1 2511 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #0
	movs	r0, #54
	bl	dwt_writetodevice
	.loc 1 2512 5
	add	r3, sp, #12
	adds	r3, r3, #1
	movs	r2, #1
	movs	r1, #1
	movs	r0, #54
	bl	dwt_writetodevice
	.loc 1 2514 1
	nop
	add	sp, sp, #20
.LCFI167:
	@ sp needed
	ldr	pc, [sp], #4
.LFE66:
	.size	_dwt_enableclocks, .-_dwt_enableclocks
	.section	.text._dwt_disablesequencing,"ax",%progbits
	.align	1
	.global	_dwt_disablesequencing
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	_dwt_disablesequencing, %function
_dwt_disablesequencing:
.LFB67:
	.loc 1 2528 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI168:
	.loc 1 2529 5
	movs	r0, #0
	bl	_dwt_enableclocks
	.loc 1 2531 5
	movs	r2, #0
	movs	r1, #4
	movs	r0, #54
	bl	dwt_write16bitoffsetreg
	.loc 1 2532 1
	nop
	pop	{r3, pc}
.LFE67:
	.size	_dwt_disablesequencing, .-_dwt_disablesequencing
	.section	.text.dwt_setdelayedtrxtime,"ax",%progbits
	.align	1
	.global	dwt_setdelayedtrxtime
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setdelayedtrxtime, %function
dwt_setdelayedtrxtime:
.LFB68:
	.loc 1 2548 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI169:
	sub	sp, sp, #12
.LCFI170:
	str	r0, [sp, #4]
	.loc 1 2549 5
	ldr	r2, [sp, #4]
	movs	r1, #1
	movs	r0, #10
	bl	dwt_write32bitoffsetreg
	.loc 1 2551 1
	nop
	add	sp, sp, #12
.LCFI171:
	@ sp needed
	ldr	pc, [sp], #4
.LFE68:
	.size	dwt_setdelayedtrxtime, .-dwt_setdelayedtrxtime
	.section	.text.dwt_starttx,"ax",%progbits
	.align	1
	.global	dwt_starttx
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_starttx, %function
dwt_starttx:
.LFB69:
	.loc 1 2569 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI172:
	sub	sp, sp, #20
.LCFI173:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 1 2570 9
	movs	r3, #0
	str	r3, [sp, #12]
	.loc 1 2571 11
	movs	r3, #0
	strb	r3, [sp, #11]
	.loc 1 2572 12
	movs	r3, #0
	strh	r3, [sp, #8]	@ movhi
	.loc 1 2574 13
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	and	r3, r3, #2
	.loc 1 2574 7
	cmp	r3, #0
	beq	.L236
	.loc 1 2576 14
	movs	r3, #128
	strb	r3, [sp, #11]
	.loc 1 2577 9
	ldrb	r3, [sp, #11]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #0
	movs	r0, #13
	bl	dwt_write8bitoffsetreg
	.loc 1 2578 21
	ldr	r3, .L242
	ldr	r3, [r3]
	.loc 1 2578 33
	movs	r2, #1
	strb	r2, [r3, #26]
.L236:
	.loc 1 2581 14
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	and	r3, r3, #1
	.loc 1 2581 8
	cmp	r3, #0
	beq	.L237
	.loc 1 2584 14
	ldrb	r3, [sp, #11]
	orr	r3, r3, #6
	strb	r3, [sp, #11]
	.loc 1 2585 9
	ldrb	r3, [sp, #11]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #0
	movs	r0, #13
	bl	dwt_write8bitoffsetreg
	.loc 1 2586 21
	movs	r1, #3
	movs	r0, #15
	bl	dwt_read16bitoffsetreg
	mov	r3, r0
	strh	r3, [sp, #8]	@ movhi
	.loc 1 2587 24
	ldrh	r3, [sp, #8]
	and	r3, r3, #1032
	.loc 1 2587 12
	cmp	r3, #0
	bne	.L238
	.loc 1 2589 20
	movs	r3, #0
	str	r3, [sp, #12]
	b	.L240
.L238:
	.loc 1 2595 18
	movs	r3, #64
	strb	r3, [sp, #11]
	.loc 1 2596 13
	ldrb	r3, [sp, #11]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #0
	movs	r0, #13
	bl	dwt_write8bitoffsetreg
	.loc 1 2600 25
	ldr	r3, .L242
	ldr	r3, [r3]
	.loc 1 2600 37
	movs	r2, #0
	strb	r2, [r3, #26]
	.loc 1 2601 20
	mov	r3, #-1
	str	r3, [sp, #12]
	b	.L240
.L237:
	.loc 1 2606 14
	ldrb	r3, [sp, #11]
	orr	r3, r3, #2
	strb	r3, [sp, #11]
	.loc 1 2607 9
	ldrb	r3, [sp, #11]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #0
	movs	r0, #13
	bl	dwt_write8bitoffsetreg
.L240:
	.loc 1 2610 12
	ldr	r3, [sp, #12]
	.loc 1 2612 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI174:
	@ sp needed
	ldr	pc, [sp], #4
.L243:
	.align	2
.L242:
	.word	pdw1000local
.LFE69:
	.size	dwt_starttx, .-dwt_starttx
	.section	.text.dwt_forcetrxoff,"ax",%progbits
	.align	1
	.global	dwt_forcetrxoff
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_forcetrxoff, %function
dwt_forcetrxoff:
.LFB70:
	.loc 1 2626 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI175:
	sub	sp, sp, #12
.LCFI176:
	.loc 1 2630 12
	movs	r1, #0
	movs	r0, #14
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #4]
	.loc 1 2636 12
	bl	decamutexon
	str	r0, [sp]
	.loc 1 2638 5
	movs	r2, #0
	movs	r1, #0
	movs	r0, #14
	bl	dwt_write32bitoffsetreg
	.loc 1 2640 5
	movs	r2, #64
	movs	r1, #0
	movs	r0, #13
	bl	dwt_write8bitoffsetreg
	.loc 1 2643 5
	ldr	r2, .L245
	movs	r1, #0
	movs	r0, #15
	bl	dwt_write32bitoffsetreg
	.loc 1 2645 5
	bl	dwt_syncrxbufptrs
	.loc 1 2647 5
	ldr	r2, [sp, #4]
	movs	r1, #0
	movs	r0, #14
	bl	dwt_write32bitoffsetreg
	.loc 1 2650 5
	ldr	r0, [sp]
	bl	decamutexoff
	.loc 1 2651 17
	ldr	r3, .L245+4
	ldr	r3, [r3]
	.loc 1 2651 29
	movs	r2, #0
	strb	r2, [r3, #26]
	.loc 1 2653 1
	nop
	add	sp, sp, #12
.LCFI177:
	@ sp needed
	ldr	pc, [sp], #4
.L246:
	.align	2
.L245:
	.word	606601208
	.word	pdw1000local
.LFE70:
	.size	dwt_forcetrxoff, .-dwt_forcetrxoff
	.section	.text.dwt_syncrxbufptrs,"ax",%progbits
	.align	1
	.global	dwt_syncrxbufptrs
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_syncrxbufptrs, %function
dwt_syncrxbufptrs:
.LFB71:
	.loc 1 2668 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI178:
	sub	sp, sp, #12
.LCFI179:
	.loc 1 2671 12
	movs	r1, #3
	movs	r0, #15
	bl	dwt_read8bitoffsetreg
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 1 2673 42
	ldrb	r2, [sp, #7]	@ zero_extendqisi2
	.loc 1 2674 41
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	lsls	r3, r3, #1
	.loc 1 2673 42
	eors	r3, r3, r2
	and	r3, r3, #128
	.loc 1 2673 7
	cmp	r3, #0
	beq	.L249
	.loc 1 2676 9
	movs	r2, #1
	movs	r1, #3
	movs	r0, #13
	bl	dwt_write8bitoffsetreg
.L249:
	.loc 1 2678 1
	nop
	add	sp, sp, #12
.LCFI180:
	@ sp needed
	ldr	pc, [sp], #4
.LFE71:
	.size	dwt_syncrxbufptrs, .-dwt_syncrxbufptrs
	.section	.text.dwt_setsniffmode,"ax",%progbits
	.align	1
	.global	dwt_setsniffmode
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setsniffmode, %function
dwt_setsniffmode:
.LFB72:
	.loc 1 2700 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI181:
	sub	sp, sp, #20
.LCFI182:
	str	r0, [sp, #4]
	mov	r3, r1
	strb	r3, [sp, #3]
	mov	r3, r2
	strb	r3, [sp, #2]
	.loc 1 2702 8
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L251
.LBB4:
	.loc 1 2705 38
	ldrb	r3, [sp, #2]	@ zero_extendqisi2
	lsls	r3, r3, #8
	.loc 1 2705 44
	sxth	r2, r3
	ldrb	r3, [sp, #3]	@ zero_extendqisi2
	sxth	r3, r3
	orrs	r3, r3, r2
	sxth	r3, r3
	uxth	r3, r3
	.loc 1 2705 16
	bic	r3, r3, #240
	strh	r3, [sp, #14]	@ movhi
	.loc 1 2706 9
	ldrh	r3, [sp, #14]
	mov	r2, r3
	movs	r1, #0
	movs	r0, #29
	bl	dwt_write16bitoffsetreg
	.loc 1 2707 20
	movs	r1, #0
	movs	r0, #54
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #8]
	.loc 1 2708 18
	ldr	r3, [sp, #8]
	orr	r3, r3, #16777216
	str	r3, [sp, #8]
	.loc 1 2709 9
	ldr	r2, [sp, #8]
	movs	r1, #0
	movs	r0, #54
	bl	dwt_write32bitoffsetreg
.LBE4:
	.loc 1 2719 1
	b	.L253
.L251:
	.loc 1 2714 9
	movs	r2, #0
	movs	r1, #0
	movs	r0, #29
	bl	dwt_write16bitoffsetreg
	.loc 1 2715 20
	movs	r1, #0
	movs	r0, #54
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #8]
	.loc 1 2716 18
	ldr	r3, [sp, #8]
	bic	r3, r3, #16777216
	str	r3, [sp, #8]
	.loc 1 2717 9
	ldr	r2, [sp, #8]
	movs	r1, #0
	movs	r0, #54
	bl	dwt_write32bitoffsetreg
.L253:
	.loc 1 2719 1
	nop
	add	sp, sp, #20
.LCFI183:
	@ sp needed
	ldr	pc, [sp], #4
.LFE72:
	.size	dwt_setsniffmode, .-dwt_setsniffmode
	.section	.text.dwt_setlowpowerlistening,"ax",%progbits
	.align	1
	.global	dwt_setlowpowerlistening
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setlowpowerlistening, %function
dwt_setlowpowerlistening:
.LFB73:
	.loc 1 2752 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI184:
	sub	sp, sp, #20
.LCFI185:
	str	r0, [sp, #4]
	.loc 1 2753 23
	movs	r1, #4
	movs	r0, #54
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 2754 8
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L255
	.loc 1 2757 18
	ldr	r3, [sp, #12]
	orr	r3, r3, #12288
	str	r3, [sp, #12]
	b	.L256
.L255:
	.loc 1 2762 18
	ldr	r3, [sp, #12]
	bic	r3, r3, #12288
	str	r3, [sp, #12]
.L256:
	.loc 1 2764 5
	ldr	r2, [sp, #12]
	movs	r1, #4
	movs	r0, #54
	bl	dwt_write32bitoffsetreg
	.loc 1 2765 1
	nop
	add	sp, sp, #20
.LCFI186:
	@ sp needed
	ldr	pc, [sp], #4
.LFE73:
	.size	dwt_setlowpowerlistening, .-dwt_setlowpowerlistening
	.section	.text.dwt_setsnoozetime,"ax",%progbits
	.align	1
	.global	dwt_setsnoozetime
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setsnoozetime, %function
dwt_setsnoozetime:
.LFB74:
	.loc 1 2782 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI187:
	sub	sp, sp, #12
.LCFI188:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 1 2783 5
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #12
	movs	r0, #54
	bl	dwt_write8bitoffsetreg
	.loc 1 2784 1
	nop
	add	sp, sp, #12
.LCFI189:
	@ sp needed
	ldr	pc, [sp], #4
.LFE74:
	.size	dwt_setsnoozetime, .-dwt_setsnoozetime
	.section	.text.dwt_rxenable,"ax",%progbits
	.align	1
	.global	dwt_rxenable
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_rxenable, %function
dwt_rxenable:
.LFB75:
	.loc 1 2806 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI190:
	sub	sp, sp, #20
.LCFI191:
	str	r0, [sp, #4]
	.loc 1 2810 15
	ldr	r3, [sp, #4]
	and	r3, r3, #4
	.loc 1 2810 8
	cmp	r3, #0
	bne	.L259
	.loc 1 2812 9
	bl	dwt_syncrxbufptrs
.L259:
	.loc 1 2815 10
	mov	r3, #256
	strh	r3, [sp, #14]	@ movhi
	.loc 1 2817 14
	ldr	r3, [sp, #4]
	and	r3, r3, #1
	.loc 1 2817 8
	cmp	r3, #0
	beq	.L260
	.loc 1 2819 14
	ldrh	r3, [sp, #14]	@ movhi
	orr	r3, r3, #512
	strh	r3, [sp, #14]	@ movhi
.L260:
	.loc 1 2822 5
	ldrh	r3, [sp, #14]
	mov	r2, r3
	movs	r1, #0
	movs	r0, #13
	bl	dwt_write16bitoffsetreg
	.loc 1 2824 14
	ldr	r3, [sp, #4]
	and	r3, r3, #1
	.loc 1 2824 8
	cmp	r3, #0
	beq	.L261
	.loc 1 2826 17
	movs	r1, #3
	movs	r0, #15
	bl	dwt_read8bitoffsetreg
	mov	r3, r0
	strb	r3, [sp, #13]
	.loc 1 2827 20
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	and	r3, r3, #8
	.loc 1 2827 12
	cmp	r3, #0
	beq	.L261
	.loc 1 2829 13
	bl	dwt_forcetrxoff
	.loc 1 2831 22
	ldr	r3, [sp, #4]
	and	r3, r3, #2
	.loc 1 2831 15
	cmp	r3, #0
	bne	.L262
	.loc 1 2833 17
	mov	r2, #256
	movs	r1, #0
	movs	r0, #13
	bl	dwt_write16bitoffsetreg
.L262:
	.loc 1 2835 20
	mov	r3, #-1
	b	.L263
.L261:
	.loc 1 2839 12
	movs	r3, #0
.L263:
	.loc 1 2840 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI192:
	@ sp needed
	ldr	pc, [sp], #4
.LFE75:
	.size	dwt_rxenable, .-dwt_rxenable
	.section	.text.dwt_setrxtimeout,"ax",%progbits
	.align	1
	.global	dwt_setrxtimeout
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setrxtimeout, %function
dwt_setrxtimeout:
.LFB76:
	.loc 1 2857 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI193:
	sub	sp, sp, #20
.LCFI194:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 1 2860 12
	movs	r1, #3
	movs	r0, #4
	bl	dwt_read8bitoffsetreg
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 2862 7
	ldrh	r3, [sp, #6]
	cmp	r3, #0
	beq	.L265
	.loc 1 2864 9
	ldrh	r3, [sp, #6]
	mov	r2, r3
	movs	r1, #0
	movs	r0, #12
	bl	dwt_write16bitoffsetreg
	.loc 1 2866 14
	ldrb	r3, [sp, #15]
	orr	r3, r3, #16
	strb	r3, [sp, #15]
	.loc 1 2868 33
	ldr	r3, .L268
	ldr	r3, [r3]
	ldr	r2, [r3, #20]
	ldr	r3, .L268
	ldr	r3, [r3]
	orr	r2, r2, #268435456
	str	r2, [r3, #20]
	.loc 1 2870 9
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #3
	movs	r0, #4
	bl	dwt_write8bitoffsetreg
	.loc 1 2881 1
	b	.L267
.L265:
	.loc 1 2874 14
	ldrb	r3, [sp, #15]
	bic	r3, r3, #16
	strb	r3, [sp, #15]
	.loc 1 2876 33
	ldr	r3, .L268
	ldr	r3, [r3]
	ldr	r2, [r3, #20]
	ldr	r3, .L268
	ldr	r3, [r3]
	bic	r2, r2, #268435456
	str	r2, [r3, #20]
	.loc 1 2878 9
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #3
	movs	r0, #4
	bl	dwt_write8bitoffsetreg
.L267:
	.loc 1 2881 1
	nop
	add	sp, sp, #20
.LCFI195:
	@ sp needed
	ldr	pc, [sp], #4
.L269:
	.align	2
.L268:
	.word	pdw1000local
.LFE76:
	.size	dwt_setrxtimeout, .-dwt_setrxtimeout
	.section	.text.dwt_setpreambledetecttimeout,"ax",%progbits
	.align	1
	.global	dwt_setpreambledetecttimeout
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setpreambledetecttimeout, %function
dwt_setpreambledetecttimeout:
.LFB77:
	.loc 1 2898 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI196:
	sub	sp, sp, #12
.LCFI197:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 1 2899 5
	ldrh	r3, [sp, #6]
	mov	r2, r3
	movs	r1, #36
	movs	r0, #39
	bl	dwt_write16bitoffsetreg
	.loc 1 2900 1
	nop
	add	sp, sp, #12
.LCFI198:
	@ sp needed
	ldr	pc, [sp], #4
.LFE77:
	.size	dwt_setpreambledetecttimeout, .-dwt_setpreambledetecttimeout
	.section	.text.dwt_setinterrupt,"ax",%progbits
	.align	1
	.global	dwt_setinterrupt
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setinterrupt, %function
dwt_setinterrupt:
.LFB78:
	.loc 1 2927 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI199:
	sub	sp, sp, #20
.LCFI200:
	str	r0, [sp, #4]
	mov	r3, r1
	strb	r3, [sp, #3]
	.loc 1 2932 12
	bl	decamutexon
	str	r0, [sp, #8]
	.loc 1 2934 12
	movs	r1, #0
	movs	r0, #14
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 2936 7
	ldrb	r3, [sp, #3]	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L272
	.loc 1 2938 14
	ldr	r2, [sp, #12]
	ldr	r3, [sp, #4]
	orrs	r3, r3, r2
	str	r3, [sp, #12]
	b	.L273
.L272:
	.loc 1 2942 17
	ldr	r3, [sp, #4]
	mvns	r3, r3
	.loc 1 2942 14
	ldr	r2, [sp, #12]
	ands	r3, r3, r2
	str	r3, [sp, #12]
.L273:
	.loc 1 2944 5
	ldr	r2, [sp, #12]
	movs	r1, #0
	movs	r0, #14
	bl	dwt_write32bitoffsetreg
	.loc 1 2946 5
	ldr	r0, [sp, #8]
	bl	decamutexoff
	.loc 1 2947 1
	nop
	add	sp, sp, #20
.LCFI201:
	@ sp needed
	ldr	pc, [sp], #4
.LFE78:
	.size	dwt_setinterrupt, .-dwt_setinterrupt
	.section	.text.dwt_configeventcounters,"ax",%progbits
	.align	1
	.global	dwt_configeventcounters
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_configeventcounters, %function
dwt_configeventcounters:
.LFB79:
	.loc 1 2961 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI202:
	sub	sp, sp, #12
.LCFI203:
	str	r0, [sp, #4]
	.loc 1 2963 5
	movs	r2, #2
	movs	r1, #0
	movs	r0, #47
	bl	dwt_write8bitoffsetreg
	.loc 1 2965 7
	ldr	r3, [sp, #4]
	cmp	r3, #0
	beq	.L276
	.loc 1 2967 9
	movs	r2, #1
	movs	r1, #0
	movs	r0, #47
	bl	dwt_write8bitoffsetreg
.L276:
	.loc 1 2969 1
	nop
	add	sp, sp, #12
.LCFI204:
	@ sp needed
	ldr	pc, [sp], #4
.LFE79:
	.size	dwt_configeventcounters, .-dwt_configeventcounters
	.section	.text.dwt_readeventcounters,"ax",%progbits
	.align	1
	.global	dwt_readeventcounters
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readeventcounters, %function
dwt_readeventcounters:
.LFB80:
	.loc 1 2984 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI205:
	sub	sp, sp, #20
.LCFI206:
	str	r0, [sp, #4]
	.loc 1 2987 11
	movs	r1, #4
	movs	r0, #47
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 2988 26
	ldr	r3, [sp, #12]
	uxth	r3, r3
	ubfx	r3, r3, #0, #12
	uxth	r2, r3
	.loc 1 2988 19
	ldr	r3, [sp, #4]
	strh	r2, [r3]	@ movhi
	.loc 1 2989 27
	ldr	r3, [sp, #12]
	lsrs	r3, r3, #16
	.loc 1 2989 34
	uxth	r3, r3
	ubfx	r3, r3, #0, #12
	uxth	r2, r3
	.loc 1 2989 19
	ldr	r3, [sp, #4]
	strh	r2, [r3, #2]	@ movhi
	.loc 1 2991 12
	movs	r1, #8
	movs	r0, #47
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 2992 27
	ldr	r3, [sp, #12]
	uxth	r3, r3
	ubfx	r3, r3, #0, #12
	uxth	r2, r3
	.loc 1 2992 20
	ldr	r3, [sp, #4]
	strh	r2, [r3, #4]	@ movhi
	.loc 1 2993 28
	ldr	r3, [sp, #12]
	lsrs	r3, r3, #16
	.loc 1 2993 35
	uxth	r3, r3
	ubfx	r3, r3, #0, #12
	uxth	r2, r3
	.loc 1 2993 20
	ldr	r3, [sp, #4]
	strh	r2, [r3, #6]	@ movhi
	.loc 1 2995 12
	movs	r1, #12
	movs	r0, #47
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 2996 27
	ldr	r3, [sp, #12]
	uxth	r3, r3
	ubfx	r3, r3, #0, #12
	uxth	r2, r3
	.loc 1 2996 20
	ldr	r3, [sp, #4]
	strh	r2, [r3, #8]	@ movhi
	.loc 1 2997 28
	ldr	r3, [sp, #12]
	lsrs	r3, r3, #16
	.loc 1 2997 35
	uxth	r3, r3
	ubfx	r3, r3, #0, #12
	uxth	r2, r3
	.loc 1 2997 20
	ldr	r3, [sp, #4]
	strh	r2, [r3, #10]	@ movhi
	.loc 1 2999 12
	movs	r1, #16
	movs	r0, #47
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 3000 27
	ldr	r3, [sp, #12]
	lsrs	r3, r3, #16
	.loc 1 3000 34
	uxth	r3, r3
	ubfx	r3, r3, #0, #12
	uxth	r2, r3
	.loc 1 3000 19
	ldr	r3, [sp, #4]
	strh	r2, [r3, #14]	@ movhi
	.loc 1 3001 28
	ldr	r3, [sp, #12]
	uxth	r3, r3
	ubfx	r3, r3, #0, #12
	uxth	r2, r3
	.loc 1 3001 21
	ldr	r3, [sp, #4]
	strh	r2, [r3, #12]	@ movhi
	.loc 1 3003 12
	movs	r1, #20
	movs	r0, #47
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 3004 27
	ldr	r3, [sp, #12]
	lsrs	r3, r3, #16
	.loc 1 3004 34
	uxth	r3, r3
	ubfx	r3, r3, #0, #12
	uxth	r2, r3
	.loc 1 3004 19
	ldr	r3, [sp, #4]
	strh	r2, [r3, #18]	@ movhi
	.loc 1 3005 26
	ldr	r3, [sp, #12]
	uxth	r3, r3
	ubfx	r3, r3, #0, #12
	uxth	r2, r3
	.loc 1 3005 19
	ldr	r3, [sp, #4]
	strh	r2, [r3, #16]	@ movhi
	.loc 1 3007 12
	movs	r1, #24
	movs	r0, #47
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 3008 26
	ldr	r3, [sp, #12]
	uxth	r3, r3
	ubfx	r3, r3, #0, #12
	uxth	r2, r3
	.loc 1 3008 19
	ldr	r3, [sp, #4]
	strh	r2, [r3, #20]	@ movhi
	.loc 1 3009 27
	ldr	r3, [sp, #12]
	lsrs	r3, r3, #16
	.loc 1 3009 34
	uxth	r3, r3
	ubfx	r3, r3, #0, #12
	uxth	r2, r3
	.loc 1 3009 19
	ldr	r3, [sp, #4]
	strh	r2, [r3, #22]	@ movhi
	.loc 1 3011 1
	nop
	add	sp, sp, #20
.LCFI207:
	@ sp needed
	ldr	pc, [sp], #4
.LFE80:
	.size	dwt_readeventcounters, .-dwt_readeventcounters
	.section	.text.dwt_rxreset,"ax",%progbits
	.align	1
	.global	dwt_rxreset
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_rxreset, %function
dwt_rxreset:
.LFB81:
	.loc 1 3025 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI208:
	.loc 1 3027 5
	movs	r2, #224
	movs	r1, #3
	movs	r0, #54
	bl	dwt_write8bitoffsetreg
	.loc 1 3030 5
	movs	r2, #240
	movs	r1, #3
	movs	r0, #54
	bl	dwt_write8bitoffsetreg
	.loc 1 3031 1
	nop
	pop	{r3, pc}
.LFE81:
	.size	dwt_rxreset, .-dwt_rxreset
	.section	.text.dwt_softreset,"ax",%progbits
	.align	1
	.global	dwt_softreset
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_softreset, %function
dwt_softreset:
.LFB82:
	.loc 1 3045 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI209:
	.loc 1 3046 5
	bl	_dwt_disablesequencing
	.loc 1 3049 5
	movs	r2, #0
	movs	r1, #0
	movs	r0, #44
	bl	dwt_write16bitoffsetreg
	.loc 1 3051 5
	movs	r2, #0
	movs	r1, #6
	movs	r0, #44
	bl	dwt_write8bitoffsetreg
	.loc 1 3053 5
	bl	_dwt_aonarrayupload
	.loc 1 3056 5
	movs	r2, #0
	movs	r1, #3
	movs	r0, #54
	bl	dwt_write8bitoffsetreg
	.loc 1 3060 5
	movs	r0, #1
	bl	deca_sleep
	.loc 1 3063 5
	movs	r2, #240
	movs	r1, #3
	movs	r0, #54
	bl	dwt_write8bitoffsetreg
	.loc 1 3065 17
	ldr	r3, .L280
	ldr	r3, [r3]
	.loc 1 3065 29
	movs	r2, #0
	strb	r2, [r3, #26]
	.loc 1 3066 1
	nop
	pop	{r3, pc}
.L281:
	.align	2
.L280:
	.word	pdw1000local
.LFE82:
	.size	dwt_softreset, .-dwt_softreset
	.section	.text.dwt_setxtaltrim,"ax",%progbits
	.align	1
	.global	dwt_setxtaltrim
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_setxtaltrim, %function
dwt_setxtaltrim:
.LFB83:
	.loc 1 3081 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI210:
	sub	sp, sp, #20
.LCFI211:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 1 3083 39
	ldrsb	r3, [sp, #7]
	and	r3, r3, #31
	sxtb	r3, r3
	.loc 1 3083 30
	orr	r3, r3, #96
	sxtb	r3, r3
	.loc 1 3083 11
	strb	r3, [sp, #15]
	.loc 1 3084 5
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #14
	movs	r0, #43
	bl	dwt_write8bitoffsetreg
	.loc 1 3085 1
	nop
	add	sp, sp, #20
.LCFI212:
	@ sp needed
	ldr	pc, [sp], #4
.LFE83:
	.size	dwt_setxtaltrim, .-dwt_setxtaltrim
	.section	.text.dwt_getinitxtaltrim,"ax",%progbits
	.align	1
	.global	dwt_getinitxtaltrim
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_getinitxtaltrim, %function
dwt_getinitxtaltrim:
.LFB84:
	.loc 1 3102 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 3103 24
	ldr	r3, .L285
	ldr	r3, [r3]
	ldrb	r3, [r3, #16]	@ zero_extendqisi2
	.loc 1 3104 1
	mov	r0, r3
	bx	lr
.L286:
	.align	2
.L285:
	.word	pdw1000local
.LFE84:
	.size	dwt_getinitxtaltrim, .-dwt_getinitxtaltrim
	.section	.text.dwt_configcwmode,"ax",%progbits
	.align	1
	.global	dwt_configcwmode
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_configcwmode, %function
dwt_configcwmode:
.LFB85:
	.loc 1 3119 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI213:
	sub	sp, sp, #12
.LCFI214:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 1 3127 5
	bl	_dwt_disablesequencing
	.loc 1 3131 78
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	ldr	r2, .L288
	ldrb	r3, [r2, r3]	@ zero_extendqisi2
	mov	r2, r3
	.loc 1 3131 5
	ldr	r3, .L288+4
	ldr	r3, [r3, r2, lsl #2]
	mov	r2, r3
	movs	r1, #7
	movs	r0, #43
	bl	dwt_write32bitoffsetreg
	.loc 1 3132 79
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	ldr	r2, .L288
	ldrb	r3, [r2, r3]	@ zero_extendqisi2
	mov	r2, r3
	.loc 1 3132 5
	ldr	r3, .L288+8
	ldrb	r3, [r3, r2]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #11
	movs	r0, #43
	bl	dwt_write8bitoffsetreg
	.loc 1 3136 77
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	ldr	r2, .L288
	ldrb	r3, [r2, r3]	@ zero_extendqisi2
	mov	r2, r3
	.loc 1 3136 5
	ldr	r3, .L288+12
	ldr	r3, [r3, r2, lsl #2]
	mov	r2, r3
	movs	r1, #12
	movs	r0, #40
	bl	dwt_write32bitoffsetreg
	.loc 1 3141 5
	mov	r2, #2088960
	movs	r1, #0
	movs	r0, #40
	bl	dwt_write32bitoffsetreg
	.loc 1 3142 5
	ldr	r2, .L288+16
	movs	r1, #0
	movs	r0, #40
	bl	dwt_write32bitoffsetreg
	.loc 1 3147 5
	movs	r2, #34
	movs	r1, #0
	movs	r0, #54
	bl	dwt_write8bitoffsetreg
	.loc 1 3148 5
	movs	r2, #7
	movs	r1, #1
	movs	r0, #54
	bl	dwt_write8bitoffsetreg
	.loc 1 3151 5
	movs	r0, #0
	bl	dwt_setfinegraintxseq
	.loc 1 3154 5
	movs	r2, #19
	movs	r1, #12
	movs	r0, #42
	bl	dwt_write8bitoffsetreg
	.loc 1 3155 1
	nop
	add	sp, sp, #12
.LCFI215:
	@ sp needed
	ldr	pc, [sp], #4
.L289:
	.align	2
.L288:
	.word	chan_idx
	.word	fs_pll_cfg
	.word	fs_pll_tune
	.word	tx_config
	.word	6291200
.LFE85:
	.size	dwt_configcwmode, .-dwt_configcwmode
	.section	.text.dwt_configcontinuousframemode,"ax",%progbits
	.align	1
	.global	dwt_configcontinuousframemode
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_configcontinuousframemode, %function
dwt_configcontinuousframemode:
.LFB86:
	.loc 1 3171 1
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI216:
	sub	sp, sp, #12
.LCFI217:
	str	r0, [sp, #4]
	.loc 1 3175 5
	bl	_dwt_disablesequencing
	.loc 1 3180 5
	mov	r2, #2088960
	movs	r1, #0
	movs	r0, #40
	bl	dwt_write32bitoffsetreg
	.loc 1 3181 5
	ldr	r2, .L292
	movs	r1, #0
	movs	r0, #40
	bl	dwt_write32bitoffsetreg
	.loc 1 3186 5
	movs	r0, #2
	bl	_dwt_enableclocks
	.loc 1 3187 5
	movs	r0, #13
	bl	_dwt_enableclocks
	.loc 1 3190 7
	ldr	r3, [sp, #4]
	cmp	r3, #3
	bhi	.L291
	.loc 1 3192 29
	movs	r3, #4
	str	r3, [sp, #4]
.L291:
	.loc 1 3194 5
	ldr	r2, [sp, #4]
	movs	r1, #0
	movs	r0, #10
	bl	dwt_write32bitoffsetreg
	.loc 1 3199 5
	movs	r2, #16
	movs	r1, #36
	movs	r0, #47
	bl	dwt_write8bitoffsetreg
	.loc 1 3200 1
	nop
	add	sp, sp, #12
.LCFI218:
	@ sp needed
	ldr	pc, [sp], #4
.L293:
	.align	2
.L292:
	.word	6291200
.LFE86:
	.size	dwt_configcontinuousframemode, .-dwt_configcontinuousframemode
	.section	.text.dwt_readtempvbat,"ax",%progbits
	.align	1
	.global	dwt_readtempvbat
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readtempvbat, %function
dwt_readtempvbat:
.LFB87:
	.loc 1 3224 1
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI219:
	sub	sp, sp, #20
.LCFI220:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 1 3230 15
	movs	r3, #128
	strb	r3, [sp, #12]
	.loc 1 3231 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #17
	movs	r0, #40
	bl	dwt_writetodevice
	.loc 1 3233 15
	movs	r3, #10
	strb	r3, [sp, #12]
	.loc 1 3234 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #18
	movs	r0, #40
	bl	dwt_writetodevice
	.loc 1 3236 15
	movs	r3, #15
	strb	r3, [sp, #12]
	.loc 1 3237 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #18
	movs	r0, #40
	bl	dwt_writetodevice
	.loc 1 3240 15
	movs	r3, #0
	strb	r3, [sp, #12]
	.loc 1 3241 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #0
	movs	r0, #42
	bl	dwt_writetodevice
	.loc 1 3242 15
	movs	r3, #1
	strb	r3, [sp, #12]
	.loc 1 3243 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #0
	movs	r0, #42
	bl	dwt_writetodevice
	.loc 1 3245 7
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	cmp	r3, #1
	bne	.L295
	.loc 1 3247 9
	movs	r0, #1
	bl	deca_sleep
	.loc 1 3249 9
	add	r3, sp, #12
	movs	r2, #2
	movs	r1, #3
	movs	r0, #42
	bl	dwt_readfromdevice
	b	.L296
.L295:
	.loc 1 3253 9
	movs	r0, #0
	bl	_dwt_enableclocks
	.loc 1 3255 9
	add	r3, sp, #12
	movs	r2, #2
	movs	r1, #3
	movs	r0, #42
	bl	dwt_readfromdevice
	.loc 1 3257 9
	movs	r0, #1
	bl	_dwt_enableclocks
.L296:
	.loc 1 3260 14
	ldrb	r3, [sp, #12]
	strb	r3, [sp, #15]
	.loc 1 3261 14
	ldrb	r3, [sp, #13]
	strb	r3, [sp, #14]
	.loc 1 3263 15
	movs	r3, #0
	strb	r3, [sp, #12]
	.loc 1 3264 5
	add	r3, sp, #12
	movs	r2, #1
	movs	r1, #0
	movs	r0, #42
	bl	dwt_writetodevice
	.loc 1 3266 22
	ldrb	r3, [sp, #14]	@ zero_extendqisi2
	lsls	r3, r3, #8
	.loc 1 3266 26
	sxth	r2, r3
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	sxth	r3, r3
	orrs	r3, r3, r2
	sxth	r3, r3
	uxth	r3, r3
	.loc 1 3267 1
	mov	r0, r3
	add	sp, sp, #20
.LCFI221:
	@ sp needed
	ldr	pc, [sp], #4
.LFE87:
	.size	dwt_readtempvbat, .-dwt_readtempvbat
	.section	.text.dwt_readwakeuptemp,"ax",%progbits
	.align	1
	.global	dwt_readwakeuptemp
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readwakeuptemp, %function
dwt_readwakeuptemp:
.LFB88:
	.loc 1 3283 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI222:
	.loc 1 3284 12
	movs	r1, #4
	movs	r0, #42
	bl	dwt_read8bitoffsetreg
	mov	r3, r0
	.loc 1 3285 1
	mov	r0, r3
	pop	{r3, pc}
.LFE88:
	.size	dwt_readwakeuptemp, .-dwt_readwakeuptemp
	.section	.text.dwt_readwakeupvbat,"ax",%progbits
	.align	1
	.global	dwt_readwakeupvbat
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_readwakeupvbat, %function
dwt_readwakeupvbat:
.LFB89:
	.loc 1 3301 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI223:
	.loc 1 3302 12
	movs	r1, #3
	movs	r0, #42
	bl	dwt_read8bitoffsetreg
	mov	r3, r0
	.loc 1 3303 1
	mov	r0, r3
	pop	{r3, pc}
.LFE89:
	.size	dwt_readwakeupvbat, .-dwt_readwakeupvbat
	.section	.text.dwt_calcbandwidthtempadj,"ax",%progbits
	.align	1
	.global	dwt_calcbandwidthtempadj
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_calcbandwidthtempadj, %function
dwt_calcbandwidthtempadj:
.LFB90:
	.loc 1 3319 1
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI224:
	sub	sp, sp, #52
.LCFI225:
	mov	r3, r0
	strh	r3, [sp, #6]	@ movhi
	.loc 1 3322 11
	movs	r3, #0
	str	r3, [sp, #24]
	.loc 1 3323 12
	movs	r3, #0
	str	r3, [sp, #32]
	.loc 1 3324 12
	movs	r3, #0
	strh	r3, [sp, #22]	@ movhi
	.loc 1 3333 22
	movs	r1, #0
	movs	r0, #54
	bl	dwt_read8bitoffsetreg
	mov	r3, r0
	strb	r3, [sp, #21]
	.loc 1 3334 22
	movs	r1, #4
	movs	r0, #54
	bl	dwt_read16bitoffsetreg
	mov	r3, r0
	strh	r3, [sp, #18]	@ movhi
	.loc 1 3335 30
	movs	r1, #0
	movs	r0, #40
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #12]
	.loc 1 3338 5
	movs	r2, #1
	movs	r1, #0
	movs	r0, #54
	bl	dwt_write8bitoffsetreg
	.loc 1 3341 5
	movs	r2, #0
	movs	r1, #4
	movs	r0, #54
	bl	dwt_write16bitoffsetreg
	.loc 1 3344 5
	ldr	r2, .L309
	movs	r1, #0
	movs	r0, #40
	bl	dwt_write32bitoffsetreg
	.loc 1 3347 5
	movs	r2, #34
	movs	r1, #0
	movs	r0, #54
	bl	dwt_write8bitoffsetreg
	.loc 1 3350 13
	movs	r3, #128
	str	r3, [sp, #36]
	.loc 1 3352 15
	movs	r3, #128
	str	r3, [sp, #40]
	.loc 1 3356 18
	mov	r3, #300
	str	r3, [sp, #28]
	.loc 1 3358 12
	movs	r3, #0
	str	r3, [sp, #44]
	.loc 1 3358 5
	b	.L303
.L307:
	.loc 1 3361 19
	ldr	r3, [sp, #40]
	lsrs	r3, r3, #1
	str	r3, [sp, #40]
	.loc 1 3362 17
	ldr	r2, [sp, #36]
	ldr	r3, [sp, #40]
	orrs	r3, r3, r2
	str	r3, [sp, #36]
	.loc 1 3365 9
	ldr	r3, [sp, #36]
	uxtb	r3, r3
	mov	r2, r3
	movs	r1, #11
	movs	r0, #42
	bl	dwt_write8bitoffsetreg
	.loc 1 3368 9
	movs	r2, #188
	movs	r1, #8
	movs	r0, #42
	bl	dwt_write8bitoffsetreg
	.loc 1 3371 9
	movs	r2, #189
	movs	r1, #8
	movs	r0, #42
	bl	dwt_write8bitoffsetreg
	.loc 1 3373 9
	movs	r0, #100
	bl	deca_sleep
	.loc 1 3376 21
	movs	r1, #9
	movs	r0, #42
	bl	dwt_read16bitoffsetreg
	mov	r3, r0
	.loc 1 3376 19
	ubfx	r3, r3, #0, #12
	strh	r3, [sp, #22]	@ movhi
	.loc 1 3379 27
	ldrh	r2, [sp, #22]
	.loc 1 3379 44
	ldrh	r3, [sp, #6]
	.loc 1 3379 23
	subs	r3, r2, r3
	mov	r0, r3
	bl	abs
	str	r0, [sp, #24]
	.loc 1 3380 12
	ldr	r2, [sp, #24]
	ldr	r3, [sp, #28]
	cmp	r2, r3
	bge	.L304
	.loc 1 3382 26
	ldr	r3, [sp, #24]
	str	r3, [sp, #28]
	.loc 1 3383 21
	ldr	r3, [sp, #36]
	str	r3, [sp, #32]
.L304:
	.loc 1 3387 12
	ldrh	r2, [sp, #22]
	ldrh	r3, [sp, #6]
	cmp	r2, r3
	bls	.L305
	.loc 1 3389 21
	ldr	r2, [sp, #36]
	ldr	r3, [sp, #40]
	orrs	r3, r3, r2
	str	r3, [sp, #36]
	b	.L306
.L305:
	.loc 1 3392 34
	ldr	r3, [sp, #40]
	mvns	r3, r3
	.loc 1 3392 21
	ldr	r2, [sp, #36]
	ands	r3, r3, r2
	str	r3, [sp, #36]
.L306:
	.loc 1 3358 25 discriminator 2
	ldr	r3, [sp, #44]
	adds	r3, r3, #1
	str	r3, [sp, #44]
.L303:
	.loc 1 3358 5 discriminator 1
	ldr	r3, [sp, #44]
	cmp	r3, #6
	ble	.L307
	.loc 1 3396 5
	ldrb	r3, [sp, #21]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #0
	movs	r0, #54
	bl	dwt_write8bitoffsetreg
	.loc 1 3397 5
	ldrh	r3, [sp, #18]
	mov	r2, r3
	movs	r1, #4
	movs	r0, #54
	bl	dwt_write16bitoffsetreg
	.loc 1 3398 5
	ldr	r2, [sp, #12]
	movs	r1, #0
	movs	r0, #40
	bl	dwt_write32bitoffsetreg
	.loc 1 3401 12
	ldr	r3, [sp, #32]
	.loc 1 3402 1
	mov	r0, r3
	add	sp, sp, #52
.LCFI226:
	@ sp needed
	ldr	pc, [sp], #4
.L310:
	.align	2
.L309:
	.word	2074368
.LFE90:
	.size	dwt_calcbandwidthtempadj, .-dwt_calcbandwidthtempadj
	.section	.text._dwt_computetxpowersetting,"ax",%progbits
	.align	1
	.global	_dwt_computetxpowersetting
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	_dwt_computetxpowersetting, %function
_dwt_computetxpowersetting:
.LFB91:
	.loc 1 3420 1
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #32
.LCFI227:
	str	r0, [sp, #4]
	str	r1, [sp]
	.loc 1 3424 12
	movs	r3, #0
	str	r3, [sp, #20]
	.loc 1 3427 11
	movs	r3, #0
	str	r3, [sp, #16]
	.loc 1 3427 5
	b	.L312
.L316:
	.loc 1 3429 24
	movs	r3, #0
	str	r3, [sp, #28]
	.loc 1 3430 27
	ldr	r3, [sp]
	str	r3, [sp, #24]
	.loc 1 3431 47
	ldr	r3, [sp, #16]
	lsls	r3, r3, #3
	.loc 1 3431 42
	ldr	r2, [sp, #4]
	lsr	r3, r2, r3
	.loc 1 3431 60
	lsrs	r3, r3, #5
	uxtb	r3, r3
	.loc 1 3431 25
	and	r3, r3, #7
	strb	r3, [sp, #15]
	.loc 1 3432 49
	ldr	r3, [sp, #16]
	lsls	r3, r3, #3
	.loc 1 3432 44
	ldr	r2, [sp, #4]
	lsr	r3, r2, r3
	.loc 1 3432 54
	uxtb	r3, r3
	.loc 1 3432 28
	and	r3, r3, #31
	strb	r3, [sp, #14]
	.loc 1 3435 14
	b	.L313
.L315:
	.loc 1 3439 35
	ldrb	r2, [sp, #14]	@ zero_extendqisi2
	ldr	r3, [sp, #24]
	add	r3, r3, r2
	.loc 1 3439 15
	cmp	r3, #20
	ble	.L314
	.loc 1 3441 32
	ldr	r3, [sp, #28]
	adds	r3, r3, #1
	str	r3, [sp, #28]
	.loc 1 3442 35
	ldr	r3, [sp, #24]
	subs	r3, r3, #5
	str	r3, [sp, #24]
	b	.L313
.L314:
	.loc 1 3444 40
	ldrb	r2, [sp, #14]	@ zero_extendqisi2
	ldr	r3, [sp, #24]
	add	r3, r3, r2
	.loc 1 3444 20
	cmp	r3, #3
	bgt	.L313
	.loc 1 3446 32
	ldr	r3, [sp, #28]
	adds	r3, r3, #1
	str	r3, [sp, #28]
	.loc 1 3447 35
	ldr	r3, [sp, #24]
	adds	r3, r3, #5
	str	r3, [sp, #24]
.L313:
	.loc 1 3435 35
	ldrb	r2, [sp, #14]	@ zero_extendqisi2
	ldr	r3, [sp, #24]
	add	r3, r3, r2
	.loc 1 3435 14
	cmp	r3, #3
	ble	.L315
	.loc 1 3436 35 discriminator 1
	ldrb	r2, [sp, #14]	@ zero_extendqisi2
	ldr	r3, [sp, #24]
	add	r3, r3, r2
	.loc 1 3435 60 discriminator 1
	cmp	r3, #20
	bgt	.L315
	.loc 1 3451 39 discriminator 2
	ldr	r3, [sp, #28]
	uxtb	r2, r3
	.loc 1 3451 21 discriminator 2
	ldrb	r3, [sp, #15]
	add	r3, r3, r2
	strb	r3, [sp, #13]
	.loc 1 3452 45 discriminator 2
	ldr	r3, [sp, #24]
	uxtb	r2, r3
	.loc 1 3452 24 discriminator 2
	ldrb	r3, [sp, #14]
	add	r3, r3, r2
	strb	r3, [sp, #12]
	.loc 1 3454 47 discriminator 2
	ldrb	r3, [sp, #13]	@ zero_extendqisi2
	lsls	r2, r3, #5
	.loc 1 3454 53 discriminator 2
	ldrb	r3, [sp, #12]	@ zero_extendqisi2
	orrs	r3, r3, r2
	.loc 1 3454 24 discriminator 2
	mov	r2, r3
	.loc 1 3454 78 discriminator 2
	ldr	r3, [sp, #16]
	lsls	r3, r3, #3
	.loc 1 3454 72 discriminator 2
	lsl	r3, r2, r3
	.loc 1 3454 20 discriminator 2
	ldr	r2, [sp, #20]
	orrs	r3, r3, r2
	str	r3, [sp, #20]
	.loc 1 3427 24 discriminator 2
	ldr	r3, [sp, #16]
	adds	r3, r3, #1
	str	r3, [sp, #16]
.L312:
	.loc 1 3427 5 discriminator 1
	ldr	r3, [sp, #16]
	cmp	r3, #3
	ble	.L316
	.loc 1 3457 12
	ldr	r3, [sp, #20]
	.loc 1 3458 1
	mov	r0, r3
	add	sp, sp, #32
.LCFI228:
	@ sp needed
	bx	lr
.LFE91:
	.size	_dwt_computetxpowersetting, .-_dwt_computetxpowersetting
	.global	__aeabi_dsub
	.global	__aeabi_dmul
	.global	__aeabi_ddiv
	.global	__aeabi_d2iz
	.section	.text.dwt_calcpowertempadj,"ax",%progbits
	.align	1
	.global	dwt_calcpowertempadj
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_calcpowertempadj, %function
dwt_calcpowertempadj:
.LFB92:
	.loc 1 3482 1
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
.LCFI229:
	sub	sp, sp, #40
.LCFI230:
	mov	r3, r0
	str	r1, [sp, #16]
	vstr.64	d0, [sp, #8]
	vstr.64	d1, [sp]
	strb	r3, [sp, #23]
	.loc 1 3487 16
	ldrd	r2, [sp]
	ldrd	r0, [sp, #8]
	bl	__aeabi_dsub
.LVL5:
	mov	r3, r0
	mov	r4, r1
	strd	r3, [sp, #32]
	.loc 1 3490 59
	ldrb	r3, [sp, #23]	@ zero_extendqisi2
	ldr	r2, .L320
	ldrb	r3, [r2, r3]	@ zero_extendqisi2
	.loc 1 3490 50
	ldr	r2, .L320+4
	lsls	r3, r3, #3
	add	r3, r3, r2
	ldrd	r3, [r3]
	.loc 1 3490 17
	mov	r2, r3
	mov	r3, r4
	ldrd	r0, [sp, #32]
	bl	__aeabi_dmul
.LVL6:
	mov	r3, r0
	mov	r4, r1
	strd	r3, [sp, #24]
	.loc 1 3493 73
	mov	r2, #0
	ldr	r3, .L320+8
	ldrd	r0, [sp, #24]
	bl	__aeabi_ddiv
.LVL7:
	mov	r3, r0
	mov	r4, r1
	.loc 1 3493 12
	mov	r0, r3
	mov	r1, r4
	bl	__aeabi_d2iz
.LVL8:
	mov	r3, r0
	mov	r1, r3
	ldr	r0, [sp, #16]
	bl	_dwt_computetxpowersetting
	mov	r3, r0
	.loc 1 3494 1
	mov	r0, r3
	add	sp, sp, #40
.LCFI231:
	@ sp needed
	pop	{r4, pc}
.L321:
	.align	2
.L320:
	.word	chan_idx
	.word	txpwr_compensation
	.word	1071644672
.LFE92:
	.size	dwt_calcpowertempadj, .-dwt_calcpowertempadj
	.section	.text.dwt_calcpgcount,"ax",%progbits
	.align	1
	.global	dwt_calcpgcount
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	dwt_calcpgcount, %function
dwt_calcpgcount:
.LFB93:
	.loc 1 3511 1
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{lr}
.LCFI232:
	sub	sp, sp, #36
.LCFI233:
	mov	r3, r0
	strb	r3, [sp, #7]
	.loc 1 3513 15
	movs	r3, #10
	str	r3, [sp, #20]
	.loc 1 3514 12
	movs	r3, #0
	str	r3, [sp, #28]
	.loc 1 3515 12
	movs	r3, #0
	strh	r3, [sp, #18]	@ movhi
	.loc 1 3515 31
	movs	r3, #0
	strh	r3, [sp, #16]	@ movhi
	.loc 1 3516 9
	movs	r3, #0
	str	r3, [sp, #24]
	.loc 1 3524 22
	movs	r1, #0
	movs	r0, #54
	bl	dwt_read8bitoffsetreg
	mov	r3, r0
	strb	r3, [sp, #15]
	.loc 1 3525 22
	movs	r1, #4
	movs	r0, #54
	bl	dwt_read16bitoffsetreg
	mov	r3, r0
	strh	r3, [sp, #12]	@ movhi
	.loc 1 3526 30
	movs	r1, #0
	movs	r0, #40
	bl	dwt_read32bitoffsetreg
	str	r0, [sp, #8]
	.loc 1 3529 5
	movs	r2, #1
	movs	r1, #0
	movs	r0, #54
	bl	dwt_write8bitoffsetreg
	.loc 1 3531 5
	movs	r2, #0
	movs	r1, #4
	movs	r0, #54
	bl	dwt_write16bitoffsetreg
	.loc 1 3533 5
	ldr	r2, .L326
	movs	r1, #0
	movs	r0, #40
	bl	dwt_write32bitoffsetreg
	.loc 1 3535 5
	movs	r2, #34
	movs	r1, #0
	movs	r0, #54
	bl	dwt_write8bitoffsetreg
	.loc 1 3537 11
	movs	r3, #0
	str	r3, [sp, #24]
	.loc 1 3537 5
	b	.L323
.L324:
	.loc 1 3539 9 discriminator 3
	ldrb	r3, [sp, #7]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #11
	movs	r0, #42
	bl	dwt_write8bitoffsetreg
	.loc 1 3542 9 discriminator 3
	movs	r2, #188
	movs	r1, #8
	movs	r0, #42
	bl	dwt_write8bitoffsetreg
	.loc 1 3545 9 discriminator 3
	movs	r2, #189
	movs	r1, #8
	movs	r0, #42
	bl	dwt_write8bitoffsetreg
	.loc 1 3548 9 discriminator 3
	movs	r0, #100
	bl	deca_sleep
	.loc 1 3551 17 discriminator 3
	movs	r1, #9
	movs	r0, #42
	bl	dwt_read16bitoffsetreg
	mov	r3, r0
	.loc 1 3551 15 discriminator 3
	ubfx	r3, r3, #0, #12
	strh	r3, [sp, #16]	@ movhi
	.loc 1 3553 19 discriminator 3
	ldrh	r3, [sp, #16]
	ldr	r2, [sp, #28]
	add	r3, r3, r2
	str	r3, [sp, #28]
	.loc 1 3537 34 discriminator 3
	ldr	r3, [sp, #24]
	adds	r3, r3, #1
	str	r3, [sp, #24]
.L323:
	.loc 1 3537 5 discriminator 1
	ldr	r2, [sp, #24]
	ldr	r3, [sp, #20]
	cmp	r2, r3
	blt	.L324
	.loc 1 3557 5
	ldrb	r3, [sp, #15]	@ zero_extendqisi2
	mov	r2, r3
	movs	r1, #0
	movs	r0, #54
	bl	dwt_write8bitoffsetreg
	.loc 1 3558 5
	ldrh	r3, [sp, #12]
	mov	r2, r3
	movs	r1, #4
	movs	r0, #54
	bl	dwt_write16bitoffsetreg
	.loc 1 3559 5
	ldr	r2, [sp, #8]
	movs	r1, #0
	movs	r0, #40
	bl	dwt_write32bitoffsetreg
	.loc 1 3561 37
	ldr	r3, [sp, #20]
	ldr	r2, [sp, #28]
	udiv	r3, r2, r3
	.loc 1 3561 19
	strh	r3, [sp, #18]	@ movhi
	.loc 1 3562 12
	ldrh	r3, [sp, #18]
	.loc 1 3563 1
	mov	r0, r3
	add	sp, sp, #36
.LCFI234:
	@ sp needed
	ldr	pc, [sp], #4
.L327:
	.align	2
.L326:
	.word	2074368
.LFE93:
	.size	dwt_calcpgcount, .-dwt_calcpgcount
	.section	.debug_frame,"",%progbits
.Lframe0:
	.4byte	.LECIE0-.LSCIE0
.LSCIE0:
	.4byte	0xffffffff
	.byte	0x3
	.ascii	"\000"
	.uleb128 0x1
	.sleb128 -4
	.uleb128 0xe
	.byte	0xc
	.uleb128 0xd
	.uleb128 0
	.align	2
.LECIE0:
.LSFDE0:
	.4byte	.LEFDE0-.LASFDE0
.LASFDE0:
	.4byte	.Lframe0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x4
	.4byte	.LCFI0-.LFB0
	.byte	0xe
	.uleb128 0x8
	.byte	0x4
	.4byte	.LCFI1-.LCFI0
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x4
	.4byte	.LCFI2-.LFB1
	.byte	0xe
	.uleb128 0x8
	.byte	0x84
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI3-.LCFI2
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI4-.LCFI3
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.align	2
.LEFDE4:
.LSFDE6:
	.4byte	.LEFDE6-.LASFDE6
.LASFDE6:
	.4byte	.Lframe0
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.byte	0x4
	.4byte	.LCFI5-.LFB3
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI6-.LCFI5
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI7-.LCFI6
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE6:
.LSFDE8:
	.4byte	.LEFDE8-.LASFDE8
.LASFDE8:
	.4byte	.Lframe0
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.byte	0x4
	.4byte	.LCFI8-.LFB4
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI9-.LCFI8
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI10-.LCFI9
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE8:
.LSFDE10:
	.4byte	.LEFDE10-.LASFDE10
.LASFDE10:
	.4byte	.Lframe0
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.byte	0x4
	.4byte	.LCFI11-.LFB5
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI12-.LCFI11
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI13-.LCFI12
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE10:
.LSFDE12:
	.4byte	.LEFDE12-.LASFDE12
.LASFDE12:
	.4byte	.Lframe0
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.byte	0x4
	.4byte	.LCFI14-.LFB6
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI15-.LCFI14
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI16-.LCFI15
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE12:
.LSFDE14:
	.4byte	.LEFDE14-.LASFDE14
.LASFDE14:
	.4byte	.Lframe0
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.align	2
.LEFDE14:
.LSFDE16:
	.4byte	.LEFDE16-.LASFDE16
.LASFDE16:
	.4byte	.Lframe0
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.align	2
.LEFDE16:
.LSFDE18:
	.4byte	.LEFDE18-.LASFDE18
.LASFDE18:
	.4byte	.Lframe0
	.4byte	.LFB9
	.4byte	.LFE9-.LFB9
	.byte	0x4
	.4byte	.LCFI17-.LFB9
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE18:
.LSFDE20:
	.4byte	.LEFDE20-.LASFDE20
.LASFDE20:
	.4byte	.Lframe0
	.4byte	.LFB10
	.4byte	.LFE10-.LFB10
	.byte	0x4
	.4byte	.LCFI18-.LFB10
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI19-.LCFI18
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI20-.LCFI19
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE20:
.LSFDE22:
	.4byte	.LEFDE22-.LASFDE22
.LASFDE22:
	.4byte	.Lframe0
	.4byte	.LFB11
	.4byte	.LFE11-.LFB11
	.byte	0x4
	.4byte	.LCFI21-.LFB11
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI22-.LCFI21
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI23-.LCFI22
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE22:
.LSFDE24:
	.4byte	.LEFDE24-.LASFDE24
.LASFDE24:
	.4byte	.Lframe0
	.4byte	.LFB12
	.4byte	.LFE12-.LFB12
	.byte	0x4
	.4byte	.LCFI24-.LFB12
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI25-.LCFI24
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI26-.LCFI25
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE24:
.LSFDE26:
	.4byte	.LEFDE26-.LASFDE26
.LASFDE26:
	.4byte	.Lframe0
	.4byte	.LFB13
	.4byte	.LFE13-.LFB13
	.byte	0x4
	.4byte	.LCFI27-.LFB13
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI28-.LCFI27
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI29-.LCFI28
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE26:
.LSFDE28:
	.4byte	.LEFDE28-.LASFDE28
.LASFDE28:
	.4byte	.Lframe0
	.4byte	.LFB14
	.4byte	.LFE14-.LFB14
	.byte	0x4
	.4byte	.LCFI30-.LFB14
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI31-.LCFI30
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI32-.LCFI31
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE28:
.LSFDE30:
	.4byte	.LEFDE30-.LASFDE30
.LASFDE30:
	.4byte	.Lframe0
	.4byte	.LFB15
	.4byte	.LFE15-.LFB15
	.byte	0x4
	.4byte	.LCFI33-.LFB15
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI34-.LCFI33
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI35-.LCFI34
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE30:
.LSFDE32:
	.4byte	.LEFDE32-.LASFDE32
.LASFDE32:
	.4byte	.Lframe0
	.4byte	.LFB16
	.4byte	.LFE16-.LFB16
	.byte	0x4
	.4byte	.LCFI36-.LFB16
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI37-.LCFI36
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI38-.LCFI37
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE32:
.LSFDE34:
	.4byte	.LEFDE34-.LASFDE34
.LASFDE34:
	.4byte	.Lframe0
	.4byte	.LFB17
	.4byte	.LFE17-.LFB17
	.byte	0x4
	.4byte	.LCFI39-.LFB17
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI40-.LCFI39
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI41-.LCFI40
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE34:
.LSFDE36:
	.4byte	.LEFDE36-.LASFDE36
.LASFDE36:
	.4byte	.Lframe0
	.4byte	.LFB18
	.4byte	.LFE18-.LFB18
	.byte	0x4
	.4byte	.LCFI42-.LFB18
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI43-.LCFI42
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI44-.LCFI43
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE36:
.LSFDE38:
	.4byte	.LEFDE38-.LASFDE38
.LASFDE38:
	.4byte	.Lframe0
	.4byte	.LFB19
	.4byte	.LFE19-.LFB19
	.byte	0x4
	.4byte	.LCFI45-.LFB19
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI46-.LCFI45
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI47-.LCFI46
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE38:
.LSFDE40:
	.4byte	.LEFDE40-.LASFDE40
.LASFDE40:
	.4byte	.Lframe0
	.4byte	.LFB20
	.4byte	.LFE20-.LFB20
	.byte	0x4
	.4byte	.LCFI48-.LFB20
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI49-.LCFI48
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI50-.LCFI49
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE40:
.LSFDE42:
	.4byte	.LEFDE42-.LASFDE42
.LASFDE42:
	.4byte	.Lframe0
	.4byte	.LFB21
	.4byte	.LFE21-.LFB21
	.byte	0x4
	.4byte	.LCFI51-.LFB21
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE42:
.LSFDE44:
	.4byte	.LEFDE44-.LASFDE44
.LASFDE44:
	.4byte	.Lframe0
	.4byte	.LFB22
	.4byte	.LFE22-.LFB22
	.byte	0x4
	.4byte	.LCFI52-.LFB22
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE44:
.LSFDE46:
	.4byte	.LEFDE46-.LASFDE46
.LASFDE46:
	.4byte	.Lframe0
	.4byte	.LFB23
	.4byte	.LFE23-.LFB23
	.byte	0x4
	.4byte	.LCFI53-.LFB23
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI54-.LCFI53
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI55-.LCFI54
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE46:
.LSFDE48:
	.4byte	.LEFDE48-.LASFDE48
.LASFDE48:
	.4byte	.Lframe0
	.4byte	.LFB24
	.4byte	.LFE24-.LFB24
	.byte	0x4
	.4byte	.LCFI56-.LFB24
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE48:
.LSFDE50:
	.4byte	.LEFDE50-.LASFDE50
.LASFDE50:
	.4byte	.Lframe0
	.4byte	.LFB25
	.4byte	.LFE25-.LFB25
	.byte	0x4
	.4byte	.LCFI57-.LFB25
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE50:
.LSFDE52:
	.4byte	.LEFDE52-.LASFDE52
.LASFDE52:
	.4byte	.Lframe0
	.4byte	.LFB26
	.4byte	.LFE26-.LFB26
	.byte	0x4
	.4byte	.LCFI58-.LFB26
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE52:
.LSFDE54:
	.4byte	.LEFDE54-.LASFDE54
.LASFDE54:
	.4byte	.Lframe0
	.4byte	.LFB27
	.4byte	.LFE27-.LFB27
	.byte	0x4
	.4byte	.LCFI59-.LFB27
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI60-.LCFI59
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI61-.LCFI60
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE54:
.LSFDE56:
	.4byte	.LEFDE56-.LASFDE56
.LASFDE56:
	.4byte	.Lframe0
	.4byte	.LFB28
	.4byte	.LFE28-.LFB28
	.byte	0x4
	.4byte	.LCFI62-.LFB28
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI63-.LCFI62
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI64-.LCFI63
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE56:
.LSFDE58:
	.4byte	.LEFDE58-.LASFDE58
.LASFDE58:
	.4byte	.Lframe0
	.4byte	.LFB29
	.4byte	.LFE29-.LFB29
	.byte	0x4
	.4byte	.LCFI65-.LFB29
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI66-.LCFI65
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI67-.LCFI66
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE58:
.LSFDE60:
	.4byte	.LEFDE60-.LASFDE60
.LASFDE60:
	.4byte	.Lframe0
	.4byte	.LFB30
	.4byte	.LFE30-.LFB30
	.byte	0x4
	.4byte	.LCFI68-.LFB30
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI69-.LCFI68
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI70-.LCFI69
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE60:
.LSFDE62:
	.4byte	.LEFDE62-.LASFDE62
.LASFDE62:
	.4byte	.Lframe0
	.4byte	.LFB31
	.4byte	.LFE31-.LFB31
	.byte	0x4
	.4byte	.LCFI71-.LFB31
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI72-.LCFI71
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI73-.LCFI72
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE62:
.LSFDE64:
	.4byte	.LEFDE64-.LASFDE64
.LASFDE64:
	.4byte	.Lframe0
	.4byte	.LFB32
	.4byte	.LFE32-.LFB32
	.byte	0x4
	.4byte	.LCFI74-.LFB32
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI75-.LCFI74
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI76-.LCFI75
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE64:
.LSFDE66:
	.4byte	.LEFDE66-.LASFDE66
.LASFDE66:
	.4byte	.Lframe0
	.4byte	.LFB33
	.4byte	.LFE33-.LFB33
	.byte	0x4
	.4byte	.LCFI77-.LFB33
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI78-.LCFI77
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI79-.LCFI78
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE66:
.LSFDE68:
	.4byte	.LEFDE68-.LASFDE68
.LASFDE68:
	.4byte	.Lframe0
	.4byte	.LFB34
	.4byte	.LFE34-.LFB34
	.byte	0x4
	.4byte	.LCFI80-.LFB34
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI81-.LCFI80
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI82-.LCFI81
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE68:
.LSFDE70:
	.4byte	.LEFDE70-.LASFDE70
.LASFDE70:
	.4byte	.Lframe0
	.4byte	.LFB35
	.4byte	.LFE35-.LFB35
	.byte	0x4
	.4byte	.LCFI83-.LFB35
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI84-.LCFI83
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI85-.LCFI84
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE70:
.LSFDE72:
	.4byte	.LEFDE72-.LASFDE72
.LASFDE72:
	.4byte	.Lframe0
	.4byte	.LFB36
	.4byte	.LFE36-.LFB36
	.byte	0x4
	.4byte	.LCFI86-.LFB36
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI87-.LCFI86
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI88-.LCFI87
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE72:
.LSFDE74:
	.4byte	.LEFDE74-.LASFDE74
.LASFDE74:
	.4byte	.Lframe0
	.4byte	.LFB37
	.4byte	.LFE37-.LFB37
	.byte	0x4
	.4byte	.LCFI89-.LFB37
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI90-.LCFI89
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI91-.LCFI90
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE74:
.LSFDE76:
	.4byte	.LEFDE76-.LASFDE76
.LASFDE76:
	.4byte	.Lframe0
	.4byte	.LFB38
	.4byte	.LFE38-.LFB38
	.byte	0x4
	.4byte	.LCFI92-.LFB38
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI93-.LCFI92
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI94-.LCFI93
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE76:
.LSFDE78:
	.4byte	.LEFDE78-.LASFDE78
.LASFDE78:
	.4byte	.Lframe0
	.4byte	.LFB39
	.4byte	.LFE39-.LFB39
	.byte	0x4
	.4byte	.LCFI95-.LFB39
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI96-.LCFI95
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI97-.LCFI96
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE78:
.LSFDE80:
	.4byte	.LEFDE80-.LASFDE80
.LASFDE80:
	.4byte	.Lframe0
	.4byte	.LFB40
	.4byte	.LFE40-.LFB40
	.byte	0x4
	.4byte	.LCFI98-.LFB40
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI99-.LCFI98
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI100-.LCFI99
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE80:
.LSFDE82:
	.4byte	.LEFDE82-.LASFDE82
.LASFDE82:
	.4byte	.Lframe0
	.4byte	.LFB41
	.4byte	.LFE41-.LFB41
	.byte	0x4
	.4byte	.LCFI101-.LFB41
	.byte	0xe
	.uleb128 0x8
	.byte	0x84
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI102-.LCFI101
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI103-.LCFI102
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE82:
.LSFDE84:
	.4byte	.LEFDE84-.LASFDE84
.LASFDE84:
	.4byte	.Lframe0
	.4byte	.LFB42
	.4byte	.LFE42-.LFB42
	.byte	0x4
	.4byte	.LCFI104-.LFB42
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI105-.LCFI104
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI106-.LCFI105
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE84:
.LSFDE86:
	.4byte	.LEFDE86-.LASFDE86
.LASFDE86:
	.4byte	.Lframe0
	.4byte	.LFB43
	.4byte	.LFE43-.LFB43
	.byte	0x4
	.4byte	.LCFI107-.LFB43
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI108-.LCFI107
	.byte	0xe
	.uleb128 0x28
	.byte	0x4
	.4byte	.LCFI109-.LCFI108
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE86:
.LSFDE88:
	.4byte	.LEFDE88-.LASFDE88
.LASFDE88:
	.4byte	.Lframe0
	.4byte	.LFB44
	.4byte	.LFE44-.LFB44
	.byte	0x4
	.4byte	.LCFI110-.LFB44
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI111-.LCFI110
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI112-.LCFI111
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE88:
.LSFDE90:
	.4byte	.LEFDE90-.LASFDE90
.LASFDE90:
	.4byte	.Lframe0
	.4byte	.LFB45
	.4byte	.LFE45-.LFB45
	.byte	0x4
	.4byte	.LCFI113-.LFB45
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI114-.LCFI113
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI115-.LCFI114
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE90:
.LSFDE92:
	.4byte	.LEFDE92-.LASFDE92
.LASFDE92:
	.4byte	.Lframe0
	.4byte	.LFB46
	.4byte	.LFE46-.LFB46
	.byte	0x4
	.4byte	.LCFI116-.LFB46
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE92:
.LSFDE94:
	.4byte	.LEFDE94-.LASFDE94
.LASFDE94:
	.4byte	.Lframe0
	.4byte	.LFB47
	.4byte	.LFE47-.LFB47
	.byte	0x4
	.4byte	.LCFI117-.LFB47
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE94:
.LSFDE96:
	.4byte	.LEFDE96-.LASFDE96
.LASFDE96:
	.4byte	.Lframe0
	.4byte	.LFB48
	.4byte	.LFE48-.LFB48
	.byte	0x4
	.4byte	.LCFI118-.LFB48
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE96:
.LSFDE98:
	.4byte	.LEFDE98-.LASFDE98
.LASFDE98:
	.4byte	.Lframe0
	.4byte	.LFB49
	.4byte	.LFE49-.LFB49
	.byte	0x4
	.4byte	.LCFI119-.LFB49
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI120-.LCFI119
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI121-.LCFI120
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE98:
.LSFDE100:
	.4byte	.LEFDE100-.LASFDE100
.LASFDE100:
	.4byte	.Lframe0
	.4byte	.LFB50
	.4byte	.LFE50-.LFB50
	.byte	0x4
	.4byte	.LCFI122-.LFB50
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI123-.LCFI122
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI124-.LCFI123
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE100:
.LSFDE102:
	.4byte	.LEFDE102-.LASFDE102
.LASFDE102:
	.4byte	.Lframe0
	.4byte	.LFB51
	.4byte	.LFE51-.LFB51
	.byte	0x4
	.4byte	.LCFI125-.LFB51
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI126-.LCFI125
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI127-.LCFI126
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE102:
.LSFDE104:
	.4byte	.LEFDE104-.LASFDE104
.LASFDE104:
	.4byte	.Lframe0
	.4byte	.LFB52
	.4byte	.LFE52-.LFB52
	.byte	0x4
	.4byte	.LCFI128-.LFB52
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI129-.LCFI128
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI130-.LCFI129
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE104:
.LSFDE106:
	.4byte	.LEFDE106-.LASFDE106
.LASFDE106:
	.4byte	.Lframe0
	.4byte	.LFB53
	.4byte	.LFE53-.LFB53
	.byte	0x4
	.4byte	.LCFI131-.LFB53
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI132-.LCFI131
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI133-.LCFI132
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE106:
.LSFDE108:
	.4byte	.LEFDE108-.LASFDE108
.LASFDE108:
	.4byte	.Lframe0
	.4byte	.LFB54
	.4byte	.LFE54-.LFB54
	.byte	0x4
	.4byte	.LCFI134-.LFB54
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI135-.LCFI134
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI136-.LCFI135
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE108:
.LSFDE110:
	.4byte	.LEFDE110-.LASFDE110
.LASFDE110:
	.4byte	.Lframe0
	.4byte	.LFB55
	.4byte	.LFE55-.LFB55
	.byte	0x4
	.4byte	.LCFI137-.LFB55
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE110:
.LSFDE112:
	.4byte	.LEFDE112-.LASFDE112
.LASFDE112:
	.4byte	.Lframe0
	.4byte	.LFB56
	.4byte	.LFE56-.LFB56
	.byte	0x4
	.4byte	.LCFI138-.LFB56
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI139-.LCFI138
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI140-.LCFI139
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE112:
.LSFDE114:
	.4byte	.LEFDE114-.LASFDE114
.LASFDE114:
	.4byte	.Lframe0
	.4byte	.LFB57
	.4byte	.LFE57-.LFB57
	.byte	0x4
	.4byte	.LCFI141-.LFB57
	.byte	0xe
	.uleb128 0x8
	.byte	0x84
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI142-.LCFI141
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI143-.LCFI142
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE114:
.LSFDE116:
	.4byte	.LEFDE116-.LASFDE116
.LASFDE116:
	.4byte	.Lframe0
	.4byte	.LFB58
	.4byte	.LFE58-.LFB58
	.byte	0x4
	.4byte	.LCFI144-.LFB58
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI145-.LCFI144
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI146-.LCFI145
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE116:
.LSFDE118:
	.4byte	.LEFDE118-.LASFDE118
.LASFDE118:
	.4byte	.Lframe0
	.4byte	.LFB59
	.4byte	.LFE59-.LFB59
	.byte	0x4
	.4byte	.LCFI147-.LFB59
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI148-.LCFI147
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI149-.LCFI148
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE118:
.LSFDE120:
	.4byte	.LEFDE120-.LASFDE120
.LASFDE120:
	.4byte	.Lframe0
	.4byte	.LFB60
	.4byte	.LFE60-.LFB60
	.byte	0x4
	.4byte	.LCFI150-.LFB60
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI151-.LCFI150
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI152-.LCFI151
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE120:
.LSFDE122:
	.4byte	.LEFDE122-.LASFDE122
.LASFDE122:
	.4byte	.Lframe0
	.4byte	.LFB61
	.4byte	.LFE61-.LFB61
	.byte	0x4
	.4byte	.LCFI153-.LFB61
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI154-.LCFI153
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE122:
.LSFDE124:
	.4byte	.LEFDE124-.LASFDE124
.LASFDE124:
	.4byte	.Lframe0
	.4byte	.LFB62
	.4byte	.LFE62-.LFB62
	.byte	0x4
	.4byte	.LCFI155-.LFB62
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE124:
.LSFDE126:
	.4byte	.LEFDE126-.LASFDE126
.LASFDE126:
	.4byte	.Lframe0
	.4byte	.LFB63
	.4byte	.LFE63-.LFB63
	.byte	0x4
	.4byte	.LCFI156-.LFB63
	.byte	0xe
	.uleb128 0x8
	.byte	0x84
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI157-.LCFI156
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI158-.LCFI157
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE126:
.LSFDE128:
	.4byte	.LEFDE128-.LASFDE128
.LASFDE128:
	.4byte	.Lframe0
	.4byte	.LFB64
	.4byte	.LFE64-.LFB64
	.byte	0x4
	.4byte	.LCFI159-.LFB64
	.byte	0xe
	.uleb128 0x8
	.byte	0x84
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI160-.LCFI159
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI161-.LCFI160
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE128:
.LSFDE130:
	.4byte	.LEFDE130-.LASFDE130
.LASFDE130:
	.4byte	.Lframe0
	.4byte	.LFB65
	.4byte	.LFE65-.LFB65
	.byte	0x4
	.4byte	.LCFI162-.LFB65
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI163-.LCFI162
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI164-.LCFI163
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE130:
.LSFDE132:
	.4byte	.LEFDE132-.LASFDE132
.LASFDE132:
	.4byte	.Lframe0
	.4byte	.LFB66
	.4byte	.LFE66-.LFB66
	.byte	0x4
	.4byte	.LCFI165-.LFB66
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI166-.LCFI165
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI167-.LCFI166
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE132:
.LSFDE134:
	.4byte	.LEFDE134-.LASFDE134
.LASFDE134:
	.4byte	.Lframe0
	.4byte	.LFB67
	.4byte	.LFE67-.LFB67
	.byte	0x4
	.4byte	.LCFI168-.LFB67
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE134:
.LSFDE136:
	.4byte	.LEFDE136-.LASFDE136
.LASFDE136:
	.4byte	.Lframe0
	.4byte	.LFB68
	.4byte	.LFE68-.LFB68
	.byte	0x4
	.4byte	.LCFI169-.LFB68
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI170-.LCFI169
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI171-.LCFI170
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE136:
.LSFDE138:
	.4byte	.LEFDE138-.LASFDE138
.LASFDE138:
	.4byte	.Lframe0
	.4byte	.LFB69
	.4byte	.LFE69-.LFB69
	.byte	0x4
	.4byte	.LCFI172-.LFB69
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI173-.LCFI172
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI174-.LCFI173
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE138:
.LSFDE140:
	.4byte	.LEFDE140-.LASFDE140
.LASFDE140:
	.4byte	.Lframe0
	.4byte	.LFB70
	.4byte	.LFE70-.LFB70
	.byte	0x4
	.4byte	.LCFI175-.LFB70
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI176-.LCFI175
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI177-.LCFI176
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE140:
.LSFDE142:
	.4byte	.LEFDE142-.LASFDE142
.LASFDE142:
	.4byte	.Lframe0
	.4byte	.LFB71
	.4byte	.LFE71-.LFB71
	.byte	0x4
	.4byte	.LCFI178-.LFB71
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI179-.LCFI178
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI180-.LCFI179
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE142:
.LSFDE144:
	.4byte	.LEFDE144-.LASFDE144
.LASFDE144:
	.4byte	.Lframe0
	.4byte	.LFB72
	.4byte	.LFE72-.LFB72
	.byte	0x4
	.4byte	.LCFI181-.LFB72
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI182-.LCFI181
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI183-.LCFI182
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE144:
.LSFDE146:
	.4byte	.LEFDE146-.LASFDE146
.LASFDE146:
	.4byte	.Lframe0
	.4byte	.LFB73
	.4byte	.LFE73-.LFB73
	.byte	0x4
	.4byte	.LCFI184-.LFB73
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI185-.LCFI184
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI186-.LCFI185
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE146:
.LSFDE148:
	.4byte	.LEFDE148-.LASFDE148
.LASFDE148:
	.4byte	.Lframe0
	.4byte	.LFB74
	.4byte	.LFE74-.LFB74
	.byte	0x4
	.4byte	.LCFI187-.LFB74
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI188-.LCFI187
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI189-.LCFI188
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE148:
.LSFDE150:
	.4byte	.LEFDE150-.LASFDE150
.LASFDE150:
	.4byte	.Lframe0
	.4byte	.LFB75
	.4byte	.LFE75-.LFB75
	.byte	0x4
	.4byte	.LCFI190-.LFB75
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI191-.LCFI190
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI192-.LCFI191
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE150:
.LSFDE152:
	.4byte	.LEFDE152-.LASFDE152
.LASFDE152:
	.4byte	.Lframe0
	.4byte	.LFB76
	.4byte	.LFE76-.LFB76
	.byte	0x4
	.4byte	.LCFI193-.LFB76
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI194-.LCFI193
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI195-.LCFI194
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE152:
.LSFDE154:
	.4byte	.LEFDE154-.LASFDE154
.LASFDE154:
	.4byte	.Lframe0
	.4byte	.LFB77
	.4byte	.LFE77-.LFB77
	.byte	0x4
	.4byte	.LCFI196-.LFB77
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI197-.LCFI196
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI198-.LCFI197
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE154:
.LSFDE156:
	.4byte	.LEFDE156-.LASFDE156
.LASFDE156:
	.4byte	.Lframe0
	.4byte	.LFB78
	.4byte	.LFE78-.LFB78
	.byte	0x4
	.4byte	.LCFI199-.LFB78
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI200-.LCFI199
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI201-.LCFI200
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE156:
.LSFDE158:
	.4byte	.LEFDE158-.LASFDE158
.LASFDE158:
	.4byte	.Lframe0
	.4byte	.LFB79
	.4byte	.LFE79-.LFB79
	.byte	0x4
	.4byte	.LCFI202-.LFB79
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI203-.LCFI202
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI204-.LCFI203
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE158:
.LSFDE160:
	.4byte	.LEFDE160-.LASFDE160
.LASFDE160:
	.4byte	.Lframe0
	.4byte	.LFB80
	.4byte	.LFE80-.LFB80
	.byte	0x4
	.4byte	.LCFI205-.LFB80
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI206-.LCFI205
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI207-.LCFI206
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE160:
.LSFDE162:
	.4byte	.LEFDE162-.LASFDE162
.LASFDE162:
	.4byte	.Lframe0
	.4byte	.LFB81
	.4byte	.LFE81-.LFB81
	.byte	0x4
	.4byte	.LCFI208-.LFB81
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE162:
.LSFDE164:
	.4byte	.LEFDE164-.LASFDE164
.LASFDE164:
	.4byte	.Lframe0
	.4byte	.LFB82
	.4byte	.LFE82-.LFB82
	.byte	0x4
	.4byte	.LCFI209-.LFB82
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE164:
.LSFDE166:
	.4byte	.LEFDE166-.LASFDE166
.LASFDE166:
	.4byte	.Lframe0
	.4byte	.LFB83
	.4byte	.LFE83-.LFB83
	.byte	0x4
	.4byte	.LCFI210-.LFB83
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI211-.LCFI210
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI212-.LCFI211
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE166:
.LSFDE168:
	.4byte	.LEFDE168-.LASFDE168
.LASFDE168:
	.4byte	.Lframe0
	.4byte	.LFB84
	.4byte	.LFE84-.LFB84
	.align	2
.LEFDE168:
.LSFDE170:
	.4byte	.LEFDE170-.LASFDE170
.LASFDE170:
	.4byte	.Lframe0
	.4byte	.LFB85
	.4byte	.LFE85-.LFB85
	.byte	0x4
	.4byte	.LCFI213-.LFB85
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI214-.LCFI213
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI215-.LCFI214
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE170:
.LSFDE172:
	.4byte	.LEFDE172-.LASFDE172
.LASFDE172:
	.4byte	.Lframe0
	.4byte	.LFB86
	.4byte	.LFE86-.LFB86
	.byte	0x4
	.4byte	.LCFI216-.LFB86
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI217-.LCFI216
	.byte	0xe
	.uleb128 0x10
	.byte	0x4
	.4byte	.LCFI218-.LCFI217
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE172:
.LSFDE174:
	.4byte	.LEFDE174-.LASFDE174
.LASFDE174:
	.4byte	.Lframe0
	.4byte	.LFB87
	.4byte	.LFE87-.LFB87
	.byte	0x4
	.4byte	.LCFI219-.LFB87
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI220-.LCFI219
	.byte	0xe
	.uleb128 0x18
	.byte	0x4
	.4byte	.LCFI221-.LCFI220
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE174:
.LSFDE176:
	.4byte	.LEFDE176-.LASFDE176
.LASFDE176:
	.4byte	.Lframe0
	.4byte	.LFB88
	.4byte	.LFE88-.LFB88
	.byte	0x4
	.4byte	.LCFI222-.LFB88
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE176:
.LSFDE178:
	.4byte	.LEFDE178-.LASFDE178
.LASFDE178:
	.4byte	.Lframe0
	.4byte	.LFB89
	.4byte	.LFE89-.LFB89
	.byte	0x4
	.4byte	.LCFI223-.LFB89
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE178:
.LSFDE180:
	.4byte	.LEFDE180-.LASFDE180
.LASFDE180:
	.4byte	.Lframe0
	.4byte	.LFB90
	.4byte	.LFE90-.LFB90
	.byte	0x4
	.4byte	.LCFI224-.LFB90
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI225-.LCFI224
	.byte	0xe
	.uleb128 0x38
	.byte	0x4
	.4byte	.LCFI226-.LCFI225
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE180:
.LSFDE182:
	.4byte	.LEFDE182-.LASFDE182
.LASFDE182:
	.4byte	.Lframe0
	.4byte	.LFB91
	.4byte	.LFE91-.LFB91
	.byte	0x4
	.4byte	.LCFI227-.LFB91
	.byte	0xe
	.uleb128 0x20
	.byte	0x4
	.4byte	.LCFI228-.LCFI227
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE182:
.LSFDE184:
	.4byte	.LEFDE184-.LASFDE184
.LASFDE184:
	.4byte	.Lframe0
	.4byte	.LFB92
	.4byte	.LFE92-.LFB92
	.byte	0x4
	.4byte	.LCFI229-.LFB92
	.byte	0xe
	.uleb128 0x8
	.byte	0x84
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI230-.LCFI229
	.byte	0xe
	.uleb128 0x30
	.byte	0x4
	.4byte	.LCFI231-.LCFI230
	.byte	0xe
	.uleb128 0x8
	.align	2
.LEFDE184:
.LSFDE186:
	.4byte	.LEFDE186-.LASFDE186
.LASFDE186:
	.4byte	.Lframe0
	.4byte	.LFB93
	.4byte	.LFE93-.LFB93
	.byte	0x4
	.4byte	.LCFI232-.LFB93
	.byte	0xe
	.uleb128 0x4
	.byte	0x8e
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI233-.LCFI232
	.byte	0xe
	.uleb128 0x28
	.byte	0x4
	.4byte	.LCFI234-.LCFI233
	.byte	0xe
	.uleb128 0x4
	.align	2
.LEFDE186:
	.text
.Letext0:
	.file 2 "C:/Program Files/SEGGER/SEGGER Embedded Studio for ARM 4.18/include/__crossworks.h"
	.file 3 "C:\\Users\\ali\\Desktop\\Ali_Safaei\\5_GeoLocation_UWB\\UWB_sensors\\DWM1001\\Source_Code\\dwm1001_exm\\deca_driver\\deca_types.h"
	.file 4 "C:\\Users\\ali\\Desktop\\Ali_Safaei\\5_GeoLocation_UWB\\UWB_sensors\\DWM1001\\Source_Code\\dwm1001_exm\\deca_driver\\deca_param_types.h"
	.file 5 "C:\\Users\\ali\\Desktop\\Ali_Safaei\\5_GeoLocation_UWB\\UWB_sensors\\DWM1001\\Source_Code\\dwm1001_exm\\deca_driver\\deca_device_api.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x220b
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF355
	.byte	0xc
	.4byte	.LASF356
	.4byte	.LASF357
	.4byte	.Ldebug_ranges0+0
	.4byte	0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.4byte	.LASF52
	.byte	0x8
	.byte	0x2
	.byte	0x7e
	.byte	0x8
	.4byte	0x4d
	.uleb128 0x3
	.4byte	.LASF0
	.byte	0x2
	.byte	0x7f
	.byte	0x7
	.4byte	0x4d
	.byte	0
	.uleb128 0x3
	.4byte	.LASF1
	.byte	0x2
	.byte	0x80
	.byte	0x8
	.4byte	0x59
	.byte	0x4
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x5
	.4byte	0x4d
	.uleb128 0x6
	.byte	0x4
	.byte	0x5
	.4byte	.LASF2
	.uleb128 0x7
	.4byte	0x4d
	.4byte	0x79
	.uleb128 0x8
	.4byte	0x79
	.uleb128 0x8
	.4byte	0x8b
	.uleb128 0x8
	.4byte	0x92
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x7f
	.uleb128 0x6
	.byte	0x1
	.byte	0x8
	.4byte	.LASF3
	.uleb128 0x5
	.4byte	0x7f
	.uleb128 0x6
	.byte	0x4
	.byte	0x7
	.4byte	.LASF4
	.uleb128 0x9
	.byte	0x4
	.4byte	0x25
	.uleb128 0x7
	.4byte	0x4d
	.4byte	0xb6
	.uleb128 0x8
	.4byte	0xb6
	.uleb128 0x8
	.4byte	0xbc
	.uleb128 0x8
	.4byte	0x8b
	.uleb128 0x8
	.4byte	0x92
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x8b
	.uleb128 0x9
	.byte	0x4
	.4byte	0x86
	.uleb128 0xa
	.byte	0x58
	.byte	0x2
	.byte	0x86
	.byte	0x9
	.4byte	0x26c
	.uleb128 0x3
	.4byte	.LASF5
	.byte	0x2
	.byte	0x88
	.byte	0xf
	.4byte	0xbc
	.byte	0
	.uleb128 0x3
	.4byte	.LASF6
	.byte	0x2
	.byte	0x89
	.byte	0xf
	.4byte	0xbc
	.byte	0x4
	.uleb128 0x3
	.4byte	.LASF7
	.byte	0x2
	.byte	0x8a
	.byte	0xf
	.4byte	0xbc
	.byte	0x8
	.uleb128 0x3
	.4byte	.LASF8
	.byte	0x2
	.byte	0x8c
	.byte	0xf
	.4byte	0xbc
	.byte	0xc
	.uleb128 0x3
	.4byte	.LASF9
	.byte	0x2
	.byte	0x8d
	.byte	0xf
	.4byte	0xbc
	.byte	0x10
	.uleb128 0x3
	.4byte	.LASF10
	.byte	0x2
	.byte	0x8e
	.byte	0xf
	.4byte	0xbc
	.byte	0x14
	.uleb128 0x3
	.4byte	.LASF11
	.byte	0x2
	.byte	0x8f
	.byte	0xf
	.4byte	0xbc
	.byte	0x18
	.uleb128 0x3
	.4byte	.LASF12
	.byte	0x2
	.byte	0x90
	.byte	0xf
	.4byte	0xbc
	.byte	0x1c
	.uleb128 0x3
	.4byte	.LASF13
	.byte	0x2
	.byte	0x91
	.byte	0xf
	.4byte	0xbc
	.byte	0x20
	.uleb128 0x3
	.4byte	.LASF14
	.byte	0x2
	.byte	0x92
	.byte	0xf
	.4byte	0xbc
	.byte	0x24
	.uleb128 0x3
	.4byte	.LASF15
	.byte	0x2
	.byte	0x94
	.byte	0x8
	.4byte	0x7f
	.byte	0x28
	.uleb128 0x3
	.4byte	.LASF16
	.byte	0x2
	.byte	0x95
	.byte	0x8
	.4byte	0x7f
	.byte	0x29
	.uleb128 0x3
	.4byte	.LASF17
	.byte	0x2
	.byte	0x96
	.byte	0x8
	.4byte	0x7f
	.byte	0x2a
	.uleb128 0x3
	.4byte	.LASF18
	.byte	0x2
	.byte	0x97
	.byte	0x8
	.4byte	0x7f
	.byte	0x2b
	.uleb128 0x3
	.4byte	.LASF19
	.byte	0x2
	.byte	0x98
	.byte	0x8
	.4byte	0x7f
	.byte	0x2c
	.uleb128 0x3
	.4byte	.LASF20
	.byte	0x2
	.byte	0x99
	.byte	0x8
	.4byte	0x7f
	.byte	0x2d
	.uleb128 0x3
	.4byte	.LASF21
	.byte	0x2
	.byte	0x9a
	.byte	0x8
	.4byte	0x7f
	.byte	0x2e
	.uleb128 0x3
	.4byte	.LASF22
	.byte	0x2
	.byte	0x9b
	.byte	0x8
	.4byte	0x7f
	.byte	0x2f
	.uleb128 0x3
	.4byte	.LASF23
	.byte	0x2
	.byte	0x9c
	.byte	0x8
	.4byte	0x7f
	.byte	0x30
	.uleb128 0x3
	.4byte	.LASF24
	.byte	0x2
	.byte	0x9d
	.byte	0x8
	.4byte	0x7f
	.byte	0x31
	.uleb128 0x3
	.4byte	.LASF25
	.byte	0x2
	.byte	0x9e
	.byte	0x8
	.4byte	0x7f
	.byte	0x32
	.uleb128 0x3
	.4byte	.LASF26
	.byte	0x2
	.byte	0x9f
	.byte	0x8
	.4byte	0x7f
	.byte	0x33
	.uleb128 0x3
	.4byte	.LASF27
	.byte	0x2
	.byte	0xa0
	.byte	0x8
	.4byte	0x7f
	.byte	0x34
	.uleb128 0x3
	.4byte	.LASF28
	.byte	0x2
	.byte	0xa1
	.byte	0x8
	.4byte	0x7f
	.byte	0x35
	.uleb128 0x3
	.4byte	.LASF29
	.byte	0x2
	.byte	0xa6
	.byte	0xf
	.4byte	0xbc
	.byte	0x38
	.uleb128 0x3
	.4byte	.LASF30
	.byte	0x2
	.byte	0xa7
	.byte	0xf
	.4byte	0xbc
	.byte	0x3c
	.uleb128 0x3
	.4byte	.LASF31
	.byte	0x2
	.byte	0xa8
	.byte	0xf
	.4byte	0xbc
	.byte	0x40
	.uleb128 0x3
	.4byte	.LASF32
	.byte	0x2
	.byte	0xa9
	.byte	0xf
	.4byte	0xbc
	.byte	0x44
	.uleb128 0x3
	.4byte	.LASF33
	.byte	0x2
	.byte	0xaa
	.byte	0xf
	.4byte	0xbc
	.byte	0x48
	.uleb128 0x3
	.4byte	.LASF34
	.byte	0x2
	.byte	0xab
	.byte	0xf
	.4byte	0xbc
	.byte	0x4c
	.uleb128 0x3
	.4byte	.LASF35
	.byte	0x2
	.byte	0xac
	.byte	0xf
	.4byte	0xbc
	.byte	0x50
	.uleb128 0x3
	.4byte	.LASF36
	.byte	0x2
	.byte	0xad
	.byte	0xf
	.4byte	0xbc
	.byte	0x54
	.byte	0
	.uleb128 0xb
	.4byte	.LASF46
	.byte	0x2
	.byte	0xae
	.byte	0x3
	.4byte	0xc2
	.uleb128 0x5
	.4byte	0x26c
	.uleb128 0x6
	.byte	0x1
	.byte	0x8
	.4byte	.LASF37
	.uleb128 0x5
	.4byte	0x27d
	.uleb128 0xa
	.byte	0x20
	.byte	0x2
	.byte	0xc4
	.byte	0x9
	.4byte	0x2fb
	.uleb128 0x3
	.4byte	.LASF38
	.byte	0x2
	.byte	0xc6
	.byte	0x9
	.4byte	0x30f
	.byte	0
	.uleb128 0x3
	.4byte	.LASF39
	.byte	0x2
	.byte	0xc7
	.byte	0x9
	.4byte	0x324
	.byte	0x4
	.uleb128 0x3
	.4byte	.LASF40
	.byte	0x2
	.byte	0xc8
	.byte	0x9
	.4byte	0x324
	.byte	0x8
	.uleb128 0x3
	.4byte	.LASF41
	.byte	0x2
	.byte	0xcb
	.byte	0x9
	.4byte	0x33e
	.byte	0xc
	.uleb128 0x3
	.4byte	.LASF42
	.byte	0x2
	.byte	0xcc
	.byte	0xa
	.4byte	0x353
	.byte	0x10
	.uleb128 0x3
	.4byte	.LASF43
	.byte	0x2
	.byte	0xcd
	.byte	0xa
	.4byte	0x353
	.byte	0x14
	.uleb128 0x3
	.4byte	.LASF44
	.byte	0x2
	.byte	0xd0
	.byte	0x9
	.4byte	0x359
	.byte	0x18
	.uleb128 0x3
	.4byte	.LASF45
	.byte	0x2
	.byte	0xd1
	.byte	0x9
	.4byte	0x35f
	.byte	0x1c
	.byte	0
	.uleb128 0x7
	.4byte	0x4d
	.4byte	0x30f
	.uleb128 0x8
	.4byte	0x4d
	.uleb128 0x8
	.4byte	0x4d
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x2fb
	.uleb128 0x7
	.4byte	0x4d
	.4byte	0x324
	.uleb128 0x8
	.4byte	0x4d
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x315
	.uleb128 0x7
	.4byte	0x4d
	.4byte	0x33e
	.uleb128 0x8
	.4byte	0x59
	.uleb128 0x8
	.4byte	0x4d
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x32a
	.uleb128 0x7
	.4byte	0x59
	.4byte	0x353
	.uleb128 0x8
	.4byte	0x59
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x344
	.uleb128 0x9
	.byte	0x4
	.4byte	0x60
	.uleb128 0x9
	.byte	0x4
	.4byte	0x98
	.uleb128 0xb
	.4byte	.LASF47
	.byte	0x2
	.byte	0xd2
	.byte	0x3
	.4byte	0x289
	.uleb128 0x5
	.4byte	0x365
	.uleb128 0xa
	.byte	0xc
	.byte	0x2
	.byte	0xd4
	.byte	0x9
	.4byte	0x3a7
	.uleb128 0x3
	.4byte	.LASF48
	.byte	0x2
	.byte	0xd5
	.byte	0xf
	.4byte	0xbc
	.byte	0
	.uleb128 0x3
	.4byte	.LASF49
	.byte	0x2
	.byte	0xd6
	.byte	0x25
	.4byte	0x3a7
	.byte	0x4
	.uleb128 0x3
	.4byte	.LASF50
	.byte	0x2
	.byte	0xd7
	.byte	0x28
	.4byte	0x3ad
	.byte	0x8
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x278
	.uleb128 0x9
	.byte	0x4
	.4byte	0x371
	.uleb128 0xb
	.4byte	.LASF51
	.byte	0x2
	.byte	0xd8
	.byte	0x3
	.4byte	0x376
	.uleb128 0x5
	.4byte	0x3b3
	.uleb128 0x2
	.4byte	.LASF53
	.byte	0x14
	.byte	0x2
	.byte	0xdc
	.byte	0x10
	.4byte	0x3df
	.uleb128 0x3
	.4byte	.LASF54
	.byte	0x2
	.byte	0xdd
	.byte	0x20
	.4byte	0x3df
	.byte	0
	.byte	0
	.uleb128 0xc
	.4byte	0x3ef
	.4byte	0x3ef
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x4
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x3bf
	.uleb128 0xe
	.4byte	.LASF55
	.byte	0x2
	.2byte	0x106
	.byte	0x1a
	.4byte	0x3c4
	.uleb128 0xe
	.4byte	.LASF56
	.byte	0x2
	.2byte	0x10d
	.byte	0x24
	.4byte	0x3bf
	.uleb128 0xe
	.4byte	.LASF57
	.byte	0x2
	.2byte	0x110
	.byte	0x2c
	.4byte	0x371
	.uleb128 0xe
	.4byte	.LASF58
	.byte	0x2
	.2byte	0x111
	.byte	0x2c
	.4byte	0x371
	.uleb128 0xc
	.4byte	0x284
	.4byte	0x439
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x7f
	.byte	0
	.uleb128 0x5
	.4byte	0x429
	.uleb128 0xe
	.4byte	.LASF59
	.byte	0x2
	.2byte	0x113
	.byte	0x23
	.4byte	0x439
	.uleb128 0xc
	.4byte	0x86
	.4byte	0x456
	.uleb128 0xf
	.byte	0
	.uleb128 0x5
	.4byte	0x44b
	.uleb128 0xe
	.4byte	.LASF60
	.byte	0x2
	.2byte	0x115
	.byte	0x13
	.4byte	0x456
	.uleb128 0xe
	.4byte	.LASF61
	.byte	0x2
	.2byte	0x116
	.byte	0x13
	.4byte	0x456
	.uleb128 0xe
	.4byte	.LASF62
	.byte	0x2
	.2byte	0x117
	.byte	0x13
	.4byte	0x456
	.uleb128 0xe
	.4byte	.LASF63
	.byte	0x2
	.2byte	0x118
	.byte	0x13
	.4byte	0x456
	.uleb128 0xe
	.4byte	.LASF64
	.byte	0x2
	.2byte	0x11a
	.byte	0x13
	.4byte	0x456
	.uleb128 0xe
	.4byte	.LASF65
	.byte	0x2
	.2byte	0x11b
	.byte	0x13
	.4byte	0x456
	.uleb128 0xe
	.4byte	.LASF66
	.byte	0x2
	.2byte	0x11c
	.byte	0x13
	.4byte	0x456
	.uleb128 0xe
	.4byte	.LASF67
	.byte	0x2
	.2byte	0x11d
	.byte	0x13
	.4byte	0x456
	.uleb128 0xe
	.4byte	.LASF68
	.byte	0x2
	.2byte	0x11e
	.byte	0x13
	.4byte	0x456
	.uleb128 0xe
	.4byte	.LASF69
	.byte	0x2
	.2byte	0x11f
	.byte	0x13
	.4byte	0x456
	.uleb128 0x7
	.4byte	0x4d
	.4byte	0x4ec
	.uleb128 0x8
	.4byte	0x4ec
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x4f7
	.uleb128 0x10
	.4byte	.LASF358
	.uleb128 0x5
	.4byte	0x4f2
	.uleb128 0xe
	.4byte	.LASF70
	.byte	0x2
	.2byte	0x135
	.byte	0xe
	.4byte	0x509
	.uleb128 0x9
	.byte	0x4
	.4byte	0x4dd
	.uleb128 0x7
	.4byte	0x4d
	.4byte	0x51e
	.uleb128 0x8
	.4byte	0x51e
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x4f2
	.uleb128 0xe
	.4byte	.LASF71
	.byte	0x2
	.2byte	0x136
	.byte	0xe
	.4byte	0x531
	.uleb128 0x9
	.byte	0x4
	.4byte	0x50f
	.uleb128 0x6
	.byte	0x2
	.byte	0x7
	.4byte	.LASF72
	.uleb128 0x11
	.4byte	.LASF73
	.byte	0x2
	.2byte	0x14d
	.byte	0x18
	.4byte	0x54b
	.uleb128 0x9
	.byte	0x4
	.4byte	0x551
	.uleb128 0x7
	.4byte	0xbc
	.4byte	0x560
	.uleb128 0x8
	.4byte	0x4d
	.byte	0
	.uleb128 0x12
	.4byte	.LASF74
	.byte	0x8
	.byte	0x2
	.2byte	0x14f
	.byte	0x10
	.4byte	0x58b
	.uleb128 0x13
	.4byte	.LASF75
	.byte	0x2
	.2byte	0x151
	.byte	0x1c
	.4byte	0x53e
	.byte	0
	.uleb128 0x13
	.4byte	.LASF76
	.byte	0x2
	.2byte	0x152
	.byte	0x21
	.4byte	0x58b
	.byte	0x4
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x560
	.uleb128 0x11
	.4byte	.LASF77
	.byte	0x2
	.2byte	0x153
	.byte	0x3
	.4byte	0x560
	.uleb128 0xe
	.4byte	.LASF78
	.byte	0x2
	.2byte	0x157
	.byte	0x1f
	.4byte	0x5ab
	.uleb128 0x9
	.byte	0x4
	.4byte	0x591
	.uleb128 0x6
	.byte	0x8
	.byte	0x5
	.4byte	.LASF79
	.uleb128 0xb
	.4byte	.LASF80
	.byte	0x3
	.byte	0x17
	.byte	0x17
	.4byte	0x27d
	.uleb128 0x5
	.4byte	0x5b8
	.uleb128 0xb
	.4byte	.LASF81
	.byte	0x3
	.byte	0x1e
	.byte	0x18
	.4byte	0x537
	.uleb128 0x5
	.4byte	0x5c9
	.uleb128 0xb
	.4byte	.LASF82
	.byte	0x3
	.byte	0x25
	.byte	0x17
	.4byte	0x5eb
	.uleb128 0x5
	.4byte	0x5da
	.uleb128 0x6
	.byte	0x4
	.byte	0x7
	.4byte	.LASF83
	.uleb128 0x6
	.byte	0x1
	.byte	0x6
	.4byte	.LASF84
	.uleb128 0x6
	.byte	0x2
	.byte	0x5
	.4byte	.LASF85
	.uleb128 0xb
	.4byte	.LASF86
	.byte	0x3
	.byte	0x3a
	.byte	0x15
	.4byte	0x59
	.uleb128 0xa
	.byte	0x8
	.byte	0x4
	.byte	0x1e
	.byte	0x9
	.4byte	0x630
	.uleb128 0x3
	.4byte	.LASF87
	.byte	0x4
	.byte	0x1f
	.byte	0xc
	.4byte	0x5da
	.byte	0
	.uleb128 0x3
	.4byte	.LASF88
	.byte	0x4
	.byte	0x20
	.byte	0xc
	.4byte	0x630
	.byte	0x4
	.byte	0
	.uleb128 0xc
	.4byte	0x5c9
	.4byte	0x640
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x1
	.byte	0
	.uleb128 0xb
	.4byte	.LASF89
	.byte	0x4
	.byte	0x21
	.byte	0x3
	.4byte	0x60c
	.uleb128 0x5
	.4byte	0x640
	.uleb128 0x14
	.4byte	.LASF90
	.byte	0x4
	.byte	0x23
	.byte	0x1d
	.4byte	0x64c
	.uleb128 0xc
	.4byte	0x5d5
	.4byte	0x673
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x2
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x1
	.byte	0
	.uleb128 0x5
	.4byte	0x65d
	.uleb128 0x14
	.4byte	.LASF91
	.byte	0x4
	.byte	0x26
	.byte	0x15
	.4byte	0x673
	.uleb128 0xc
	.4byte	0x5d5
	.4byte	0x694
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x1
	.byte	0
	.uleb128 0x5
	.4byte	0x684
	.uleb128 0x14
	.4byte	.LASF92
	.byte	0x4
	.byte	0x28
	.byte	0x15
	.4byte	0x694
	.uleb128 0xc
	.4byte	0x5e6
	.4byte	0x6b5
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x5
	.byte	0
	.uleb128 0x5
	.4byte	0x6a5
	.uleb128 0x14
	.4byte	.LASF93
	.byte	0x4
	.byte	0x2c
	.byte	0x15
	.4byte	0x6b5
	.uleb128 0xc
	.4byte	0x5c4
	.4byte	0x6d6
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x5
	.byte	0
	.uleb128 0x5
	.4byte	0x6c6
	.uleb128 0x14
	.4byte	.LASF94
	.byte	0x4
	.byte	0x2d
	.byte	0x14
	.4byte	0x6d6
	.uleb128 0xc
	.4byte	0x5c4
	.4byte	0x6f7
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x1
	.byte	0
	.uleb128 0x5
	.4byte	0x6e7
	.uleb128 0x14
	.4byte	.LASF95
	.byte	0x4
	.byte	0x2e
	.byte	0x14
	.4byte	0x6f7
	.uleb128 0x14
	.4byte	.LASF96
	.byte	0x4
	.byte	0x2f
	.byte	0x15
	.4byte	0x6b5
	.uleb128 0xc
	.4byte	0x5c4
	.4byte	0x724
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x2
	.byte	0
	.uleb128 0x5
	.4byte	0x714
	.uleb128 0x14
	.4byte	.LASF97
	.byte	0x4
	.byte	0x30
	.byte	0x14
	.4byte	0x724
	.uleb128 0xc
	.4byte	0x5e6
	.4byte	0x74b
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x1
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x3
	.byte	0
	.uleb128 0x5
	.4byte	0x735
	.uleb128 0x14
	.4byte	.LASF98
	.byte	0x4
	.byte	0x31
	.byte	0x15
	.4byte	0x74b
	.uleb128 0xc
	.4byte	0x5c4
	.4byte	0x76c
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x7
	.byte	0
	.uleb128 0x5
	.4byte	0x75c
	.uleb128 0x14
	.4byte	.LASF99
	.byte	0x4
	.byte	0x32
	.byte	0x14
	.4byte	0x76c
	.uleb128 0xc
	.4byte	0x799
	.4byte	0x78d
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x5
	.byte	0
	.uleb128 0x5
	.4byte	0x77d
	.uleb128 0x6
	.byte	0x8
	.byte	0x4
	.4byte	.LASF100
	.uleb128 0x5
	.4byte	0x792
	.uleb128 0x14
	.4byte	.LASF101
	.byte	0x4
	.byte	0x33
	.byte	0x15
	.4byte	0x78d
	.uleb128 0xc
	.4byte	0x5d5
	.4byte	0x7ba
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x18
	.byte	0
	.uleb128 0x5
	.4byte	0x7aa
	.uleb128 0x14
	.4byte	.LASF102
	.byte	0x4
	.byte	0x3f
	.byte	0x15
	.4byte	0x7ba
	.uleb128 0xa
	.byte	0xc
	.byte	0x5
	.byte	0xaf
	.byte	0x9
	.4byte	0x809
	.uleb128 0x3
	.4byte	.LASF103
	.byte	0x5
	.byte	0xb1
	.byte	0xc
	.4byte	0x5da
	.byte	0
	.uleb128 0x3
	.4byte	.LASF104
	.byte	0x5
	.byte	0xb2
	.byte	0xc
	.4byte	0x5c9
	.byte	0x4
	.uleb128 0x3
	.4byte	.LASF105
	.byte	0x5
	.byte	0xb3
	.byte	0xc
	.4byte	0x809
	.byte	0x6
	.uleb128 0x3
	.4byte	.LASF106
	.byte	0x5
	.byte	0xb4
	.byte	0xc
	.4byte	0x5b8
	.byte	0x8
	.byte	0
	.uleb128 0xc
	.4byte	0x5b8
	.4byte	0x819
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x1
	.byte	0
	.uleb128 0xb
	.4byte	.LASF107
	.byte	0x5
	.byte	0xb5
	.byte	0x3
	.4byte	0x7cb
	.uleb128 0x5
	.4byte	0x819
	.uleb128 0xb
	.4byte	.LASF108
	.byte	0x5
	.byte	0xb8
	.byte	0x10
	.4byte	0x836
	.uleb128 0x9
	.byte	0x4
	.4byte	0x83c
	.uleb128 0x15
	.4byte	0x847
	.uleb128 0x8
	.4byte	0x847
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x825
	.uleb128 0xa
	.byte	0xc
	.byte	0x5
	.byte	0xc0
	.byte	0x9
	.4byte	0x8d9
	.uleb128 0x3
	.4byte	.LASF109
	.byte	0x5
	.byte	0xc2
	.byte	0xb
	.4byte	0x5b8
	.byte	0
	.uleb128 0x16
	.ascii	"prf\000"
	.byte	0x5
	.byte	0xc3
	.byte	0xb
	.4byte	0x5b8
	.byte	0x1
	.uleb128 0x3
	.4byte	.LASF110
	.byte	0x5
	.byte	0xc4
	.byte	0xb
	.4byte	0x5b8
	.byte	0x2
	.uleb128 0x3
	.4byte	.LASF111
	.byte	0x5
	.byte	0xc5
	.byte	0xb
	.4byte	0x5b8
	.byte	0x3
	.uleb128 0x3
	.4byte	.LASF112
	.byte	0x5
	.byte	0xc6
	.byte	0xb
	.4byte	0x5b8
	.byte	0x4
	.uleb128 0x3
	.4byte	.LASF113
	.byte	0x5
	.byte	0xc7
	.byte	0xb
	.4byte	0x5b8
	.byte	0x5
	.uleb128 0x3
	.4byte	.LASF114
	.byte	0x5
	.byte	0xc8
	.byte	0xb
	.4byte	0x5b8
	.byte	0x6
	.uleb128 0x3
	.4byte	.LASF115
	.byte	0x5
	.byte	0xc9
	.byte	0xb
	.4byte	0x5b8
	.byte	0x7
	.uleb128 0x3
	.4byte	.LASF116
	.byte	0x5
	.byte	0xca
	.byte	0xb
	.4byte	0x5b8
	.byte	0x8
	.uleb128 0x3
	.4byte	.LASF117
	.byte	0x5
	.byte	0xcb
	.byte	0xc
	.4byte	0x5c9
	.byte	0xa
	.byte	0
	.uleb128 0xb
	.4byte	.LASF118
	.byte	0x5
	.byte	0xcc
	.byte	0x3
	.4byte	0x84d
	.uleb128 0xa
	.byte	0x8
	.byte	0x5
	.byte	0xcf
	.byte	0x9
	.4byte	0x909
	.uleb128 0x3
	.4byte	.LASF119
	.byte	0x5
	.byte	0xd1
	.byte	0xd
	.4byte	0x5b8
	.byte	0
	.uleb128 0x3
	.4byte	.LASF120
	.byte	0x5
	.byte	0xd7
	.byte	0xd
	.4byte	0x5da
	.byte	0x4
	.byte	0
	.uleb128 0xb
	.4byte	.LASF121
	.byte	0x5
	.byte	0xd9
	.byte	0x1
	.4byte	0x8e5
	.uleb128 0xa
	.byte	0x10
	.byte	0x5
	.byte	0xdc
	.byte	0x9
	.4byte	0x987
	.uleb128 0x3
	.4byte	.LASF122
	.byte	0x5
	.byte	0xdf
	.byte	0x11
	.4byte	0x5c9
	.byte	0
	.uleb128 0x3
	.4byte	.LASF123
	.byte	0x5
	.byte	0xe0
	.byte	0x11
	.4byte	0x5c9
	.byte	0x2
	.uleb128 0x3
	.4byte	.LASF124
	.byte	0x5
	.byte	0xe1
	.byte	0x11
	.4byte	0x5c9
	.byte	0x4
	.uleb128 0x3
	.4byte	.LASF125
	.byte	0x5
	.byte	0xe2
	.byte	0x11
	.4byte	0x5c9
	.byte	0x6
	.uleb128 0x3
	.4byte	.LASF126
	.byte	0x5
	.byte	0xe3
	.byte	0x11
	.4byte	0x5c9
	.byte	0x8
	.uleb128 0x3
	.4byte	.LASF127
	.byte	0x5
	.byte	0xe4
	.byte	0x11
	.4byte	0x5c9
	.byte	0xa
	.uleb128 0x3
	.4byte	.LASF128
	.byte	0x5
	.byte	0xe5
	.byte	0x11
	.4byte	0x5c9
	.byte	0xc
	.uleb128 0x3
	.4byte	.LASF129
	.byte	0x5
	.byte	0xe6
	.byte	0x11
	.4byte	0x5c9
	.byte	0xe
	.byte	0
	.uleb128 0xb
	.4byte	.LASF130
	.byte	0x5
	.byte	0xe7
	.byte	0x2
	.4byte	0x915
	.uleb128 0xa
	.byte	0x18
	.byte	0x5
	.byte	0xea
	.byte	0x9
	.4byte	0xa39
	.uleb128 0x16
	.ascii	"PHE\000"
	.byte	0x5
	.byte	0xed
	.byte	0xc
	.4byte	0x5c9
	.byte	0
	.uleb128 0x16
	.ascii	"RSL\000"
	.byte	0x5
	.byte	0xee
	.byte	0xc
	.4byte	0x5c9
	.byte	0x2
	.uleb128 0x3
	.4byte	.LASF131
	.byte	0x5
	.byte	0xef
	.byte	0xc
	.4byte	0x5c9
	.byte	0x4
	.uleb128 0x3
	.4byte	.LASF132
	.byte	0x5
	.byte	0xf0
	.byte	0xc
	.4byte	0x5c9
	.byte	0x6
	.uleb128 0x3
	.4byte	.LASF133
	.byte	0x5
	.byte	0xf1
	.byte	0xc
	.4byte	0x5c9
	.byte	0x8
	.uleb128 0x3
	.4byte	.LASF134
	.byte	0x5
	.byte	0xf2
	.byte	0xc
	.4byte	0x5c9
	.byte	0xa
	.uleb128 0x3
	.4byte	.LASF135
	.byte	0x5
	.byte	0xf3
	.byte	0xc
	.4byte	0x5c9
	.byte	0xc
	.uleb128 0x16
	.ascii	"PTO\000"
	.byte	0x5
	.byte	0xf4
	.byte	0xc
	.4byte	0x5c9
	.byte	0xe
	.uleb128 0x16
	.ascii	"RTO\000"
	.byte	0x5
	.byte	0xf5
	.byte	0xc
	.4byte	0x5c9
	.byte	0x10
	.uleb128 0x16
	.ascii	"TXF\000"
	.byte	0x5
	.byte	0xf6
	.byte	0xc
	.4byte	0x5c9
	.byte	0x12
	.uleb128 0x16
	.ascii	"HPW\000"
	.byte	0x5
	.byte	0xf7
	.byte	0xc
	.4byte	0x5c9
	.byte	0x14
	.uleb128 0x16
	.ascii	"TXW\000"
	.byte	0x5
	.byte	0xf8
	.byte	0xc
	.4byte	0x5c9
	.byte	0x16
	.byte	0
	.uleb128 0xb
	.4byte	.LASF136
	.byte	0x5
	.byte	0xfa
	.byte	0x3
	.4byte	0x993
	.uleb128 0x11
	.4byte	.LASF137
	.byte	0x5
	.2byte	0x6f3
	.byte	0xd
	.4byte	0x4d
	.uleb128 0xa
	.byte	0x38
	.byte	0x1
	.byte	0x41
	.byte	0x9
	.4byte	0xb1f
	.uleb128 0x3
	.4byte	.LASF138
	.byte	0x1
	.byte	0x43
	.byte	0x11
	.4byte	0x5da
	.byte	0
	.uleb128 0x3
	.4byte	.LASF139
	.byte	0x1
	.byte	0x44
	.byte	0x11
	.4byte	0x5da
	.byte	0x4
	.uleb128 0x3
	.4byte	.LASF140
	.byte	0x1
	.byte	0x45
	.byte	0x11
	.4byte	0x5b8
	.byte	0x8
	.uleb128 0x3
	.4byte	.LASF141
	.byte	0x1
	.byte	0x46
	.byte	0x11
	.4byte	0x5b8
	.byte	0x9
	.uleb128 0x3
	.4byte	.LASF142
	.byte	0x1
	.byte	0x47
	.byte	0x11
	.4byte	0x5da
	.byte	0xc
	.uleb128 0x3
	.4byte	.LASF143
	.byte	0x1
	.byte	0x48
	.byte	0x11
	.4byte	0x5b8
	.byte	0x10
	.uleb128 0x3
	.4byte	.LASF144
	.byte	0x1
	.byte	0x49
	.byte	0x11
	.4byte	0x5b8
	.byte	0x11
	.uleb128 0x3
	.4byte	.LASF145
	.byte	0x1
	.byte	0x4a
	.byte	0x11
	.4byte	0x5da
	.byte	0x14
	.uleb128 0x3
	.4byte	.LASF146
	.byte	0x1
	.byte	0x4b
	.byte	0x11
	.4byte	0x5c9
	.byte	0x18
	.uleb128 0x3
	.4byte	.LASF147
	.byte	0x1
	.byte	0x4c
	.byte	0x11
	.4byte	0x5b8
	.byte	0x1a
	.uleb128 0x3
	.4byte	.LASF148
	.byte	0x1
	.byte	0x4d
	.byte	0x13
	.4byte	0x819
	.byte	0x1c
	.uleb128 0x3
	.4byte	.LASF149
	.byte	0x1
	.byte	0x4e
	.byte	0x11
	.4byte	0x82a
	.byte	0x28
	.uleb128 0x3
	.4byte	.LASF150
	.byte	0x1
	.byte	0x4f
	.byte	0x11
	.4byte	0x82a
	.byte	0x2c
	.uleb128 0x3
	.4byte	.LASF151
	.byte	0x1
	.byte	0x50
	.byte	0x11
	.4byte	0x82a
	.byte	0x30
	.uleb128 0x3
	.4byte	.LASF152
	.byte	0x1
	.byte	0x51
	.byte	0x11
	.4byte	0x82a
	.byte	0x34
	.byte	0
	.uleb128 0xb
	.4byte	.LASF153
	.byte	0x1
	.byte	0x52
	.byte	0x3
	.4byte	0xa52
	.uleb128 0xc
	.4byte	0xb1f
	.4byte	0xb3b
	.uleb128 0xd
	.4byte	0x8b
	.byte	0
	.byte	0
	.uleb128 0x17
	.4byte	.LASF154
	.byte	0x1
	.byte	0x54
	.byte	0x19
	.4byte	0xb2b
	.uleb128 0x5
	.byte	0x3
	.4byte	dw1000local
	.uleb128 0x17
	.4byte	.LASF155
	.byte	0x1
	.byte	0x55
	.byte	0x1a
	.4byte	0xb5f
	.uleb128 0x5
	.byte	0x3
	.4byte	pdw1000local
	.uleb128 0x9
	.byte	0x4
	.4byte	0xb1f
	.uleb128 0x18
	.4byte	.LASF163
	.byte	0x1
	.2byte	0xdb6
	.byte	0x8
	.4byte	0x5c9
	.4byte	.LFB93
	.4byte	.LFE93-.LFB93
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xc0f
	.uleb128 0x19
	.4byte	.LASF165
	.byte	0x1
	.2byte	0xdb6
	.byte	0x1e
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -33
	.uleb128 0x1a
	.4byte	.LASF156
	.byte	0x1
	.2byte	0xdb9
	.byte	0xf
	.4byte	0x54
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1a
	.4byte	.LASF157
	.byte	0x1
	.2byte	0xdba
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1a
	.4byte	.LASF158
	.byte	0x1
	.2byte	0xdbb
	.byte	0xc
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -22
	.uleb128 0x1a
	.4byte	.LASF159
	.byte	0x1
	.2byte	0xdbb
	.byte	0x1f
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1b
	.ascii	"i\000"
	.byte	0x1
	.2byte	0xdbc
	.byte	0x9
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1a
	.4byte	.LASF160
	.byte	0x1
	.2byte	0xdbf
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -25
	.uleb128 0x1a
	.4byte	.LASF161
	.byte	0x1
	.2byte	0xdc0
	.byte	0xc
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1a
	.4byte	.LASF162
	.byte	0x1
	.2byte	0xdc1
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x18
	.4byte	.LASF164
	.byte	0x1
	.2byte	0xd93
	.byte	0x9
	.4byte	0x5da
	.4byte	.LFB92
	.4byte	.LFE92-.LFB92
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xc8b
	.uleb128 0x19
	.4byte	.LASF166
	.byte	0x1
	.2byte	0xd95
	.byte	0xe
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -25
	.uleb128 0x19
	.4byte	.LASF167
	.byte	0x1
	.2byte	0xd96
	.byte	0xf
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.4byte	.LASF168
	.byte	0x1
	.2byte	0xd97
	.byte	0xf
	.4byte	0x792
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x19
	.4byte	.LASF169
	.byte	0x1
	.2byte	0xd98
	.byte	0xf
	.4byte	0x792
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1a
	.4byte	.LASF170
	.byte	0x1
	.2byte	0xd9b
	.byte	0xc
	.4byte	0x792
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1a
	.4byte	.LASF171
	.byte	0x1
	.2byte	0xd9c
	.byte	0xc
	.4byte	0x792
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1c
	.4byte	.LASF172
	.byte	0x1
	.2byte	0xd5b
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB91
	.4byte	.LFE91-.LFB91
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xd45
	.uleb128 0x19
	.4byte	.LASF167
	.byte	0x1
	.2byte	0xd5b
	.byte	0x2a
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x19
	.4byte	.LASF173
	.byte	0x1
	.2byte	0xd5b
	.byte	0x3e
	.4byte	0x600
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1a
	.4byte	.LASF174
	.byte	0x1
	.2byte	0xd5d
	.byte	0xb
	.4byte	0x600
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x1a
	.4byte	.LASF175
	.byte	0x1
	.2byte	0xd5d
	.byte	0x1b
	.4byte	0x600
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0x1a
	.4byte	.LASF176
	.byte	0x1
	.2byte	0xd5e
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1a
	.4byte	.LASF177
	.byte	0x1
	.2byte	0xd5e
	.byte	0x1c
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x1a
	.4byte	.LASF178
	.byte	0x1
	.2byte	0xd5f
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -19
	.uleb128 0x1a
	.4byte	.LASF179
	.byte	0x1
	.2byte	0xd5f
	.byte	0x18
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1a
	.4byte	.LASF180
	.byte	0x1
	.2byte	0xd60
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1b
	.ascii	"i\000"
	.byte	0x1
	.2byte	0xd61
	.byte	0x9
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x18
	.4byte	.LASF181
	.byte	0x1
	.2byte	0xcf6
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB90
	.4byte	.LFE90-.LFB90
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xe0f
	.uleb128 0x19
	.4byte	.LASF182
	.byte	0x1
	.2byte	0xcf6
	.byte	0x28
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -50
	.uleb128 0x1b
	.ascii	"i\000"
	.byte	0x1
	.2byte	0xcf8
	.byte	0x9
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1a
	.4byte	.LASF183
	.byte	0x1
	.2byte	0xcf9
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1a
	.4byte	.LASF184
	.byte	0x1
	.2byte	0xcf9
	.byte	0x17
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1a
	.4byte	.LASF185
	.byte	0x1
	.2byte	0xcfa
	.byte	0xb
	.4byte	0x600
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1a
	.4byte	.LASF186
	.byte	0x1
	.2byte	0xcfb
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1a
	.4byte	.LASF187
	.byte	0x1
	.2byte	0xcfc
	.byte	0xc
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -34
	.uleb128 0x1a
	.4byte	.LASF188
	.byte	0x1
	.2byte	0xcfd
	.byte	0xb
	.4byte	0x600
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1a
	.4byte	.LASF160
	.byte	0x1
	.2byte	0xd00
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -35
	.uleb128 0x1a
	.4byte	.LASF161
	.byte	0x1
	.2byte	0xd01
	.byte	0xc
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -38
	.uleb128 0x1a
	.4byte	.LASF162
	.byte	0x1
	.2byte	0xd02
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.byte	0
	.uleb128 0x1d
	.4byte	.LASF189
	.byte	0x1
	.2byte	0xce4
	.byte	0x7
	.4byte	0x5b8
	.4byte	.LFB89
	.4byte	.LFE89-.LFB89
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1d
	.4byte	.LASF190
	.byte	0x1
	.2byte	0xcd2
	.byte	0x7
	.4byte	0x5b8
	.4byte	.LFB88
	.4byte	.LFE88-.LFB88
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x18
	.4byte	.LASF191
	.byte	0x1
	.2byte	0xc97
	.byte	0x8
	.4byte	0x5c9
	.4byte	.LFB87
	.4byte	.LFE87-.LFB87
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xe99
	.uleb128 0x19
	.4byte	.LASF192
	.byte	0x1
	.2byte	0xc97
	.byte	0x1f
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1a
	.4byte	.LASF193
	.byte	0x1
	.2byte	0xc99
	.byte	0xb
	.4byte	0x809
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1a
	.4byte	.LASF194
	.byte	0x1
	.2byte	0xc9a
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x1a
	.4byte	.LASF195
	.byte	0x1
	.2byte	0xc9b
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF197
	.byte	0x1
	.2byte	0xc62
	.byte	0x6
	.4byte	.LFB86
	.4byte	.LFE86-.LFB86
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xec1
	.uleb128 0x19
	.4byte	.LASF196
	.byte	0x1
	.2byte	0xc62
	.byte	0x2b
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF198
	.byte	0x1
	.2byte	0xc2e
	.byte	0x6
	.4byte	.LFB85
	.4byte	.LFE85-.LFB85
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xee9
	.uleb128 0x19
	.4byte	.LASF109
	.byte	0x1
	.2byte	0xc2e
	.byte	0x1d
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF199
	.byte	0x1
	.2byte	0xc1d
	.byte	0x7
	.4byte	0x5b8
	.4byte	.LFB84
	.4byte	.LFE84-.LFB84
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1e
	.4byte	.LASF200
	.byte	0x1
	.2byte	0xc08
	.byte	0x6
	.4byte	.LFB83
	.4byte	.LFE83-.LFB83
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xf38
	.uleb128 0x19
	.4byte	.LASF201
	.byte	0x1
	.2byte	0xc08
	.byte	0x1c
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1a
	.4byte	.LASF202
	.byte	0x1
	.2byte	0xc0b
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.byte	0
	.uleb128 0x20
	.4byte	.LASF203
	.byte	0x1
	.2byte	0xbe4
	.byte	0x6
	.4byte	.LFB82
	.4byte	.LFE82-.LFB82
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x20
	.4byte	.LASF204
	.byte	0x1
	.2byte	0xbd0
	.byte	0x6
	.4byte	.LFB81
	.4byte	.LFE81-.LFB81
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1e
	.4byte	.LASF205
	.byte	0x1
	.2byte	0xba7
	.byte	0x6
	.4byte	.LFB80
	.4byte	.LFE80-.LFB80
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xf96
	.uleb128 0x19
	.4byte	.LASF206
	.byte	0x1
	.2byte	0xba7
	.byte	0x31
	.4byte	0xf96
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1a
	.4byte	.LASF207
	.byte	0x1
	.2byte	0xba9
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0xa39
	.uleb128 0x1e
	.4byte	.LASF208
	.byte	0x1
	.2byte	0xb90
	.byte	0x6
	.4byte	.LFB79
	.4byte	.LFE79-.LFB79
	.uleb128 0x1
	.byte	0x9c
	.4byte	0xfc4
	.uleb128 0x19
	.4byte	.LASF209
	.byte	0x1
	.2byte	0xb90
	.byte	0x22
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF210
	.byte	0x1
	.2byte	0xb6e
	.byte	0x6
	.4byte	.LFB78
	.4byte	.LFE78-.LFB78
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x101c
	.uleb128 0x19
	.4byte	.LASF211
	.byte	0x1
	.2byte	0xb6e
	.byte	0x1e
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF209
	.byte	0x1
	.2byte	0xb6e
	.byte	0x2d
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -21
	.uleb128 0x1a
	.4byte	.LASF212
	.byte	0x1
	.2byte	0xb70
	.byte	0x15
	.4byte	0xa45
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1a
	.4byte	.LASF213
	.byte	0x1
	.2byte	0xb71
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF214
	.byte	0x1
	.2byte	0xb51
	.byte	0x6
	.4byte	.LFB77
	.4byte	.LFE77-.LFB77
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1044
	.uleb128 0x19
	.4byte	.LASF215
	.byte	0x1
	.2byte	0xb51
	.byte	0x2a
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF216
	.byte	0x1
	.2byte	0xb28
	.byte	0x6
	.4byte	.LFB76
	.4byte	.LFE76-.LFB76
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x107c
	.uleb128 0x19
	.4byte	.LASF217
	.byte	0x1
	.2byte	0xb28
	.byte	0x1e
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x1a
	.4byte	.LASF207
	.byte	0x1
	.2byte	0xb2a
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.byte	0
	.uleb128 0x18
	.4byte	.LASF218
	.byte	0x1
	.2byte	0xaf5
	.byte	0x5
	.4byte	0x4d
	.4byte	.LFB75
	.4byte	.LFE75-.LFB75
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x10c8
	.uleb128 0x19
	.4byte	.LASF219
	.byte	0x1
	.2byte	0xaf5
	.byte	0x16
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1a
	.4byte	.LASF207
	.byte	0x1
	.2byte	0xaf7
	.byte	0xc
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x1a
	.4byte	.LASF220
	.byte	0x1
	.2byte	0xaf8
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -11
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF221
	.byte	0x1
	.2byte	0xadd
	.byte	0x6
	.4byte	.LFB74
	.4byte	.LFE74-.LFB74
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x10f0
	.uleb128 0x19
	.4byte	.LASF222
	.byte	0x1
	.2byte	0xadd
	.byte	0x1e
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF223
	.byte	0x1
	.2byte	0xabf
	.byte	0x6
	.4byte	.LFB73
	.4byte	.LFE73-.LFB73
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1128
	.uleb128 0x19
	.4byte	.LASF209
	.byte	0x1
	.2byte	0xabf
	.byte	0x23
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1a
	.4byte	.LASF224
	.byte	0x1
	.2byte	0xac1
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF225
	.byte	0x1
	.2byte	0xa8b
	.byte	0x6
	.4byte	.LFB72
	.4byte	.LFE72-.LFB72
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x119a
	.uleb128 0x19
	.4byte	.LASF209
	.byte	0x1
	.2byte	0xa8b
	.byte	0x1b
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF226
	.byte	0x1
	.2byte	0xa8b
	.byte	0x29
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -21
	.uleb128 0x19
	.4byte	.LASF227
	.byte	0x1
	.2byte	0xa8b
	.byte	0x37
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -22
	.uleb128 0x1a
	.4byte	.LASF224
	.byte	0x1
	.2byte	0xa8d
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x21
	.4byte	.LBB4
	.4byte	.LBE4-.LBB4
	.uleb128 0x1a
	.4byte	.LASF228
	.byte	0x1
	.2byte	0xa91
	.byte	0x10
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF229
	.byte	0x1
	.2byte	0xa6b
	.byte	0x6
	.4byte	.LFB71
	.4byte	.LFE71-.LFB71
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x11c2
	.uleb128 0x1a
	.4byte	.LASF230
	.byte	0x1
	.2byte	0xa6d
	.byte	0xc
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF231
	.byte	0x1
	.2byte	0xa41
	.byte	0x6
	.4byte	.LFB70
	.4byte	.LFE70-.LFB70
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x11fa
	.uleb128 0x1a
	.4byte	.LASF212
	.byte	0x1
	.2byte	0xa43
	.byte	0x15
	.4byte	0xa45
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1a
	.4byte	.LASF213
	.byte	0x1
	.2byte	0xa44
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x18
	.4byte	.LASF232
	.byte	0x1
	.2byte	0xa08
	.byte	0x5
	.4byte	0x4d
	.4byte	.LFB69
	.4byte	.LFE69-.LFB69
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1256
	.uleb128 0x19
	.4byte	.LASF219
	.byte	0x1
	.2byte	0xa08
	.byte	0x17
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1a
	.4byte	.LASF233
	.byte	0x1
	.2byte	0xa0a
	.byte	0x9
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1a
	.4byte	.LASF207
	.byte	0x1
	.2byte	0xa0b
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -13
	.uleb128 0x1a
	.4byte	.LASF234
	.byte	0x1
	.2byte	0xa0c
	.byte	0xc
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF235
	.byte	0x1
	.2byte	0x9f3
	.byte	0x6
	.4byte	.LFB68
	.4byte	.LFE68-.LFB68
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x127e
	.uleb128 0x19
	.4byte	.LASF236
	.byte	0x1
	.2byte	0x9f3
	.byte	0x23
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x20
	.4byte	.LASF237
	.byte	0x1
	.2byte	0x9df
	.byte	0x6
	.4byte	.LFB67
	.4byte	.LFE67-.LFB67
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1e
	.4byte	.LASF238
	.byte	0x1
	.2byte	0x98f
	.byte	0x6
	.4byte	.LFB66
	.4byte	.LFE66-.LFB66
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x12c9
	.uleb128 0x19
	.4byte	.LASF239
	.byte	0x1
	.2byte	0x98f
	.byte	0x1c
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1b
	.ascii	"reg\000"
	.byte	0x1
	.2byte	0x991
	.byte	0xb
	.4byte	0x809
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF240
	.byte	0x1
	.2byte	0x95a
	.byte	0x6
	.4byte	.LFB65
	.4byte	.LFE65-.LFB65
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1301
	.uleb128 0x19
	.4byte	.LASF219
	.byte	0x1
	.2byte	0x95a
	.byte	0x18
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1b
	.ascii	"reg\000"
	.byte	0x1
	.2byte	0x95c
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF241
	.byte	0x1
	.2byte	0x914
	.byte	0x6
	.4byte	.LFB64
	.4byte	.LFE64-.LFB64
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1349
	.uleb128 0x1a
	.4byte	.LASF103
	.byte	0x1
	.2byte	0x916
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1a
	.4byte	.LASF242
	.byte	0x1
	.2byte	0x917
	.byte	0xc
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x1b
	.ascii	"len\000"
	.byte	0x1
	.2byte	0x918
	.byte	0xc
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF243
	.byte	0x1
	.2byte	0x88b
	.byte	0x6
	.4byte	.LFB63
	.4byte	.LFE63-.LFB63
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x139b
	.uleb128 0x1a
	.4byte	.LASF103
	.byte	0x1
	.2byte	0x88d
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x21
	.4byte	.LBB3
	.4byte	.LBE3-.LBB3
	.uleb128 0x1a
	.4byte	.LASF242
	.byte	0x1
	.2byte	0x892
	.byte	0x10
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x1b
	.ascii	"len\000"
	.byte	0x1
	.2byte	0x893
	.byte	0x10
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.byte	0
	.uleb128 0x1d
	.4byte	.LASF244
	.byte	0x1
	.2byte	0x86e
	.byte	0x7
	.4byte	0x5b8
	.4byte	.LFB62
	.4byte	.LFE62-.LFB62
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x22
	.4byte	.LASF245
	.byte	0x1
	.2byte	0x85b
	.byte	0x6
	.4byte	.LFB61
	.4byte	.LFE61-.LFB61
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x140a
	.uleb128 0x19
	.4byte	.LASF149
	.byte	0x1
	.2byte	0x85b
	.byte	0x20
	.4byte	0x82a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.uleb128 0x19
	.4byte	.LASF150
	.byte	0x1
	.2byte	0x85b
	.byte	0x33
	.4byte	0x82a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -8
	.uleb128 0x19
	.4byte	.LASF151
	.byte	0x1
	.2byte	0x85b
	.byte	0x44
	.4byte	0x82a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x19
	.4byte	.LASF152
	.byte	0x1
	.2byte	0x85b
	.byte	0x55
	.4byte	0x82a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF246
	.byte	0x1
	.2byte	0x83e
	.byte	0x6
	.4byte	.LFB60
	.4byte	.LFE60-.LFB60
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1442
	.uleb128 0x19
	.4byte	.LASF247
	.byte	0x1
	.2byte	0x83e
	.byte	0x23
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1b
	.ascii	"val\000"
	.byte	0x1
	.2byte	0x840
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF248
	.byte	0x1
	.2byte	0x820
	.byte	0x6
	.4byte	.LFB59
	.4byte	.LFE59-.LFB59
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x146a
	.uleb128 0x19
	.4byte	.LASF209
	.byte	0x1
	.2byte	0x820
	.byte	0x1f
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF249
	.byte	0x1
	.2byte	0x80b
	.byte	0x6
	.4byte	.LFB58
	.4byte	.LFE58-.LFB58
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1492
	.uleb128 0x19
	.4byte	.LASF250
	.byte	0x1
	.2byte	0x80b
	.byte	0x1e
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF251
	.byte	0x1
	.2byte	0x7ea
	.byte	0x6
	.4byte	.LFB57
	.4byte	.LFE57-.LFB57
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x14ba
	.uleb128 0x19
	.4byte	.LASF209
	.byte	0x1
	.2byte	0x7ea
	.byte	0x1e
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF252
	.byte	0x1
	.2byte	0x7d0
	.byte	0x6
	.4byte	.LFB56
	.4byte	.LFE56-.LFB56
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x14f2
	.uleb128 0x19
	.4byte	.LASF253
	.byte	0x1
	.2byte	0x7d0
	.byte	0x24
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.uleb128 0x1b
	.ascii	"reg\000"
	.byte	0x1
	.2byte	0x7d2
	.byte	0xc
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x20
	.4byte	.LASF254
	.byte	0x1
	.2byte	0x7b3
	.byte	0x6
	.4byte	.LFB55
	.4byte	.LFE55-.LFB55
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1e
	.4byte	.LASF255
	.byte	0x1
	.2byte	0x799
	.byte	0x6
	.4byte	.LFB54
	.4byte	.LFE54-.LFB54
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x152d
	.uleb128 0x19
	.4byte	.LASF256
	.byte	0x1
	.2byte	0x799
	.byte	0x19
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x18
	.4byte	.LASF257
	.byte	0x1
	.2byte	0x775
	.byte	0x5
	.4byte	0x4d
	.4byte	.LFB53
	.4byte	.LFE53-.LFB53
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1569
	.uleb128 0x19
	.4byte	.LASF230
	.byte	0x1
	.2byte	0x775
	.byte	0x1c
	.4byte	0x1569
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x19
	.4byte	.LASF258
	.byte	0x1
	.2byte	0x775
	.byte	0x29
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -14
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x5b8
	.uleb128 0x1e
	.4byte	.LASF259
	.byte	0x1
	.2byte	0x74e
	.byte	0x6
	.4byte	.LFB52
	.4byte	.LFE52-.LFB52
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x15a7
	.uleb128 0x19
	.4byte	.LASF209
	.byte	0x1
	.2byte	0x74e
	.byte	0x20
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1b
	.ascii	"reg\000"
	.byte	0x1
	.2byte	0x750
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF260
	.byte	0x1
	.2byte	0x735
	.byte	0x6
	.4byte	.LFB51
	.4byte	.LFE51-.LFB51
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x15df
	.uleb128 0x19
	.4byte	.LASF219
	.byte	0x1
	.2byte	0x735
	.byte	0x20
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x19
	.4byte	.LASF261
	.byte	0x1
	.2byte	0x735
	.byte	0x2c
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -11
	.byte	0
	.uleb128 0x18
	.4byte	.LASF262
	.byte	0x1
	.2byte	0x6de
	.byte	0x8
	.4byte	0x5c9
	.4byte	.LFB50
	.4byte	.LFE50-.LFB50
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x160b
	.uleb128 0x1a
	.4byte	.LASF263
	.byte	0x1
	.2byte	0x6e0
	.byte	0xc
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF264
	.byte	0x1
	.2byte	0x6b8
	.byte	0x6
	.4byte	.LFB49
	.4byte	.LFE49-.LFB49
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1633
	.uleb128 0x19
	.4byte	.LASF265
	.byte	0x1
	.2byte	0x6b8
	.byte	0x23
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x20
	.4byte	.LASF266
	.byte	0x1
	.2byte	0x6a4
	.byte	0x6
	.4byte	.LFB48
	.4byte	.LFE48-.LFB48
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x20
	.4byte	.LASF267
	.byte	0x1
	.2byte	0x692
	.byte	0x6
	.4byte	.LFB47
	.4byte	.LFE47-.LFB47
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x20
	.4byte	.LASF268
	.byte	0x1
	.2byte	0x680
	.byte	0x6
	.4byte	.LFB46
	.4byte	.LFE46-.LFB46
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x18
	.4byte	.LASF269
	.byte	0x1
	.2byte	0x649
	.byte	0x5
	.4byte	0x4d
	.4byte	.LFB45
	.4byte	.LFE45-.LFB45
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x16c8
	.uleb128 0x19
	.4byte	.LASF201
	.byte	0x1
	.2byte	0x649
	.byte	0x22
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF270
	.byte	0x1
	.2byte	0x649
	.byte	0x30
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -22
	.uleb128 0x1a
	.4byte	.LASF271
	.byte	0x1
	.2byte	0x64b
	.byte	0x9
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1a
	.4byte	.LASF272
	.byte	0x1
	.2byte	0x64c
	.byte	0x9
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x18
	.4byte	.LASF273
	.byte	0x1
	.2byte	0x60c
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB44
	.4byte	.LFE44-.LFB44
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1734
	.uleb128 0x19
	.4byte	.LASF49
	.byte	0x1
	.2byte	0x60c
	.byte	0x22
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF270
	.byte	0x1
	.2byte	0x60c
	.byte	0x2f
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -22
	.uleb128 0x1a
	.4byte	.LASF274
	.byte	0x1
	.2byte	0x60e
	.byte	0xb
	.4byte	0x1734
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1a
	.4byte	.LASF193
	.byte	0x1
	.2byte	0x60f
	.byte	0xb
	.4byte	0x1744
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1a
	.4byte	.LASF275
	.byte	0x1
	.2byte	0x610
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.byte	0
	.uleb128 0xc
	.4byte	0x5b8
	.4byte	0x1744
	.uleb128 0xd
	.4byte	0x8b
	.byte	0
	.byte	0
	.uleb128 0xc
	.4byte	0x5b8
	.4byte	0x1754
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x3
	.byte	0
	.uleb128 0x18
	.4byte	.LASF276
	.byte	0x1
	.2byte	0x566
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB43
	.4byte	.LFE43-.LFB43
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x17cf
	.uleb128 0x19
	.4byte	.LASF219
	.byte	0x1
	.2byte	0x566
	.byte	0x1e
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x1a
	.4byte	.LASF274
	.byte	0x1
	.2byte	0x568
	.byte	0xb
	.4byte	0x1744
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1a
	.4byte	.LASF193
	.byte	0x1
	.2byte	0x569
	.byte	0xb
	.4byte	0x1744
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1b
	.ascii	"mra\000"
	.byte	0x1
	.2byte	0x56a
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1b
	.ascii	"mrb\000"
	.byte	0x1
	.2byte	0x56a
	.byte	0x12
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1b
	.ascii	"mr\000"
	.byte	0x1
	.2byte	0x56a
	.byte	0x18
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x18
	.4byte	.LASF277
	.byte	0x1
	.2byte	0x540
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB42
	.4byte	.LFE42-.LFB42
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x180b
	.uleb128 0x19
	.4byte	.LASF270
	.byte	0x1
	.2byte	0x540
	.byte	0x1c
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1a
	.4byte	.LASF278
	.byte	0x1
	.2byte	0x542
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF279
	.byte	0x1
	.2byte	0x524
	.byte	0x6
	.4byte	.LFB41
	.4byte	.LFE41-.LFB41
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1861
	.uleb128 0x19
	.4byte	.LASF270
	.byte	0x1
	.2byte	0x524
	.byte	0x19
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF280
	.byte	0x1
	.2byte	0x524
	.byte	0x2a
	.4byte	0x1861
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF258
	.byte	0x1
	.2byte	0x524
	.byte	0x37
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -25
	.uleb128 0x1b
	.ascii	"i\000"
	.byte	0x1
	.2byte	0x526
	.byte	0x9
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x5da
	.uleb128 0x1e
	.4byte	.LASF281
	.byte	0x1
	.2byte	0x511
	.byte	0x6
	.4byte	.LFB40
	.4byte	.LFE40-.LFB40
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x188f
	.uleb128 0x19
	.4byte	.LASF282
	.byte	0x1
	.2byte	0x511
	.byte	0x18
	.4byte	0x1569
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF283
	.byte	0x1
	.2byte	0x500
	.byte	0x6
	.4byte	.LFB39
	.4byte	.LFE39-.LFB39
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x18b7
	.uleb128 0x19
	.4byte	.LASF282
	.byte	0x1
	.2byte	0x500
	.byte	0x18
	.4byte	0x1569
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF284
	.byte	0x1
	.2byte	0x4ee
	.byte	0x6
	.4byte	.LFB38
	.4byte	.LFE38-.LFB38
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x18df
	.uleb128 0x19
	.4byte	.LASF285
	.byte	0x1
	.2byte	0x4ee
	.byte	0x1e
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF286
	.byte	0x1
	.2byte	0x4dc
	.byte	0x6
	.4byte	.LFB37
	.4byte	.LFE37-.LFB37
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1907
	.uleb128 0x19
	.4byte	.LASF287
	.byte	0x1
	.2byte	0x4dc
	.byte	0x1a
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF288
	.byte	0x1
	.2byte	0x4bd
	.byte	0x6
	.4byte	.LFB36
	.4byte	.LFE36-.LFB36
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x193f
	.uleb128 0x19
	.4byte	.LASF209
	.byte	0x1
	.2byte	0x4bd
	.byte	0x23
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x1a
	.4byte	.LASF289
	.byte	0x1
	.2byte	0x4bf
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF290
	.byte	0x1
	.2byte	0x49b
	.byte	0x6
	.4byte	.LFB35
	.4byte	.LFE35-.LFB35
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x19a5
	.uleb128 0x19
	.4byte	.LASF291
	.byte	0x1
	.2byte	0x49b
	.byte	0x22
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF292
	.byte	0x1
	.2byte	0x49b
	.byte	0x30
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF293
	.byte	0x1
	.2byte	0x49b
	.byte	0x41
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1b
	.ascii	"j\000"
	.byte	0x1
	.2byte	0x49d
	.byte	0xd
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1a
	.4byte	.LASF294
	.byte	0x1
	.2byte	0x49e
	.byte	0xd
	.4byte	0x1744
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF295
	.byte	0x1
	.2byte	0x483
	.byte	0x6
	.4byte	.LFB34
	.4byte	.LFE34-.LFB34
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x19fd
	.uleb128 0x19
	.4byte	.LASF291
	.byte	0x1
	.2byte	0x483
	.byte	0x22
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF292
	.byte	0x1
	.2byte	0x483
	.byte	0x30
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF293
	.byte	0x1
	.2byte	0x483
	.byte	0x41
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -26
	.uleb128 0x1a
	.4byte	.LASF294
	.byte	0x1
	.2byte	0x485
	.byte	0xd
	.4byte	0x809
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF296
	.byte	0x1
	.2byte	0x470
	.byte	0x6
	.4byte	.LFB33
	.4byte	.LFE33-.LFB33
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1a45
	.uleb128 0x19
	.4byte	.LASF291
	.byte	0x1
	.2byte	0x470
	.byte	0x21
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x19
	.4byte	.LASF292
	.byte	0x1
	.2byte	0x470
	.byte	0x30
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x19
	.4byte	.LASF293
	.byte	0x1
	.2byte	0x470
	.byte	0x41
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -17
	.byte	0
	.uleb128 0x18
	.4byte	.LASF297
	.byte	0x1
	.2byte	0x459
	.byte	0x7
	.4byte	0x5b8
	.4byte	.LFB32
	.4byte	.LFE32-.LFB32
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1a91
	.uleb128 0x19
	.4byte	.LASF291
	.byte	0x1
	.2byte	0x459
	.byte	0x21
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF292
	.byte	0x1
	.2byte	0x459
	.byte	0x30
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1a
	.4byte	.LASF293
	.byte	0x1
	.2byte	0x45b
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.byte	0
	.uleb128 0x18
	.4byte	.LASF298
	.byte	0x1
	.2byte	0x440
	.byte	0x8
	.4byte	0x5c9
	.4byte	.LFB31
	.4byte	.LFE31-.LFB31
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1aed
	.uleb128 0x19
	.4byte	.LASF291
	.byte	0x1
	.2byte	0x440
	.byte	0x23
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF292
	.byte	0x1
	.2byte	0x440
	.byte	0x31
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1a
	.4byte	.LASF293
	.byte	0x1
	.2byte	0x442
	.byte	0xd
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x1a
	.4byte	.LASF294
	.byte	0x1
	.2byte	0x443
	.byte	0xd
	.4byte	0x809
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x18
	.4byte	.LASF299
	.byte	0x1
	.2byte	0x423
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB30
	.4byte	.LFE30-.LFB30
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1b57
	.uleb128 0x19
	.4byte	.LASF291
	.byte	0x1
	.2byte	0x423
	.byte	0x23
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x19
	.4byte	.LASF292
	.byte	0x1
	.2byte	0x423
	.byte	0x31
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1a
	.4byte	.LASF293
	.byte	0x1
	.2byte	0x425
	.byte	0xd
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1b
	.ascii	"j\000"
	.byte	0x1
	.2byte	0x426
	.byte	0xd
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1a
	.4byte	.LASF294
	.byte	0x1
	.2byte	0x427
	.byte	0xd
	.4byte	0x1744
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF300
	.byte	0x1
	.2byte	0x3eb
	.byte	0x6
	.4byte	.LFB29
	.4byte	.LFE29-.LFB29
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1bcf
	.uleb128 0x19
	.4byte	.LASF301
	.byte	0x1
	.2byte	0x3ed
	.byte	0xd
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x19
	.4byte	.LASF302
	.byte	0x1
	.2byte	0x3ee
	.byte	0xd
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF258
	.byte	0x1
	.2byte	0x3ef
	.byte	0xd
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF294
	.byte	0x1
	.2byte	0x3f0
	.byte	0xe
	.4byte	0x1569
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1a
	.4byte	.LASF303
	.byte	0x1
	.2byte	0x3f3
	.byte	0xb
	.4byte	0x1bcf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1b
	.ascii	"cnt\000"
	.byte	0x1
	.2byte	0x3f4
	.byte	0xb
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0xc
	.4byte	0x5b8
	.4byte	0x1bdf
	.uleb128 0xd
	.4byte	0x8b
	.byte	0x2
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF304
	.byte	0x1
	.2byte	0x3ab
	.byte	0x6
	.4byte	.LFB28
	.4byte	.LFE28-.LFB28
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1c57
	.uleb128 0x19
	.4byte	.LASF301
	.byte	0x1
	.2byte	0x3ad
	.byte	0x11
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x19
	.4byte	.LASF302
	.byte	0x1
	.2byte	0x3ae
	.byte	0x11
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF258
	.byte	0x1
	.2byte	0x3af
	.byte	0x11
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.4byte	.LASF294
	.byte	0x1
	.2byte	0x3b0
	.byte	0x12
	.4byte	0x1c57
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1a
	.4byte	.LASF303
	.byte	0x1
	.2byte	0x3b3
	.byte	0xb
	.4byte	0x1bcf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1b
	.ascii	"cnt\000"
	.byte	0x1
	.2byte	0x3b4
	.byte	0xb
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x5c4
	.uleb128 0x1e
	.4byte	.LASF305
	.byte	0x1
	.2byte	0x38f
	.byte	0x6
	.4byte	.LFB27
	.4byte	.LFE27-.LFB27
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1c85
	.uleb128 0x19
	.4byte	.LASF306
	.byte	0x1
	.2byte	0x38f
	.byte	0x1e
	.4byte	0x1569
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1d
	.4byte	.LASF307
	.byte	0x1
	.2byte	0x37d
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB26
	.4byte	.LFE26-.LFB26
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1d
	.4byte	.LASF308
	.byte	0x1
	.2byte	0x36d
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB25
	.4byte	.LFE25-.LFB25
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1d
	.4byte	.LASF309
	.byte	0x1
	.2byte	0x35d
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB24
	.4byte	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1e
	.4byte	.LASF310
	.byte	0x1
	.2byte	0x34d
	.byte	0x6
	.4byte	.LFB23
	.4byte	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1cf2
	.uleb128 0x19
	.4byte	.LASF306
	.byte	0x1
	.2byte	0x34d
	.byte	0x22
	.4byte	0x1569
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1d
	.4byte	.LASF311
	.byte	0x1
	.2byte	0x33c
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB22
	.4byte	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1d
	.4byte	.LASF312
	.byte	0x1
	.2byte	0x32c
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB21
	.4byte	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1e
	.4byte	.LASF313
	.byte	0x1
	.2byte	0x31c
	.byte	0x6
	.4byte	.LFB20
	.4byte	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1d48
	.uleb128 0x19
	.4byte	.LASF306
	.byte	0x1
	.2byte	0x31c
	.byte	0x22
	.4byte	0x1569
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF314
	.byte	0x1
	.2byte	0x300
	.byte	0x6
	.4byte	.LFB19
	.4byte	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1d70
	.uleb128 0x19
	.4byte	.LASF315
	.byte	0x1
	.2byte	0x300
	.byte	0x28
	.4byte	0x1d70
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x987
	.uleb128 0x18
	.4byte	.LASF316
	.byte	0x1
	.2byte	0x2df
	.byte	0x7
	.4byte	0x600
	.4byte	.LFB18
	.4byte	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1dc0
	.uleb128 0x1a
	.4byte	.LASF293
	.byte	0x1
	.2byte	0x2e1
	.byte	0xd
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1b
	.ascii	"j\000"
	.byte	0x1
	.2byte	0x2e2
	.byte	0xd
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1a
	.4byte	.LASF294
	.byte	0x1
	.2byte	0x2e3
	.byte	0xd
	.4byte	0x1bcf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF317
	.byte	0x1
	.2byte	0x2c4
	.byte	0x6
	.4byte	.LFB17
	.4byte	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1e08
	.uleb128 0x19
	.4byte	.LASF294
	.byte	0x1
	.2byte	0x2c4
	.byte	0x1d
	.4byte	0x1569
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x23
	.ascii	"len\000"
	.byte	0x1
	.2byte	0x2c4
	.byte	0x2c
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -14
	.uleb128 0x19
	.4byte	.LASF318
	.byte	0x1
	.2byte	0x2c4
	.byte	0x38
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF319
	.byte	0x1
	.2byte	0x2ae
	.byte	0x6
	.4byte	.LFB16
	.4byte	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1e50
	.uleb128 0x19
	.4byte	.LASF294
	.byte	0x1
	.2byte	0x2ae
	.byte	0x1c
	.4byte	0x1569
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x19
	.4byte	.LASF258
	.byte	0x1
	.2byte	0x2ae
	.byte	0x2b
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -14
	.uleb128 0x19
	.4byte	.LASF320
	.byte	0x1
	.2byte	0x2ae
	.byte	0x3a
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF321
	.byte	0x1
	.2byte	0x292
	.byte	0x6
	.4byte	.LFB15
	.4byte	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1ea8
	.uleb128 0x19
	.4byte	.LASF322
	.byte	0x1
	.2byte	0x292
	.byte	0x1e
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.uleb128 0x19
	.4byte	.LASF323
	.byte	0x1
	.2byte	0x292
	.byte	0x34
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF324
	.byte	0x1
	.2byte	0x292
	.byte	0x48
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1a
	.4byte	.LASF325
	.byte	0x1
	.2byte	0x29b
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x18
	.4byte	.LASF326
	.byte	0x1
	.2byte	0x26d
	.byte	0x5
	.4byte	0x4d
	.4byte	.LFB14
	.4byte	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1ef4
	.uleb128 0x19
	.4byte	.LASF322
	.byte	0x1
	.2byte	0x26d
	.byte	0x1c
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x19
	.4byte	.LASF327
	.byte	0x1
	.2byte	0x26d
	.byte	0x32
	.4byte	0x1569
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x19
	.4byte	.LASF323
	.byte	0x1
	.2byte	0x26d
	.byte	0x47
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF328
	.byte	0x1
	.2byte	0x253
	.byte	0x6
	.4byte	.LFB13
	.4byte	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1f1c
	.uleb128 0x19
	.4byte	.LASF329
	.byte	0x1
	.2byte	0x253
	.byte	0x23
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF330
	.byte	0x1
	.2byte	0x240
	.byte	0x6
	.4byte	.LFB12
	.4byte	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1f44
	.uleb128 0x19
	.4byte	.LASF331
	.byte	0x1
	.2byte	0x240
	.byte	0x23
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF332
	.byte	0x1
	.2byte	0x1b5
	.byte	0x6
	.4byte	.LFB11
	.4byte	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x1fdb
	.uleb128 0x19
	.4byte	.LASF333
	.byte	0x1
	.2byte	0x1b5
	.byte	0x22
	.4byte	0x1fdb
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1a
	.4byte	.LASF334
	.byte	0x1
	.2byte	0x1b7
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -9
	.uleb128 0x1a
	.4byte	.LASF335
	.byte	0x1
	.2byte	0x1b8
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x1a
	.4byte	.LASF109
	.byte	0x1
	.2byte	0x1b9
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -13
	.uleb128 0x1a
	.4byte	.LASF293
	.byte	0x1
	.2byte	0x1ba
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1a
	.4byte	.LASF336
	.byte	0x1
	.2byte	0x1bb
	.byte	0xc
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.uleb128 0x1a
	.4byte	.LASF256
	.byte	0x1
	.2byte	0x1bc
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -14
	.uleb128 0x1b
	.ascii	"bw\000"
	.byte	0x1
	.2byte	0x1bd
	.byte	0xb
	.4byte	0x5b8
	.uleb128 0x2
	.byte	0x91
	.sleb128 -15
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x8d9
	.uleb128 0x1e
	.4byte	.LASF337
	.byte	0x1
	.2byte	0x19b
	.byte	0x6
	.4byte	.LFB10
	.4byte	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2009
	.uleb128 0x19
	.4byte	.LASF333
	.byte	0x1
	.2byte	0x19b
	.byte	0x28
	.4byte	0x2009
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x9
	.byte	0x4
	.4byte	0x909
	.uleb128 0x1d
	.4byte	.LASF338
	.byte	0x1
	.2byte	0x188
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB9
	.4byte	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1f
	.4byte	.LASF339
	.byte	0x1
	.2byte	0x178
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1f
	.4byte	.LASF340
	.byte	0x1
	.2byte	0x166
	.byte	0x8
	.4byte	0x5da
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1e
	.4byte	.LASF341
	.byte	0x1
	.2byte	0x14d
	.byte	0x6
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x20ac
	.uleb128 0x19
	.4byte	.LASF342
	.byte	0x1
	.2byte	0x14d
	.byte	0x1e
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF201
	.byte	0x1
	.2byte	0x14d
	.byte	0x2e
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1b
	.ascii	"buf\000"
	.byte	0x1
	.2byte	0x14f
	.byte	0xb
	.4byte	0x1bcf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1a
	.4byte	.LASF343
	.byte	0x1
	.2byte	0x150
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF344
	.byte	0x1
	.2byte	0x134
	.byte	0x6
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2104
	.uleb128 0x19
	.4byte	.LASF342
	.byte	0x1
	.2byte	0x134
	.byte	0x22
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.4byte	.LASF345
	.byte	0x1
	.2byte	0x134
	.byte	0x32
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1b
	.ascii	"buf\000"
	.byte	0x1
	.2byte	0x136
	.byte	0xb
	.4byte	0x1bcf
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x1a
	.4byte	.LASF343
	.byte	0x1
	.2byte	0x137
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x1e
	.4byte	.LASF346
	.byte	0x1
	.2byte	0x118
	.byte	0x6
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x214b
	.uleb128 0x23
	.ascii	"lna\000"
	.byte	0x1
	.2byte	0x118
	.byte	0x1b
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x23
	.ascii	"pa\000"
	.byte	0x1
	.2byte	0x118
	.byte	0x24
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1a
	.4byte	.LASF347
	.byte	0x1
	.2byte	0x11a
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x24
	.4byte	.LASF348
	.byte	0x1
	.byte	0xfb
	.byte	0x6
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2171
	.uleb128 0x25
	.4byte	.LASF209
	.byte	0x1
	.byte	0xfb
	.byte	0x20
	.4byte	0x4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.uleb128 0x26
	.4byte	.LASF349
	.byte	0x1
	.byte	0xea
	.byte	0x7
	.4byte	0x5b8
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x27
	.4byte	.LASF350
	.byte	0x1
	.byte	0x8e
	.byte	0x5
	.4byte	0x4d
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x21e8
	.uleb128 0x25
	.4byte	.LASF333
	.byte	0x1
	.byte	0x8e
	.byte	0x1b
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -26
	.uleb128 0x17
	.4byte	.LASF351
	.byte	0x1
	.byte	0x90
	.byte	0xc
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x17
	.4byte	.LASF352
	.byte	0x1
	.byte	0x91
	.byte	0xc
	.4byte	0x5da
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x21
	.4byte	.LBB2
	.4byte	.LBE2-.LBB2
	.uleb128 0x17
	.4byte	.LASF353
	.byte	0x1
	.byte	0xcc
	.byte	0x10
	.4byte	0x5c9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -18
	.byte	0
	.byte	0
	.uleb128 0x28
	.4byte	.LASF354
	.byte	0x1
	.byte	0x63
	.byte	0x5
	.4byte	0x4d
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x25
	.4byte	.LASF302
	.byte	0x1
	.byte	0x63
	.byte	0x26
	.4byte	0x8b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -4
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x2134
	.uleb128 0x19
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_pubnames,"",%progbits
	.4byte	0x8ac
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x220f
	.4byte	0xb3b
	.ascii	"dw1000local\000"
	.4byte	0xb4d
	.ascii	"pdw1000local\000"
	.4byte	0xb3b
	.ascii	"dw1000local\000"
	.4byte	0xb65
	.ascii	"dwt_calcpgcount\000"
	.4byte	0xc0f
	.ascii	"dwt_calcpowertempadj\000"
	.4byte	0xc8b
	.ascii	"_dwt_computetxpowersetting\000"
	.4byte	0xd45
	.ascii	"dwt_calcbandwidthtempadj\000"
	.4byte	0xe0f
	.ascii	"dwt_readwakeupvbat\000"
	.4byte	0xe26
	.ascii	"dwt_readwakeuptemp\000"
	.4byte	0xe3d
	.ascii	"dwt_readtempvbat\000"
	.4byte	0xe99
	.ascii	"dwt_configcontinuousframemode\000"
	.4byte	0xec1
	.ascii	"dwt_configcwmode\000"
	.4byte	0xee9
	.ascii	"dwt_getinitxtaltrim\000"
	.4byte	0xf00
	.ascii	"dwt_setxtaltrim\000"
	.4byte	0xf38
	.ascii	"dwt_softreset\000"
	.4byte	0xf4b
	.ascii	"dwt_rxreset\000"
	.4byte	0xf5e
	.ascii	"dwt_readeventcounters\000"
	.4byte	0xf9c
	.ascii	"dwt_configeventcounters\000"
	.4byte	0xfc4
	.ascii	"dwt_setinterrupt\000"
	.4byte	0x101c
	.ascii	"dwt_setpreambledetecttimeout\000"
	.4byte	0x1044
	.ascii	"dwt_setrxtimeout\000"
	.4byte	0x107c
	.ascii	"dwt_rxenable\000"
	.4byte	0x10c8
	.ascii	"dwt_setsnoozetime\000"
	.4byte	0x10f0
	.ascii	"dwt_setlowpowerlistening\000"
	.4byte	0x1128
	.ascii	"dwt_setsniffmode\000"
	.4byte	0x119a
	.ascii	"dwt_syncrxbufptrs\000"
	.4byte	0x11c2
	.ascii	"dwt_forcetrxoff\000"
	.4byte	0x11fa
	.ascii	"dwt_starttx\000"
	.4byte	0x1256
	.ascii	"dwt_setdelayedtrxtime\000"
	.4byte	0x127e
	.ascii	"_dwt_disablesequencing\000"
	.4byte	0x1291
	.ascii	"_dwt_enableclocks\000"
	.4byte	0x12c9
	.ascii	"dwt_setleds\000"
	.4byte	0x1301
	.ascii	"dwt_lowpowerlistenisr\000"
	.4byte	0x1349
	.ascii	"dwt_isr\000"
	.4byte	0x139b
	.ascii	"dwt_checkirq\000"
	.4byte	0x13b2
	.ascii	"dwt_setcallbacks\000"
	.4byte	0x140a
	.ascii	"dwt_setrxaftertxdelay\000"
	.4byte	0x1442
	.ascii	"dwt_setdblrxbuffmode\000"
	.4byte	0x146a
	.ascii	"dwt_enableautoack\000"
	.4byte	0x1492
	.ascii	"dwt_setsmarttxpower\000"
	.4byte	0x14ba
	.ascii	"dwt_loadopsettabfromotp\000"
	.4byte	0x14f2
	.ascii	"_dwt_loaducodefromrom\000"
	.4byte	0x1505
	.ascii	"_dwt_configlde\000"
	.4byte	0x152d
	.ascii	"dwt_spicswakeup\000"
	.4byte	0x156f
	.ascii	"dwt_entersleepaftertx\000"
	.4byte	0x15a7
	.ascii	"dwt_configuresleep\000"
	.4byte	0x15df
	.ascii	"dwt_calibratesleepcnt\000"
	.4byte	0x160b
	.ascii	"dwt_configuresleepcnt\000"
	.4byte	0x1633
	.ascii	"dwt_entersleep\000"
	.4byte	0x1646
	.ascii	"_dwt_aonarrayupload\000"
	.4byte	0x1659
	.ascii	"_dwt_aonconfigupload\000"
	.4byte	0x166c
	.ascii	"dwt_otpwriteandverify\000"
	.4byte	0x16c8
	.ascii	"_dwt_otpprogword32\000"
	.4byte	0x1754
	.ascii	"_dwt_otpsetmrregs\000"
	.4byte	0x17cf
	.ascii	"_dwt_otpread\000"
	.4byte	0x180b
	.ascii	"dwt_otpread\000"
	.4byte	0x1867
	.ascii	"dwt_geteui\000"
	.4byte	0x188f
	.ascii	"dwt_seteui\000"
	.4byte	0x18b7
	.ascii	"dwt_setaddress16\000"
	.4byte	0x18df
	.ascii	"dwt_setpanid\000"
	.4byte	0x1907
	.ascii	"dwt_enableframefilter\000"
	.4byte	0x193f
	.ascii	"dwt_write32bitoffsetreg\000"
	.4byte	0x19a5
	.ascii	"dwt_write16bitoffsetreg\000"
	.4byte	0x19fd
	.ascii	"dwt_write8bitoffsetreg\000"
	.4byte	0x1a45
	.ascii	"dwt_read8bitoffsetreg\000"
	.4byte	0x1a91
	.ascii	"dwt_read16bitoffsetreg\000"
	.4byte	0x1aed
	.ascii	"dwt_read32bitoffsetreg\000"
	.4byte	0x1b57
	.ascii	"dwt_readfromdevice\000"
	.4byte	0x1bdf
	.ascii	"dwt_writetodevice\000"
	.4byte	0x1c5d
	.ascii	"dwt_readsystime\000"
	.4byte	0x1c85
	.ascii	"dwt_readsystimestamphi32\000"
	.4byte	0x1c9c
	.ascii	"dwt_readrxtimestamplo32\000"
	.4byte	0x1cb3
	.ascii	"dwt_readrxtimestamphi32\000"
	.4byte	0x1cca
	.ascii	"dwt_readrxtimestamp\000"
	.4byte	0x1cf2
	.ascii	"dwt_readtxtimestamplo32\000"
	.4byte	0x1d09
	.ascii	"dwt_readtxtimestamphi32\000"
	.4byte	0x1d20
	.ascii	"dwt_readtxtimestamp\000"
	.4byte	0x1d48
	.ascii	"dwt_readdiagnostics\000"
	.4byte	0x1d76
	.ascii	"dwt_readcarrierintegrator\000"
	.4byte	0x1dc0
	.ascii	"dwt_readaccdata\000"
	.4byte	0x1e08
	.ascii	"dwt_readrxdata\000"
	.4byte	0x1e50
	.ascii	"dwt_writetxfctrl\000"
	.4byte	0x1ea8
	.ascii	"dwt_writetxdata\000"
	.4byte	0x1ef4
	.ascii	"dwt_settxantennadelay\000"
	.4byte	0x1f1c
	.ascii	"dwt_setrxantennadelay\000"
	.4byte	0x1f44
	.ascii	"dwt_configure\000"
	.4byte	0x1fe1
	.ascii	"dwt_configuretxrf\000"
	.4byte	0x200f
	.ascii	"dwt_readdevid\000"
	.4byte	0x2026
	.ascii	"dwt_getlotid\000"
	.4byte	0x203d
	.ascii	"dwt_getpartid\000"
	.4byte	0x2054
	.ascii	"dwt_setgpiovalue\000"
	.4byte	0x20ac
	.ascii	"dwt_setgpiodirection\000"
	.4byte	0x2104
	.ascii	"dwt_setlnapamode\000"
	.4byte	0x214b
	.ascii	"dwt_setfinegraintxseq\000"
	.4byte	0x2171
	.ascii	"dwt_otprevision\000"
	.4byte	0x2187
	.ascii	"dwt_initialise\000"
	.4byte	0x21e8
	.ascii	"dwt_setlocaldataptr\000"
	.4byte	0
	.section	.debug_pubtypes,"",%progbits
	.4byte	0x23f
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x220f
	.4byte	0x4d
	.ascii	"int\000"
	.4byte	0x59
	.ascii	"long int\000"
	.4byte	0x25
	.ascii	"__mbstate_s\000"
	.4byte	0x7f
	.ascii	"char\000"
	.4byte	0x8b
	.ascii	"unsigned int\000"
	.4byte	0x26c
	.ascii	"__RAL_locale_data_t\000"
	.4byte	0x27d
	.ascii	"unsigned char\000"
	.4byte	0x365
	.ascii	"__RAL_locale_codeset_t\000"
	.4byte	0x3b3
	.ascii	"__RAL_locale_t\000"
	.4byte	0x3c4
	.ascii	"__locale_s\000"
	.4byte	0x537
	.ascii	"short unsigned int\000"
	.4byte	0x53e
	.ascii	"__RAL_error_decoder_fn_t\000"
	.4byte	0x560
	.ascii	"__RAL_error_decoder_s\000"
	.4byte	0x591
	.ascii	"__RAL_error_decoder_t\000"
	.4byte	0x5b1
	.ascii	"long long int\000"
	.4byte	0x5b8
	.ascii	"uint8\000"
	.4byte	0x5c9
	.ascii	"uint16\000"
	.4byte	0x5eb
	.ascii	"long unsigned int\000"
	.4byte	0x5da
	.ascii	"uint32\000"
	.4byte	0x5f2
	.ascii	"signed char\000"
	.4byte	0x5f9
	.ascii	"short int\000"
	.4byte	0x600
	.ascii	"int32\000"
	.4byte	0x640
	.ascii	"agc_cfg_struct\000"
	.4byte	0x792
	.ascii	"double\000"
	.4byte	0x819
	.ascii	"dwt_cb_data_t\000"
	.4byte	0x82a
	.ascii	"dwt_cb_t\000"
	.4byte	0x8d9
	.ascii	"dwt_config_t\000"
	.4byte	0x909
	.ascii	"dwt_txconfig_t\000"
	.4byte	0x987
	.ascii	"dwt_rxdiag_t\000"
	.4byte	0xa39
	.ascii	"dwt_deviceentcnts_t\000"
	.4byte	0xa45
	.ascii	"decaIrqStatus_t\000"
	.4byte	0xb1f
	.ascii	"dwt_local_data_t\000"
	.4byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x304
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	.LFB3
	.4byte	.LFE3-.LFB3
	.4byte	.LFB4
	.4byte	.LFE4-.LFB4
	.4byte	.LFB5
	.4byte	.LFE5-.LFB5
	.4byte	.LFB6
	.4byte	.LFE6-.LFB6
	.4byte	.LFB7
	.4byte	.LFE7-.LFB7
	.4byte	.LFB8
	.4byte	.LFE8-.LFB8
	.4byte	.LFB9
	.4byte	.LFE9-.LFB9
	.4byte	.LFB10
	.4byte	.LFE10-.LFB10
	.4byte	.LFB11
	.4byte	.LFE11-.LFB11
	.4byte	.LFB12
	.4byte	.LFE12-.LFB12
	.4byte	.LFB13
	.4byte	.LFE13-.LFB13
	.4byte	.LFB14
	.4byte	.LFE14-.LFB14
	.4byte	.LFB15
	.4byte	.LFE15-.LFB15
	.4byte	.LFB16
	.4byte	.LFE16-.LFB16
	.4byte	.LFB17
	.4byte	.LFE17-.LFB17
	.4byte	.LFB18
	.4byte	.LFE18-.LFB18
	.4byte	.LFB19
	.4byte	.LFE19-.LFB19
	.4byte	.LFB20
	.4byte	.LFE20-.LFB20
	.4byte	.LFB21
	.4byte	.LFE21-.LFB21
	.4byte	.LFB22
	.4byte	.LFE22-.LFB22
	.4byte	.LFB23
	.4byte	.LFE23-.LFB23
	.4byte	.LFB24
	.4byte	.LFE24-.LFB24
	.4byte	.LFB25
	.4byte	.LFE25-.LFB25
	.4byte	.LFB26
	.4byte	.LFE26-.LFB26
	.4byte	.LFB27
	.4byte	.LFE27-.LFB27
	.4byte	.LFB28
	.4byte	.LFE28-.LFB28
	.4byte	.LFB29
	.4byte	.LFE29-.LFB29
	.4byte	.LFB30
	.4byte	.LFE30-.LFB30
	.4byte	.LFB31
	.4byte	.LFE31-.LFB31
	.4byte	.LFB32
	.4byte	.LFE32-.LFB32
	.4byte	.LFB33
	.4byte	.LFE33-.LFB33
	.4byte	.LFB34
	.4byte	.LFE34-.LFB34
	.4byte	.LFB35
	.4byte	.LFE35-.LFB35
	.4byte	.LFB36
	.4byte	.LFE36-.LFB36
	.4byte	.LFB37
	.4byte	.LFE37-.LFB37
	.4byte	.LFB38
	.4byte	.LFE38-.LFB38
	.4byte	.LFB39
	.4byte	.LFE39-.LFB39
	.4byte	.LFB40
	.4byte	.LFE40-.LFB40
	.4byte	.LFB41
	.4byte	.LFE41-.LFB41
	.4byte	.LFB42
	.4byte	.LFE42-.LFB42
	.4byte	.LFB43
	.4byte	.LFE43-.LFB43
	.4byte	.LFB44
	.4byte	.LFE44-.LFB44
	.4byte	.LFB45
	.4byte	.LFE45-.LFB45
	.4byte	.LFB46
	.4byte	.LFE46-.LFB46
	.4byte	.LFB47
	.4byte	.LFE47-.LFB47
	.4byte	.LFB48
	.4byte	.LFE48-.LFB48
	.4byte	.LFB49
	.4byte	.LFE49-.LFB49
	.4byte	.LFB50
	.4byte	.LFE50-.LFB50
	.4byte	.LFB51
	.4byte	.LFE51-.LFB51
	.4byte	.LFB52
	.4byte	.LFE52-.LFB52
	.4byte	.LFB53
	.4byte	.LFE53-.LFB53
	.4byte	.LFB54
	.4byte	.LFE54-.LFB54
	.4byte	.LFB55
	.4byte	.LFE55-.LFB55
	.4byte	.LFB56
	.4byte	.LFE56-.LFB56
	.4byte	.LFB57
	.4byte	.LFE57-.LFB57
	.4byte	.LFB58
	.4byte	.LFE58-.LFB58
	.4byte	.LFB59
	.4byte	.LFE59-.LFB59
	.4byte	.LFB60
	.4byte	.LFE60-.LFB60
	.4byte	.LFB61
	.4byte	.LFE61-.LFB61
	.4byte	.LFB62
	.4byte	.LFE62-.LFB62
	.4byte	.LFB63
	.4byte	.LFE63-.LFB63
	.4byte	.LFB64
	.4byte	.LFE64-.LFB64
	.4byte	.LFB65
	.4byte	.LFE65-.LFB65
	.4byte	.LFB66
	.4byte	.LFE66-.LFB66
	.4byte	.LFB67
	.4byte	.LFE67-.LFB67
	.4byte	.LFB68
	.4byte	.LFE68-.LFB68
	.4byte	.LFB69
	.4byte	.LFE69-.LFB69
	.4byte	.LFB70
	.4byte	.LFE70-.LFB70
	.4byte	.LFB71
	.4byte	.LFE71-.LFB71
	.4byte	.LFB72
	.4byte	.LFE72-.LFB72
	.4byte	.LFB73
	.4byte	.LFE73-.LFB73
	.4byte	.LFB74
	.4byte	.LFE74-.LFB74
	.4byte	.LFB75
	.4byte	.LFE75-.LFB75
	.4byte	.LFB76
	.4byte	.LFE76-.LFB76
	.4byte	.LFB77
	.4byte	.LFE77-.LFB77
	.4byte	.LFB78
	.4byte	.LFE78-.LFB78
	.4byte	.LFB79
	.4byte	.LFE79-.LFB79
	.4byte	.LFB80
	.4byte	.LFE80-.LFB80
	.4byte	.LFB81
	.4byte	.LFE81-.LFB81
	.4byte	.LFB82
	.4byte	.LFE82-.LFB82
	.4byte	.LFB83
	.4byte	.LFE83-.LFB83
	.4byte	.LFB84
	.4byte	.LFE84-.LFB84
	.4byte	.LFB85
	.4byte	.LFE85-.LFB85
	.4byte	.LFB86
	.4byte	.LFE86-.LFB86
	.4byte	.LFB87
	.4byte	.LFE87-.LFB87
	.4byte	.LFB88
	.4byte	.LFE88-.LFB88
	.4byte	.LFB89
	.4byte	.LFE89-.LFB89
	.4byte	.LFB90
	.4byte	.LFE90-.LFB90
	.4byte	.LFB91
	.4byte	.LFE91-.LFB91
	.4byte	.LFB92
	.4byte	.LFE92-.LFB92
	.4byte	.LFB93
	.4byte	.LFE93-.LFB93
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",%progbits
.Ldebug_ranges0:
	.4byte	.LFB0
	.4byte	.LFE0
	.4byte	.LFB1
	.4byte	.LFE1
	.4byte	.LFB2
	.4byte	.LFE2
	.4byte	.LFB3
	.4byte	.LFE3
	.4byte	.LFB4
	.4byte	.LFE4
	.4byte	.LFB5
	.4byte	.LFE5
	.4byte	.LFB6
	.4byte	.LFE6
	.4byte	.LFB7
	.4byte	.LFE7
	.4byte	.LFB8
	.4byte	.LFE8
	.4byte	.LFB9
	.4byte	.LFE9
	.4byte	.LFB10
	.4byte	.LFE10
	.4byte	.LFB11
	.4byte	.LFE11
	.4byte	.LFB12
	.4byte	.LFE12
	.4byte	.LFB13
	.4byte	.LFE13
	.4byte	.LFB14
	.4byte	.LFE14
	.4byte	.LFB15
	.4byte	.LFE15
	.4byte	.LFB16
	.4byte	.LFE16
	.4byte	.LFB17
	.4byte	.LFE17
	.4byte	.LFB18
	.4byte	.LFE18
	.4byte	.LFB19
	.4byte	.LFE19
	.4byte	.LFB20
	.4byte	.LFE20
	.4byte	.LFB21
	.4byte	.LFE21
	.4byte	.LFB22
	.4byte	.LFE22
	.4byte	.LFB23
	.4byte	.LFE23
	.4byte	.LFB24
	.4byte	.LFE24
	.4byte	.LFB25
	.4byte	.LFE25
	.4byte	.LFB26
	.4byte	.LFE26
	.4byte	.LFB27
	.4byte	.LFE27
	.4byte	.LFB28
	.4byte	.LFE28
	.4byte	.LFB29
	.4byte	.LFE29
	.4byte	.LFB30
	.4byte	.LFE30
	.4byte	.LFB31
	.4byte	.LFE31
	.4byte	.LFB32
	.4byte	.LFE32
	.4byte	.LFB33
	.4byte	.LFE33
	.4byte	.LFB34
	.4byte	.LFE34
	.4byte	.LFB35
	.4byte	.LFE35
	.4byte	.LFB36
	.4byte	.LFE36
	.4byte	.LFB37
	.4byte	.LFE37
	.4byte	.LFB38
	.4byte	.LFE38
	.4byte	.LFB39
	.4byte	.LFE39
	.4byte	.LFB40
	.4byte	.LFE40
	.4byte	.LFB41
	.4byte	.LFE41
	.4byte	.LFB42
	.4byte	.LFE42
	.4byte	.LFB43
	.4byte	.LFE43
	.4byte	.LFB44
	.4byte	.LFE44
	.4byte	.LFB45
	.4byte	.LFE45
	.4byte	.LFB46
	.4byte	.LFE46
	.4byte	.LFB47
	.4byte	.LFE47
	.4byte	.LFB48
	.4byte	.LFE48
	.4byte	.LFB49
	.4byte	.LFE49
	.4byte	.LFB50
	.4byte	.LFE50
	.4byte	.LFB51
	.4byte	.LFE51
	.4byte	.LFB52
	.4byte	.LFE52
	.4byte	.LFB53
	.4byte	.LFE53
	.4byte	.LFB54
	.4byte	.LFE54
	.4byte	.LFB55
	.4byte	.LFE55
	.4byte	.LFB56
	.4byte	.LFE56
	.4byte	.LFB57
	.4byte	.LFE57
	.4byte	.LFB58
	.4byte	.LFE58
	.4byte	.LFB59
	.4byte	.LFE59
	.4byte	.LFB60
	.4byte	.LFE60
	.4byte	.LFB61
	.4byte	.LFE61
	.4byte	.LFB62
	.4byte	.LFE62
	.4byte	.LFB63
	.4byte	.LFE63
	.4byte	.LFB64
	.4byte	.LFE64
	.4byte	.LFB65
	.4byte	.LFE65
	.4byte	.LFB66
	.4byte	.LFE66
	.4byte	.LFB67
	.4byte	.LFE67
	.4byte	.LFB68
	.4byte	.LFE68
	.4byte	.LFB69
	.4byte	.LFE69
	.4byte	.LFB70
	.4byte	.LFE70
	.4byte	.LFB71
	.4byte	.LFE71
	.4byte	.LFB72
	.4byte	.LFE72
	.4byte	.LFB73
	.4byte	.LFE73
	.4byte	.LFB74
	.4byte	.LFE74
	.4byte	.LFB75
	.4byte	.LFE75
	.4byte	.LFB76
	.4byte	.LFE76
	.4byte	.LFB77
	.4byte	.LFE77
	.4byte	.LFB78
	.4byte	.LFE78
	.4byte	.LFB79
	.4byte	.LFE79
	.4byte	.LFB80
	.4byte	.LFE80
	.4byte	.LFB81
	.4byte	.LFE81
	.4byte	.LFB82
	.4byte	.LFE82
	.4byte	.LFB83
	.4byte	.LFE83
	.4byte	.LFB84
	.4byte	.LFE84
	.4byte	.LFB85
	.4byte	.LFE85
	.4byte	.LFB86
	.4byte	.LFE86
	.4byte	.LFB87
	.4byte	.LFE87
	.4byte	.LFB88
	.4byte	.LFE88
	.4byte	.LFB89
	.4byte	.LFE89
	.4byte	.LFB90
	.4byte	.LFE90
	.4byte	.LFB91
	.4byte	.LFE91
	.4byte	.LFB92
	.4byte	.LFE92
	.4byte	.LFB93
	.4byte	.LFE93
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF236:
	.ascii	"starttime\000"
.LASF113:
	.ascii	"rxCode\000"
.LASF138:
	.ascii	"partID\000"
.LASF283:
	.ascii	"dwt_seteui\000"
.LASF314:
	.ascii	"dwt_readdiagnostics\000"
.LASF313:
	.ascii	"dwt_readtxtimestamp\000"
.LASF284:
	.ascii	"dwt_setaddress16\000"
.LASF238:
	.ascii	"_dwt_enableclocks\000"
.LASF175:
	.ascii	"mixer_gain_change\000"
.LASF248:
	.ascii	"dwt_setdblrxbuffmode\000"
.LASF285:
	.ascii	"shortAddress\000"
.LASF294:
	.ascii	"buffer\000"
.LASF118:
	.ascii	"dwt_config_t\000"
.LASF239:
	.ascii	"clocks\000"
.LASF181:
	.ascii	"dwt_calcbandwidthtempadj\000"
.LASF4:
	.ascii	"unsigned int\000"
.LASF76:
	.ascii	"next\000"
.LASF157:
	.ascii	"sum_count\000"
.LASF322:
	.ascii	"txFrameLength\000"
.LASF208:
	.ascii	"dwt_configeventcounters\000"
.LASF60:
	.ascii	"__RAL_c_locale_day_names\000"
.LASF274:
	.ascii	"rd_buf\000"
.LASF32:
	.ascii	"abbrev_month_names\000"
.LASF169:
	.ascii	"ref_temp\000"
.LASF305:
	.ascii	"dwt_readsystime\000"
.LASF35:
	.ascii	"time_format\000"
.LASF42:
	.ascii	"__towupper\000"
.LASF301:
	.ascii	"recordNumber\000"
.LASF310:
	.ascii	"dwt_readrxtimestamp\000"
.LASF327:
	.ascii	"txFrameBytes\000"
.LASF105:
	.ascii	"fctrl\000"
.LASF171:
	.ascii	"delta_power\000"
.LASF85:
	.ascii	"short int\000"
.LASF10:
	.ascii	"mon_decimal_point\000"
.LASF354:
	.ascii	"dwt_setlocaldataptr\000"
.LASF278:
	.ascii	"ret_data\000"
.LASF189:
	.ascii	"dwt_readwakeupvbat\000"
.LASF329:
	.ascii	"txDelay\000"
.LASF197:
	.ascii	"dwt_configcontinuousframemode\000"
.LASF192:
	.ascii	"fastSPI\000"
.LASF187:
	.ascii	"raw_count\000"
.LASF63:
	.ascii	"__RAL_c_locale_abbrev_month_names\000"
.LASF353:
	.ascii	"rega\000"
.LASF179:
	.ascii	"new_mixer_gain\000"
.LASF227:
	.ascii	"timeOff\000"
.LASF5:
	.ascii	"decimal_point\000"
.LASF154:
	.ascii	"dw1000local\000"
.LASF173:
	.ascii	"power_adj\000"
.LASF198:
	.ascii	"dwt_configcwmode\000"
.LASF20:
	.ascii	"n_sep_by_space\000"
.LASF145:
	.ascii	"sysCFGreg\000"
.LASF223:
	.ascii	"dwt_setlowpowerlistening\000"
.LASF80:
	.ascii	"uint8\000"
.LASF54:
	.ascii	"__category\000"
.LASF275:
	.ascii	"otp_done\000"
.LASF101:
	.ascii	"txpwr_compensation\000"
.LASF121:
	.ascii	"dwt_txconfig_t\000"
.LASF41:
	.ascii	"__iswctype\000"
.LASF18:
	.ascii	"p_sep_by_space\000"
.LASF132:
	.ascii	"CRCB\000"
.LASF165:
	.ascii	"pgdly\000"
.LASF46:
	.ascii	"__RAL_locale_data_t\000"
.LASF131:
	.ascii	"CRCG\000"
.LASF352:
	.ascii	"ldo_tune\000"
.LASF108:
	.ascii	"dwt_cb_t\000"
.LASF188:
	.ascii	"delta_lowest\000"
.LASF86:
	.ascii	"int32\000"
.LASF159:
	.ascii	"count\000"
.LASF302:
	.ascii	"index\000"
.LASF116:
	.ascii	"phrMode\000"
.LASF68:
	.ascii	"__RAL_data_utf8_minus\000"
.LASF257:
	.ascii	"dwt_spicswakeup\000"
.LASF263:
	.ascii	"result\000"
.LASF65:
	.ascii	"__RAL_data_utf8_comma\000"
.LASF104:
	.ascii	"datalength\000"
.LASF196:
	.ascii	"framerepetitionrate\000"
.LASF133:
	.ascii	"ARFE\000"
.LASF289:
	.ascii	"sysconfig\000"
.LASF286:
	.ascii	"dwt_setpanid\000"
.LASF167:
	.ascii	"ref_powerreg\000"
.LASF253:
	.ascii	"ops_sel\000"
.LASF70:
	.ascii	"__user_set_time_of_day\000"
.LASF28:
	.ascii	"int_n_sign_posn\000"
.LASF78:
	.ascii	"__RAL_error_decoder_head\000"
.LASF203:
	.ascii	"dwt_softreset\000"
.LASF91:
	.ascii	"sftsh\000"
.LASF297:
	.ascii	"dwt_read8bitoffsetreg\000"
.LASF290:
	.ascii	"dwt_write32bitoffsetreg\000"
.LASF211:
	.ascii	"bitmask\000"
.LASF112:
	.ascii	"txCode\000"
.LASF315:
	.ascii	"diagnostics\000"
.LASF217:
	.ascii	"time\000"
.LASF209:
	.ascii	"enable\000"
.LASF201:
	.ascii	"value\000"
.LASF193:
	.ascii	"wr_buf\000"
.LASF258:
	.ascii	"length\000"
.LASF212:
	.ascii	"stat\000"
.LASF87:
	.ascii	"lo32\000"
.LASF269:
	.ascii	"dwt_otpwriteandverify\000"
.LASF241:
	.ascii	"dwt_lowpowerlistenisr\000"
.LASF358:
	.ascii	"timeval\000"
.LASF1:
	.ascii	"__wchar\000"
.LASF292:
	.ascii	"regOffset\000"
.LASF230:
	.ascii	"buff\000"
.LASF143:
	.ascii	"init_xtrim\000"
.LASF21:
	.ascii	"p_sign_posn\000"
.LASF250:
	.ascii	"responseDelayTime\000"
.LASF220:
	.ascii	"temp1\000"
.LASF357:
	.ascii	"C:\\Users\\ali\\Desktop\\Ali_Safaei\\5_GeoLocation_"
	.ascii	"UWB\\UWB_sensors\\DWM1001\\Source_Code\\dwm1001_exm"
	.ascii	"\\examples\\ds_twr_resp_Ali\\SES\000"
.LASF186:
	.ascii	"best_bw\000"
.LASF299:
	.ascii	"dwt_read32bitoffsetreg\000"
.LASF88:
	.ascii	"target\000"
.LASF23:
	.ascii	"int_p_cs_precedes\000"
.LASF128:
	.ascii	"rxPreamCount\000"
.LASF195:
	.ascii	"temp_raw\000"
.LASF100:
	.ascii	"double\000"
.LASF172:
	.ascii	"_dwt_computetxpowersetting\000"
.LASF242:
	.ascii	"finfo16\000"
.LASF337:
	.ascii	"dwt_configuretxrf\000"
.LASF350:
	.ascii	"dwt_initialise\000"
.LASF308:
	.ascii	"dwt_readrxtimestamplo32\000"
.LASF264:
	.ascii	"dwt_configuresleepcnt\000"
.LASF136:
	.ascii	"dwt_deviceentcnts_t\000"
.LASF251:
	.ascii	"dwt_setsmarttxpower\000"
.LASF221:
	.ascii	"dwt_setsnoozetime\000"
.LASF255:
	.ascii	"_dwt_configlde\000"
.LASF202:
	.ascii	"reg_val\000"
.LASF15:
	.ascii	"int_frac_digits\000"
.LASF252:
	.ascii	"dwt_loadopsettabfromotp\000"
.LASF206:
	.ascii	"counters\000"
.LASF287:
	.ascii	"panID\000"
.LASF24:
	.ascii	"int_n_cs_precedes\000"
.LASF317:
	.ascii	"dwt_readaccdata\000"
.LASF246:
	.ascii	"dwt_setrxaftertxdelay\000"
.LASF14:
	.ascii	"negative_sign\000"
.LASF262:
	.ascii	"dwt_calibratesleepcnt\000"
.LASF267:
	.ascii	"_dwt_aonarrayupload\000"
.LASF178:
	.ascii	"new_da_attn\000"
.LASF235:
	.ascii	"dwt_setdelayedtrxtime\000"
.LASF7:
	.ascii	"grouping\000"
.LASF268:
	.ascii	"_dwt_aonconfigupload\000"
.LASF226:
	.ascii	"timeOn\000"
.LASF111:
	.ascii	"rxPAC\000"
.LASF339:
	.ascii	"dwt_getlotid\000"
.LASF109:
	.ascii	"chan\000"
.LASF321:
	.ascii	"dwt_writetxfctrl\000"
.LASF3:
	.ascii	"char\000"
.LASF106:
	.ascii	"rx_flags\000"
.LASF95:
	.ascii	"rx_config\000"
.LASF51:
	.ascii	"__RAL_locale_t\000"
.LASF225:
	.ascii	"dwt_setsniffmode\000"
.LASF69:
	.ascii	"__RAL_data_empty_string\000"
.LASF200:
	.ascii	"dwt_setxtaltrim\000"
.LASF304:
	.ascii	"dwt_writetodevice\000"
.LASF356:
	.ascii	"C:\\Users\\ali\\Desktop\\Ali_Safaei\\5_GeoLocation_"
	.ascii	"UWB\\UWB_sensors\\DWM1001\\Source_Code\\dwm1001_exm"
	.ascii	"\\deca_driver\\deca_device.c\000"
.LASF43:
	.ascii	"__towlower\000"
.LASF81:
	.ascii	"uint16\000"
.LASF49:
	.ascii	"data\000"
.LASF351:
	.ascii	"otp_addr\000"
.LASF92:
	.ascii	"dtune1\000"
.LASF161:
	.ascii	"old_pmsc_ctrl1\000"
.LASF185:
	.ascii	"delta_count\000"
.LASF103:
	.ascii	"status\000"
.LASF94:
	.ascii	"fs_pll_tune\000"
.LASF218:
	.ascii	"dwt_rxenable\000"
.LASF150:
	.ascii	"cbRxOk\000"
.LASF340:
	.ascii	"dwt_getpartid\000"
.LASF233:
	.ascii	"retval\000"
.LASF160:
	.ascii	"old_pmsc_ctrl0\000"
.LASF347:
	.ascii	"gpio_mode\000"
.LASF163:
	.ascii	"dwt_calcpgcount\000"
.LASF228:
	.ascii	"sniff_reg\000"
.LASF282:
	.ascii	"eui64\000"
.LASF79:
	.ascii	"long long int\000"
.LASF237:
	.ascii	"_dwt_disablesequencing\000"
.LASF164:
	.ascii	"dwt_calcpowertempadj\000"
.LASF33:
	.ascii	"am_pm_indicator\000"
.LASF336:
	.ascii	"reg16\000"
.LASF234:
	.ascii	"checkTxOK\000"
.LASF231:
	.ascii	"dwt_forcetrxoff\000"
.LASF270:
	.ascii	"address\000"
.LASF12:
	.ascii	"mon_grouping\000"
.LASF265:
	.ascii	"sleepcnt\000"
.LASF273:
	.ascii	"_dwt_otpprogword32\000"
.LASF312:
	.ascii	"dwt_readtxtimestamphi32\000"
.LASF318:
	.ascii	"accOffset\000"
.LASF219:
	.ascii	"mode\000"
.LASF216:
	.ascii	"dwt_setrxtimeout\000"
.LASF232:
	.ascii	"dwt_starttx\000"
.LASF114:
	.ascii	"nsSFD\000"
.LASF30:
	.ascii	"abbrev_day_names\000"
.LASF129:
	.ascii	"firstPath\000"
.LASF259:
	.ascii	"dwt_entersleepaftertx\000"
.LASF147:
	.ascii	"wait4resp\000"
.LASF245:
	.ascii	"dwt_setcallbacks\000"
.LASF124:
	.ascii	"stdNoise\000"
.LASF331:
	.ascii	"rxDelay\000"
.LASF73:
	.ascii	"__RAL_error_decoder_fn_t\000"
.LASF134:
	.ascii	"OVER\000"
.LASF266:
	.ascii	"dwt_entersleep\000"
.LASF29:
	.ascii	"day_names\000"
.LASF213:
	.ascii	"mask\000"
.LASF303:
	.ascii	"header\000"
.LASF341:
	.ascii	"dwt_setgpiovalue\000"
.LASF277:
	.ascii	"_dwt_otpread\000"
.LASF319:
	.ascii	"dwt_readrxdata\000"
.LASF316:
	.ascii	"dwt_readcarrierintegrator\000"
.LASF183:
	.ascii	"bit_field\000"
.LASF332:
	.ascii	"dwt_configure\000"
.LASF59:
	.ascii	"__RAL_ascii_ctype_map\000"
.LASF204:
	.ascii	"dwt_rxreset\000"
.LASF36:
	.ascii	"date_time_format\000"
.LASF158:
	.ascii	"average_count\000"
.LASF45:
	.ascii	"__mbtowc\000"
.LASF280:
	.ascii	"array\000"
.LASF52:
	.ascii	"__mbstate_s\000"
.LASF152:
	.ascii	"cbRxErr\000"
.LASF57:
	.ascii	"__RAL_codeset_ascii\000"
.LASF325:
	.ascii	"reg32\000"
.LASF149:
	.ascii	"cbTxDone\000"
.LASF288:
	.ascii	"dwt_enableframefilter\000"
.LASF166:
	.ascii	"channel\000"
.LASF137:
	.ascii	"decaIrqStatus_t\000"
.LASF323:
	.ascii	"txBufferOffset\000"
.LASF47:
	.ascii	"__RAL_locale_codeset_t\000"
.LASF50:
	.ascii	"codeset\000"
.LASF309:
	.ascii	"dwt_readrxtimestamphi32\000"
.LASF333:
	.ascii	"config\000"
.LASF205:
	.ascii	"dwt_readeventcounters\000"
.LASF39:
	.ascii	"__toupper\000"
.LASF168:
	.ascii	"curr_temp\000"
.LASF55:
	.ascii	"__RAL_global_locale\000"
.LASF344:
	.ascii	"dwt_setgpiodirection\000"
.LASF75:
	.ascii	"decode\000"
.LASF44:
	.ascii	"__wctomb\000"
.LASF8:
	.ascii	"int_curr_symbol\000"
.LASF2:
	.ascii	"long int\000"
.LASF281:
	.ascii	"dwt_geteui\000"
.LASF16:
	.ascii	"frac_digits\000"
.LASF115:
	.ascii	"dataRate\000"
.LASF148:
	.ascii	"cbData\000"
.LASF74:
	.ascii	"__RAL_error_decoder_s\000"
.LASF123:
	.ascii	"firstPathAmp1\000"
.LASF125:
	.ascii	"firstPathAmp2\000"
.LASF126:
	.ascii	"firstPathAmp3\000"
.LASF140:
	.ascii	"longFrames\000"
.LASF22:
	.ascii	"n_sign_posn\000"
.LASF207:
	.ascii	"temp\000"
.LASF261:
	.ascii	"wake\000"
.LASF300:
	.ascii	"dwt_readfromdevice\000"
.LASF345:
	.ascii	"direction\000"
.LASF170:
	.ascii	"delta_temp\000"
.LASF229:
	.ascii	"dwt_syncrxbufptrs\000"
.LASF26:
	.ascii	"int_n_sep_by_space\000"
.LASF271:
	.ascii	"prog_ok\000"
.LASF320:
	.ascii	"rxBufferOffset\000"
.LASF82:
	.ascii	"uint32\000"
.LASF127:
	.ascii	"maxGrowthCIR\000"
.LASF58:
	.ascii	"__RAL_codeset_utf8\000"
.LASF146:
	.ascii	"sleep_mode\000"
.LASF224:
	.ascii	"pmsc_reg\000"
.LASF144:
	.ascii	"dblbuffon\000"
.LASF298:
	.ascii	"dwt_read16bitoffsetreg\000"
.LASF107:
	.ascii	"dwt_cb_data_t\000"
.LASF13:
	.ascii	"positive_sign\000"
.LASF25:
	.ascii	"int_p_sep_by_space\000"
.LASF194:
	.ascii	"vbat_raw\000"
.LASF48:
	.ascii	"name\000"
.LASF64:
	.ascii	"__RAL_data_utf8_period\000"
.LASF184:
	.ascii	"curr_bw\000"
.LASF214:
	.ascii	"dwt_setpreambledetecttimeout\000"
.LASF247:
	.ascii	"rxDelayTime\000"
.LASF191:
	.ascii	"dwt_readtempvbat\000"
.LASF324:
	.ascii	"ranging\000"
.LASF293:
	.ascii	"regval\000"
.LASF177:
	.ascii	"current_mixer_gain\000"
.LASF162:
	.ascii	"old_rf_conf_txpow_mask\000"
.LASF153:
	.ascii	"dwt_local_data_t\000"
.LASF110:
	.ascii	"txPreambLength\000"
.LASF279:
	.ascii	"dwt_otpread\000"
.LASF83:
	.ascii	"long unsigned int\000"
.LASF61:
	.ascii	"__RAL_c_locale_abbrev_day_names\000"
.LASF176:
	.ascii	"current_da_attn\000"
.LASF182:
	.ascii	"target_count\000"
.LASF156:
	.ascii	"NUM_SAMPLES\000"
.LASF296:
	.ascii	"dwt_write8bitoffsetreg\000"
.LASF151:
	.ascii	"cbRxTo\000"
.LASF272:
	.ascii	"retry\000"
.LASF11:
	.ascii	"mon_thousands_sep\000"
.LASF260:
	.ascii	"dwt_configuresleep\000"
.LASF141:
	.ascii	"otprev\000"
.LASF97:
	.ascii	"dwnsSFDlen\000"
.LASF66:
	.ascii	"__RAL_data_utf8_space\000"
.LASF130:
	.ascii	"dwt_rxdiag_t\000"
.LASF37:
	.ascii	"unsigned char\000"
.LASF142:
	.ascii	"txFCTRL\000"
.LASF155:
	.ascii	"pdw1000local\000"
.LASF342:
	.ascii	"gpioNum\000"
.LASF56:
	.ascii	"__RAL_c_locale\000"
.LASF249:
	.ascii	"dwt_enableautoack\000"
.LASF62:
	.ascii	"__RAL_c_locale_month_names\000"
.LASF222:
	.ascii	"snooze_time\000"
.LASF215:
	.ascii	"timeout\000"
.LASF6:
	.ascii	"thousands_sep\000"
.LASF90:
	.ascii	"agc_config\000"
.LASF291:
	.ascii	"regFileID\000"
.LASF240:
	.ascii	"dwt_setleds\000"
.LASF334:
	.ascii	"nsSfd_result\000"
.LASF326:
	.ascii	"dwt_writetxdata\000"
.LASF117:
	.ascii	"sfdTO\000"
.LASF338:
	.ascii	"dwt_readdevid\000"
.LASF256:
	.ascii	"prfIndex\000"
.LASF98:
	.ascii	"digital_bb_config\000"
.LASF38:
	.ascii	"__isctype\000"
.LASF174:
	.ascii	"da_attn_change\000"
.LASF9:
	.ascii	"currency_symbol\000"
.LASF343:
	.ascii	"command\000"
.LASF89:
	.ascii	"agc_cfg_struct\000"
.LASF306:
	.ascii	"timestamp\000"
.LASF120:
	.ascii	"power\000"
.LASF210:
	.ascii	"dwt_setinterrupt\000"
.LASF119:
	.ascii	"PGdly\000"
.LASF84:
	.ascii	"signed char\000"
.LASF67:
	.ascii	"__RAL_data_utf8_plus\000"
.LASF199:
	.ascii	"dwt_getinitxtaltrim\000"
.LASF72:
	.ascii	"short unsigned int\000"
.LASF295:
	.ascii	"dwt_write16bitoffsetreg\000"
.LASF348:
	.ascii	"dwt_setfinegraintxseq\000"
.LASF243:
	.ascii	"dwt_isr\000"
.LASF244:
	.ascii	"dwt_checkirq\000"
.LASF19:
	.ascii	"n_cs_precedes\000"
.LASF311:
	.ascii	"dwt_readtxtimestamplo32\000"
.LASF349:
	.ascii	"dwt_otprevision\000"
.LASF122:
	.ascii	"maxNoise\000"
.LASF71:
	.ascii	"__user_get_time_of_day\000"
.LASF99:
	.ascii	"chan_idx\000"
.LASF276:
	.ascii	"_dwt_otpsetmrregs\000"
.LASF335:
	.ascii	"useDWnsSFD\000"
.LASF180:
	.ascii	"new_regval\000"
.LASF190:
	.ascii	"dwt_readwakeuptemp\000"
.LASF93:
	.ascii	"fs_pll_cfg\000"
.LASF0:
	.ascii	"__state\000"
.LASF355:
	.ascii	"GNU C99 8.2.1 20181213 (release) [gcc-8-branch revi"
	.ascii	"sion 267074] -fmessage-length=0 -mcpu=cortex-m4 -ml"
	.ascii	"ittle-endian -mfloat-abi=hard -mfpu=fpv4-sp-d16 -mt"
	.ascii	"humb -mtp=soft -munaligned-access -std=gnu99 -g2 -g"
	.ascii	"pubnames -fomit-frame-pointer -fno-dwarf2-cfi-asm -"
	.ascii	"fno-builtin -ffunction-sections -fdata-sections -fs"
	.ascii	"hort-enums -fno-common\000"
.LASF330:
	.ascii	"dwt_setrxantennadelay\000"
.LASF34:
	.ascii	"date_format\000"
.LASF135:
	.ascii	"SFDTO\000"
.LASF53:
	.ascii	"__locale_s\000"
.LASF27:
	.ascii	"int_p_sign_posn\000"
.LASF254:
	.ascii	"_dwt_loaducodefromrom\000"
.LASF307:
	.ascii	"dwt_readsystimestamphi32\000"
.LASF31:
	.ascii	"month_names\000"
.LASF17:
	.ascii	"p_cs_precedes\000"
.LASF77:
	.ascii	"__RAL_error_decoder_t\000"
.LASF96:
	.ascii	"tx_config\000"
.LASF102:
	.ascii	"lde_replicaCoeff\000"
.LASF139:
	.ascii	"lotID\000"
.LASF346:
	.ascii	"dwt_setlnapamode\000"
.LASF40:
	.ascii	"__tolower\000"
.LASF328:
	.ascii	"dwt_settxantennadelay\000"
	.ident	"GCC: (GNU) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]"

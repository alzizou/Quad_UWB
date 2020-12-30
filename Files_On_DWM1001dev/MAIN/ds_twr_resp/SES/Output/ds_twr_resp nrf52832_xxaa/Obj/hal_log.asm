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
	.file	"hal_log.c"
	.text
.Ltext0:
	.section	.data.log_file_name,"aw"
	.align	2
	.type	log_file_name, %object
	.size	log_file_name, 8
log_file_name:
	.ascii	"log.txt\000"
	.section	.bss.fp,"aw",%nobits
	.align	2
	.type	fp, %object
	.size	fp, 4
fp:
	.space	4
	.section .rodata
	.align	2
.LC0:
	.ascii	"w\000"
	.section	.text.HAL_Log_GetFile,"ax",%progbits
	.align	1
	.global	HAL_Log_GetFile
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	HAL_Log_GetFile, %function
HAL_Log_GetFile:
.LFB0:
	.file 1 "C:\\Users\\ali\\Desktop\\Ali_Safaei\\5_GeoLocation_UWB\\UWB_sensors\\DWM1001\\Source_Code\\dwm1001_exm\\nRF5_SDK_14.2.0\\components\\libraries\\hal\\hal_log.c"
	.loc 1 28 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI0:
	.loc 1 29 10
	ldr	r3, .L4
	ldr	r3, [r3]
	.loc 1 29 6
	cmp	r3, #0
	beq	.L2
	.loc 1 31 14
	ldr	r3, .L4
	ldr	r3, [r3]
	b	.L3
.L2:
	.loc 1 33 9
	ldr	r1, .L4+4
	ldr	r0, .L4+8
	bl	fopen
	mov	r2, r0
	.loc 1 33 7
	ldr	r3, .L4
	str	r2, [r3]
	.loc 1 35 11
	ldr	r3, .L4
	ldr	r3, [r3]
.L3:
	.loc 1 36 1
	mov	r0, r3
	pop	{r3, pc}
.L5:
	.align	2
.L4:
	.word	fp
	.word	.LC0
	.word	log_file_name
.LFE0:
	.size	HAL_Log_GetFile, .-HAL_Log_GetFile
	.section	.text.HAL_Log_DeInit,"ax",%progbits
	.align	1
	.global	HAL_Log_DeInit
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	HAL_Log_DeInit, %function
HAL_Log_DeInit:
.LFB1:
	.loc 1 46 1
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, lr}
.LCFI1:
	.loc 1 47 10
	ldr	r3, .L9
	ldr	r3, [r3]
	.loc 1 47 6
	cmp	r3, #0
	beq	.L8
	.loc 1 49 7
	ldr	r3, .L9
	ldr	r3, [r3]
	mov	r0, r3
	bl	fclose
	.loc 1 50 10
	ldr	r3, .L9
	movs	r2, #0
	str	r2, [r3]
.L8:
	.loc 1 52 1
	nop
	pop	{r3, pc}
.L10:
	.align	2
.L9:
	.word	fp
.LFE1:
	.size	HAL_Log_DeInit, .-HAL_Log_DeInit
	.section	.text.HAL_Log,"ax",%progbits
	.align	1
	.global	HAL_Log
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	HAL_Log, %function
HAL_Log:
.LFB2:
	.loc 1 62 1
	@ args = 4, pretend = 16, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 1
	@ link register save eliminated.
	push	{r0, r1, r2, r3}
.LCFI2:
	.loc 1 70 1
	nop
	add	sp, sp, #16
.LCFI3:
	bx	lr
.LFE2:
	.size	HAL_Log, .-HAL_Log
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
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE0:
.LSFDE2:
	.4byte	.LEFDE2-.LASFDE2
.LASFDE2:
	.4byte	.Lframe0
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x4
	.4byte	.LCFI1-.LFB1
	.byte	0xe
	.uleb128 0x8
	.byte	0x83
	.uleb128 0x2
	.byte	0x8e
	.uleb128 0x1
	.align	2
.LEFDE2:
.LSFDE4:
	.4byte	.LEFDE4-.LASFDE4
.LASFDE4:
	.4byte	.Lframe0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.byte	0x4
	.4byte	.LCFI2-.LFB2
	.byte	0xe
	.uleb128 0x10
	.byte	0x80
	.uleb128 0x4
	.byte	0x81
	.uleb128 0x3
	.byte	0x82
	.uleb128 0x2
	.byte	0x83
	.uleb128 0x1
	.byte	0x4
	.4byte	.LCFI3-.LCFI2
	.byte	0xc3
	.byte	0xc2
	.byte	0xc1
	.byte	0xc0
	.byte	0xe
	.uleb128 0
	.align	2
.LEFDE4:
	.text
.Letext0:
	.file 2 "C:/Program Files/SEGGER/SEGGER Embedded Studio for ARM 4.18/include/__crossworks.h"
	.file 3 "C:/Program Files/SEGGER/SEGGER Embedded Studio for ARM 4.18/include/stdio.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x671
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF87
	.byte	0xc
	.4byte	.LASF88
	.4byte	.LASF89
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
	.4byte	0x54
	.byte	0x4
	.byte	0
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.4byte	.LASF2
	.uleb128 0x6
	.4byte	0x4d
	.4byte	0x74
	.uleb128 0x7
	.4byte	0x74
	.uleb128 0x7
	.4byte	0x86
	.uleb128 0x7
	.4byte	0x8d
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.4byte	0x7a
	.uleb128 0x5
	.byte	0x1
	.byte	0x8
	.4byte	.LASF3
	.uleb128 0x9
	.4byte	0x7a
	.uleb128 0x5
	.byte	0x4
	.byte	0x7
	.4byte	.LASF4
	.uleb128 0x8
	.byte	0x4
	.4byte	0x25
	.uleb128 0x6
	.4byte	0x4d
	.4byte	0xb1
	.uleb128 0x7
	.4byte	0xb1
	.uleb128 0x7
	.4byte	0xb7
	.uleb128 0x7
	.4byte	0x86
	.uleb128 0x7
	.4byte	0x8d
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.4byte	0x86
	.uleb128 0x8
	.byte	0x4
	.4byte	0x81
	.uleb128 0xa
	.byte	0x58
	.byte	0x2
	.byte	0x86
	.byte	0x9
	.4byte	0x267
	.uleb128 0x3
	.4byte	.LASF5
	.byte	0x2
	.byte	0x88
	.byte	0xf
	.4byte	0xb7
	.byte	0
	.uleb128 0x3
	.4byte	.LASF6
	.byte	0x2
	.byte	0x89
	.byte	0xf
	.4byte	0xb7
	.byte	0x4
	.uleb128 0x3
	.4byte	.LASF7
	.byte	0x2
	.byte	0x8a
	.byte	0xf
	.4byte	0xb7
	.byte	0x8
	.uleb128 0x3
	.4byte	.LASF8
	.byte	0x2
	.byte	0x8c
	.byte	0xf
	.4byte	0xb7
	.byte	0xc
	.uleb128 0x3
	.4byte	.LASF9
	.byte	0x2
	.byte	0x8d
	.byte	0xf
	.4byte	0xb7
	.byte	0x10
	.uleb128 0x3
	.4byte	.LASF10
	.byte	0x2
	.byte	0x8e
	.byte	0xf
	.4byte	0xb7
	.byte	0x14
	.uleb128 0x3
	.4byte	.LASF11
	.byte	0x2
	.byte	0x8f
	.byte	0xf
	.4byte	0xb7
	.byte	0x18
	.uleb128 0x3
	.4byte	.LASF12
	.byte	0x2
	.byte	0x90
	.byte	0xf
	.4byte	0xb7
	.byte	0x1c
	.uleb128 0x3
	.4byte	.LASF13
	.byte	0x2
	.byte	0x91
	.byte	0xf
	.4byte	0xb7
	.byte	0x20
	.uleb128 0x3
	.4byte	.LASF14
	.byte	0x2
	.byte	0x92
	.byte	0xf
	.4byte	0xb7
	.byte	0x24
	.uleb128 0x3
	.4byte	.LASF15
	.byte	0x2
	.byte	0x94
	.byte	0x8
	.4byte	0x7a
	.byte	0x28
	.uleb128 0x3
	.4byte	.LASF16
	.byte	0x2
	.byte	0x95
	.byte	0x8
	.4byte	0x7a
	.byte	0x29
	.uleb128 0x3
	.4byte	.LASF17
	.byte	0x2
	.byte	0x96
	.byte	0x8
	.4byte	0x7a
	.byte	0x2a
	.uleb128 0x3
	.4byte	.LASF18
	.byte	0x2
	.byte	0x97
	.byte	0x8
	.4byte	0x7a
	.byte	0x2b
	.uleb128 0x3
	.4byte	.LASF19
	.byte	0x2
	.byte	0x98
	.byte	0x8
	.4byte	0x7a
	.byte	0x2c
	.uleb128 0x3
	.4byte	.LASF20
	.byte	0x2
	.byte	0x99
	.byte	0x8
	.4byte	0x7a
	.byte	0x2d
	.uleb128 0x3
	.4byte	.LASF21
	.byte	0x2
	.byte	0x9a
	.byte	0x8
	.4byte	0x7a
	.byte	0x2e
	.uleb128 0x3
	.4byte	.LASF22
	.byte	0x2
	.byte	0x9b
	.byte	0x8
	.4byte	0x7a
	.byte	0x2f
	.uleb128 0x3
	.4byte	.LASF23
	.byte	0x2
	.byte	0x9c
	.byte	0x8
	.4byte	0x7a
	.byte	0x30
	.uleb128 0x3
	.4byte	.LASF24
	.byte	0x2
	.byte	0x9d
	.byte	0x8
	.4byte	0x7a
	.byte	0x31
	.uleb128 0x3
	.4byte	.LASF25
	.byte	0x2
	.byte	0x9e
	.byte	0x8
	.4byte	0x7a
	.byte	0x32
	.uleb128 0x3
	.4byte	.LASF26
	.byte	0x2
	.byte	0x9f
	.byte	0x8
	.4byte	0x7a
	.byte	0x33
	.uleb128 0x3
	.4byte	.LASF27
	.byte	0x2
	.byte	0xa0
	.byte	0x8
	.4byte	0x7a
	.byte	0x34
	.uleb128 0x3
	.4byte	.LASF28
	.byte	0x2
	.byte	0xa1
	.byte	0x8
	.4byte	0x7a
	.byte	0x35
	.uleb128 0x3
	.4byte	.LASF29
	.byte	0x2
	.byte	0xa6
	.byte	0xf
	.4byte	0xb7
	.byte	0x38
	.uleb128 0x3
	.4byte	.LASF30
	.byte	0x2
	.byte	0xa7
	.byte	0xf
	.4byte	0xb7
	.byte	0x3c
	.uleb128 0x3
	.4byte	.LASF31
	.byte	0x2
	.byte	0xa8
	.byte	0xf
	.4byte	0xb7
	.byte	0x40
	.uleb128 0x3
	.4byte	.LASF32
	.byte	0x2
	.byte	0xa9
	.byte	0xf
	.4byte	0xb7
	.byte	0x44
	.uleb128 0x3
	.4byte	.LASF33
	.byte	0x2
	.byte	0xaa
	.byte	0xf
	.4byte	0xb7
	.byte	0x48
	.uleb128 0x3
	.4byte	.LASF34
	.byte	0x2
	.byte	0xab
	.byte	0xf
	.4byte	0xb7
	.byte	0x4c
	.uleb128 0x3
	.4byte	.LASF35
	.byte	0x2
	.byte	0xac
	.byte	0xf
	.4byte	0xb7
	.byte	0x50
	.uleb128 0x3
	.4byte	.LASF36
	.byte	0x2
	.byte	0xad
	.byte	0xf
	.4byte	0xb7
	.byte	0x54
	.byte	0
	.uleb128 0xb
	.4byte	.LASF46
	.byte	0x2
	.byte	0xae
	.byte	0x3
	.4byte	0xbd
	.uleb128 0x9
	.4byte	0x267
	.uleb128 0x5
	.byte	0x1
	.byte	0x8
	.4byte	.LASF37
	.uleb128 0x9
	.4byte	0x278
	.uleb128 0xa
	.byte	0x20
	.byte	0x2
	.byte	0xc4
	.byte	0x9
	.4byte	0x2f6
	.uleb128 0x3
	.4byte	.LASF38
	.byte	0x2
	.byte	0xc6
	.byte	0x9
	.4byte	0x30a
	.byte	0
	.uleb128 0x3
	.4byte	.LASF39
	.byte	0x2
	.byte	0xc7
	.byte	0x9
	.4byte	0x31f
	.byte	0x4
	.uleb128 0x3
	.4byte	.LASF40
	.byte	0x2
	.byte	0xc8
	.byte	0x9
	.4byte	0x31f
	.byte	0x8
	.uleb128 0x3
	.4byte	.LASF41
	.byte	0x2
	.byte	0xcb
	.byte	0x9
	.4byte	0x339
	.byte	0xc
	.uleb128 0x3
	.4byte	.LASF42
	.byte	0x2
	.byte	0xcc
	.byte	0xa
	.4byte	0x34e
	.byte	0x10
	.uleb128 0x3
	.4byte	.LASF43
	.byte	0x2
	.byte	0xcd
	.byte	0xa
	.4byte	0x34e
	.byte	0x14
	.uleb128 0x3
	.4byte	.LASF44
	.byte	0x2
	.byte	0xd0
	.byte	0x9
	.4byte	0x354
	.byte	0x18
	.uleb128 0x3
	.4byte	.LASF45
	.byte	0x2
	.byte	0xd1
	.byte	0x9
	.4byte	0x35a
	.byte	0x1c
	.byte	0
	.uleb128 0x6
	.4byte	0x4d
	.4byte	0x30a
	.uleb128 0x7
	.4byte	0x4d
	.uleb128 0x7
	.4byte	0x4d
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.4byte	0x2f6
	.uleb128 0x6
	.4byte	0x4d
	.4byte	0x31f
	.uleb128 0x7
	.4byte	0x4d
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.4byte	0x310
	.uleb128 0x6
	.4byte	0x4d
	.4byte	0x339
	.uleb128 0x7
	.4byte	0x54
	.uleb128 0x7
	.4byte	0x4d
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.4byte	0x325
	.uleb128 0x6
	.4byte	0x54
	.4byte	0x34e
	.uleb128 0x7
	.4byte	0x54
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.4byte	0x33f
	.uleb128 0x8
	.byte	0x4
	.4byte	0x5b
	.uleb128 0x8
	.byte	0x4
	.4byte	0x93
	.uleb128 0xb
	.4byte	.LASF47
	.byte	0x2
	.byte	0xd2
	.byte	0x3
	.4byte	0x284
	.uleb128 0x9
	.4byte	0x360
	.uleb128 0xa
	.byte	0xc
	.byte	0x2
	.byte	0xd4
	.byte	0x9
	.4byte	0x3a2
	.uleb128 0x3
	.4byte	.LASF48
	.byte	0x2
	.byte	0xd5
	.byte	0xf
	.4byte	0xb7
	.byte	0
	.uleb128 0x3
	.4byte	.LASF49
	.byte	0x2
	.byte	0xd6
	.byte	0x25
	.4byte	0x3a2
	.byte	0x4
	.uleb128 0x3
	.4byte	.LASF50
	.byte	0x2
	.byte	0xd7
	.byte	0x28
	.4byte	0x3a8
	.byte	0x8
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.4byte	0x273
	.uleb128 0x8
	.byte	0x4
	.4byte	0x36c
	.uleb128 0xb
	.4byte	.LASF51
	.byte	0x2
	.byte	0xd8
	.byte	0x3
	.4byte	0x371
	.uleb128 0x9
	.4byte	0x3ae
	.uleb128 0x2
	.4byte	.LASF53
	.byte	0x14
	.byte	0x2
	.byte	0xdc
	.byte	0x10
	.4byte	0x3da
	.uleb128 0x3
	.4byte	.LASF54
	.byte	0x2
	.byte	0xdd
	.byte	0x20
	.4byte	0x3da
	.byte	0
	.byte	0
	.uleb128 0xc
	.4byte	0x3ea
	.4byte	0x3ea
	.uleb128 0xd
	.4byte	0x86
	.byte	0x4
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.4byte	0x3ba
	.uleb128 0xe
	.4byte	.LASF55
	.byte	0x2
	.2byte	0x106
	.byte	0x1a
	.4byte	0x3bf
	.uleb128 0xe
	.4byte	.LASF56
	.byte	0x2
	.2byte	0x10d
	.byte	0x24
	.4byte	0x3ba
	.uleb128 0xe
	.4byte	.LASF57
	.byte	0x2
	.2byte	0x110
	.byte	0x2c
	.4byte	0x36c
	.uleb128 0xe
	.4byte	.LASF58
	.byte	0x2
	.2byte	0x111
	.byte	0x2c
	.4byte	0x36c
	.uleb128 0xc
	.4byte	0x27f
	.4byte	0x434
	.uleb128 0xd
	.4byte	0x86
	.byte	0x7f
	.byte	0
	.uleb128 0x9
	.4byte	0x424
	.uleb128 0xe
	.4byte	.LASF59
	.byte	0x2
	.2byte	0x113
	.byte	0x23
	.4byte	0x434
	.uleb128 0xc
	.4byte	0x81
	.4byte	0x451
	.uleb128 0xf
	.byte	0
	.uleb128 0x9
	.4byte	0x446
	.uleb128 0xe
	.4byte	.LASF60
	.byte	0x2
	.2byte	0x115
	.byte	0x13
	.4byte	0x451
	.uleb128 0xe
	.4byte	.LASF61
	.byte	0x2
	.2byte	0x116
	.byte	0x13
	.4byte	0x451
	.uleb128 0xe
	.4byte	.LASF62
	.byte	0x2
	.2byte	0x117
	.byte	0x13
	.4byte	0x451
	.uleb128 0xe
	.4byte	.LASF63
	.byte	0x2
	.2byte	0x118
	.byte	0x13
	.4byte	0x451
	.uleb128 0xe
	.4byte	.LASF64
	.byte	0x2
	.2byte	0x11a
	.byte	0x13
	.4byte	0x451
	.uleb128 0xe
	.4byte	.LASF65
	.byte	0x2
	.2byte	0x11b
	.byte	0x13
	.4byte	0x451
	.uleb128 0xe
	.4byte	.LASF66
	.byte	0x2
	.2byte	0x11c
	.byte	0x13
	.4byte	0x451
	.uleb128 0xe
	.4byte	.LASF67
	.byte	0x2
	.2byte	0x11d
	.byte	0x13
	.4byte	0x451
	.uleb128 0xe
	.4byte	.LASF68
	.byte	0x2
	.2byte	0x11e
	.byte	0x13
	.4byte	0x451
	.uleb128 0xe
	.4byte	.LASF69
	.byte	0x2
	.2byte	0x11f
	.byte	0x13
	.4byte	0x451
	.uleb128 0x6
	.4byte	0x4d
	.4byte	0x4e7
	.uleb128 0x7
	.4byte	0x4e7
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.4byte	0x4f2
	.uleb128 0x10
	.4byte	.LASF80
	.uleb128 0x9
	.4byte	0x4ed
	.uleb128 0xe
	.4byte	.LASF70
	.byte	0x2
	.2byte	0x135
	.byte	0xe
	.4byte	0x504
	.uleb128 0x8
	.byte	0x4
	.4byte	0x4d8
	.uleb128 0x6
	.4byte	0x4d
	.4byte	0x519
	.uleb128 0x7
	.4byte	0x519
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.4byte	0x4ed
	.uleb128 0xe
	.4byte	.LASF71
	.byte	0x2
	.2byte	0x136
	.byte	0xe
	.4byte	0x52c
	.uleb128 0x8
	.byte	0x4
	.4byte	0x50a
	.uleb128 0x5
	.byte	0x2
	.byte	0x7
	.4byte	.LASF72
	.uleb128 0x11
	.4byte	.LASF73
	.byte	0x2
	.2byte	0x14d
	.byte	0x18
	.4byte	0x546
	.uleb128 0x8
	.byte	0x4
	.4byte	0x54c
	.uleb128 0x6
	.4byte	0xb7
	.4byte	0x55b
	.uleb128 0x7
	.4byte	0x4d
	.byte	0
	.uleb128 0x12
	.4byte	.LASF74
	.byte	0x8
	.byte	0x2
	.2byte	0x14f
	.byte	0x10
	.4byte	0x586
	.uleb128 0x13
	.4byte	.LASF75
	.byte	0x2
	.2byte	0x151
	.byte	0x1c
	.4byte	0x539
	.byte	0
	.uleb128 0x13
	.4byte	.LASF76
	.byte	0x2
	.2byte	0x152
	.byte	0x21
	.4byte	0x586
	.byte	0x4
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.4byte	0x55b
	.uleb128 0x11
	.4byte	.LASF77
	.byte	0x2
	.2byte	0x153
	.byte	0x3
	.4byte	0x55b
	.uleb128 0xe
	.4byte	.LASF78
	.byte	0x2
	.2byte	0x157
	.byte	0x1f
	.4byte	0x5a6
	.uleb128 0x8
	.byte	0x4
	.4byte	0x58c
	.uleb128 0x11
	.4byte	.LASF79
	.byte	0x3
	.2byte	0x317
	.byte	0x1b
	.4byte	0x5b9
	.uleb128 0x10
	.4byte	.LASF81
	.uleb128 0xe
	.4byte	.LASF82
	.byte	0x3
	.2byte	0x31b
	.byte	0xe
	.4byte	0x5cb
	.uleb128 0x8
	.byte	0x4
	.4byte	0x5ac
	.uleb128 0xe
	.4byte	.LASF83
	.byte	0x3
	.2byte	0x31c
	.byte	0xe
	.4byte	0x5cb
	.uleb128 0xe
	.4byte	.LASF84
	.byte	0x3
	.2byte	0x31d
	.byte	0xe
	.4byte	0x5cb
	.uleb128 0x5
	.byte	0x8
	.byte	0x5
	.4byte	.LASF85
	.uleb128 0xc
	.4byte	0x7a
	.4byte	0x602
	.uleb128 0xd
	.4byte	0x86
	.byte	0x7
	.byte	0
	.uleb128 0x14
	.4byte	.LASF86
	.byte	0x1
	.byte	0x11
	.byte	0xd
	.4byte	0x5f2
	.uleb128 0x5
	.byte	0x3
	.4byte	log_file_name
	.uleb128 0x15
	.ascii	"fp\000"
	.byte	0x1
	.byte	0x12
	.byte	0xf
	.4byte	0x5cb
	.uleb128 0x5
	.byte	0x3
	.4byte	fp
	.uleb128 0x16
	.4byte	.LASF90
	.byte	0x1
	.byte	0x3d
	.byte	0x6
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x64c
	.uleb128 0x17
	.4byte	.LASF91
	.byte	0x1
	.byte	0x3d
	.byte	0x1a
	.4byte	0xb7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x18
	.byte	0
	.uleb128 0x19
	.4byte	.LASF92
	.byte	0x1
	.byte	0x2d
	.byte	0x6
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1a
	.4byte	.LASF93
	.byte	0x1
	.byte	0x1b
	.byte	0x8
	.4byte	0x5cb
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
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
	.uleb128 0x6
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
	.uleb128 0x7
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x26
	.byte	0
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
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x34
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
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x16
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
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
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
	.uleb128 0x18
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x19
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
	.uleb128 0x1a
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
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_pubnames,"",%progbits
	.4byte	0x5a
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x675
	.4byte	0x602
	.ascii	"log_file_name\000"
	.4byte	0x614
	.ascii	"fp\000"
	.4byte	0x625
	.ascii	"HAL_Log\000"
	.4byte	0x64c
	.ascii	"HAL_Log_DeInit\000"
	.4byte	0x65e
	.ascii	"HAL_Log_GetFile\000"
	.4byte	0
	.section	.debug_pubtypes,"",%progbits
	.4byte	0x137
	.2byte	0x2
	.4byte	.Ldebug_info0
	.4byte	0x675
	.4byte	0x4d
	.ascii	"int\000"
	.4byte	0x54
	.ascii	"long int\000"
	.4byte	0x25
	.ascii	"__mbstate_s\000"
	.4byte	0x7a
	.ascii	"char\000"
	.4byte	0x86
	.ascii	"unsigned int\000"
	.4byte	0x267
	.ascii	"__RAL_locale_data_t\000"
	.4byte	0x278
	.ascii	"unsigned char\000"
	.4byte	0x360
	.ascii	"__RAL_locale_codeset_t\000"
	.4byte	0x3ae
	.ascii	"__RAL_locale_t\000"
	.4byte	0x3bf
	.ascii	"__locale_s\000"
	.4byte	0x532
	.ascii	"short unsigned int\000"
	.4byte	0x539
	.ascii	"__RAL_error_decoder_fn_t\000"
	.4byte	0x55b
	.ascii	"__RAL_error_decoder_s\000"
	.4byte	0x58c
	.ascii	"__RAL_error_decoder_t\000"
	.4byte	0x5ac
	.ascii	"FILE\000"
	.4byte	0x5eb
	.ascii	"long long int\000"
	.4byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x2c
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
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF52:
	.ascii	"__mbstate_s\000"
.LASF41:
	.ascii	"__iswctype\000"
.LASF27:
	.ascii	"int_p_sign_posn\000"
.LASF78:
	.ascii	"__RAL_error_decoder_head\000"
.LASF69:
	.ascii	"__RAL_data_empty_string\000"
.LASF26:
	.ascii	"int_n_sep_by_space\000"
.LASF53:
	.ascii	"__locale_s\000"
.LASF31:
	.ascii	"month_names\000"
.LASF1:
	.ascii	"__wchar\000"
.LASF61:
	.ascii	"__RAL_c_locale_abbrev_day_names\000"
.LASF20:
	.ascii	"n_sep_by_space\000"
.LASF40:
	.ascii	"__tolower\000"
.LASF22:
	.ascii	"n_sign_posn\000"
.LASF85:
	.ascii	"long long int\000"
.LASF35:
	.ascii	"time_format\000"
.LASF46:
	.ascii	"__RAL_locale_data_t\000"
.LASF58:
	.ascii	"__RAL_codeset_utf8\000"
.LASF62:
	.ascii	"__RAL_c_locale_month_names\000"
.LASF17:
	.ascii	"p_cs_precedes\000"
.LASF93:
	.ascii	"HAL_Log_GetFile\000"
.LASF28:
	.ascii	"int_n_sign_posn\000"
.LASF64:
	.ascii	"__RAL_data_utf8_period\000"
.LASF25:
	.ascii	"int_p_sep_by_space\000"
.LASF74:
	.ascii	"__RAL_error_decoder_s\000"
.LASF77:
	.ascii	"__RAL_error_decoder_t\000"
.LASF10:
	.ascii	"mon_decimal_point\000"
.LASF5:
	.ascii	"decimal_point\000"
.LASF15:
	.ascii	"int_frac_digits\000"
.LASF84:
	.ascii	"stderr\000"
.LASF50:
	.ascii	"codeset\000"
.LASF18:
	.ascii	"p_sep_by_space\000"
.LASF54:
	.ascii	"__category\000"
.LASF7:
	.ascii	"grouping\000"
.LASF89:
	.ascii	"C:\\Users\\ali\\Desktop\\Ali_Safaei\\5_GeoLocation_"
	.ascii	"UWB\\UWB_sensors\\DWM1001\\Source_Code\\dwm1001_exm"
	.ascii	"\\examples\\ds_twr_resp\\SES\000"
.LASF2:
	.ascii	"long int\000"
.LASF43:
	.ascii	"__towlower\000"
.LASF14:
	.ascii	"negative_sign\000"
.LASF75:
	.ascii	"decode\000"
.LASF48:
	.ascii	"name\000"
.LASF63:
	.ascii	"__RAL_c_locale_abbrev_month_names\000"
.LASF21:
	.ascii	"p_sign_posn\000"
.LASF73:
	.ascii	"__RAL_error_decoder_fn_t\000"
.LASF70:
	.ascii	"__user_set_time_of_day\000"
.LASF92:
	.ascii	"HAL_Log_DeInit\000"
.LASF37:
	.ascii	"unsigned char\000"
.LASF56:
	.ascii	"__RAL_c_locale\000"
.LASF57:
	.ascii	"__RAL_codeset_ascii\000"
.LASF9:
	.ascii	"currency_symbol\000"
.LASF87:
	.ascii	"GNU C99 8.2.1 20181213 (release) [gcc-8-branch revi"
	.ascii	"sion 267074] -fmessage-length=0 -mcpu=cortex-m4 -ml"
	.ascii	"ittle-endian -mfloat-abi=hard -mfpu=fpv4-sp-d16 -mt"
	.ascii	"humb -mtp=soft -munaligned-access -std=gnu99 -g2 -g"
	.ascii	"pubnames -fomit-frame-pointer -fno-dwarf2-cfi-asm -"
	.ascii	"fno-builtin -ffunction-sections -fdata-sections -fs"
	.ascii	"hort-enums -fno-common\000"
.LASF12:
	.ascii	"mon_grouping\000"
.LASF4:
	.ascii	"unsigned int\000"
.LASF29:
	.ascii	"day_names\000"
.LASF33:
	.ascii	"am_pm_indicator\000"
.LASF42:
	.ascii	"__towupper\000"
.LASF8:
	.ascii	"int_curr_symbol\000"
.LASF67:
	.ascii	"__RAL_data_utf8_plus\000"
.LASF72:
	.ascii	"short unsigned int\000"
.LASF3:
	.ascii	"char\000"
.LASF71:
	.ascii	"__user_get_time_of_day\000"
.LASF19:
	.ascii	"n_cs_precedes\000"
.LASF36:
	.ascii	"date_time_format\000"
.LASF66:
	.ascii	"__RAL_data_utf8_space\000"
.LASF86:
	.ascii	"log_file_name\000"
.LASF49:
	.ascii	"data\000"
.LASF79:
	.ascii	"FILE\000"
.LASF88:
	.ascii	"C:\\Users\\ali\\Desktop\\Ali_Safaei\\5_GeoLocation_"
	.ascii	"UWB\\UWB_sensors\\DWM1001\\Source_Code\\dwm1001_exm"
	.ascii	"\\nRF5_SDK_14.2.0\\components\\libraries\\hal\\hal_"
	.ascii	"log.c\000"
.LASF16:
	.ascii	"frac_digits\000"
.LASF59:
	.ascii	"__RAL_ascii_ctype_map\000"
.LASF55:
	.ascii	"__RAL_global_locale\000"
.LASF80:
	.ascii	"timeval\000"
.LASF60:
	.ascii	"__RAL_c_locale_day_names\000"
.LASF81:
	.ascii	"__RAL_FILE\000"
.LASF32:
	.ascii	"abbrev_month_names\000"
.LASF90:
	.ascii	"HAL_Log\000"
.LASF47:
	.ascii	"__RAL_locale_codeset_t\000"
.LASF82:
	.ascii	"stdin\000"
.LASF13:
	.ascii	"positive_sign\000"
.LASF45:
	.ascii	"__mbtowc\000"
.LASF51:
	.ascii	"__RAL_locale_t\000"
.LASF34:
	.ascii	"date_format\000"
.LASF39:
	.ascii	"__toupper\000"
.LASF65:
	.ascii	"__RAL_data_utf8_comma\000"
.LASF11:
	.ascii	"mon_thousands_sep\000"
.LASF6:
	.ascii	"thousands_sep\000"
.LASF24:
	.ascii	"int_n_cs_precedes\000"
.LASF38:
	.ascii	"__isctype\000"
.LASF0:
	.ascii	"__state\000"
.LASF91:
	.ascii	"format\000"
.LASF68:
	.ascii	"__RAL_data_utf8_minus\000"
.LASF23:
	.ascii	"int_p_cs_precedes\000"
.LASF30:
	.ascii	"abbrev_day_names\000"
.LASF44:
	.ascii	"__wctomb\000"
.LASF83:
	.ascii	"stdout\000"
.LASF76:
	.ascii	"next\000"
	.ident	"GCC: (GNU) 8.2.1 20181213 (release) [gcc-8-branch revision 267074]"

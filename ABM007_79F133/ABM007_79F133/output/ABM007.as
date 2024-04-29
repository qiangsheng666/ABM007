opt subtitle "Microchip Technology Omniscient Code Generator v1.45 (PRO mode) build 201711160504"

opt pagewidth 120

	opt pm

	processor	79F133
opt include "D:\soft.download\CMS_IDE_V2.03.25\CMS_IDE_V2.03.25\data\include\79f133.cgen.inc"
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
	FNCALL	_main,_Delay_nms
	FNCALL	_main,_GflushLoop
	FNCALL	_main,_GledLoop
	FNCALL	_main,_GsensorLoop
	FNCALL	_main,_Init_GPIO
	FNCALL	_main,_Init_IC
	FNCALL	_main,_Init_TIMER1
	FNCALL	_main,_Init_TIMER2
	FNCALL	_GsensorLoop,_SensorControl
	FNCALL	_GsensorLoop,_SensorJudge
	FNCALL	_GsensorLoop,_SensorKey
	FNCALL	_GsensorLoop,_SensorTime
	FNCALL	_GledLoop,_LED_Con
	FNCALL	_GledLoop,_LED_Judge
	FNCALL	_GledLoop,_LED_Key
	FNCALL	_GledLoop,_LED_Time
	FNCALL	_GflushLoop,_FlushCon
	FNCALL	_GflushLoop,_FlushJudge
	FNCALL	_GflushLoop,_FlushTime
	FNCALL	_Delay_nms,_Delay
	FNROOT	_main
	FNCALL	_Int_ALL,_INT_LED_SHOW
	FNCALL	intlevel1,_Int_ALL
	global	intlevel1
	FNROOT	intlevel1
	global	_CNTbreath_Led2
	global	_Fflush1
	global	_FledBits01
	global	_Fbodysensor
	global	_CNTfct
	global	_CNTbodyExitTime
	global	_CNTbodyInTime
	global	_BufCntAdd
	global	_CNTbody_l
	global	_CNTbody_h
	global	_CNTflush
	global	_AD_Result
	global	_MainTime_1s
	global	_CNTbreath_Led3
	global	_CNTbreath_Led1
	global	_CNTbreath_Led
	global	_CNTfctStart
	global	_fctBits001
	global	_SEQbody
	global	_u8stsBodySensor
	global	_SEQflsuh
	global	_MainTime_1min
	global	_SEQmain
	global	_templ
	global	_RX_Buf
	global	_Fsys1m
	global	_Fsys1s
	global	_Fsys1
	global	_TMR1
psect	text0,local,class=CODE,delta=2,merge=1
global __ptext0
__ptext0:
_TMR1	set	14
	global	_T2CON
_T2CON	set	18
	global	_T1CON
_T1CON	set	16
	global	_PIR2
_PIR2	set	13
	global	_PIR1
_PIR1	set	12
	global	_INTCON
_INTCON	set	11
	global	_PORTC
_PORTC	set	7
	global	_PORTB
_PORTB	set	6
	global	_PORTA
_PORTA	set	5
	global	_TMR1IF
_TMR1IF	set	96
	global	_TMR2IF
_TMR2IF	set	97
	global	_GIE
_GIE	set	95
	global	_RB1
_RB1	set	49
	global	_RA2
_RA2	set	42
	global	_RA4
_RA4	set	44
	global	_RA5
_RA5	set	45
	global	_WPUB
_WPUB	set	149
	global	_PR2
_PR2	set	146
	global	_OSCCON
_OSCCON	set	143
	global	_PIE2
_PIE2	set	141
	global	_PIE1
_PIE1	set	140
	global	_TRISC
_TRISC	set	135
	global	_TRISB
_TRISB	set	134
	global	_TRISA
_TRISA	set	133
	global	_OPTION_REG
_OPTION_REG	set	129
	global	_TMR1IE
_TMR1IE	set	1120
	global	_TMR2IE
_TMR2IE	set	1121
	global	_WDTCON
_WDTCON	set	261
	global	_WPUC
_WPUC	set	399
	global	_WPUA
_WPUA	set	398
; #config settings
	file	"ABM007.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

global __initialization
__initialization:
psect	bssCOMMON,class=COMMON,space=1,noexec
global __pbssCOMMON
__pbssCOMMON:
_CNTbreath_Led2:
       ds      2

_Fflush1:
       ds      1

_FledBits01:
       ds      1

_Fbodysensor:
       ds      1

psect	bssBANK0,class=BANK0,space=1,noexec
global __pbssBANK0
__pbssBANK0:
_CNTfct:
       ds      2

_CNTbodyExitTime:
       ds      2

_CNTbodyInTime:
       ds      2

_BufCntAdd:
       ds      2

_CNTbody_l:
       ds      2

_CNTbody_h:
       ds      2

_CNTflush:
       ds      2

_AD_Result:
       ds      2

_MainTime_1s:
       ds      2

_CNTbreath_Led3:
       ds      2

_CNTbreath_Led1:
       ds      2

_CNTbreath_Led:
       ds      2

_CNTfctStart:
       ds      1

_fctBits001:
       ds      1

_SEQbody:
       ds      1

_u8stsBodySensor:
       ds      1

_SEQflsuh:
       ds      1

_MainTime_1min:
       ds      1

_SEQmain:
       ds      1

_templ:
       ds      1

_RX_Buf:
       ds      1

_Fsys1m:
       ds      1

_Fsys1s:
       ds      1

_Fsys1:
       ds      1

	file	"ABM007.as"
	line	#
psect clrtext,class=CODE,delta=2
global clear_ram0
;	Called with FSR containing the base address, and
;	W with the last address+1
clear_ram0:
	clrwdt			;clear the watchdog before getting into this loop
clrloop0:
	clrf	indf		;clear RAM location pointed to by FSR
	incf	fsr,f		;increment pointer
	xorwf	fsr,w		;XOR with final address
	btfsc	status,2	;have we reached the end yet?
	retlw	0		;all done for this memory range, return
	xorwf	fsr,w		;XOR again to restore value
	goto	clrloop0		;do the next byte

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2,merge=1
	clrf	((__pbssCOMMON)+0)&07Fh
	clrf	((__pbssCOMMON)+1)&07Fh
	clrf	((__pbssCOMMON)+2)&07Fh
	clrf	((__pbssCOMMON)+3)&07Fh
	clrf	((__pbssCOMMON)+4)&07Fh
; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2,merge=1
	bcf	status, 7	;select IRP bank0
	movlw	low(__pbssBANK0)
	movwf	fsr
	movlw	low((__pbssBANK0)+024h)
	fcall	clear_ram0
psect cinit,class=CODE,delta=2,merge=1
global end_of_initialization,__end_of__initialization

;End of C runtime variable initialization code

end_of_initialization:
__end_of__initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1,noexec
global __pcstackCOMMON
__pcstackCOMMON:
?_LED_Time:	; 1 bytes @ 0x0
?_LED_Key:	; 1 bytes @ 0x0
?_LED_Judge:	; 1 bytes @ 0x0
?_LED_Con:	; 1 bytes @ 0x0
?_GsensorLoop:	; 1 bytes @ 0x0
?_GflushLoop:	; 1 bytes @ 0x0
?_FlushTime:	; 1 bytes @ 0x0
?_FlushJudge:	; 1 bytes @ 0x0
?_FlushCon:	; 1 bytes @ 0x0
?_SensorKey:	; 1 bytes @ 0x0
?_SensorTime:	; 1 bytes @ 0x0
?_SensorJudge:	; 1 bytes @ 0x0
?_SensorControl:	; 1 bytes @ 0x0
?_GledLoop:	; 1 bytes @ 0x0
?_INT_LED_SHOW:	; 1 bytes @ 0x0
??_INT_LED_SHOW:	; 1 bytes @ 0x0
?_Init_GPIO:	; 1 bytes @ 0x0
?_Init_IC:	; 1 bytes @ 0x0
?_Init_TIMER1:	; 1 bytes @ 0x0
?_Init_TIMER2:	; 1 bytes @ 0x0
?_main:	; 1 bytes @ 0x0
?_Int_ALL:	; 1 bytes @ 0x0
??_Int_ALL:	; 1 bytes @ 0x0
	ds	2
??_LED_Time:	; 1 bytes @ 0x2
??_LED_Key:	; 1 bytes @ 0x2
??_LED_Judge:	; 1 bytes @ 0x2
??_LED_Con:	; 1 bytes @ 0x2
??_GflushLoop:	; 1 bytes @ 0x2
??_FlushTime:	; 1 bytes @ 0x2
??_FlushJudge:	; 1 bytes @ 0x2
??_FlushCon:	; 1 bytes @ 0x2
??_SensorKey:	; 1 bytes @ 0x2
??_SensorTime:	; 1 bytes @ 0x2
??_SensorJudge:	; 1 bytes @ 0x2
??_SensorControl:	; 1 bytes @ 0x2
??_GledLoop:	; 1 bytes @ 0x2
?_Delay:	; 1 bytes @ 0x2
??_Init_GPIO:	; 1 bytes @ 0x2
??_Init_IC:	; 1 bytes @ 0x2
??_Init_TIMER1:	; 1 bytes @ 0x2
??_Init_TIMER2:	; 1 bytes @ 0x2
	global	Delay@dtemp
Delay@dtemp:	; 2 bytes @ 0x2
	ds	1
??_GsensorLoop:	; 1 bytes @ 0x3
	ds	1
??_Delay:	; 1 bytes @ 0x4
?_Delay_nms:	; 1 bytes @ 0x4
	global	Delay_nms@inittempl
Delay_nms@inittempl:	; 2 bytes @ 0x4
	ds	2
??_Delay_nms:	; 1 bytes @ 0x6
??_main:	; 1 bytes @ 0x6
psect	cstackBANK0,class=BANK0,space=1,noexec
global __pcstackBANK0
__pcstackBANK0:
	global	Delay_nms@i
Delay_nms@i:	; 2 bytes @ 0x0
	ds	2
	global	Delay_nms@gtemp
Delay_nms@gtemp:	; 1 bytes @ 0x2
	ds	1
;!
;!Data Sizes:
;!    Strings     0
;!    Constant    0
;!    Data        0
;!    BSS         41
;!    Persistent  0
;!    Stack       0
;!
;!Auto Spaces:
;!    Space          Size  Autos    Used
;!    COMMON           14      6      11
;!    BANK0            80      3      39
;!    BANK1            80      0       0
;!    BANK3            80      0       0
;!    BANK2            80      0       0

;!
;!Pointer List with Targets:
;!
;!    None.


;!
;!Critical Paths under _main in COMMON
;!
;!    _main->_Delay_nms
;!    _GsensorLoop->_SensorControl
;!    _Delay_nms->_Delay
;!
;!Critical Paths under _Int_ALL in COMMON
;!
;!    None.
;!
;!Critical Paths under _main in BANK0
;!
;!    _main->_Delay_nms
;!
;!Critical Paths under _Int_ALL in BANK0
;!
;!    None.
;!
;!Critical Paths under _main in BANK1
;!
;!    None.
;!
;!Critical Paths under _Int_ALL in BANK1
;!
;!    None.
;!
;!Critical Paths under _main in BANK3
;!
;!    None.
;!
;!Critical Paths under _Int_ALL in BANK3
;!
;!    None.
;!
;!Critical Paths under _main in BANK2
;!
;!    None.
;!
;!Critical Paths under _Int_ALL in BANK2
;!
;!    None.

;;
;;Main: autosize = 0, tempsize = 0, incstack = 0, save=0
;;

;!
;!Call Graph Tables:
;!
;! ---------------------------------------------------------------------------------
;! (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;! ---------------------------------------------------------------------------------
;! (0) _main                                                 0     0      0     244
;!                          _Delay_nms
;!                         _GflushLoop
;!                           _GledLoop
;!                        _GsensorLoop
;!                          _Init_GPIO
;!                            _Init_IC
;!                        _Init_TIMER1
;!                        _Init_TIMER2
;! ---------------------------------------------------------------------------------
;! (1) _Init_TIMER2                                          0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _Init_TIMER1                                          0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _Init_IC                                              0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _Init_GPIO                                            0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _GsensorLoop                                          0     0      0       0
;!                      _SensorControl
;!                        _SensorJudge
;!                          _SensorKey
;!                         _SensorTime
;! ---------------------------------------------------------------------------------
;! (2) _SensorTime                                           0     0      0       0
;! ---------------------------------------------------------------------------------
;! (2) _SensorKey                                            0     0      0       0
;! ---------------------------------------------------------------------------------
;! (2) _SensorJudge                                          0     0      0       0
;! ---------------------------------------------------------------------------------
;! (2) _SensorControl                                        1     1      0       0
;!                                              2 COMMON     1     1      0
;! ---------------------------------------------------------------------------------
;! (1) _GledLoop                                             0     0      0       0
;!                            _LED_Con
;!                          _LED_Judge
;!                            _LED_Key
;!                           _LED_Time
;! ---------------------------------------------------------------------------------
;! (2) _LED_Time                                             0     0      0       0
;! ---------------------------------------------------------------------------------
;! (2) _LED_Key                                              0     0      0       0
;! ---------------------------------------------------------------------------------
;! (2) _LED_Judge                                            0     0      0       0
;! ---------------------------------------------------------------------------------
;! (2) _LED_Con                                              0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _GflushLoop                                           0     0      0       0
;!                           _FlushCon
;!                         _FlushJudge
;!                          _FlushTime
;! ---------------------------------------------------------------------------------
;! (2) _FlushTime                                            0     0      0       0
;! ---------------------------------------------------------------------------------
;! (2) _FlushJudge                                           0     0      0       0
;! ---------------------------------------------------------------------------------
;! (2) _FlushCon                                             0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _Delay_nms                                            5     3      2     244
;!                                              4 COMMON     2     0      2
;!                                              0 BANK0      3     3      0
;!                              _Delay
;! ---------------------------------------------------------------------------------
;! (2) _Delay                                                2     0      2      85
;!                                              2 COMMON     2     0      2
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 2
;! ---------------------------------------------------------------------------------
;! (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;! ---------------------------------------------------------------------------------
;! (3) _Int_ALL                                              2     2      0       0
;!                                              0 COMMON     2     2      0
;!                       _INT_LED_SHOW
;! ---------------------------------------------------------------------------------
;! (4) _INT_LED_SHOW                                         0     0      0       0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 4
;! ---------------------------------------------------------------------------------
;!
;! Call Graph Graphs:
;!
;! _main (ROOT)
;!   _Delay_nms
;!     _Delay
;!   _GflushLoop
;!     _FlushCon
;!     _FlushJudge
;!     _FlushTime
;!   _GledLoop
;!     _LED_Con
;!     _LED_Judge
;!     _LED_Key
;!     _LED_Time
;!   _GsensorLoop
;!     _SensorControl
;!     _SensorJudge
;!     _SensorKey
;!     _SensorTime
;!   _Init_GPIO
;!   _Init_IC
;!   _Init_TIMER1
;!   _Init_TIMER2
;!
;! _Int_ALL (ROOT)
;!   _INT_LED_SHOW
;!

;! Address spaces:

;!Name               Size   Autos  Total    Cost      Usage
;!BITCOMMON            E      0       0       0        0.0%
;!NULL                 0      0       0       0        0.0%
;!CODE                 0      0       0       0        0.0%
;!COMMON               E      6       B       1       78.6%
;!BITSFR0              0      0       0       1        0.0%
;!SFR0                 0      0       0       1        0.0%
;!BITSFR1              0      0       0       2        0.0%
;!SFR1                 0      0       0       2        0.0%
;!STACK                0      0       0       2        0.0%
;!BITBANK0            50      0       0       3        0.0%
;!BANK0               50      3      27       4       48.8%
;!BITSFR3              0      0       0       4        0.0%
;!SFR3                 0      0       0       4        0.0%
;!BITBANK1            50      0       0       5        0.0%
;!BITSFR2              0      0       0       5        0.0%
;!SFR2                 0      0       0       5        0.0%
;!BANK1               50      0       0       6        0.0%
;!BITBANK3            50      0       0       7        0.0%
;!BANK3               50      0       0       8        0.0%
;!BITBANK2            50      0       0       9        0.0%
;!BANK2               50      0       0      10        0.0%
;!ABS                  0      0      32      11        0.0%
;!DATA                 0      0      32      12        0.0%

	global	_main

;; *************** function _main *****************
;; Defined at:
;;		line 476 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : B00/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_Delay_nms
;;		_GflushLoop
;;		_GledLoop
;;		_GsensorLoop
;;		_Init_GPIO
;;		_Init_IC
;;		_Init_TIMER1
;;		_Init_TIMER2
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext,global,class=CODE,delta=2,split=1,group=0
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
	line	476
global __pmaintext
__pmaintext:	;psect for function _main
psect	maintext
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
	line	476
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
;incstack = 0
	opt	stack 4
; Regs used in _main: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	479
	
l6058:	
# 479 "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
nop ;# 
	line	480
# 480 "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
clrwdt ;# 
psect	maintext
	line	481
	
l6060:	
;main.c: 481: INTCON = 0;
	clrf	(11)	;volatile
	line	483
	
l6062:	
;main.c: 483: Init_GPIO();
	fcall	_Init_GPIO
	line	484
	
l6064:	
;main.c: 484: Init_IC();
	fcall	_Init_IC
	line	485
	
l6066:	
;main.c: 485: Delay_nms(200);
	movlw	0C8h
	movwf	(Delay_nms@inittempl)
	clrf	(Delay_nms@inittempl+1)
	fcall	_Delay_nms
	line	486
	
l6068:	
;main.c: 486: Init_TIMER1();
	fcall	_Init_TIMER1
	line	487
	
l6070:	
;main.c: 487: Init_TIMER2();
	fcall	_Init_TIMER2
	line	498
	
l6072:	
;main.c: 498: INTCON = 0XC0;
	movlw	low(0C0h)
	movwf	(11)	;volatile
	line	504
	
l6074:	
;main.c: 502: {
;main.c: 504: if (Fsys1.bits.bit_1 == 1)
	btfss	(_Fsys1),1	;volatile
	goto	u1501
	goto	u1500
u1501:
	goto	l6074
u1500:
	line	506
	
l6076:	
# 506 "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
clrwdt ;# 
psect	maintext
	line	507
;main.c: 507: Fsys1.bits.bit_1 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(_Fsys1),1	;volatile
	line	508
;main.c: 508: switch (SEQmain)
	goto	l6086
	line	516
	
l6078:	
;main.c: 516: GsensorLoop();
	fcall	_GsensorLoop
	line	517
;main.c: 517: break;
	goto	l6088
	line	528
	
l6080:	
;main.c: 528: GflushLoop();
	fcall	_GflushLoop
	line	529
;main.c: 529: break;
	goto	l6088
	line	540
	
l6082:	
;main.c: 540: GledLoop();
	fcall	_GledLoop
	line	541
;main.c: 541: break;
	goto	l6088
	line	508
	
l6086:	
	movf	(_SEQmain),w	;volatile
	; Switch size 1, requested type "space"
; Number of cases is 10, Range of values is 0 to 9
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           31    16 (average)
; direct_byte           38     8 (fixed)
; jumptable            260     6 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_push
	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l6078
	xorlw	1^0	; case 1
	skipnz
	goto	l6088
	xorlw	2^1	; case 2
	skipnz
	goto	l6088
	xorlw	3^2	; case 3
	skipnz
	goto	l6088
	xorlw	4^3	; case 4
	skipnz
	goto	l6080
	xorlw	5^4	; case 5
	skipnz
	goto	l6088
	xorlw	6^5	; case 6
	skipnz
	goto	l6088
	xorlw	7^6	; case 7
	skipnz
	goto	l6088
	xorlw	8^7	; case 8
	skipnz
	goto	l6082
	xorlw	9^8	; case 9
	skipnz
	goto	l6088
	goto	l6088
	opt asmopt_pop

	line	550
	
l6088:	
;main.c: 550: if (++SEQmain >= 10)
	movlw	low(0Ah)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	incf	(_SEQmain),f	;volatile
	subwf	((_SEQmain)),w	;volatile
	skipc
	goto	u1511
	goto	u1510
u1511:
	goto	l6074
u1510:
	line	552
	
l6090:	
;main.c: 551: {
;main.c: 552: SEQmain = 0;
	clrf	(_SEQmain)	;volatile
	goto	l6074
	global	start
	ljmp	start
	opt stack 0
	line	556
GLOBAL	__end_of_main
	__end_of_main:
	signat	_main,89
	global	_Init_TIMER2

;; *************** function _Init_TIMER2 *****************
;; Defined at:
;;		line 177 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text1,local,class=CODE,delta=2,merge=1,group=0
	line	177
global __ptext1
__ptext1:	;psect for function _Init_TIMER2
psect	text1
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
	line	177
	global	__size_of_Init_TIMER2
	__size_of_Init_TIMER2	equ	__end_of_Init_TIMER2-_Init_TIMER2
	
_Init_TIMER2:	
;incstack = 0
	opt	stack 5
; Regs used in _Init_TIMER2: [wreg]
	line	179
	
l5968:	
;main.c: 179: PR2 = 24;
	movlw	low(018h)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(146)^080h	;volatile
	line	180
	
l5970:	
;main.c: 180: TMR2IF = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	(97/8),(97)&7	;volatile
	line	181
	
l5972:	
;main.c: 181: TMR2IE = 1;
	bsf	status, 5	;RP0=1, select bank1
	bsf	(1121/8)^080h,(1121)&7	;volatile
	line	182
;main.c: 182: T2CON = 5;
	movlw	low(05h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(18)	;volatile
	line	183
	
l1903:	
	return
	opt stack 0
GLOBAL	__end_of_Init_TIMER2
	__end_of_Init_TIMER2:
	signat	_Init_TIMER2,89
	global	_Init_TIMER1

;; *************** function _Init_TIMER1 *****************
;; Defined at:
;;		line 155 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text2,local,class=CODE,delta=2,merge=1,group=0
	line	155
global __ptext2
__ptext2:	;psect for function _Init_TIMER1
psect	text2
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
	line	155
	global	__size_of_Init_TIMER1
	__size_of_Init_TIMER1	equ	__end_of_Init_TIMER1-_Init_TIMER1
	
_Init_TIMER1:	
;incstack = 0
	opt	stack 5
; Regs used in _Init_TIMER1: [wreg]
	line	159
	
l5964:	
;main.c: 159: TMR1 = 0xE0C0;
	movlw	0E0h
	movwf	(14+1)	;volatile
	movlw	0C0h
	movwf	(14)	;volatile
	line	160
;main.c: 160: TMR1IF = 0;
	bcf	(96/8),(96)&7	;volatile
	line	161
;main.c: 161: TMR1IE = 1;
	bsf	status, 5	;RP0=1, select bank1
	bsf	(1120/8)^080h,(1120)&7	;volatile
	line	162
	
l5966:	
;main.c: 162: T1CON = 0x01;
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(16)	;volatile
	line	163
	
l1900:	
	return
	opt stack 0
GLOBAL	__end_of_Init_TIMER1
	__end_of_Init_TIMER1:
	signat	_Init_TIMER1,89
	global	_Init_IC

;; *************** function _Init_IC *****************
;; Defined at:
;;		line 99 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 300/300
;;		On exit  : 300/100
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text3,local,class=CODE,delta=2,merge=1,group=0
	line	99
global __ptext3
__ptext3:	;psect for function _Init_IC
psect	text3
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
	line	99
	global	__size_of_Init_IC
	__size_of_Init_IC	equ	__end_of_Init_IC-_Init_IC
	
_Init_IC:	
;incstack = 0
	opt	stack 5
; Regs used in _Init_IC: [wreg+status,2]
	line	101
	
l5950:	
# 101 "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
clrwdt ;# 
psect	text3
	line	106
	
l5952:	
;main.c: 106: INTCON = 0x00;
	clrf	(11)	;volatile
	line	111
;main.c: 111: PIR1 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(12)	;volatile
	line	116
;main.c: 116: PIR2 = 0;
	clrf	(13)	;volatile
	line	121
	
l5954:	
;main.c: 121: WDTCON = 0x01;
	movlw	low(01h)
	bsf	status, 6	;RP1=1, select bank2
	movwf	(261)^0100h	;volatile
	line	126
	
l5956:	
;main.c: 126: OPTION_REG = 0b00001110;
	movlw	low(0Eh)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(129)^080h	;volatile
	line	131
	
l5958:	
;main.c: 131: OSCCON = 0x71;
	movlw	low(071h)
	movwf	(143)^080h	;volatile
	line	136
	
l5960:	
;main.c: 136: PIE1 = 0;
	clrf	(140)^080h	;volatile
	line	141
	
l5962:	
;main.c: 141: PIE2 = 0;
	clrf	(141)^080h	;volatile
	line	142
	
l1897:	
	return
	opt stack 0
GLOBAL	__end_of_Init_IC
	__end_of_Init_IC:
	signat	_Init_IC,89
	global	_Init_GPIO

;; *************** function _Init_GPIO *****************
;; Defined at:
;;		line 65 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 300/300
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text4,local,class=CODE,delta=2,merge=1,group=0
	line	65
global __ptext4
__ptext4:	;psect for function _Init_GPIO
psect	text4
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
	line	65
	global	__size_of_Init_GPIO
	__size_of_Init_GPIO	equ	__end_of_Init_GPIO-_Init_GPIO
	
_Init_GPIO:	
;incstack = 0
	opt	stack 5
; Regs used in _Init_GPIO: [wreg+status,2]
	line	69
	
l5940:	
;main.c: 69: PORTA = 0B00000000;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(5)	;volatile
	line	70
;main.c: 70: PORTB = 0B00000000;
	clrf	(6)	;volatile
	line	71
;main.c: 71: PORTC = 0B00000000;
	clrf	(7)	;volatile
	line	74
;main.c: 74: TRISA = 0B00000000;
	bsf	status, 5	;RP0=1, select bank1
	clrf	(133)^080h	;volatile
	line	75
	
l5942:	
;main.c: 75: TRISB = 0B00000010;
	movlw	low(02h)
	movwf	(134)^080h	;volatile
	line	76
	
l5944:	
;main.c: 76: TRISC = 0B00000000;
	clrf	(135)^080h	;volatile
	line	79
	
l5946:	
;main.c: 79: WPUA = 0B00000000;
	bsf	status, 6	;RP1=1, select bank3
	clrf	(398)^0180h	;volatile
	line	80
	
l5948:	
;main.c: 80: WPUB = 0B00000010;
	movlw	low(02h)
	bcf	status, 6	;RP1=0, select bank1
	movwf	(149)^080h	;volatile
	line	81
;main.c: 81: WPUC = 0B00000000;
	bsf	status, 6	;RP1=1, select bank3
	clrf	(399)^0180h	;volatile
	line	90
	
l1894:	
	return
	opt stack 0
GLOBAL	__end_of_Init_GPIO
	__end_of_Init_GPIO:
	signat	_Init_GPIO,89
	global	_GsensorLoop

;; *************** function _GsensorLoop *****************
;; Defined at:
;;		line 19 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\sensor.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_SensorControl
;;		_SensorJudge
;;		_SensorKey
;;		_SensorTime
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text5,local,class=CODE,delta=2,merge=1,group=0
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\sensor.c"
	line	19
global __ptext5
__ptext5:	;psect for function _GsensorLoop
psect	text5
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\sensor.c"
	line	19
	global	__size_of_GsensorLoop
	__size_of_GsensorLoop	equ	__end_of_GsensorLoop-_GsensorLoop
	
_GsensorLoop:	
;incstack = 0
	opt	stack 4
; Regs used in _GsensorLoop: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	21
	
l5974:	
;sensor.c: 21: SensorKey();
	fcall	_SensorKey
	line	22
	
l5976:	
;sensor.c: 22: SensorTime();
	fcall	_SensorTime
	line	23
	
l5978:	
;sensor.c: 23: SensorJudge();
	fcall	_SensorJudge
	line	24
	
l5980:	
;sensor.c: 24: SensorControl();
	fcall	_SensorControl
	line	25
	
l3841:	
	return
	opt stack 0
GLOBAL	__end_of_GsensorLoop
	__end_of_GsensorLoop:
	signat	_GsensorLoop,89
	global	_SensorTime

;; *************** function _SensorTime *****************
;; Defined at:
;;		line 33 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\sensor.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_GsensorLoop
;; This function uses a non-reentrant model
;;
psect	text6,local,class=CODE,delta=2,merge=1,group=0
	line	33
global __ptext6
__ptext6:	;psect for function _SensorTime
psect	text6
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\sensor.c"
	line	33
	global	__size_of_SensorTime
	__size_of_SensorTime	equ	__end_of_SensorTime-_SensorTime
	
_SensorTime:	
;incstack = 0
	opt	stack 4
; Regs used in _SensorTime: [wreg+status,2+status,0]
	line	35
	
l5812:	
;sensor.c: 35: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u1131
	goto	u1130
u1131:
	goto	l5832
u1130:
	line	37
	
l5814:	
;sensor.c: 36: {
;sensor.c: 37: Fbodysensor.bits.bit_5 = 0;
	bcf	(_Fbodysensor),5	;volatile
	line	38
	
l5816:	
;sensor.c: 38: CNTbodyExitTime = 0;
	clrf	(_CNTbodyExitTime)	;volatile
	clrf	(_CNTbodyExitTime+1)	;volatile
	line	39
	
l5818:	
;sensor.c: 39: if(FledBits01.bits.bit_2 == 0)
	btfsc	(_FledBits01),2	;volatile
	goto	u1141
	goto	u1140
u1141:
	goto	l3848
u1140:
	line	41
	
l5820:	
;sensor.c: 40: {
;sensor.c: 41: if(++CNTbodyInTime >= 6000)
	incf	(_CNTbodyInTime),f	;volatile
	skipnz
	incf	(_CNTbodyInTime+1),f	;volatile
	movlw	017h
	subwf	((_CNTbodyInTime+1)),w	;volatile
	movlw	070h
	skipnz
	subwf	((_CNTbodyInTime)),w	;volatile
	skipc
	goto	u1151
	goto	u1150
u1151:
	goto	l5826
u1150:
	line	43
	
l5822:	
;sensor.c: 42: {
;sensor.c: 43: CNTbodyInTime = 6000;
	movlw	070h
	movwf	(_CNTbodyInTime)	;volatile
	movlw	017h
	movwf	((_CNTbodyInTime))+1	;volatile
	line	44
	
l5824:	
;sensor.c: 44: Fbodysensor.bits.bit_3 = 1;
	bsf	(_Fbodysensor),3	;volatile
	line	45
;sensor.c: 45: }
	goto	l3856
	line	46
	
l5826:	
;sensor.c: 46: else if(CNTbodyInTime >= 500)
	movlw	01h
	subwf	(_CNTbodyInTime+1),w	;volatile
	movlw	0F4h
	skipnz
	subwf	(_CNTbodyInTime),w	;volatile
	skipc
	goto	u1161
	goto	u1160
u1161:
	goto	l3852
u1160:
	line	48
	
l5828:	
;sensor.c: 47: {
;sensor.c: 48: Fbodysensor.bits.bit_4 = 1;
	bsf	(_Fbodysensor),4	;volatile
	goto	l3856
	line	51
	
l3848:	
	line	53
;sensor.c: 51: else
;sensor.c: 52: {
;sensor.c: 53: if(Fbodysensor.bits.bit_4 == 0)
	btfsc	(_Fbodysensor),4	;volatile
	goto	u1171
	goto	u1170
u1171:
	goto	l3856
u1170:
	line	55
	
l5830:	
;sensor.c: 54: {
;sensor.c: 55: CNTbodyInTime = 0;
	clrf	(_CNTbodyInTime)	;volatile
	clrf	(_CNTbodyInTime+1)	;volatile
	goto	l3856
	line	57
	
l3852:	
	line	58
;sensor.c: 56: }
;sensor.c: 57: }
;sensor.c: 58: }
	goto	l3856
	line	61
	
l5832:	
;sensor.c: 59: else
;sensor.c: 60: {
;sensor.c: 61: CNTbodyInTime = 0;
	clrf	(_CNTbodyInTime)	;volatile
	clrf	(_CNTbodyInTime+1)	;volatile
	line	62
	
l5834:	
;sensor.c: 62: Fbodysensor.bits.bit_4 = 0;
	bcf	(_Fbodysensor),4	;volatile
	line	63
	
l5836:	
;sensor.c: 63: Fbodysensor.bits.bit_3 = 0;
	bcf	(_Fbodysensor),3	;volatile
	line	64
	
l5838:	
;sensor.c: 64: if(++CNTbodyExitTime >= 500)
	incf	(_CNTbodyExitTime),f	;volatile
	skipnz
	incf	(_CNTbodyExitTime+1),f	;volatile
	movlw	01h
	subwf	((_CNTbodyExitTime+1)),w	;volatile
	movlw	0F4h
	skipnz
	subwf	((_CNTbodyExitTime)),w	;volatile
	skipc
	goto	u1181
	goto	u1180
u1181:
	goto	l3856
u1180:
	line	66
	
l5840:	
;sensor.c: 65: {
;sensor.c: 66: CNTbodyExitTime = 500;
	movlw	0F4h
	movwf	(_CNTbodyExitTime)	;volatile
	movlw	01h
	movwf	((_CNTbodyExitTime))+1	;volatile
	line	67
	
l5842:	
;sensor.c: 67: Fbodysensor.bits.bit_5 = 1;
	bsf	(_Fbodysensor),5	;volatile
	line	70
	
l3856:	
	return
	opt stack 0
GLOBAL	__end_of_SensorTime
	__end_of_SensorTime:
	signat	_SensorTime,89
	global	_SensorKey

;; *************** function _SensorKey *****************
;; Defined at:
;;		line 27 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\sensor.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 300/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_GsensorLoop
;; This function uses a non-reentrant model
;;
psect	text7,local,class=CODE,delta=2,merge=1,group=0
	line	27
global __ptext7
__ptext7:	;psect for function _SensorKey
psect	text7
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\sensor.c"
	line	27
	global	__size_of_SensorKey
	__size_of_SensorKey	equ	__end_of_SensorKey-_SensorKey
	
_SensorKey:	
;incstack = 0
	opt	stack 4
; Regs used in _SensorKey: []
	line	30
	
l3844:	
	return
	opt stack 0
GLOBAL	__end_of_SensorKey
	__end_of_SensorKey:
	signat	_SensorKey,89
	global	_SensorJudge

;; *************** function _SensorJudge *****************
;; Defined at:
;;		line 73 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\sensor.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_GsensorLoop
;; This function uses a non-reentrant model
;;
psect	text8,local,class=CODE,delta=2,merge=1,group=0
	line	73
global __ptext8
__ptext8:	;psect for function _SensorJudge
psect	text8
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\sensor.c"
	line	73
	global	__size_of_SensorJudge
	__size_of_SensorJudge	equ	__end_of_SensorJudge-_SensorJudge
	
_SensorJudge:	
;incstack = 0
	opt	stack 4
; Regs used in _SensorJudge: [wreg-fsr0h+status,2+status,0]
	line	75
	
l5844:	
;sensor.c: 75: switch (SEQbody)
	goto	l5896
	line	77
;sensor.c: 76: {
;sensor.c: 77: case 0:
	
l3860:	
	line	78
;sensor.c: 78: Fbodysensor.bits.bit_0 = 0;
	bcf	(_Fbodysensor),0	;volatile
	line	79
;sensor.c: 79: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	80
	
l5846:	
;sensor.c: 80: SEQbody = 1;
	movlw	low(01h)
	movwf	(_SEQbody)	;volatile
	line	81
;sensor.c: 81: break;
	goto	l3881
	line	84
;sensor.c: 84: case 1:
	
l3862:	
	line	85
;sensor.c: 85: Fbodysensor.bits.bit_0 = 0;
	bcf	(_Fbodysensor),0	;volatile
	line	86
;sensor.c: 86: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	87
;sensor.c: 87: if(RB1 == 0)
	btfsc	(49/8),(49)&7	;volatile
	goto	u1191
	goto	u1190
u1191:
	goto	l5854
u1190:
	line	89
	
l5848:	
;sensor.c: 88: {
;sensor.c: 89: if(++CNTbody_h >= 3)
	incf	(_CNTbody_h),f	;volatile
	skipnz
	incf	(_CNTbody_h+1),f	;volatile
	movlw	0
	subwf	((_CNTbody_h+1)),w	;volatile
	movlw	03h
	skipnz
	subwf	((_CNTbody_h)),w	;volatile
	skipc
	goto	u1201
	goto	u1200
u1201:
	goto	l3881
u1200:
	line	91
	
l5850:	
;sensor.c: 90: {
;sensor.c: 91: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	line	92
;sensor.c: 92: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	line	93
	
l5852:	
;sensor.c: 93: SEQbody = 2;
	movlw	low(02h)
	movwf	(_SEQbody)	;volatile
	line	94
;sensor.c: 94: break;
	goto	l3881
	line	99
	
l5854:	
;sensor.c: 97: else
;sensor.c: 98: {
;sensor.c: 99: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	goto	l3881
	line	104
;sensor.c: 104: case 2:
	
l3866:	
	line	105
;sensor.c: 105: Fbodysensor.bits.bit_0 = 0;
	bcf	(_Fbodysensor),0	;volatile
	line	106
;sensor.c: 106: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	107
;sensor.c: 107: if(RB1 == 0)
	btfsc	(49/8),(49)&7	;volatile
	goto	u1211
	goto	u1210
u1211:
	goto	l5858
u1210:
	line	109
	
l5856:	
;sensor.c: 108: {
;sensor.c: 109: ++CNTbody_h;
	incf	(_CNTbody_h),f	;volatile
	skipnz
	incf	(_CNTbody_h+1),f	;volatile
	line	110
;sensor.c: 110: }
	goto	l5864
	line	113
	
l5858:	
;sensor.c: 111: else
;sensor.c: 112: {
;sensor.c: 113: if(++CNTbody_l >= 6)
	incf	(_CNTbody_l),f	;volatile
	skipnz
	incf	(_CNTbody_l+1),f	;volatile
	movlw	0
	subwf	((_CNTbody_l+1)),w	;volatile
	movlw	06h
	skipnz
	subwf	((_CNTbody_l)),w	;volatile
	skipc
	goto	u1221
	goto	u1220
u1221:
	goto	l5864
u1220:
	line	115
	
l5860:	
;sensor.c: 114: {
;sensor.c: 115: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	line	116
;sensor.c: 116: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	goto	l5846
	line	121
	
l5864:	
;sensor.c: 119: }
;sensor.c: 120: }
;sensor.c: 121: BufCntAdd = CNTbody_h +CNTbody_l;
	movf	(_CNTbody_l),w	;volatile
	addwf	(_CNTbody_h),w	;volatile
	movwf	(_BufCntAdd)	;volatile
	movf	(_CNTbody_l+1),w	;volatile
	skipnc
	incf	(_CNTbody_l+1),w	;volatile
	addwf	(_CNTbody_h+1),w	;volatile
	movwf	1+(_BufCntAdd)	;volatile
	line	122
	
l5866:	
;sensor.c: 122: if(BufCntAdd >= 30)
	movlw	0
	subwf	(_BufCntAdd+1),w	;volatile
	movlw	01Eh
	skipnz
	subwf	(_BufCntAdd),w	;volatile
	skipc
	goto	u1231
	goto	u1230
u1231:
	goto	l3881
u1230:
	line	124
	
l5868:	
;sensor.c: 123: {
;sensor.c: 124: SEQbody = 3;
	movlw	low(03h)
	movwf	(_SEQbody)	;volatile
	line	125
;sensor.c: 125: break;
	goto	l3881
	line	129
;sensor.c: 129: case 3:
	
l3871:	
	line	130
;sensor.c: 130: Fbodysensor.bits.bit_0 = 1;
	bsf	(_Fbodysensor),0	;volatile
	line	131
;sensor.c: 131: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	132
;sensor.c: 132: if(RB1 == 1)
	btfss	(49/8),(49)&7	;volatile
	goto	u1241
	goto	u1240
u1241:
	goto	l5876
u1240:
	line	134
	
l5870:	
;sensor.c: 133: {
;sensor.c: 134: if(++CNTbody_l >= 3)
	incf	(_CNTbody_l),f	;volatile
	skipnz
	incf	(_CNTbody_l+1),f	;volatile
	movlw	0
	subwf	((_CNTbody_l+1)),w	;volatile
	movlw	03h
	skipnz
	subwf	((_CNTbody_l)),w	;volatile
	skipc
	goto	u1251
	goto	u1250
u1251:
	goto	l3881
u1250:
	line	136
	
l5872:	
;sensor.c: 135: {
;sensor.c: 136: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	line	137
;sensor.c: 137: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	line	138
	
l5874:	
;sensor.c: 138: SEQbody = 4;
	movlw	low(04h)
	movwf	(_SEQbody)	;volatile
	line	139
;sensor.c: 139: break;
	goto	l3881
	line	144
	
l5876:	
;sensor.c: 142: else
;sensor.c: 143: {
;sensor.c: 144: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	goto	l3881
	line	148
;sensor.c: 148: case 4:
	
l3875:	
	line	149
;sensor.c: 149: Fbodysensor.bits.bit_0 = 1;
	bsf	(_Fbodysensor),0	;volatile
	line	150
;sensor.c: 150: FledBits01.bits.bit_2 = 1;
	bsf	(_FledBits01),2	;volatile
	line	151
;sensor.c: 151: if(RB1 == 0)
	btfsc	(49/8),(49)&7	;volatile
	goto	u1261
	goto	u1260
u1261:
	goto	l5884
u1260:
	line	153
	
l5878:	
;sensor.c: 152: {
;sensor.c: 153: if(++CNTbody_h >= 6)
	incf	(_CNTbody_h),f	;volatile
	skipnz
	incf	(_CNTbody_h+1),f	;volatile
	movlw	0
	subwf	((_CNTbody_h+1)),w	;volatile
	movlw	06h
	skipnz
	subwf	((_CNTbody_h)),w	;volatile
	skipc
	goto	u1271
	goto	u1270
u1271:
	goto	l5886
u1270:
	line	155
	
l5880:	
;sensor.c: 154: {
;sensor.c: 155: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	line	156
;sensor.c: 156: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	goto	l5868
	line	163
	
l5884:	
;sensor.c: 161: else
;sensor.c: 162: {
;sensor.c: 163: ++CNTbody_l;
	incf	(_CNTbody_l),f	;volatile
	skipnz
	incf	(_CNTbody_l+1),f	;volatile
	line	165
	
l5886:	
;sensor.c: 164: }
;sensor.c: 165: BufCntAdd = CNTbody_h +CNTbody_l;
	movf	(_CNTbody_l),w	;volatile
	addwf	(_CNTbody_h),w	;volatile
	movwf	(_BufCntAdd)	;volatile
	movf	(_CNTbody_l+1),w	;volatile
	skipnc
	incf	(_CNTbody_l+1),w	;volatile
	addwf	(_CNTbody_h+1),w	;volatile
	movwf	1+(_BufCntAdd)	;volatile
	line	166
;sensor.c: 166: if(BufCntAdd >= 500)
	movlw	01h
	subwf	(_BufCntAdd+1),w	;volatile
	movlw	0F4h
	skipnz
	subwf	(_BufCntAdd),w	;volatile
	skipc
	goto	u1281
	goto	u1280
u1281:
	goto	l3881
u1280:
	goto	l5846
	line	173
	
l5890:	
;sensor.c: 173: SEQbody = 0;
	clrf	(_SEQbody)	;volatile
	line	174
	
l5892:	
;sensor.c: 174: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	175
;sensor.c: 175: break;
	goto	l3881
	line	75
	
l5896:	
	movf	(_SEQbody),w	;volatile
	; Switch size 1, requested type "space"
; Number of cases is 5, Range of values is 0 to 4
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           16     9 (average)
; direct_byte           23     8 (fixed)
; jumptable            260     6 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_push
	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l3860
	xorlw	1^0	; case 1
	skipnz
	goto	l3862
	xorlw	2^1	; case 2
	skipnz
	goto	l3866
	xorlw	3^2	; case 3
	skipnz
	goto	l3871
	xorlw	4^3	; case 4
	skipnz
	goto	l3875
	goto	l5890
	opt asmopt_pop

	line	177
	
l3881:	
	return
	opt stack 0
GLOBAL	__end_of_SensorJudge
	__end_of_SensorJudge:
	signat	_SensorJudge,89
	global	_SensorControl

;; *************** function _SensorControl *****************
;; Defined at:
;;		line 179 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\sensor.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_GsensorLoop
;; This function uses a non-reentrant model
;;
psect	text9,local,class=CODE,delta=2,merge=1,group=0
	line	179
global __ptext9
__ptext9:	;psect for function _SensorControl
psect	text9
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\sensor.c"
	line	179
	global	__size_of_SensorControl
	__size_of_SensorControl	equ	__end_of_SensorControl-_SensorControl
	
_SensorControl:	
;incstack = 0
	opt	stack 4
; Regs used in _SensorControl: [wreg]
	line	181
	
l5898:	
;sensor.c: 181: Fbodysensor.bits.bit_1 = 0;
	bcf	(_Fbodysensor),1	;volatile
	line	182
;sensor.c: 182: Fbodysensor.bits.bit_2 = 0;
	bcf	(_Fbodysensor),2	;volatile
	line	183
	
l5900:	
;sensor.c: 183: if(Fbodysensor.bits.bit_6 != Fbodysensor.bits.bit_0)
	btfsc	(_Fbodysensor),0	;volatile
	goto	u1291
	goto	u1290
u1291:
	movlw	1
	goto	u1292
u1290:
	movlw	0
u1292:
	movwf	(??_SensorControl+0)+0
	btfsc	(_Fbodysensor),6	;volatile
	goto	u1301
	goto	u1300
u1301:
	movlw	1
	goto	u1302
u1300:
	movlw	0
u1302:
	xorwf	(??_SensorControl+0)+0,w
	skipnz
	goto	u1311
	goto	u1310
u1311:
	goto	l3887
u1310:
	line	185
	
l5902:	
;sensor.c: 184: {
;sensor.c: 185: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u1321
	goto	u1320
u1321:
	goto	l3885
u1320:
	line	187
	
l5904:	
;sensor.c: 186: {
;sensor.c: 187: Fbodysensor.bits.bit_1 = 1;
	bsf	(_Fbodysensor),1	;volatile
	line	188
;sensor.c: 188: }
	goto	l3886
	line	189
	
l3885:	
	line	191
;sensor.c: 189: else
;sensor.c: 190: {
;sensor.c: 191: Fbodysensor.bits.bit_2 = 1;
	bsf	(_Fbodysensor),2	;volatile
	line	192
	
l3886:	
	line	193
;sensor.c: 192: }
;sensor.c: 193: Fbodysensor.bits.bit_6 = Fbodysensor.bits.bit_0;
	btfsc	(_Fbodysensor),0	;volatile
	goto	u1331
	goto	u1330
	
u1331:
	bsf	(_Fbodysensor),6	;volatile
	goto	u1344
u1330:
	bcf	(_Fbodysensor),6	;volatile
u1344:
	line	195
	
l3887:	
	return
	opt stack 0
GLOBAL	__end_of_SensorControl
	__end_of_SensorControl:
	signat	_SensorControl,89
	global	_GledLoop

;; *************** function _GledLoop *****************
;; Defined at:
;;		line 16 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_LED_Con
;;		_LED_Judge
;;		_LED_Key
;;		_LED_Time
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text10,local,class=CODE,delta=2,merge=1,group=0
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
	line	16
global __ptext10
__ptext10:	;psect for function _GledLoop
psect	text10
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
	line	16
	global	__size_of_GledLoop
	__size_of_GledLoop	equ	__end_of_GledLoop-_GledLoop
	
_GledLoop:	
;incstack = 0
	opt	stack 4
; Regs used in _GledLoop: [wreg+status,2+status,0+pclath+cstack]
	line	18
	
l5906:	
;light.c: 18: LED_Time();
	fcall	_LED_Time
	line	19
;light.c: 19: LED_Key();
	fcall	_LED_Key
	line	20
;light.c: 20: LED_Judge();
	fcall	_LED_Judge
	line	21
	
l5908:	
;light.c: 21: LED_Con();
	fcall	_LED_Con
	line	22
	
l911:	
	return
	opt stack 0
GLOBAL	__end_of_GledLoop
	__end_of_GledLoop:
	signat	_GledLoop,89
	global	_LED_Time

;; *************** function _LED_Time *****************
;; Defined at:
;;		line 45 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_GledLoop
;; This function uses a non-reentrant model
;;
psect	text11,local,class=CODE,delta=2,merge=1,group=0
	line	45
global __ptext11
__ptext11:	;psect for function _LED_Time
psect	text11
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
	line	45
	global	__size_of_LED_Time
	__size_of_LED_Time	equ	__end_of_LED_Time-_LED_Time
	
_LED_Time:	
;incstack = 0
	opt	stack 4
; Regs used in _LED_Time: []
	line	47
	
l5608:	
;light.c: 47: if(Fsys1m.bits.bit_0 == 1)
	btfss	(_Fsys1m),0	;volatile
	goto	u661
	goto	u660
u661:
	goto	l918
u660:
	line	49
	
l5610:	
;light.c: 48: {
;light.c: 49: Fsys1m.bits.bit_0 = 0;
	bcf	(_Fsys1m),0	;volatile
	line	51
	
l918:	
	return
	opt stack 0
GLOBAL	__end_of_LED_Time
	__end_of_LED_Time:
	signat	_LED_Time,89
	global	_LED_Key

;; *************** function _LED_Key *****************
;; Defined at:
;;		line 24 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 300/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_GledLoop
;; This function uses a non-reentrant model
;;
psect	text12,local,class=CODE,delta=2,merge=1,group=0
	line	24
global __ptext12
__ptext12:	;psect for function _LED_Key
psect	text12
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
	line	24
	global	__size_of_LED_Key
	__size_of_LED_Key	equ	__end_of_LED_Key-_LED_Key
	
_LED_Key:	
;incstack = 0
	opt	stack 4
; Regs used in _LED_Key: []
	line	43
	
l914:	
	return
	opt stack 0
GLOBAL	__end_of_LED_Key
	__end_of_LED_Key:
	signat	_LED_Key,89
	global	_LED_Judge

;; *************** function _LED_Judge *****************
;; Defined at:
;;		line 53 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 300/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_GledLoop
;; This function uses a non-reentrant model
;;
psect	text13,local,class=CODE,delta=2,merge=1,group=0
	line	53
global __ptext13
__ptext13:	;psect for function _LED_Judge
psect	text13
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
	line	53
	global	__size_of_LED_Judge
	__size_of_LED_Judge	equ	__end_of_LED_Judge-_LED_Judge
	
_LED_Judge:	
;incstack = 0
	opt	stack 4
; Regs used in _LED_Judge: []
	line	55
	
l5612:	
;light.c: 55: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u671
	goto	u670
u671:
	goto	l5618
u670:
	line	57
	
l5614:	
;light.c: 56: {
;light.c: 57: FledBits01.bits.bit_0 = 1;
	bsf	(_FledBits01),0	;volatile
	line	58
;light.c: 58: if(Fbodysensor.bits.bit_4 == 0)
	btfsc	(_Fbodysensor),4	;volatile
	goto	u681
	goto	u680
u681:
	goto	l925
u680:
	line	60
	
l5616:	
;light.c: 59: {
;light.c: 60: if(FledBits01.bits.bit_2 == 1)
	btfss	(_FledBits01),2	;volatile
	goto	u691
	goto	u690
u691:
	goto	l925
u690:
	line	62
	
l5618:	
;light.c: 61: {
;light.c: 62: FledBits01.bits.bit_0 = 0;
	bcf	(_FledBits01),0	;volatile
	line	82
	
l925:	
	return
	opt stack 0
GLOBAL	__end_of_LED_Judge
	__end_of_LED_Judge:
	signat	_LED_Judge,89
	global	_LED_Con

;; *************** function _LED_Con *****************
;; Defined at:
;;		line 84 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_GledLoop
;; This function uses a non-reentrant model
;;
psect	text14,local,class=CODE,delta=2,merge=1,group=0
	line	84
global __ptext14
__ptext14:	;psect for function _LED_Con
psect	text14
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
	line	84
	global	__size_of_LED_Con
	__size_of_LED_Con	equ	__end_of_LED_Con-_LED_Con
	
_LED_Con:	
;incstack = 0
	opt	stack 4
; Regs used in _LED_Con: [wreg+status,2+status,0]
	line	88
	
l5620:	
;light.c: 88: if (FledBits01.bits.bit_0 == 1)
	btfss	(_FledBits01),0	;volatile
	goto	u701
	goto	u700
u701:
	goto	l5708
u700:
	line	90
	
l5622:	
;light.c: 89: {
;light.c: 90: if (FledBits01.bits.bit_3 == 0)
	btfsc	(_FledBits01),3	;volatile
	goto	u711
	goto	u710
u711:
	goto	l5664
u710:
	line	92
	
l5624:	
;light.c: 91: {
;light.c: 92: if (CNTbreath_Led2 >= 80)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	050h
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipc
	goto	u721
	goto	u720
u721:
	goto	l5634
u720:
	line	94
	
l5626:	
;light.c: 93: {
;light.c: 94: CNTbreath_Led2 = 80;
	movlw	050h
	movwf	(_CNTbreath_Led2)	;volatile
	clrf	(_CNTbreath_Led2+1)	;volatile
	line	95
	
l5628:	
;light.c: 95: if (++CNTbreath_Led3 > 10)
	incf	(_CNTbreath_Led3),f	;volatile
	skipnz
	incf	(_CNTbreath_Led3+1),f	;volatile
	movlw	0
	subwf	((_CNTbreath_Led3+1)),w	;volatile
	movlw	0Bh
	skipnz
	subwf	((_CNTbreath_Led3)),w	;volatile
	skipc
	goto	u731
	goto	u730
u731:
	goto	l960
u730:
	line	97
	
l5630:	
;light.c: 96: {
;light.c: 97: FledBits01.bits.bit_3 = 1;
	bsf	(_FledBits01),3	;volatile
	line	98
	
l5632:	
;light.c: 98: CNTbreath_Led3 = 0;
	clrf	(_CNTbreath_Led3)	;volatile
	clrf	(_CNTbreath_Led3+1)	;volatile
	goto	l960
	line	101
	
l5634:	
;light.c: 101: else if (CNTbreath_Led2 > 45)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	02Eh
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipc
	goto	u741
	goto	u740
u741:
	goto	l5642
u740:
	line	103
	
l5636:	
;light.c: 102: {
;light.c: 103: if (++CNTbreath_Led1 >= 3)
	incf	(_CNTbreath_Led1),f	;volatile
	skipnz
	incf	(_CNTbreath_Led1+1),f	;volatile
	movlw	0
	subwf	((_CNTbreath_Led1+1)),w	;volatile
	movlw	03h
	skipnz
	subwf	((_CNTbreath_Led1)),w	;volatile
	skipc
	goto	u751
	goto	u750
u751:
	goto	l960
u750:
	line	105
	
l5638:	
;light.c: 104: {
;light.c: 105: CNTbreath_Led1 = 0;
	clrf	(_CNTbreath_Led1)	;volatile
	clrf	(_CNTbreath_Led1+1)	;volatile
	line	106
	
l5640:	
;light.c: 106: CNTbreath_Led2++;
	incf	(_CNTbreath_Led2),f	;volatile
	skipnz
	incf	(_CNTbreath_Led2+1),f	;volatile
	goto	l960
	line	109
	
l5642:	
;light.c: 109: else if (CNTbreath_Led2 > 30)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	01Fh
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipc
	goto	u761
	goto	u760
u761:
	goto	l5650
u760:
	line	111
	
l5644:	
;light.c: 110: {
;light.c: 111: if (++CNTbreath_Led1 >= 8)
	incf	(_CNTbreath_Led1),f	;volatile
	skipnz
	incf	(_CNTbreath_Led1+1),f	;volatile
	movlw	0
	subwf	((_CNTbreath_Led1+1)),w	;volatile
	movlw	08h
	skipnz
	subwf	((_CNTbreath_Led1)),w	;volatile
	skipc
	goto	u771
	goto	u770
u771:
	goto	l960
u770:
	goto	l5638
	line	117
	
l5650:	
;light.c: 117: else if (CNTbreath_Led2 > 10)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	0Bh
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipc
	goto	u781
	goto	u780
u781:
	goto	l5658
u780:
	line	119
	
l5652:	
;light.c: 118: {
;light.c: 119: if (++CNTbreath_Led1 >= 5)
	incf	(_CNTbreath_Led1),f	;volatile
	skipnz
	incf	(_CNTbreath_Led1+1),f	;volatile
	movlw	0
	subwf	((_CNTbreath_Led1+1)),w	;volatile
	movlw	05h
	skipnz
	subwf	((_CNTbreath_Led1)),w	;volatile
	skipc
	goto	u791
	goto	u790
u791:
	goto	l932
u790:
	goto	l5638
	line	127
	
l5658:	
;light.c: 125: else
;light.c: 126: {
;light.c: 127: if (++CNTbreath_Led1 >= 11)
	incf	(_CNTbreath_Led1),f	;volatile
	skipnz
	incf	(_CNTbreath_Led1+1),f	;volatile
	movlw	0
	subwf	((_CNTbreath_Led1+1)),w	;volatile
	movlw	0Bh
	skipnz
	subwf	((_CNTbreath_Led1)),w	;volatile
	skipc
	goto	u801
	goto	u800
u801:
	goto	l932
u800:
	goto	l5638
	line	132
	
l932:	
	line	133
;light.c: 131: }
;light.c: 132: }
;light.c: 133: }
	goto	l960
	line	136
	
l5664:	
;light.c: 134: else
;light.c: 135: {
;light.c: 136: if (CNTbreath_Led2 < 5)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	05h
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u811
	goto	u810
u811:
	goto	l5670
u810:
	line	138
	
l5666:	
;light.c: 137: {
;light.c: 138: CNTbreath_Led2 = 5;
	movlw	05h
	movwf	(_CNTbreath_Led2)	;volatile
	clrf	(_CNTbreath_Led2+1)	;volatile
	line	139
	
l5668:	
;light.c: 139: FledBits01.bits.bit_3 = 0;
	bcf	(_FledBits01),3	;volatile
	line	140
;light.c: 140: }
	goto	l960
	line	141
	
l5670:	
;light.c: 141: else if (CNTbreath_Led2 < 10)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	0Ah
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u821
	goto	u820
u821:
	goto	l5678
u820:
	line	143
	
l5672:	
;light.c: 142: {
;light.c: 143: if (++CNTbreath_Led1 >= 6)
	incf	(_CNTbreath_Led1),f	;volatile
	skipnz
	incf	(_CNTbreath_Led1+1),f	;volatile
	movlw	0
	subwf	((_CNTbreath_Led1+1)),w	;volatile
	movlw	06h
	skipnz
	subwf	((_CNTbreath_Led1)),w	;volatile
	skipc
	goto	u831
	goto	u830
u831:
	goto	l960
u830:
	line	145
	
l5674:	
;light.c: 144: {
;light.c: 145: CNTbreath_Led1 = 0;
	clrf	(_CNTbreath_Led1)	;volatile
	clrf	(_CNTbreath_Led1+1)	;volatile
	line	146
	
l5676:	
;light.c: 146: CNTbreath_Led2--;
	movlw	01h
	subwf	(_CNTbreath_Led2),f	;volatile
	movlw	0
	skipc
	decf	(_CNTbreath_Led2+1),f	;volatile
	subwf	(_CNTbreath_Led2+1),f	;volatile
	goto	l960
	line	149
	
l5678:	
;light.c: 149: else if (CNTbreath_Led2 < 40)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	028h
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u841
	goto	u840
u841:
	goto	l5686
u840:
	line	151
	
l5680:	
;light.c: 150: {
;light.c: 151: if (++CNTbreath_Led1 >= 6)
	incf	(_CNTbreath_Led1),f	;volatile
	skipnz
	incf	(_CNTbreath_Led1+1),f	;volatile
	movlw	0
	subwf	((_CNTbreath_Led1+1)),w	;volatile
	movlw	06h
	skipnz
	subwf	((_CNTbreath_Led1)),w	;volatile
	skipc
	goto	u851
	goto	u850
u851:
	goto	l960
u850:
	goto	l5674
	line	157
	
l5686:	
;light.c: 157: else if (CNTbreath_Led2 < 60)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	03Ch
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u861
	goto	u860
u861:
	goto	l5694
u860:
	line	159
	
l5688:	
;light.c: 158: {
;light.c: 159: if (++CNTbreath_Led1 >= 8)
	incf	(_CNTbreath_Led1),f	;volatile
	skipnz
	incf	(_CNTbreath_Led1+1),f	;volatile
	movlw	0
	subwf	((_CNTbreath_Led1+1)),w	;volatile
	movlw	08h
	skipnz
	subwf	((_CNTbreath_Led1)),w	;volatile
	skipc
	goto	u871
	goto	u870
u871:
	goto	l960
u870:
	goto	l5674
	line	165
	
l5694:	
;light.c: 165: else if (CNTbreath_Led2 < 70)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	046h
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u881
	goto	u880
u881:
	goto	l5702
u880:
	line	167
	
l5696:	
;light.c: 166: {
;light.c: 167: if (++CNTbreath_Led1 >= 4)
	incf	(_CNTbreath_Led1),f	;volatile
	skipnz
	incf	(_CNTbreath_Led1+1),f	;volatile
	movlw	0
	subwf	((_CNTbreath_Led1+1)),w	;volatile
	movlw	04h
	skipnz
	subwf	((_CNTbreath_Led1)),w	;volatile
	skipc
	goto	u891
	goto	u890
u891:
	goto	l932
u890:
	goto	l5674
	line	175
	
l5702:	
;light.c: 173: else
;light.c: 174: {
;light.c: 175: if (++CNTbreath_Led1 >= 3)
	incf	(_CNTbreath_Led1),f	;volatile
	skipnz
	incf	(_CNTbreath_Led1+1),f	;volatile
	movlw	0
	subwf	((_CNTbreath_Led1+1)),w	;volatile
	movlw	03h
	skipnz
	subwf	((_CNTbreath_Led1)),w	;volatile
	skipc
	goto	u901
	goto	u900
u901:
	goto	l932
u900:
	goto	l5674
	line	185
	
l5708:	
;light.c: 183: else
;light.c: 184: {
;light.c: 185: CNTbreath_Led1 = 0;
	clrf	(_CNTbreath_Led1)	;volatile
	clrf	(_CNTbreath_Led1+1)	;volatile
	line	186
;light.c: 186: CNTbreath_Led2 = 0;
	clrf	(_CNTbreath_Led2)	;volatile
	clrf	(_CNTbreath_Led2+1)	;volatile
	line	187
;light.c: 187: CNTbreath_Led3 = 0;
	clrf	(_CNTbreath_Led3)	;volatile
	clrf	(_CNTbreath_Led3+1)	;volatile
	goto	l5668
	line	190
	
l960:	
	return
	opt stack 0
GLOBAL	__end_of_LED_Con
	__end_of_LED_Con:
	signat	_LED_Con,89
	global	_GflushLoop

;; *************** function _GflushLoop *****************
;; Defined at:
;;		line 28 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\flush.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_FlushCon
;;		_FlushJudge
;;		_FlushTime
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text15,local,class=CODE,delta=2,merge=1,group=0
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\flush.c"
	line	28
global __ptext15
__ptext15:	;psect for function _GflushLoop
psect	text15
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\flush.c"
	line	28
	global	__size_of_GflushLoop
	__size_of_GflushLoop	equ	__end_of_GflushLoop-_GflushLoop
	
_GflushLoop:	
;incstack = 0
	opt	stack 4
; Regs used in _GflushLoop: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	30
	
l5982:	
;flush.c: 30: FlushTime();
	fcall	_FlushTime
	line	31
;flush.c: 31: FlushJudge();
	fcall	_FlushJudge
	line	32
	
l5984:	
;flush.c: 32: FlushCon();
	fcall	_FlushCon
	line	33
	
l2876:	
	return
	opt stack 0
GLOBAL	__end_of_GflushLoop
	__end_of_GflushLoop:
	signat	_GflushLoop,89
	global	_FlushTime

;; *************** function _FlushTime *****************
;; Defined at:
;;		line 35 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\flush.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 300/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_GflushLoop
;; This function uses a non-reentrant model
;;
psect	text16,local,class=CODE,delta=2,merge=1,group=0
	line	35
global __ptext16
__ptext16:	;psect for function _FlushTime
psect	text16
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\flush.c"
	line	35
	global	__size_of_FlushTime
	__size_of_FlushTime	equ	__end_of_FlushTime-_FlushTime
	
_FlushTime:	
;incstack = 0
	opt	stack 4
; Regs used in _FlushTime: []
	line	38
	
l2879:	
	return
	opt stack 0
GLOBAL	__end_of_FlushTime
	__end_of_FlushTime:
	signat	_FlushTime,89
	global	_FlushJudge

;; *************** function _FlushJudge *****************
;; Defined at:
;;		line 39 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\flush.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 300/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_GflushLoop
;; This function uses a non-reentrant model
;;
psect	text17,local,class=CODE,delta=2,merge=1,group=0
	line	39
global __ptext17
__ptext17:	;psect for function _FlushJudge
psect	text17
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\flush.c"
	line	39
	global	__size_of_FlushJudge
	__size_of_FlushJudge	equ	__end_of_FlushJudge-_FlushJudge
	
_FlushJudge:	
;incstack = 0
	opt	stack 4
; Regs used in _FlushJudge: []
	line	43
	
l5716:	
;flush.c: 43: if(Fbodysensor.bits.bit_3 == 1)
	btfss	(_Fbodysensor),3	;volatile
	goto	u921
	goto	u920
u921:
	goto	l2882
u920:
	line	45
	
l5718:	
;flush.c: 44: {
;flush.c: 45: Fflush1.bits.bit_0 = 1;
	bsf	(_Fflush1),0	;volatile
	line	46
;flush.c: 46: Fflush1.bits.bit_2 = 0;
	bcf	(_Fflush1),2	;volatile
	line	47
;flush.c: 47: }
	goto	l2883
	line	48
	
l2882:	
;flush.c: 48: else if(Fbodysensor.bits.bit_4 == 1)
	btfss	(_Fbodysensor),4	;volatile
	goto	u931
	goto	u930
u931:
	goto	l2884
u930:
	line	50
	
l5720:	
;flush.c: 49: {
;flush.c: 50: Fflush1.bits.bit_2 = 1;
	bsf	(_Fflush1),2	;volatile
	line	51
;flush.c: 51: Fflush1.bits.bit_0 = 0;
	bcf	(_Fflush1),0	;volatile
	line	52
;flush.c: 52: }
	goto	l2883
	line	53
	
l2884:	
	line	55
;flush.c: 53: else
;flush.c: 54: {
;flush.c: 55: Fflush1.bits.bit_2 = 0;
	bcf	(_Fflush1),2	;volatile
	line	56
;flush.c: 56: Fflush1.bits.bit_0 = 0;
	bcf	(_Fflush1),0	;volatile
	line	57
	
l2883:	
	line	74
;flush.c: 57: }
;flush.c: 74: if (Fbodysensor.bits.bit_2 == 1)
	btfss	(_Fbodysensor),2	;volatile
	goto	u941
	goto	u940
u941:
	goto	l2886
u940:
	line	76
	
l5722:	
;flush.c: 75: {
;flush.c: 76: Fflush1.bits.bit_7 = 1;
	bsf	(_Fflush1),7	;volatile
	line	77
	
l2886:	
	line	78
;flush.c: 77: }
;flush.c: 78: if (Fflush1.bits.bit_7 == 1)
	btfss	(_Fflush1),7	;volatile
	goto	u951
	goto	u950
u951:
	goto	l2889
u950:
	line	80
	
l5724:	
;flush.c: 79: {
;flush.c: 80: if (Fflush1.bits.bit_6 == 1)
	btfss	(_Fflush1),6	;volatile
	goto	u961
	goto	u960
u961:
	goto	l2888
u960:
	line	82
	
l5726:	
;flush.c: 81: {
;flush.c: 82: Fflush1.bits.bit_2 = 0;
	bcf	(_Fflush1),2	;volatile
	line	83
;flush.c: 83: Fflush1.bits.bit_0 = 0;
	bcf	(_Fflush1),0	;volatile
	line	84
;flush.c: 84: return;
	goto	l2889
	line	85
	
l2888:	
	line	86
;flush.c: 85: }
;flush.c: 86: Fflush1.bits.bit_7 = 0;
	bcf	(_Fflush1),7	;volatile
	line	87
;flush.c: 87: if(Fflush1.bits.bit_0 == 1)
	btfss	(_Fflush1),0	;volatile
	goto	u971
	goto	u970
u971:
	goto	l2890
u970:
	line	89
	
l5728:	
;flush.c: 88: {
;flush.c: 89: Fflush1.bits.bit_0 = 0;
	bcf	(_Fflush1),0	;volatile
	line	90
;flush.c: 90: Fflush1.bits.bit_1 = 1;
	bsf	(_Fflush1),1	;volatile
	line	91
;flush.c: 91: return;
	goto	l2889
	line	92
	
l2890:	
	line	93
;flush.c: 92: }
;flush.c: 93: if(Fflush1.bits.bit_2 == 1)
	btfss	(_Fflush1),2	;volatile
	goto	u981
	goto	u980
u981:
	goto	l2889
u980:
	line	95
	
l5730:	
;flush.c: 94: {
;flush.c: 95: Fflush1.bits.bit_2 = 0;
	bcf	(_Fflush1),2	;volatile
	line	96
;flush.c: 96: Fflush1.bits.bit_3 = 1;
	bsf	(_Fflush1),3	;volatile
	line	102
	
l2889:	
	return
	opt stack 0
GLOBAL	__end_of_FlushJudge
	__end_of_FlushJudge:
	signat	_FlushJudge,89
	global	_FlushCon

;; *************** function _FlushCon *****************
;; Defined at:
;;		line 105 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\flush.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_GflushLoop
;; This function uses a non-reentrant model
;;
psect	text18,local,class=CODE,delta=2,merge=1,group=0
	line	105
global __ptext18
__ptext18:	;psect for function _FlushCon
psect	text18
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\flush.c"
	line	105
	global	__size_of_FlushCon
	__size_of_FlushCon	equ	__end_of_FlushCon-_FlushCon
	
_FlushCon:	
;incstack = 0
	opt	stack 4
; Regs used in _FlushCon: [wreg-fsr0h+status,2+status,0]
	line	107
	
l5732:	
;flush.c: 107: switch (SEQflsuh)
	goto	l5810
	line	109
;flush.c: 108: {
;flush.c: 109: case FLUSH_INIT_0:
	
l2895:	
	line	110
;flush.c: 110: Fflush1.bits.bit_6 = 0;
	bcf	(_Fflush1),6	;volatile
	line	111
;flush.c: 111: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	112
;flush.c: 112: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	113
;flush.c: 113: if((Fflush1.bits.bit_1 == 1) || (Fflush1.bits.bit_3 == 1))
	btfsc	(_Fflush1),1	;volatile
	goto	u991
	goto	u990
u991:
	goto	l5736
u990:
	
l5734:	
	btfss	(_Fflush1),3	;volatile
	goto	u1001
	goto	u1000
u1001:
	goto	l2924
u1000:
	line	115
	
l5736:	
;flush.c: 114: {
;flush.c: 115: SEQflsuh = FLUSH_INIT_1;
	movlw	low(01h)
	movwf	(_SEQflsuh)	;volatile
	line	116
	
l5738:	
;flush.c: 116: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	goto	l2924
	line	119
;flush.c: 119: case FLUSH_INIT_1:
	
l2900:	
	line	120
;flush.c: 120: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	121
;flush.c: 121: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	122
;flush.c: 122: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	123
;flush.c: 123: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u1011
	goto	u1010
u1011:
	goto	l5744
u1010:
	line	125
	
l5740:	
;flush.c: 124: {
;flush.c: 125: SEQflsuh = FLUSH_END_0;
	movlw	low(09h)
	movwf	(_SEQflsuh)	;volatile
	goto	l5738
	line	129
	
l5744:	
;flush.c: 128: }
;flush.c: 129: if(++CNTflush >= 5)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	05h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1021
	goto	u1020
u1021:
	goto	l2924
u1020:
	line	131
	
l5746:	
;flush.c: 130: {
;flush.c: 131: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	132
	
l5748:	
;flush.c: 132: SEQflsuh = FLUSH_INIT_2;
	movlw	low(02h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2924
	line	135
;flush.c: 135: case FLUSH_INIT_2:
	
l2903:	
	line	136
;flush.c: 136: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	137
;flush.c: 137: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	138
;flush.c: 138: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	139
;flush.c: 139: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u1031
	goto	u1030
u1031:
	goto	l2904
u1030:
	goto	l5740
	line	144
	
l2904:	
	line	146
;flush.c: 144: }
;flush.c: 146: if(Fflush1.bits.bit_1 == 1)
	btfss	(_Fflush1),1	;volatile
	goto	u1041
	goto	u1040
u1041:
	goto	l2905
u1040:
	line	148
	
l5754:	
;flush.c: 147: {
;flush.c: 148: SEQflsuh = FLUSH_BIG_0;
	movlw	low(03h)
	movwf	(_SEQflsuh)	;volatile
	line	149
;flush.c: 149: }
	goto	l2924
	line	150
	
l2905:	
;flush.c: 150: else if(Fflush1.bits.bit_3 == 1)
	btfss	(_Fflush1),3	;volatile
	goto	u1051
	goto	u1050
u1051:
	goto	l2924
u1050:
	line	152
	
l5756:	
;flush.c: 151: {
;flush.c: 152: SEQflsuh = FLUSH_SML_0;
	movlw	low(06h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2924
	line	155
;flush.c: 155: case FLUSH_BIG_0:
	
l2908:	
	line	156
;flush.c: 156: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	157
;flush.c: 157: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	158
;flush.c: 158: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	159
	
l5758:	
;flush.c: 159: if(++CNTflush >= 10)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	0Ah
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1061
	goto	u1060
u1061:
	goto	l2924
u1060:
	line	161
	
l5760:	
;flush.c: 160: {
;flush.c: 161: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	162
	
l5762:	
;flush.c: 162: SEQflsuh = FLUSH_BIG_1;
	movlw	low(04h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2924
	line	165
;flush.c: 165: case FLUSH_BIG_1:
	
l2910:	
	line	166
;flush.c: 166: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	167
;flush.c: 167: RA2 = 1;
	bsf	(42/8),(42)&7	;volatile
	line	168
;flush.c: 168: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	170
	
l5764:	
;flush.c: 170: if(++CNTflush >= 100)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	064h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1071
	goto	u1070
u1071:
	goto	l2924
u1070:
	line	172
	
l5766:	
;flush.c: 171: {
;flush.c: 172: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	173
	
l5768:	
;flush.c: 173: SEQflsuh = FLUSH_BIG_2;
	movlw	low(05h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2924
	line	183
;flush.c: 183: case FLUSH_BIG_2:
	
l2912:	
	line	184
;flush.c: 184: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	185
;flush.c: 185: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	186
;flush.c: 186: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	187
	
l5770:	
;flush.c: 187: if(++CNTflush >= 10)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	0Ah
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1081
	goto	u1080
u1081:
	goto	l2924
u1080:
	line	189
	
l5772:	
;flush.c: 188: {
;flush.c: 189: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	190
	
l5774:	
;flush.c: 190: SEQflsuh = FLUSH_END_0;
	movlw	low(09h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2924
	line	194
;flush.c: 194: case FLUSH_SML_0:
	
l2914:	
	line	195
;flush.c: 195: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	196
;flush.c: 196: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	197
;flush.c: 197: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	198
	
l5776:	
;flush.c: 198: if(++CNTflush >= 5)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	05h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1091
	goto	u1090
u1091:
	goto	l2924
u1090:
	line	200
	
l5778:	
;flush.c: 199: {
;flush.c: 200: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	201
	
l5780:	
;flush.c: 201: SEQflsuh = FLUSH_SML_1;
	movlw	low(07h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2924
	line	204
;flush.c: 204: case FLUSH_SML_1:
	
l2916:	
	line	205
;flush.c: 205: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	206
;flush.c: 206: RA2 = 1;
	bsf	(42/8),(42)&7	;volatile
	line	207
;flush.c: 207: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	208
	
l5782:	
;flush.c: 208: if(++CNTflush >= 200)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	0C8h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1101
	goto	u1100
u1101:
	goto	l2924
u1100:
	line	210
	
l5784:	
;flush.c: 209: {
;flush.c: 210: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	211
	
l5786:	
;flush.c: 211: SEQflsuh = FLUSH_SML_2;
	movlw	low(08h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2924
	line	214
;flush.c: 214: case FLUSH_SML_2:
	
l2918:	
	line	215
;flush.c: 215: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	216
;flush.c: 216: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	217
;flush.c: 217: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	218
	
l5788:	
;flush.c: 218: if(++CNTflush >= 5)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	05h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1111
	goto	u1110
u1111:
	goto	l2924
u1110:
	goto	l5772
	line	225
;flush.c: 225: case FLUSH_END_0:
	
l2920:	
	line	226
;flush.c: 226: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	227
;flush.c: 227: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	228
;flush.c: 228: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	229
	
l5794:	
;flush.c: 229: if(++CNTflush >= 5)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	05h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1121
	goto	u1120
u1121:
	goto	l2924
u1120:
	line	231
	
l5796:	
;flush.c: 230: {
;flush.c: 231: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	232
	
l5798:	
;flush.c: 232: SEQflsuh = FLUSH_END_1;
	movlw	low(0Ah)
	movwf	(_SEQflsuh)	;volatile
	goto	l2924
	line	235
;flush.c: 235: case FLUSH_END_1:
	
l2922:	
	line	236
;flush.c: 236: Fflush1.bits.bit_6 = 0;
	bcf	(_Fflush1),6	;volatile
	line	237
;flush.c: 237: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	238
;flush.c: 238: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	239
	
l5800:	
;flush.c: 239: SEQflsuh = FLUSH_INIT_0;
	clrf	(_SEQflsuh)	;volatile
	line	240
;flush.c: 240: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	241
	
l5802:	
;flush.c: 241: Fflush1.bits.bit_1 = 0;
	bcf	(_Fflush1),1	;volatile
	line	242
	
l5804:	
;flush.c: 242: Fflush1.bits.bit_3 = 0;
	bcf	(_Fflush1),3	;volatile
	line	243
;flush.c: 243: break;
	goto	l2924
	line	244
;flush.c: 244: default:
	
l2923:	
	line	245
;flush.c: 245: Fflush1.bits.bit_6 = 0;
	bcf	(_Fflush1),6	;volatile
	line	246
;flush.c: 246: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	247
;flush.c: 247: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	248
;flush.c: 248: Fflush1.bits.bit_1 = 0;
	bcf	(_Fflush1),1	;volatile
	line	249
;flush.c: 249: Fflush1.bits.bit_3 = 0;
	bcf	(_Fflush1),3	;volatile
	line	250
	
l5806:	
;flush.c: 250: SEQflsuh = FLUSH_INIT_0;
	clrf	(_SEQflsuh)	;volatile
	line	251
;flush.c: 251: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	252
;flush.c: 252: break;
	goto	l2924
	line	107
	
l5810:	
	movf	(_SEQflsuh),w	;volatile
	; Switch size 1, requested type "space"
; Number of cases is 11, Range of values is 0 to 10
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           34    18 (average)
; direct_byte           41     8 (fixed)
; jumptable            260     6 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_push
	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l2895
	xorlw	1^0	; case 1
	skipnz
	goto	l2900
	xorlw	2^1	; case 2
	skipnz
	goto	l2903
	xorlw	3^2	; case 3
	skipnz
	goto	l2908
	xorlw	4^3	; case 4
	skipnz
	goto	l2910
	xorlw	5^4	; case 5
	skipnz
	goto	l2912
	xorlw	6^5	; case 6
	skipnz
	goto	l2914
	xorlw	7^6	; case 7
	skipnz
	goto	l2916
	xorlw	8^7	; case 8
	skipnz
	goto	l2918
	xorlw	9^8	; case 9
	skipnz
	goto	l2920
	xorlw	10^9	; case 10
	skipnz
	goto	l2922
	goto	l2923
	opt asmopt_pop

	line	254
	
l2924:	
	return
	opt stack 0
GLOBAL	__end_of_FlushCon
	__end_of_FlushCon:
	signat	_FlushCon,89
	global	_Delay_nms

;; *************** function _Delay_nms *****************
;; Defined at:
;;		line 38 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
;; Parameters:    Size  Location     Type
;;  inittempl       2    4[COMMON] unsigned int 
;; Auto vars:     Size  Location     Type
;;  i               2    0[BANK0 ] unsigned int 
;;  gtemp           1    2[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 300/100
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         2       0       0       0       0
;;      Locals:         0       3       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         2       3       0       0       0
;;Total ram usage:        5 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_Delay
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text19,local,class=CODE,delta=2,merge=1,group=0
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
	line	38
global __ptext19
__ptext19:	;psect for function _Delay_nms
psect	text19
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
	line	38
	global	__size_of_Delay_nms
	__size_of_Delay_nms	equ	__end_of_Delay_nms-_Delay_nms
	
_Delay_nms:	
;incstack = 0
	opt	stack 4
; Regs used in _Delay_nms: [wreg+status,2+status,0+pclath+cstack]
	line	43
	
l6040:	
;main.c: 40: unsigned int i;
;main.c: 41: unsigned char gtemp;
;main.c: 43: gtemp = 0;
	bcf	status, 5	;RP0=0, select bank0
	clrf	(Delay_nms@gtemp)
	line	44
	
l6042:	
;main.c: 44: if (GIE == 1)
	btfss	(95/8),(95)&7	;volatile
	goto	u1471
	goto	u1470
u1471:
	goto	l6046
u1470:
	line	46
	
l6044:	
;main.c: 45: {
;main.c: 46: gtemp = 1;
	clrf	(Delay_nms@gtemp)
	incf	(Delay_nms@gtemp),f
	line	47
;main.c: 47: GIE = 0;
	bcf	(95/8),(95)&7	;volatile
	line	49
	
l6046:	
;main.c: 48: }
;main.c: 49: for (i = 0; i < inittempl; i++)
	clrf	(Delay_nms@i)
	clrf	(Delay_nms@i+1)
	goto	l6052
	line	51
	
l6048:	
;main.c: 50: {
;main.c: 51: Delay(154);
	movlw	09Ah
	movwf	(Delay@dtemp)
	clrf	(Delay@dtemp+1)
	fcall	_Delay
	line	52
# 52 "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
clrwdt ;# 
psect	text19
	line	49
	
l6050:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	incf	(Delay_nms@i),f
	skipnz
	incf	(Delay_nms@i+1),f
	
l6052:	
	movf	(Delay_nms@inittempl+1),w
	subwf	(Delay_nms@i+1),w
	skipz
	goto	u1485
	movf	(Delay_nms@inittempl),w
	subwf	(Delay_nms@i),w
u1485:
	skipc
	goto	u1481
	goto	u1480
u1481:
	goto	l6048
u1480:
	line	54
	
l6054:	
;main.c: 53: }
;main.c: 54: if (gtemp == 1)
		decf	((Delay_nms@gtemp)),w
	btfss	status,2
	goto	u1491
	goto	u1490
u1491:
	goto	l1891
u1490:
	line	55
	
l6056:	
;main.c: 55: GIE = 1;
	bsf	(95/8),(95)&7	;volatile
	line	56
	
l1891:	
	return
	opt stack 0
GLOBAL	__end_of_Delay_nms
	__end_of_Delay_nms:
	signat	_Delay_nms,4217
	global	_Delay

;; *************** function _Delay *****************
;; Defined at:
;;		line 30 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
;; Parameters:    Size  Location     Type
;;  dtemp           2    2[COMMON] unsigned int 
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 200/0
;;		On exit  : 200/0
;;		Unchanged: 200/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         2       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Delay_nms
;; This function uses a non-reentrant model
;;
psect	text20,local,class=CODE,delta=2,merge=1,group=0
	line	30
global __ptext20
__ptext20:	;psect for function _Delay
psect	text20
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
	line	30
	global	__size_of_Delay
	__size_of_Delay	equ	__end_of_Delay-_Delay
	
_Delay:	
;incstack = 0
	opt	stack 4
; Regs used in _Delay: [wreg+status,2+status,0]
	line	32
	
l6036:	
;main.c: 32: while (dtemp--)
	
l6038:	
	movlw	01h
	subwf	(Delay@dtemp),f
	movlw	0
	skipc
	decf	(Delay@dtemp+1),f
	subwf	(Delay@dtemp+1),f
		incf	(((Delay@dtemp))),w
	skipz
	goto	u1461
	incf	(((Delay@dtemp+1))),w
	btfss	status,2
	goto	u1461
	goto	u1460
u1461:
	goto	l6038
u1460:
	line	34
	
l1883:	
	return
	opt stack 0
GLOBAL	__end_of_Delay
	__end_of_Delay:
	signat	_Delay,4217
	global	_Int_ALL

;; *************** function _Int_ALL *****************
;; Defined at:
;;		line 562 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_INT_LED_SHOW
;; This function is called by:
;;		Interrupt level 1
;; This function uses a non-reentrant model
;;
psect	text21,local,class=CODE,delta=2,merge=1,group=0
	line	562
global __ptext21
__ptext21:	;psect for function _Int_ALL
psect	text21
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\main.c"
	line	562
	global	__size_of_Int_ALL
	__size_of_Int_ALL	equ	__end_of_Int_ALL-_Int_ALL
	
_Int_ALL:	
;incstack = 0
	opt	stack 4
; Regs used in _Int_ALL: [wreg+status,2+status,0+pclath+cstack]
psect	intentry,class=CODE,delta=2
global __pintentry
__pintentry:
global interrupt_function
interrupt_function:
	global saved_w
	saved_w	set	btemp+0
	movwf	saved_w
	swapf	status,w
	movwf	(??_Int_ALL+0)
	movf	pclath,w
	movwf	(??_Int_ALL+1)
	ljmp	_Int_ALL
psect	text21
	line	565
	
i1l6020:	
;main.c: 565: if (TMR1IF)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(96/8),(96)&7	;volatile
	goto	u143_21
	goto	u143_20
u143_21:
	goto	i1l6030
u143_20:
	line	572
	
i1l6022:	
;main.c: 566: {
;main.c: 572: TMR1 = 0xE0C0;
	movlw	0E0h
	movwf	(14+1)	;volatile
	movlw	0C0h
	movwf	(14)	;volatile
	line	573
;main.c: 573: TMR1IF = 0;
	bcf	(96/8),(96)&7	;volatile
	line	576
;main.c: 576: Fsys1.bits.bit_1 = 1;
	bsf	(_Fsys1),1	;volatile
	line	579
	
i1l6024:	
;main.c: 579: if (++MainTime_1s >= 1000)
	incf	(_MainTime_1s),f	;volatile
	skipnz
	incf	(_MainTime_1s+1),f	;volatile
	movlw	03h
	subwf	((_MainTime_1s+1)),w	;volatile
	movlw	0E8h
	skipnz
	subwf	((_MainTime_1s)),w	;volatile
	skipc
	goto	u144_21
	goto	u144_20
u144_21:
	goto	i1l6030
u144_20:
	line	581
	
i1l6026:	
;main.c: 580: {
;main.c: 581: MainTime_1s = 0;
	clrf	(_MainTime_1s)	;volatile
	clrf	(_MainTime_1s+1)	;volatile
	line	582
	
i1l6028:	
;main.c: 582: Fsys1s.byte = 0xFF;
	movlw	low(0FFh)
	movwf	(_Fsys1s)	;volatile
	line	594
	
i1l6030:	
;main.c: 590: }
;main.c: 591: }
;main.c: 594: if (TMR2IF)
	btfss	(97/8),(97)&7	;volatile
	goto	u145_21
	goto	u145_20
u145_21:
	goto	i1l1971
u145_20:
	line	596
	
i1l6032:	
;main.c: 595: {
;main.c: 596: TMR2IF = 0;
	bcf	(97/8),(97)&7	;volatile
	line	597
	
i1l6034:	
;main.c: 597: INT_LED_SHOW();
	fcall	_INT_LED_SHOW
	line	656
	
i1l1971:	
	movf	(??_Int_ALL+1),w
	movwf	pclath
	swapf	(??_Int_ALL+0)^0FFFFFF80h,w
	movwf	status
	swapf	saved_w,f
	swapf	saved_w,w
	retfie
	opt stack 0
GLOBAL	__end_of_Int_ALL
	__end_of_Int_ALL:
	signat	_Int_ALL,89
	global	_INT_LED_SHOW

;; *************** function _INT_LED_SHOW *****************
;; Defined at:
;;		line 192 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         0       0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_Int_ALL
;; This function uses a non-reentrant model
;;
psect	text22,local,class=CODE,delta=2,merge=1,group=0
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
	line	192
global __ptext22
__ptext22:	;psect for function _INT_LED_SHOW
psect	text22
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_79F133(2)\ABM007_79F133\source\light.c"
	line	192
	global	__size_of_INT_LED_SHOW
	__size_of_INT_LED_SHOW	equ	__end_of_INT_LED_SHOW-_INT_LED_SHOW
	
_INT_LED_SHOW:	
;incstack = 0
	opt	stack 4
; Regs used in _INT_LED_SHOW: [wreg+status,2+status,0]
	line	194
	
i1l5910:	
;light.c: 194: if(FledBits01.bits.bit_0 == 1)
	btfss	(_FledBits01),0	;volatile
	goto	u135_21
	goto	u135_20
u135_21:
	goto	i1l967
u135_20:
	line	196
	
i1l5912:	
;light.c: 195: {
;light.c: 196: if (++CNTbreath_Led == 80)
	incf	(_CNTbreath_Led),f	;volatile
	skipnz
	incf	(_CNTbreath_Led+1),f	;volatile
		movlw	80
	xorwf	(((_CNTbreath_Led))),w	;volatile
iorwf	(((_CNTbreath_Led+1))),w	;volatile
	btfss	status,2
	goto	u136_21
	goto	u136_20
u136_21:
	goto	i1l5918
u136_20:
	line	198
	
i1l5914:	
;light.c: 197: {
;light.c: 198: CNTbreath_Led = 0;
	clrf	(_CNTbreath_Led)	;volatile
	clrf	(_CNTbreath_Led+1)	;volatile
	line	199
	
i1l5916:	
;light.c: 199: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	201
	
i1l5918:	
;light.c: 200: }
;light.c: 201: if (CNTbreath_Led >= CNTbreath_Led2)
	movf	(_CNTbreath_Led2+1),w	;volatile
	subwf	(_CNTbreath_Led+1),w	;volatile
	skipz
	goto	u137_25
	movf	(_CNTbreath_Led2),w	;volatile
	subwf	(_CNTbreath_Led),w	;volatile
u137_25:
	skipc
	goto	u137_21
	goto	u137_20
u137_21:
	goto	i1l965
u137_20:
	line	203
	
i1l5920:	
;light.c: 202: {
;light.c: 203: RA5 = 1;
	bsf	(45/8),(45)&7	;volatile
	line	204
;light.c: 204: }
	goto	i1l967
	line	205
	
i1l965:	
	line	207
;light.c: 205: else
;light.c: 206: {
;light.c: 207: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	210
	
i1l967:	
	return
	opt stack 0
GLOBAL	__end_of_INT_LED_SHOW
	__end_of_INT_LED_SHOW:
	signat	_INT_LED_SHOW,89
global	___latbits
___latbits	equ	2
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp+0
	end

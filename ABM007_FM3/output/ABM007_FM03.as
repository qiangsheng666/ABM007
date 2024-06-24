opt subtitle "Microchip Technology Omniscient Code Generator v1.45 (PRO mode) build 201711160504"

opt pagewidth 120

	opt pm

	processor	79F133
opt include "D:\soft.anzhuang\CMS_IDE_V2.03.25\CMS_IDE_V2.03.25\data\include\79f133.cgen.inc"
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
	FNCALL	_main,_FCTloop
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
	FNCALL	_FlushJudge,_GkeyLoop
	FNCALL	_GkeyLoop,_KeyControl
	FNCALL	_GkeyLoop,_ScanKey
	FNCALL	_FCTloop,_FCTjudge
	FNCALL	_FCTloop,_FCTkey
	FNCALL	_FCTjudge,_G_KEY
	FNCALL	_FCTjudge,_R_KEY
	FNCALL	_FCTjudge,_key1
	FNCALL	_FCTjudge,_key2
	FNCALL	_Delay_nms,_Delay
	FNROOT	_main
	FNCALL	_Int_ALL,_INT_LED_SHOW
	FNCALL	intlevel1,_Int_ALL
	global	intlevel1
	FNROOT	intlevel1
	global	_SeletedLine
	global	_Fbodysensor
	global	_flag_time
	global	_CNTkey2
	global	_CNTkey1
	global	_CNTfct
	global	_CNTfctStart
	global	_CNTbodyExitTime
	global	_CNTbodyInTime
	global	_BufCntAdd
	global	_CNTbody_l
	global	_CNTbody_h
	global	_CNTflush
	global	_AD_Result
	global	_MainTime_1s
	global	_CNTbreath_Led3
	global	_CNTbreath_Led2
	global	_CNTbreath_Led1
	global	_CNTbreath_Led
	global	_My_test_cnt
	global	_CurrentIO
	global	_CNTfctFlashLed
	global	_CNTfctSensior
	global	_FCT
	global	_SEQbody
	global	_u8stsBodySensor
	global	_SEQflsuh
	global	_Fflush1
	global	_MainTime_1min
	global	_SEQmain
	global	_templ
	global	_RX_Buf
	global	_FledBits01
	global	_Fsys1m
	global	_Fsys1s
	global	_Fsys1
	global	_fctBits001
	global	_KeyLines
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
	global	_RB0
_RB0	set	48
	global	_RB1
_RB1	set	49
	global	_RB2
_RB2	set	50
	global	_RA1
_RA1	set	41
	global	_RA2
_RA2	set	42
	global	_RA4
_RA4	set	44
	global	_RA5
_RA5	set	45
	global	_RA6
_RA6	set	46
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
	file	"ABM007_FM03.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

global __initialization
__initialization:
psect	bssCOMMON,class=COMMON,space=1,noexec
global __pbssCOMMON
__pbssCOMMON:
_SeletedLine:
       ds      1

_Fbodysensor:
       ds      1

psect	bssBANK0,class=BANK0,space=1,noexec
global __pbssBANK0
__pbssBANK0:
_flag_time:
       ds      2

_CNTkey2:
       ds      2

_CNTkey1:
       ds      2

_CNTfct:
       ds      2

_CNTfctStart:
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

_CNTbreath_Led2:
       ds      2

_CNTbreath_Led1:
       ds      2

_CNTbreath_Led:
       ds      2

_My_test_cnt:
       ds      2

_CurrentIO:
       ds      1

_CNTfctFlashLed:
       ds      1

_CNTfctSensior:
       ds      1

_FCT:
       ds      1

_SEQbody:
       ds      1

_u8stsBodySensor:
       ds      1

_SEQflsuh:
       ds      1

_Fflush1:
       ds      1

_MainTime_1min:
       ds      1

_SEQmain:
       ds      1

_templ:
       ds      1

_RX_Buf:
       ds      1

_FledBits01:
       ds      1

_Fsys1m:
       ds      1

_Fsys1s:
       ds      1

_Fsys1:
       ds      1

_fctBits001:
       ds      1

_KeyLines:
       ds      8

	file	"ABM007_FM03.as"
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
; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2,merge=1
	bcf	status, 7	;select IRP bank0
	movlw	low(__pbssBANK0)
	movwf	fsr
	movlw	low((__pbssBANK0)+03Dh)
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
?_FCTloop:	; 1 bytes @ 0x0
?_GsensorLoop:	; 1 bytes @ 0x0
?_GflushLoop:	; 1 bytes @ 0x0
?_FlushTime:	; 1 bytes @ 0x0
?_FlushJudge:	; 1 bytes @ 0x0
?_FlushCon:	; 1 bytes @ 0x0
?_GkeyLoop:	; 1 bytes @ 0x0
?_SensorKey:	; 1 bytes @ 0x0
?_SensorTime:	; 1 bytes @ 0x0
?_SensorJudge:	; 1 bytes @ 0x0
?_SensorControl:	; 1 bytes @ 0x0
?_FCTkey:	; 1 bytes @ 0x0
?_FCTjudge:	; 1 bytes @ 0x0
?_ScanKey:	; 1 bytes @ 0x0
?_KeyControl:	; 1 bytes @ 0x0
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
?_G_KEY:	; 1 bytes @ 0x0
?_R_KEY:	; 1 bytes @ 0x0
?_key1:	; 1 bytes @ 0x0
?_key2:	; 1 bytes @ 0x0
	ds	2
??_LED_Time:	; 1 bytes @ 0x2
??_LED_Key:	; 1 bytes @ 0x2
??_LED_Judge:	; 1 bytes @ 0x2
??_LED_Con:	; 1 bytes @ 0x2
??_FCTloop:	; 1 bytes @ 0x2
??_FlushTime:	; 1 bytes @ 0x2
??_FlushCon:	; 1 bytes @ 0x2
??_SensorKey:	; 1 bytes @ 0x2
??_SensorTime:	; 1 bytes @ 0x2
??_SensorJudge:	; 1 bytes @ 0x2
??_SensorControl:	; 1 bytes @ 0x2
??_FCTkey:	; 1 bytes @ 0x2
??_FCTjudge:	; 1 bytes @ 0x2
??_ScanKey:	; 1 bytes @ 0x2
??_KeyControl:	; 1 bytes @ 0x2
??_GledLoop:	; 1 bytes @ 0x2
?_Delay:	; 1 bytes @ 0x2
??_Init_GPIO:	; 1 bytes @ 0x2
??_Init_IC:	; 1 bytes @ 0x2
??_Init_TIMER1:	; 1 bytes @ 0x2
??_Init_TIMER2:	; 1 bytes @ 0x2
??_G_KEY:	; 1 bytes @ 0x2
??_R_KEY:	; 1 bytes @ 0x2
??_key1:	; 1 bytes @ 0x2
??_key2:	; 1 bytes @ 0x2
	global	ScanKey@line_num
ScanKey@line_num:	; 1 bytes @ 0x2
	global	Delay@dtemp
Delay@dtemp:	; 2 bytes @ 0x2
	ds	1
??_GsensorLoop:	; 1 bytes @ 0x3
	ds	1
??_GkeyLoop:	; 1 bytes @ 0x4
??_Delay:	; 1 bytes @ 0x4
?_Delay_nms:	; 1 bytes @ 0x4
	global	Delay_nms@inittempl
Delay_nms@inittempl:	; 2 bytes @ 0x4
	ds	2
??_FlushJudge:	; 1 bytes @ 0x6
??_Delay_nms:	; 1 bytes @ 0x6
	global	FlushJudge@Key_Step
FlushJudge@Key_Step:	; 1 bytes @ 0x6
	global	Delay_nms@i
Delay_nms@i:	; 2 bytes @ 0x6
	ds	1
??_GflushLoop:	; 1 bytes @ 0x7
	ds	1
	global	Delay_nms@gtemp
Delay_nms@gtemp:	; 1 bytes @ 0x8
	ds	1
??_main:	; 1 bytes @ 0x9
psect	cstackBANK0,class=BANK0,space=1,noexec
global __pcstackBANK0
__pcstackBANK0:
	global	_KeyControl$3154
_KeyControl$3154:	; 2 bytes @ 0x0
	ds	2
	global	_KeyControl$3155
_KeyControl$3155:	; 2 bytes @ 0x2
	ds	2
	global	_KeyControl$3156
_KeyControl$3156:	; 2 bytes @ 0x4
	ds	2
	global	KeyControl@this
KeyControl@this:	; 1 bytes @ 0x6
	ds	1
;!
;!Data Sizes:
;!    Strings     0
;!    Constant    0
;!    Data        0
;!    BSS         63
;!    Persistent  0
;!    Stack       0
;!
;!Auto Spaces:
;!    Space          Size  Autos    Used
;!    COMMON           14      9      11
;!    BANK0            80      7      68
;!    BANK1            80      0       0
;!    BANK3            80      0       0
;!    BANK2            80      0       0

;!
;!Pointer List with Targets:
;!
;!    KeyControl@this	PTR struct _KEY_PRIVATE size(1) Largest target is 8
;!		 -> KeyLines(BANK0[8]), 
;!


;!
;!Critical Paths under _main in COMMON
;!
;!    _main->_Delay_nms
;!    _GsensorLoop->_SensorControl
;!    _GflushLoop->_FlushJudge
;!    _FlushJudge->_GkeyLoop
;!    _GkeyLoop->_KeyControl
;!    _Delay_nms->_Delay
;!
;!Critical Paths under _Int_ALL in COMMON
;!
;!    None.
;!
;!Critical Paths under _main in BANK0
;!
;!    _GkeyLoop->_KeyControl
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
;! (0) _main                                                 0     0      0     919
;!                          _Delay_nms
;!                            _FCTloop
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
;! (1) _GflushLoop                                           0     0      0     699
;!                           _FlushCon
;!                         _FlushJudge
;!                          _FlushTime
;! ---------------------------------------------------------------------------------
;! (2) _FlushTime                                            0     0      0       0
;! ---------------------------------------------------------------------------------
;! (2) _FlushJudge                                           1     1      0     699
;!                                              6 COMMON     1     1      0
;!                           _GkeyLoop
;! ---------------------------------------------------------------------------------
;! (3) _GkeyLoop                                             2     2      0     631
;!                                              4 COMMON     2     2      0
;!                         _KeyControl
;!                            _ScanKey
;! ---------------------------------------------------------------------------------
;! (4) _ScanKey                                              1     1      0      22
;!                                              2 COMMON     1     1      0
;! ---------------------------------------------------------------------------------
;! (4) _KeyControl                                           9     9      0     609
;!                                              2 COMMON     2     2      0
;!                                              0 BANK0      7     7      0
;! ---------------------------------------------------------------------------------
;! (2) _FlushCon                                             0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _FCTloop                                              0     0      0       0
;!                           _FCTjudge
;!                             _FCTkey
;! ---------------------------------------------------------------------------------
;! (2) _FCTkey                                               0     0      0       0
;! ---------------------------------------------------------------------------------
;! (2) _FCTjudge                                             0     0      0       0
;!                              _G_KEY
;!                              _R_KEY
;!                               _key1
;!                               _key2
;! ---------------------------------------------------------------------------------
;! (3) _key2                                                 0     0      0       0
;! ---------------------------------------------------------------------------------
;! (3) _key1                                                 0     0      0       0
;! ---------------------------------------------------------------------------------
;! (3) _R_KEY                                                0     0      0       0
;! ---------------------------------------------------------------------------------
;! (3) _G_KEY                                                0     0      0       0
;! ---------------------------------------------------------------------------------
;! (1) _Delay_nms                                            5     3      2     220
;!                                              4 COMMON     5     3      2
;!                              _Delay
;! ---------------------------------------------------------------------------------
;! (2) _Delay                                                2     0      2      86
;!                                              2 COMMON     2     0      2
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 4
;! ---------------------------------------------------------------------------------
;! (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;! ---------------------------------------------------------------------------------
;! (5) _Int_ALL                                              2     2      0       0
;!                                              0 COMMON     2     2      0
;!                       _INT_LED_SHOW
;! ---------------------------------------------------------------------------------
;! (6) _INT_LED_SHOW                                         0     0      0       0
;! ---------------------------------------------------------------------------------
;! Estimated maximum stack depth 6
;! ---------------------------------------------------------------------------------
;!
;! Call Graph Graphs:
;!
;! _main (ROOT)
;!   _Delay_nms
;!     _Delay
;!   _FCTloop
;!     _FCTjudge
;!       _G_KEY
;!       _R_KEY
;!       _key1
;!       _key2
;!     _FCTkey
;!   _GflushLoop
;!     _FlushCon
;!     _FlushJudge
;!       _GkeyLoop
;!         _KeyControl
;!         _ScanKey
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
;!COMMON               E      9       B       1       78.6%
;!BITSFR0              0      0       0       1        0.0%
;!SFR0                 0      0       0       1        0.0%
;!BITSFR1              0      0       0       2        0.0%
;!SFR1                 0      0       0       2        0.0%
;!STACK                0      0       0       2        0.0%
;!BITBANK0            50      0       0       3        0.0%
;!BANK0               50      7      44       4       85.0%
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
;!ABS                  0      0      4F      11        0.0%
;!DATA                 0      0      4F      12        0.0%

	global	_main

;; *************** function _main *****************
;; Defined at:
;;		line 473 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
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
;; Hardware stack levels required when called:    6
;; This function calls:
;;		_Delay_nms
;;		_FCTloop
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
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
	line	473
global __pmaintext
__pmaintext:	;psect for function _main
psect	maintext
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
	line	473
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
;incstack = 0
	opt	stack 2
; Regs used in _main: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	476
	
l7616:	
# 476 "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
nop ;# 
	line	477
# 477 "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
clrwdt ;# 
psect	maintext
	line	478
	
l7618:	
;main.c: 478: INTCON = 0;
	clrf	(11)	;volatile
	line	480
	
l7620:	
;main.c: 480: Init_GPIO();
	fcall	_Init_GPIO
	line	481
	
l7622:	
;main.c: 481: Init_IC();
	fcall	_Init_IC
	line	482
	
l7624:	
;main.c: 482: Delay_nms(200);
	movlw	0C8h
	movwf	(Delay_nms@inittempl)
	clrf	(Delay_nms@inittempl+1)
	fcall	_Delay_nms
	line	483
	
l7626:	
;main.c: 483: Init_TIMER1();
	fcall	_Init_TIMER1
	line	484
	
l7628:	
;main.c: 484: Init_TIMER2();
	fcall	_Init_TIMER2
	line	495
	
l7630:	
;main.c: 495: INTCON = 0XC0;
	movlw	low(0C0h)
	movwf	(11)	;volatile
	line	501
	
l7632:	
;main.c: 499: {
;main.c: 501: if (Fsys1.bits.bit_1 == 1)
	btfss	(_Fsys1),1	;volatile
	goto	u2781
	goto	u2780
u2781:
	goto	l7632
u2780:
	line	503
	
l7634:	
# 503 "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
clrwdt ;# 
psect	maintext
	line	505
;main.c: 505: Fsys1.bits.bit_1 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(_Fsys1),1	;volatile
	line	506
;main.c: 506: switch (SEQmain)
	goto	l7646
	line	509
	
l7636:	
;main.c: 509: FCTloop();
	fcall	_FCTloop
	line	510
;main.c: 510: break;
	goto	l7648
	line	511
;main.c: 511: case 1:
	
l1964:	
	line	512
;main.c: 512: if(fctBits001.bits.bit_0 == 0)
	btfsc	(_fctBits001),0	;volatile
	goto	u2791
	goto	u2790
u2791:
	goto	l7648
u2790:
	line	514
	
l7638:	
;main.c: 513: {
;main.c: 514: GsensorLoop();
	fcall	_GsensorLoop
	goto	l7648
	line	523
;main.c: 523: case 4:
	
l1968:	
	line	524
;main.c: 524: if(fctBits001.bits.bit_0 == 0)
	btfsc	(_fctBits001),0	;volatile
	goto	u2801
	goto	u2800
u2801:
	goto	l7648
u2800:
	line	526
	
l7640:	
;main.c: 525: {
;main.c: 526: GflushLoop();
	fcall	_GflushLoop
	goto	l7648
	line	538
;main.c: 538: case 8:
	
l1973:	
	line	539
;main.c: 539: if(fctBits001.bits.bit_0 == 0)
	btfsc	(_fctBits001),0	;volatile
	goto	u2811
	goto	u2810
u2811:
	goto	l7648
u2810:
	line	541
	
l7642:	
;main.c: 540: {
;main.c: 541: GledLoop();
	fcall	_GledLoop
	goto	l7648
	line	506
	
l7646:	
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
	goto	l7636
	xorlw	1^0	; case 1
	skipnz
	goto	l1964
	xorlw	2^1	; case 2
	skipnz
	goto	l7648
	xorlw	3^2	; case 3
	skipnz
	goto	l7648
	xorlw	4^3	; case 4
	skipnz
	goto	l1968
	xorlw	5^4	; case 5
	skipnz
	goto	l7648
	xorlw	6^5	; case 6
	skipnz
	goto	l7648
	xorlw	7^6	; case 7
	skipnz
	goto	l7648
	xorlw	8^7	; case 8
	skipnz
	goto	l1973
	xorlw	9^8	; case 9
	skipnz
	goto	l7648
	goto	l7648
	opt asmopt_pop

	line	551
	
l7648:	
;main.c: 551: if (++SEQmain >= 10)
	movlw	low(0Ah)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	incf	(_SEQmain),f	;volatile
	subwf	((_SEQmain)),w	;volatile
	skipc
	goto	u2821
	goto	u2820
u2821:
	goto	l7632
u2820:
	line	553
	
l7650:	
;main.c: 552: {
;main.c: 553: SEQmain = 0;
	clrf	(_SEQmain)	;volatile
	goto	l7632
	global	start
	ljmp	start
	opt stack 0
	line	557
GLOBAL	__end_of_main
	__end_of_main:
	signat	_main,89
	global	_Init_TIMER2

;; *************** function _Init_TIMER2 *****************
;; Defined at:
;;		line 174 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
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
	line	174
global __ptext1
__ptext1:	;psect for function _Init_TIMER2
psect	text1
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
	line	174
	global	__size_of_Init_TIMER2
	__size_of_Init_TIMER2	equ	__end_of_Init_TIMER2-_Init_TIMER2
	
_Init_TIMER2:	
;incstack = 0
	opt	stack 5
; Regs used in _Init_TIMER2: [wreg]
	line	176
	
l7416:	
;main.c: 176: PR2 = 24;
	movlw	low(018h)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(146)^080h	;volatile
	line	177
	
l7418:	
;main.c: 177: TMR2IF = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	(97/8),(97)&7	;volatile
	line	178
	
l7420:	
;main.c: 178: TMR2IE = 1;
	bsf	status, 5	;RP0=1, select bank1
	bsf	(1121/8)^080h,(1121)&7	;volatile
	line	179
;main.c: 179: T2CON = 5;
	movlw	low(05h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(18)	;volatile
	line	180
	
l1917:	
	return
	opt stack 0
GLOBAL	__end_of_Init_TIMER2
	__end_of_Init_TIMER2:
	signat	_Init_TIMER2,89
	global	_Init_TIMER1

;; *************** function _Init_TIMER1 *****************
;; Defined at:
;;		line 152 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 0/100
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
	line	152
global __ptext2
__ptext2:	;psect for function _Init_TIMER1
psect	text2
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
	line	152
	global	__size_of_Init_TIMER1
	__size_of_Init_TIMER1	equ	__end_of_Init_TIMER1-_Init_TIMER1
	
_Init_TIMER1:	
;incstack = 0
	opt	stack 5
; Regs used in _Init_TIMER1: [wreg]
	line	156
	
l7412:	
;main.c: 156: TMR1 = 0xE0C0;
	movlw	0E0h
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(14+1)	;volatile
	movlw	0C0h
	movwf	(14)	;volatile
	line	157
;main.c: 157: TMR1IF = 0;
	bcf	(96/8),(96)&7	;volatile
	line	158
;main.c: 158: TMR1IE = 1;
	bsf	status, 5	;RP0=1, select bank1
	bsf	(1120/8)^080h,(1120)&7	;volatile
	line	159
	
l7414:	
;main.c: 159: T1CON = 0x01;
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(16)	;volatile
	line	160
	
l1914:	
	return
	opt stack 0
GLOBAL	__end_of_Init_TIMER1
	__end_of_Init_TIMER1:
	signat	_Init_TIMER1,89
	global	_Init_IC

;; *************** function _Init_IC *****************
;; Defined at:
;;		line 96 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
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
	line	96
global __ptext3
__ptext3:	;psect for function _Init_IC
psect	text3
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
	line	96
	global	__size_of_Init_IC
	__size_of_Init_IC	equ	__end_of_Init_IC-_Init_IC
	
_Init_IC:	
;incstack = 0
	opt	stack 5
; Regs used in _Init_IC: [wreg+status,2]
	line	98
	
l7398:	
# 98 "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
clrwdt ;# 
psect	text3
	line	103
	
l7400:	
;main.c: 103: INTCON = 0x00;
	clrf	(11)	;volatile
	line	108
;main.c: 108: PIR1 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(12)	;volatile
	line	113
;main.c: 113: PIR2 = 0;
	clrf	(13)	;volatile
	line	118
	
l7402:	
;main.c: 118: WDTCON = 0x01;
	movlw	low(01h)
	bsf	status, 6	;RP1=1, select bank2
	movwf	(261)^0100h	;volatile
	line	123
	
l7404:	
;main.c: 123: OPTION_REG = 0b00001110;
	movlw	low(0Eh)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(129)^080h	;volatile
	line	128
	
l7406:	
;main.c: 128: OSCCON = 0x71;
	movlw	low(071h)
	movwf	(143)^080h	;volatile
	line	133
	
l7408:	
;main.c: 133: PIE1 = 0;
	clrf	(140)^080h	;volatile
	line	138
	
l7410:	
;main.c: 138: PIE2 = 0;
	clrf	(141)^080h	;volatile
	line	139
	
l1911:	
	return
	opt stack 0
GLOBAL	__end_of_Init_IC
	__end_of_Init_IC:
	signat	_Init_IC,89
	global	_Init_GPIO

;; *************** function _Init_GPIO *****************
;; Defined at:
;;		line 62 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
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
	line	62
global __ptext4
__ptext4:	;psect for function _Init_GPIO
psect	text4
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
	line	62
	global	__size_of_Init_GPIO
	__size_of_Init_GPIO	equ	__end_of_Init_GPIO-_Init_GPIO
	
_Init_GPIO:	
;incstack = 0
	opt	stack 5
; Regs used in _Init_GPIO: [wreg+status,2]
	line	66
	
l7384:	
;main.c: 66: PORTA = 0B01000000;
	movlw	low(040h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(5)	;volatile
	line	67
;main.c: 67: PORTB = 0B00000001;
	movlw	low(01h)
	movwf	(6)	;volatile
	line	68
	
l7386:	
;main.c: 68: PORTC = 0B00000000;
	clrf	(7)	;volatile
	line	71
	
l7388:	
;main.c: 71: TRISA = 0B01000000;
	movlw	low(040h)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(133)^080h	;volatile
	line	72
	
l7390:	
;main.c: 72: TRISB = 0B00000111;
	movlw	low(07h)
	movwf	(134)^080h	;volatile
	line	73
	
l7392:	
;main.c: 73: TRISC = 0B00000000;
	clrf	(135)^080h	;volatile
	line	76
	
l7394:	
;main.c: 76: WPUA = 0B00000000;
	bsf	status, 6	;RP1=1, select bank3
	clrf	(398)^0180h	;volatile
	line	77
	
l7396:	
;main.c: 77: WPUB = 0B00000010;
	movlw	low(02h)
	bcf	status, 6	;RP1=0, select bank1
	movwf	(149)^080h	;volatile
	line	78
;main.c: 78: WPUC = 0B00000000;
	bsf	status, 6	;RP1=1, select bank3
	clrf	(399)^0180h	;volatile
	line	87
	
l1908:	
	return
	opt stack 0
GLOBAL	__end_of_Init_GPIO
	__end_of_Init_GPIO:
	signat	_Init_GPIO,89
	global	_GsensorLoop

;; *************** function _GsensorLoop *****************
;; Defined at:
;;		line 19 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\sensor.c"
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
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\sensor.c"
	line	19
global __ptext5
__ptext5:	;psect for function _GsensorLoop
psect	text5
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\sensor.c"
	line	19
	global	__size_of_GsensorLoop
	__size_of_GsensorLoop	equ	__end_of_GsensorLoop-_GsensorLoop
	
_GsensorLoop:	
;incstack = 0
	opt	stack 4
; Regs used in _GsensorLoop: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	21
	
l7424:	
;sensor.c: 21: SensorKey();
	fcall	_SensorKey
	line	22
	
l7426:	
;sensor.c: 22: SensorTime();
	fcall	_SensorTime
	line	23
	
l7428:	
;sensor.c: 23: SensorJudge();
	fcall	_SensorJudge
	line	24
	
l7430:	
;sensor.c: 24: SensorControl();
	fcall	_SensorControl
	line	25
	
l3874:	
	return
	opt stack 0
GLOBAL	__end_of_GsensorLoop
	__end_of_GsensorLoop:
	signat	_GsensorLoop,89
	global	_SensorTime

;; *************** function _SensorTime *****************
;; Defined at:
;;		line 33 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\sensor.c"
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
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\sensor.c"
	line	33
	global	__size_of_SensorTime
	__size_of_SensorTime	equ	__end_of_SensorTime-_SensorTime
	
_SensorTime:	
;incstack = 0
	opt	stack 4
; Regs used in _SensorTime: [wreg+status,2+status,0]
	line	35
	
l7188:	
;sensor.c: 35: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u1891
	goto	u1890
u1891:
	goto	l7208
u1890:
	line	37
	
l7190:	
;sensor.c: 36: {
;sensor.c: 37: Fbodysensor.bits.bit_5 = 0;
	bcf	(_Fbodysensor),5	;volatile
	line	38
	
l7192:	
;sensor.c: 38: CNTbodyExitTime = 0;
	clrf	(_CNTbodyExitTime)	;volatile
	clrf	(_CNTbodyExitTime+1)	;volatile
	line	39
	
l7194:	
;sensor.c: 39: if(FledBits01.bits.bit_2 == 0)
	btfsc	(_FledBits01),2	;volatile
	goto	u1901
	goto	u1900
u1901:
	goto	l3881
u1900:
	line	41
	
l7196:	
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
	goto	u1911
	goto	u1910
u1911:
	goto	l7202
u1910:
	line	43
	
l7198:	
;sensor.c: 42: {
;sensor.c: 43: CNTbodyInTime = 6000;
	movlw	070h
	movwf	(_CNTbodyInTime)	;volatile
	movlw	017h
	movwf	((_CNTbodyInTime))+1	;volatile
	line	44
	
l7200:	
;sensor.c: 44: Fbodysensor.bits.bit_3 = 1;
	bsf	(_Fbodysensor),3	;volatile
	line	45
;sensor.c: 45: }
	goto	l3889
	line	46
	
l7202:	
;sensor.c: 46: else if(CNTbodyInTime >= 500)
	movlw	01h
	subwf	(_CNTbodyInTime+1),w	;volatile
	movlw	0F4h
	skipnz
	subwf	(_CNTbodyInTime),w	;volatile
	skipc
	goto	u1921
	goto	u1920
u1921:
	goto	l3885
u1920:
	line	48
	
l7204:	
;sensor.c: 47: {
;sensor.c: 48: Fbodysensor.bits.bit_4 = 1;
	bsf	(_Fbodysensor),4	;volatile
	goto	l3889
	line	51
	
l3881:	
	line	53
;sensor.c: 51: else
;sensor.c: 52: {
;sensor.c: 53: if(Fbodysensor.bits.bit_4 == 0)
	btfsc	(_Fbodysensor),4	;volatile
	goto	u1931
	goto	u1930
u1931:
	goto	l3889
u1930:
	line	55
	
l7206:	
;sensor.c: 54: {
;sensor.c: 55: CNTbodyInTime = 0;
	clrf	(_CNTbodyInTime)	;volatile
	clrf	(_CNTbodyInTime+1)	;volatile
	goto	l3889
	line	57
	
l3885:	
	line	58
;sensor.c: 56: }
;sensor.c: 57: }
;sensor.c: 58: }
	goto	l3889
	line	61
	
l7208:	
;sensor.c: 59: else
;sensor.c: 60: {
;sensor.c: 61: CNTbodyInTime = 0;
	clrf	(_CNTbodyInTime)	;volatile
	clrf	(_CNTbodyInTime+1)	;volatile
	line	62
	
l7210:	
;sensor.c: 62: Fbodysensor.bits.bit_4 = 0;
	bcf	(_Fbodysensor),4	;volatile
	line	63
	
l7212:	
;sensor.c: 63: Fbodysensor.bits.bit_3 = 0;
	bcf	(_Fbodysensor),3	;volatile
	line	64
	
l7214:	
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
	goto	u1941
	goto	u1940
u1941:
	goto	l3889
u1940:
	line	66
	
l7216:	
;sensor.c: 65: {
;sensor.c: 66: CNTbodyExitTime = 500;
	movlw	0F4h
	movwf	(_CNTbodyExitTime)	;volatile
	movlw	01h
	movwf	((_CNTbodyExitTime))+1	;volatile
	line	67
	
l7218:	
;sensor.c: 67: Fbodysensor.bits.bit_5 = 1;
	bsf	(_Fbodysensor),5	;volatile
	line	70
	
l3889:	
	return
	opt stack 0
GLOBAL	__end_of_SensorTime
	__end_of_SensorTime:
	signat	_SensorTime,89
	global	_SensorKey

;; *************** function _SensorKey *****************
;; Defined at:
;;		line 27 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\sensor.c"
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
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\sensor.c"
	line	27
	global	__size_of_SensorKey
	__size_of_SensorKey	equ	__end_of_SensorKey-_SensorKey
	
_SensorKey:	
;incstack = 0
	opt	stack 4
; Regs used in _SensorKey: []
	line	30
	
l3877:	
	return
	opt stack 0
GLOBAL	__end_of_SensorKey
	__end_of_SensorKey:
	signat	_SensorKey,89
	global	_SensorJudge

;; *************** function _SensorJudge *****************
;; Defined at:
;;		line 73 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\sensor.c"
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
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\sensor.c"
	line	73
	global	__size_of_SensorJudge
	__size_of_SensorJudge	equ	__end_of_SensorJudge-_SensorJudge
	
_SensorJudge:	
;incstack = 0
	opt	stack 4
; Regs used in _SensorJudge: [wreg-fsr0h+status,2+status,0]
	line	75
	
l7220:	
;sensor.c: 75: switch (SEQbody)
	goto	l7272
	line	77
;sensor.c: 76: {
;sensor.c: 77: case 0:
	
l3893:	
	line	78
;sensor.c: 78: Fbodysensor.bits.bit_0 = 0;
	bcf	(_Fbodysensor),0	;volatile
	line	79
;sensor.c: 79: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	80
	
l7222:	
;sensor.c: 80: SEQbody = 1;
	movlw	low(01h)
	movwf	(_SEQbody)	;volatile
	line	81
;sensor.c: 81: break;
	goto	l3914
	line	84
;sensor.c: 84: case 1:
	
l3895:	
	line	85
;sensor.c: 85: Fbodysensor.bits.bit_0 = 0;
	bcf	(_Fbodysensor),0	;volatile
	line	86
;sensor.c: 86: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	87
;sensor.c: 87: if(RB1 == 0)
	btfsc	(49/8),(49)&7	;volatile
	goto	u1951
	goto	u1950
u1951:
	goto	l7230
u1950:
	line	89
	
l7224:	
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
	goto	u1961
	goto	u1960
u1961:
	goto	l3914
u1960:
	line	91
	
l7226:	
;sensor.c: 90: {
;sensor.c: 91: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	line	92
;sensor.c: 92: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	line	93
	
l7228:	
;sensor.c: 93: SEQbody = 2;
	movlw	low(02h)
	movwf	(_SEQbody)	;volatile
	line	94
;sensor.c: 94: break;
	goto	l3914
	line	99
	
l7230:	
;sensor.c: 97: else
;sensor.c: 98: {
;sensor.c: 99: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	goto	l3914
	line	104
;sensor.c: 104: case 2:
	
l3899:	
	line	105
;sensor.c: 105: Fbodysensor.bits.bit_0 = 0;
	bcf	(_Fbodysensor),0	;volatile
	line	106
;sensor.c: 106: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	107
;sensor.c: 107: if(RB1 == 0)
	btfsc	(49/8),(49)&7	;volatile
	goto	u1971
	goto	u1970
u1971:
	goto	l7234
u1970:
	line	109
	
l7232:	
;sensor.c: 108: {
;sensor.c: 109: ++CNTbody_h;
	incf	(_CNTbody_h),f	;volatile
	skipnz
	incf	(_CNTbody_h+1),f	;volatile
	line	110
;sensor.c: 110: }
	goto	l7240
	line	113
	
l7234:	
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
	goto	u1981
	goto	u1980
u1981:
	goto	l7240
u1980:
	line	115
	
l7236:	
;sensor.c: 114: {
;sensor.c: 115: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	line	116
;sensor.c: 116: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	goto	l7222
	line	121
	
l7240:	
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
	
l7242:	
;sensor.c: 122: if(BufCntAdd >= 30)
	movlw	0
	subwf	(_BufCntAdd+1),w	;volatile
	movlw	01Eh
	skipnz
	subwf	(_BufCntAdd),w	;volatile
	skipc
	goto	u1991
	goto	u1990
u1991:
	goto	l3914
u1990:
	line	124
	
l7244:	
;sensor.c: 123: {
;sensor.c: 124: SEQbody = 3;
	movlw	low(03h)
	movwf	(_SEQbody)	;volatile
	line	125
;sensor.c: 125: break;
	goto	l3914
	line	129
;sensor.c: 129: case 3:
	
l3904:	
	line	130
;sensor.c: 130: Fbodysensor.bits.bit_0 = 1;
	bsf	(_Fbodysensor),0	;volatile
	line	131
;sensor.c: 131: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	132
;sensor.c: 132: if(RB1 == 1)
	btfss	(49/8),(49)&7	;volatile
	goto	u2001
	goto	u2000
u2001:
	goto	l7252
u2000:
	line	134
	
l7246:	
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
	goto	u2011
	goto	u2010
u2011:
	goto	l3914
u2010:
	line	136
	
l7248:	
;sensor.c: 135: {
;sensor.c: 136: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	line	137
;sensor.c: 137: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	line	138
	
l7250:	
;sensor.c: 138: SEQbody = 4;
	movlw	low(04h)
	movwf	(_SEQbody)	;volatile
	line	139
;sensor.c: 139: break;
	goto	l3914
	line	144
	
l7252:	
;sensor.c: 142: else
;sensor.c: 143: {
;sensor.c: 144: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	goto	l3914
	line	148
;sensor.c: 148: case 4:
	
l3908:	
	line	149
;sensor.c: 149: Fbodysensor.bits.bit_0 = 1;
	bsf	(_Fbodysensor),0	;volatile
	line	150
;sensor.c: 150: FledBits01.bits.bit_2 = 1;
	bsf	(_FledBits01),2	;volatile
	line	151
;sensor.c: 151: if(RB1 == 0)
	btfsc	(49/8),(49)&7	;volatile
	goto	u2021
	goto	u2020
u2021:
	goto	l7260
u2020:
	line	153
	
l7254:	
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
	goto	u2031
	goto	u2030
u2031:
	goto	l7262
u2030:
	line	155
	
l7256:	
;sensor.c: 154: {
;sensor.c: 155: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	line	156
;sensor.c: 156: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	goto	l7244
	line	163
	
l7260:	
;sensor.c: 161: else
;sensor.c: 162: {
;sensor.c: 163: ++CNTbody_l;
	incf	(_CNTbody_l),f	;volatile
	skipnz
	incf	(_CNTbody_l+1),f	;volatile
	line	165
	
l7262:	
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
	goto	u2041
	goto	u2040
u2041:
	goto	l3914
u2040:
	goto	l7222
	line	173
	
l7266:	
;sensor.c: 173: SEQbody = 0;
	clrf	(_SEQbody)	;volatile
	line	174
	
l7268:	
;sensor.c: 174: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	175
;sensor.c: 175: break;
	goto	l3914
	line	75
	
l7272:	
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
	goto	l3893
	xorlw	1^0	; case 1
	skipnz
	goto	l3895
	xorlw	2^1	; case 2
	skipnz
	goto	l3899
	xorlw	3^2	; case 3
	skipnz
	goto	l3904
	xorlw	4^3	; case 4
	skipnz
	goto	l3908
	goto	l7266
	opt asmopt_pop

	line	177
	
l3914:	
	return
	opt stack 0
GLOBAL	__end_of_SensorJudge
	__end_of_SensorJudge:
	signat	_SensorJudge,89
	global	_SensorControl

;; *************** function _SensorControl *****************
;; Defined at:
;;		line 179 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\sensor.c"
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
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\sensor.c"
	line	179
	global	__size_of_SensorControl
	__size_of_SensorControl	equ	__end_of_SensorControl-_SensorControl
	
_SensorControl:	
;incstack = 0
	opt	stack 4
; Regs used in _SensorControl: [wreg]
	line	181
	
l7274:	
;sensor.c: 181: Fbodysensor.bits.bit_1 = 0;
	bcf	(_Fbodysensor),1	;volatile
	line	182
;sensor.c: 182: Fbodysensor.bits.bit_2 = 0;
	bcf	(_Fbodysensor),2	;volatile
	line	183
	
l7276:	
;sensor.c: 183: if(Fbodysensor.bits.bit_6 != Fbodysensor.bits.bit_0)
	btfsc	(_Fbodysensor),0	;volatile
	goto	u2051
	goto	u2050
u2051:
	movlw	1
	goto	u2052
u2050:
	movlw	0
u2052:
	movwf	(??_SensorControl+0)+0
	btfsc	(_Fbodysensor),6	;volatile
	goto	u2061
	goto	u2060
u2061:
	movlw	1
	goto	u2062
u2060:
	movlw	0
u2062:
	xorwf	(??_SensorControl+0)+0,w
	skipnz
	goto	u2071
	goto	u2070
u2071:
	goto	l3920
u2070:
	line	185
	
l7278:	
;sensor.c: 184: {
;sensor.c: 185: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u2081
	goto	u2080
u2081:
	goto	l3918
u2080:
	line	187
	
l7280:	
;sensor.c: 186: {
;sensor.c: 187: Fbodysensor.bits.bit_1 = 1;
	bsf	(_Fbodysensor),1	;volatile
	line	188
;sensor.c: 188: }
	goto	l3919
	line	189
	
l3918:	
	line	191
;sensor.c: 189: else
;sensor.c: 190: {
;sensor.c: 191: Fbodysensor.bits.bit_2 = 1;
	bsf	(_Fbodysensor),2	;volatile
	line	192
	
l3919:	
	line	193
;sensor.c: 192: }
;sensor.c: 193: Fbodysensor.bits.bit_6 = Fbodysensor.bits.bit_0;
	btfsc	(_Fbodysensor),0	;volatile
	goto	u2091
	goto	u2090
	
u2091:
	bsf	(_Fbodysensor),6	;volatile
	goto	u2104
u2090:
	bcf	(_Fbodysensor),6	;volatile
u2104:
	line	195
	
l3920:	
	return
	opt stack 0
GLOBAL	__end_of_SensorControl
	__end_of_SensorControl:
	signat	_SensorControl,89
	global	_GledLoop

;; *************** function _GledLoop *****************
;; Defined at:
;;		line 16 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
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
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
	line	16
global __ptext10
__ptext10:	;psect for function _GledLoop
psect	text10
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
	line	16
	global	__size_of_GledLoop
	__size_of_GledLoop	equ	__end_of_GledLoop-_GledLoop
	
_GledLoop:	
;incstack = 0
	opt	stack 4
; Regs used in _GledLoop: [wreg+status,2+status,0+pclath+cstack]
	line	18
	
l7348:	
;light.c: 18: LED_Time();
	fcall	_LED_Time
	line	19
;light.c: 19: LED_Key();
	fcall	_LED_Key
	line	20
;light.c: 20: LED_Judge();
	fcall	_LED_Judge
	line	21
	
l7350:	
;light.c: 21: LED_Con();
	fcall	_LED_Con
	line	22
	
l917:	
	return
	opt stack 0
GLOBAL	__end_of_GledLoop
	__end_of_GledLoop:
	signat	_GledLoop,89
	global	_LED_Time

;; *************** function _LED_Time *****************
;; Defined at:
;;		line 45 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
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
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
	line	45
	global	__size_of_LED_Time
	__size_of_LED_Time	equ	__end_of_LED_Time-_LED_Time
	
_LED_Time:	
;incstack = 0
	opt	stack 4
; Regs used in _LED_Time: []
	line	47
	
l6960:	
;light.c: 47: if(Fsys1m.bits.bit_0 == 1)
	btfss	(_Fsys1m),0	;volatile
	goto	u1371
	goto	u1370
u1371:
	goto	l924
u1370:
	line	49
	
l6962:	
;light.c: 48: {
;light.c: 49: Fsys1m.bits.bit_0 = 0;
	bcf	(_Fsys1m),0	;volatile
	line	51
	
l924:	
	return
	opt stack 0
GLOBAL	__end_of_LED_Time
	__end_of_LED_Time:
	signat	_LED_Time,89
	global	_LED_Key

;; *************** function _LED_Key *****************
;; Defined at:
;;		line 24 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
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
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
	line	24
	global	__size_of_LED_Key
	__size_of_LED_Key	equ	__end_of_LED_Key-_LED_Key
	
_LED_Key:	
;incstack = 0
	opt	stack 4
; Regs used in _LED_Key: []
	line	43
	
l920:	
	return
	opt stack 0
GLOBAL	__end_of_LED_Key
	__end_of_LED_Key:
	signat	_LED_Key,89
	global	_LED_Judge

;; *************** function _LED_Judge *****************
;; Defined at:
;;		line 53 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
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
psect	text13,local,class=CODE,delta=2,merge=1,group=0
	line	53
global __ptext13
__ptext13:	;psect for function _LED_Judge
psect	text13
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
	line	53
	global	__size_of_LED_Judge
	__size_of_LED_Judge	equ	__end_of_LED_Judge-_LED_Judge
	
_LED_Judge:	
;incstack = 0
	opt	stack 4
; Regs used in _LED_Judge: []
	line	55
	
l6964:	
;light.c: 55: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u1381
	goto	u1380
u1381:
	goto	l6970
u1380:
	line	57
	
l6966:	
;light.c: 56: {
;light.c: 57: FledBits01.bits.bit_0 = 1;
	bsf	(_FledBits01),0	;volatile
	line	58
;light.c: 58: if(Fbodysensor.bits.bit_4 == 0)
	btfsc	(_Fbodysensor),4	;volatile
	goto	u1391
	goto	u1390
u1391:
	goto	l931
u1390:
	line	60
	
l6968:	
;light.c: 59: {
;light.c: 60: if(FledBits01.bits.bit_2 == 1)
	btfss	(_FledBits01),2	;volatile
	goto	u1401
	goto	u1400
u1401:
	goto	l931
u1400:
	line	62
	
l6970:	
;light.c: 61: {
;light.c: 62: FledBits01.bits.bit_0 = 0;
	bcf	(_FledBits01),0	;volatile
	line	82
	
l931:	
	return
	opt stack 0
GLOBAL	__end_of_LED_Judge
	__end_of_LED_Judge:
	signat	_LED_Judge,89
	global	_LED_Con

;; *************** function _LED_Con *****************
;; Defined at:
;;		line 84 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
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
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
	line	84
	global	__size_of_LED_Con
	__size_of_LED_Con	equ	__end_of_LED_Con-_LED_Con
	
_LED_Con:	
;incstack = 0
	opt	stack 4
; Regs used in _LED_Con: [wreg+status,2+status,0]
	line	86
	
l6972:	
;light.c: 86: RA5 = FledBits01.bits.bit_0;
	btfsc	(_FledBits01),0	;volatile
	goto	u1411
	goto	u1410
	
u1411:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(45/8),(45)&7	;volatile
	goto	u1424
u1410:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(45/8),(45)&7	;volatile
u1424:
	line	88
;light.c: 88: if (FledBits01.bits.bit_0 == 1)
	btfss	(_FledBits01),0	;volatile
	goto	u1431
	goto	u1430
u1431:
	goto	l7060
u1430:
	line	90
	
l6974:	
;light.c: 89: {
;light.c: 90: if (FledBits01.bits.bit_3 == 0)
	btfsc	(_FledBits01),3	;volatile
	goto	u1441
	goto	u1440
u1441:
	goto	l7016
u1440:
	line	92
	
l6976:	
;light.c: 91: {
;light.c: 92: if (CNTbreath_Led2 >= 80)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	050h
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipc
	goto	u1451
	goto	u1450
u1451:
	goto	l6986
u1450:
	line	94
	
l6978:	
;light.c: 93: {
;light.c: 94: CNTbreath_Led2 = 80;
	movlw	050h
	movwf	(_CNTbreath_Led2)	;volatile
	clrf	(_CNTbreath_Led2+1)	;volatile
	line	95
	
l6980:	
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
	goto	u1461
	goto	u1460
u1461:
	goto	l966
u1460:
	line	97
	
l6982:	
;light.c: 96: {
;light.c: 97: FledBits01.bits.bit_3 = 1;
	bsf	(_FledBits01),3	;volatile
	line	98
	
l6984:	
;light.c: 98: CNTbreath_Led3 = 0;
	clrf	(_CNTbreath_Led3)	;volatile
	clrf	(_CNTbreath_Led3+1)	;volatile
	goto	l966
	line	101
	
l6986:	
;light.c: 101: else if (CNTbreath_Led2 > 45)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	02Eh
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipc
	goto	u1471
	goto	u1470
u1471:
	goto	l6994
u1470:
	line	103
	
l6988:	
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
	goto	u1481
	goto	u1480
u1481:
	goto	l966
u1480:
	line	105
	
l6990:	
;light.c: 104: {
;light.c: 105: CNTbreath_Led1 = 0;
	clrf	(_CNTbreath_Led1)	;volatile
	clrf	(_CNTbreath_Led1+1)	;volatile
	line	106
	
l6992:	
;light.c: 106: CNTbreath_Led2++;
	incf	(_CNTbreath_Led2),f	;volatile
	skipnz
	incf	(_CNTbreath_Led2+1),f	;volatile
	goto	l966
	line	109
	
l6994:	
;light.c: 109: else if (CNTbreath_Led2 > 30)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	01Fh
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipc
	goto	u1491
	goto	u1490
u1491:
	goto	l7002
u1490:
	line	111
	
l6996:	
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
	goto	u1501
	goto	u1500
u1501:
	goto	l966
u1500:
	goto	l6990
	line	117
	
l7002:	
;light.c: 117: else if (CNTbreath_Led2 > 10)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	0Bh
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipc
	goto	u1511
	goto	u1510
u1511:
	goto	l7010
u1510:
	line	119
	
l7004:	
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
	goto	u1521
	goto	u1520
u1521:
	goto	l938
u1520:
	goto	l6990
	line	127
	
l7010:	
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
	goto	u1531
	goto	u1530
u1531:
	goto	l938
u1530:
	goto	l6990
	line	132
	
l938:	
	line	133
;light.c: 131: }
;light.c: 132: }
;light.c: 133: }
	goto	l966
	line	136
	
l7016:	
;light.c: 134: else
;light.c: 135: {
;light.c: 136: if (CNTbreath_Led2 < 5)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	05h
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u1541
	goto	u1540
u1541:
	goto	l7022
u1540:
	line	138
	
l7018:	
;light.c: 137: {
;light.c: 138: CNTbreath_Led2 = 5;
	movlw	05h
	movwf	(_CNTbreath_Led2)	;volatile
	clrf	(_CNTbreath_Led2+1)	;volatile
	line	139
	
l7020:	
;light.c: 139: FledBits01.bits.bit_3 = 0;
	bcf	(_FledBits01),3	;volatile
	line	140
;light.c: 140: }
	goto	l966
	line	141
	
l7022:	
;light.c: 141: else if (CNTbreath_Led2 < 10)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	0Ah
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u1551
	goto	u1550
u1551:
	goto	l7030
u1550:
	line	143
	
l7024:	
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
	goto	u1561
	goto	u1560
u1561:
	goto	l966
u1560:
	line	145
	
l7026:	
;light.c: 144: {
;light.c: 145: CNTbreath_Led1 = 0;
	clrf	(_CNTbreath_Led1)	;volatile
	clrf	(_CNTbreath_Led1+1)	;volatile
	line	146
	
l7028:	
;light.c: 146: CNTbreath_Led2--;
	movlw	01h
	subwf	(_CNTbreath_Led2),f	;volatile
	movlw	0
	skipc
	decf	(_CNTbreath_Led2+1),f	;volatile
	subwf	(_CNTbreath_Led2+1),f	;volatile
	goto	l966
	line	149
	
l7030:	
;light.c: 149: else if (CNTbreath_Led2 < 30)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	01Eh
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u1571
	goto	u1570
u1571:
	goto	l7038
u1570:
	line	151
	
l7032:	
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
	goto	u1581
	goto	u1580
u1581:
	goto	l966
u1580:
	goto	l7026
	line	157
	
l7038:	
;light.c: 157: else if (CNTbreath_Led2 < 40)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	028h
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u1591
	goto	u1590
u1591:
	goto	l7046
u1590:
	line	159
	
l7040:	
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
	goto	u1601
	goto	u1600
u1601:
	goto	l966
u1600:
	goto	l7026
	line	165
	
l7046:	
;light.c: 165: else if (CNTbreath_Led2 < 60)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	03Ch
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u1611
	goto	u1610
u1611:
	goto	l7054
u1610:
	line	167
	
l7048:	
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
	goto	u1621
	goto	u1620
u1621:
	goto	l938
u1620:
	goto	l7026
	line	175
	
l7054:	
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
	goto	u1631
	goto	u1630
u1631:
	goto	l938
u1630:
	goto	l7026
	line	185
	
l7060:	
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
	line	188
	
l7062:	
;light.c: 188: FledBits01.bits.bit_3 = 0;
	bcf	(_FledBits01),3	;volatile
	line	189
	
l7064:	
;light.c: 189: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	191
	
l966:	
	return
	opt stack 0
GLOBAL	__end_of_LED_Con
	__end_of_LED_Con:
	signat	_LED_Con,89
	global	_GflushLoop

;; *************** function _GflushLoop *****************
;; Defined at:
;;		line 15 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\flush.c"
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
;; Hardware stack levels required when called:    5
;; This function calls:
;;		_FlushCon
;;		_FlushJudge
;;		_FlushTime
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text15,local,class=CODE,delta=2,merge=1,group=0
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\flush.c"
	line	15
global __ptext15
__ptext15:	;psect for function _GflushLoop
psect	text15
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\flush.c"
	line	15
	global	__size_of_GflushLoop
	__size_of_GflushLoop	equ	__end_of_GflushLoop-_GflushLoop
	
_GflushLoop:	
;incstack = 0
	opt	stack 2
; Regs used in _GflushLoop: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	17
	
l7610:	
;flush.c: 17: FlushTime();
	fcall	_FlushTime
	line	18
	
l7612:	
;flush.c: 18: FlushJudge();
	fcall	_FlushJudge
	line	19
	
l7614:	
;flush.c: 19: FlushCon();
	fcall	_FlushCon
	line	20
	
l2899:	
	return
	opt stack 0
GLOBAL	__end_of_GflushLoop
	__end_of_GflushLoop:
	signat	_GflushLoop,89
	global	_FlushTime

;; *************** function _FlushTime *****************
;; Defined at:
;;		line 22 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\flush.c"
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
	line	22
global __ptext16
__ptext16:	;psect for function _FlushTime
psect	text16
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\flush.c"
	line	22
	global	__size_of_FlushTime
	__size_of_FlushTime	equ	__end_of_FlushTime-_FlushTime
	
_FlushTime:	
;incstack = 0
	opt	stack 4
; Regs used in _FlushTime: []
	line	25
	
l2902:	
	return
	opt stack 0
GLOBAL	__end_of_FlushTime
	__end_of_FlushTime:
	signat	_FlushTime,89
	global	_FlushJudge

;; *************** function _FlushJudge *****************
;; Defined at:
;;		line 26 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\flush.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  Key_Step        1    6[COMMON] unsigned char 
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
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_GkeyLoop
;; This function is called by:
;;		_GflushLoop
;; This function uses a non-reentrant model
;;
psect	text17,local,class=CODE,delta=2,merge=1,group=0
	line	26
global __ptext17
__ptext17:	;psect for function _FlushJudge
psect	text17
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\flush.c"
	line	26
	global	__size_of_FlushJudge
	__size_of_FlushJudge	equ	__end_of_FlushJudge-_FlushJudge
	
_FlushJudge:	
;incstack = 0
	opt	stack 2
; Regs used in _FlushJudge: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	28
	
l7578:	
	line	31
	
l7580:	
;flush.c: 31: if(Fbodysensor.bits.bit_3 == 1)
	btfss	(_Fbodysensor),3	;volatile
	goto	u2691
	goto	u2690
u2691:
	goto	l2905
u2690:
	line	33
	
l7582:	
;flush.c: 32: {
;flush.c: 33: Fflush1.bits.bit_0 = 1;
	bsf	(_Fflush1),0	;volatile
	line	34
;flush.c: 34: Fflush1.bits.bit_2 = 0;
	bcf	(_Fflush1),2	;volatile
	line	35
;flush.c: 35: }
	goto	l2906
	line	36
	
l2905:	
;flush.c: 36: else if(Fbodysensor.bits.bit_4 == 1)
	btfss	(_Fbodysensor),4	;volatile
	goto	u2701
	goto	u2700
u2701:
	goto	l7586
u2700:
	line	38
	
l7584:	
;flush.c: 37: {
;flush.c: 38: Fflush1.bits.bit_2 = 1;
	bsf	(_Fflush1),2	;volatile
	line	39
;flush.c: 39: Fflush1.bits.bit_0 = 0;
	bcf	(_Fflush1),0	;volatile
	line	40
;flush.c: 40: }
	goto	l2906
	line	41
	
l7586:	
;flush.c: 41: else if (SEQflsuh)
	movf	((_SEQflsuh)),w	;volatile
	btfsc	status,2
	goto	u2711
	goto	u2710
u2711:
	goto	l7590
u2710:
	line	43
	
l7588:	
;flush.c: 42: {
;flush.c: 43: Fflush1.bits.bit_2 = 0;
	bcf	(_Fflush1),2	;volatile
	line	44
;flush.c: 44: Fflush1.bits.bit_0 = 0;
	bcf	(_Fflush1),0	;volatile
	line	45
;flush.c: 45: }
	goto	l2906
	line	48
	
l7590:	
;flush.c: 46: else
;flush.c: 47: {
;flush.c: 48: Key_Step = GkeyLoop();
	fcall	_GkeyLoop
	movwf	(FlushJudge@Key_Step)
	line	49
	
l7592:	
;flush.c: 49: if (Key_Step)
	movf	((FlushJudge@Key_Step)),w
	btfsc	status,2
	goto	u2721
	goto	u2720
u2721:
	goto	l7588
u2720:
	line	51
	
l7594:	
;flush.c: 50: {
;flush.c: 51: SEQflsuh = Key_Step;
	movf	(FlushJudge@Key_Step),w
	movwf	(_SEQflsuh)	;volatile
	line	52
	
l7596:	
;flush.c: 52: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	53
	
l7598:	
;flush.c: 53: Fflush1.bits.bit_7 = 1;
	bsf	(_Fflush1),7	;volatile
	line	59
;flush.c: 54: }else
	
l2906:	
	line	76
;flush.c: 58: }
;flush.c: 59: }
;flush.c: 76: if (Fbodysensor.bits.bit_2 == 1)
	btfss	(_Fbodysensor),2	;volatile
	goto	u2731
	goto	u2730
u2731:
	goto	l2913
u2730:
	line	78
	
l7600:	
;flush.c: 77: {
;flush.c: 78: Fflush1.bits.bit_7 = 1;
	bsf	(_Fflush1),7	;volatile
	line	79
	
l2913:	
	line	80
;flush.c: 79: }
;flush.c: 80: if (Fflush1.bits.bit_7 == 1)
	btfss	(_Fflush1),7	;volatile
	goto	u2741
	goto	u2740
u2741:
	goto	l2916
u2740:
	line	82
	
l7602:	
;flush.c: 81: {
;flush.c: 82: if (Fflush1.bits.bit_6 == 1)
	btfss	(_Fflush1),6	;volatile
	goto	u2751
	goto	u2750
u2751:
	goto	l2915
u2750:
	line	84
	
l7604:	
;flush.c: 83: {
;flush.c: 84: Fflush1.bits.bit_2 = 0;
	bcf	(_Fflush1),2	;volatile
	line	85
;flush.c: 85: Fflush1.bits.bit_0 = 0;
	bcf	(_Fflush1),0	;volatile
	line	86
;flush.c: 86: return;
	goto	l2916
	line	87
	
l2915:	
	line	88
;flush.c: 87: }
;flush.c: 88: Fflush1.bits.bit_7 = 0;
	bcf	(_Fflush1),7	;volatile
	line	89
;flush.c: 89: if(Fflush1.bits.bit_0 == 1)
	btfss	(_Fflush1),0	;volatile
	goto	u2761
	goto	u2760
u2761:
	goto	l2917
u2760:
	line	91
	
l7606:	
;flush.c: 90: {
;flush.c: 91: Fflush1.bits.bit_0 = 0;
	bcf	(_Fflush1),0	;volatile
	line	92
;flush.c: 92: Fflush1.bits.bit_1 = 1;
	bsf	(_Fflush1),1	;volatile
	line	93
;flush.c: 93: return;
	goto	l2916
	line	94
	
l2917:	
	line	95
;flush.c: 94: }
;flush.c: 95: if(Fflush1.bits.bit_2 == 1)
	btfss	(_Fflush1),2	;volatile
	goto	u2771
	goto	u2770
u2771:
	goto	l2916
u2770:
	line	97
	
l7608:	
;flush.c: 96: {
;flush.c: 97: Fflush1.bits.bit_2 = 0;
	bcf	(_Fflush1),2	;volatile
	line	98
;flush.c: 98: Fflush1.bits.bit_3 = 1;
	bsf	(_Fflush1),3	;volatile
	line	102
	
l2916:	
	return
	opt stack 0
GLOBAL	__end_of_FlushJudge
	__end_of_FlushJudge:
	signat	_FlushJudge,89
	global	_GkeyLoop

;; *************** function _GkeyLoop *****************
;; Defined at:
;;		line 7 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\key.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_KeyControl
;;		_ScanKey
;; This function is called by:
;;		_FlushJudge
;; This function uses a non-reentrant model
;;
psect	text18,local,class=CODE,delta=2,merge=1,group=0
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\key.c"
	line	7
global __ptext18
__ptext18:	;psect for function _GkeyLoop
psect	text18
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\key.c"
	line	7
	global	__size_of_GkeyLoop
	__size_of_GkeyLoop	equ	__end_of_GkeyLoop-_GkeyLoop
	
_GkeyLoop:	
;incstack = 0
	opt	stack 2
; Regs used in _GkeyLoop: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	9
	
l7540:	
;key.c: 9: for ( SeletedLine = 0; SeletedLine < 2; SeletedLine++)
	clrf	(_SeletedLine)	;volatile
	
l7542:	
	movlw	low(02h)
	subwf	(_SeletedLine),w	;volatile
	skipc
	goto	u2591
	goto	u2590
u2591:
	goto	l7546
u2590:
	goto	l7574
	line	11
	
l7546:	
;key.c: 10: {
;key.c: 11: KeyLines[SeletedLine].flags.level =ScanKey(SeletedLine);
	movf	(_SeletedLine),w	;volatile
	fcall	_ScanKey
	movwf	(??_GkeyLoop+0)+0
	movf	(_SeletedLine),w	;volatile
	movwf	(??_GkeyLoop+1)+0
	movlw	(02h)-1
u2605:
	clrc
	rlf	(??_GkeyLoop+1)+0,f
	addlw	-1
	skipz
	goto	u2605
	clrc
	rlf	(??_GkeyLoop+1)+0,w
	addlw	low(_KeyLines|((0x0)<<8))&0ffh
	movwf	fsr0
	rlf	(??_GkeyLoop+0)+0,f
	rlf	(??_GkeyLoop+0)+0,f
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	xorwf	(??_GkeyLoop+0)+0,w
	andlw	not (((1<<1)-1)<<2)
	xorwf	(??_GkeyLoop+0)+0,w
	movwf	indf
	line	13
	
l7548:	
;key.c: 13: if(KeyLines[SeletedLine].flags.is_forbidden)
	movf	(_SeletedLine),w	;volatile
	movwf	(??_GkeyLoop+0)+0
	movlw	(02h)-1
u2615:
	clrc
	rlf	(??_GkeyLoop+0)+0,f
	addlw	-1
	skipz
	goto	u2615
	clrc
	rlf	(??_GkeyLoop+0)+0,w
	addlw	low(_KeyLines|((0x0)<<8))&0ffh
	movwf	fsr0
	btfss	indf,0
	goto	u2621
	goto	u2620
u2621:
	goto	l7554
u2620:
	line	15
	
l7550:	
;key.c: 14: {
;key.c: 15: if (KeyLines[SeletedLine].flags.level)
	movf	(_SeletedLine),w	;volatile
	movwf	(??_GkeyLoop+0)+0
	movlw	(02h)-1
u2635:
	clrc
	rlf	(??_GkeyLoop+0)+0,f
	addlw	-1
	skipz
	goto	u2635
	clrc
	rlf	(??_GkeyLoop+0)+0,w
	addlw	low(_KeyLines|((0x0)<<8))&0ffh
	movwf	fsr0
	btfss	indf,2
	goto	u2641
	goto	u2640
u2641:
	goto	l7570
u2640:
	line	17
	
l7552:	
;key.c: 16: {
;key.c: 17: KeyLines[SeletedLine].flags.is_forbidden = 0;
	movf	(_SeletedLine),w	;volatile
	movwf	(??_GkeyLoop+0)+0
	movlw	(02h)-1
u2655:
	clrc
	rlf	(??_GkeyLoop+0)+0,f
	addlw	-1
	skipz
	goto	u2655
	clrc
	rlf	(??_GkeyLoop+0)+0,w
	addlw	low(_KeyLines|((0x0)<<8))&0ffh
	movwf	fsr0
	bcf	indf,0
	goto	l7570
	line	21
	
l7554:	
;key.c: 20: }
;key.c: 21: if (KeyControl(&KeyLines[SeletedLine]))
	movf	(_SeletedLine),w	;volatile
	movwf	(??_GkeyLoop+0)+0
	movlw	(02h)-1
u2665:
	clrc
	rlf	(??_GkeyLoop+0)+0,f
	addlw	-1
	skipz
	goto	u2665
	clrc
	rlf	(??_GkeyLoop+0)+0,w
	addlw	low(_KeyLines|((0x0)<<8))&0ffh
	fcall	_KeyControl
	xorlw	0
	skipnz
	goto	u2671
	goto	u2670
u2671:
	goto	l7570
u2670:
	goto	l7568
	line	25
;key.c: 24: {
;key.c: 25: case PortA:
	
l5793:	
	line	26
;key.c: 26: Fflush1.bits.bit_0 = 1;
	bsf	(_Fflush1),0	;volatile
	line	27
;key.c: 27: KeyLines[PortB].flags.is_forbidden = 1;
	bsf	0+(_KeyLines)+04h,0	;volatile
	line	28
	
l7558:	
;key.c: 28: return FLUSH_BIG_0;
	movlw	low(03h)
	goto	l5794
	line	29
;key.c: 29: case PortB:
	
l5795:	
	line	30
;key.c: 30: Fflush1.bits.bit_2 = 1;
	bsf	(_Fflush1),2	;volatile
	line	31
;key.c: 31: KeyLines[PortA].flags.is_forbidden = 1;
	bsf	(_KeyLines),0	;volatile
	line	32
	
l7562:	
;key.c: 32: return FLUSH_SML_0;
	movlw	low(07h)
	goto	l5794
	line	23
	
l7568:	
	movf	(_SeletedLine),w	;volatile
	; Switch size 1, requested type "space"
; Number of cases is 2, Range of values is 0 to 1
; switch strategies available:
; Name         Instructions Cycles
; simple_byte            7     4 (average)
; direct_byte           14     8 (fixed)
; jumptable            260     6 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_push
	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l5793
	xorlw	1^0	; case 1
	skipnz
	goto	l5795
	goto	l7570
	opt asmopt_pop

	line	9
	
l7570:	
	incf	(_SeletedLine),f	;volatile
	
l7572:	
	movlw	low(02h)
	subwf	(_SeletedLine),w	;volatile
	skipc
	goto	u2681
	goto	u2680
u2681:
	goto	l7546
u2680:
	line	40
	
l7574:	
;key.c: 38: }
;key.c: 39: }
;key.c: 40: return 0;
	movlw	low(0)
	line	42
	
l5794:	
	return
	opt stack 0
GLOBAL	__end_of_GkeyLoop
	__end_of_GkeyLoop:
	signat	_GkeyLoop,89
	global	_ScanKey

;; *************** function _ScanKey *****************
;; Defined at:
;;		line 45 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\key.c"
;; Parameters:    Size  Location     Type
;;  line_num        1    wreg     enum E879
;; Auto vars:     Size  Location     Type
;;  line_num        1    2[COMMON] enum E879
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 300/0
;;		On exit  : 300/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         1       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         1       0       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_GkeyLoop
;; This function uses a non-reentrant model
;;
psect	text19,local,class=CODE,delta=2,merge=1,group=0
	line	45
global __ptext19
__ptext19:	;psect for function _ScanKey
psect	text19
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\key.c"
	line	45
	global	__size_of_ScanKey
	__size_of_ScanKey	equ	__end_of_ScanKey-_ScanKey
	
_ScanKey:	
;incstack = 0
	opt	stack 2
; Regs used in _ScanKey: [wreg-fsr0h+status,2+status,0]
;ScanKey@line_num stored from wreg
	movwf	(ScanKey@line_num)
	line	47
	
l6850:	
;key.c: 47: switch (line_num)
	goto	l6862
	line	50
	
l6852:	
;key.c: 50: return RA6;
	movlw	0
	btfsc	(46/8),(46)&7	;volatile
	movlw	1
	goto	l5802
	line	52
	
l6856:	
;key.c: 52: return RB0;
	movlw	0
	btfsc	(48/8),(48)&7	;volatile
	movlw	1
	goto	l5802
	line	47
	
l6862:	
	movf	(ScanKey@line_num),w
	; Switch size 1, requested type "space"
; Number of cases is 2, Range of values is 0 to 1
; switch strategies available:
; Name         Instructions Cycles
; simple_byte            7     4 (average)
; direct_byte           14     8 (fixed)
; jumptable            260     6 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_push
	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l6852
	xorlw	1^0	; case 1
	skipnz
	goto	l6856
	goto	l5802
	opt asmopt_pop

	line	54
	
l5802:	
	return
	opt stack 0
GLOBAL	__end_of_ScanKey
	__end_of_ScanKey:
	signat	_ScanKey,4217
	global	_KeyControl

;; *************** function _KeyControl *****************
;; Defined at:
;;		line 58 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\key.c"
;; Parameters:    Size  Location     Type
;;  this            1    wreg     PTR struct _KEY_PRIVATE
;;		 -> KeyLines(8), 
;; Auto vars:     Size  Location     Type
;;  this            1    6[BANK0 ] PTR struct _KEY_PRIVATE
;;		 -> KeyLines(8), 
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : B00/0
;;		On exit  : B00/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       7       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         2       7       0       0       0
;;Total ram usage:        9 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_GkeyLoop
;; This function uses a non-reentrant model
;;
psect	text20,local,class=CODE,delta=2,merge=1,group=0
	line	58
global __ptext20
__ptext20:	;psect for function _KeyControl
psect	text20
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\key.c"
	line	58
	global	__size_of_KeyControl
	__size_of_KeyControl	equ	__end_of_KeyControl-_KeyControl
	
_KeyControl:	
;incstack = 0
	opt	stack 2
; Regs used in _KeyControl: [wreg-fsr0h+status,2+status,0]
;KeyControl@this stored from wreg
	movwf	(KeyControl@this)
	line	60
	
l7490:	
;key.c: 60: if(!(this->flags.level))
	movf	(KeyControl@this),w
	movwf	fsr0
	btfsc	indf,2
	goto	u2441
	goto	u2440
u2441:
	goto	l7520
u2440:
	line	62
	
l7492:	
;key.c: 61: {
;key.c: 62: if (this->flags.is_pressing)
	movf	(KeyControl@this),w
	movwf	fsr0
	btfss	indf,1
	goto	u2451
	goto	u2450
u2451:
	goto	l7506
u2450:
	line	64
	
l7494:	
;key.c: 63: {
;key.c: 64: this->cnt = 0;
	incf	(KeyControl@this),w
	movwf	fsr0
	clrf	indf
	line	66
	
l7496:	
;key.c: 66: if (((++(this->cnt_timeout)) > (600)?(0 == ((this->cnt_timeout) = 0)):0))
	movf	(KeyControl@this),w
	addlw	02h
	movwf	fsr0
	movlw	01h
	addwf	indf,f
	incf	fsr0,f
	skipnc
	incf	indf,f
	decf	fsr0,f
	movf	indf,w
	movwf	(??_KeyControl+0)+0+0
	incf	fsr0,f
	movf	indf,w
	movwf	(??_KeyControl+0)+0+1
	movlw	02h
	subwf	1+(??_KeyControl+0)+0,w
	movlw	059h
	skipnz
	subwf	0+(??_KeyControl+0)+0,w
	skipnc
	goto	u2461
	goto	u2460
u2461:
	goto	l7500
u2460:
	
l7498:	
	clrf	(_KeyControl$3154)
	clrf	(_KeyControl$3154+1)
	goto	l7502
	
l7500:	
	movf	(KeyControl@this),w
	addlw	02h
	movwf	fsr0
	clrf	indf
	incf	fsr0,f
	clrf	indf
	movlw	low(0)
	movwf	(??_KeyControl+0)+0
	movlw	high(0)
	movwf	(??_KeyControl+0)+0+1
	movf	((??_KeyControl+0)+0),w
iorwf	((??_KeyControl+0)+1),w
	btfsc	status,2
	goto	u2471
	goto	u2470
u2471:
	movlw	1
	goto	u2480
u2470:
	movlw	0
u2480:
	movwf	(_KeyControl$3154)
	clrf	(_KeyControl$3154+1)
	
l7502:	
	movf	((_KeyControl$3154)),w
iorwf	((_KeyControl$3154+1)),w
	btfsc	status,2
	goto	u2491
	goto	u2490
u2491:
	goto	l7536
u2490:
	line	68
	
l7504:	
;key.c: 67: {
;key.c: 68: this->flags.is_forbidden = 1;
	movf	(KeyControl@this),w
	movwf	fsr0
	bsf	indf,0
	goto	l7536
	line	73
	
l7506:	
;key.c: 72: {
;key.c: 73: if (((++(this->cnt)) > (10)?(0 == ((this->cnt) = 0)):0))
	incf	(KeyControl@this),w
	movwf	fsr0
	incf	indf,f
	movlw	low(0Bh)
	subwf	(indf),w
	skipnc
	goto	u2501
	goto	u2500
u2501:
	goto	l7510
u2500:
	
l7508:	
	clrf	(_KeyControl$3155)
	clrf	(_KeyControl$3155+1)
	goto	l7512
	
l7510:	
	incf	(KeyControl@this),w
	movwf	fsr0
	clrf	indf
	movlw	(low(0))&0ffh
	btfsc	status,2
	goto	u2511
	goto	u2510
u2511:
	movlw	1
	goto	u2520
u2510:
	movlw	0
u2520:
	movwf	(_KeyControl$3155)
	clrf	(_KeyControl$3155+1)
	
l7512:	
	movf	((_KeyControl$3155)),w
iorwf	((_KeyControl$3155+1)),w
	btfsc	status,2
	goto	u2531
	goto	u2530
u2531:
	goto	l7536
u2530:
	line	75
	
l7514:	
;key.c: 74: {
;key.c: 75: this->flags.is_pressing = 1;
	movf	(KeyControl@this),w
	movwf	fsr0
	bsf	indf,1
	line	76
	
l7516:	
;key.c: 76: return 1;
	movlw	low(01h)
	goto	l5820
	line	83
	
l7520:	
;key.c: 81: else
;key.c: 82: {
;key.c: 83: if (this->flags.is_pressing)
	movf	(KeyControl@this),w
	movwf	fsr0
	btfss	indf,1
	goto	u2541
	goto	u2540
u2541:
	goto	l7532
u2540:
	line	85
	
l7522:	
;key.c: 84: {
;key.c: 85: if (((++(this->cnt)) > (10)?(0 == ((this->cnt) = 0)):0))
	incf	(KeyControl@this),w
	movwf	fsr0
	incf	indf,f
	movlw	low(0Bh)
	subwf	(indf),w
	skipnc
	goto	u2551
	goto	u2550
u2551:
	goto	l7526
u2550:
	
l7524:	
	clrf	(_KeyControl$3156)
	clrf	(_KeyControl$3156+1)
	goto	l7528
	
l7526:	
	incf	(KeyControl@this),w
	movwf	fsr0
	clrf	indf
	movlw	(low(0))&0ffh
	btfsc	status,2
	goto	u2561
	goto	u2560
u2561:
	movlw	1
	goto	u2570
u2560:
	movlw	0
u2570:
	movwf	(_KeyControl$3156)
	clrf	(_KeyControl$3156+1)
	
l7528:	
	movf	((_KeyControl$3156)),w
iorwf	((_KeyControl$3156+1)),w
	btfsc	status,2
	goto	u2581
	goto	u2580
u2581:
	goto	l7536
u2580:
	line	87
	
l7530:	
;key.c: 86: {
;key.c: 87: this->flags.is_pressing = 0;
	movf	(KeyControl@this),w
	movwf	fsr0
	bcf	indf,1
	goto	l7536
	line	91
	
l7532:	
;key.c: 90: {
;key.c: 91: this->cnt = 0;
	incf	(KeyControl@this),w
	movwf	fsr0
	clrf	indf
	line	92
	
l7534:	
;key.c: 92: this->cnt_timeout = 0;
	movf	(KeyControl@this),w
	addlw	02h
	movwf	fsr0
	clrf	indf
	incf	fsr0,f
	clrf	indf
	line	96
	
l7536:	
;key.c: 93: }
;key.c: 95: }
;key.c: 96: return 0;
	movlw	low(0)
	line	97
	
l5820:	
	return
	opt stack 0
GLOBAL	__end_of_KeyControl
	__end_of_KeyControl:
	signat	_KeyControl,4217
	global	_FlushCon

;; *************** function _FlushCon *****************
;; Defined at:
;;		line 105 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\flush.c"
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
psect	text21,local,class=CODE,delta=2,merge=1,group=0
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\flush.c"
	line	105
global __ptext21
__ptext21:	;psect for function _FlushCon
psect	text21
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\flush.c"
	line	105
	global	__size_of_FlushCon
	__size_of_FlushCon	equ	__end_of_FlushCon-_FlushCon
	
_FlushCon:	
;incstack = 0
	opt	stack 4
; Regs used in _FlushCon: [wreg-fsr0h+status,2+status,0]
	line	107
	
l7102:	
;flush.c: 107: switch (SEQflsuh)
	goto	l7186
	line	109
;flush.c: 108: {
;flush.c: 109: case FLUSH_INIT_0:
	
l2922:	
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
;flush.c: 113: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	114
;flush.c: 114: if((Fflush1.bits.bit_1 == 1) || (Fflush1.bits.bit_3 == 1))
	btfsc	(_Fflush1),1	;volatile
	goto	u1741
	goto	u1740
u1741:
	goto	l7106
u1740:
	
l7104:	
	btfss	(_Fflush1),3	;volatile
	goto	u1751
	goto	u1750
u1751:
	goto	l2953
u1750:
	line	116
	
l7106:	
;flush.c: 115: {
;flush.c: 116: SEQflsuh = FLUSH_INIT_1;
	movlw	low(01h)
	movwf	(_SEQflsuh)	;volatile
	line	117
	
l7108:	
;flush.c: 117: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	goto	l2953
	line	120
;flush.c: 120: case FLUSH_INIT_1:
	
l2927:	
	line	121
;flush.c: 121: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	122
;flush.c: 122: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	123
;flush.c: 123: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	124
;flush.c: 124: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	125
;flush.c: 125: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u1761
	goto	u1760
u1761:
	goto	l7114
u1760:
	line	127
	
l7110:	
;flush.c: 126: {
;flush.c: 127: SEQflsuh = FLUSH_END_0;
	movlw	low(0Ah)
	movwf	(_SEQflsuh)	;volatile
	goto	l7108
	line	131
	
l7114:	
;flush.c: 130: }
;flush.c: 131: if(++CNTflush >= 5)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	05h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1771
	goto	u1770
u1771:
	goto	l2953
u1770:
	line	133
	
l7116:	
;flush.c: 132: {
;flush.c: 133: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	134
	
l7118:	
;flush.c: 134: SEQflsuh = FLUSH_INIT_2;
	movlw	low(02h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2953
	line	137
;flush.c: 137: case FLUSH_INIT_2:
	
l2930:	
	line	138
;flush.c: 138: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	139
;flush.c: 139: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	140
;flush.c: 140: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	141
;flush.c: 141: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	142
;flush.c: 142: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u1781
	goto	u1780
u1781:
	goto	l2931
u1780:
	goto	l7110
	line	147
	
l2931:	
	line	149
;flush.c: 147: }
;flush.c: 149: if(Fflush1.bits.bit_1 == 1)
	btfss	(_Fflush1),1	;volatile
	goto	u1791
	goto	u1790
u1791:
	goto	l2932
u1790:
	line	151
	
l7124:	
;flush.c: 150: {
;flush.c: 151: SEQflsuh = FLUSH_BIG_0;
	movlw	low(03h)
	movwf	(_SEQflsuh)	;volatile
	line	152
;flush.c: 152: }
	goto	l2953
	line	153
	
l2932:	
;flush.c: 153: else if(Fflush1.bits.bit_3 == 1)
	btfss	(_Fflush1),3	;volatile
	goto	u1801
	goto	u1800
u1801:
	goto	l2953
u1800:
	line	155
	
l7126:	
;flush.c: 154: {
;flush.c: 155: SEQflsuh = FLUSH_SML_0;
	movlw	low(07h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2953
	line	158
;flush.c: 158: case FLUSH_BIG_0:
	
l2935:	
	line	159
;flush.c: 159: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	160
;flush.c: 160: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	161
;flush.c: 161: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	162
;flush.c: 162: RA1 = 1;
	bsf	(41/8),(41)&7	;volatile
	line	163
	
l7128:	
;flush.c: 163: if(++CNTflush >= 10)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	0Ah
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1811
	goto	u1810
u1811:
	goto	l2953
u1810:
	line	165
	
l7130:	
;flush.c: 164: {
;flush.c: 165: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	166
	
l7132:	
;flush.c: 166: SEQflsuh = FLUSH_BIG_1;
	movlw	low(04h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2953
	line	169
;flush.c: 169: case FLUSH_BIG_1:
	
l2937:	
	line	170
;flush.c: 170: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	171
;flush.c: 171: RA2 = 1;
	bsf	(42/8),(42)&7	;volatile
	line	172
;flush.c: 172: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	173
;flush.c: 173: RA1 = 1;
	bsf	(41/8),(41)&7	;volatile
	line	175
	
l7134:	
;flush.c: 175: if(++CNTflush >= 100)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	064h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1821
	goto	u1820
u1821:
	goto	l2953
u1820:
	line	177
	
l7136:	
;flush.c: 176: {
;flush.c: 177: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	178
	
l7138:	
;flush.c: 178: SEQflsuh = FLUSH_BIG_2;
	movlw	low(05h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2953
	line	189
;flush.c: 189: case FLUSH_BIG_2:
	
l2939:	
	line	190
;flush.c: 190: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	191
;flush.c: 191: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	192
;flush.c: 192: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	193
;flush.c: 193: RA1 = 1;
	bsf	(41/8),(41)&7	;volatile
	line	194
	
l7140:	
;flush.c: 194: if(++CNTflush >= 10)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	0Ah
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1831
	goto	u1830
u1831:
	goto	l2953
u1830:
	line	196
	
l7142:	
;flush.c: 195: {
;flush.c: 196: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	197
	
l7144:	
;flush.c: 197: SEQflsuh = FLUSH_BIG_3;
	movlw	low(06h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2953
	line	200
;flush.c: 200: case FLUSH_BIG_3:
	
l2941:	
	line	201
;flush.c: 201: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	202
;flush.c: 202: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	203
;flush.c: 203: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	204
;flush.c: 204: RA1 = 1;
	bsf	(41/8),(41)&7	;volatile
	line	205
	
l7146:	
;flush.c: 205: if(++CNTflush >= 200)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	0C8h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1841
	goto	u1840
u1841:
	goto	l2953
u1840:
	line	207
	
l7148:	
;flush.c: 206: {
;flush.c: 207: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	208
	
l7150:	
;flush.c: 208: SEQflsuh = FLUSH_END_0;
	movlw	low(0Ah)
	movwf	(_SEQflsuh)	;volatile
	goto	l2953
	line	211
;flush.c: 211: case FLUSH_SML_0:
	
l2943:	
	line	212
;flush.c: 212: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	213
;flush.c: 213: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	214
;flush.c: 214: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	215
;flush.c: 215: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	216
	
l7152:	
;flush.c: 216: if(++CNTflush >= 5)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	05h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1851
	goto	u1850
u1851:
	goto	l2953
u1850:
	line	218
	
l7154:	
;flush.c: 217: {
;flush.c: 218: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	219
	
l7156:	
;flush.c: 219: SEQflsuh = FLUSH_SML_1;
	movlw	low(08h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2953
	line	222
;flush.c: 222: case FLUSH_SML_1:
	
l2945:	
	line	223
;flush.c: 223: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	224
;flush.c: 224: RA2 = 1;
	bsf	(42/8),(42)&7	;volatile
	line	225
;flush.c: 225: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	226
;flush.c: 226: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	228
	
l7158:	
;flush.c: 228: if(++CNTflush >= 100)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	064h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1861
	goto	u1860
u1861:
	goto	l2953
u1860:
	line	230
	
l7160:	
;flush.c: 229: {
;flush.c: 230: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	231
	
l7162:	
;flush.c: 231: SEQflsuh = FLUSH_SML_2;
	movlw	low(09h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2953
	line	234
;flush.c: 234: case FLUSH_SML_2:
	
l2947:	
	line	235
;flush.c: 235: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	236
;flush.c: 236: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	237
;flush.c: 237: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	238
;flush.c: 238: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	239
	
l7164:	
;flush.c: 239: if(++CNTflush >= 5)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	05h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1871
	goto	u1870
u1871:
	goto	l2953
u1870:
	goto	l7148
	line	246
;flush.c: 246: case FLUSH_END_0:
	
l2949:	
	line	247
;flush.c: 247: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	248
;flush.c: 248: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	249
;flush.c: 249: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	250
;flush.c: 250: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	251
	
l7170:	
;flush.c: 251: if(++CNTflush >= 5)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	05h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1881
	goto	u1880
u1881:
	goto	l2953
u1880:
	line	253
	
l7172:	
;flush.c: 252: {
;flush.c: 253: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	254
	
l7174:	
;flush.c: 254: SEQflsuh = FLUSH_END_1;
	movlw	low(0Bh)
	movwf	(_SEQflsuh)	;volatile
	goto	l2953
	line	257
;flush.c: 257: case FLUSH_END_1:
	
l2951:	
	line	258
;flush.c: 258: Fflush1.bits.bit_6 = 0;
	bcf	(_Fflush1),6	;volatile
	line	259
;flush.c: 259: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	260
;flush.c: 260: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	261
;flush.c: 261: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	262
	
l7176:	
;flush.c: 262: SEQflsuh = FLUSH_INIT_0;
	clrf	(_SEQflsuh)	;volatile
	line	263
;flush.c: 263: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	264
	
l7178:	
;flush.c: 264: Fflush1.bits.bit_1 = 0;
	bcf	(_Fflush1),1	;volatile
	line	265
	
l7180:	
;flush.c: 265: Fflush1.bits.bit_3 = 0;
	bcf	(_Fflush1),3	;volatile
	line	266
;flush.c: 266: break;
	goto	l2953
	line	267
;flush.c: 267: default:
	
l2952:	
	line	268
;flush.c: 268: Fflush1.bits.bit_6 = 0;
	bcf	(_Fflush1),6	;volatile
	line	269
;flush.c: 269: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	270
;flush.c: 270: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	271
;flush.c: 271: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	272
;flush.c: 272: Fflush1.bits.bit_1 = 0;
	bcf	(_Fflush1),1	;volatile
	line	273
;flush.c: 273: Fflush1.bits.bit_3 = 0;
	bcf	(_Fflush1),3	;volatile
	line	274
	
l7182:	
;flush.c: 274: SEQflsuh = FLUSH_INIT_0;
	clrf	(_SEQflsuh)	;volatile
	line	275
;flush.c: 275: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	276
;flush.c: 276: break;
	goto	l2953
	line	107
	
l7186:	
	movf	(_SEQflsuh),w	;volatile
	; Switch size 1, requested type "space"
; Number of cases is 12, Range of values is 0 to 11
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           37    19 (average)
; direct_byte           44     8 (fixed)
; jumptable            260     6 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_push
	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l2922
	xorlw	1^0	; case 1
	skipnz
	goto	l2927
	xorlw	2^1	; case 2
	skipnz
	goto	l2930
	xorlw	3^2	; case 3
	skipnz
	goto	l2935
	xorlw	4^3	; case 4
	skipnz
	goto	l2937
	xorlw	5^4	; case 5
	skipnz
	goto	l2939
	xorlw	6^5	; case 6
	skipnz
	goto	l2941
	xorlw	7^6	; case 7
	skipnz
	goto	l2943
	xorlw	8^7	; case 8
	skipnz
	goto	l2945
	xorlw	9^8	; case 9
	skipnz
	goto	l2947
	xorlw	10^9	; case 10
	skipnz
	goto	l2949
	xorlw	11^10	; case 11
	skipnz
	goto	l2951
	goto	l2952
	opt asmopt_pop

	line	278
	
l2953:	
	return
	opt stack 0
GLOBAL	__end_of_FlushCon
	__end_of_FlushCon:
	signat	_FlushCon,89
	global	_FCTloop

;; *************** function _FCTloop *****************
;; Defined at:
;;		line 23 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
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
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_FCTjudge
;;		_FCTkey
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text22,local,class=CODE,delta=2,merge=1,group=0
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
	line	23
global __ptext22
__ptext22:	;psect for function _FCTloop
psect	text22
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
	line	23
	global	__size_of_FCTloop
	__size_of_FCTloop	equ	__end_of_FCTloop-_FCTloop
	
_FCTloop:	
;incstack = 0
	opt	stack 3
; Regs used in _FCTloop: [wreg+status,2+status,0+pclath+cstack]
	line	25
	
l7422:	
;fct.c: 25: FCTkey();
	fcall	_FCTkey
	line	26
;fct.c: 26: FCTjudge();
	fcall	_FCTjudge
	line	27
	
l4839:	
	return
	opt stack 0
GLOBAL	__end_of_FCTloop
	__end_of_FCTloop:
	signat	_FCTloop,89
	global	_FCTkey

;; *************** function _FCTkey *****************
;; Defined at:
;;		line 52 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
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
;;		_FCTloop
;; This function uses a non-reentrant model
;;
psect	text23,local,class=CODE,delta=2,merge=1,group=0
	line	52
global __ptext23
__ptext23:	;psect for function _FCTkey
psect	text23
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
	line	52
	global	__size_of_FCTkey
	__size_of_FCTkey	equ	__end_of_FCTkey-_FCTkey
	
_FCTkey:	
;incstack = 0
	opt	stack 4
; Regs used in _FCTkey: [wreg+status,2+status,0]
	line	54
	
l7282:	
;fct.c: 54: if((FCT == 0) && (RB2 == 0))
	movf	((_FCT)),w
	btfss	status,2
	goto	u2111
	goto	u2110
u2111:
	goto	l7288
u2110:
	
l7284:	
	btfsc	(50/8),(50)&7	;volatile
	goto	u2121
	goto	u2120
u2121:
	goto	l7288
u2120:
	line	56
	
l7286:	
;fct.c: 55: {
;fct.c: 56: FCT = 3;
	movlw	low(03h)
	movwf	(_FCT)
	line	59
	
l7288:	
;fct.c: 57: }
;fct.c: 59: if(FCT == 3)
		movlw	3
	xorwf	((_FCT)),w
	btfss	status,2
	goto	u2131
	goto	u2130
u2131:
	goto	l7306
u2130:
	line	61
	
l7290:	
;fct.c: 60: {
;fct.c: 61: if(RB2 == 1)
	btfss	(50/8),(50)&7	;volatile
	goto	u2141
	goto	u2140
u2141:
	goto	l7304
u2140:
	line	63
	
l7292:	
	incf	(_My_test_cnt),f
	skipnz
	incf	(_My_test_cnt+1),f
	movlw	0
	subwf	((_My_test_cnt+1)),w
	movlw	065h
	skipnz
	subwf	((_My_test_cnt)),w
	skipc
	goto	u2151
	goto	u2150
u2151:
	goto	l7306
u2150:
	line	65
	
l7294:	
;fct.c: 64: {
;fct.c: 65: if(RB2 == 1)
	btfss	(50/8),(50)&7	;volatile
	goto	u2161
	goto	u2160
u2161:
	goto	l4848
u2160:
	line	67
	
l7296:	
;fct.c: 66: {
;fct.c: 67: fctBits001.bits.bit_0 = 1;
	bsf	(_fctBits001),0	;volatile
	line	68
	
l7298:	
;fct.c: 68: My_test_cnt = 0;
	clrf	(_My_test_cnt)
	clrf	(_My_test_cnt+1)
	line	69
	
l7300:	
;fct.c: 69: FCT = 1;
	clrf	(_FCT)
	incf	(_FCT),f
	goto	l4847
	line	70
	
l7302:	
;fct.c: 70: return;
	goto	l4847
	line	77
	
l7304:	
;fct.c: 75: else
;fct.c: 76: {
;fct.c: 77: My_test_cnt = 0;
	clrf	(_My_test_cnt)
	clrf	(_My_test_cnt+1)
	goto	l7306
	line	78
	
l4848:	
	line	81
	
l7306:	
;fct.c: 78: }
;fct.c: 79: }
;fct.c: 81: if((FCT == 1) && (RB2 == 0))
		decf	((_FCT)),w
	btfss	status,2
	goto	u2171
	goto	u2170
u2171:
	goto	l7312
u2170:
	
l7308:	
	btfsc	(50/8),(50)&7	;volatile
	goto	u2181
	goto	u2180
u2181:
	goto	l7312
u2180:
	line	83
	
l7310:	
;fct.c: 82: {
;fct.c: 83: FCT = 2;
	movlw	low(02h)
	movwf	(_FCT)
	line	86
	
l7312:	
;fct.c: 84: }
;fct.c: 86: if(FCT == 2)
		movlw	2
	xorwf	((_FCT)),w
	btfss	status,2
	goto	u2191
	goto	u2190
u2191:
	goto	l4847
u2190:
	line	88
	
l7314:	
;fct.c: 87: {
;fct.c: 88: if(RB2 == 1)
	btfss	(50/8),(50)&7	;volatile
	goto	u2201
	goto	u2200
u2201:
	goto	l7326
u2200:
	line	90
	
l7316:	
	incf	(_My_test_cnt),f
	skipnz
	incf	(_My_test_cnt+1),f
	movlw	0
	subwf	((_My_test_cnt+1)),w
	movlw	065h
	skipnz
	subwf	((_My_test_cnt)),w
	skipc
	goto	u2211
	goto	u2210
u2211:
	goto	l4847
u2210:
	line	93
	
l7318:	
;fct.c: 91: {
;fct.c: 93: if(RB2 == 1)
	btfss	(50/8),(50)&7	;volatile
	goto	u2221
	goto	u2220
u2221:
	goto	l7302
u2220:
	line	95
	
l7320:	
;fct.c: 94: {
;fct.c: 95: fctBits001.bits.bit_0 = 0;
	bcf	(_fctBits001),0	;volatile
	line	96
	
l7322:	
;fct.c: 96: My_test_cnt = 0;
	clrf	(_My_test_cnt)
	clrf	(_My_test_cnt+1)
	line	97
;fct.c: 97: FCT = 0;
	clrf	(_FCT)
	goto	l4847
	line	105
	
l7326:	
;fct.c: 103: else
;fct.c: 104: {
;fct.c: 105: My_test_cnt = 0;
	clrf	(_My_test_cnt)
	clrf	(_My_test_cnt+1)
	line	109
	
l4847:	
	return
	opt stack 0
GLOBAL	__end_of_FCTkey
	__end_of_FCTkey:
	signat	_FCTkey,89
	global	_FCTjudge

;; *************** function _FCTjudge *****************
;; Defined at:
;;		line 143 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
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
;;		_G_KEY
;;		_R_KEY
;;		_key1
;;		_key2
;; This function is called by:
;;		_FCTloop
;; This function uses a non-reentrant model
;;
psect	text24,local,class=CODE,delta=2,merge=1,group=0
	line	143
global __ptext24
__ptext24:	;psect for function _FCTjudge
psect	text24
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
	line	143
	global	__size_of_FCTjudge
	__size_of_FCTjudge	equ	__end_of_FCTjudge-_FCTjudge
	
_FCTjudge:	
;incstack = 0
	opt	stack 3
; Regs used in _FCTjudge: [wreg+status,2+status,0+pclath+cstack]
	line	145
	
l7328:	
;fct.c: 145: if(fctBits001.bits.bit_0 == 1)
	btfss	(_fctBits001),0	;volatile
	goto	u2231
	goto	u2230
u2231:
	goto	l4869
u2230:
	line	147
	
l7330:	
;fct.c: 146: {
;fct.c: 147: if(++flag_time == 1500)
	incf	(_flag_time),f	;volatile
	skipnz
	incf	(_flag_time+1),f	;volatile
		movlw	220
	xorwf	(((_flag_time))),w	;volatile
	movlw	5
	skipnz
	xorwf	(((_flag_time+1))),w	;volatile
	btfss	status,2
	goto	u2241
	goto	u2240
u2241:
	goto	l7336
u2240:
	line	149
	
l7332:	
;fct.c: 148: {
;fct.c: 149: fctBits001.bits.bit_0 = 0;
	bcf	(_fctBits001),0	;volatile
	line	150
	
l7334:	
;fct.c: 150: flag_time = 0;
	clrf	(_flag_time)	;volatile
	clrf	(_flag_time+1)	;volatile
	line	152
	
l7336:	
;fct.c: 151: }
;fct.c: 152: if(RB1 == 0)
	btfsc	(49/8),(49)&7	;volatile
	goto	u2251
	goto	u2250
u2251:
	goto	l4871
u2250:
	line	154
	
l7338:	
;fct.c: 153: {
;fct.c: 154: R_KEY();
	fcall	_R_KEY
	line	155
;fct.c: 155: }
	goto	l4879
	line	156
	
l4871:	
	line	158
;fct.c: 156: else
;fct.c: 157: {
;fct.c: 158: if(RA6 == 0)
	btfsc	(46/8),(46)&7	;volatile
	goto	u2261
	goto	u2260
u2261:
	goto	l4873
u2260:
	line	160
	
l7340:	
;fct.c: 159: {
;fct.c: 160: key1();
	fcall	_key1
	line	161
;fct.c: 161: }
	goto	l4879
	line	162
	
l4873:	
	line	164
;fct.c: 162: else
;fct.c: 163: {
;fct.c: 164: if(RB0 == 0)
	btfsc	(48/8),(48)&7	;volatile
	goto	u2271
	goto	u2270
u2271:
	goto	l7344
u2270:
	line	166
	
l7342:	
;fct.c: 165: {
;fct.c: 166: key2();
	fcall	_key2
	line	167
;fct.c: 167: }
	goto	l4879
	line	170
	
l7344:	
;fct.c: 168: else
;fct.c: 169: {
;fct.c: 170: G_KEY();
	fcall	_G_KEY
	goto	l4879
	line	175
	
l4869:	
;fct.c: 175: else if(fctBits001.bits.bit_0 == 0)
	btfsc	(_fctBits001),0	;volatile
	goto	u2281
	goto	u2280
u2281:
	goto	l4879
u2280:
	line	177
	
l7346:	
;fct.c: 176: {
;fct.c: 177: flag_time = 0;
	clrf	(_flag_time)	;volatile
	clrf	(_flag_time+1)	;volatile
	line	179
	
l4879:	
	return
	opt stack 0
GLOBAL	__end_of_FCTjudge
	__end_of_FCTjudge:
	signat	_FCTjudge,89
	global	_key2

;; *************** function _key2 *****************
;; Defined at:
;;		line 135 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
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
;;		_FCTjudge
;; This function uses a non-reentrant model
;;
psect	text25,local,class=CODE,delta=2,merge=1,group=0
	line	135
global __ptext25
__ptext25:	;psect for function _key2
psect	text25
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
	line	135
	global	__size_of_key2
	__size_of_key2	equ	__end_of_key2-_key2
	
_key2:	
;incstack = 0
	opt	stack 3
; Regs used in _key2: []
	line	137
	
l6958:	
;fct.c: 137: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	138
;fct.c: 138: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	139
;fct.c: 139: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	140
;fct.c: 140: RA1 = 1;
	bsf	(41/8),(41)&7	;volatile
	line	141
	
l4866:	
	return
	opt stack 0
GLOBAL	__end_of_key2
	__end_of_key2:
	signat	_key2,89
	global	_key1

;; *************** function _key1 *****************
;; Defined at:
;;		line 127 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
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
;;		_FCTjudge
;; This function uses a non-reentrant model
;;
psect	text26,local,class=CODE,delta=2,merge=1,group=0
	line	127
global __ptext26
__ptext26:	;psect for function _key1
psect	text26
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
	line	127
	global	__size_of_key1
	__size_of_key1	equ	__end_of_key1-_key1
	
_key1:	
;incstack = 0
	opt	stack 3
; Regs used in _key1: []
	line	129
	
l6956:	
;fct.c: 129: RA5 = 1;
	bsf	(45/8),(45)&7	;volatile
	line	130
;fct.c: 130: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	131
;fct.c: 131: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	132
;fct.c: 132: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	133
	
l4863:	
	return
	opt stack 0
GLOBAL	__end_of_key1
	__end_of_key1:
	signat	_key1,89
	global	_R_KEY

;; *************** function _R_KEY *****************
;; Defined at:
;;		line 119 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
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
;;		_FCTjudge
;; This function uses a non-reentrant model
;;
psect	text27,local,class=CODE,delta=2,merge=1,group=0
	line	119
global __ptext27
__ptext27:	;psect for function _R_KEY
psect	text27
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
	line	119
	global	__size_of_R_KEY
	__size_of_R_KEY	equ	__end_of_R_KEY-_R_KEY
	
_R_KEY:	
;incstack = 0
	opt	stack 3
; Regs used in _R_KEY: []
	line	121
	
l6954:	
;fct.c: 121: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	122
;fct.c: 122: RA2 = 1;
	bsf	(42/8),(42)&7	;volatile
	line	123
;fct.c: 123: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	124
;fct.c: 124: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	125
	
l4860:	
	return
	opt stack 0
GLOBAL	__end_of_R_KEY
	__end_of_R_KEY:
	signat	_R_KEY,89
	global	_G_KEY

;; *************** function _G_KEY *****************
;; Defined at:
;;		line 111 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
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
;;		_FCTjudge
;; This function uses a non-reentrant model
;;
psect	text28,local,class=CODE,delta=2,merge=1,group=0
	line	111
global __ptext28
__ptext28:	;psect for function _G_KEY
psect	text28
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\fct.c"
	line	111
	global	__size_of_G_KEY
	__size_of_G_KEY	equ	__end_of_G_KEY-_G_KEY
	
_G_KEY:	
;incstack = 0
	opt	stack 3
; Regs used in _G_KEY: []
	line	113
	
l6952:	
;fct.c: 113: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	114
;fct.c: 114: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	115
;fct.c: 115: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	116
;fct.c: 116: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	117
	
l4857:	
	return
	opt stack 0
GLOBAL	__end_of_G_KEY
	__end_of_G_KEY:
	signat	_G_KEY,89
	global	_Delay_nms

;; *************** function _Delay_nms *****************
;; Defined at:
;;		line 35 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
;; Parameters:    Size  Location     Type
;;  inittempl       2    4[COMMON] unsigned int 
;; Auto vars:     Size  Location     Type
;;  i               2    6[COMMON] unsigned int 
;;  gtemp           1    8[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 300/100
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         2       0       0       0       0
;;      Locals:         3       0       0       0       0
;;      Temps:          0       0       0       0       0
;;      Totals:         5       0       0       0       0
;;Total ram usage:        5 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		_Delay
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text29,local,class=CODE,delta=2,merge=1,group=0
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
	line	35
global __ptext29
__ptext29:	;psect for function _Delay_nms
psect	text29
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
	line	35
	global	__size_of_Delay_nms
	__size_of_Delay_nms	equ	__end_of_Delay_nms-_Delay_nms
	
_Delay_nms:	
;incstack = 0
	opt	stack 4
; Regs used in _Delay_nms: [wreg+status,2+status,0+pclath+cstack]
	line	40
	
l7366:	
;main.c: 37: unsigned int i;
;main.c: 38: unsigned char gtemp;
;main.c: 40: gtemp = 0;
	clrf	(Delay_nms@gtemp)
	line	41
	
l7368:	
;main.c: 41: if (GIE == 1)
	btfss	(95/8),(95)&7	;volatile
	goto	u2331
	goto	u2330
u2331:
	goto	l7372
u2330:
	line	43
	
l7370:	
;main.c: 42: {
;main.c: 43: gtemp = 1;
	clrf	(Delay_nms@gtemp)
	incf	(Delay_nms@gtemp),f
	line	44
;main.c: 44: GIE = 0;
	bcf	(95/8),(95)&7	;volatile
	line	46
	
l7372:	
;main.c: 45: }
;main.c: 46: for (i = 0; i < inittempl; i++)
	clrf	(Delay_nms@i)
	clrf	(Delay_nms@i+1)
	goto	l7378
	line	48
	
l7374:	
;main.c: 47: {
;main.c: 48: Delay(154);
	movlw	09Ah
	movwf	(Delay@dtemp)
	clrf	(Delay@dtemp+1)
	fcall	_Delay
	line	49
# 49 "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
clrwdt ;# 
psect	text29
	line	46
	
l7376:	
	incf	(Delay_nms@i),f
	skipnz
	incf	(Delay_nms@i+1),f
	
l7378:	
	movf	(Delay_nms@inittempl+1),w
	subwf	(Delay_nms@i+1),w
	skipz
	goto	u2345
	movf	(Delay_nms@inittempl),w
	subwf	(Delay_nms@i),w
u2345:
	skipc
	goto	u2341
	goto	u2340
u2341:
	goto	l7374
u2340:
	line	51
	
l7380:	
;main.c: 50: }
;main.c: 51: if (gtemp == 1)
		decf	((Delay_nms@gtemp)),w
	btfss	status,2
	goto	u2351
	goto	u2350
u2351:
	goto	l1905
u2350:
	line	52
	
l7382:	
;main.c: 52: GIE = 1;
	bsf	(95/8),(95)&7	;volatile
	line	53
	
l1905:	
	return
	opt stack 0
GLOBAL	__end_of_Delay_nms
	__end_of_Delay_nms:
	signat	_Delay_nms,4217
	global	_Delay

;; *************** function _Delay *****************
;; Defined at:
;;		line 27 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
;; Parameters:    Size  Location     Type
;;  dtemp           2    2[COMMON] unsigned int 
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;                  1    wreg      void 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/100
;;		On exit  : 0/0
;;		Unchanged: 0/0
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
psect	text30,local,class=CODE,delta=2,merge=1,group=0
	line	27
global __ptext30
__ptext30:	;psect for function _Delay
psect	text30
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
	line	27
	global	__size_of_Delay
	__size_of_Delay	equ	__end_of_Delay-_Delay
	
_Delay:	
;incstack = 0
	opt	stack 4
; Regs used in _Delay: [wreg+status,2+status,0]
	line	29
	
l7066:	
;main.c: 29: while (dtemp--)
	
l7068:	
	movlw	01h
	subwf	(Delay@dtemp),f
	movlw	0
	skipc
	decf	(Delay@dtemp+1),f
	subwf	(Delay@dtemp+1),f
		incf	(((Delay@dtemp))),w
	skipz
	goto	u1641
	incf	(((Delay@dtemp+1))),w
	btfss	status,2
	goto	u1641
	goto	u1640
u1641:
	goto	l7068
u1640:
	line	31
	
l1897:	
	return
	opt stack 0
GLOBAL	__end_of_Delay
	__end_of_Delay:
	signat	_Delay,4217
	global	_Int_ALL

;; *************** function _Int_ALL *****************
;; Defined at:
;;		line 563 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
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
psect	text31,local,class=CODE,delta=2,merge=1,group=0
	line	563
global __ptext31
__ptext31:	;psect for function _Int_ALL
psect	text31
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\main.c"
	line	563
	global	__size_of_Int_ALL
	__size_of_Int_ALL	equ	__end_of_Int_ALL-_Int_ALL
	
_Int_ALL:	
;incstack = 0
	opt	stack 2
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
psect	text31
	line	566
	
i1l7474:	
;main.c: 566: if (TMR1IF)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(96/8),(96)&7	;volatile
	goto	u241_21
	goto	u241_20
u241_21:
	goto	i1l7484
u241_20:
	line	573
	
i1l7476:	
;main.c: 567: {
;main.c: 573: TMR1 = 0xE0C0;
	movlw	0E0h
	movwf	(14+1)	;volatile
	movlw	0C0h
	movwf	(14)	;volatile
	line	574
;main.c: 574: TMR1IF = 0;
	bcf	(96/8),(96)&7	;volatile
	line	577
;main.c: 577: Fsys1.bits.bit_1 = 1;
	bsf	(_Fsys1),1	;volatile
	line	580
	
i1l7478:	
;main.c: 580: if (++MainTime_1s >= 1000)
	incf	(_MainTime_1s),f	;volatile
	skipnz
	incf	(_MainTime_1s+1),f	;volatile
	movlw	03h
	subwf	((_MainTime_1s+1)),w	;volatile
	movlw	0E8h
	skipnz
	subwf	((_MainTime_1s)),w	;volatile
	skipc
	goto	u242_21
	goto	u242_20
u242_21:
	goto	i1l7484
u242_20:
	line	582
	
i1l7480:	
;main.c: 581: {
;main.c: 582: MainTime_1s = 0;
	clrf	(_MainTime_1s)	;volatile
	clrf	(_MainTime_1s+1)	;volatile
	line	583
	
i1l7482:	
;main.c: 583: Fsys1s.byte = 0xFF;
	movlw	low(0FFh)
	movwf	(_Fsys1s)	;volatile
	line	595
	
i1l7484:	
;main.c: 591: }
;main.c: 592: }
;main.c: 595: if (TMR2IF)
	btfss	(97/8),(97)&7	;volatile
	goto	u243_21
	goto	u243_20
u243_21:
	goto	i1l1988
u243_20:
	line	597
	
i1l7486:	
;main.c: 596: {
;main.c: 597: TMR2IF = 0;
	bcf	(97/8),(97)&7	;volatile
	line	598
	
i1l7488:	
;main.c: 598: INT_LED_SHOW();
	fcall	_INT_LED_SHOW
	line	657
	
i1l1988:	
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
;;		line 193 in file "C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
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
psect	text32,local,class=CODE,delta=2,merge=1,group=0
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
	line	193
global __ptext32
__ptext32:	;psect for function _INT_LED_SHOW
psect	text32
	file	"C:\Users\ÍôÇ¿Éý\Desktop\ABM007_FM3\ABM007_FM3\source\light.c"
	line	193
	global	__size_of_INT_LED_SHOW
	__size_of_INT_LED_SHOW	equ	__end_of_INT_LED_SHOW-_INT_LED_SHOW
	
_INT_LED_SHOW:	
;incstack = 0
	opt	stack 2
; Regs used in _INT_LED_SHOW: [wreg+status,2+status,0]
	line	196
	
i1l7352:	
;light.c: 196: if((FledBits01.bits.bit_0 == 1) && (fctBits001.bits.bit_0 == 0))
	btfss	(_FledBits01),0	;volatile
	goto	u229_21
	goto	u229_20
u229_21:
	goto	i1l973
u229_20:
	
i1l7354:	
	btfsc	(_fctBits001),0	;volatile
	goto	u230_21
	goto	u230_20
u230_21:
	goto	i1l973
u230_20:
	line	198
	
i1l7356:	
;light.c: 197: {
;light.c: 198: if (++CNTbreath_Led == 80)
	incf	(_CNTbreath_Led),f	;volatile
	skipnz
	incf	(_CNTbreath_Led+1),f	;volatile
		movlw	80
	xorwf	(((_CNTbreath_Led))),w	;volatile
iorwf	(((_CNTbreath_Led+1))),w	;volatile
	btfss	status,2
	goto	u231_21
	goto	u231_20
u231_21:
	goto	i1l7362
u231_20:
	line	200
	
i1l7358:	
;light.c: 199: {
;light.c: 200: CNTbreath_Led = 0;
	clrf	(_CNTbreath_Led)	;volatile
	clrf	(_CNTbreath_Led+1)	;volatile
	line	201
	
i1l7360:	
;light.c: 201: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	203
	
i1l7362:	
;light.c: 202: }
;light.c: 203: if (CNTbreath_Led >= CNTbreath_Led2)
	movf	(_CNTbreath_Led2+1),w	;volatile
	subwf	(_CNTbreath_Led+1),w	;volatile
	skipz
	goto	u232_25
	movf	(_CNTbreath_Led2),w	;volatile
	subwf	(_CNTbreath_Led),w	;volatile
u232_25:
	skipc
	goto	u232_21
	goto	u232_20
u232_21:
	goto	i1l971
u232_20:
	line	205
	
i1l7364:	
;light.c: 204: {
;light.c: 205: RA5 = 1;
	bsf	(45/8),(45)&7	;volatile
	line	206
;light.c: 206: }
	goto	i1l973
	line	207
	
i1l971:	
	line	209
;light.c: 207: else
;light.c: 208: {
;light.c: 209: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	212
	
i1l973:	
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

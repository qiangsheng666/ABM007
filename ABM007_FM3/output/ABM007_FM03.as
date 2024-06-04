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
	FNCALL	_FCTkey,_Delay_nms
	FNCALL	_Delay_nms,_Delay
	FNCALL	_FCTjudge,_G_KEY
	FNCALL	_FCTjudge,_R_KEY
	FNCALL	_FCTjudge,_key1
	FNCALL	_FCTjudge,_key2
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
	global	_CurrentIO
	global	_CNTfctFlashLed
	global	_CNTfctSensior
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

_CurrentIO:
       ds      1

_CNTfctFlashLed:
       ds      1

_CNTfctSensior:
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
	movlw	low((__pbssBANK0)+03Ah)
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
??_FlushTime:	; 1 bytes @ 0x2
??_FlushCon:	; 1 bytes @ 0x2
??_SensorKey:	; 1 bytes @ 0x2
??_SensorTime:	; 1 bytes @ 0x2
??_SensorJudge:	; 1 bytes @ 0x2
??_SensorControl:	; 1 bytes @ 0x2
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
??_FCTloop:	; 1 bytes @ 0x9
??_FCTkey:	; 1 bytes @ 0x9
??_main:	; 1 bytes @ 0x9
psect	cstackBANK0,class=BANK0,space=1,noexec
global __pcstackBANK0
__pcstackBANK0:
	global	_KeyControl$3140
_KeyControl$3140:	; 2 bytes @ 0x0
	ds	2
	global	_KeyControl$3141
_KeyControl$3141:	; 2 bytes @ 0x2
	ds	2
	global	_KeyControl$3142
_KeyControl$3142:	; 2 bytes @ 0x4
	ds	2
	global	KeyControl@this
KeyControl@this:	; 1 bytes @ 0x6
	ds	1
;!
;!Data Sizes:
;!    Strings     0
;!    Constant    0
;!    Data        0
;!    BSS         60
;!    Persistent  0
;!    Stack       0
;!
;!Auto Spaces:
;!    Space          Size  Autos    Used
;!    COMMON           14      9      11
;!    BANK0            80      7      65
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
;!    _FCTkey->_Delay_nms
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
;! (0) _main                                                 0     0      0    1395
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
;! (1) _FCTloop                                              0     0      0     348
;!                           _FCTjudge
;!                             _FCTkey
;! ---------------------------------------------------------------------------------
;! (2) _FCTkey                                               0     0      0     348
;!                          _Delay_nms
;! ---------------------------------------------------------------------------------
;! (3) _Delay_nms                                            5     3      2     348
;!                                              4 COMMON     5     3      2
;!                              _Delay
;! ---------------------------------------------------------------------------------
;! (4) _Delay                                                2     0      2      86
;!                                              2 COMMON     2     0      2
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
;!       _Delay_nms
;!         _Delay
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
;!BANK0               50      7      41       4       81.3%
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
;!ABS                  0      0      4C      11        0.0%
;!DATA                 0      0      4C      12        0.0%

	global	_main

;; *************** function _main *****************
;; Defined at:
;;		line 473 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
	line	473
global __pmaintext
__pmaintext:	;psect for function _main
psect	maintext
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
	line	473
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
;incstack = 0
	opt	stack 2
; Regs used in _main: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	476
	
l7515:	
# 476 "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
nop ;# 
	line	477
# 477 "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
clrwdt ;# 
psect	maintext
	line	478
	
l7517:	
;main.c: 478: INTCON = 0;
	clrf	(11)	;volatile
	line	480
	
l7519:	
;main.c: 480: Init_GPIO();
	fcall	_Init_GPIO
	line	481
	
l7521:	
;main.c: 481: Init_IC();
	fcall	_Init_IC
	line	482
	
l7523:	
;main.c: 482: Delay_nms(200);
	movlw	0C8h
	movwf	(Delay_nms@inittempl)
	clrf	(Delay_nms@inittempl+1)
	fcall	_Delay_nms
	line	483
	
l7525:	
;main.c: 483: Init_TIMER1();
	fcall	_Init_TIMER1
	line	484
	
l7527:	
;main.c: 484: Init_TIMER2();
	fcall	_Init_TIMER2
	line	495
	
l7529:	
;main.c: 495: INTCON = 0XC0;
	movlw	low(0C0h)
	movwf	(11)	;volatile
	line	501
	
l7531:	
;main.c: 499: {
;main.c: 501: if (Fsys1.bits.bit_1 == 1)
	btfss	(_Fsys1),1	;volatile
	goto	u2611
	goto	u2610
u2611:
	goto	l7531
u2610:
	line	503
	
l7533:	
# 503 "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
clrwdt ;# 
psect	maintext
	line	505
;main.c: 505: Fsys1.bits.bit_1 = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(_Fsys1),1	;volatile
	line	506
;main.c: 506: switch (SEQmain)
	goto	l7545
	line	509
	
l7535:	
;main.c: 509: FCTloop();
	fcall	_FCTloop
	line	510
;main.c: 510: break;
	goto	l7547
	line	511
;main.c: 511: case 1:
	
l1956:	
	line	512
;main.c: 512: if(fctBits001.bits.bit_0 == 0)
	btfsc	(_fctBits001),0	;volatile
	goto	u2621
	goto	u2620
u2621:
	goto	l7547
u2620:
	line	514
	
l7537:	
;main.c: 513: {
;main.c: 514: GsensorLoop();
	fcall	_GsensorLoop
	goto	l7547
	line	523
;main.c: 523: case 4:
	
l1960:	
	line	524
;main.c: 524: if(fctBits001.bits.bit_0 == 0)
	btfsc	(_fctBits001),0	;volatile
	goto	u2631
	goto	u2630
u2631:
	goto	l7547
u2630:
	line	526
	
l7539:	
;main.c: 525: {
;main.c: 526: GflushLoop();
	fcall	_GflushLoop
	goto	l7547
	line	538
;main.c: 538: case 8:
	
l1965:	
	line	539
;main.c: 539: if(fctBits001.bits.bit_0 == 0)
	btfsc	(_fctBits001),0	;volatile
	goto	u2641
	goto	u2640
u2641:
	goto	l7547
u2640:
	line	541
	
l7541:	
;main.c: 540: {
;main.c: 541: GledLoop();
	fcall	_GledLoop
	goto	l7547
	line	506
	
l7545:	
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
	goto	l7535
	xorlw	1^0	; case 1
	skipnz
	goto	l1956
	xorlw	2^1	; case 2
	skipnz
	goto	l7547
	xorlw	3^2	; case 3
	skipnz
	goto	l7547
	xorlw	4^3	; case 4
	skipnz
	goto	l1960
	xorlw	5^4	; case 5
	skipnz
	goto	l7547
	xorlw	6^5	; case 6
	skipnz
	goto	l7547
	xorlw	7^6	; case 7
	skipnz
	goto	l7547
	xorlw	8^7	; case 8
	skipnz
	goto	l1965
	xorlw	9^8	; case 9
	skipnz
	goto	l7547
	goto	l7547
	opt asmopt_pop

	line	551
	
l7547:	
;main.c: 551: if (++SEQmain >= 10)
	movlw	low(0Ah)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	incf	(_SEQmain),f	;volatile
	subwf	((_SEQmain)),w	;volatile
	skipc
	goto	u2651
	goto	u2650
u2651:
	goto	l7531
u2650:
	line	553
	
l7549:	
;main.c: 552: {
;main.c: 553: SEQmain = 0;
	clrf	(_SEQmain)	;volatile
	goto	l7531
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
;;		line 174 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
	line	174
	global	__size_of_Init_TIMER2
	__size_of_Init_TIMER2	equ	__end_of_Init_TIMER2-_Init_TIMER2
	
_Init_TIMER2:	
;incstack = 0
	opt	stack 5
; Regs used in _Init_TIMER2: [wreg]
	line	176
	
l7315:	
;main.c: 176: PR2 = 24;
	movlw	low(018h)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(146)^080h	;volatile
	line	177
	
l7317:	
;main.c: 177: TMR2IF = 0;
	bcf	status, 5	;RP0=0, select bank0
	bcf	(97/8),(97)&7	;volatile
	line	178
	
l7319:	
;main.c: 178: TMR2IE = 1;
	bsf	status, 5	;RP0=1, select bank1
	bsf	(1121/8)^080h,(1121)&7	;volatile
	line	179
;main.c: 179: T2CON = 5;
	movlw	low(05h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(18)	;volatile
	line	180
	
l1909:	
	return
	opt stack 0
GLOBAL	__end_of_Init_TIMER2
	__end_of_Init_TIMER2:
	signat	_Init_TIMER2,89
	global	_Init_TIMER1

;; *************** function _Init_TIMER1 *****************
;; Defined at:
;;		line 152 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
	line	152
	global	__size_of_Init_TIMER1
	__size_of_Init_TIMER1	equ	__end_of_Init_TIMER1-_Init_TIMER1
	
_Init_TIMER1:	
;incstack = 0
	opt	stack 5
; Regs used in _Init_TIMER1: [wreg]
	line	156
	
l7311:	
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
	
l7313:	
;main.c: 159: T1CON = 0x01;
	movlw	low(01h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(16)	;volatile
	line	160
	
l1906:	
	return
	opt stack 0
GLOBAL	__end_of_Init_TIMER1
	__end_of_Init_TIMER1:
	signat	_Init_TIMER1,89
	global	_Init_IC

;; *************** function _Init_IC *****************
;; Defined at:
;;		line 96 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
	line	96
	global	__size_of_Init_IC
	__size_of_Init_IC	equ	__end_of_Init_IC-_Init_IC
	
_Init_IC:	
;incstack = 0
	opt	stack 5
; Regs used in _Init_IC: [wreg+status,2]
	line	98
	
l7297:	
# 98 "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
clrwdt ;# 
psect	text3
	line	103
	
l7299:	
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
	
l7301:	
;main.c: 118: WDTCON = 0x01;
	movlw	low(01h)
	bsf	status, 6	;RP1=1, select bank2
	movwf	(261)^0100h	;volatile
	line	123
	
l7303:	
;main.c: 123: OPTION_REG = 0b00001110;
	movlw	low(0Eh)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(129)^080h	;volatile
	line	128
	
l7305:	
;main.c: 128: OSCCON = 0x71;
	movlw	low(071h)
	movwf	(143)^080h	;volatile
	line	133
	
l7307:	
;main.c: 133: PIE1 = 0;
	clrf	(140)^080h	;volatile
	line	138
	
l7309:	
;main.c: 138: PIE2 = 0;
	clrf	(141)^080h	;volatile
	line	139
	
l1903:	
	return
	opt stack 0
GLOBAL	__end_of_Init_IC
	__end_of_Init_IC:
	signat	_Init_IC,89
	global	_Init_GPIO

;; *************** function _Init_GPIO *****************
;; Defined at:
;;		line 62 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
	line	62
	global	__size_of_Init_GPIO
	__size_of_Init_GPIO	equ	__end_of_Init_GPIO-_Init_GPIO
	
_Init_GPIO:	
;incstack = 0
	opt	stack 5
; Regs used in _Init_GPIO: [wreg+status,2]
	line	66
	
l7283:	
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
	
l7285:	
;main.c: 68: PORTC = 0B00000000;
	clrf	(7)	;volatile
	line	71
	
l7287:	
;main.c: 71: TRISA = 0B01000000;
	movlw	low(040h)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(133)^080h	;volatile
	line	72
	
l7289:	
;main.c: 72: TRISB = 0B00000111;
	movlw	low(07h)
	movwf	(134)^080h	;volatile
	line	73
	
l7291:	
;main.c: 73: TRISC = 0B00000000;
	clrf	(135)^080h	;volatile
	line	76
	
l7293:	
;main.c: 76: WPUA = 0B00000000;
	bsf	status, 6	;RP1=1, select bank3
	clrf	(398)^0180h	;volatile
	line	77
	
l7295:	
;main.c: 77: WPUB = 0B00000010;
	movlw	low(02h)
	bcf	status, 6	;RP1=0, select bank1
	movwf	(149)^080h	;volatile
	line	78
;main.c: 78: WPUC = 0B00000000;
	bsf	status, 6	;RP1=1, select bank3
	clrf	(399)^0180h	;volatile
	line	87
	
l1900:	
	return
	opt stack 0
GLOBAL	__end_of_Init_GPIO
	__end_of_Init_GPIO:
	signat	_Init_GPIO,89
	global	_GsensorLoop

;; *************** function _GsensorLoop *****************
;; Defined at:
;;		line 19 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\sensor.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\sensor.c"
	line	19
global __ptext5
__ptext5:	;psect for function _GsensorLoop
psect	text5
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\sensor.c"
	line	19
	global	__size_of_GsensorLoop
	__size_of_GsensorLoop	equ	__end_of_GsensorLoop-_GsensorLoop
	
_GsensorLoop:	
;incstack = 0
	opt	stack 4
; Regs used in _GsensorLoop: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	21
	
l7323:	
;sensor.c: 21: SensorKey();
	fcall	_SensorKey
	line	22
	
l7325:	
;sensor.c: 22: SensorTime();
	fcall	_SensorTime
	line	23
	
l7327:	
;sensor.c: 23: SensorJudge();
	fcall	_SensorJudge
	line	24
	
l7329:	
;sensor.c: 24: SensorControl();
	fcall	_SensorControl
	line	25
	
l3856:	
	return
	opt stack 0
GLOBAL	__end_of_GsensorLoop
	__end_of_GsensorLoop:
	signat	_GsensorLoop,89
	global	_SensorTime

;; *************** function _SensorTime *****************
;; Defined at:
;;		line 33 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\sensor.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\sensor.c"
	line	33
	global	__size_of_SensorTime
	__size_of_SensorTime	equ	__end_of_SensorTime-_SensorTime
	
_SensorTime:	
;incstack = 0
	opt	stack 4
; Regs used in _SensorTime: [wreg+status,2+status,0]
	line	35
	
l7133:	
;sensor.c: 35: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u1821
	goto	u1820
u1821:
	goto	l7153
u1820:
	line	37
	
l7135:	
;sensor.c: 36: {
;sensor.c: 37: Fbodysensor.bits.bit_5 = 0;
	bcf	(_Fbodysensor),5	;volatile
	line	38
	
l7137:	
;sensor.c: 38: CNTbodyExitTime = 0;
	clrf	(_CNTbodyExitTime)	;volatile
	clrf	(_CNTbodyExitTime+1)	;volatile
	line	39
	
l7139:	
;sensor.c: 39: if(FledBits01.bits.bit_2 == 0)
	btfsc	(_FledBits01),2	;volatile
	goto	u1831
	goto	u1830
u1831:
	goto	l3863
u1830:
	line	41
	
l7141:	
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
	goto	u1841
	goto	u1840
u1841:
	goto	l7147
u1840:
	line	43
	
l7143:	
;sensor.c: 42: {
;sensor.c: 43: CNTbodyInTime = 6000;
	movlw	070h
	movwf	(_CNTbodyInTime)	;volatile
	movlw	017h
	movwf	((_CNTbodyInTime))+1	;volatile
	line	44
	
l7145:	
;sensor.c: 44: Fbodysensor.bits.bit_3 = 1;
	bsf	(_Fbodysensor),3	;volatile
	line	45
;sensor.c: 45: }
	goto	l3871
	line	46
	
l7147:	
;sensor.c: 46: else if(CNTbodyInTime >= 500)
	movlw	01h
	subwf	(_CNTbodyInTime+1),w	;volatile
	movlw	0F4h
	skipnz
	subwf	(_CNTbodyInTime),w	;volatile
	skipc
	goto	u1851
	goto	u1850
u1851:
	goto	l3867
u1850:
	line	48
	
l7149:	
;sensor.c: 47: {
;sensor.c: 48: Fbodysensor.bits.bit_4 = 1;
	bsf	(_Fbodysensor),4	;volatile
	goto	l3871
	line	51
	
l3863:	
	line	53
;sensor.c: 51: else
;sensor.c: 52: {
;sensor.c: 53: if(Fbodysensor.bits.bit_4 == 0)
	btfsc	(_Fbodysensor),4	;volatile
	goto	u1861
	goto	u1860
u1861:
	goto	l3871
u1860:
	line	55
	
l7151:	
;sensor.c: 54: {
;sensor.c: 55: CNTbodyInTime = 0;
	clrf	(_CNTbodyInTime)	;volatile
	clrf	(_CNTbodyInTime+1)	;volatile
	goto	l3871
	line	57
	
l3867:	
	line	58
;sensor.c: 56: }
;sensor.c: 57: }
;sensor.c: 58: }
	goto	l3871
	line	61
	
l7153:	
;sensor.c: 59: else
;sensor.c: 60: {
;sensor.c: 61: CNTbodyInTime = 0;
	clrf	(_CNTbodyInTime)	;volatile
	clrf	(_CNTbodyInTime+1)	;volatile
	line	62
	
l7155:	
;sensor.c: 62: Fbodysensor.bits.bit_4 = 0;
	bcf	(_Fbodysensor),4	;volatile
	line	63
	
l7157:	
;sensor.c: 63: Fbodysensor.bits.bit_3 = 0;
	bcf	(_Fbodysensor),3	;volatile
	line	64
	
l7159:	
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
	goto	u1871
	goto	u1870
u1871:
	goto	l3871
u1870:
	line	66
	
l7161:	
;sensor.c: 65: {
;sensor.c: 66: CNTbodyExitTime = 500;
	movlw	0F4h
	movwf	(_CNTbodyExitTime)	;volatile
	movlw	01h
	movwf	((_CNTbodyExitTime))+1	;volatile
	line	67
	
l7163:	
;sensor.c: 67: Fbodysensor.bits.bit_5 = 1;
	bsf	(_Fbodysensor),5	;volatile
	line	70
	
l3871:	
	return
	opt stack 0
GLOBAL	__end_of_SensorTime
	__end_of_SensorTime:
	signat	_SensorTime,89
	global	_SensorKey

;; *************** function _SensorKey *****************
;; Defined at:
;;		line 27 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\sensor.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\sensor.c"
	line	27
	global	__size_of_SensorKey
	__size_of_SensorKey	equ	__end_of_SensorKey-_SensorKey
	
_SensorKey:	
;incstack = 0
	opt	stack 4
; Regs used in _SensorKey: []
	line	30
	
l3859:	
	return
	opt stack 0
GLOBAL	__end_of_SensorKey
	__end_of_SensorKey:
	signat	_SensorKey,89
	global	_SensorJudge

;; *************** function _SensorJudge *****************
;; Defined at:
;;		line 73 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\sensor.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\sensor.c"
	line	73
	global	__size_of_SensorJudge
	__size_of_SensorJudge	equ	__end_of_SensorJudge-_SensorJudge
	
_SensorJudge:	
;incstack = 0
	opt	stack 4
; Regs used in _SensorJudge: [wreg-fsr0h+status,2+status,0]
	line	75
	
l7165:	
;sensor.c: 75: switch (SEQbody)
	goto	l7217
	line	77
;sensor.c: 76: {
;sensor.c: 77: case 0:
	
l3875:	
	line	78
;sensor.c: 78: Fbodysensor.bits.bit_0 = 0;
	bcf	(_Fbodysensor),0	;volatile
	line	79
;sensor.c: 79: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	80
	
l7167:	
;sensor.c: 80: SEQbody = 1;
	movlw	low(01h)
	movwf	(_SEQbody)	;volatile
	line	81
;sensor.c: 81: break;
	goto	l3896
	line	84
;sensor.c: 84: case 1:
	
l3877:	
	line	85
;sensor.c: 85: Fbodysensor.bits.bit_0 = 0;
	bcf	(_Fbodysensor),0	;volatile
	line	86
;sensor.c: 86: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	87
;sensor.c: 87: if(RB1 == 0)
	btfsc	(49/8),(49)&7	;volatile
	goto	u1881
	goto	u1880
u1881:
	goto	l7175
u1880:
	line	89
	
l7169:	
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
	goto	u1891
	goto	u1890
u1891:
	goto	l3896
u1890:
	line	91
	
l7171:	
;sensor.c: 90: {
;sensor.c: 91: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	line	92
;sensor.c: 92: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	line	93
	
l7173:	
;sensor.c: 93: SEQbody = 2;
	movlw	low(02h)
	movwf	(_SEQbody)	;volatile
	line	94
;sensor.c: 94: break;
	goto	l3896
	line	99
	
l7175:	
;sensor.c: 97: else
;sensor.c: 98: {
;sensor.c: 99: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	goto	l3896
	line	104
;sensor.c: 104: case 2:
	
l3881:	
	line	105
;sensor.c: 105: Fbodysensor.bits.bit_0 = 0;
	bcf	(_Fbodysensor),0	;volatile
	line	106
;sensor.c: 106: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	107
;sensor.c: 107: if(RB1 == 0)
	btfsc	(49/8),(49)&7	;volatile
	goto	u1901
	goto	u1900
u1901:
	goto	l7179
u1900:
	line	109
	
l7177:	
;sensor.c: 108: {
;sensor.c: 109: ++CNTbody_h;
	incf	(_CNTbody_h),f	;volatile
	skipnz
	incf	(_CNTbody_h+1),f	;volatile
	line	110
;sensor.c: 110: }
	goto	l7185
	line	113
	
l7179:	
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
	goto	u1911
	goto	u1910
u1911:
	goto	l7185
u1910:
	line	115
	
l7181:	
;sensor.c: 114: {
;sensor.c: 115: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	line	116
;sensor.c: 116: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	goto	l7167
	line	121
	
l7185:	
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
	
l7187:	
;sensor.c: 122: if(BufCntAdd >= 30)
	movlw	0
	subwf	(_BufCntAdd+1),w	;volatile
	movlw	01Eh
	skipnz
	subwf	(_BufCntAdd),w	;volatile
	skipc
	goto	u1921
	goto	u1920
u1921:
	goto	l3896
u1920:
	line	124
	
l7189:	
;sensor.c: 123: {
;sensor.c: 124: SEQbody = 3;
	movlw	low(03h)
	movwf	(_SEQbody)	;volatile
	line	125
;sensor.c: 125: break;
	goto	l3896
	line	129
;sensor.c: 129: case 3:
	
l3886:	
	line	130
;sensor.c: 130: Fbodysensor.bits.bit_0 = 1;
	bsf	(_Fbodysensor),0	;volatile
	line	131
;sensor.c: 131: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	132
;sensor.c: 132: if(RB1 == 1)
	btfss	(49/8),(49)&7	;volatile
	goto	u1931
	goto	u1930
u1931:
	goto	l7197
u1930:
	line	134
	
l7191:	
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
	goto	u1941
	goto	u1940
u1941:
	goto	l3896
u1940:
	line	136
	
l7193:	
;sensor.c: 135: {
;sensor.c: 136: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	line	137
;sensor.c: 137: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	line	138
	
l7195:	
;sensor.c: 138: SEQbody = 4;
	movlw	low(04h)
	movwf	(_SEQbody)	;volatile
	line	139
;sensor.c: 139: break;
	goto	l3896
	line	144
	
l7197:	
;sensor.c: 142: else
;sensor.c: 143: {
;sensor.c: 144: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	goto	l3896
	line	148
;sensor.c: 148: case 4:
	
l3890:	
	line	149
;sensor.c: 149: Fbodysensor.bits.bit_0 = 1;
	bsf	(_Fbodysensor),0	;volatile
	line	150
;sensor.c: 150: FledBits01.bits.bit_2 = 1;
	bsf	(_FledBits01),2	;volatile
	line	151
;sensor.c: 151: if(RB1 == 0)
	btfsc	(49/8),(49)&7	;volatile
	goto	u1951
	goto	u1950
u1951:
	goto	l7205
u1950:
	line	153
	
l7199:	
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
	goto	u1961
	goto	u1960
u1961:
	goto	l7207
u1960:
	line	155
	
l7201:	
;sensor.c: 154: {
;sensor.c: 155: CNTbody_h = 0;
	clrf	(_CNTbody_h)	;volatile
	clrf	(_CNTbody_h+1)	;volatile
	line	156
;sensor.c: 156: CNTbody_l = 0;
	clrf	(_CNTbody_l)	;volatile
	clrf	(_CNTbody_l+1)	;volatile
	goto	l7189
	line	163
	
l7205:	
;sensor.c: 161: else
;sensor.c: 162: {
;sensor.c: 163: ++CNTbody_l;
	incf	(_CNTbody_l),f	;volatile
	skipnz
	incf	(_CNTbody_l+1),f	;volatile
	line	165
	
l7207:	
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
	goto	u1971
	goto	u1970
u1971:
	goto	l3896
u1970:
	goto	l7167
	line	173
	
l7211:	
;sensor.c: 173: SEQbody = 0;
	clrf	(_SEQbody)	;volatile
	line	174
	
l7213:	
;sensor.c: 174: FledBits01.bits.bit_2 = 0;
	bcf	(_FledBits01),2	;volatile
	line	175
;sensor.c: 175: break;
	goto	l3896
	line	75
	
l7217:	
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
	goto	l3875
	xorlw	1^0	; case 1
	skipnz
	goto	l3877
	xorlw	2^1	; case 2
	skipnz
	goto	l3881
	xorlw	3^2	; case 3
	skipnz
	goto	l3886
	xorlw	4^3	; case 4
	skipnz
	goto	l3890
	goto	l7211
	opt asmopt_pop

	line	177
	
l3896:	
	return
	opt stack 0
GLOBAL	__end_of_SensorJudge
	__end_of_SensorJudge:
	signat	_SensorJudge,89
	global	_SensorControl

;; *************** function _SensorControl *****************
;; Defined at:
;;		line 179 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\sensor.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\sensor.c"
	line	179
	global	__size_of_SensorControl
	__size_of_SensorControl	equ	__end_of_SensorControl-_SensorControl
	
_SensorControl:	
;incstack = 0
	opt	stack 4
; Regs used in _SensorControl: [wreg]
	line	181
	
l7219:	
;sensor.c: 181: Fbodysensor.bits.bit_1 = 0;
	bcf	(_Fbodysensor),1	;volatile
	line	182
;sensor.c: 182: Fbodysensor.bits.bit_2 = 0;
	bcf	(_Fbodysensor),2	;volatile
	line	183
	
l7221:	
;sensor.c: 183: if(Fbodysensor.bits.bit_6 != Fbodysensor.bits.bit_0)
	btfsc	(_Fbodysensor),0	;volatile
	goto	u1981
	goto	u1980
u1981:
	movlw	1
	goto	u1982
u1980:
	movlw	0
u1982:
	movwf	(??_SensorControl+0)+0
	btfsc	(_Fbodysensor),6	;volatile
	goto	u1991
	goto	u1990
u1991:
	movlw	1
	goto	u1992
u1990:
	movlw	0
u1992:
	xorwf	(??_SensorControl+0)+0,w
	skipnz
	goto	u2001
	goto	u2000
u2001:
	goto	l3902
u2000:
	line	185
	
l7223:	
;sensor.c: 184: {
;sensor.c: 185: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u2011
	goto	u2010
u2011:
	goto	l3900
u2010:
	line	187
	
l7225:	
;sensor.c: 186: {
;sensor.c: 187: Fbodysensor.bits.bit_1 = 1;
	bsf	(_Fbodysensor),1	;volatile
	line	188
;sensor.c: 188: }
	goto	l3901
	line	189
	
l3900:	
	line	191
;sensor.c: 189: else
;sensor.c: 190: {
;sensor.c: 191: Fbodysensor.bits.bit_2 = 1;
	bsf	(_Fbodysensor),2	;volatile
	line	192
	
l3901:	
	line	193
;sensor.c: 192: }
;sensor.c: 193: Fbodysensor.bits.bit_6 = Fbodysensor.bits.bit_0;
	btfsc	(_Fbodysensor),0	;volatile
	goto	u2021
	goto	u2020
	
u2021:
	bsf	(_Fbodysensor),6	;volatile
	goto	u2034
u2020:
	bcf	(_Fbodysensor),6	;volatile
u2034:
	line	195
	
l3902:	
	return
	opt stack 0
GLOBAL	__end_of_SensorControl
	__end_of_SensorControl:
	signat	_SensorControl,89
	global	_GledLoop

;; *************** function _GledLoop *****************
;; Defined at:
;;		line 16 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
	line	16
global __ptext10
__ptext10:	;psect for function _GledLoop
psect	text10
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
	line	16
	global	__size_of_GledLoop
	__size_of_GledLoop	equ	__end_of_GledLoop-_GledLoop
	
_GledLoop:	
;incstack = 0
	opt	stack 4
; Regs used in _GledLoop: [wreg+status,2+status,0+pclath+cstack]
	line	18
	
l7265:	
;light.c: 18: LED_Time();
	fcall	_LED_Time
	line	19
;light.c: 19: LED_Key();
	fcall	_LED_Key
	line	20
;light.c: 20: LED_Judge();
	fcall	_LED_Judge
	line	21
	
l7267:	
;light.c: 21: LED_Con();
	fcall	_LED_Con
	line	22
	
l913:	
	return
	opt stack 0
GLOBAL	__end_of_GledLoop
	__end_of_GledLoop:
	signat	_GledLoop,89
	global	_LED_Time

;; *************** function _LED_Time *****************
;; Defined at:
;;		line 45 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
	line	45
	global	__size_of_LED_Time
	__size_of_LED_Time	equ	__end_of_LED_Time-_LED_Time
	
_LED_Time:	
;incstack = 0
	opt	stack 4
; Regs used in _LED_Time: []
	line	47
	
l6915:	
;light.c: 47: if(Fsys1m.bits.bit_0 == 1)
	btfss	(_Fsys1m),0	;volatile
	goto	u1321
	goto	u1320
u1321:
	goto	l920
u1320:
	line	49
	
l6917:	
;light.c: 48: {
;light.c: 49: Fsys1m.bits.bit_0 = 0;
	bcf	(_Fsys1m),0	;volatile
	line	51
	
l920:	
	return
	opt stack 0
GLOBAL	__end_of_LED_Time
	__end_of_LED_Time:
	signat	_LED_Time,89
	global	_LED_Key

;; *************** function _LED_Key *****************
;; Defined at:
;;		line 24 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
	line	24
	global	__size_of_LED_Key
	__size_of_LED_Key	equ	__end_of_LED_Key-_LED_Key
	
_LED_Key:	
;incstack = 0
	opt	stack 4
; Regs used in _LED_Key: []
	line	43
	
l916:	
	return
	opt stack 0
GLOBAL	__end_of_LED_Key
	__end_of_LED_Key:
	signat	_LED_Key,89
	global	_LED_Judge

;; *************** function _LED_Judge *****************
;; Defined at:
;;		line 53 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
	line	53
	global	__size_of_LED_Judge
	__size_of_LED_Judge	equ	__end_of_LED_Judge-_LED_Judge
	
_LED_Judge:	
;incstack = 0
	opt	stack 4
; Regs used in _LED_Judge: []
	line	55
	
l6919:	
;light.c: 55: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u1331
	goto	u1330
u1331:
	goto	l6925
u1330:
	line	57
	
l6921:	
;light.c: 56: {
;light.c: 57: FledBits01.bits.bit_0 = 1;
	bsf	(_FledBits01),0	;volatile
	line	58
;light.c: 58: if(Fbodysensor.bits.bit_4 == 0)
	btfsc	(_Fbodysensor),4	;volatile
	goto	u1341
	goto	u1340
u1341:
	goto	l927
u1340:
	line	60
	
l6923:	
;light.c: 59: {
;light.c: 60: if(FledBits01.bits.bit_2 == 1)
	btfss	(_FledBits01),2	;volatile
	goto	u1351
	goto	u1350
u1351:
	goto	l927
u1350:
	line	62
	
l6925:	
;light.c: 61: {
;light.c: 62: FledBits01.bits.bit_0 = 0;
	bcf	(_FledBits01),0	;volatile
	line	82
	
l927:	
	return
	opt stack 0
GLOBAL	__end_of_LED_Judge
	__end_of_LED_Judge:
	signat	_LED_Judge,89
	global	_LED_Con

;; *************** function _LED_Con *****************
;; Defined at:
;;		line 84 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
	line	84
	global	__size_of_LED_Con
	__size_of_LED_Con	equ	__end_of_LED_Con-_LED_Con
	
_LED_Con:	
;incstack = 0
	opt	stack 4
; Regs used in _LED_Con: [wreg+status,2+status,0]
	line	86
	
l6927:	
;light.c: 86: RA5 = FledBits01.bits.bit_0;
	btfsc	(_FledBits01),0	;volatile
	goto	u1361
	goto	u1360
	
u1361:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bsf	(45/8),(45)&7	;volatile
	goto	u1374
u1360:
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	bcf	(45/8),(45)&7	;volatile
u1374:
	line	88
;light.c: 88: if (FledBits01.bits.bit_0 == 1)
	btfss	(_FledBits01),0	;volatile
	goto	u1381
	goto	u1380
u1381:
	goto	l7015
u1380:
	line	90
	
l6929:	
;light.c: 89: {
;light.c: 90: if (FledBits01.bits.bit_3 == 0)
	btfsc	(_FledBits01),3	;volatile
	goto	u1391
	goto	u1390
u1391:
	goto	l6971
u1390:
	line	92
	
l6931:	
;light.c: 91: {
;light.c: 92: if (CNTbreath_Led2 >= 80)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	050h
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipc
	goto	u1401
	goto	u1400
u1401:
	goto	l6941
u1400:
	line	94
	
l6933:	
;light.c: 93: {
;light.c: 94: CNTbreath_Led2 = 80;
	movlw	050h
	movwf	(_CNTbreath_Led2)	;volatile
	clrf	(_CNTbreath_Led2+1)	;volatile
	line	95
	
l6935:	
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
	goto	u1411
	goto	u1410
u1411:
	goto	l962
u1410:
	line	97
	
l6937:	
;light.c: 96: {
;light.c: 97: FledBits01.bits.bit_3 = 1;
	bsf	(_FledBits01),3	;volatile
	line	98
	
l6939:	
;light.c: 98: CNTbreath_Led3 = 0;
	clrf	(_CNTbreath_Led3)	;volatile
	clrf	(_CNTbreath_Led3+1)	;volatile
	goto	l962
	line	101
	
l6941:	
;light.c: 101: else if (CNTbreath_Led2 > 45)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	02Eh
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipc
	goto	u1421
	goto	u1420
u1421:
	goto	l6949
u1420:
	line	103
	
l6943:	
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
	goto	u1431
	goto	u1430
u1431:
	goto	l962
u1430:
	line	105
	
l6945:	
;light.c: 104: {
;light.c: 105: CNTbreath_Led1 = 0;
	clrf	(_CNTbreath_Led1)	;volatile
	clrf	(_CNTbreath_Led1+1)	;volatile
	line	106
	
l6947:	
;light.c: 106: CNTbreath_Led2++;
	incf	(_CNTbreath_Led2),f	;volatile
	skipnz
	incf	(_CNTbreath_Led2+1),f	;volatile
	goto	l962
	line	109
	
l6949:	
;light.c: 109: else if (CNTbreath_Led2 > 30)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	01Fh
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipc
	goto	u1441
	goto	u1440
u1441:
	goto	l6957
u1440:
	line	111
	
l6951:	
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
	goto	u1451
	goto	u1450
u1451:
	goto	l962
u1450:
	goto	l6945
	line	117
	
l6957:	
;light.c: 117: else if (CNTbreath_Led2 > 10)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	0Bh
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipc
	goto	u1461
	goto	u1460
u1461:
	goto	l6965
u1460:
	line	119
	
l6959:	
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
	goto	u1471
	goto	u1470
u1471:
	goto	l934
u1470:
	goto	l6945
	line	127
	
l6965:	
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
	goto	u1481
	goto	u1480
u1481:
	goto	l934
u1480:
	goto	l6945
	line	132
	
l934:	
	line	133
;light.c: 131: }
;light.c: 132: }
;light.c: 133: }
	goto	l962
	line	136
	
l6971:	
;light.c: 134: else
;light.c: 135: {
;light.c: 136: if (CNTbreath_Led2 < 5)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	05h
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u1491
	goto	u1490
u1491:
	goto	l6977
u1490:
	line	138
	
l6973:	
;light.c: 137: {
;light.c: 138: CNTbreath_Led2 = 5;
	movlw	05h
	movwf	(_CNTbreath_Led2)	;volatile
	clrf	(_CNTbreath_Led2+1)	;volatile
	line	139
	
l6975:	
;light.c: 139: FledBits01.bits.bit_3 = 0;
	bcf	(_FledBits01),3	;volatile
	line	140
;light.c: 140: }
	goto	l962
	line	141
	
l6977:	
;light.c: 141: else if (CNTbreath_Led2 < 10)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	0Ah
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u1501
	goto	u1500
u1501:
	goto	l6985
u1500:
	line	143
	
l6979:	
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
	goto	u1511
	goto	u1510
u1511:
	goto	l962
u1510:
	line	145
	
l6981:	
;light.c: 144: {
;light.c: 145: CNTbreath_Led1 = 0;
	clrf	(_CNTbreath_Led1)	;volatile
	clrf	(_CNTbreath_Led1+1)	;volatile
	line	146
	
l6983:	
;light.c: 146: CNTbreath_Led2--;
	movlw	01h
	subwf	(_CNTbreath_Led2),f	;volatile
	movlw	0
	skipc
	decf	(_CNTbreath_Led2+1),f	;volatile
	subwf	(_CNTbreath_Led2+1),f	;volatile
	goto	l962
	line	149
	
l6985:	
;light.c: 149: else if (CNTbreath_Led2 < 30)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	01Eh
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u1521
	goto	u1520
u1521:
	goto	l6993
u1520:
	line	151
	
l6987:	
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
	goto	u1531
	goto	u1530
u1531:
	goto	l962
u1530:
	goto	l6981
	line	157
	
l6993:	
;light.c: 157: else if (CNTbreath_Led2 < 40)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	028h
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u1541
	goto	u1540
u1541:
	goto	l7001
u1540:
	line	159
	
l6995:	
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
	goto	u1551
	goto	u1550
u1551:
	goto	l962
u1550:
	goto	l6981
	line	165
	
l7001:	
;light.c: 165: else if (CNTbreath_Led2 < 60)
	movlw	0
	subwf	(_CNTbreath_Led2+1),w	;volatile
	movlw	03Ch
	skipnz
	subwf	(_CNTbreath_Led2),w	;volatile
	skipnc
	goto	u1561
	goto	u1560
u1561:
	goto	l7009
u1560:
	line	167
	
l7003:	
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
	goto	u1571
	goto	u1570
u1571:
	goto	l934
u1570:
	goto	l6981
	line	175
	
l7009:	
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
	goto	u1581
	goto	u1580
u1581:
	goto	l934
u1580:
	goto	l6981
	line	185
	
l7015:	
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
	
l7017:	
;light.c: 188: FledBits01.bits.bit_3 = 0;
	bcf	(_FledBits01),3	;volatile
	line	189
	
l7019:	
;light.c: 189: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	191
	
l962:	
	return
	opt stack 0
GLOBAL	__end_of_LED_Con
	__end_of_LED_Con:
	signat	_LED_Con,89
	global	_GflushLoop

;; *************** function _GflushLoop *****************
;; Defined at:
;;		line 15 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\flush.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\flush.c"
	line	15
global __ptext15
__ptext15:	;psect for function _GflushLoop
psect	text15
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\flush.c"
	line	15
	global	__size_of_GflushLoop
	__size_of_GflushLoop	equ	__end_of_GflushLoop-_GflushLoop
	
_GflushLoop:	
;incstack = 0
	opt	stack 2
; Regs used in _GflushLoop: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	17
	
l7509:	
;flush.c: 17: FlushTime();
	fcall	_FlushTime
	line	18
	
l7511:	
;flush.c: 18: FlushJudge();
	fcall	_FlushJudge
	line	19
	
l7513:	
;flush.c: 19: FlushCon();
	fcall	_FlushCon
	line	20
	
l2887:	
	return
	opt stack 0
GLOBAL	__end_of_GflushLoop
	__end_of_GflushLoop:
	signat	_GflushLoop,89
	global	_FlushTime

;; *************** function _FlushTime *****************
;; Defined at:
;;		line 22 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\flush.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\flush.c"
	line	22
	global	__size_of_FlushTime
	__size_of_FlushTime	equ	__end_of_FlushTime-_FlushTime
	
_FlushTime:	
;incstack = 0
	opt	stack 4
; Regs used in _FlushTime: []
	line	25
	
l2890:	
	return
	opt stack 0
GLOBAL	__end_of_FlushTime
	__end_of_FlushTime:
	signat	_FlushTime,89
	global	_FlushJudge

;; *************** function _FlushJudge *****************
;; Defined at:
;;		line 26 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\flush.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\flush.c"
	line	26
	global	__size_of_FlushJudge
	__size_of_FlushJudge	equ	__end_of_FlushJudge-_FlushJudge
	
_FlushJudge:	
;incstack = 0
	opt	stack 2
; Regs used in _FlushJudge: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	28
	
l7477:	
	line	31
	
l7479:	
;flush.c: 31: if(Fbodysensor.bits.bit_3 == 1)
	btfss	(_Fbodysensor),3	;volatile
	goto	u2521
	goto	u2520
u2521:
	goto	l2893
u2520:
	line	33
	
l7481:	
;flush.c: 32: {
;flush.c: 33: Fflush1.bits.bit_0 = 1;
	bsf	(_Fflush1),0	;volatile
	line	34
;flush.c: 34: Fflush1.bits.bit_2 = 0;
	bcf	(_Fflush1),2	;volatile
	line	35
;flush.c: 35: }
	goto	l2894
	line	36
	
l2893:	
;flush.c: 36: else if(Fbodysensor.bits.bit_4 == 1)
	btfss	(_Fbodysensor),4	;volatile
	goto	u2531
	goto	u2530
u2531:
	goto	l7485
u2530:
	line	38
	
l7483:	
;flush.c: 37: {
;flush.c: 38: Fflush1.bits.bit_2 = 1;
	bsf	(_Fflush1),2	;volatile
	line	39
;flush.c: 39: Fflush1.bits.bit_0 = 0;
	bcf	(_Fflush1),0	;volatile
	line	40
;flush.c: 40: }
	goto	l2894
	line	41
	
l7485:	
;flush.c: 41: else if (SEQflsuh)
	movf	((_SEQflsuh)),w	;volatile
	btfsc	status,2
	goto	u2541
	goto	u2540
u2541:
	goto	l7489
u2540:
	line	43
	
l7487:	
;flush.c: 42: {
;flush.c: 43: Fflush1.bits.bit_2 = 0;
	bcf	(_Fflush1),2	;volatile
	line	44
;flush.c: 44: Fflush1.bits.bit_0 = 0;
	bcf	(_Fflush1),0	;volatile
	line	45
;flush.c: 45: }
	goto	l2894
	line	48
	
l7489:	
;flush.c: 46: else
;flush.c: 47: {
;flush.c: 48: Key_Step = GkeyLoop();
	fcall	_GkeyLoop
	movwf	(FlushJudge@Key_Step)
	line	49
	
l7491:	
;flush.c: 49: if (Key_Step)
	movf	((FlushJudge@Key_Step)),w
	btfsc	status,2
	goto	u2551
	goto	u2550
u2551:
	goto	l7487
u2550:
	line	51
	
l7493:	
;flush.c: 50: {
;flush.c: 51: SEQflsuh = Key_Step;
	movf	(FlushJudge@Key_Step),w
	movwf	(_SEQflsuh)	;volatile
	line	52
	
l7495:	
;flush.c: 52: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	53
	
l7497:	
;flush.c: 53: Fflush1.bits.bit_7 = 1;
	bsf	(_Fflush1),7	;volatile
	line	59
;flush.c: 54: }else
	
l2894:	
	line	76
;flush.c: 58: }
;flush.c: 59: }
;flush.c: 76: if (Fbodysensor.bits.bit_2 == 1)
	btfss	(_Fbodysensor),2	;volatile
	goto	u2561
	goto	u2560
u2561:
	goto	l2901
u2560:
	line	78
	
l7499:	
;flush.c: 77: {
;flush.c: 78: Fflush1.bits.bit_7 = 1;
	bsf	(_Fflush1),7	;volatile
	line	79
	
l2901:	
	line	80
;flush.c: 79: }
;flush.c: 80: if (Fflush1.bits.bit_7 == 1)
	btfss	(_Fflush1),7	;volatile
	goto	u2571
	goto	u2570
u2571:
	goto	l2904
u2570:
	line	82
	
l7501:	
;flush.c: 81: {
;flush.c: 82: if (Fflush1.bits.bit_6 == 1)
	btfss	(_Fflush1),6	;volatile
	goto	u2581
	goto	u2580
u2581:
	goto	l2903
u2580:
	line	84
	
l7503:	
;flush.c: 83: {
;flush.c: 84: Fflush1.bits.bit_2 = 0;
	bcf	(_Fflush1),2	;volatile
	line	85
;flush.c: 85: Fflush1.bits.bit_0 = 0;
	bcf	(_Fflush1),0	;volatile
	line	86
;flush.c: 86: return;
	goto	l2904
	line	87
	
l2903:	
	line	88
;flush.c: 87: }
;flush.c: 88: Fflush1.bits.bit_7 = 0;
	bcf	(_Fflush1),7	;volatile
	line	89
;flush.c: 89: if(Fflush1.bits.bit_0 == 1)
	btfss	(_Fflush1),0	;volatile
	goto	u2591
	goto	u2590
u2591:
	goto	l2905
u2590:
	line	91
	
l7505:	
;flush.c: 90: {
;flush.c: 91: Fflush1.bits.bit_0 = 0;
	bcf	(_Fflush1),0	;volatile
	line	92
;flush.c: 92: Fflush1.bits.bit_1 = 1;
	bsf	(_Fflush1),1	;volatile
	line	93
;flush.c: 93: return;
	goto	l2904
	line	94
	
l2905:	
	line	95
;flush.c: 94: }
;flush.c: 95: if(Fflush1.bits.bit_2 == 1)
	btfss	(_Fflush1),2	;volatile
	goto	u2601
	goto	u2600
u2601:
	goto	l2904
u2600:
	line	97
	
l7507:	
;flush.c: 96: {
;flush.c: 97: Fflush1.bits.bit_2 = 0;
	bcf	(_Fflush1),2	;volatile
	line	98
;flush.c: 98: Fflush1.bits.bit_3 = 1;
	bsf	(_Fflush1),3	;volatile
	line	104
	
l2904:	
	return
	opt stack 0
GLOBAL	__end_of_FlushJudge
	__end_of_FlushJudge:
	signat	_FlushJudge,89
	global	_GkeyLoop

;; *************** function _GkeyLoop *****************
;; Defined at:
;;		line 7 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\key.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\key.c"
	line	7
global __ptext18
__ptext18:	;psect for function _GkeyLoop
psect	text18
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\key.c"
	line	7
	global	__size_of_GkeyLoop
	__size_of_GkeyLoop	equ	__end_of_GkeyLoop-_GkeyLoop
	
_GkeyLoop:	
;incstack = 0
	opt	stack 2
; Regs used in _GkeyLoop: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	9
	
l7439:	
;key.c: 9: for ( SeletedLine = 0; SeletedLine < 2; SeletedLine++)
	clrf	(_SeletedLine)	;volatile
	
l7441:	
	movlw	low(02h)
	subwf	(_SeletedLine),w	;volatile
	skipc
	goto	u2421
	goto	u2420
u2421:
	goto	l7445
u2420:
	goto	l7473
	line	11
	
l7445:	
;key.c: 10: {
;key.c: 11: KeyLines[SeletedLine].flags.level =ScanKey(SeletedLine);
	movf	(_SeletedLine),w	;volatile
	fcall	_ScanKey
	movwf	(??_GkeyLoop+0)+0
	movf	(_SeletedLine),w	;volatile
	movwf	(??_GkeyLoop+1)+0
	movlw	(02h)-1
u2435:
	clrc
	rlf	(??_GkeyLoop+1)+0,f
	addlw	-1
	skipz
	goto	u2435
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
	
l7447:	
;key.c: 13: if(KeyLines[SeletedLine].flags.is_forbidden)
	movf	(_SeletedLine),w	;volatile
	movwf	(??_GkeyLoop+0)+0
	movlw	(02h)-1
u2445:
	clrc
	rlf	(??_GkeyLoop+0)+0,f
	addlw	-1
	skipz
	goto	u2445
	clrc
	rlf	(??_GkeyLoop+0)+0,w
	addlw	low(_KeyLines|((0x0)<<8))&0ffh
	movwf	fsr0
	btfss	indf,0
	goto	u2451
	goto	u2450
u2451:
	goto	l7453
u2450:
	line	15
	
l7449:	
;key.c: 14: {
;key.c: 15: if (KeyLines[SeletedLine].flags.level)
	movf	(_SeletedLine),w	;volatile
	movwf	(??_GkeyLoop+0)+0
	movlw	(02h)-1
u2465:
	clrc
	rlf	(??_GkeyLoop+0)+0,f
	addlw	-1
	skipz
	goto	u2465
	clrc
	rlf	(??_GkeyLoop+0)+0,w
	addlw	low(_KeyLines|((0x0)<<8))&0ffh
	movwf	fsr0
	btfss	indf,2
	goto	u2471
	goto	u2470
u2471:
	goto	l7469
u2470:
	line	17
	
l7451:	
;key.c: 16: {
;key.c: 17: KeyLines[SeletedLine].flags.is_forbidden = 0;
	movf	(_SeletedLine),w	;volatile
	movwf	(??_GkeyLoop+0)+0
	movlw	(02h)-1
u2485:
	clrc
	rlf	(??_GkeyLoop+0)+0,f
	addlw	-1
	skipz
	goto	u2485
	clrc
	rlf	(??_GkeyLoop+0)+0,w
	addlw	low(_KeyLines|((0x0)<<8))&0ffh
	movwf	fsr0
	bcf	indf,0
	goto	l7469
	line	21
	
l7453:	
;key.c: 20: }
;key.c: 21: if (KeyControl(&KeyLines[SeletedLine]))
	movf	(_SeletedLine),w	;volatile
	movwf	(??_GkeyLoop+0)+0
	movlw	(02h)-1
u2495:
	clrc
	rlf	(??_GkeyLoop+0)+0,f
	addlw	-1
	skipz
	goto	u2495
	clrc
	rlf	(??_GkeyLoop+0)+0,w
	addlw	low(_KeyLines|((0x0)<<8))&0ffh
	fcall	_KeyControl
	xorlw	0
	skipnz
	goto	u2501
	goto	u2500
u2501:
	goto	l7469
u2500:
	goto	l7467
	line	25
;key.c: 24: {
;key.c: 25: case PortA:
	
l5760:	
	line	26
;key.c: 26: Fflush1.bits.bit_0 = 1;
	bsf	(_Fflush1),0	;volatile
	line	27
;key.c: 27: KeyLines[PortB].flags.is_forbidden = 1;
	bsf	0+(_KeyLines)+04h,0	;volatile
	line	28
	
l7457:	
;key.c: 28: return FLUSH_BIG_0;
	movlw	low(03h)
	goto	l5761
	line	29
;key.c: 29: case PortB:
	
l5762:	
	line	30
;key.c: 30: Fflush1.bits.bit_2 = 1;
	bsf	(_Fflush1),2	;volatile
	line	31
;key.c: 31: KeyLines[PortA].flags.is_forbidden = 1;
	bsf	(_KeyLines),0	;volatile
	line	32
	
l7461:	
;key.c: 32: return FLUSH_SML_0;
	movlw	low(06h)
	goto	l5761
	line	23
	
l7467:	
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
	goto	l5760
	xorlw	1^0	; case 1
	skipnz
	goto	l5762
	goto	l7469
	opt asmopt_pop

	line	9
	
l7469:	
	incf	(_SeletedLine),f	;volatile
	
l7471:	
	movlw	low(02h)
	subwf	(_SeletedLine),w	;volatile
	skipc
	goto	u2511
	goto	u2510
u2511:
	goto	l7445
u2510:
	line	40
	
l7473:	
;key.c: 38: }
;key.c: 39: }
;key.c: 40: return 0;
	movlw	low(0)
	line	42
	
l5761:	
	return
	opt stack 0
GLOBAL	__end_of_GkeyLoop
	__end_of_GkeyLoop:
	signat	_GkeyLoop,89
	global	_ScanKey

;; *************** function _ScanKey *****************
;; Defined at:
;;		line 45 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\key.c"
;; Parameters:    Size  Location     Type
;;  line_num        1    wreg     enum E876
;; Auto vars:     Size  Location     Type
;;  line_num        1    2[COMMON] enum E876
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\key.c"
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
	
l6787:	
;key.c: 47: switch (line_num)
	goto	l6799
	line	50
	
l6789:	
;key.c: 50: return RA6;
	movlw	0
	btfsc	(46/8),(46)&7	;volatile
	movlw	1
	goto	l5769
	line	52
	
l6793:	
;key.c: 52: return RB0;
	movlw	0
	btfsc	(48/8),(48)&7	;volatile
	movlw	1
	goto	l5769
	line	47
	
l6799:	
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
	goto	l6789
	xorlw	1^0	; case 1
	skipnz
	goto	l6793
	goto	l5769
	opt asmopt_pop

	line	54
	
l5769:	
	return
	opt stack 0
GLOBAL	__end_of_ScanKey
	__end_of_ScanKey:
	signat	_ScanKey,4217
	global	_KeyControl

;; *************** function _KeyControl *****************
;; Defined at:
;;		line 58 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\key.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\key.c"
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
	
l7389:	
;key.c: 60: if(!(this->flags.level))
	movf	(KeyControl@this),w
	movwf	fsr0
	btfsc	indf,2
	goto	u2271
	goto	u2270
u2271:
	goto	l7419
u2270:
	line	62
	
l7391:	
;key.c: 61: {
;key.c: 62: if (this->flags.is_pressing)
	movf	(KeyControl@this),w
	movwf	fsr0
	btfss	indf,1
	goto	u2281
	goto	u2280
u2281:
	goto	l7405
u2280:
	line	64
	
l7393:	
;key.c: 63: {
;key.c: 64: this->cnt = 0;
	incf	(KeyControl@this),w
	movwf	fsr0
	clrf	indf
	line	66
	
l7395:	
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
	goto	u2291
	goto	u2290
u2291:
	goto	l7399
u2290:
	
l7397:	
	clrf	(_KeyControl$3140)
	clrf	(_KeyControl$3140+1)
	goto	l7401
	
l7399:	
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
	goto	u2301
	goto	u2300
u2301:
	movlw	1
	goto	u2310
u2300:
	movlw	0
u2310:
	movwf	(_KeyControl$3140)
	clrf	(_KeyControl$3140+1)
	
l7401:	
	movf	((_KeyControl$3140)),w
iorwf	((_KeyControl$3140+1)),w
	btfsc	status,2
	goto	u2321
	goto	u2320
u2321:
	goto	l7435
u2320:
	line	68
	
l7403:	
;key.c: 67: {
;key.c: 68: this->flags.is_forbidden = 1;
	movf	(KeyControl@this),w
	movwf	fsr0
	bsf	indf,0
	goto	l7435
	line	73
	
l7405:	
;key.c: 72: {
;key.c: 73: if (((++(this->cnt)) > (10)?(0 == ((this->cnt) = 0)):0))
	incf	(KeyControl@this),w
	movwf	fsr0
	incf	indf,f
	movlw	low(0Bh)
	subwf	(indf),w
	skipnc
	goto	u2331
	goto	u2330
u2331:
	goto	l7409
u2330:
	
l7407:	
	clrf	(_KeyControl$3141)
	clrf	(_KeyControl$3141+1)
	goto	l7411
	
l7409:	
	incf	(KeyControl@this),w
	movwf	fsr0
	clrf	indf
	movlw	(low(0))&0ffh
	btfsc	status,2
	goto	u2341
	goto	u2340
u2341:
	movlw	1
	goto	u2350
u2340:
	movlw	0
u2350:
	movwf	(_KeyControl$3141)
	clrf	(_KeyControl$3141+1)
	
l7411:	
	movf	((_KeyControl$3141)),w
iorwf	((_KeyControl$3141+1)),w
	btfsc	status,2
	goto	u2361
	goto	u2360
u2361:
	goto	l7435
u2360:
	line	75
	
l7413:	
;key.c: 74: {
;key.c: 75: this->flags.is_pressing = 1;
	movf	(KeyControl@this),w
	movwf	fsr0
	bsf	indf,1
	line	76
	
l7415:	
;key.c: 76: return 1;
	movlw	low(01h)
	goto	l5787
	line	83
	
l7419:	
;key.c: 81: else
;key.c: 82: {
;key.c: 83: if (this->flags.is_pressing)
	movf	(KeyControl@this),w
	movwf	fsr0
	btfss	indf,1
	goto	u2371
	goto	u2370
u2371:
	goto	l7431
u2370:
	line	85
	
l7421:	
;key.c: 84: {
;key.c: 85: if (((++(this->cnt)) > (10)?(0 == ((this->cnt) = 0)):0))
	incf	(KeyControl@this),w
	movwf	fsr0
	incf	indf,f
	movlw	low(0Bh)
	subwf	(indf),w
	skipnc
	goto	u2381
	goto	u2380
u2381:
	goto	l7425
u2380:
	
l7423:	
	clrf	(_KeyControl$3142)
	clrf	(_KeyControl$3142+1)
	goto	l7427
	
l7425:	
	incf	(KeyControl@this),w
	movwf	fsr0
	clrf	indf
	movlw	(low(0))&0ffh
	btfsc	status,2
	goto	u2391
	goto	u2390
u2391:
	movlw	1
	goto	u2400
u2390:
	movlw	0
u2400:
	movwf	(_KeyControl$3142)
	clrf	(_KeyControl$3142+1)
	
l7427:	
	movf	((_KeyControl$3142)),w
iorwf	((_KeyControl$3142+1)),w
	btfsc	status,2
	goto	u2411
	goto	u2410
u2411:
	goto	l7435
u2410:
	line	87
	
l7429:	
;key.c: 86: {
;key.c: 87: this->flags.is_pressing = 0;
	movf	(KeyControl@this),w
	movwf	fsr0
	bcf	indf,1
	goto	l7435
	line	91
	
l7431:	
;key.c: 90: {
;key.c: 91: this->cnt = 0;
	incf	(KeyControl@this),w
	movwf	fsr0
	clrf	indf
	line	92
	
l7433:	
;key.c: 92: this->cnt_timeout = 0;
	movf	(KeyControl@this),w
	addlw	02h
	movwf	fsr0
	clrf	indf
	incf	fsr0,f
	clrf	indf
	line	96
	
l7435:	
;key.c: 93: }
;key.c: 95: }
;key.c: 96: return 0;
	movlw	low(0)
	line	97
	
l5787:	
	return
	opt stack 0
GLOBAL	__end_of_KeyControl
	__end_of_KeyControl:
	signat	_KeyControl,4217
	global	_FlushCon

;; *************** function _FlushCon *****************
;; Defined at:
;;		line 107 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\flush.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\flush.c"
	line	107
global __ptext21
__ptext21:	;psect for function _FlushCon
psect	text21
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\flush.c"
	line	107
	global	__size_of_FlushCon
	__size_of_FlushCon	equ	__end_of_FlushCon-_FlushCon
	
_FlushCon:	
;incstack = 0
	opt	stack 4
; Regs used in _FlushCon: [wreg-fsr0h+status,2+status,0]
	line	109
	
l7053:	
;flush.c: 109: switch (SEQflsuh)
	goto	l7131
	line	111
;flush.c: 110: {
;flush.c: 111: case FLUSH_INIT_0:
	
l2910:	
	line	112
;flush.c: 112: Fflush1.bits.bit_6 = 0;
	bcf	(_Fflush1),6	;volatile
	line	113
;flush.c: 113: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	114
;flush.c: 114: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	115
;flush.c: 115: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	116
;flush.c: 116: if((Fflush1.bits.bit_1 == 1) || (Fflush1.bits.bit_3 == 1))
	btfsc	(_Fflush1),1	;volatile
	goto	u1681
	goto	u1680
u1681:
	goto	l7057
u1680:
	
l7055:	
	btfss	(_Fflush1),3	;volatile
	goto	u1691
	goto	u1690
u1691:
	goto	l2939
u1690:
	line	118
	
l7057:	
;flush.c: 117: {
;flush.c: 118: SEQflsuh = FLUSH_INIT_1;
	movlw	low(01h)
	movwf	(_SEQflsuh)	;volatile
	line	119
	
l7059:	
;flush.c: 119: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	goto	l2939
	line	122
;flush.c: 122: case FLUSH_INIT_1:
	
l2915:	
	line	123
;flush.c: 123: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	124
;flush.c: 124: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	125
;flush.c: 125: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	126
;flush.c: 126: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	127
;flush.c: 127: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u1701
	goto	u1700
u1701:
	goto	l7065
u1700:
	line	129
	
l7061:	
;flush.c: 128: {
;flush.c: 129: SEQflsuh = FLUSH_END_0;
	movlw	low(09h)
	movwf	(_SEQflsuh)	;volatile
	goto	l7059
	line	133
	
l7065:	
;flush.c: 132: }
;flush.c: 133: if(++CNTflush >= 5)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	05h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1711
	goto	u1710
u1711:
	goto	l2939
u1710:
	line	135
	
l7067:	
;flush.c: 134: {
;flush.c: 135: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	136
	
l7069:	
;flush.c: 136: SEQflsuh = FLUSH_INIT_2;
	movlw	low(02h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2939
	line	139
;flush.c: 139: case FLUSH_INIT_2:
	
l2918:	
	line	140
;flush.c: 140: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	141
;flush.c: 141: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	142
;flush.c: 142: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	143
;flush.c: 143: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	144
;flush.c: 144: if(Fbodysensor.bits.bit_0 == 1)
	btfss	(_Fbodysensor),0	;volatile
	goto	u1721
	goto	u1720
u1721:
	goto	l2919
u1720:
	goto	l7061
	line	149
	
l2919:	
	line	151
;flush.c: 149: }
;flush.c: 151: if(Fflush1.bits.bit_1 == 1)
	btfss	(_Fflush1),1	;volatile
	goto	u1731
	goto	u1730
u1731:
	goto	l2920
u1730:
	line	153
	
l7075:	
;flush.c: 152: {
;flush.c: 153: SEQflsuh = FLUSH_BIG_0;
	movlw	low(03h)
	movwf	(_SEQflsuh)	;volatile
	line	154
;flush.c: 154: }
	goto	l2939
	line	155
	
l2920:	
;flush.c: 155: else if(Fflush1.bits.bit_3 == 1)
	btfss	(_Fflush1),3	;volatile
	goto	u1741
	goto	u1740
u1741:
	goto	l2939
u1740:
	line	157
	
l7077:	
;flush.c: 156: {
;flush.c: 157: SEQflsuh = FLUSH_SML_0;
	movlw	low(06h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2939
	line	160
;flush.c: 160: case FLUSH_BIG_0:
	
l2923:	
	line	161
;flush.c: 161: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	162
;flush.c: 162: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	163
;flush.c: 163: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	164
;flush.c: 164: RA1 = 1;
	bsf	(41/8),(41)&7	;volatile
	line	165
	
l7079:	
;flush.c: 165: if(++CNTflush >= 10)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	0Ah
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1751
	goto	u1750
u1751:
	goto	l2939
u1750:
	line	167
	
l7081:	
;flush.c: 166: {
;flush.c: 167: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	168
	
l7083:	
;flush.c: 168: SEQflsuh = FLUSH_BIG_1;
	movlw	low(04h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2939
	line	171
;flush.c: 171: case FLUSH_BIG_1:
	
l2925:	
	line	172
;flush.c: 172: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	173
;flush.c: 173: RA2 = 1;
	bsf	(42/8),(42)&7	;volatile
	line	174
;flush.c: 174: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	175
;flush.c: 175: RA1 = 1;
	bsf	(41/8),(41)&7	;volatile
	line	184
	
l7085:	
;flush.c: 184: if(++CNTflush >= 100)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	064h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1761
	goto	u1760
u1761:
	goto	l2939
u1760:
	line	186
	
l7087:	
;flush.c: 185: {
;flush.c: 186: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	187
	
l7089:	
;flush.c: 187: SEQflsuh = FLUSH_BIG_2;
	movlw	low(05h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2939
	line	191
;flush.c: 191: case FLUSH_BIG_2:
	
l2927:	
	line	192
;flush.c: 192: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	193
;flush.c: 193: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	194
;flush.c: 194: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	195
;flush.c: 195: RA1 = 1;
	bsf	(41/8),(41)&7	;volatile
	line	196
	
l7091:	
;flush.c: 196: if(++CNTflush >= 10)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	0Ah
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1771
	goto	u1770
u1771:
	goto	l2939
u1770:
	line	198
	
l7093:	
;flush.c: 197: {
;flush.c: 198: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	199
	
l7095:	
;flush.c: 199: SEQflsuh = FLUSH_END_0;
	movlw	low(09h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2939
	line	203
;flush.c: 203: case FLUSH_SML_0:
	
l2929:	
	line	204
;flush.c: 204: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	205
;flush.c: 205: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	206
;flush.c: 206: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	207
;flush.c: 207: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	208
	
l7097:	
;flush.c: 208: if(++CNTflush >= 5)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	05h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1781
	goto	u1780
u1781:
	goto	l2939
u1780:
	line	210
	
l7099:	
;flush.c: 209: {
;flush.c: 210: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	211
	
l7101:	
;flush.c: 211: SEQflsuh = FLUSH_SML_1;
	movlw	low(07h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2939
	line	214
;flush.c: 214: case FLUSH_SML_1:
	
l2931:	
	line	215
;flush.c: 215: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	216
;flush.c: 216: RA2 = 1;
	bsf	(42/8),(42)&7	;volatile
	line	217
;flush.c: 217: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	218
;flush.c: 218: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	220
	
l7103:	
;flush.c: 220: if(++CNTflush >= 100)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	064h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1791
	goto	u1790
u1791:
	goto	l2939
u1790:
	line	222
	
l7105:	
;flush.c: 221: {
;flush.c: 222: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	223
	
l7107:	
;flush.c: 223: SEQflsuh = FLUSH_SML_2;
	movlw	low(08h)
	movwf	(_SEQflsuh)	;volatile
	goto	l2939
	line	226
;flush.c: 226: case FLUSH_SML_2:
	
l2933:	
	line	227
;flush.c: 227: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	228
;flush.c: 228: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	229
;flush.c: 229: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	230
;flush.c: 230: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	231
	
l7109:	
;flush.c: 231: if(++CNTflush >= 5)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	05h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1801
	goto	u1800
u1801:
	goto	l2939
u1800:
	line	233
	
l7111:	
;flush.c: 232: {
;flush.c: 233: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	234
	
l7113:	
;flush.c: 234: SEQflsuh = FLUSH_END_1;
	movlw	low(0Ah)
	movwf	(_SEQflsuh)	;volatile
	goto	l2939
	line	238
;flush.c: 238: case FLUSH_END_0:
	
l2935:	
	line	239
;flush.c: 239: Fflush1.bits.bit_6 = 1;
	bsf	(_Fflush1),6	;volatile
	line	240
;flush.c: 240: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	241
;flush.c: 241: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	242
;flush.c: 242: RA1 = 1;
	bsf	(41/8),(41)&7	;volatile
	line	243
	
l7115:	
;flush.c: 243: if(++CNTflush >= 200)
	incf	(_CNTflush),f	;volatile
	skipnz
	incf	(_CNTflush+1),f	;volatile
	movlw	0
	subwf	((_CNTflush+1)),w	;volatile
	movlw	0C8h
	skipnz
	subwf	((_CNTflush)),w	;volatile
	skipc
	goto	u1811
	goto	u1810
u1811:
	goto	l2939
u1810:
	goto	l7111
	line	250
;flush.c: 250: case FLUSH_END_1:
	
l2937:	
	line	251
;flush.c: 251: Fflush1.bits.bit_6 = 0;
	bcf	(_Fflush1),6	;volatile
	line	252
;flush.c: 252: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	253
;flush.c: 253: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	254
;flush.c: 254: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	255
	
l7121:	
;flush.c: 255: SEQflsuh = FLUSH_INIT_0;
	clrf	(_SEQflsuh)	;volatile
	line	256
;flush.c: 256: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	257
	
l7123:	
;flush.c: 257: Fflush1.bits.bit_1 = 0;
	bcf	(_Fflush1),1	;volatile
	line	258
	
l7125:	
;flush.c: 258: Fflush1.bits.bit_3 = 0;
	bcf	(_Fflush1),3	;volatile
	line	259
;flush.c: 259: break;
	goto	l2939
	line	260
;flush.c: 260: default:
	
l2938:	
	line	261
;flush.c: 261: Fflush1.bits.bit_6 = 0;
	bcf	(_Fflush1),6	;volatile
	line	262
;flush.c: 262: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	263
;flush.c: 263: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	264
;flush.c: 264: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	265
;flush.c: 265: Fflush1.bits.bit_1 = 0;
	bcf	(_Fflush1),1	;volatile
	line	266
;flush.c: 266: Fflush1.bits.bit_3 = 0;
	bcf	(_Fflush1),3	;volatile
	line	267
	
l7127:	
;flush.c: 267: SEQflsuh = FLUSH_INIT_0;
	clrf	(_SEQflsuh)	;volatile
	line	268
;flush.c: 268: CNTflush = 0;
	clrf	(_CNTflush)	;volatile
	clrf	(_CNTflush+1)	;volatile
	line	269
;flush.c: 269: break;
	goto	l2939
	line	109
	
l7131:	
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
	goto	l2910
	xorlw	1^0	; case 1
	skipnz
	goto	l2915
	xorlw	2^1	; case 2
	skipnz
	goto	l2918
	xorlw	3^2	; case 3
	skipnz
	goto	l2923
	xorlw	4^3	; case 4
	skipnz
	goto	l2925
	xorlw	5^4	; case 5
	skipnz
	goto	l2927
	xorlw	6^5	; case 6
	skipnz
	goto	l2929
	xorlw	7^6	; case 7
	skipnz
	goto	l2931
	xorlw	8^7	; case 8
	skipnz
	goto	l2933
	xorlw	9^8	; case 9
	skipnz
	goto	l2935
	xorlw	10^9	; case 10
	skipnz
	goto	l2937
	goto	l2938
	opt asmopt_pop

	line	271
	
l2939:	
	return
	opt stack 0
GLOBAL	__end_of_FlushCon
	__end_of_FlushCon:
	signat	_FlushCon,89
	global	_FCTloop

;; *************** function _FCTloop *****************
;; Defined at:
;;		line 21 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
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
;; Hardware stack levels required when called:    5
;; This function calls:
;;		_FCTjudge
;;		_FCTkey
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text22,local,class=CODE,delta=2,merge=1,group=0
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
	line	21
global __ptext22
__ptext22:	;psect for function _FCTloop
psect	text22
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
	line	21
	global	__size_of_FCTloop
	__size_of_FCTloop	equ	__end_of_FCTloop-_FCTloop
	
_FCTloop:	
;incstack = 0
	opt	stack 2
; Regs used in _FCTloop: [wreg+status,2+status,0+pclath+cstack]
	line	23
	
l7321:	
;fct.c: 23: FCTkey();
	fcall	_FCTkey
	line	24
;fct.c: 24: FCTjudge();
	fcall	_FCTjudge
	line	25
	
l4817:	
	return
	opt stack 0
GLOBAL	__end_of_FCTloop
	__end_of_FCTloop:
	signat	_FCTloop,89
	global	_FCTkey

;; *************** function _FCTkey *****************
;; Defined at:
;;		line 50 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
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
;;		_Delay_nms
;; This function is called by:
;;		_FCTloop
;; This function uses a non-reentrant model
;;
psect	text23,local,class=CODE,delta=2,merge=1,group=0
	line	50
global __ptext23
__ptext23:	;psect for function _FCTkey
psect	text23
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
	line	50
	global	__size_of_FCTkey
	__size_of_FCTkey	equ	__end_of_FCTkey-_FCTkey
	
_FCTkey:	
;incstack = 0
	opt	stack 2
; Regs used in _FCTkey: [wreg+status,2+status,0+pclath+cstack]
	line	52
	
l7227:	
;fct.c: 52: if(fctBits001.bits.bit_0 == 1)
	btfss	(_fctBits001),0	;volatile
	goto	u2041
	goto	u2040
u2041:
	goto	l4820
u2040:
	line	54
	
l7229:	
;fct.c: 53: {
;fct.c: 54: if(RB2 == 1)
	btfss	(50/8),(50)&7	;volatile
	goto	u2051
	goto	u2050
u2051:
	goto	l4820
u2050:
	line	56
	
l7231:	
;fct.c: 55: {
;fct.c: 56: Delay_nms(1000);
	movlw	0E8h
	movwf	(Delay_nms@inittempl)
	movlw	03h
	movwf	((Delay_nms@inittempl))+1
	fcall	_Delay_nms
	line	57
	
l7233:	
;fct.c: 57: if(RB2 == 1)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(50/8),(50)&7	;volatile
	goto	u2061
	goto	u2060
u2061:
	goto	l4820
u2060:
	line	59
	
l7235:	
;fct.c: 58: {
;fct.c: 59: fctBits001.bits.bit_0 = 0;
	bcf	(_fctBits001),0	;volatile
	line	60
;fct.c: 60: return;
	goto	l4823
	line	63
	
l4820:	
	line	64
;fct.c: 61: }
;fct.c: 62: }
;fct.c: 63: }
;fct.c: 64: if(RB2 == 1)
	btfss	(50/8),(50)&7	;volatile
	goto	u2071
	goto	u2070
u2071:
	goto	l4823
u2070:
	line	66
	
l7237:	
;fct.c: 65: {
;fct.c: 66: Delay_nms(1000);
	movlw	0E8h
	movwf	(Delay_nms@inittempl)
	movlw	03h
	movwf	((Delay_nms@inittempl))+1
	fcall	_Delay_nms
	line	67
	
l7239:	
;fct.c: 67: if(RB2 == 1)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(50/8),(50)&7	;volatile
	goto	u2081
	goto	u2080
u2081:
	goto	l4823
u2080:
	line	69
	
l7241:	
;fct.c: 68: {
;fct.c: 69: fctBits001.bits.bit_0 = 1;
	bsf	(_fctBits001),0	;volatile
	line	73
;fct.c: 70: return;
	
l4823:	
	return
	opt stack 0
GLOBAL	__end_of_FCTkey
	__end_of_FCTkey:
	signat	_FCTkey,89
	global	_Delay_nms

;; *************** function _Delay_nms *****************
;; Defined at:
;;		line 35 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
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
;;		On entry : 200/100
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
;;		_FCTkey
;; This function uses a non-reentrant model
;;
psect	text24,local,class=CODE,delta=2,merge=1,group=0
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
	line	35
global __ptext24
__ptext24:	;psect for function _Delay_nms
psect	text24
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
	line	35
	global	__size_of_Delay_nms
	__size_of_Delay_nms	equ	__end_of_Delay_nms-_Delay_nms
	
_Delay_nms:	
;incstack = 0
	opt	stack 2
; Regs used in _Delay_nms: [wreg+status,2+status,0+pclath+cstack]
	line	40
	
l6851:	
;main.c: 37: unsigned int i;
;main.c: 38: unsigned char gtemp;
;main.c: 40: gtemp = 0;
	clrf	(Delay_nms@gtemp)
	line	41
	
l6853:	
;main.c: 41: if (GIE == 1)
	btfss	(95/8),(95)&7	;volatile
	goto	u1191
	goto	u1190
u1191:
	goto	l6857
u1190:
	line	43
	
l6855:	
;main.c: 42: {
;main.c: 43: gtemp = 1;
	clrf	(Delay_nms@gtemp)
	incf	(Delay_nms@gtemp),f
	line	44
;main.c: 44: GIE = 0;
	bcf	(95/8),(95)&7	;volatile
	line	46
	
l6857:	
;main.c: 45: }
;main.c: 46: for (i = 0; i < inittempl; i++)
	clrf	(Delay_nms@i)
	clrf	(Delay_nms@i+1)
	goto	l6863
	line	48
	
l6859:	
;main.c: 47: {
;main.c: 48: Delay(154);
	movlw	09Ah
	movwf	(Delay@dtemp)
	clrf	(Delay@dtemp+1)
	fcall	_Delay
	line	49
# 49 "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
clrwdt ;# 
psect	text24
	line	46
	
l6861:	
	incf	(Delay_nms@i),f
	skipnz
	incf	(Delay_nms@i+1),f
	
l6863:	
	movf	(Delay_nms@inittempl+1),w
	subwf	(Delay_nms@i+1),w
	skipz
	goto	u1205
	movf	(Delay_nms@inittempl),w
	subwf	(Delay_nms@i),w
u1205:
	skipc
	goto	u1201
	goto	u1200
u1201:
	goto	l6859
u1200:
	line	51
	
l6865:	
;main.c: 50: }
;main.c: 51: if (gtemp == 1)
		decf	((Delay_nms@gtemp)),w
	btfss	status,2
	goto	u1211
	goto	u1210
u1211:
	goto	l1897
u1210:
	line	52
	
l6867:	
;main.c: 52: GIE = 1;
	bsf	(95/8),(95)&7	;volatile
	line	53
	
l1897:	
	return
	opt stack 0
GLOBAL	__end_of_Delay_nms
	__end_of_Delay_nms:
	signat	_Delay_nms,4217
	global	_Delay

;; *************** function _Delay *****************
;; Defined at:
;;		line 27 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
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
psect	text25,local,class=CODE,delta=2,merge=1,group=0
	line	27
global __ptext25
__ptext25:	;psect for function _Delay
psect	text25
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
	line	27
	global	__size_of_Delay
	__size_of_Delay	equ	__end_of_Delay-_Delay
	
_Delay:	
;incstack = 0
	opt	stack 2
; Regs used in _Delay: [wreg+status,2+status,0]
	line	29
	
l6783:	
;main.c: 29: while (dtemp--)
	
l6785:	
	movlw	01h
	subwf	(Delay@dtemp),f
	movlw	0
	skipc
	decf	(Delay@dtemp+1),f
	subwf	(Delay@dtemp+1),f
		incf	(((Delay@dtemp))),w
	skipz
	goto	u1031
	incf	(((Delay@dtemp+1))),w
	btfss	status,2
	goto	u1031
	goto	u1030
u1031:
	goto	l6785
u1030:
	line	31
	
l1889:	
	return
	opt stack 0
GLOBAL	__end_of_Delay
	__end_of_Delay:
	signat	_Delay,4217
	global	_FCTjudge

;; *************** function _FCTjudge *****************
;; Defined at:
;;		line 107 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
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
psect	text26,local,class=CODE,delta=2,merge=1,group=0
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
	line	107
global __ptext26
__ptext26:	;psect for function _FCTjudge
psect	text26
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
	line	107
	global	__size_of_FCTjudge
	__size_of_FCTjudge	equ	__end_of_FCTjudge-_FCTjudge
	
_FCTjudge:	
;incstack = 0
	opt	stack 3
; Regs used in _FCTjudge: [wreg+status,2+status,0+pclath+cstack]
	line	109
	
l7243:	
;fct.c: 109: if(fctBits001.bits.bit_0 == 1)
	btfss	(_fctBits001),0	;volatile
	goto	u2091
	goto	u2090
u2091:
	goto	l4840
u2090:
	line	111
	
l7245:	
;fct.c: 110: {
;fct.c: 111: if(++flag_time == 1500)
	incf	(_flag_time),f	;volatile
	skipnz
	incf	(_flag_time+1),f	;volatile
		movlw	220
	xorwf	(((_flag_time))),w	;volatile
	movlw	5
	skipnz
	xorwf	(((_flag_time+1))),w	;volatile
	btfss	status,2
	goto	u2101
	goto	u2100
u2101:
	goto	l7251
u2100:
	line	113
	
l7247:	
;fct.c: 112: {
;fct.c: 113: fctBits001.bits.bit_0 = 0;
	bcf	(_fctBits001),0	;volatile
	line	114
	
l7249:	
;fct.c: 114: flag_time = 0;
	clrf	(_flag_time)	;volatile
	clrf	(_flag_time+1)	;volatile
	line	116
	
l7251:	
;fct.c: 115: }
;fct.c: 116: if(RB1 == 0)
	btfsc	(49/8),(49)&7	;volatile
	goto	u2111
	goto	u2110
u2111:
	goto	l4842
u2110:
	line	118
	
l7253:	
;fct.c: 117: {
;fct.c: 118: R_KEY();
	fcall	_R_KEY
	line	119
;fct.c: 119: }
	goto	l4850
	line	120
	
l4842:	
	line	122
;fct.c: 120: else
;fct.c: 121: {
;fct.c: 122: if(RA6 == 0)
	btfsc	(46/8),(46)&7	;volatile
	goto	u2121
	goto	u2120
u2121:
	goto	l4844
u2120:
	line	124
	
l7255:	
;fct.c: 123: {
;fct.c: 124: key1();
	fcall	_key1
	line	125
;fct.c: 125: }
	goto	l4850
	line	126
	
l4844:	
	line	128
;fct.c: 126: else
;fct.c: 127: {
;fct.c: 128: if(RB0 == 0)
	btfsc	(48/8),(48)&7	;volatile
	goto	u2131
	goto	u2130
u2131:
	goto	l7259
u2130:
	line	130
	
l7257:	
;fct.c: 129: {
;fct.c: 130: key2();
	fcall	_key2
	line	131
;fct.c: 131: }
	goto	l4850
	line	134
	
l7259:	
;fct.c: 132: else
;fct.c: 133: {
;fct.c: 134: G_KEY();
	fcall	_G_KEY
	goto	l4850
	line	139
	
l4840:	
;fct.c: 139: else if(fctBits001.bits.bit_0 == 0)
	btfsc	(_fctBits001),0	;volatile
	goto	u2141
	goto	u2140
u2141:
	goto	l4850
u2140:
	line	141
	
l7261:	
;fct.c: 140: {
;fct.c: 141: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	142
;fct.c: 142: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	143
;fct.c: 143: RA4 = 0;
	bcf	(44/8),(44)&7	;volatile
	line	144
;fct.c: 144: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	145
	
l7263:	
;fct.c: 145: flag_time = 0;
	clrf	(_flag_time)	;volatile
	clrf	(_flag_time+1)	;volatile
	line	147
	
l4850:	
	return
	opt stack 0
GLOBAL	__end_of_FCTjudge
	__end_of_FCTjudge:
	signat	_FCTjudge,89
	global	_key2

;; *************** function _key2 *****************
;; Defined at:
;;		line 99 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
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
	line	99
global __ptext27
__ptext27:	;psect for function _key2
psect	text27
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
	line	99
	global	__size_of_key2
	__size_of_key2	equ	__end_of_key2-_key2
	
_key2:	
;incstack = 0
	opt	stack 3
; Regs used in _key2: []
	line	101
	
l6913:	
;fct.c: 101: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	102
;fct.c: 102: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	103
;fct.c: 103: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	104
;fct.c: 104: RA1 = 1;
	bsf	(41/8),(41)&7	;volatile
	line	105
	
l4837:	
	return
	opt stack 0
GLOBAL	__end_of_key2
	__end_of_key2:
	signat	_key2,89
	global	_key1

;; *************** function _key1 *****************
;; Defined at:
;;		line 91 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
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
	line	91
global __ptext28
__ptext28:	;psect for function _key1
psect	text28
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
	line	91
	global	__size_of_key1
	__size_of_key1	equ	__end_of_key1-_key1
	
_key1:	
;incstack = 0
	opt	stack 3
; Regs used in _key1: []
	line	93
	
l6911:	
;fct.c: 93: RA5 = 1;
	bsf	(45/8),(45)&7	;volatile
	line	94
;fct.c: 94: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	95
;fct.c: 95: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	96
;fct.c: 96: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	97
	
l4834:	
	return
	opt stack 0
GLOBAL	__end_of_key1
	__end_of_key1:
	signat	_key1,89
	global	_R_KEY

;; *************** function _R_KEY *****************
;; Defined at:
;;		line 83 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
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
psect	text29,local,class=CODE,delta=2,merge=1,group=0
	line	83
global __ptext29
__ptext29:	;psect for function _R_KEY
psect	text29
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
	line	83
	global	__size_of_R_KEY
	__size_of_R_KEY	equ	__end_of_R_KEY-_R_KEY
	
_R_KEY:	
;incstack = 0
	opt	stack 3
; Regs used in _R_KEY: []
	line	85
	
l6909:	
;fct.c: 85: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	86
;fct.c: 86: RA2 = 1;
	bsf	(42/8),(42)&7	;volatile
	line	87
;fct.c: 87: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	88
;fct.c: 88: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	89
	
l4831:	
	return
	opt stack 0
GLOBAL	__end_of_R_KEY
	__end_of_R_KEY:
	signat	_R_KEY,89
	global	_G_KEY

;; *************** function _G_KEY *****************
;; Defined at:
;;		line 75 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
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
psect	text30,local,class=CODE,delta=2,merge=1,group=0
	line	75
global __ptext30
__ptext30:	;psect for function _G_KEY
psect	text30
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\fct.c"
	line	75
	global	__size_of_G_KEY
	__size_of_G_KEY	equ	__end_of_G_KEY-_G_KEY
	
_G_KEY:	
;incstack = 0
	opt	stack 3
; Regs used in _G_KEY: []
	line	77
	
l6907:	
;fct.c: 77: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	78
;fct.c: 78: RA2 = 0;
	bcf	(42/8),(42)&7	;volatile
	line	79
;fct.c: 79: RA4 = 1;
	bsf	(44/8),(44)&7	;volatile
	line	80
;fct.c: 80: RA1 = 0;
	bcf	(41/8),(41)&7	;volatile
	line	81
	
l4828:	
	return
	opt stack 0
GLOBAL	__end_of_G_KEY
	__end_of_G_KEY:
	signat	_G_KEY,89
	global	_Int_ALL

;; *************** function _Int_ALL *****************
;; Defined at:
;;		line 563 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
	line	563
global __ptext31
__ptext31:	;psect for function _Int_ALL
psect	text31
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\main.c"
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
	
i1l7373:	
;main.c: 566: if (TMR1IF)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(96/8),(96)&7	;volatile
	goto	u224_21
	goto	u224_20
u224_21:
	goto	i1l7383
u224_20:
	line	573
	
i1l7375:	
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
	
i1l7377:	
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
	goto	u225_21
	goto	u225_20
u225_21:
	goto	i1l7383
u225_20:
	line	582
	
i1l7379:	
;main.c: 581: {
;main.c: 582: MainTime_1s = 0;
	clrf	(_MainTime_1s)	;volatile
	clrf	(_MainTime_1s+1)	;volatile
	line	583
	
i1l7381:	
;main.c: 583: Fsys1s.byte = 0xFF;
	movlw	low(0FFh)
	movwf	(_Fsys1s)	;volatile
	line	595
	
i1l7383:	
;main.c: 591: }
;main.c: 592: }
;main.c: 595: if (TMR2IF)
	btfss	(97/8),(97)&7	;volatile
	goto	u226_21
	goto	u226_20
u226_21:
	goto	i1l1980
u226_20:
	line	597
	
i1l7385:	
;main.c: 596: {
;main.c: 597: TMR2IF = 0;
	bcf	(97/8),(97)&7	;volatile
	line	598
	
i1l7387:	
;main.c: 598: INT_LED_SHOW();
	fcall	_INT_LED_SHOW
	line	657
	
i1l1980:	
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
;;		line 193 in file "D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
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
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
	line	193
global __ptext32
__ptext32:	;psect for function _INT_LED_SHOW
psect	text32
	file	"D:\mywork.wqs\SOUOCETREE\ABM\ABM007_FM3\source\light.c"
	line	193
	global	__size_of_INT_LED_SHOW
	__size_of_INT_LED_SHOW	equ	__end_of_INT_LED_SHOW-_INT_LED_SHOW
	
_INT_LED_SHOW:	
;incstack = 0
	opt	stack 2
; Regs used in _INT_LED_SHOW: [wreg+status,2+status,0]
	line	196
	
i1l7269:	
;light.c: 196: if((FledBits01.bits.bit_0 == 1) && (fctBits001.bits.bit_0 == 0))
	btfss	(_FledBits01),0	;volatile
	goto	u215_21
	goto	u215_20
u215_21:
	goto	i1l969
u215_20:
	
i1l7271:	
	btfsc	(_fctBits001),0	;volatile
	goto	u216_21
	goto	u216_20
u216_21:
	goto	i1l969
u216_20:
	line	198
	
i1l7273:	
;light.c: 197: {
;light.c: 198: if (++CNTbreath_Led == 80)
	incf	(_CNTbreath_Led),f	;volatile
	skipnz
	incf	(_CNTbreath_Led+1),f	;volatile
		movlw	80
	xorwf	(((_CNTbreath_Led))),w	;volatile
iorwf	(((_CNTbreath_Led+1))),w	;volatile
	btfss	status,2
	goto	u217_21
	goto	u217_20
u217_21:
	goto	i1l7279
u217_20:
	line	200
	
i1l7275:	
;light.c: 199: {
;light.c: 200: CNTbreath_Led = 0;
	clrf	(_CNTbreath_Led)	;volatile
	clrf	(_CNTbreath_Led+1)	;volatile
	line	201
	
i1l7277:	
;light.c: 201: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	203
	
i1l7279:	
;light.c: 202: }
;light.c: 203: if (CNTbreath_Led >= CNTbreath_Led2)
	movf	(_CNTbreath_Led2+1),w	;volatile
	subwf	(_CNTbreath_Led+1),w	;volatile
	skipz
	goto	u218_25
	movf	(_CNTbreath_Led2),w	;volatile
	subwf	(_CNTbreath_Led),w	;volatile
u218_25:
	skipc
	goto	u218_21
	goto	u218_20
u218_21:
	goto	i1l967
u218_20:
	line	205
	
i1l7281:	
;light.c: 204: {
;light.c: 205: RA5 = 1;
	bsf	(45/8),(45)&7	;volatile
	line	206
;light.c: 206: }
	goto	i1l969
	line	207
	
i1l967:	
	line	209
;light.c: 207: else
;light.c: 208: {
;light.c: 209: RA5 = 0;
	bcf	(45/8),(45)&7	;volatile
	line	212
	
i1l969:	
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

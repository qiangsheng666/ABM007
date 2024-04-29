#include <cms.h>	//芯片头文件，会根据工程选项自动寻找对应型号头文件
/* 系统设定区域 */

/* 注意是否为测试模式 */
#define	FCT_TEST			0		/* 测试使用 1测试  0正常 */

/* version */
#define ABM007_FLUSH_1	 		0x1001	/* 感应水箱(模式1，双冲水) */
#define ABM007_FLUSH_2	 		0x1002	/* 感应水箱(模式2，单冲水) */

/******************	记得修改版本号	 *****************/
#define SOFTWARE_VERSION         (ABM007_FLUSH_1)      		/*	记得修改版本号	*/
/******************	记得修改版本号	 *****************/
#if (SOFTWARE_VERSION == ABM007_FLUSH_1)
	#define DUBLE_FLUSH_MODE	1								/* 1-双冲模式，0-单冲模式 */
    #define SOFTWAREVERSION     "ABM007_MODE1_79F133_3B16A"    	/* 输出程序版本号 */
#endif

#if (SOFTWARE_VERSION == ABM007_FLUSH_2)
	#define DUBLE_FLUSH_MODE	0								/* 1-双冲模式，0-单冲模式 */
    #define SOFTWAREVERSION     "ABM007_MODE2_79F133_3B24A"    	/* 输出程序版本号 */
#endif

/* 数据类型定义 */
typedef unsigned char	uint8_t;
typedef signed char		int8_t;
typedef unsigned short	USHORT;
typedef signed short	SHORT;
typedef unsigned int	uint16_t;
typedef signed short int int16_t;
typedef unsigned long	uint32_t;
typedef signed long		int32_t;

typedef volatile bit v_bit;
typedef volatile unsigned char v_uint8;
typedef volatile unsigned int v_uint16;
typedef volatile unsigned long v_uint32;

typedef	struct {
	v_uint8 bit_0 : 1 ;	/* BIT0		*/
	v_uint8 bit_1 : 1 ;	/* BIT1		*/
	v_uint8 bit_2 : 1 ;	/* BIT2		*/
	v_uint8 bit_3 : 1 ;	/* BIT3		*/
	v_uint8 bit_4 : 1 ;	/* BIT4		*/
	v_uint8 bit_5 : 1 ;	/* BIT5		*/
	v_uint8 bit_6 : 1 ;	/* BIT6		*/
	v_uint8 bit_7 : 1 ;	/* BIT7		*/
	} BIT;
	
typedef union {
	v_uint8	byte;
	BIT	bits;
	} BYTE;	
	
volatile BYTE Fsys1;		/* 全局调用标识符 */
volatile BYTE Fsys1s;		/* 1s标识符 */
volatile BYTE Fsys1m;		/* 1min标识符 */

#define F1ms		Fsys1.bits.bit_1
#define F10ms		Fsys1.bits.bit_2
#define	Ftest		Fsys1.bits.bit_3		/* 测试标识符 */
#define	Fstart_10s	Fsys1.bits.bit_4		/* 开机10s标识符 */

#define F1s_light	Fsys1s.bits.bit_0
#define F1s_flush	Fsys1s.bits.bit_1
#define F1s_flash	Fsys1s.bits.bit_2
#define F1s_test	Fsys1s.bits.bit_3
#define F1s_body	Fsys1s.bits.bit_4

#define F1min_lgt	Fsys1m.bits.bit_0		/* 照明1min计时 */

#define	SET					1				/*	标志位设定置位		*/
#define	CLR					0				/*	标志位设定清除		*/
#define	HIGH				1				/*	电平高			*/
#define	LOW					0				/*	电平低			*/
#define	ON					1				/*	开				*/
#define	OFF					0				/*	关				*/

// v_uint8 SiCon_SETkey;	/* 全局控制指令 */

/*  按键 */

/* 端口定义 */
// #if FCT

// #else
	#define PIsensor		RB1		/* 龙头感应 */

	#define POmainValue		RA4		/* 主阀 */
	#define	POlight			RA5		/* 氛围灯 */
	#define POairPump		RA2		/* 气泵 */
// #endif

#include <cms.h>	//оƬͷ�ļ�������ݹ���ѡ���Զ�Ѱ�Ҷ�Ӧ�ͺ�ͷ�ļ�
/* ϵͳ�趨���� */

/* ע���Ƿ�Ϊ����ģʽ */
#define	FCT_TEST			0		/* ����ʹ�� 1����  0���� */

/* version */
#define ABM007_FLUSH_1	 		0x1001	/* ��Ӧˮ��(ģʽ1��˫��ˮ) */
#define ABM007_FLUSH_2	 		0x1002	/* ��Ӧˮ��(ģʽ2������ˮ) */

/******************	�ǵ��޸İ汾��	 *****************/
#define SOFTWARE_VERSION         (ABM007_FLUSH_1)      		/*	�ǵ��޸İ汾��	*/
/******************	�ǵ��޸İ汾��	 *****************/
#if (SOFTWARE_VERSION == ABM007_FLUSH_1)
	#define DUBLE_FLUSH_MODE	1								/* 1-˫��ģʽ��0-����ģʽ */
    #define SOFTWAREVERSION     "ABM007_MODE1_79F133_3B16A"    	/* �������汾�� */
#endif

#if (SOFTWARE_VERSION == ABM007_FLUSH_2)
	#define DUBLE_FLUSH_MODE	0								/* 1-˫��ģʽ��0-����ģʽ */
    #define SOFTWAREVERSION     "ABM007_MODE2_79F133_3B24A"    	/* �������汾�� */
#endif

/* �������Ͷ��� */
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
	
volatile BYTE Fsys1;		/* ȫ�ֵ��ñ�ʶ�� */
volatile BYTE Fsys1s;		/* 1s��ʶ�� */
volatile BYTE Fsys1m;		/* 1min��ʶ�� */

#define F1ms		Fsys1.bits.bit_1
#define F10ms		Fsys1.bits.bit_2
#define	Ftest		Fsys1.bits.bit_3		/* ���Ա�ʶ�� */
#define	Fstart_10s	Fsys1.bits.bit_4		/* ����10s��ʶ�� */

#define F1s_light	Fsys1s.bits.bit_0
#define F1s_flush	Fsys1s.bits.bit_1
#define F1s_flash	Fsys1s.bits.bit_2
#define F1s_test	Fsys1s.bits.bit_3
#define F1s_body	Fsys1s.bits.bit_4

#define F1min_lgt	Fsys1m.bits.bit_0		/* ����1min��ʱ */

#define	SET					1				/*	��־λ�趨��λ		*/
#define	CLR					0				/*	��־λ�趨���		*/
#define	HIGH				1				/*	��ƽ��			*/
#define	LOW					0				/*	��ƽ��			*/
#define	ON					1				/*	��				*/
#define	OFF					0				/*	��				*/

// v_uint8 SiCon_SETkey;	/* ȫ�ֿ���ָ�� */

/*  ���� */

/* �˿ڶ��� */
// #if FCT

// #else
	#define PIsensor		RB1		/* ��ͷ��Ӧ */

	#define POmainValue		RA4		/* ���� */
	#define	POlight			RA5		/* ��Χ�� */
	#define POairPump		RA2		/* ���� */
// #endif

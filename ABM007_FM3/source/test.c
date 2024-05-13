#include "cfg_user.h"
#include "cfg_case.h"

#if DEBUG_CSTM
BYTE FtestBit01;

//#define Ftest       FtestBit01.bits.bit_0
#define Ftest_ok    FtestBit01.bits.bit_1

v_uint8 bufTestCode;
v_uint8 SEQtest;
v_uint8 CNTtestKey;
v_uint16 CNTtestTime;


void TestControl(void);
void TestKey(void);

unsigned char TestCon(void)
{
	unsigned char u8testCom = 0;
	if(Ftest_ok == SET)
	{
		Ftest_ok = CLR;
		u8testCom = bufTestCode;
	}
	return u8testCom;
}
 
void GtestLoop(void)
{
    // TestKey();
    TestControl();
}

/* ������ʽ����ֹͣ+�½��� */
/* ���������ͻ����ܲ�ͬ����뷽ʽ */
void TestKey(void)
{
	switch(SiCon_SETkey)
	{
		case KEY_STP:		/* ͨ��1 */
			
			break;
		// case KEY_TEST:		/* ͨ��2 */
		// 	if(Ftest == CLR)
		// 	{
		// 		Ftest = SET;	/* ����10s�ڰ�ֹͣ+�½����������ϻ�����ģʽ */
		// 		GbuzOutSet(5);	/* ����һ�� */
		// 	}
		// 	break;
		default:
			break;
	}
}

/*	�ϻ����̣�	*/
/*	1�����¸���������������ɣ���������ɣ����¸��½�*/
/*	2����������90s */
void TestControl(void)
{
	if(F1s_test == SET)
	{
		F1s_test = CLR;
		if(++CNTtestTime >= 90)
		{
			CNTtestTime = 0;
		}
		if(CNTtestTime == 1)
		{
			bufTestCode = KEY_UP;		/* ����������Լ18s,35kg-32s */
			Ftest_ok = SET;
		}
		else if(CNTtestTime == 30)
		{
			if(Flight == CLR)
			{
				bufTestCode = KEY_LIGHT;		/* ���� */
				Ftest_ok = SET;
			}
		}
		else if(CNTtestTime == 40)
		{
			if(Flight == SET)
			{
				bufTestCode = KEY_LIGHT;		/* �ص� */
				Ftest_ok = SET;
			}
		}
	// #if VER_2510M
    //     else if(CNTtestTime == 42)
	// 	{
	// 		if(0 == OKfan)
	// 		{
	// 			bufTestCode = KEY_FAN;		/* ��ɿ��� */
	// 			Ftest_ok = SET;
	// 		}
	// 	}
    //     else if(CNTtestTime == 52)
	// 	{
	// 		if(1 == OKfan)
	// 		{
	// 			bufTestCode = KEY_FAN;		/* ��ɹر� */
	// 			Ftest_ok = SET;
	// 		}
	// 	}
    //     else if(CNTtestTime == 55)
	// 	{
	// 		if(0 == OKdry)
	// 		{
	// 			bufTestCode = KEY_DRY;		/* ��ɿ��� */
	// 			Ftest_ok = SET;
	// 		}
	// 	}
    //     else if(CNTtestTime == 65)
	// 	{
	// 		if(1 == OKdry)
	// 		{
	// 			bufTestCode = KEY_DRY;		/* ��ɹر� */
	// 			Ftest_ok = SET;
	// 		}
	// 	}
	// #endif
		else if(CNTtestTime == 70)
		{
			bufTestCode = KEY_DOWN;		/* �½�������Լ18s */
			Ftest_ok = SET;
		}
	}
}
#endif

// #else
// /* �ڲ����� */
// void TestControl(void)
// {
//     switch(SEQtest)
// 	{
// 		case 0:
// 			bufTestCode = KEY_UP;		/* ���� */
// 			Ftest_ok = SET;
// 			SEQtest = 1;
// 			break;
// 		case 1:
// 			/* ��������л� */
// 			if(++CNTtestTime >= 200)
// 			{
// 				CNTtestTime = 0;
// 				// bufTestCode = KEY_STP;		/* ���� */
// 				// Ftest_ok = SET;
// 				SEQtest = 4;
// 				break;
// 			}
// 			/* ��������л� */
// 			if(PIhang_H == SET)			/* ������λ */
// 			{
// 				// SEQtest = 2;
// 				SEQtest = 4;
// 				break;
// 			}
// 			if(PIhang_S == SET)
// 			{
// 				SEQtest = 0;			/* ����ز����� */
// 				break;
// 			}
// 			break;
// 		case 2:
// 	#if VER_2510M
// 			bufTestCode = KEY_DRY;		/* ��ɿ��� */
// 			Ftest_ok = SET;
// 	#endif
// 			Flight = SET;				/* ���� */
// 			SEQtest = 21;
// 			break;
// 		case 21:
// 			if(++CNTtestTime >= 5000)	/* 50s */
// 			{
// 				CNTtestTime = 0;
// 				SEQtest = 3;
// 			}
// 			break;
// 		case 3:
// 	#if VER_2510M
// 			if(OKdry == SET)
// 			{
// 				bufTestCode = KEY_DRY;		/* ��ɹر� */
// 				Ftest_ok = SET;
// 			}
// 	#endif
// 			Flight = CLR;				/* �ص� */
// 			SEQtest = 4;
// 			break;
// 		case 4:
// 			/* ��������л� */
// 			// if(++CNTtestTime >= 10)
// 			// {
// 			// 	CNTtestTime = 0;
// 			// 	bufTestCode = KEY_DOWN;		/* ���¸��½� */
// 			// 	Ftest_ok = SET;
// 			// 	SEQtest = 41;
// 			// 	break;
// 			// }
// 			/* ��������л� */
// 			bufTestCode = KEY_DOWN;		/* ���¸��½� */
// 			Ftest_ok = SET;
// 			SEQtest = 41;
// 			break;
// 		case 41:
// 			// /* ��������л� */
// 			// if(++CNTtestTime >= 200)
// 			// {
// 			// 	CNTtestTime = 0;
// 			// 	SEQtest = 5;
// 			// 	break;
// 			// }
// 			// /* ��������л� */
// 			if(PIhang_L == SET)			/* �½���λ */
// 			{
// 				SEQtest = 0;		/* ���ȴ���ֱ���л� */
// 				// SEQtest = 5;		/* �ȴ�һ��ʱ�� */ 
// 				break;
// 			}
// 			if(PIhang_S == SET)
// 			{
// 				SEQtest = 0;			/* ����ز����� */
// 				break;
// 			}
// 			break;
// 		case 5:
// 			/* ��������л� */
// 			if(++CNTtestTime >= 50)		/* �ȴ�500ms */
// 			{
// 				CNTtestTime = 0;
// 				SEQtest = 0;
// 				break;
// 			}
// 			/* ��������л� */
// 			break;
// 		default:
// 			SEQtest = 0;
// 			CNTtestTime = 0;
// 			break;
// 	}

// }

// #endif



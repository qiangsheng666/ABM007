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

/* 开启方式：按停止+下降键 */
/* 待保留，客户可能不同意进入方式 */
void TestKey(void)
{
	switch(SiCon_SETkey)
	{
		case KEY_STP:		/* 通道1 */
			
			break;
		// case KEY_TEST:		/* 通道2 */
		// 	if(Ftest == CLR)
		// 	{
		// 		Ftest = SET;	/* 开机10s内按停止+下降键，进入老化测试模式 */
		// 		GbuzOutSet(5);	/* 长鸣一声 */
		// 	}
		// 	break;
		default:
			break;
	}
}

/*	老化流程：	*/
/*	1、晾衣杆上升，开照明烘干，关照明烘干，晾衣杆下降*/
/*	2、整个流程90s */
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
			bufTestCode = KEY_UP;		/* 上升，空载约18s,35kg-32s */
			Ftest_ok = SET;
		}
		else if(CNTtestTime == 30)
		{
			if(Flight == CLR)
			{
				bufTestCode = KEY_LIGHT;		/* 开灯 */
				Ftest_ok = SET;
			}
		}
		else if(CNTtestTime == 40)
		{
			if(Flight == SET)
			{
				bufTestCode = KEY_LIGHT;		/* 关灯 */
				Ftest_ok = SET;
			}
		}
	// #if VER_2510M
    //     else if(CNTtestTime == 42)
	// 	{
	// 		if(0 == OKfan)
	// 		{
	// 			bufTestCode = KEY_FAN;		/* 风干开启 */
	// 			Ftest_ok = SET;
	// 		}
	// 	}
    //     else if(CNTtestTime == 52)
	// 	{
	// 		if(1 == OKfan)
	// 		{
	// 			bufTestCode = KEY_FAN;		/* 风干关闭 */
	// 			Ftest_ok = SET;
	// 		}
	// 	}
    //     else if(CNTtestTime == 55)
	// 	{
	// 		if(0 == OKdry)
	// 		{
	// 			bufTestCode = KEY_DRY;		/* 烘干开启 */
	// 			Ftest_ok = SET;
	// 		}
	// 	}
    //     else if(CNTtestTime == 65)
	// 	{
	// 		if(1 == OKdry)
	// 		{
	// 			bufTestCode = KEY_DRY;		/* 烘干关闭 */
	// 			Ftest_ok = SET;
	// 		}
	// 	}
	// #endif
		else if(CNTtestTime == 70)
		{
			bufTestCode = KEY_DOWN;		/* 下降，空载约18s */
			Ftest_ok = SET;
		}
	}
}
#endif

// #else
// /* 内部测试 */
// void TestControl(void)
// {
//     switch(SEQtest)
// 	{
// 		case 0:
// 			bufTestCode = KEY_UP;		/* 上升 */
// 			Ftest_ok = SET;
// 			SEQtest = 1;
// 			break;
// 		case 1:
// 			/* 电机方向切换 */
// 			if(++CNTtestTime >= 200)
// 			{
// 				CNTtestTime = 0;
// 				// bufTestCode = KEY_STP;		/* 上升 */
// 				// Ftest_ok = SET;
// 				SEQtest = 4;
// 				break;
// 			}
// 			/* 电机方向切换 */
// 			if(PIhang_H == SET)			/* 上升到位 */
// 			{
// 				// SEQtest = 2;
// 				SEQtest = 4;
// 				break;
// 			}
// 			if(PIhang_S == SET)
// 			{
// 				SEQtest = 0;			/* 遇阻回步骤零 */
// 				break;
// 			}
// 			break;
// 		case 2:
// 	#if VER_2510M
// 			bufTestCode = KEY_DRY;		/* 烘干开启 */
// 			Ftest_ok = SET;
// 	#endif
// 			Flight = SET;				/* 开灯 */
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
// 				bufTestCode = KEY_DRY;		/* 烘干关闭 */
// 				Ftest_ok = SET;
// 			}
// 	#endif
// 			Flight = CLR;				/* 关灯 */
// 			SEQtest = 4;
// 			break;
// 		case 4:
// 			/* 电机方向切换 */
// 			// if(++CNTtestTime >= 10)
// 			// {
// 			// 	CNTtestTime = 0;
// 			// 	bufTestCode = KEY_DOWN;		/* 晾衣杆下降 */
// 			// 	Ftest_ok = SET;
// 			// 	SEQtest = 41;
// 			// 	break;
// 			// }
// 			/* 电机方向切换 */
// 			bufTestCode = KEY_DOWN;		/* 晾衣杆下降 */
// 			Ftest_ok = SET;
// 			SEQtest = 41;
// 			break;
// 		case 41:
// 			// /* 电机方向切换 */
// 			// if(++CNTtestTime >= 200)
// 			// {
// 			// 	CNTtestTime = 0;
// 			// 	SEQtest = 5;
// 			// 	break;
// 			// }
// 			// /* 电机方向切换 */
// 			if(PIhang_L == SET)			/* 下降到位 */
// 			{
// 				SEQtest = 0;		/* 不等待，直接切换 */
// 				// SEQtest = 5;		/* 等待一段时间 */ 
// 				break;
// 			}
// 			if(PIhang_S == SET)
// 			{
// 				SEQtest = 0;			/* 遇阻回步骤零 */
// 				break;
// 			}
// 			break;
// 		case 5:
// 			/* 电机方向切换 */
// 			if(++CNTtestTime >= 50)		/* 等待500ms */
// 			{
// 				CNTtestTime = 0;
// 				SEQtest = 0;
// 				break;
// 			}
// 			/* 电机方向切换 */
// 			break;
// 		default:
// 			SEQtest = 0;
// 			CNTtestTime = 0;
// 			break;
// 	}

// }

// #endif



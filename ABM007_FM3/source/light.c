#include "cfg_user.h"
#include "cfg_case.h"

BYTE FledBits01;

v_uint16 CNTbreath_Led;
v_uint16 CNTbreath_Led1;
v_uint16 CNTbreath_Led2;
v_uint16 CNTbreath_Led3;

void LED_Key(void);
void LED_Judge(void);
void LED_Con(void);
void LED_Time(void);

void GledLoop(void)
{
	LED_Time();
	LED_Key();
	LED_Judge();
	LED_Con();
}

void LED_Key(void)
{
	// switch(SiCon_SETkey)
	// {	
	// 	case KEY_LIGHT:
	// 		Flight = ~Flight;
	// 		if(Flight == SET)
	// 		{
	// 			GbuzOutSet(2);
	// 		}
	// 		else
	// 		{
	// 			GbuzOutSet(1);
	// 		}
	// 		break;
	// 	default:
			
	// 		break;
	// }
}

void LED_Time(void)
{
	if(F1min_lgt == SET)
	{
		F1min_lgt = CLR;
	}
}

void LED_Judge(void)
{
	if(Fbody == SET)	/* 感应到人开启 */
	{
		Flight = SET;
		if(FbodyIn5s == CLR)	/* 检测到人5秒之内 */
		{
			if(FlightLeave == SET)	/* 离开状态，熄灭指示灯 */
			{
				Flight = CLR;
			}
		}
	}
	else
	{
		// if(Fbuflight == SET)
		// {
		// 	Flight = SET;	/* 离开5s内 */
		// 	if(FbodyEx5s == SET)
		// 	{
		// 		Flight = CLR;
		// 		Fbuflight = CLR;
		// 	}
		// }
		// else
		// {
			Flight = CLR;
		// }
	}
}

void LED_Con(void)
{
	POlight	= Flight;
	/* 呼吸灯频率 */
	// if (Flight == SET)
	// {
	// 	if (FbreathDir == CLR)
	// 	{
	// 		if (CNTbreath_Led2 >= 80)	/* 亮度降低 */
	// 		{
	// 			CNTbreath_Led2 = 80;
	// 			if (++CNTbreath_Led3 > 10)	/* 100ms，min */
	// 			{
	// 				FbreathDir = SET;
	// 				CNTbreath_Led3 = 0;
	// 			}
	// 		}
	// 		else if (CNTbreath_Led2 > 45)	/* 35*4*10=1050ms */
	// 		{
	// 			if (++CNTbreath_Led1 >= 3)
	// 			{
	// 				CNTbreath_Led1 = 0;
	// 				CNTbreath_Led2++;
	// 			}
	// 		}
	// 		else if (CNTbreath_Led2 > 30)	/* 15*8*10 = 1200ms */
	// 		{
	// 			if (++CNTbreath_Led1 >= 8)
	// 			{
	// 				CNTbreath_Led1 = 0;
	// 				CNTbreath_Led2++;
	// 			}
	// 		}
	// 		else if (CNTbreath_Led2 > 10)	/* 1000ms */
	// 		{
	// 			if (++CNTbreath_Led1 >= 5)
	// 			{
	// 				CNTbreath_Led1 = 0;
	// 				CNTbreath_Led2++;
	// 			}
	// 		}
	// 		else
	// 		{
	// 			if (++CNTbreath_Led1 >= 11)	/* (11-5)*10=600ms，max */
	// 			{
	// 				CNTbreath_Led1 = 0;
	// 				CNTbreath_Led2++;
	// 			}
	// 		}
	// 	}
	// 	else
	// 	{
	// 		if (CNTbreath_Led2 < 5)	/* max */
	// 		{
	// 			CNTbreath_Led2 = 5;
	// 			FbreathDir = CLR;
	// 		}
	// 		else if (CNTbreath_Led2 < 10)
	// 		{
	// 			if (++CNTbreath_Led1 >= 6)	/* 600ms */
	// 			{
	// 				CNTbreath_Led1 = 0;
	// 				CNTbreath_Led2--;
	// 			}
	// 		}
	// 		else if (CNTbreath_Led2 < 30)
	// 		{
	// 			if (++CNTbreath_Led1 >= 6)	/* 1200ms */
	// 			{
	// 				CNTbreath_Led1 = 0;
	// 				CNTbreath_Led2--;
	// 			}
	// 		}
	// 		else if (CNTbreath_Led2 < 40)
	// 		{
	// 			if (++CNTbreath_Led1 >= 8)	/* 800ms */
	// 			{
	// 				CNTbreath_Led1 = 0;
	// 				CNTbreath_Led2--;
	// 			}
	// 		}
	// 		else if (CNTbreath_Led2 < 60)
	// 		{
	// 			if (++CNTbreath_Led1 >= 4)	/* 800ms */
	// 			{
	// 				CNTbreath_Led1 = 0;
	// 				CNTbreath_Led2--;
	// 			}
	// 		}
	// 		else
	// 		{
	// 			if (++CNTbreath_Led1 >= 3)	/* 600ms，min */
	// 			{
	// 				CNTbreath_Led1 = 0;
	// 				CNTbreath_Led2--;
	// 			}
	// 		}
	// 	}
	// }
	// else
	// {
	// 	CNTbreath_Led1 = 0;
	// 	CNTbreath_Led2 = 0;
	// 	CNTbreath_Led3 = 0;
	// 	FbreathDir = CLR;
	// 	POlight = OFF;
	// }
}

void INT_LED_SHOW(void)
{
	// if((Flight == SET) && (FfctTest == CLR))
	if((Flight == SET) && (FfctTest == CLR))
	{
		if (++CNTbreath_Led == 80)
		{
			CNTbreath_Led = 0;
			POlight = OFF;
		}
		if (CNTbreath_Led >= CNTbreath_Led2)
		{
			POlight = ON;
		}
		else
		{
			POlight = OFF;
		}
	}
}

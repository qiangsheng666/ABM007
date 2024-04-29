#include "cfg_user.h"
#include "cfg_case.h"

BYTE Fflush1;



v_uint8 SEQflsuh = 0;
v_uint16 CNTflush = 0;  /* 冲水计时 */

void FlushTime(void);
void FlushJudge(void);
void FlushCon(void);

void GflushLoop(void)
{
    FlushTime();
    FlushJudge();
    FlushCon();
}

void FlushTime(void)
{

}
void FlushJudge(void)
{
    uint8_t Key_Step = 0;
    /* 请求判定 */
    #if DUBLE_FLUSH_MODE
    if(FbodyIn60s == SET)   /* 感应到60秒以上，大冲请求置位 */
    {
        YKfls_Big = SET;
        YKfls_Sml = CLR;
    }
    else if(FbodyIn5s == SET)   /* 感应到人5秒以上，小冲请求置位 */
    {
        YKfls_Sml = SET;
        YKfls_Big = CLR;
    }
    else if (SEQflsuh)
    {
        YKfls_Sml = CLR;
        YKfls_Big = CLR;
    }
    else
    {
        Key_Step = GkeyLoop();
        if (Key_Step)
        {
            SEQflsuh = Key_Step;
            CNTflush = 0;
            Flush_AutoLeaveWait = SET;
        }else
        {
           YKfls_Sml = CLR;
            YKfls_Big = CLR;
        }
    }
#else
    if(FbodyIn5s == SET)   /* 感应到人5秒以上，小冲请求置位 */
    {
        // YKfls_Sml = SET;
        // YKfls_Big = CLR;
        YKfls_Sml = CLR;
        YKfls_Big = SET;
    }
    else
    {
        YKfls_Sml = CLR;
        YKfls_Big = CLR;
    }
#endif
    /*********************************************/
	/*	自动冲水判断	*/
	if (FbodyExit == SET)	/* 离开冲水 */
	{
        Flush_AutoLeaveWait = SET;
	}
	if (Flush_AutoLeaveWait == SET) /*	离开自动冲水	*/
	{
		if (f_STSflush == SET)
		{
            YKfls_Sml = CLR;
            YKfls_Big = CLR;    /* 正在冲水，请求清除 */
			return;
		}
		Flush_AutoLeaveWait = CLR;
        if(YKfls_Big == SET)
        {
            YKfls_Big = CLR;
            OKfls_Big = SET;
            return;
        }
		if(YKfls_Sml == SET)
        {
            YKfls_Sml = CLR;
            OKfls_Sml = SET;
        }
		return;
	}
	/*	自动冲水判断	*/
	/******************************************/
}

/* 主阀气泵控制函数 */
void FlushCon(void)
{
    switch (SEQflsuh)
    {
        case FLUSH_INIT_0:
            f_STSflush = CLR;
            POairPump = OFF;
            POmainValue = OFF;
            POdirectValue = OFF;
            if((OKfls_Big == SET) || (OKfls_Sml == SET))
            {
                SEQflsuh = FLUSH_INIT_1;
                CNTflush = 0;
            }
            break;
        case FLUSH_INIT_1:
            f_STSflush = SET;
            POairPump = OFF;
            POmainValue = OFF;
            POdirectValue = OFF;
            if(Fbody == SET)        /* 检测到有人，流程跳到结束阶段 */
            {
                SEQflsuh = FLUSH_END_0;
                CNTflush = 0;
                break;
            }
            if(++CNTflush >= 5)
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_INIT_2;
            }
            break;
        case FLUSH_INIT_2:
            f_STSflush = SET;
            POairPump = OFF;        /* 冲水关闭 */
            POmainValue = OFF;      /* 冲水通道1  默认冲水通道,先假设无默认尝试*/ 
            POdirectValue = OFF;
            if(Fbody == SET)        /* 检测到有人，流程跳到结束阶段 */
            {
                SEQflsuh = FLUSH_END_0;
                CNTflush = 0;
                break;
            }

            if(OKfls_Big == SET)
            {
                SEQflsuh = FLUSH_BIG_0;
            }
            else if(OKfls_Sml == SET)
            {
                SEQflsuh = FLUSH_SML_0;
            }
            break;
        case FLUSH_BIG_0:   /* 大冲阶段 */
            f_STSflush = SET;
            POairPump = OFF;        /* 大冲先开电磁阀换大冲，后开气泵冲水 */
            POmainValue = ON;            /* 大冲*/
            POdirectValue = ON;
            if(++CNTflush >= 10)    /* 延迟100ms后打开气泵冲水 */
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_BIG_1;
            }
            break;
        case FLUSH_BIG_1:
            f_STSflush = SET;
            POairPump = ON;
            POmainValue = ON;
            POdirectValue = ON;
#if ABM007_FLUSH_2
            if(++CNTflush >= 100)   /* 冲水1s */
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_BIG_2;
            }
#else
            //if(++CNTflush >= 200)   /* 冲水2s */
            if(++CNTflush >= 100)   /* 冲水1s */
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_BIG_2;
            }
#endif
            break;
        case FLUSH_BIG_2:
            f_STSflush = SET;
            POairPump = OFF;        /* 关气泵，停止冲水 */
            POmainValue = SET;      /* 大冲先关气泵停止冲水，后关主阀 */    /* 冲水通道2 */
            POdirectValue = SET;
            if(++CNTflush >= 10)
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_END_0;
            }
            break;

        case FLUSH_SML_0:           /* 小冲阶段 */
            f_STSflush = SET;
            POairPump = OFF;        /* 小冲先开主阀阀换小冲，后开气泵冲水 */
            POmainValue = ON;      /* 冲水通道1 */
            POdirectValue = OFF;
            if(++CNTflush >= 5)
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_SML_1;
            }
            break;
        case FLUSH_SML_1:
            f_STSflush = SET;
            POairPump = ON;         /* 冲水 */
            POmainValue = ON;      /* 冲水通道1 */
            POdirectValue = OFF;
            // if(++CNTflush >= 200)
            if(++CNTflush >= 100)
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_SML_2;
            }
            break;
        case FLUSH_SML_2:
            f_STSflush = SET;
            POairPump = OFF;        /* 关气泵，停止冲水 */
            POmainValue = ON;      /* 冲水通道1 */
            POdirectValue = OFF;
            if(++CNTflush >= 5)
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_END_0;
            }
            break;

        case FLUSH_END_0:
            f_STSflush = SET;
            POairPump = OFF;        /* 停止冲水 */
            POmainValue = OFF;      /* 返回通道1 */
            POdirectValue = OFF;
            if(++CNTflush >= 5)
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_END_1;
            }
            break;
        case FLUSH_END_1:
            f_STSflush = CLR;
            POairPump = OFF;
            POmainValue = OFF;
            POdirectValue = OFF;
            SEQflsuh = FLUSH_INIT_0;
            CNTflush = 0;
            OKfls_Big = CLR;
            OKfls_Sml = CLR;
            break;
        default:
            f_STSflush = CLR;
            POairPump = OFF;
            POmainValue = OFF;
            POdirectValue = OFF;
            OKfls_Big = CLR;
            OKfls_Sml = CLR;
            SEQflsuh = FLUSH_INIT_0;
            CNTflush = 0;
            break;
    }
}



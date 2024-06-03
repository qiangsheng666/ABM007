#include "cfg_user.h"
#include "cfg_case.h"

BYTE Fflush1;



v_uint8 SEQflsuh = 0;
v_uint16 CNTflush = 0;  /* ��ˮ��ʱ */

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
    /* �����ж� */
#if DUBLE_FLUSH_MODE
    if(FbodyIn60s == SET)   /* ��Ӧ��60�����ϣ����������λ */
    {
        YKfls_Big = SET;
        YKfls_Sml = CLR;
    }
    else if(FbodyIn5s == SET)   /* ��Ӧ����5�����ϣ�С��������λ */
    {
        YKfls_Sml = SET;
        YKfls_Big = CLR;
    }
    else
    {
        YKfls_Sml = CLR;
        YKfls_Big = CLR;
    }
#else
    if(FbodyIn5s == SET)   /* ��Ӧ����5�����ϣ�С��������λ */
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
	/*	�Զ���ˮ�ж�	*/
	if (FbodyExit == SET)	/* �뿪��ˮ */
	{
        Flush_AutoLeaveWait = SET;
	}
	if (Flush_AutoLeaveWait == SET) /*	�뿪�Զ���ˮ	*/
	{
		if (f_STSflush == SET)
		{
            YKfls_Sml = CLR;
            YKfls_Big = CLR;    /* ���ڳ�ˮ��������� */
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
	/*	�Զ���ˮ�ж�	*/
	/******************************************/
}

/* �������ÿ��ƺ��� */
void FlushCon(void)
{
    switch (SEQflsuh)
    {
        case FLUSH_INIT_0:
            f_STSflush = CLR;
            POairPump = OFF;
            POmainValue = OFF;
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
            if(Fbody == SET)        /* ��⵽���ˣ��������������׶� */
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
            POairPump = OFF;        /* ��ˮ�ر� */
            POmainValue = OFF;      /* ��ˮͨ��1 */
            if(Fbody == SET)        /* ��⵽���ˣ��������������׶� */
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
        case FLUSH_BIG_0:   /* ���׶� */
            f_STSflush = SET;
            POairPump = OFF;        /* ����ȿ���ŷ�����壬�����ó�ˮ */
            POmainValue = ON;       /* �л�ͨ��2 */     /* ��ˮͨ��2 */
            if(++CNTflush >= 10)    /* �ӳ�100ms������ó�ˮ */
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_BIG_1;
            }
            break;
        case FLUSH_BIG_1:
            f_STSflush = SET;
            POairPump = ON;
            POmainValue = ON;
#if ABM007_FLUSH_2
            if(++CNTflush >= 100)   /* ��ˮ1s */
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_BIG_2;
            }
#else
            if(++CNTflush >= 200)   /* ��ˮ2s */
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_BIG_2;
            }
#endif
            break;
        case FLUSH_BIG_2:
            f_STSflush = SET;
            POairPump = OFF;        /* �����ã�ֹͣ��ˮ */
            POmainValue = SET;      /* ����ȹ�����ֹͣ��ˮ��������� */    /* ��ˮͨ��2 */
            if(++CNTflush >= 10)
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_END_0;
            }
            break;

        case FLUSH_SML_0:           /* С��׶� */
            f_STSflush = SET;
            POairPump = OFF;        /* С��رյ�ŷ� */
            POmainValue = OFF;      /* ��ˮͨ��1 */
            if(++CNTflush >= 5)
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_SML_1;
            }
            break;
        case FLUSH_SML_1:
            f_STSflush = SET;
            POairPump = ON;         /* ��ˮ */
            POmainValue = OFF;      /* ��ˮͨ��1 */
            if(++CNTflush >= 200)
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_SML_2;
            }
            break;
        case FLUSH_SML_2:
            f_STSflush = SET;
            POairPump = OFF;        /* �����ã�ֹͣ��ˮ */
            POmainValue = OFF;      /* ��ˮͨ��1 */
            if(++CNTflush >= 5)
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_END_0;
            }
            break;

        case FLUSH_END_0:
            f_STSflush = SET;
            POairPump = OFF;        /* ֹͣ��ˮ */
            POmainValue = OFF;      /* ����ͨ��1 */
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
            SEQflsuh = FLUSH_INIT_0;
            CNTflush = 0;
            OKfls_Big = CLR;
            OKfls_Sml = CLR;
            break;
        default:
            f_STSflush = CLR;
            POairPump = OFF;
            POmainValue = OFF;
            OKfls_Big = CLR;
            OKfls_Sml = CLR;
            SEQflsuh = FLUSH_INIT_0;
            CNTflush = 0;
            break;
    }
}



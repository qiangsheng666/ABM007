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
    uint8_t Key_Step = 0;
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
            if(Fbody == SET)      
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
            POairPump = OFF;       
            POmainValue = OFF;      
            POdirectValue = OFF;
            if(Fbody == SET)        
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
        case FLUSH_BIG_0:   
            f_STSflush = SET;
            POairPump = OFF;       
            POmainValue = ON;           
            POdirectValue = ON;
            if(++CNTflush >= 10)   
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
            if(++CNTflush >= 100)  
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_BIG_2;
            }
#else
            //if(++CNTflush >= 200)   
            if(++CNTflush >= 100) 
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_BIG_2;
            }
#endif
            break;
        case FLUSH_BIG_2:
            f_STSflush = SET;
            POairPump = OFF;       
            POmainValue = ON;       
            POdirectValue = ON;
            if(++CNTflush >= 10)
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_BIG_3;
            }
            break;
        case FLUSH_BIG_3:
            f_STSflush = SET;
            POairPump = OFF;    
            POmainValue = OFF;    
            POdirectValue = ON;
            if(++CNTflush >= 200)  
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_END_0;
            }
            break;
        case FLUSH_SML_0:         
            f_STSflush = SET;
            POairPump = OFF;      
            POmainValue = ON;      
            POdirectValue = OFF;
            if(++CNTflush >= 5)
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_SML_1;
            }
            break;
        case FLUSH_SML_1:
            f_STSflush = SET;
            POairPump = ON;         
            POmainValue = ON;    
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
            POairPump = OFF;       
            POmainValue = ON;     
            POdirectValue = OFF;
            if(++CNTflush >= 5)
            {
                CNTflush = 0;
                SEQflsuh = FLUSH_END_0;
            }
            break;

        case FLUSH_END_0:
            f_STSflush = SET;
            POairPump = OFF;        
            POmainValue = OFF;   
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



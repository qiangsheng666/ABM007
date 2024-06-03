#include "cfg_user.h"
#include "cfg_case.h"
#include "key_Private.h"



uint8_t GkeyLoop(void)
{
	for ( SeletedLine = 0; SeletedLine < 2; SeletedLine++)
	{
		KeyLines[SeletedLine].flags.level =ScanKey(SeletedLine);

		if(KeyLines[SeletedLine].flags.is_forbidden)
		{
			if (KeyLines[SeletedLine].flags.level)
			{
				KeyLines[SeletedLine].flags.is_forbidden = CLR;
			}
			continue;
		}
		if (KeyControl(&KeyLines[SeletedLine]))
		{
			switch (SeletedLine)
			{
			case PortA:
				YKfls_Big = SET;
				KeyLines[PortB].flags.is_forbidden = SET;
				return FLUSH_BIG_0;
			case PortB:
				YKfls_Sml = SET;
				KeyLines[PortA].flags.is_forbidden = SET;
				return FLUSH_SML_0;
			
			default:
				break;
			}
			
		}
	}
	return FALSE;
	
}


uint8_t ScanKey(SignalLines line_num)   /*用于判断按键引脚的状态*/
{
    switch (line_num)
	{
	case PortA:
		return PIKey1;
	case PortB:
		return PIKey2;
	}
}



uint8_t KeyControl(KEY_PRIVATE* this)/*用于按键的消除抖动处理*/
{
    if(!(this->flags.level))  //按键按下有效时间判定
    {
		if (this->flags.is_pressing)
		{
			this->cnt = CLR;

			if (IncrementJudgeToCLR(this->cnt_timeout,CNTKeyOutTime))
			{			
				this->flags.is_forbidden = SET;
			}

		}else
		{
			if (IncrementJudgeToCLR(this->cnt,CNTKeyTime))
			{
				this->flags.is_pressing = SET;
				return TRUE;
			}
		}	

    }
     else
    {
		if (this->flags.is_pressing)
		{
			if (IncrementJudgeToCLR(this->cnt,CNTKeyTime))
			{
				this->flags.is_pressing = CLR;
			}
		}else
		{
			this->cnt = CLR;
			this->cnt_timeout = CLR;
		}
   
    }
	return FALSE;
}

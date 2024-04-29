#include "cfg_user.h"
#include "cfg_case.h"
#include "key_Private.h"



void Key()
{
    KeyScan();
    JudgeKey();
    KeyControl();

}

uint8_t KeyScan(uint8_t i)
{
    current_IO_Trgging[(unsigned char)i] = CurrentIO ^ last_IO_value[(unsigned char)i];
	if(current_IO_Trgging[(unsigned char)i])
	{
		if(last_IO_value[(unsigned char)i])
		{
			last_IO_value[(unsigned char)i] = CLR;
			return TRUE;   /* 此时电平为低,按键按下 **/
		}
		else
		{
			last_IO_value[(unsigned char)i] = SET;
            		
		}
	}
    	return FALSE;	
}

void JudgeKey()
{
    switch (SeletedLine)
	{
	case PortA:
		CurrentIO = PIKey1;
		break;
	case PortB:
		CurrentIO = PIKey2;
		break;
	default:
		break;

    if()

}

void KeyControl()
{

}
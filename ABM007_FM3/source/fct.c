#include "cfg_user.h"
#include "cfg_case.h"

BYTE fctBits001;

// #define FfctTest fctBits001.bits.bit_0

unsigned char FCT = 0;

volatile unsigned int CNTfctStart;
volatile unsigned char CNTfctSensior;
volatile unsigned char CNTfctFlashLed;
volatile unsigned int CNTfct;
volatile unsigned int CNTkey1;
volatile unsigned int CNTkey2;
volatile unsigned int flag_time;

unsigned int Flag_G_Key = 0;

void FCTkey(void);
void FCTjudge(void);

void FCTloop(void)
{
    FCTkey();
    FCTjudge();
}

/* void FCTkey(void)
{
    if(PItest == HIGH)
    {
        if(++CNTfctStart >= 100)
        {
//            CNTfctStart = 100;
            FfctTest = 1;
			if(PItest == HIGH)
			{
				if(++CNTfctStart >= 500)
				{
					FfctTest = 0;
					CNTfctStart = 0;
					return;
				}
			}
//			CNTfctStart = 0;
			return;
        }
    }
}
*/
void FCTkey(void)
{
	if((FCT == 0) && (PItest == LOW))
	{
		FCT = 3;
	}
	
	if(FCT == 3)
	{
		if(PItest == HIGH)
		{
			if(++My_test_cnt > My_test_time)	
			{
				if(PItest == HIGH)
				{
					FfctTest = 1;
					My_test_cnt = CLR;
					FCT = 1;
					return;
				}
			}	

		}
		else
		{
			My_test_cnt = CLR;
		}
	}
	
	if((FCT == 1) && (PItest == LOW))
	{
		FCT = 2;
	}
	
	if(FCT == 2)
	{
		if(PItest == HIGH)
		{
			if(++My_test_cnt > My_test_time)
			{

				if(PItest == HIGH)
				{
					FfctTest = 0;
					My_test_cnt = CLR;
					FCT = 0;
					return;
				}
			}

		}
		else
		{
			My_test_cnt = CLR;
		}
		
	}
}

void G_KEY(void)
{
	POlight = LOW;
	POairPump = LOW;
	POmainValue = HIGH;
	POdirectValue = LOW;
}

void R_KEY(void)
{
	POlight = LOW;
	POairPump = HIGH;
	POmainValue = HIGH;
	POdirectValue = LOW;
}

void key1(void)
{
	POlight = HIGH;
	POairPump = LOW;
	POmainValue = HIGH;
	POdirectValue = LOW;
}

void key2(void)
{
	POlight = LOW;
	POairPump = LOW;
	POmainValue = HIGH;
	POdirectValue = HIGH;
}

void FCTjudge(void)
{
    if(FfctTest == 1)
    {
		if(++flag_time == 1500)
		{
			FfctTest = 0;
			flag_time = 0;
		}
		if(PIsensor == LOW)
		{
			R_KEY();
		}
		else
		{
			if(PIKey1 == LOW)
			{
				key1();
			}
			else
			{
				if(PIKey2 == LOW)
				{
					key2();
				}
				else
				{
					G_KEY();
				}
			}
		}
	}
    else if(FfctTest == 0)
    {
		flag_time = 0;
    }
}

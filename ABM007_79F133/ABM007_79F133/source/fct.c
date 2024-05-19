#include "cfg_user.h"
#include "cfg_case.h"

BYTE fctBits001;

// #define FfctTest fctBits001.bits.bit_0

volatile unsigned int CNTfctStart;
volatile unsigned char CNTfctSensior;
volatile unsigned char CNTfctFlashLed;
volatile unsigned int CNTfct;
volatile unsigned int CNTkey1;
volatile unsigned int CNTkey2;

unsigned int Flag_G_Key = 0;

void FCTkey(void);
void FCTjudge(void);

void FCTloop(void)
{
    FCTkey();
    FCTjudge();
}

void FCTkey(void)
{
    if(PItest == HIGH)
    {
        if(++CNTfctStart >= 100)
        {
//            CNTfctStart = 20;
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
			return;
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
		POlight = LOW;
		POairPump = LOW;
		POmainValue = LOW;
		POdirectValue = LOW;
    }
}


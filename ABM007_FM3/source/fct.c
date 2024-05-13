#include "cfg_user.h"
#include "cfg_case.h"

BYTE fctBits001;

// #define FfctTest fctBits001.bits.bit_0

volatile unsigned char CNTfctStart;
volatile unsigned char CNTfctSensior;
volatile unsigned char CNTfctFlashLed;
volatile unsigned int CNTfct;

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
        if(++CNTfctStart >= 50)
        {
            CNTfctStart = 50;
            FfctTest = SET;
        }
    }
    else
    {
        FfctTest = CLR;
        CNTfctStart = 0;
    }
}

void FCTjudge(void)
{
    if(FfctTest == SET)
    {
        if(PIsensor == LOW)
        {
            if(++CNTfctSensior >= 50)
            {
                CNTfct = 0;
                CNTfctSensior = 50;
                if(++CNTfctFlashLed >= 50)
                {
                    CNTfctFlashLed = 0;
                }
                else if(CNTfctFlashLed == 25)
                {
                    POlight = HIGH;
                    POairPump = HIGH;
                    POmainValue = HIGH;
                }
                else if(CNTfctFlashLed == 1)
                {
                    POlight = LOW;
                    POairPump = LOW;
                    POmainValue = LOW;
                }
            }
        }
        else
        {
            CNTfctSensior = 0;
            if(++CNTfct >= 100)
            {
                CNTfct = 0;
                // FfctTest = CLR;
                POlight = LOW;
                POairPump = LOW;
                POmainValue = LOW;
            }
            else if(CNTfct == 75)
            {
                POlight = HIGH;
                POairPump = LOW;
                POmainValue = LOW;
            }
            else if(CNTfct == 50)
            {
                POlight = LOW;
                POairPump = HIGH;
                POmainValue = LOW;
            }
            else if(CNTfct == 25)
            {
                POlight = LOW;
                POairPump = LOW;
                POmainValue = HIGH;
            }
        }
    }
    else
    {
        CNTfctSensior = 0;
        CNTfct = 0;
    }
}


#include "cfg_user.h"
#include "cfg_case.h"

volatile BYTE fctBits001;

#define FkeySta fctBits001.bits.bit_0

volatile unsigned char CNTfctStart;
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
    if(PIsensor == LOW)
    {
        if(++CNTfctStart >= 100)
        {
            CNTfctStart = 100;
            FkeySta = SET;
        }
    }
    else
    {
        CNTfctStart = 0;
    }
}

void FCTjudge(void)
{
    if(FkeySta == SET)
    {
        if(++CNTfct >= 500)
        {
            CNTfct = 500;
            FkeySta = CLR;
            POlight = LOW;
            POairPump = LOW;
            POmainValue = LOW;
        }
        else if(CNTfct == 350)
        {
            POlight = HIGH;
            POairPump = LOW;
            POmainValue = LOW;
        }
        else if(CNTfct == 200)
        {
            POlight = LOW;
            POairPump = HIGH;
            POmainValue = LOW;
        }
        else if(CNTfct == 50)
        {
            POlight = LOW;
            POairPump = LOW;
            POmainValue = HIGH;
        }
    }
    else
    {
        CNTfct = 0;
    }
}


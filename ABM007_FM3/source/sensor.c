#include "cfg_user.h"
#include "cfg_case.h"

BYTE Fbodysensor;

v_uint8 u8stsBodySensor = 0;
v_uint8 SEQbody = 0;
v_uint16 CNTbody_h = 0;         /* 感应高电平计时 */
v_uint16 CNTbody_l = 0;         /* 感应低电平计时 */
v_uint16 BufCntAdd = 0;         /* 感应计时 */
v_uint16 CNTbodyInTime = 0;     /* 感应到人计时 */
v_uint16 CNTbodyExitTime = 0;   /* 感应到人离开计时 */

void SensorKey(void);
void SensorTime(void);
void SensorJudge(void);
void SensorControl(void);

void GsensorLoop(void)
{
    SensorKey();
    SensorTime();
    SensorJudge();
    SensorControl();
}

void SensorKey(void)
{

}

/* 人体感应计时函数 */
void SensorTime(void)
{
    if(Fbody == SET)
    {
        FbodyEx5s = CLR;
        CNTbodyExitTime = 0;
        if(FlightLeave == CLR)  /* 检测到人有效时间 */
        {
            if(++CNTbodyInTime >= BODY_ENTER_KEEP_60S)	/* 60s */
            {
                CNTbodyInTime = BODY_ENTER_KEEP_60S;
                FbodyIn60s = SET;
            }
            else if(CNTbodyInTime >= BODY_ENTER_KEEP_5S)		/* 5s */
            {
                FbodyIn5s = SET;
            }
        }
        else
        {
            if(FbodyIn5s == CLR)    /* 未待满5s，时间清零 */
            {
                CNTbodyInTime = 0;
            }
        }
    }
    else
    {
        CNTbodyInTime = 0;
        FbodyIn5s = CLR;
        FbodyIn60s = CLR;
        if(++CNTbodyExitTime >= BODY_EXIT_KEEP_5S)
        {
            CNTbodyExitTime = BODY_EXIT_KEEP_5S;
            FbodyEx5s = SET;        /* 人离开5秒 */
        }
    }
}

/* 人体感应判定函数 */
void SensorJudge(void)
{
    switch (SEQbody)
    {
        case 0:
            Fbody = CLR;
            FlightLeave = CLR;
            SEQbody = 1;
            break;

        /* 人离开确认 */
        case 1:
            Fbody = CLR;
            FlightLeave = CLR;
            if(PIsensor == LOW)
            {
                if(++CNTbody_h >= SENSOR_TRG)
                {
                    CNTbody_h = 0;
					CNTbody_l = 0;
					SEQbody = 2;
					break;
                }
            }
            else
            {
                CNTbody_h = 0;
            }
            break;

        /* 感应到人判定开始 */
        case 2:
            Fbody = CLR;
            FlightLeave = CLR;
            if(PIsensor == LOW)
            {
                ++CNTbody_h;
            }
            else
            {
                if(++CNTbody_l >= SENSOR_ERROR)
                {
                    CNTbody_h = 0;
                    CNTbody_l = 0;
                    SEQbody = 1;
                    break;
                }
            }
            BufCntAdd = CNTbody_h +CNTbody_l;
            if(BufCntAdd >= SENSOR_BODY_ENTER_X_0S)
            {
                SEQbody = 3;
                break;
            }
            break;
        /* 感应到人确认 */
        case 3:
            Fbody = SET;
            FlightLeave = CLR;
            if(PIsensor == HIGH)
            {
                if(++CNTbody_l >= SENSOR_TRG)
                {
                    CNTbody_h = 0;
                    CNTbody_l = 0;
                    SEQbody = 4;
                    break;
                }
            }
            else
            {
                CNTbody_l = 0;
            }
            break;
        /* 人离开判定开始 */
        case 4:
            Fbody = SET;
            FlightLeave = SET;
            if(PIsensor == LOW)
            {
                if(++CNTbody_h >= SENSOR_ERROR)
                {
                    CNTbody_h = 0;
                    CNTbody_l = 0;
                    SEQbody = 3;
                    break;
                }
            }
            else
            {
                ++CNTbody_l;
            }
            BufCntAdd = CNTbody_h +CNTbody_l;
            if(BufCntAdd >= SENSOR_BODY_EXIT_X_0S)      /* 暂改为5s */
            {
                SEQbody = 1;
                break;
            }
            break;
        default:
            SEQbody = 0;
            FlightLeave = CLR;
            break;
    }
}

void SensorControl(void)
{
    FbodyEnter = CLR;
    FbodyExit = CLR;
    if(Fbufbody != Fbody)
    {
        if(Fbody == SET)
        {
            FbodyEnter = SET;   /* 感应到人瞬间 */
        }
        else
        {
            FbodyExit = SET;    /* 人离开瞬间 */
        }
        Fbufbody = Fbody;
    }
}


// void ScanIO(void){
// 	for (SeletedLine = 0; SeletedLine < 2; SeletedLine++)
// 	{
// 		judgeIO();
// 	}

// }
// uint8_t ScanSignal(uint8_t i)
// {
// 	current_IO_Trgging[(unsigned char)i] = CurrentIO ^ last_IO_value[(unsigned char)i];

// 	if(current_IO_Trgging[(unsigned char)i])
// 	{
// 		if(last_IO_value[(unsigned char)i])
// 		{
// 			last_IO_value[(unsigned char)i] = CLR;
// 			return TRUE;
// 		}
// 		else
// 		{
// 			last_IO_value[(unsigned char)i] = SET;
// 			IrIrqCnt_H[(unsigned char)i] = CLR;
// 		}
// 	}else if(last_IO_value[(unsigned char)i])	{
// 		if(IrIrqCnt_H[(unsigned char)i] < UINT16_MAX){
// 			IrIrqCnt_H[(unsigned char)i]++;
// 		}
// 	}
// 	else {
// 		if(IrIrqCnt_L[(unsigned char)i] < UINT16_MAX){
// 			IrIrqCnt_L[(unsigned char)i]++;
// 		}
// 	} 
// 	return FALSE;
// }

// void judgeIO(void)
// {
//     switch (SeletedLine)
// 	{
// 	case PortA:
// 		CurrentIO = PIKey1;
// 		break;
// 	case PortB:
// 		CurrentIO = PIKey2;
// 		break;
// 	default:
// 		break;
// 	}

//     if(ScanSignal(SeletedLine))
//     {
//         key_flag = SET;
//         switch (SeletedLine)
//         {
//         case PortA:
//         POairPump = SET;
//         POmainValue = SET;
//         POdirectValue = CLR;
//             break;
//         case PortB:
//         POdirectValue= SET;
//         POairPump =SET;
//         POmainValue = CLR;
//             break;
//         default:
//         POdirectValue= CLR;
//         POairPump =CLR;
//         POmainValue = CLR;
//             break;
//         }
         

//     }
//     else
//     {
//         if(key_flag)
//         {
//              switch (SeletedLine)
//             {
//             case PortA:
//             POairPump = CLR;
//             POmainValue = CLR;
//             POdirectValue = CLR;
//                 break;
//             case PortB:
//             POdirectValue= CLR;
//             POairPump =CLR;
//             POmainValue = CLR;
//                 break;
//             default:
//             POdirectValue= CLR;
//             POairPump =CLR;
//             POmainValue = CLR;
//                 break;
//             }
//             key_flag = CLR;
//         }
//     }
   
 


// }



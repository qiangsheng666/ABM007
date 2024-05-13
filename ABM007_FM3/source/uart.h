#ifndef __UART_USER_H__
#define __UART_USER_H__

extern volatile BYTE FuartBitG;
#define	FdevActTx	FuartBitG.bits.bit_0	/* 设备主动发送当前状态信息标识符 */
#define FwifiCfg    FuartBitG.bits.bit_1	/* 设备向模块发送进入配置模式标识符 */
#define Fwifi1st    FuartBitG.bits.bit_2    /* 设备首次通电或者复位配网标识 */

#define TM_TX_60S  600

extern void GuartLoop(void);
extern void Uart_ReceiveLogic(void);    /* UART接收内中断逻辑处理 */
extern void MotorAVuartInit(void);
extern void Uart_SendLogic(void);       /* UART发送中断逻辑 */

extern void GstartVoice(void);
// extern unsigned char VoiceCon(void);
extern unsigned char UartCom(void);
extern void WifiFirstFlagRead(void);

#endif
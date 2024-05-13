#ifndef __UART_USER_H__
#define __UART_USER_H__

extern volatile BYTE FuartBitG;
#define	FdevActTx	FuartBitG.bits.bit_0	/* �豸�������͵�ǰ״̬��Ϣ��ʶ�� */
#define FwifiCfg    FuartBitG.bits.bit_1	/* �豸��ģ�鷢�ͽ�������ģʽ��ʶ�� */
#define Fwifi1st    FuartBitG.bits.bit_2    /* �豸�״�ͨ����߸�λ������ʶ */

#define TM_TX_60S  600

extern void GuartLoop(void);
extern void Uart_ReceiveLogic(void);    /* UART�������ж��߼����� */
extern void MotorAVuartInit(void);
extern void Uart_SendLogic(void);       /* UART�����ж��߼� */

extern void GstartVoice(void);
// extern unsigned char VoiceCon(void);
extern unsigned char UartCom(void);
extern void WifiFirstFlagRead(void);

#endif
#include "cfg_user.h"
#include "cfg_case.h"
#include "math.h"
#include "string.h"

volatile BYTE FuartBitG;
volatile BYTE FuartBit01;
volatile BYTE FuartBit02;
volatile BYTE FuartBit03;
volatile BYTE FuartBit04;

#define Frr_s 		FuartBit01.bits.bit_0
#define FwrSend 	FuartBit01.bits.bit_1
#define	Fuart_OK	FuartBit01.bits.bit_2	/* ���ڷ���ָ�� */
#define FvoiceSta	FuartBit01.bits.bit_3	/* ��������ָ�� */
#define	FvoiceUart	FuartBit01.bits.bit_4	/* ����ͨ�� */
#define	Fvoice_Set	FuartBit01.bits.bit_5	/* ��������ָ�� */
// #define	Fvoice_Ok	FuartBit01.bits.bit_6	/* ����ָ�� */
// #define FuartBpsTx	FuartBit01.bits.bit_6	/* �������л���ʶ */
// #define FuartBpsSw	FuartBit01.bits.bit_7	/* �������л���ʶ */

#define	FwifiUart	FuartBit02.bits.bit_0	/* wifiͨѶ */
// #define	Fwifi_OK	FuartBit02.bits.bit_1	/* wifiָ�� */
#define Fwifi_OKtx	FuartBit02.bits.bit_2	/* wifi�յ���Ϣ��ȷ�� */
#define FdevTx62	FuartBit02.bits.bit_3	/* �����豸�汾��Ϣ */
#define FdevTx71	FuartBit02.bits.bit_4	/* ģ���ȡ�豸������Ϣ */
#define	FinvalidCom	FuartBit02.bits.bit_5	/* ��Чָ��Invalid command */
// #define	FdevActTx	FuartBit02.bits.bit_6	/* �豸�������͵�ǰ״̬��Ϣ��ʶ����תΪȫ�ֵ��ã� */
#define FalarmTx	FuartBit02.bits.bit_6	/* ���淢�ͱ�ʶ */
#define FalarmTx05	FuartBit02.bits.bit_7	/* ��ͣ5s��������;��� */

#define FdevOK_Tx	FuartBit03.bits.bit_0	/* �豸��WiFiģ�鷢��ȷ�ϱ�ʶ�� */
#define FwifiWork	FuartBit03.bits.bit_1	/* wifi������ɽ��빤��ģʽ��ʶ */
// #define FwifiCfg	FuartBit03.bits.bit_1	/* ����ģʽ��ʶ�� */
#define	FdevFreqSet	FuartBit03.bits.bit_2	/* �豸�����㱨��� */
#define	FdatFreqSet	FuartBit03.bits.bit_3	/* �豸�����ݻ㱨��� */
#define FalarmCheck	FuartBit03.bits.bit_4	/* 0x73->0x74ģ���ѯ���б�����Ϣ */
#define FwifiCfgSts	FuartBit03.bits.bit_5	/* wifi��������״̬ */
// #define	FtestUart	FuartBit03.bits.bit_6	/* ���Դ��ڱ�ʶ */
#define FdevActOff	FuartBit03.bits.bit_6	/* �豸�����㱨�û���Ϣ��0������1�ر� */
#define FdataAtoOff	FuartBit03.bits.bit_7	/* �豸�����ݻ㱨�����0������1�ر� */

#define	FsubBoardTx	FuartBit04.bits.bit_0	/* ��ѯ�Ӱ���Ϣ��0xE9 -> 0xEA */
#define	FmacTx		FuartBit04.bits.bit_1	/* ��ѯ�������Ӱ���Ϣ��0xEb -> 0xEC */
#define	Freset		FuartBit04.bits.bit_2	/* ��λ��ʶ */
#define FwifiSta	FuartBit04.bits.bit_3	/* �ϵ���ж�����״̬��ʶ */
#define bufFwifi1st	FuartBit04.bits.bit_4	/* �ж�����������ʶ�仯 */

uint8_t TX_Buf[49];		/* ������������ָ���� */
v_uint8 Uart_MaxRrNo; 	/* �������������� */
v_uint8 u8RxDi;
v_uint8 RxBuf1;
v_uint8 BUF_Rr[15];		/* �������������ָ���� */

v_uint8 tx_index;		/* �����ֽ��� */
v_uint8 TX_CNT = 0;

v_uint8 SEQuart_Dta;
v_uint8 SETuart_code;
v_uint8 CNTdevTx_Rx;
v_uint8 CNTwifiReplyTX;		/* �յ�ģ����Ϣ�㱨��ʱ */
v_uint8 CNTwifiTx100ms;
v_uint8 CNTwifiTx200ms;
v_uint8 CNTdevAlarmTx;

v_uint8 voice_Dta3 = 5;	/* ��������ͳ�� */
v_uint8 Voice_Key;		/* ��������ָ�����ָ��󲥱�ָ� */

v_uint16 CNTuartTxd;
v_uint16 CNTwifiCfgSts;		/* ����״̬��ʱ��������30min */
v_uint16 TM_DATA_TX = 600;	/* �����ݻ㱨���60s */
v_uint16 TM_DEV_TX = 600;	/* �豸�����㱨���60s */

extern v_uint8 RX_Buf;
extern v_uint16 DTmotorNGminSet;
extern v_uint16 DTmotorNGmaxSet;
// extern v_uint16 DTmotorNGmaxHot;

extern v_uint16 CNTstartCal;
extern v_uint16 AvgMotorAD;
extern v_uint16 AVmotor_ad;
extern v_uint32 SumMotorAD;

extern unsigned char Memory_Read(unsigned char Addr);

void WifiUartRxd(void);
void WifiUartTxd(void);
void VoiceUartTxd(void);
void VoiceUartRxd(void);
void TestUartTxd(void);
void TestUartRxd(void);
// void WifiUartBpsSet(void);

/* UARTͨѶ */
void GuartLoop(void)
{
	if(FvoiceSta == SET)
	{
		FvoiceSta = CLR;	/* ����������ǿ�Ʒ��ͣ�����ʶ�� */
		CNTuartTxd = 20;
		VoiceUartTxd();
	}
	
	if(FwifiUart == SET)
	{
		WifiUartTxd();
		WifiUartRxd();
	}
	else if(FvoiceUart == SET)
	{
		VoiceUartTxd();
		VoiceUartRxd();
	}
	else
	{
		TestUartTxd();
		TestUartRxd();
	}
}

/* ���ڷ����ж��߼� */
void Uart_SendLogic(void)
{
	TXREG1 = TX_Buf[TX_CNT];
	TX_CNT++;
	if (TX_CNT >= tx_index)
	{
		TX_CNT = 0;
		TX1IE = 0;
	}
}

/* ���ڽ����ж��߼� */
void Uart_ReceiveLogic(void)
{
	if(u8RxDi == 0)
	{
		if(RX_Buf == 0xC1)
		{
			BUF_Rr[u8RxDi] = RX_Buf;
			u8RxDi = 1;
			FvoiceUart = 1;			/* �������ݣ�7�������գ���WiFi���棩 */
			FwifiUart = 0;
			Uart_MaxRrNo = 7;
		}
		else if (RX_Buf == 0xFF)
		{
			BUF_Rr[u8RxDi] = RX_Buf;
			u8RxDi = 1;
			FvoiceUart = 0;
			FwifiUart = 1;			/* wifi���� */
			Uart_MaxRrNo = 15;
		}
		else if(RX_Buf == 0xCC)
		{
			BUF_Rr[u8RxDi] = RX_Buf;
			u8RxDi = 1;
			FvoiceUart = 0;			/* �������� */
			FwifiUart = 0;
			Uart_MaxRrNo = 6;		/* 6��ȫ�����գ���WiFi���� */
		}
	}
	else
	{
		BUF_Rr[u8RxDi] = RX_Buf;
		if(++u8RxDi >= Uart_MaxRrNo)
		{
			u8RxDi = 0;
			Frr_s = SET;
//			CREN1 = 0; /* ������ֹ */
		}
	}
}

/*******************************************************************/
/* �������ݣ�����λ��ͨѶ�� */
/* �������ݴ��ڷ��� */
void TestUartTxd(void)
{
	unsigned char itxd = 0;
	unsigned char u8motorSts = 0;
	if(++CNTuartTxd >= 20)
	{
		CNTuartTxd = 0;
		u8motorSts = GhangerStatus();
		if((u8motorSts != 0)
		|| (FwrSend == SET))	/* д��Ԥ��ֵ�󲹷�һ����Ϣ */
		{
			FwrSend = CLR;
			TX_Buf[0] = 0xAA; /* ͷ�룬1֡ */
			TX_Buf[1] = (unsigned char)AvgMotorAD; /* ����λ1������ֵ��λ */
			TX_Buf[2] = (unsigned char)(AvgMotorAD >> 8); /* ����λ2������ֵ��λ */
			TX_Buf[3] = u8motorSts; /* �������״̬ */
			/************************************/
			// TX_Buf[4] = (unsigned char)CNTstartCal; /* Ԥ��AD��λ */
			// TX_Buf[5] = (unsigned char)(CNTstartCal >> 8 ); /* Ԥ��AD��λ */
			// TX_Buf[6] = (unsigned char)SumMotorAD; /* Ԥ��AD��λ */
			// TX_Buf[7] = (unsigned char)(SumMotorAD >> 8); /* Ԥ��AD��λ */
			/********************************/
			TX_Buf[4] = (unsigned char)DTmotorNGminSet; /* Ԥ��AD��λ */
			TX_Buf[5] = (unsigned char)(DTmotorNGminSet >> 8 ); /* Ԥ��AD��λ */
			TX_Buf[6] = (unsigned char)DTmotorNGmaxSet; /* Ԥ��AD��λ */
			TX_Buf[7] = (unsigned char)(DTmotorNGmaxSet >> 8); /* Ԥ��AD��λ */
			/**********************************************/
			TX_Buf[8] = (unsigned char)AVmotor_ad; /* ����λ1������ֵ��λ */
			TX_Buf[9] = (unsigned char)(AVmotor_ad >> 8); /* ����λ2������ֵ��λ */
			TX_Buf[10] = 0;
			for(itxd = 1; itxd < 10; itxd++)
			{
				TX_Buf[10] += TX_Buf[itxd];		/* �ۼ� */
			}
			tx_index = 11;		/* �����ֽ��� */
			TX1IE = 1;			/* �򿪷����ж� */
			CREN1 = 1;			/* ������� */
		}
	}
}

/* �������ݴ��ڽ��������ж� */
void TestUartRxd(void)
{
	unsigned char irxd = 0;
	unsigned char irxdCheck = 0;
	if(Frr_s == SET)
	{
		Frr_s = CLR;
		for(irxd = 1; irxd <= 4; irxd++)
		{
			irxdCheck += BUF_Rr[irxd];
		}
		if(BUF_Rr[5] == irxdCheck)
		{
			if(BUF_Rr[1] == 0x01)	/* 0x01Ԥ��������ʶ */
			{
				DTmotorNGminSet = BUF_Rr[2];
				DTmotorNGminSet = (DTmotorNGminSet << 8) + BUF_Rr[3];
				/* Ԥ��ֵд��洢 */
				Flash_Write(0x70, BUF_Rr[2]);		/* ��8λ */
				Flash_Write(0x71, BUF_Rr[3]);		/* ��8λ */
				// DTmotorNGmax = (DTmotorNGmin + 4 * ADper01A);	/* Ԥ�����ֵ,Ԥ��ֵ+0.4A */
				// Flash_Write(0x72, (DTmotorNGmax >> 8));		/* ��8λ */
				// Flash_Write(0x73, DTmotorNGmax);			/* ��8λ */
				FwrSend = SET;		/* ����һ����Ϣ����ʾ��ǰ״ֵ̬ */
			}
			else if(BUF_Rr[1] == 0x02)		/* ����������ʶ�� */
			{
				DTmotorNGmaxSet = BUF_Rr[2];		/* ��8λ */
				DTmotorNGmaxSet = (DTmotorNGmaxSet << 8) + BUF_Rr[3];	/* ��8λ */
				/* �Ͽ�ֵд��洢 */
				// Flash_Write(0x72, (DTmotorNGmax >> 8));		/* ��8λ */
				// Flash_Write(0x73, DTmotorNGmax);			/* ��8λ */
				Flash_Write(0x72, BUF_Rr[2]);		/* ��8λ */
				Flash_Write(0x73, BUF_Rr[3]);		/* ��8λ */
				/*����Ԥ��ֵ*/
				DTmotorNGminSet = DTmotorNGmaxSet - ADper01A - ADper02A;	/* ����ֵ-0.3A */
				Flash_Write(0x70, (unsigned char)(DTmotorNGminSet >> 8));		/* ��8λ */
				Flash_Write(0x71, (unsigned char)DTmotorNGminSet);		/* ��8λ */
				FwrSend = SET;		/* ����һ����Ϣ����ʾ��ǰ״ֵ̬ */
			}
			// else if(BUF_Rr[1] == 0x03)		/* ��̬����������ʶ�� */
			// {
			// 	DTmotorNGmaxHot = BUF_Rr[2];		/* ��8λ */
			// 	DTmotorNGmaxHot = (DTmotorNGmaxHot << 8) + BUF_Rr[3];	/* ��8λ */
			// 	/* �Ͽ�ֵд��洢 */
			// 	// Flash_Write(0x72, (DTmotorNGmax >> 8));		/* ��8λ */
			// 	// Flash_Write(0x73, DTmotorNGmax);			/* ��8λ */
			// 	Flash_Write(0x74, BUF_Rr[2]);		/* ��8λ */
			// 	Flash_Write(0x75, BUF_Rr[3]);		/* ��8λ */
			// 	FwrSend = SET;		/* ����һ����Ϣ����ʾ��ǰ״ֵ̬ */
			// }
			else if(BUF_Rr[1] == 0x04)		/* ��̬����������ʶ�� */
			{
				if(BUF_Rr[4] == 0xAC)
				{
					SiCon_SETkey = KEY_UP;
				}
				else if(BUF_Rr[4] == 0xCA)
				{
					SiCon_SETkey = KEY_DOWN;
				}
				else if(BUF_Rr[4] == 0xDD)
				{
					SiCon_SETkey = KEY_STP;
				}
			}
		}
	}
}

/*******************************************************************/
/* �����Ǽ�WiFi */
/* WIFIģ�������Ϣ���� */
void WifiUartRxd(void)
{
	if(Frr_s == SET)
	{
		Frr_s = CLR;
		if(BUF_Rr[9] == 0x61)
		{
			FdevTx62 = SET;	/* �����豸�汾��Ϣ */
		}
		else if(BUF_Rr[9] == 0xE8)
		{
			// SPBRG = 25; /* 19200bps, 8M/(16*26) */
			// FwifiUart = SET;
		}
		else if(BUF_Rr[9] == 0x70)
		{
			FdevTx71 = SET;	/* ģ���ȡ�豸������Ϣ */
		}
		else if(BUF_Rr[9] == 0x05)	/* ģ��ȷ�ϱ�ʶ */
		{
			FdevActTx = CLR;
			if(FalarmTx == SET)
			{
				FalarmTx = CLR;
				FalarmTx05 == SET;	/* ��ͣ5s */
			}
		}
		else if(BUF_Rr[9] == 0x73)
		{
			FalarmCheck = SET;
		}
		else if(BUF_Rr[9] == 0x09)
		{
			FalarmTx = CLR;
			FalarmTx05 = CLR;	/* ������� */
			FdevOK_Tx = SET;	/* �豸����ȷ����Ϣ��ʶ */
		}
		else if(BUF_Rr[9] == 0xF3)	/* �豸��������WiFi�� */ 
		{
			// if(BUF_Rr[11] == 0x03)
			// {
				FwifiCfg = CLR;	/* ���ģʽ */
			// }
		}
		else if((BUF_Rr[9] == 0xF7) || (BUF_Rr[9] == 0xF1))	/* F7WiFiģ����������F1�豸��ѯ�� */
		{
			if(BUF_Rr[11] == 0x00)
			{
				if(FwifiCfgSts == SET)
				{
					FwifiWork = SET;	/* 00ͨѶ������01�޷�����ap��02�޷����ӷ�������03�豸��������ģʽ */
					FwifiCfgSts = CLR;
					Fwifi1st = SET;		/* ��Գɹ� */
				}
				FdevOK_Tx = SET;	/* ģ��WiFi�����㱨ȷ��֡ */
			}
			else if(BUF_Rr[11] == 0x03)
			{
				FwifiCfg = CLR;	/* ���ģʽ */
				FwifiCfgSts = SET;
			}
		}
		// else if(BUF_Rr[9] == 0xE9)
		// {
		// 	FsubBoardTx = SET;	/* ��ѯ�Ӱ���Ϣ */
		// }
		// else if(BUF_Rr[9] == 0xEB)
		// {
		// 	FmacTx = SET;	/* ��ѯ������Ϣ */
		// }
		else if(BUF_Rr[9] == 0x7C)
		{
			FdevFreqSet = SET;	/* �豸�����㱨��� */
			TM_DEV_TX = (BUF_Rr[10] << 8);
			TM_DEV_TX += BUF_Rr[11];
			if(TM_DEV_TX == 0)
			{
				FdevActOff = 1;		/* ��������Ϣ����0ʱ����ʾ�رջ㱨���� */
			}
			else if(TM_DEV_TX == 0xFFFF)
			{
				TM_DEV_TX = TM_TX_60S;	/* ��������ϢΪ 0xFFFF ʱ����ʾ��ʼ��ʱ���������豸Ĭ�ϵ�ʱ�����жϡ� */
				FdevActOff = 0;	/* �豸��Ĭ�ϵĻ㱨�ж�ʱ����Ϊ60�롣 */
			}
			else
			{
				FdevActOff = 0;
			}
		}
		else if(BUF_Rr[9] == 0xFA)
		{
			FdatFreqSet = SET;	/* �豸�����ݻ㱨��� */
			TM_DATA_TX = (BUF_Rr[10] << 8);
			TM_DATA_TX += BUF_Rr[11];
			if(TM_DATA_TX == 0)
			{
				FdataAtoOff = SET;		/* ��������Ϣ����0ʱ����ʾ�رջ㱨���� */
			}
			else if(TM_DATA_TX == 0xFFFF)
			{
				TM_DATA_TX = 600;	/* ��������ϢΪ 0xFFFF ʱ����ʾ��ʼ��ʱ���������豸Ĭ�ϵ�ʱ�����жϡ� */
				FdataAtoOff = CLR;	/* �豸��Ĭ�ϵĻ㱨�ж�ʱ����Ϊ60�롣 */
			}
			else
			{
				FdataAtoOff = CLR;
			}
		}
		else if(BUF_Rr[9] == 0x01)
		{
			if((BUF_Rr[10] == 0x4D)
			&& (BUF_Rr[11] == 0x01))	/* ��ѯ����״̬(getAllProperty) */
			{
				Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
			}
			else if(BUF_Rr[10] == 0x5D)	/* ����ָ�� */
			{
				if((BUF_Rr[11] == 0x09) && (BUF_Rr[12] == 0x00) && (BUF_Rr[13] == 0x00))
				{
					// FinvalidCom = SET;	/* ��Чָ�� */
					Freset = SET;		/* ��λ��ʶ */
					Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
					/* ��λ, ���޴˹��� */
				}
				else if((BUF_Rr[11] == 0x01) && (BUF_Rr[12] == 0x00))	/* �˶�״̬(moveStatus) */
				{
					if(BUF_Rr[13] == 0x00)	/* ֹͣ */
					{
						Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
						Fuart_OK = SET;
						SETuart_code = KEY_STP;
					}
					else if(BUF_Rr[13] == 0x01)	/* ���� */
					{
						Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
						Fuart_OK = SET;
						SETuart_code = KEY_UP;
					}
					else if(BUF_Rr[13] == 0x02)	/* �½� */
					{
						Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
						Fuart_OK = SET;
						SETuart_code = KEY_DOWN;
					}
					else
					{
						FinvalidCom = SET;	/* ��Чָ�� */
						Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
					}
				}
				else if((BUF_Rr[11] == 0x02) &&	(BUF_Rr[12] == 0x00))	/* ��������״̬(lightStatus) */
				{
					if(BUF_Rr[13] == 0x00)
					{
						if(Flight == SET)
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
							Fuart_OK = SET;
							SETuart_code = KEY_LIGHT;	/* �ص� */
						}
						else
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
						}
					}
					else if(BUF_Rr[13] == 0x01)
					{
						if (Flight == CLR)
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
							Fuart_OK = SET;
							SETuart_code = KEY_LIGHT;	/* ���� */
						}
						else
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
						}
					}
					else
					{
						FinvalidCom = SET;	/* ��Чָ�� */
						Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
					}
				}
				else if((BUF_Rr[11] == 0x0D) && (BUF_Rr[12] == 0x00))	/* ������ʱ����ʱ(lightCountdown)  */
				{
					Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
					LGT_CNT_DWON = BUF_Rr[13];	/* ��λ<���180min>  */
				}
	#if VER_2510M
				else if((BUF_Rr[11] == 0x03) && (BUF_Rr[12] == 0x00))	/* ��ɹ���״̬(airDryStatus)  */
				{
					if(BUF_Rr[13] == 0x00)	/* �رշ�� */
					{
						if(OKfan == SET)
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
							Fuart_OK = SET;
							SETuart_code = KEY_FAN;
						}
						else
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
						}
					}
					else if(BUF_Rr[13] == 0x01)	/* �򿪷�� */
					{
						if(OKfan == CLR)
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
							Fuart_OK = SET;
							SETuart_code = KEY_FAN;
						}
						else
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
						}
					}
					else
					{
						FinvalidCom = SET;	/* ��Чָ�� */
						Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
					}
				}
				else if((BUF_Rr[11] == 0x04) && (BUF_Rr[12] == 0x00))	/* ��ɶ�ʱ����ʱ(airDryCountdown)  */
				{
					Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
					FAN_CNT_DWON = BUF_Rr[13];	/* ��λ<���240min>  */
				}
				else if((BUF_Rr[11] == 0x05) && (BUF_Rr[12] == 0x00))	/* ��ɹ���״̬(dryStatus) */
				{
					if(BUF_Rr[13] == 0x00)	/* �رպ�� */
					{
						if(OKdry == SET)
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
							Fuart_OK = SET;
							SETuart_code = KEY_DRY;
						}
						else
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
						}
					}
					else if(BUF_Rr[13] == 0x01)	/* �򿪺�� */
					{
						if(OKdry == CLR)
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
							Fuart_OK = SET;
							SETuart_code = KEY_DRY;
						}
						else
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
						}
					}
					else
					{
						FinvalidCom = SET;	/* ��Чָ�� */
						Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
					}
				}
				else if((BUF_Rr[11] == 0x06) && (BUF_Rr[12] == 0x00))/* ��ɶ�ʱ����ʱ(dryCountdown)  */
				{
					Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
					DRY_CNT_DWON = BUF_Rr[13];	/* ��λ<���240min> */
				}
				else if((BUF_Rr[11] == 0x0B) && (BUF_Rr[12] == 0x00))	/* ��ɶ�ʱʱ��(dryTimingTime)  */
				{
					Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
					TM_DRY = BUF_Rr[13];	/* <���240min>  */
				}
				else if((BUF_Rr[11] == 0x0C) && (BUF_Rr[12] == 0x00))	/* ��ɶ�ʱʱ��(airDryTimingTime)  */
				{
					Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
					TM_FAN = BUF_Rr[13];	/* <���240min>  */
				}
				else if((BUF_Rr[11] == 0x0E) && (BUF_Rr[12] == 0x00))	/* �����Ӷ�ʱ����ʱ(anionCountdown) */
				{
					// FinvalidCom = SET;	/* ��Чָ������������ͬʱ���� */
					Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
				}
				else
				{
					FinvalidCom = SET;	/* ��Чָ�� */
					Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
				}
	#elif VER_2510U
				else if((BUF_Rr[11] == 0x07) && (BUF_Rr[12] == 0x00))	/* ��������״̬(disinfectStatus)  */
				{
					if(BUF_Rr[13] == 0x00)	/* �ر�����ɱ��*/
					{
						if (OKuvc == SET)
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
							Fuart_OK = SET;
							SETuart_code = KEY_UVC;
						}
						else
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
						}
					}
					else if(BUF_Rr[13] == 0x01)	/* ������ɱ�� */
					{
						if(OKuvc == CLR)
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
							Fuart_OK = SET;
							SETuart_code = KEY_UVC;
						}
						else
						{
							Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
						}
					}
					else
					{
						FinvalidCom = SET;	/* ��Чָ�� */
						Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
					}
				}
				else if((BUF_Rr[11] == 0x08) && (BUF_Rr[12] == 0x00))	/* ������ʱ����ʱ(disinfectCountdown) */
				{
					Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
					UVC_CNT_DWON = BUF_Rr[13];	/* ��λ<���240min> */
				}
				else if((BUF_Rr[11] == 0x0A)	&& (BUF_Rr[12] == 0x00))/* ������ʱʱ��(disinfectTimingTime) */
				{
					Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
					TM_UVC = BUF_Rr[13];	/* <���240min>  */
				}
	#endif
			}
			else
			{
				FinvalidCom = SET;	/* ��Чָ�� */
				Fwifi_OKtx = SET;	/* �����豸״̬��Ϣ */
			}
		}
	}
}

/* �����豸�汾��Ϣ, ֡����0x62��WiFi֡����0x61�� */
void DeviceVersionTx(void)
{
	unsigned char DevTx_i = 0;
	TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	TX_Buf[2] = 0x2C; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	TX_Buf[9] = 0x62; 	/* ֡���� */
	/* ������Ϣ 10 - 47 byte, 38 bytes */
	/* �豸Э��汾 10-17, 8bytes, E++2.17��ASCII�� */
	TX_Buf[10] = 0x45;	/* ASCII��, E */
	TX_Buf[11] = 0x2B;	/* ASCII��, + */
	TX_Buf[12] = 0x2B;	/* ASCII��, + */
	TX_Buf[13] = 0x32;	/* ASCII��, 2 */
	TX_Buf[14] = 0x2E;	/* ASCII��, . */
	TX_Buf[15] = 0x31;	/* ASCII��, 1 */
	TX_Buf[16] = 0x37;	/* ASCII��, 7 */
	TX_Buf[17] = 0x00;	/* ASCII��, NUL */
	/* �豸����汾��8B��18 - 25, ASCII��:SLM3415A */
	TX_Buf[18] = 0x53;	/* ASCII��, S */
	TX_Buf[19] = 0x4C;	/* ASCII��, L */
	TX_Buf[20] = 0x4D;	/* ASCII��, M */
	TX_Buf[21] = 0x33;	/* ASCII��, 3 */
	TX_Buf[22] = 0x34;	/* ASCII��, 4 */
	TX_Buf[23] = 0x31;	/* ASCII��, 1 */
	TX_Buf[24] = 0x35;	/* ASCII��, 5 */
#if VER_2510L
	TX_Buf[25] = 0x41;	/* ASCII��, A */
#elif VER_2510M
	TX_Buf[25] = 0x42;	/* ASCII��, B */
#else
	TX_Buf[25] = 0x43;	/* ASCII��, C */
#endif
	/* ���ܱ�־��3B��26-28,�ҵ粻֧�ּ��� */
	TX_Buf[26] = 0xF1;	/* 0xF1 */
	TX_Buf[27] = 0x00;
	TX_Buf[28] = 0x00;
	/* �豸Ӳ���汾��8B), 29-36, ASCII��:SLM3415(����) */
	TX_Buf[29] = 0x53;	/* ASCII��, S */
	TX_Buf[30] = 0x4C;	/* ASCII��, L */
	TX_Buf[31] = 0x4D;	/* ASCII��, M */
	TX_Buf[32] = 0x33;	/* ASCII��, 3 */
	TX_Buf[33] = 0x34;	/* ASCII��, 4 */
	TX_Buf[34] = 0x31;	/* ASCII��, 1 */
	TX_Buf[35] = 0x35;	/* ASCII��, 5 */
	TX_Buf[36] = 0x00;	/* ASCII��, NUL */
	/* Ԥ��1byte */
	TX_Buf[37] = 0x00;
	/* SoftAp����ģʽʱ�豸�����ƣ�8B��, 38-45, ASCII��:U-RACK */
	TX_Buf[38] = 0x55;
	TX_Buf[39] = 0x2D;
	TX_Buf[40] = 0x52;
	TX_Buf[41] = 0x41;
	TX_Buf[42] = 0x43;
	TX_Buf[43] = 0x4B;
	TX_Buf[44] = 0x00;
	TX_Buf[45] = 0x00;
	// /* �豸������Ϣ��2B��, 46-47, HEX */
	// TX_Buf[46] = 0x00;
	// TX_Buf[47] = 0x00;	/* ��5λ,0��֧���豸��ɫ,1��ʾ֧���豸��ɫ;��3λ, 0��ʾ��֧�ֵװ���Ϣ��ѯ,1��ʾ֧�ֵװ���Ϣ��ѯ; ��2λ,0��ʾ��֧��CRCУ���,1��ʾ֧��CRCУ��� */
	TX_Buf[46] = 0X00;	/* �ۼ�У��� */
	for(DevTx_i = 2; DevTx_i < 46; DevTx_i++)
	{
		TX_Buf[46] += TX_Buf[DevTx_i];
	}
	tx_index = 47;		/* �����ֽ��� */
	TX1IE = 1;			/* �򿪷����ж� */
	CREN1 = 1;			/* ������� */
	// Uart_MaxRrNo = 15; 	/* �����ֽ���(���15) */
}

/* �豸������Ϣ, ֡����71��ģ��70�� */
void DeviceTypeTx(void)
{
	unsigned char DevTx_i = 0;
	TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	TX_Buf[2] = 0x28; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	TX_Buf[9] = 0x71; 	/* ֡���� */
	/* ������Ϣ(TYPEID, 32B), 10 - 41, ��Ʒ��Ϣ��������ע�� */
	/* �����ṩ��Ϣ */
	TX_Buf[10] = 0x20;
	TX_Buf[11] = 0x54;
	TX_Buf[12] = 0xa0;
	TX_Buf[13] = 0xd6;
	TX_Buf[14] = 0x10;
	TX_Buf[15] = 0xc6;
	TX_Buf[16] = 0xd2;
	TX_Buf[17] = 0x10;
	TX_Buf[18] = 0x14;
	TX_Buf[19] = 0x10;
	TX_Buf[20] = 0xc3;
	TX_Buf[21] = 0x06;
	TX_Buf[22] = 0x37;
	TX_Buf[23] = 0x3a;
	TX_Buf[24] = 0xd1;
	TX_Buf[25] = 0x00;
	TX_Buf[26] = 0x00;
	TX_Buf[27] = 0x00;
	TX_Buf[28] = 0xc1;
	TX_Buf[29] = 0x8e;
	TX_Buf[30] = 0x94;
	TX_Buf[31] = 0x22;
	TX_Buf[32] = 0xd1;
	TX_Buf[33] = 0x0e;
	TX_Buf[34] = 0xae;
	TX_Buf[35] = 0xd3;
	TX_Buf[36] = 0x1c;
	TX_Buf[37] = 0x24;
	TX_Buf[38] = 0x22;
	TX_Buf[39] = 0x27;
	TX_Buf[40] = 0xe5;
	TX_Buf[41] = 0x40;

	/* SLM�ṩ(�޷���ȡ��Ʒ��Ϣ) */
	// TX_Buf[10] = 0x20;
	// TX_Buf[11] = 0x1c;
	// TX_Buf[12] = 0x51;
	// TX_Buf[13] = 0x89;
	// TX_Buf[14] = 0x0c;
	// TX_Buf[15] = 0x31;
	// TX_Buf[16] = 0xc3;
	// TX_Buf[17] = 0x08;
	// TX_Buf[18] = 0x14;
	// TX_Buf[19] = 0x10;
	// TX_Buf[20] = 0xf6;
	// TX_Buf[21] = 0x6d;
	// TX_Buf[22] = 0x07;
	// TX_Buf[23] = 0x2a;
	// TX_Buf[24] = 0xb0;
	// TX_Buf[25] = 0x00;
	// TX_Buf[26] = 0x00;
	// TX_Buf[27] = 0x00;
	// TX_Buf[28] = 0x7e;
	// TX_Buf[29] = 0x2e;
	// TX_Buf[30] = 0xf9;
	// TX_Buf[31] = 0x5d;
	// TX_Buf[32] = 0x67;
	// TX_Buf[33] = 0x3c;
	// TX_Buf[34] = 0xb8;
	// TX_Buf[35] = 0x85;
	// TX_Buf[36] = 0x60;
	// TX_Buf[37] = 0x08;
	// TX_Buf[38] = 0xb6;
	// TX_Buf[39] = 0xfe;
	// TX_Buf[40] = 0x43;
	// TX_Buf[41] = 0x40;

	/* ��һ��ע�� */
	// TX_Buf[10] = 0x20;
	// TX_Buf[11] = 0x1c;
	// TX_Buf[12] = 0x10;
	// TX_Buf[13] = 0x0d;
	// TX_Buf[14] = 0x2c;
	// TX_Buf[15] = 0x71;
	// TX_Buf[16] = 0x04;
	// TX_Buf[17] = 0x10;
	// TX_Buf[18] = 0x14;
	// TX_Buf[19] = 0x10;
	// TX_Buf[20] = 0xf0;
	// TX_Buf[21] = 0x0e;
	// TX_Buf[22] = 0x96;
	// TX_Buf[23] = 0xd5;
	// TX_Buf[24] = 0x22;
	// TX_Buf[25] = 0x00;
	// TX_Buf[26] = 0x00;
	// TX_Buf[27] = 0x00;
	// TX_Buf[28] = 0x86;
	// TX_Buf[29] = 0xb9;
	// TX_Buf[30] = 0xfc;
	// TX_Buf[31] = 0x24;
	// TX_Buf[32] = 0x0a;
	// TX_Buf[33] = 0x56;
	// TX_Buf[34] = 0xf1;
	// TX_Buf[35] = 0x03;
	// TX_Buf[36] = 0x20;
	// TX_Buf[37] = 0x3a;
	// TX_Buf[38] = 0x2a;
	// TX_Buf[39] = 0x21;
	// TX_Buf[40] = 0x1d;
	// TX_Buf[41] = 0xc0;

// #if (VER_2510M || VER_2510L)	/* ȫ���ܿ� */
// 	/* �ڶ���ע�ᣨ������豸�ͺ�SLM01�� */
	// TX_Buf[10] = 0x20;
	// TX_Buf[11] = 0x1c;
	// TX_Buf[12] = 0x10;
	// TX_Buf[13] = 0x0d;
	// TX_Buf[14] = 0x2c;
	// TX_Buf[15] = 0x71;
	// TX_Buf[16] = 0x04;
	// TX_Buf[17] = 0x10;
	// TX_Buf[18] = 0x14;
	// TX_Buf[19] = 0x10;
	// TX_Buf[20] = 0xac;
	// TX_Buf[21] = 0xa8;
	// TX_Buf[22] = 0x49;
	// TX_Buf[23] = 0x99;
	// TX_Buf[24] = 0x25;
	// TX_Buf[25] = 0x00;
	// TX_Buf[26] = 0x00;
	// TX_Buf[27] = 0x00;
	// TX_Buf[28] = 0x1f;
	// TX_Buf[29] = 0x7a;
	// TX_Buf[30] = 0x59;
	// TX_Buf[31] = 0x54;
	// TX_Buf[32] = 0x7e;
	// TX_Buf[33] = 0xc4;
	// TX_Buf[34] = 0xe8;
	// TX_Buf[35] = 0x2c;
	// TX_Buf[36] = 0x29;
	// TX_Buf[37] = 0xeb;
	// TX_Buf[38] = 0xf4;
	// TX_Buf[39] = 0x69;
	// TX_Buf[40] = 0xef;
	// TX_Buf[41] = 0xc0;

// #elif VER_2510U	/* ����ɱ���� */
// 	/* �������ͺŲ���SLM02A������ɱ��� */
// 	TX_Buf[10] = 0x20;
// 	TX_Buf[11] = 0x1c;
// 	TX_Buf[12] = 0x10;
// 	TX_Buf[13] = 0x0d;
// 	TX_Buf[14] = 0x2c;
// 	TX_Buf[15] = 0x71;
// 	TX_Buf[16] = 0x04;
// 	TX_Buf[17] = 0x10;
// 	TX_Buf[18] = 0x14;
// 	TX_Buf[19] = 0x10;
// 	TX_Buf[20] = 0x82;
// 	TX_Buf[21] = 0xcc;
// 	TX_Buf[22] = 0x22;
// 	TX_Buf[23] = 0x3a;
// 	TX_Buf[24] = 0x54;
// 	TX_Buf[25] = 0x00;
// 	TX_Buf[26] = 0x00;
// 	TX_Buf[27] = 0x00;
// 	TX_Buf[28] = 0x07;
// 	TX_Buf[29] = 0xcd;
// 	TX_Buf[30] = 0x15;
// 	TX_Buf[31] = 0x0c;
// 	TX_Buf[32] = 0x33;
// 	TX_Buf[33] = 0x74;
// 	TX_Buf[34] = 0x0b;
// 	TX_Buf[35] = 0x15;
// 	TX_Buf[36] = 0x1b;
// 	TX_Buf[37] = 0x2a;
// 	TX_Buf[38] = 0x0e;
// 	TX_Buf[39] = 0x10;
// 	TX_Buf[40] = 0xd6;
// 	TX_Buf[41] = 0xc0;
// #endif

	TX_Buf[42] = 0x00;
	for(DevTx_i = 2; DevTx_i < 42; DevTx_i++)
	{
		TX_Buf[42] += TX_Buf[DevTx_i];
	}
	tx_index = 43;		/* �����ֽ��� */
	TX1IE = 1;			/* �򿪷����ж� */
	CREN1 = 1;			/* ������� */
	// Uart_MaxRrNo = 15; 	/* �����ֽ���(���15) */
}

/* ����ָ��״̬��Ϣ���أ�Fwifi_OKtx 0x02�������¼�豸״̬�� */
void WiFiDeviceReturn(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	TX_Buf[2] = 0x18; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	TX_Buf[9] = 0x02; 	/* ֡���� */
	TX_Buf[10] = 0x6D;	/* ������Ϣ */
	TX_Buf[11] = 0x01;  /* ������Ϣ */

	/* �豸״̬��14bytes�� 12-25byte */
	/* �˶�״̬(moveStatus) Byte1:Bit2~ Byte1:Bit0 */
	if(OKhang_UP == SET)
	{
		TX_Buf[12] = 0x01; /* 01���� */
	}
	else if(OKhang_DWN == SET)
	{
		TX_Buf[12] = 0x02; /* 02�½� */
	}
	else
	{
		TX_Buf[12] = 0x00; /* 00ֹͣ */
	}
	/* ͣ��λ��(position) Byte2:Bit2~Byte2:Bit0 */
	if(PIhang_H == SET)
	{
		TX_Buf[13] = 0x00;	/* 00������ */
	}
	else if(PIhang_L == SET)
	{
		TX_Buf[13] = 0x02;	/* 02������ */
	}
	else
	{
		TX_Buf[13] = 0x01;	/* 01�м� */
	}
	/* ��������״̬(lightStatus) Byte3:Bit0 */
	if(Flight == SET)
	{
		TX_Buf[14] = 0x01;	/* 1������ */
	}
	else
	{
		TX_Buf[14] = 0x00;	/* ������ */
	}
	/* ��ɹ���״̬(airDryStatus) Byte4:Bit0 */
	if(OKfan == SET)
	{
		TX_Buf[15] = 0x01; /* 1��ɿ� */
	}
	else
	{
		TX_Buf[15] = 0x00; /* 0��ɹ� */
	}
	TX_Buf[16] = FAN_CNT_DWON;	/* ��ɶ�ʱ����ʱ(airDryCountdown) Byte5 */
	/* ��ɹ���״̬(dryStatus) Byte6:Bit1  */
	if(OKdry == SET)
	{
		TX_Buf[17] = 0x01; /* 1��ɿ� */
	}
	else
	{
		TX_Buf[17] = 0x00; /* 0��ɹ� */
	}
	TX_Buf[18] = DRY_CNT_DWON;	/* ��ɶ�ʱ����ʱ(dryCountdown)	Byte7 */
	/* ��������״̬(disinfectStatus��Byte8:Bit0 */
	if(OKuvc == SET)
	{
		TX_Buf[19] = 0x01;	/* ������ */
	}
	else
	{
		TX_Buf[19] = 0x00;	/* ������ */
	}
	TX_Buf[20] = UVC_CNT_DWON;	/* ������ʱ����ʱ(disinfectCountdown)  byte9 */
	TX_Buf[21] = TM_UVC;		/* ������ʱʱ��(disinfectTimingTime)��Byte10, ���޴˹��� */
	TX_Buf[22] = TM_DRY;		/* ��ɶ�ʱʱ��(dryTimingTime) Byte11 */
	TX_Buf[23] = TM_FAN;		/* ��ɶ�ʱʱ��(airDryTimingTime), Byte12 */
	TX_Buf[24] = LGT_CNT_DWON;	/* ������ʱ����ʱ(lightCountdown), Byte13 */
	TX_Buf[25] = FAN_CNT_DWON;	/* �����Ӷ�ʱ����ʱ(anionCountdown), Byte14, ���޴˹��� */

	TX_Buf[26] = 0x00;			/* ��У�� */
	for(TX_i = 2; TX_i < 26; TX_i++)
	{
		TX_Buf[26] += TX_Buf[TX_i];
	}
	tx_index = 27;		/* �����ֽ��� */
	TX1IE = 1;			/* �򿪷����ж� */
	CREN1 = 1;			/* ������� */
// #if 0
// 	TX_Buf[12] = 0x00;	/* ��ֵ���� */
// 	/* �˶�״̬(moveStatus) Byte1:Bit7~ Byte1:Bit6 */
// 	if(OKhang_UP == SET)
// 	{
// 		TX_Buf[12] = 0x40; /* 01���� */
// 	}
// 	else if(OKhang_DWN == SET)
// 	{
// 		TX_Buf[12] = 0x80; /* 02�½� */
// 	}
// 	else
// 	{
// 		TX_Buf[12] = 0x00; /* 00ֹͣ */
// 	}
// 	/* ͣ��λ��(position) Byte1:Bit5~Byte1:Bit4 */
// 	if(PIhang_H == SET)
// 	{
// 		TX_Buf[12] |= 0x00;	/* 00������ */
// 	}
// 	else if(PIhang_L == SET)
// 	{
// 		TX_Buf[12] |= 0x20;	/* 02������ */
// 	}
// 	else
// 	{
// 		TX_Buf[12] |= 0x10;	/* 01�м� */
// 	}
// 	/* ��������״̬(lightStatus) Byte1:Bit3 */
// 	if(Flight == SET)
// 	{
// 		TX_Buf[12] |= 0x08;	/* 1������ */
// 	}
// 	// else
// 	// {
// 	// 	TX_Buf[12] &= ~0x08;	/* ������ */
// 	// }
// 	/* ��ɹ���״̬(airDryStatus) Byte1:Bit2 */
// 	if(OKfan == SET)
// 	{
// 		TX_Buf[12] |= 0x04; /* 1��ɿ� */
// 	}
// 	/* ��ɹ���״̬(dryStatus) Byte1:Bit1  */
// 	if(OKdry == SET)
// 	{
// 		TX_Buf[12] |= 0x02; /* 1��ɿ� */
// 	}
// 	/* ��������״̬(disinfectStatus��Byte1:Bit0 */
// 	/* �޴˹��� */

// 	TX_Buf[13] = DRY_CNT_DWON;	/* ��ɶ�ʱ����ʱ(dryCountdown)	Byte2 */
// 	TX_Buf[14] = FAN_CNT_DWON;	/* ��ɶ�ʱ����ʱ(airDryCountdown) Byte3 */
// 	TX_Buf[15] = UVC_CNT_DWON;			/* ������ʱ����ʱ(disinfectCountdown) Byte4, ���޴˹��� */
// 	TX_Buf[16] = TM_UVC;			/* ������ʱʱ��(disinfectTimingTime)��Byte5, ���޴˹��� */
// 	TX_Buf[17] = TM_DRY;		/* ��ɶ�ʱʱ��(dryTimingTime) Byte6 */
// 	TX_Buf[18] = TM_FAN;		/* ��ɶ�ʱʱ��(airDryTimingTime), Byte7 */
// 	TX_Buf[19] = LGT_CNT_DWON;	/* ������ʱ����ʱ(lightCountdown), Byte8 */
// 	TX_Buf[20] = 0x00;			/* �����Ӷ�ʱ����ʱ(anionCountdown), Byte9, ���޴˹��� */
// 	TX_Buf[21] = 0x00;			/* Ԥ�� */
// 	TX_Buf[22] = 0x00;			/* ��У�� */
// 	for(TX_i = 2; TX_i < 22; TX_i++)
// 	{
// 		TX_Buf[22] += TX_Buf[TX_i];
// 	}
// 	tx_index = 23;		/* �����ֽ��� */
// 	TX1IE = 1;			/* �򿪷����ж� */
// 	CREN1 = 1;			/* ������� */
// 	// Uart_MaxRrNo = 15; 	/* �����ֽ���(���15) */
// #endif
}

/* ��Ч���� 0x03 */
void WiFiInvalidCom(void)
{
	TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	TX_Buf[2] = 0x08; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	TX_Buf[9] = 0x03; 	/* ֡���� */
	TX_Buf[10] = 0x0B;	/* ��У�� */
	tx_index = 11;		/* �����ֽ��� */
	TX1IE = 1;			/* �򿪷����ж� */
	CREN1 = 1;			/* ������� */
	// Uart_MaxRrNo = 15; 	/* �����ֽ���(���15) */
}

/* �豸�������ͱ�����Ϣ, 0x04/0x74 */
void WiFiAlarmTx(void)
{
	unsigned char Tx_i = 0;
	unsigned char u8alarmData = 0;
	static unsigned char u8bufAlarmData = 0;
	/* 0x01, ��Դ���� */
	if(FmotorNG_Bz == SET)	/* ���� */
	{
		u8alarmData |= 0x02;
	}
	if(FmotorHot == SET)	/* ��̬ */
	{
		u8alarmData |= 0x04;
	}
	if(PIhang_S == SET)	/* ���� */
	{
		u8alarmData |= 0x08;
	}
	else if(FpowerLow == SET)	/* �����תʱ����ֵ̫�� */
	{
		FpowerLow = CLR;	/* �������� */
		u8alarmData |= 0x01;
	}

	if(u8alarmData != u8bufAlarmData)
	{
		u8bufAlarmData = u8alarmData;
		FalarmTx = SET;		/* ����ָ��仯�����ñ��� */
	}
	
	if((FalarmTx == SET)		/* �����ϱ� */
	|| (FalarmCheck == SET))	/* WiFiģ���ѯ */
	{
		TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
		TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
		TX_Buf[2] = 0x0C; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
		TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
		TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
		TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
		TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
		TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
		TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
		if(FalarmCheck == SET)
		{
			TX_Buf[9] = 0x74; 	/* ֡���� */
			FalarmCheck = CLR;
		}
		else
		{
			TX_Buf[9] = 0x04; 	/* ֡���� */
		}
		TX_Buf[10] = 0x0F;	/* ������Ϣ */
		TX_Buf[11] = 0x5A;  /* ������Ϣ */
		TX_Buf[12] = 0x00;	/* ������Ϣ */
		TX_Buf[13] = u8alarmData;	/* ������Ϣ */
		TX_Buf[14] = 0x00;	/* ��У�� */
		for(Tx_i = 2; Tx_i < 14; Tx_i++)
		{
			TX_Buf[14] += TX_Buf[Tx_i];
		}
		tx_index = 15;		/* �����ֽ��� */
		TX1IE = 1;			/* �򿪷����ж� */
		CREN1 = 1;			/* ������� */
		// Uart_MaxRrNo = 15; 	/* �����ֽ���(���15) */
	}
	/* 7��������еı�����ʧ��ҲҪ���չ�����ȫ0�ı������ֱ���յ�09�� */
//	if(u8bufAlarmData == 0)
//	{
//		FalarmTx = CLR;
//	}
}

/* �豸��WiFiģ�鷢��ȷ����Ϣ */
/* ģ��ֹͣ�豸������Ϣ 0x09->0x05(ȷ����Ϣ) */
void WiFiDeviceOKTx(void)
{
	TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	TX_Buf[2] = 0x08; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	TX_Buf[9] = 0x05; 	/* ֡���� */
	TX_Buf[10] = 0x0D;	/* ��У�� */
	tx_index = 11;		/* �����ֽ��� */
	TX1IE = 1;			/* �򿪷����ж� */
	CREN1 = 1;			/* ������� */
	// Uart_MaxRrNo = 15; 	/* �����ֽ���(���15) */
}

/* �豸����Ԥ����ʱ�����ж�״̬֡�еĲ���״̬���κβ���״̬�����仯ʱ��	*/
/* �豸���Ϸ��ͻ㱨֡��û�в���״̬�����仯����һ��ʱ�����ٴ��жϡ�		*/
/* �豸�������͵�ǰ״̬��Ϣ��ÿ��60s��һ�Σ�0x06 */
void DeviceActiveInfoTX(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	TX_Buf[2] = 0x18; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	TX_Buf[9] = 0x06; 	/* ֡���� */
	TX_Buf[10] = 0x6D;	/* ������Ϣ */
	TX_Buf[11] = 0x01;  /* ������Ϣ */

	/* �豸״̬��14bytes�� 12-25byte */
	/* �˶�״̬(moveStatus) Byte1:Bit2~ Byte1:Bit0 */
	if(OKhang_UP == SET)
	{
		TX_Buf[12] = 0x01; /* 01���� */
	}
	else if(OKhang_DWN == SET)
	{
		TX_Buf[12] = 0x02; /* 02�½� */
	}
	else
	{
		TX_Buf[12] = 0x00; /* 00ֹͣ */
	}
	/* ͣ��λ��(position) Byte2:Bit2~Byte2:Bit0 */
	if(PIhang_H == SET)
	{
		TX_Buf[13] = 0x00;	/* 00������ */
	}
	else if(PIhang_L == SET)
	{
		TX_Buf[13] = 0x02;	/* 02������ */
	}
	else
	{
		TX_Buf[13] = 0x01;	/* 01�м� */
	}
	/* ��������״̬(lightStatus) Byte3:Bit0 */
	if(Flight == SET)
	{
		TX_Buf[14] = 0x01;	/* 1������ */
	}
	else
	{
		TX_Buf[14] = 0x00;	/* ������ */
	}
	/* ��ɹ���״̬(airDryStatus) Byte4:Bit0 */
	if(OKfan == SET)
	{
		TX_Buf[15] = 0x01; /* 1��ɿ� */
	}
	else
	{
		TX_Buf[15] = 0x00; /* 0��ɹ� */
	}
	TX_Buf[16] = FAN_CNT_DWON;	/* ��ɶ�ʱ����ʱ(airDryCountdown) Byte5 */
	/* ��ɹ���״̬(dryStatus) Byte6:Bit1  */
	if(OKdry == SET)
	{
		TX_Buf[17] = 0x01; /* 1��ɿ� */
	}
	else
	{
		TX_Buf[17] = 0x00; /* 0��ɹ� */
	}
	TX_Buf[18] = DRY_CNT_DWON;	/* ��ɶ�ʱ����ʱ(dryCountdown)	Byte7 */
	/* ��������״̬(disinfectStatus��Byte8:Bit0 */
	if(OKuvc == SET)
	{
		TX_Buf[19] = 0x01;	/* ������ */
	}
	else
	{
		TX_Buf[19] = 0x00;	/* ������ */
	}
	TX_Buf[20] = UVC_CNT_DWON;	/* ������ʱ����ʱ(disinfectCountdown)  byte9 */
	TX_Buf[21] = TM_UVC;		/* ������ʱʱ��(disinfectTimingTime)��Byte10, ���޴˹��� */
	TX_Buf[22] = TM_DRY;		/* ��ɶ�ʱʱ��(dryTimingTime) Byte11 */
	TX_Buf[23] = TM_FAN;		/* ��ɶ�ʱʱ��(airDryTimingTime), Byte12 */
	TX_Buf[24] = LGT_CNT_DWON;	/* ������ʱ����ʱ(lightCountdown), Byte13 */
	TX_Buf[25] = FAN_CNT_DWON;	/* �����Ӷ�ʱ����ʱ(anionCountdown), Byte14, ���޴˹��� */

	TX_Buf[26] = 0x00;			/* ��У�� */
	for(TX_i = 2; TX_i < 26; TX_i++)
	{
		TX_Buf[26] += TX_Buf[TX_i];
	}
	tx_index = 27;		/* �����ֽ��� */
	TX1IE = 1;			/* �򿪷����ж� */
	CREN1 = 1;			/* ������� */

	// /* �豸״̬��10bytes�� 12-21byte */
	// TX_Buf[12] = 0x00;	/* ��ֵ���� */
	// /* �˶�״̬(moveStatus) Byte1:Bit7~ Byte1:Bit6 */
	// if(OKhang_UP == SET)
	// {
	// 	TX_Buf[12] = 0x40; /* 01���� */
	// }
	// else if(OKhang_DWN == SET)
	// {
	// 	TX_Buf[12] = 0x80; /* 02�½� */
	// }
	// else
	// {
	// 	TX_Buf[12] = 0x00; /* 00ֹͣ */
	// }
	// /* ͣ��λ��(position) Byte1:Bit5~Byte1:Bit4 */
	// if(PIhang_H == SET)
	// {
	// 	TX_Buf[12] |= 0x00;	/* 00������ */
	// }
	// else if(PIhang_L == SET)
	// {
	// 	TX_Buf[12] |= 0x20;	/* 02������ */
	// }
	// else
	// {
	// 	TX_Buf[12] |= 0x10;	/* 01�м� */
	// }
	// /* ��������״̬(lightStatus) Byte1:Bit3 */
	// if(Flight == SET)
	// {
	// 	TX_Buf[12] |= 0x08;	/* 1������ */
	// }
	// // else
	// // {
	// // 	TX_Buf[12] &= ~0x08;	/* ������ */
	// // }
	// /* ��ɹ���״̬(airDryStatus) Byte1:Bit2 */
	// if(OKfan == SET)
	// {
	// 	TX_Buf[12] |= 0x04; /* 1��ɿ� */
	// }
	// /* ��ɹ���״̬(dryStatus) Byte1:Bit1  */
	// if(OKdry == SET)
	// {
	// 	TX_Buf[12] |= 0x02; /* 1��ɿ� */
	// }
	// /* ��������״̬(disinfectStatus��Byte1:Bit0 */
	// if(OKuvc == SET)
	// {
	// 	TX_Buf[12] |= 0x01; /* 1������ */
	// }

	// TX_Buf[13] = DRY_CNT_DWON;	/* ��ɶ�ʱ����ʱ(dryCountdown)	Byte2 */
	// TX_Buf[14] = FAN_CNT_DWON;	/* ��ɶ�ʱ����ʱ(airDryCountdown) Byte3 */
	// TX_Buf[15] = UVC_CNT_DWON;	/* ������ʱ����ʱ(disinfectCountdown) Byte4, ���޴˹��� */
	// TX_Buf[16] = TM_UVC;		/* ������ʱʱ��(disinfectTimingTime)��Byte5, ���޴˹��� */
	// TX_Buf[17] = TM_DRY;		/* ��ɶ�ʱʱ��(dryTimingTime) Byte6 */
	// TX_Buf[18] = TM_FAN;		/* ��ɶ�ʱʱ��(airDryTimingTime), Byte7 */
	// TX_Buf[19] = LGT_CNT_DWON;	/* ������ʱ����ʱ(lightCountdown), Byte8 */
	// TX_Buf[20] = 0x00;			/* �����Ӷ�ʱ����ʱ(anionCountdown), Byte9, ���޴˹��� */
	// TX_Buf[21] = 0x00;			/* Ԥ�� */
	// TX_Buf[22] = 0x00;			/* ��У�� */
	// for(TX_i = 2; TX_i < 22; TX_i++)
	// {
	// 	TX_Buf[22] += TX_Buf[TX_i];
	// }
	// tx_index = 23;		/* �����ֽ��� */
	// TX1IE = 1;			/* �򿪷����ж� */
	// CREN1 = 1;			/* ������� */
	// // Uart_MaxRrNo = 15; 	/* �����ֽ���(���15) */
}

/* �豸֪ͨģ���������ģʽ */
void WiFiConfigModeTx(void)
{
	TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	TX_Buf[2] = 0x0A; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	TX_Buf[9] = 0xF2; 	/* ֡���� */
	TX_Buf[10] = 0x00;	/*  */
	TX_Buf[11] = 0x00;	/* softAp��BT����ģʽ���Ƽ��� */
	TX_Buf[12] = 0xFC;	/* ��У�� */
	tx_index = 13;		/* �����ֽ��� */
	TX1IE = 1;			/* �򿪷����ж� */
	CREN1 = 1;			/* ������� */
	// Uart_MaxRrNo = 15; 	/* �����ֽ���(���15) */
}

/* �豸֪ͨģ����빤��ģʽ0xF4 */
void WiFiWorkModeTX(void)
{
	TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	TX_Buf[2] = 0x0A; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	TX_Buf[9] = 0xF4; 	/* ֡���� */
	TX_Buf[10] = 0x00;	/*  */
	TX_Buf[11] = 0x00;	/* ����ģʽ */
	TX_Buf[12] = 0xFE;	/* ��У�� */
	tx_index = 13;		/* �����ֽ��� */
	TX1IE = 1;			/* �򿪷����ж� */
	CREN1 = 1;			/* ������� */
	// Uart_MaxRrNo = 15; 	/* �����ֽ���(���15) */
}

/* �豸�����㱨���0x7D */
void DeviceFreqSetTx(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	TX_Buf[2] = 0x0A; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	TX_Buf[9] = 0x7D; 	/* ֡���� */
	// TX_Buf[10] = 0xFF;	/* Ĭ��ֵ */
	// TX_Buf[11] = 0xFF;	/* Ĭ��ֵ */
	TX_Buf[10] = (unsigned char)(TM_DEV_TX>> 8);	/* ��λ */
	TX_Buf[11] = (unsigned char)(TM_DEV_TX);	/* ��λ */
	TX_Buf[12] = 0x00;	/* ��У�� */
	for(TX_i = 2; TX_i < 12; TX_i++)
	{
		TX_Buf[12] += TX_Buf[TX_i];
	}
	tx_index = 13;		/* �����ֽ��� */
	TX1IE = 1;			/* �򿪷����ж� */
	CREN1 = 1;			/* ������� */
	// Uart_MaxRrNo = 15; 	/* �����ֽ���(���15) */
}

/* �豸�����ݻ㱨���FB */
void DataFreqSetTx(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	TX_Buf[2] = 0x0A; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	TX_Buf[9] = 0xFB; 	/* ֡���� */
	// TX_Buf[10] = 0xFF;	/* Ĭ��ֵ */
	// TX_Buf[11] = 0xFF;	/* Ĭ��ֵ */
	TX_Buf[10] = (unsigned char)(TM_DATA_TX >> 8);	/* ��λ */
	TX_Buf[11] = (unsigned char)(TM_DATA_TX);	/* ��λ */
	TX_Buf[12] = 0x00;	/* ��У�� */
	for(TX_i = 2; TX_i < 12; TX_i++)
	{
		TX_Buf[12] += TX_Buf[TX_i];
	}
	tx_index = 13;		/* �����ֽ��� */
	TX1IE = 1;			/* �򿪷����ж� */
	CREN1 = 1;			/* ������� */
	// Uart_MaxRrNo = 15; 	/* �����ֽ���(���15) */
}

/* �����ʸ����趨��0xE7(��ѡ��OTA��ѡ) */
void WifiUartBpsSet(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	TX_Buf[2] = 0x09; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	TX_Buf[9] = 0xE7; 	/* ֡���� */
	TX_Buf[10] = 0x05;	/* �����ʴ��룬19200 */
	TX_Buf[11] = 0x00;	/* ��У�� */
	for(TX_i = 2; TX_i < 11; TX_i++)
	{
		TX_Buf[11] += TX_Buf[TX_i];
	}
	tx_index = 12;		/* �����ֽ��� */
	TX1IE = 1;			/* �򿪷����ж� */
	CREN1 = 1;			/* ������� */
	// Uart_MaxRrNo = 15; 	/* �����ֽ���(���15) */
}

/* ��ѯ�Ӱ���Ϣ,0xEA(WiFi - 0xE9) */
void WifiSubBoardInfoTx(void)
{
	// unsigned char TX_i = 0;
	// TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	// TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	// TX_Buf[2] = 0x2C; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	// TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	// TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	// TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	// TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	// TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	// TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	// TX_Buf[9] = 0xEA; 	/* ֡���� */
	// TX_Buf[10] = 0x00;	/* ������Ϣ���Ӱ�� */
	// /* �Ӱ������ʶ����20bytes��11-30 */
	// TX_Buf[11] = 0x00;
	// TX_Buf[12] = 0x00;
	// TX_Buf[13] = 0x00;
	// TX_Buf[14] = 0x00;
	// TX_Buf[15] = 0x00;
	// TX_Buf[16] = 0x00;
	// TX_Buf[17] = 0x00;
	// TX_Buf[18] = 0x00;
	// TX_Buf[19] = 0x00;
	// TX_Buf[20] = 0x00;
	// TX_Buf[21] = 0x00;
	// TX_Buf[22] = 0x00;
	// TX_Buf[23] = 0x00;
	// TX_Buf[24] = 0x00;
	// TX_Buf[25] = 0x00;
	// TX_Buf[26] = 0x00;
	// TX_Buf[27] = 0x00;
	// TX_Buf[28] = 0x00;
	// TX_Buf[29] = 0x00;
	// TX_Buf[30] = 0x00;
	// /* �Ӱ�����汾�ţ�14bytes��31-44 */
	// TX_Buf[31] = 0x00;
	// TX_Buf[32] = 0x00;
	// TX_Buf[33] = 0x00;
	// TX_Buf[34] = 0x00;
	// TX_Buf[35] = 0x00;
	// TX_Buf[36] = 0x00;
	// TX_Buf[37] = 0x00;
	// TX_Buf[38] = 0x00;
	// TX_Buf[39] = 0x00;
	// TX_Buf[40] = 0x00;
	// TX_Buf[41] = 0x00;
	// TX_Buf[42] = 0x00;
	// TX_Buf[43] = 0x00;
	// TX_Buf[44] = 0x00;
	// /* �Ƿ�֧������ */
	// TX_Buf[45] = 0x00;

	// TX_Buf[46] = 0x00;	/* ��У�� */
	// for(TX_i = 2; TX_i < 46; TX_i++)
	// {
	// 	TX_Buf[46] += TX_Buf[TX_i];
	// }
	// tx_index = 47;		/* �����ֽ��� */
	// TX1IE = 1;			/* �򿪷����ж� */
	// CREN1 = 1;			/* ������� */
}

/* �������ݴ�0xEC */
void WifiMachineInfoTx(void)
{
	// unsigned char TX_i = 0;
	// TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	// TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	// TX_Buf[2] = 0x2C; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	// TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	// TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	// TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	// TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	// TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	// TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	// TX_Buf[9] = 0xEC; 	/* ֡���� */

	// // tx_index = 47;		/* �����ֽ��� */
	// TX1IE = 1;			/* �򿪷����ж� */
	// CREN1 = 1;			/* ������� */
}

/* ģ�����������Ϣ֡ */
void WifiInfoClearTx(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	TX_Buf[2] = 0x08; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	TX_Buf[9] = 0xF8; 	/* ֡���� */
	TX_Buf[10] = 0x00;	/* ��У�� */
	for(TX_i = 2; TX_i < 10; TX_i++)
	{
		TX_Buf[10] += TX_Buf[TX_i];
	}
	tx_index = 11;		/* �����ֽ��� */
	TX1IE = 1;			/* �򿪷����ж� */
	CREN1 = 1;			/* ������� */
}

/* ģ�������������ģʽ֡,0xF9 */
void WifiProductTestTx(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* ֡ͷ1 */
	TX_Buf[1] = 0xFF; 	/* ֡ͷ2 */
	TX_Buf[2] = 0x08; 	/* ֡��������Ԥ��λ��֡���͡�������Ϣ��У������ڵ�����֡���ȵ��ֽ�����֡������Ϊ1���ֽڣ�ȡֵ��Χ 8��254����������CRCУ��͡����ֽ��� �� */
	TX_Buf[3] = 0x00; 	/* ��־λ��bit6Ϊ1��CRCУ��, 0x40 */
	TX_Buf[4] = 0x00; 	/* Ԥ��λ1 */
	TX_Buf[5] = 0x00; 	/* Ԥ��λ2 */
	TX_Buf[6] = 0x00; 	/* Ԥ��λ3 */
	TX_Buf[7] = 0x00; 	/* Ԥ��λ4 */
	TX_Buf[8] = 0x00; 	/* Ԥ��λ5 */
	TX_Buf[9] = 0xF9; 	/* ֡���� */
	TX_Buf[10] = 0x00;	/* ��У�� */
	for(TX_i = 2; TX_i < 10; TX_i++)
	{
		TX_Buf[10] += TX_Buf[TX_i];
	}
	tx_index = 11;		/* �����ֽ��� */
	TX1IE = 1;			/* �򿪷����ж� */
	CREN1 = 1;			/* ������� */
}

/* WIFIģ�鷢����Ϣ���� */
void WifiUartTxd(void)
{
	if(FwifiSta == CLR)
	{
		FwifiSta = SET;
		if(Fwifi1st == CLR)
		{
			FwifiCfg = SET;
		}
	}

	if(Fwifi1st != bufFwifi1st)
	{
		bufFwifi1st = Fwifi1st;
		if(Fwifi1st == SET)
		{
			Flash_Write(0x59, 0x01);	/* ���仯��ʶ����¼ */
		}
		else
		{
			Flash_Write(0x59, 0x00);	/* ���仯��ʶ����¼ */
		}
	}

	if(++CNTwifiTx100ms >= 10)
	{
		CNTwifiTx100ms = 0;
		if(FdevActOff == CLR)	/* �����㱨���� */
		{
			if(FdevActTx == CLR)
			{
				if(++CNTuartTxd >= TM_DEV_TX)	/* Ĭ�ϼ��5s����Ϊ60s�� */
				{
					CNTuartTxd = 0;
					FdevActTx = SET;
				}
			}
			else
			{
				CNTuartTxd = 0;
			}
		}
		else
		{
			CNTuartTxd = 0;
		}

		/* �����ݣ��������� */
		// if(FdataAtoOff == CLR)
		// {
			
		// }
	}

	if(F1s_Uart == SET)
	{
		F1s_Uart = CLR;
		if(FwifiCfgSts == SET)
		{
			if(++CNTwifiCfgSts >= 1800)	/* ��������ģʽ30���Ӻ�δ�ɹ�������֪ͨWiFi���빤��ģʽ */
			{
				CNTwifiCfgSts = 0;
				FwifiCfgSts = CLR;
				FwifiWork = SET;
			}
		}
		else
		{
			CNTwifiCfgSts = 0;
		}

		/* �յ�05ȷ��֡��5s������ϱ�������Ϣ */
		if(FalarmTx05 == SET)
		{
			if(++CNTdevAlarmTx >= 5)
			{
				CNTdevAlarmTx = 0;
				FalarmTx05 = CLR;
				FalarmTx = SET;
			}
		}
		else
		{
			CNTdevAlarmTx = 0;
		}
	}

	/* ���յ�ģ��ָ���50ms�ڻظ������� */
	if(FdevTx62 == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			FdevTx62 = CLR;
			DeviceVersionTx();	/* 20ms��ظ��豸�汾��Ϣ */
		}
	}
	else if(FdevTx71 == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			FdevTx71 = CLR;
			DeviceTypeTx();		/* 20ms��ظ��豸������Ϣ����Ʒ��Ϣ��TYPEID�� */
		}
	}
	else if(Fwifi_OKtx == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			Fwifi_OKtx = CLR;
			WiFiDeviceReturn();	/* ����ָ����Ϣ״̬���� */
		}
	}
	else if(FinvalidCom == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			FinvalidCom = CLR;
			WiFiInvalidCom(); 	/* ��Ч��Ϣ��ָ� */
		}	
	}
	else if(FdevOK_Tx == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			FdevOK_Tx = CLR;
			WiFiDeviceOKTx(); 	/* �豸����ȷ����Ϣ */
		}
	}
	else if(FdevFreqSet == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			FdevFreqSet = CLR;
			DeviceFreqSetTx();		/* �趨�û����ݷ��ͼ�� */
		}
	}
	else if(FdatFreqSet == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			FdatFreqSet = CLR;
			DataFreqSetTx();	/* WiFi�趨������Ӧ���� */
		}
	}
	// else if(FsubBoardTx == SET)
	// {
	// 	if(++CNTwifiReplyTX >= 3)
	// 	{
	// 		CNTwifiReplyTX = 0;
	// 		FsubBoardTx = CLR;
	// 		WifiSubBoardInfoTx();	/* �Ӱ���Ϣ�ظ� */
	// 	}
	// }
	// else if(FmacTx == SET)
	// {
	// 	if(++CNTwifiReplyTX >= 3)
	// 	{
	// 		CNTwifiReplyTX = 0;
	// 		FmacTx = CLR;
	// 		WifiMachineInfoTx();	/* �Ӱ���Ϣ�ظ� */
	// 	}
	// }
	else if(FalarmCheck == SET)
	{
		WiFiAlarmTx();		/* WiFi��ѯ�����ظ� */
	}
	else if(FwifiWork == SET)
	{
		FwifiWork = CLR;
		WiFiWorkModeTX();	/* 0x74, ֪ͨWiFiģ����빤��ģʽ */
	}
	else if(Freset == SET)
	{
		if(++CNTwifiReplyTX >= 4)
		{
			CNTwifiReplyTX = 0;
			Freset = CLR;
			FcodeAdd_M = SET;
			GbuzOutSet(5);
			// WifiInfoClearTx();	/* WiFi���������Ϣ(��ȷ�ϣ���������) */
		}
		else if(CNTwifiReplyTX == 3)
		{
			TM_DATA_TX = 600;	/* �����ݻ㱨���60s */
			TM_DEV_TX = TM_TX_60S;	/* �豸�����㱨���600s */
			TM_UVC = 120;       /* ����ɱ����ʱʱ�� */
			UVC_CNT_DWON = 0;   /* ����ɱ������ʱ */
			LGT_CNT_DWON = 0; 	/* ��������ʱ */
			TM_DRY = 120;       /* ��ɶ�ʱʱ�� */
			TM_FAN = 120;       /* ��ɶ�ʱʱ�� */
			DRY_CNT_DWON = 0; 	/* ��ɵ���ʱ */
			FAN_CNT_DWON = 0; 	/* ��ɵ���ʱ */
			OKdry = CLR;
			OKfan = CLR;
			OKhang_DWN = CLR;
			OKhang_UP = CLR;
			OKoneLine = CLR;
			OKuvc = CLR;
			Flight = CLR;
			DeviceActiveInfoTX();	/* �豸�����㱨��Ϣ */
		}
		else if(CNTwifiReplyTX == 2)
		{
			DeviceActiveInfoTX();	/* �豸�����㱨��Ϣ */
		}
	}
	else
	{
		CNTwifiReplyTX = 0;
	}

	/* ��200msʱ����δ�յ�ģ���ACK֡���豸�ط��㱨֡������ط�2�Σ����200ms�� */
	if(++CNTwifiTx200ms >= 20)
	{
		CNTwifiTx200ms = 0;
		if(FdevActTx == SET)
		{
			DeviceActiveInfoTX();	/* �豸�����㱨��Ϣ */
			if(++CNTdevTx_Rx >= 2)
			{
				CNTdevTx_Rx = 0;
				FdevActTx = CLR;
			}
		}
		else
		{
			CNTdevTx_Rx = 0;
		}
	}
	else if(CNTwifiTx200ms == 15)
	{
		WiFiAlarmTx();	/* ÿ��200msһ�� */
	}
	else if(CNTwifiTx200ms == 10)
	{
		if(FwifiCfg == SET)
		{
			// FwifiCfg = CLR;
			WiFiConfigModeTx(); 	/* �豸֪ͨģ��������ģʽ */
		}
	}
}

/* ��ȡͨ���WiFi�Ƿ���Ա�ʶ�� */
void WifiFirstFlagRead(void)
{
	unsigned char u8wifi1stFlag = 0;
	u8wifi1stFlag = Memory_Read(0x59);
	if(u8wifi1stFlag == 0x01)
	{
		Fwifi1st = SET;
	}
	else
	{
		Fwifi1st = CLR;
	}
}
/*******************************************************************/
/* ������������ */
/* �������ݴ��ڷ��� */
void VoiceUartTxd(void)
{
	unsigned char voice_i = 0;
	if(++CNTuartTxd >= 10)	/* 200ms��� */
	{
		CNTuartTxd = 0;
		if(Fvoice_Set == SET)
		{
			Fvoice_Set = CLR;
//			voice_Dta3++;
			TX_Buf[0] = 0xc1;
			TX_Buf[1] = 0x04;
			TX_Buf[2] = 0x00;
			TX_Buf[3] = voice_Dta3++;
			TX_Buf[4] = 0x00;
			TX_Buf[5] = Voice_Key;
			TX_Buf[6] = 0x00; /* 0-6����У�� */
			for(voice_i = 0; voice_i < 6; voice_i++)
			{
				TX_Buf[6] += TX_Buf[voice_i];
			}
			tx_index = 7;		/* �����ֽ��� */
			TX1IE = 1;			/* �򿪷����ж� */
			CREN1 = 1;			/* ������� */
		}
	}
}

/* �������ݴ��ڽ����ж� */
void VoiceUartRxd(void)
{
	unsigned char VoiceSum = 0;
	unsigned char Voice_i = 0;
	if(Frr_s == SET)
	{
		Frr_s = CLR;
		for(Voice_i = 0; Voice_i < 6; Voice_i++)
		{
			VoiceSum += BUF_Rr[Voice_i];
		}
		if((BUF_Rr[2] + BUF_Rr[3] + BUF_Rr[4] == 0)
		&& (VoiceSum == BUF_Rr[6]))
		{
			SEQuart_Dta = BUF_Rr[5];
			Fuart_OK = SET;
			switch(SEQuart_Dta)
			{
				case 0x01:						/* ���¼����� */
					Fvoice_Set = SET;
					Voice_Key = 0x01;			/* ���¸������� */
					SETuart_code = KEY_UP;		/* ���� */
					break;
				case 0x02:						/* ���¼��½� */
					Fvoice_Set = SET;
					Voice_Key = 0x02;			/* ���¼����½� */
					SETuart_code = KEY_DOWN;	/* �½� */
					break;
				case 0x03:
					Fvoice_Set = SET;
					Voice_Key = 0x03;
					SETuart_code = KEY_STP;	/* ֹͣ */
					break;
				case 0x04:						/* ���� */
					if(Flight == SET)
					{
						Fuart_OK = CLR;
						Fvoice_Set = SET;
						// Voice_Key = 0x31;		/* 0x31��Ǹ�����β�����Ч */
						Voice_Key = 0x04;			/* �ƹ��Ѵ� */
						break;
					}
					Fvoice_Set = SET;
					Voice_Key = 0x04;			/* �ƹ��Ѵ� */
					SETuart_code = KEY_LIGHT;
					break;
				case 0x05:						/* �ص� */
					if(Flight == CLR)
					{
						Fuart_OK = CLR;
						Fvoice_Set = SET;
						// Voice_Key = 0x31;		/* 0x31��Ǹ�����β�����Ч */
						Voice_Key = 0x05;			/* �ƹ��ѹر� */
						break;
					}
					Fvoice_Set = SET;
					Voice_Key = 0x05;			/* �ƹ��ѹر� */
					SETuart_code = KEY_LIGHT;
					break;
#if VER_2510M
				case 0x06:						/* �򿪺�� */
					if(OKdry == SET)
					{
						Fuart_OK = CLR;
						Fvoice_Set = SET;
						// Voice_Key = 0x31;		/* 0x31��Ǹ�����β�����Ч */
						Voice_Key = 0x06;			/* ����Ѵ� */
						break;
					}
					Fvoice_Set = SET;
					Voice_Key = 0x06;			/* ����Ѵ� */
					SETuart_code = KEY_DRY;
					break;
				case 0x07:						/* �رպ�� */
					if(OKdry == CLR)
					{
						Fuart_OK = CLR;
						Fvoice_Set = SET;
						// Voice_Key = 0x31;		/* 0x31��Ǹ�����β�����Ч */
						Voice_Key = 0x07;			/* ����ѹر� */
						break;
					}
					Fvoice_Set = SET;
					Voice_Key = 0x07;			/* ����ѹر� */
					SETuart_code = KEY_DRY;
					break;
				case 0x08:						/* �򿪷�� */
					if(OKfan == SET)
					{
						Fuart_OK = CLR;
						Fvoice_Set = SET;
						// Voice_Key = 0x31;		/* 0x31��Ǹ�����β�����Ч */
						Voice_Key = 0x08;			/* ����Ѵ� */
						break;
					}
					Fvoice_Set = SET;
					Voice_Key = 0x08;			/* ����Ѵ� */
					SETuart_code = KEY_FAN;
					break;
				case 0x09:						/* �رշ�� */
					if(OKfan == CLR)
					{
						Fuart_OK = CLR;
						Fvoice_Set = SET;
						// Voice_Key = 0x31;		/* 0x31��Ǹ�����β�����Ч */
						Voice_Key = 0x09;			/* ����ѹر� */
						break;
					}
					Fvoice_Set = SET;
					Voice_Key = 0x09;			/* ����ѹر� */
					SETuart_code = KEY_FAN;
					break;
#endif
				default:
					Fuart_OK = CLR;
					Fvoice_Set = CLR;
					Voice_Key = 0;
					break;
			}
		}
	}
}

/* ��ʼ���� */
void GstartVoice(void)
{
	Fvoice_Set = SET;
	Voice_Key = 0x0A;
	FvoiceSta = SET;
	// FuartBpsSw = SET;
}

/* ����ָ�� */
unsigned char UartCom(void)
{
	unsigned char u8wifiCom = 0;
	if(Fuart_OK == SET)
	{
		Fuart_OK = CLR;
		u8wifiCom = SETuart_code;	
	}
	return u8wifiCom;
}

/* ��������һ�ε�ǰ�����Ϣ��Ԥ��ֵ������ֵ */
void MotorAVuartInit(void)
{
	FwrSend = SET;
}


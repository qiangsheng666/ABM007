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
#define	Fuart_OK	FuartBit01.bits.bit_2	/* 串口反馈指令 */
#define FvoiceSta	FuartBit01.bits.bit_3	/* 开机语音指令 */
#define	FvoiceUart	FuartBit01.bits.bit_4	/* 语音通信 */
#define	Fvoice_Set	FuartBit01.bits.bit_5	/* 语音播报指令 */
// #define	Fvoice_Ok	FuartBit01.bits.bit_6	/* 语音指令 */
// #define FuartBpsTx	FuartBit01.bits.bit_6	/* 波特率切换标识 */
// #define FuartBpsSw	FuartBit01.bits.bit_7	/* 波特率切换标识 */

#define	FwifiUart	FuartBit02.bits.bit_0	/* wifi通讯 */
// #define	Fwifi_OK	FuartBit02.bits.bit_1	/* wifi指令 */
#define Fwifi_OKtx	FuartBit02.bits.bit_2	/* wifi收到信息后确认 */
#define FdevTx62	FuartBit02.bits.bit_3	/* 返回设备版本信息 */
#define FdevTx71	FuartBit02.bits.bit_4	/* 模块获取设备类型信息 */
#define	FinvalidCom	FuartBit02.bits.bit_5	/* 无效指令Invalid command */
// #define	FdevActTx	FuartBit02.bits.bit_6	/* 设备主动发送当前状态信息标识符（转为全局调用） */
#define FalarmTx	FuartBit02.bits.bit_6	/* 警告发送标识 */
#define FalarmTx05	FuartBit02.bits.bit_7	/* 暂停5s后继续发送警告 */

#define FdevOK_Tx	FuartBit03.bits.bit_0	/* 设备向WiFi模块发送确认标识符 */
#define FwifiWork	FuartBit03.bits.bit_1	/* wifi配置完成进入工作模式标识 */
// #define FwifiCfg	FuartBit03.bits.bit_1	/* 配置模式标识符 */
#define	FdevFreqSet	FuartBit03.bits.bit_2	/* 设备主动汇报间隔 */
#define	FdatFreqSet	FuartBit03.bits.bit_3	/* 设备大数据汇报间隔 */
#define FalarmCheck	FuartBit03.bits.bit_4	/* 0x73->0x74模块查询所有报警信息 */
#define FwifiCfgSts	FuartBit03.bits.bit_5	/* wifi处于配置状态 */
// #define	FtestUart	FuartBit03.bits.bit_6	/* 测试串口标识 */
#define FdevActOff	FuartBit03.bits.bit_6	/* 设备主动汇报用户信息，0开启，1关闭 */
#define FdataAtoOff	FuartBit03.bits.bit_7	/* 设备大数据汇报间隔，0开启，1关闭 */

#define	FsubBoardTx	FuartBit04.bits.bit_0	/* 查询子板信息，0xE9 -> 0xEA */
#define	FmacTx		FuartBit04.bits.bit_1	/* 查询整机和子板信息，0xEb -> 0xEC */
#define	Freset		FuartBit04.bits.bit_2	/* 复位标识 */
#define FwifiSta	FuartBit04.bits.bit_3	/* 上电后判定网络状态标识 */
#define bufFwifi1st	FuartBit04.bits.bit_4	/* 判定初次配网标识变化 */

uint8_t TX_Buf[49];		/* 必须大于最大发送指令数 */
v_uint8 Uart_MaxRrNo; 	/* 最大接收数据数量 */
v_uint8 u8RxDi;
v_uint8 RxBuf1;
v_uint8 BUF_Rr[15];		/* 必须大于最大接收指令数 */

v_uint8 tx_index;		/* 发送字节数 */
v_uint8 TX_CNT = 0;

v_uint8 SEQuart_Dta;
v_uint8 SETuart_code;
v_uint8 CNTdevTx_Rx;
v_uint8 CNTwifiReplyTX;		/* 收到模块信息汇报计时 */
v_uint8 CNTwifiTx100ms;
v_uint8 CNTwifiTx200ms;
v_uint8 CNTdevAlarmTx;

v_uint8 voice_Dta3 = 5;	/* 语音次数统计 */
v_uint8 Voice_Key;		/* 语音反馈指令（接收指令后播报指令） */

v_uint16 CNTuartTxd;
v_uint16 CNTwifiCfgSts;		/* 配网状态计时，不超过30min */
v_uint16 TM_DATA_TX = 600;	/* 大数据汇报间隔60s */
v_uint16 TM_DEV_TX = 600;	/* 设备主动汇报间隔60s */

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

/* UART通讯 */
void GuartLoop(void)
{
	if(FvoiceSta == SET)
	{
		FvoiceSta = CLR;	/* 开机语音，强制发送，不做识别 */
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

/* 串口发送中断逻辑 */
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

/* 串口接收中断逻辑 */
void Uart_ReceiveLogic(void)
{
	if(u8RxDi == 0)
	{
		if(RX_Buf == 0xC1)
		{
			BUF_Rr[u8RxDi] = RX_Buf;
			u8RxDi = 1;
			FvoiceUart = 1;			/* 语音数据（7，量接收，与WiFi共存） */
			FwifiUart = 0;
			Uart_MaxRrNo = 7;
		}
		else if (RX_Buf == 0xFF)
		{
			BUF_Rr[u8RxDi] = RX_Buf;
			u8RxDi = 1;
			FvoiceUart = 0;
			FwifiUart = 1;			/* wifi数据 */
			Uart_MaxRrNo = 15;
		}
		else if(RX_Buf == 0xCC)
		{
			BUF_Rr[u8RxDi] = RX_Buf;
			u8RxDi = 1;
			FvoiceUart = 0;			/* 调试数据 */
			FwifiUart = 0;
			Uart_MaxRrNo = 6;		/* 6，全量接收，与WiFi共存 */
		}
	}
	else
	{
		BUF_Rr[u8RxDi] = RX_Buf;
		if(++u8RxDi >= Uart_MaxRrNo)
		{
			u8RxDi = 0;
			Frr_s = SET;
//			CREN1 = 0; /* 接收终止 */
		}
	}
}

/*******************************************************************/
/* 测试数据（与上位机通讯） */
/* 测试数据串口发送 */
void TestUartTxd(void)
{
	unsigned char itxd = 0;
	unsigned char u8motorSts = 0;
	if(++CNTuartTxd >= 20)
	{
		CNTuartTxd = 0;
		u8motorSts = GhangerStatus();
		if((u8motorSts != 0)
		|| (FwrSend == SET))	/* 写入预警值后补发一次信息 */
		{
			FwrSend = CLR;
			TX_Buf[0] = 0xAA; /* 头码，1帧 */
			TX_Buf[1] = (unsigned char)AvgMotorAD; /* 数据位1，电流值低位 */
			TX_Buf[2] = (unsigned char)(AvgMotorAD >> 8); /* 数据位2，电流值高位 */
			TX_Buf[3] = u8motorSts; /* 电机运行状态 */
			/************************************/
			// TX_Buf[4] = (unsigned char)CNTstartCal; /* 预警AD低位 */
			// TX_Buf[5] = (unsigned char)(CNTstartCal >> 8 ); /* 预警AD高位 */
			// TX_Buf[6] = (unsigned char)SumMotorAD; /* 预警AD低位 */
			// TX_Buf[7] = (unsigned char)(SumMotorAD >> 8); /* 预警AD高位 */
			/********************************/
			TX_Buf[4] = (unsigned char)DTmotorNGminSet; /* 预警AD低位 */
			TX_Buf[5] = (unsigned char)(DTmotorNGminSet >> 8 ); /* 预警AD高位 */
			TX_Buf[6] = (unsigned char)DTmotorNGmaxSet; /* 预警AD低位 */
			TX_Buf[7] = (unsigned char)(DTmotorNGmaxSet >> 8); /* 预警AD高位 */
			/**********************************************/
			TX_Buf[8] = (unsigned char)AVmotor_ad; /* 数据位1，电流值低位 */
			TX_Buf[9] = (unsigned char)(AVmotor_ad >> 8); /* 数据位2，电流值高位 */
			TX_Buf[10] = 0;
			for(itxd = 1; itxd < 10; itxd++)
			{
				TX_Buf[10] += TX_Buf[itxd];		/* 累加 */
			}
			tx_index = 11;		/* 发送字节数 */
			TX1IE = 1;			/* 打开发送中断 */
			CREN1 = 1;			/* 允许接收 */
		}
	}
}

/* 测试数据串口接收数据判断 */
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
			if(BUF_Rr[1] == 0x01)	/* 0x01预警电流标识 */
			{
				DTmotorNGminSet = BUF_Rr[2];
				DTmotorNGminSet = (DTmotorNGminSet << 8) + BUF_Rr[3];
				/* 预警值写入存储 */
				Flash_Write(0x70, BUF_Rr[2]);		/* 高8位 */
				Flash_Write(0x71, BUF_Rr[3]);		/* 低8位 */
				// DTmotorNGmax = (DTmotorNGmin + 4 * ADper01A);	/* 预估最大值,预警值+0.4A */
				// Flash_Write(0x72, (DTmotorNGmax >> 8));		/* 高8位 */
				// Flash_Write(0x73, DTmotorNGmax);			/* 低8位 */
				FwrSend = SET;		/* 返回一次信息，显示当前状态值 */
			}
			else if(BUF_Rr[1] == 0x02)		/* 锁死电流标识符 */
			{
				DTmotorNGmaxSet = BUF_Rr[2];		/* 高8位 */
				DTmotorNGmaxSet = (DTmotorNGmaxSet << 8) + BUF_Rr[3];	/* 低8位 */
				/* 断开值写入存储 */
				// Flash_Write(0x72, (DTmotorNGmax >> 8));		/* 高8位 */
				// Flash_Write(0x73, DTmotorNGmax);			/* 低8位 */
				Flash_Write(0x72, BUF_Rr[2]);		/* 高8位 */
				Flash_Write(0x73, BUF_Rr[3]);		/* 低8位 */
				/*推算预警值*/
				DTmotorNGminSet = DTmotorNGmaxSet - ADper01A - ADper02A;	/* 锁死值-0.3A */
				Flash_Write(0x70, (unsigned char)(DTmotorNGminSet >> 8));		/* 高8位 */
				Flash_Write(0x71, (unsigned char)DTmotorNGminSet);		/* 低8位 */
				FwrSend = SET;		/* 返回一次信息，显示当前状态值 */
			}
			// else if(BUF_Rr[1] == 0x03)		/* 热态锁死电流标识符 */
			// {
			// 	DTmotorNGmaxHot = BUF_Rr[2];		/* 高8位 */
			// 	DTmotorNGmaxHot = (DTmotorNGmaxHot << 8) + BUF_Rr[3];	/* 低8位 */
			// 	/* 断开值写入存储 */
			// 	// Flash_Write(0x72, (DTmotorNGmax >> 8));		/* 高8位 */
			// 	// Flash_Write(0x73, DTmotorNGmax);			/* 低8位 */
			// 	Flash_Write(0x74, BUF_Rr[2]);		/* 高8位 */
			// 	Flash_Write(0x75, BUF_Rr[3]);		/* 低8位 */
			// 	FwrSend = SET;		/* 返回一次信息，显示当前状态值 */
			// }
			else if(BUF_Rr[1] == 0x04)		/* 热态锁死电流标识符 */
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
/* 海尔智家WiFi */
/* WIFI模块接收信息处理 */
void WifiUartRxd(void)
{
	if(Frr_s == SET)
	{
		Frr_s = CLR;
		if(BUF_Rr[9] == 0x61)
		{
			FdevTx62 = SET;	/* 返回设备版本信息 */
		}
		else if(BUF_Rr[9] == 0xE8)
		{
			// SPBRG = 25; /* 19200bps, 8M/(16*26) */
			// FwifiUart = SET;
		}
		else if(BUF_Rr[9] == 0x70)
		{
			FdevTx71 = SET;	/* 模块获取设备类型信息 */
		}
		else if(BUF_Rr[9] == 0x05)	/* 模块确认标识 */
		{
			FdevActTx = CLR;
			if(FalarmTx == SET)
			{
				FalarmTx = CLR;
				FalarmTx05 == SET;	/* 暂停5s */
			}
		}
		else if(BUF_Rr[9] == 0x73)
		{
			FalarmCheck = SET;
		}
		else if(BUF_Rr[9] == 0x09)
		{
			FalarmTx = CLR;
			FalarmTx05 = CLR;	/* 清除报警 */
			FdevOK_Tx = SET;	/* 设备发送确认信息标识 */
		}
		else if(BUF_Rr[9] == 0xF3)	/* 设备配对请求后WiFi答复 */ 
		{
			// if(BUF_Rr[11] == 0x03)
			// {
				FwifiCfg = CLR;	/* 配对模式 */
			// }
		}
		else if((BUF_Rr[9] == 0xF7) || (BUF_Rr[9] == 0xF1))	/* F7WiFi模块主动发，F1设备查询后发 */
		{
			if(BUF_Rr[11] == 0x00)
			{
				if(FwifiCfgSts == SET)
				{
					FwifiWork = SET;	/* 00通讯正常，01无法连接ap，02无法连接服务器，03设备处于配置模式 */
					FwifiCfgSts = CLR;
					Fwifi1st = SET;		/* 配对成功 */
				}
				FdevOK_Tx = SET;	/* 模块WiFi主动汇报确认帧 */
			}
			else if(BUF_Rr[11] == 0x03)
			{
				FwifiCfg = CLR;	/* 配对模式 */
				FwifiCfgSts = SET;
			}
		}
		// else if(BUF_Rr[9] == 0xE9)
		// {
		// 	FsubBoardTx = SET;	/* 查询子板信息 */
		// }
		// else if(BUF_Rr[9] == 0xEB)
		// {
		// 	FmacTx = SET;	/* 查询整机信息 */
		// }
		else if(BUF_Rr[9] == 0x7C)
		{
			FdevFreqSet = SET;	/* 设备主动汇报间隔 */
			TM_DEV_TX = (BUF_Rr[10] << 8);
			TM_DEV_TX += BUF_Rr[11];
			if(TM_DEV_TX == 0)
			{
				FdevActOff = 1;		/* 当配置信息等于0时，表示关闭汇报功能 */
			}
			else if(TM_DEV_TX == 0xFFFF)
			{
				TM_DEV_TX = TM_TX_60S;	/* 当配置信息为 0xFFFF 时，表示初始化时间间隔，按设备默认的时间间隔判断。 */
				FdevActOff = 0;	/* 设备的默认的汇报判断时间间隔为60秒。 */
			}
			else
			{
				FdevActOff = 0;
			}
		}
		else if(BUF_Rr[9] == 0xFA)
		{
			FdatFreqSet = SET;	/* 设备大数据汇报间隔 */
			TM_DATA_TX = (BUF_Rr[10] << 8);
			TM_DATA_TX += BUF_Rr[11];
			if(TM_DATA_TX == 0)
			{
				FdataAtoOff = SET;		/* 当配置信息等于0时，表示关闭汇报功能 */
			}
			else if(TM_DATA_TX == 0xFFFF)
			{
				TM_DATA_TX = 600;	/* 当配置信息为 0xFFFF 时，表示初始化时间间隔，按设备默认的时间间隔判断。 */
				FdataAtoOff = CLR;	/* 设备的默认的汇报判断时间间隔为60秒。 */
			}
			else
			{
				FdataAtoOff = CLR;
			}
		}
		else if(BUF_Rr[9] == 0x01)
		{
			if((BUF_Rr[10] == 0x4D)
			&& (BUF_Rr[11] == 0x01))	/* 查询属性状态(getAllProperty) */
			{
				Fwifi_OKtx = SET;	/* 返回设备状态信息 */
			}
			else if(BUF_Rr[10] == 0x5D)	/* 控制指令 */
			{
				if((BUF_Rr[11] == 0x09) && (BUF_Rr[12] == 0x00) && (BUF_Rr[13] == 0x00))
				{
					// FinvalidCom = SET;	/* 无效指令 */
					Freset = SET;		/* 复位标识 */
					Fwifi_OKtx = SET;	/* 返回设备状态信息 */
					/* 复位, 暂无此功能 */
				}
				else if((BUF_Rr[11] == 0x01) && (BUF_Rr[12] == 0x00))	/* 运动状态(moveStatus) */
				{
					if(BUF_Rr[13] == 0x00)	/* 停止 */
					{
						Fwifi_OKtx = SET;	/* 返回设备状态信息 */
						Fuart_OK = SET;
						SETuart_code = KEY_STP;
					}
					else if(BUF_Rr[13] == 0x01)	/* 上升 */
					{
						Fwifi_OKtx = SET;	/* 返回设备状态信息 */
						Fuart_OK = SET;
						SETuart_code = KEY_UP;
					}
					else if(BUF_Rr[13] == 0x02)	/* 下降 */
					{
						Fwifi_OKtx = SET;	/* 返回设备状态信息 */
						Fuart_OK = SET;
						SETuart_code = KEY_DOWN;
					}
					else
					{
						FinvalidCom = SET;	/* 无效指令 */
						Fwifi_OKtx = SET;	/* 返回设备状态信息 */
					}
				}
				else if((BUF_Rr[11] == 0x02) &&	(BUF_Rr[12] == 0x00))	/* 照明功能状态(lightStatus) */
				{
					if(BUF_Rr[13] == 0x00)
					{
						if(Flight == SET)
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
							Fuart_OK = SET;
							SETuart_code = KEY_LIGHT;	/* 关灯 */
						}
						else
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
						}
					}
					else if(BUF_Rr[13] == 0x01)
					{
						if (Flight == CLR)
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
							Fuart_OK = SET;
							SETuart_code = KEY_LIGHT;	/* 开灯 */
						}
						else
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
						}
					}
					else
					{
						FinvalidCom = SET;	/* 无效指令 */
						Fwifi_OKtx = SET;	/* 返回设备状态信息 */
					}
				}
				else if((BUF_Rr[11] == 0x0D) && (BUF_Rr[12] == 0x00))	/* 照明定时到计时(lightCountdown)  */
				{
					Fwifi_OKtx = SET;	/* 返回设备状态信息 */
					LGT_CNT_DWON = BUF_Rr[13];	/* 低位<最大180min>  */
				}
	#if VER_2510M
				else if((BUF_Rr[11] == 0x03) && (BUF_Rr[12] == 0x00))	/* 风干功能状态(airDryStatus)  */
				{
					if(BUF_Rr[13] == 0x00)	/* 关闭风干 */
					{
						if(OKfan == SET)
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
							Fuart_OK = SET;
							SETuart_code = KEY_FAN;
						}
						else
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
						}
					}
					else if(BUF_Rr[13] == 0x01)	/* 打开风干 */
					{
						if(OKfan == CLR)
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
							Fuart_OK = SET;
							SETuart_code = KEY_FAN;
						}
						else
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
						}
					}
					else
					{
						FinvalidCom = SET;	/* 无效指令 */
						Fwifi_OKtx = SET;	/* 返回设备状态信息 */
					}
				}
				else if((BUF_Rr[11] == 0x04) && (BUF_Rr[12] == 0x00))	/* 风干定时到计时(airDryCountdown)  */
				{
					Fwifi_OKtx = SET;	/* 返回设备状态信息 */
					FAN_CNT_DWON = BUF_Rr[13];	/* 低位<最大240min>  */
				}
				else if((BUF_Rr[11] == 0x05) && (BUF_Rr[12] == 0x00))	/* 烘干功能状态(dryStatus) */
				{
					if(BUF_Rr[13] == 0x00)	/* 关闭烘干 */
					{
						if(OKdry == SET)
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
							Fuart_OK = SET;
							SETuart_code = KEY_DRY;
						}
						else
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
						}
					}
					else if(BUF_Rr[13] == 0x01)	/* 打开烘干 */
					{
						if(OKdry == CLR)
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
							Fuart_OK = SET;
							SETuart_code = KEY_DRY;
						}
						else
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
						}
					}
					else
					{
						FinvalidCom = SET;	/* 无效指令 */
						Fwifi_OKtx = SET;	/* 返回设备状态信息 */
					}
				}
				else if((BUF_Rr[11] == 0x06) && (BUF_Rr[12] == 0x00))/* 烘干定时到计时(dryCountdown)  */
				{
					Fwifi_OKtx = SET;	/* 返回设备状态信息 */
					DRY_CNT_DWON = BUF_Rr[13];	/* 低位<最大240min> */
				}
				else if((BUF_Rr[11] == 0x0B) && (BUF_Rr[12] == 0x00))	/* 烘干定时时间(dryTimingTime)  */
				{
					Fwifi_OKtx = SET;	/* 返回设备状态信息 */
					TM_DRY = BUF_Rr[13];	/* <最大240min>  */
				}
				else if((BUF_Rr[11] == 0x0C) && (BUF_Rr[12] == 0x00))	/* 风干定时时间(airDryTimingTime)  */
				{
					Fwifi_OKtx = SET;	/* 返回设备状态信息 */
					TM_FAN = BUF_Rr[13];	/* <最大240min>  */
				}
				else if((BUF_Rr[11] == 0x0E) && (BUF_Rr[12] == 0x00))	/* 负离子定时到计时(anionCountdown) */
				{
					// FinvalidCom = SET;	/* 无效指令，负离子与风扇同时开关 */
					Fwifi_OKtx = SET;	/* 返回设备状态信息 */
				}
				else
				{
					FinvalidCom = SET;	/* 无效指令 */
					Fwifi_OKtx = SET;	/* 返回设备状态信息 */
				}
	#elif VER_2510U
				else if((BUF_Rr[11] == 0x07) && (BUF_Rr[12] == 0x00))	/* 消毒功能状态(disinfectStatus)  */
				{
					if(BUF_Rr[13] == 0x00)	/* 关闭紫外杀菌*/
					{
						if (OKuvc == SET)
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
							Fuart_OK = SET;
							SETuart_code = KEY_UVC;
						}
						else
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
						}
					}
					else if(BUF_Rr[13] == 0x01)	/* 打开紫外杀菌 */
					{
						if(OKuvc == CLR)
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
							Fuart_OK = SET;
							SETuart_code = KEY_UVC;
						}
						else
						{
							Fwifi_OKtx = SET;	/* 返回设备状态信息 */
						}
					}
					else
					{
						FinvalidCom = SET;	/* 无效指令 */
						Fwifi_OKtx = SET;	/* 返回设备状态信息 */
					}
				}
				else if((BUF_Rr[11] == 0x08) && (BUF_Rr[12] == 0x00))	/* 消毒定时到计时(disinfectCountdown) */
				{
					Fwifi_OKtx = SET;	/* 返回设备状态信息 */
					UVC_CNT_DWON = BUF_Rr[13];	/* 低位<最大240min> */
				}
				else if((BUF_Rr[11] == 0x0A)	&& (BUF_Rr[12] == 0x00))/* 消毒定时时间(disinfectTimingTime) */
				{
					Fwifi_OKtx = SET;	/* 返回设备状态信息 */
					TM_UVC = BUF_Rr[13];	/* <最大240min>  */
				}
	#endif
			}
			else
			{
				FinvalidCom = SET;	/* 无效指令 */
				Fwifi_OKtx = SET;	/* 返回设备状态信息 */
			}
		}
	}
}

/* 返回设备版本信息, 帧类型0x62（WiFi帧类型0x61） */
void DeviceVersionTx(void)
{
	unsigned char DevTx_i = 0;
	TX_Buf[0] = 0xFF; 	/* 帧头1 */
	TX_Buf[1] = 0xFF; 	/* 帧头2 */
	TX_Buf[2] = 0x2C; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	TX_Buf[4] = 0x00; 	/* 预留位1 */
	TX_Buf[5] = 0x00; 	/* 预留位2 */
	TX_Buf[6] = 0x00; 	/* 预留位3 */
	TX_Buf[7] = 0x00; 	/* 预留位4 */
	TX_Buf[8] = 0x00; 	/* 预留位5 */
	TX_Buf[9] = 0x62; 	/* 帧类型 */
	/* 数据信息 10 - 47 byte, 38 bytes */
	/* 设备协议版本 10-17, 8bytes, E++2.17的ASCII码 */
	TX_Buf[10] = 0x45;	/* ASCII码, E */
	TX_Buf[11] = 0x2B;	/* ASCII码, + */
	TX_Buf[12] = 0x2B;	/* ASCII码, + */
	TX_Buf[13] = 0x32;	/* ASCII码, 2 */
	TX_Buf[14] = 0x2E;	/* ASCII码, . */
	TX_Buf[15] = 0x31;	/* ASCII码, 1 */
	TX_Buf[16] = 0x37;	/* ASCII码, 7 */
	TX_Buf[17] = 0x00;	/* ASCII码, NUL */
	/* 设备软件版本（8B）18 - 25, ASCII码:SLM3415A */
	TX_Buf[18] = 0x53;	/* ASCII码, S */
	TX_Buf[19] = 0x4C;	/* ASCII码, L */
	TX_Buf[20] = 0x4D;	/* ASCII码, M */
	TX_Buf[21] = 0x33;	/* ASCII码, 3 */
	TX_Buf[22] = 0x34;	/* ASCII码, 4 */
	TX_Buf[23] = 0x31;	/* ASCII码, 1 */
	TX_Buf[24] = 0x35;	/* ASCII码, 5 */
#if VER_2510L
	TX_Buf[25] = 0x41;	/* ASCII码, A */
#elif VER_2510M
	TX_Buf[25] = 0x42;	/* ASCII码, B */
#else
	TX_Buf[25] = 0x43;	/* ASCII码, C */
#endif
	/* 加密标志（3B）26-28,家电不支持加密 */
	TX_Buf[26] = 0xF1;	/* 0xF1 */
	TX_Buf[27] = 0x00;
	TX_Buf[28] = 0x00;
	/* 设备硬件版本（8B), 29-36, ASCII码:SLM3415(待定) */
	TX_Buf[29] = 0x53;	/* ASCII码, S */
	TX_Buf[30] = 0x4C;	/* ASCII码, L */
	TX_Buf[31] = 0x4D;	/* ASCII码, M */
	TX_Buf[32] = 0x33;	/* ASCII码, 3 */
	TX_Buf[33] = 0x34;	/* ASCII码, 4 */
	TX_Buf[34] = 0x31;	/* ASCII码, 1 */
	TX_Buf[35] = 0x35;	/* ASCII码, 5 */
	TX_Buf[36] = 0x00;	/* ASCII码, NUL */
	/* 预留1byte */
	TX_Buf[37] = 0x00;
	/* SoftAp配置模式时设备的名称（8B）, 38-45, ASCII码:U-RACK */
	TX_Buf[38] = 0x55;
	TX_Buf[39] = 0x2D;
	TX_Buf[40] = 0x52;
	TX_Buf[41] = 0x41;
	TX_Buf[42] = 0x43;
	TX_Buf[43] = 0x4B;
	TX_Buf[44] = 0x00;
	TX_Buf[45] = 0x00;
	// /* 设备功能信息（2B）, 46-47, HEX */
	// TX_Buf[46] = 0x00;
	// TX_Buf[47] = 0x00;	/* 第5位,0不支持设备角色,1表示支持设备角色;第3位, 0表示不支持底板信息查询,1表示支持底板信息查询; 第2位,0表示不支持CRC校验和,1表示支持CRC校验和 */
	TX_Buf[46] = 0X00;	/* 累加校验和 */
	for(DevTx_i = 2; DevTx_i < 46; DevTx_i++)
	{
		TX_Buf[46] += TX_Buf[DevTx_i];
	}
	tx_index = 47;		/* 发送字节数 */
	TX1IE = 1;			/* 打开发送中断 */
	CREN1 = 1;			/* 允许接收 */
	// Uart_MaxRrNo = 15; 	/* 接收字节数(最大15) */
}

/* 设备类型信息, 帧类型71（模块70） */
void DeviceTypeTx(void)
{
	unsigned char DevTx_i = 0;
	TX_Buf[0] = 0xFF; 	/* 帧头1 */
	TX_Buf[1] = 0xFF; 	/* 帧头2 */
	TX_Buf[2] = 0x28; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	TX_Buf[4] = 0x00; 	/* 预留位1 */
	TX_Buf[5] = 0x00; 	/* 预留位2 */
	TX_Buf[6] = 0x00; 	/* 预留位3 */
	TX_Buf[7] = 0x00; 	/* 预留位4 */
	TX_Buf[8] = 0x00; 	/* 预留位5 */
	TX_Buf[9] = 0x71; 	/* 帧类型 */
	/* 数据信息(TYPEID, 32B), 10 - 41, 产品信息表，海极网注册 */
	/* 海尔提供信息 */
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

	/* SLM提供(无法获取产品信息) */
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

	/* 第一次注册 */
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

// #if (VER_2510M || VER_2510L)	/* 全功能款 */
// 	/* 第二次注册（需添加设备型号SLM01） */
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

// #elif VER_2510U	/* 紫外杀菌款 */
// 	/* 第三次型号测试SLM02A（紫外杀菌款） */
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
	tx_index = 43;		/* 发送字节数 */
	TX1IE = 1;			/* 打开发送中断 */
	CREN1 = 1;			/* 允许接收 */
	// Uart_MaxRrNo = 15; 	/* 接收字节数(最大15) */
}

/* 控制指令状态信息返回，Fwifi_OKtx 0x02，详见附录设备状态表 */
void WiFiDeviceReturn(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* 帧头1 */
	TX_Buf[1] = 0xFF; 	/* 帧头2 */
	TX_Buf[2] = 0x18; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	TX_Buf[4] = 0x00; 	/* 预留位1 */
	TX_Buf[5] = 0x00; 	/* 预留位2 */
	TX_Buf[6] = 0x00; 	/* 预留位3 */
	TX_Buf[7] = 0x00; 	/* 预留位4 */
	TX_Buf[8] = 0x00; 	/* 预留位5 */
	TX_Buf[9] = 0x02; 	/* 帧类型 */
	TX_Buf[10] = 0x6D;	/* 控制信息 */
	TX_Buf[11] = 0x01;  /* 控制信息 */

	/* 设备状态，14bytes， 12-25byte */
	/* 运动状态(moveStatus) Byte1:Bit2~ Byte1:Bit0 */
	if(OKhang_UP == SET)
	{
		TX_Buf[12] = 0x01; /* 01上升 */
	}
	else if(OKhang_DWN == SET)
	{
		TX_Buf[12] = 0x02; /* 02下降 */
	}
	else
	{
		TX_Buf[12] = 0x00; /* 00停止 */
	}
	/* 停留位置(position) Byte2:Bit2~Byte2:Bit0 */
	if(PIhang_H == SET)
	{
		TX_Buf[13] = 0x00;	/* 00最上面 */
	}
	else if(PIhang_L == SET)
	{
		TX_Buf[13] = 0x02;	/* 02最下面 */
	}
	else
	{
		TX_Buf[13] = 0x01;	/* 01中间 */
	}
	/* 照明功能状态(lightStatus) Byte3:Bit0 */
	if(Flight == SET)
	{
		TX_Buf[14] = 0x01;	/* 1照明开 */
	}
	else
	{
		TX_Buf[14] = 0x00;	/* 照明关 */
	}
	/* 风干功能状态(airDryStatus) Byte4:Bit0 */
	if(OKfan == SET)
	{
		TX_Buf[15] = 0x01; /* 1风干开 */
	}
	else
	{
		TX_Buf[15] = 0x00; /* 0风干关 */
	}
	TX_Buf[16] = FAN_CNT_DWON;	/* 风干定时到计时(airDryCountdown) Byte5 */
	/* 烘干功能状态(dryStatus) Byte6:Bit1  */
	if(OKdry == SET)
	{
		TX_Buf[17] = 0x01; /* 1烘干开 */
	}
	else
	{
		TX_Buf[17] = 0x00; /* 0烘干关 */
	}
	TX_Buf[18] = DRY_CNT_DWON;	/* 烘干定时到计时(dryCountdown)	Byte7 */
	/* 消毒功能状态(disinfectStatus，Byte8:Bit0 */
	if(OKuvc == SET)
	{
		TX_Buf[19] = 0x01;	/* 消毒开 */
	}
	else
	{
		TX_Buf[19] = 0x00;	/* 消毒关 */
	}
	TX_Buf[20] = UVC_CNT_DWON;	/* 消毒定时到计时(disinfectCountdown)  byte9 */
	TX_Buf[21] = TM_UVC;		/* 消毒定时时间(disinfectTimingTime)，Byte10, 暂无此功能 */
	TX_Buf[22] = TM_DRY;		/* 烘干定时时间(dryTimingTime) Byte11 */
	TX_Buf[23] = TM_FAN;		/* 风干定时时间(airDryTimingTime), Byte12 */
	TX_Buf[24] = LGT_CNT_DWON;	/* 照明定时到计时(lightCountdown), Byte13 */
	TX_Buf[25] = FAN_CNT_DWON;	/* 负离子定时到计时(anionCountdown), Byte14, 暂无此功能 */

	TX_Buf[26] = 0x00;			/* 和校验 */
	for(TX_i = 2; TX_i < 26; TX_i++)
	{
		TX_Buf[26] += TX_Buf[TX_i];
	}
	tx_index = 27;		/* 发送字节数 */
	TX1IE = 1;			/* 打开发送中断 */
	CREN1 = 1;			/* 允许接收 */
// #if 0
// 	TX_Buf[12] = 0x00;	/* 数值归零 */
// 	/* 运动状态(moveStatus) Byte1:Bit7~ Byte1:Bit6 */
// 	if(OKhang_UP == SET)
// 	{
// 		TX_Buf[12] = 0x40; /* 01上升 */
// 	}
// 	else if(OKhang_DWN == SET)
// 	{
// 		TX_Buf[12] = 0x80; /* 02下降 */
// 	}
// 	else
// 	{
// 		TX_Buf[12] = 0x00; /* 00停止 */
// 	}
// 	/* 停留位置(position) Byte1:Bit5~Byte1:Bit4 */
// 	if(PIhang_H == SET)
// 	{
// 		TX_Buf[12] |= 0x00;	/* 00最上面 */
// 	}
// 	else if(PIhang_L == SET)
// 	{
// 		TX_Buf[12] |= 0x20;	/* 02最下面 */
// 	}
// 	else
// 	{
// 		TX_Buf[12] |= 0x10;	/* 01中间 */
// 	}
// 	/* 照明功能状态(lightStatus) Byte1:Bit3 */
// 	if(Flight == SET)
// 	{
// 		TX_Buf[12] |= 0x08;	/* 1照明开 */
// 	}
// 	// else
// 	// {
// 	// 	TX_Buf[12] &= ~0x08;	/* 照明关 */
// 	// }
// 	/* 风干功能状态(airDryStatus) Byte1:Bit2 */
// 	if(OKfan == SET)
// 	{
// 		TX_Buf[12] |= 0x04; /* 1风干开 */
// 	}
// 	/* 烘干功能状态(dryStatus) Byte1:Bit1  */
// 	if(OKdry == SET)
// 	{
// 		TX_Buf[12] |= 0x02; /* 1烘干开 */
// 	}
// 	/* 消毒功能状态(disinfectStatus，Byte1:Bit0 */
// 	/* 无此功能 */

// 	TX_Buf[13] = DRY_CNT_DWON;	/* 烘干定时到计时(dryCountdown)	Byte2 */
// 	TX_Buf[14] = FAN_CNT_DWON;	/* 风干定时到计时(airDryCountdown) Byte3 */
// 	TX_Buf[15] = UVC_CNT_DWON;			/* 消毒定时到计时(disinfectCountdown) Byte4, 暂无此功能 */
// 	TX_Buf[16] = TM_UVC;			/* 消毒定时时间(disinfectTimingTime)，Byte5, 暂无此功能 */
// 	TX_Buf[17] = TM_DRY;		/* 烘干定时时间(dryTimingTime) Byte6 */
// 	TX_Buf[18] = TM_FAN;		/* 风干定时时间(airDryTimingTime), Byte7 */
// 	TX_Buf[19] = LGT_CNT_DWON;	/* 照明定时到计时(lightCountdown), Byte8 */
// 	TX_Buf[20] = 0x00;			/* 负离子定时到计时(anionCountdown), Byte9, 暂无此功能 */
// 	TX_Buf[21] = 0x00;			/* 预留 */
// 	TX_Buf[22] = 0x00;			/* 和校验 */
// 	for(TX_i = 2; TX_i < 22; TX_i++)
// 	{
// 		TX_Buf[22] += TX_Buf[TX_i];
// 	}
// 	tx_index = 23;		/* 发送字节数 */
// 	TX1IE = 1;			/* 打开发送中断 */
// 	CREN1 = 1;			/* 允许接收 */
// 	// Uart_MaxRrNo = 15; 	/* 接收字节数(最大15) */
// #endif
}

/* 无效命令 0x03 */
void WiFiInvalidCom(void)
{
	TX_Buf[0] = 0xFF; 	/* 帧头1 */
	TX_Buf[1] = 0xFF; 	/* 帧头2 */
	TX_Buf[2] = 0x08; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	TX_Buf[4] = 0x00; 	/* 预留位1 */
	TX_Buf[5] = 0x00; 	/* 预留位2 */
	TX_Buf[6] = 0x00; 	/* 预留位3 */
	TX_Buf[7] = 0x00; 	/* 预留位4 */
	TX_Buf[8] = 0x00; 	/* 预留位5 */
	TX_Buf[9] = 0x03; 	/* 帧类型 */
	TX_Buf[10] = 0x0B;	/* 和校验 */
	tx_index = 11;		/* 发送字节数 */
	TX1IE = 1;			/* 打开发送中断 */
	CREN1 = 1;			/* 允许接收 */
	// Uart_MaxRrNo = 15; 	/* 接收字节数(最大15) */
}

/* 设备主动发送报警信息, 0x04/0x74 */
void WiFiAlarmTx(void)
{
	unsigned char Tx_i = 0;
	unsigned char u8alarmData = 0;
	static unsigned char u8bufAlarmData = 0;
	/* 0x01, 电源故障 */
	if(FmotorNG_Bz == SET)	/* 超重 */
	{
		u8alarmData |= 0x02;
	}
	if(FmotorHot == SET)	/* 热态 */
	{
		u8alarmData |= 0x04;
	}
	if(PIhang_S == SET)	/* 遇阻 */
	{
		u8alarmData |= 0x08;
	}
	else if(FpowerLow == SET)	/* 电机运转时电流值太低 */
	{
		FpowerLow = CLR;	/* 仅报警用 */
		u8alarmData |= 0x01;
	}

	if(u8alarmData != u8bufAlarmData)
	{
		u8bufAlarmData = u8alarmData;
		FalarmTx = SET;		/* 报警指令变化，重置报警 */
	}
	
	if((FalarmTx == SET)		/* 主动上报 */
	|| (FalarmCheck == SET))	/* WiFi模块查询 */
	{
		TX_Buf[0] = 0xFF; 	/* 帧头1 */
		TX_Buf[1] = 0xFF; 	/* 帧头2 */
		TX_Buf[2] = 0x0C; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
		TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
		TX_Buf[4] = 0x00; 	/* 预留位1 */
		TX_Buf[5] = 0x00; 	/* 预留位2 */
		TX_Buf[6] = 0x00; 	/* 预留位3 */
		TX_Buf[7] = 0x00; 	/* 预留位4 */
		TX_Buf[8] = 0x00; 	/* 预留位5 */
		if(FalarmCheck == SET)
		{
			TX_Buf[9] = 0x74; 	/* 帧类型 */
			FalarmCheck = CLR;
		}
		else
		{
			TX_Buf[9] = 0x04; 	/* 帧类型 */
		}
		TX_Buf[10] = 0x0F;	/* 控制信息 */
		TX_Buf[11] = 0x5A;  /* 控制信息 */
		TX_Buf[12] = 0x00;	/* 报警信息 */
		TX_Buf[13] = u8alarmData;	/* 报警信息 */
		TX_Buf[14] = 0x00;	/* 和校验 */
		for(Tx_i = 2; Tx_i < 14; Tx_i++)
		{
			TX_Buf[14] += TX_Buf[Tx_i];
		}
		tx_index = 15;		/* 发送字节数 */
		TX1IE = 1;			/* 打开发送中断 */
		CREN1 = 1;			/* 允许接收 */
		// Uart_MaxRrNo = 15; 	/* 接收字节数(最大15) */
	}
	/* 7．如果所有的报警消失，也要按照规则发送全0的报警命令，直到收到09。 */
//	if(u8bufAlarmData == 0)
//	{
//		FalarmTx = CLR;
//	}
}

/* 设备向WiFi模块发送确认信息 */
/* 模块停止设备报警信息 0x09->0x05(确认信息) */
void WiFiDeviceOKTx(void)
{
	TX_Buf[0] = 0xFF; 	/* 帧头1 */
	TX_Buf[1] = 0xFF; 	/* 帧头2 */
	TX_Buf[2] = 0x08; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	TX_Buf[4] = 0x00; 	/* 预留位1 */
	TX_Buf[5] = 0x00; 	/* 预留位2 */
	TX_Buf[6] = 0x00; 	/* 预留位3 */
	TX_Buf[7] = 0x00; 	/* 预留位4 */
	TX_Buf[8] = 0x00; 	/* 预留位5 */
	TX_Buf[9] = 0x05; 	/* 帧类型 */
	TX_Buf[10] = 0x0D;	/* 和校验 */
	tx_index = 11;		/* 发送字节数 */
	TX1IE = 1;			/* 打开发送中断 */
	CREN1 = 1;			/* 允许接收 */
	// Uart_MaxRrNo = 15; 	/* 接收字节数(最大15) */
}

/* 设备按照预定的时间间隔判断状态帧中的参数状态，任何参数状态发生变化时，	*/
/* 设备向上发送汇报帧。没有参数状态发生变化，下一次时间间隔再次判断。		*/
/* 设备主动发送当前状态信息，每隔60s发一次，0x06 */
void DeviceActiveInfoTX(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* 帧头1 */
	TX_Buf[1] = 0xFF; 	/* 帧头2 */
	TX_Buf[2] = 0x18; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	TX_Buf[4] = 0x00; 	/* 预留位1 */
	TX_Buf[5] = 0x00; 	/* 预留位2 */
	TX_Buf[6] = 0x00; 	/* 预留位3 */
	TX_Buf[7] = 0x00; 	/* 预留位4 */
	TX_Buf[8] = 0x00; 	/* 预留位5 */
	TX_Buf[9] = 0x06; 	/* 帧类型 */
	TX_Buf[10] = 0x6D;	/* 控制信息 */
	TX_Buf[11] = 0x01;  /* 控制信息 */

	/* 设备状态，14bytes， 12-25byte */
	/* 运动状态(moveStatus) Byte1:Bit2~ Byte1:Bit0 */
	if(OKhang_UP == SET)
	{
		TX_Buf[12] = 0x01; /* 01上升 */
	}
	else if(OKhang_DWN == SET)
	{
		TX_Buf[12] = 0x02; /* 02下降 */
	}
	else
	{
		TX_Buf[12] = 0x00; /* 00停止 */
	}
	/* 停留位置(position) Byte2:Bit2~Byte2:Bit0 */
	if(PIhang_H == SET)
	{
		TX_Buf[13] = 0x00;	/* 00最上面 */
	}
	else if(PIhang_L == SET)
	{
		TX_Buf[13] = 0x02;	/* 02最下面 */
	}
	else
	{
		TX_Buf[13] = 0x01;	/* 01中间 */
	}
	/* 照明功能状态(lightStatus) Byte3:Bit0 */
	if(Flight == SET)
	{
		TX_Buf[14] = 0x01;	/* 1照明开 */
	}
	else
	{
		TX_Buf[14] = 0x00;	/* 照明关 */
	}
	/* 风干功能状态(airDryStatus) Byte4:Bit0 */
	if(OKfan == SET)
	{
		TX_Buf[15] = 0x01; /* 1风干开 */
	}
	else
	{
		TX_Buf[15] = 0x00; /* 0风干关 */
	}
	TX_Buf[16] = FAN_CNT_DWON;	/* 风干定时到计时(airDryCountdown) Byte5 */
	/* 烘干功能状态(dryStatus) Byte6:Bit1  */
	if(OKdry == SET)
	{
		TX_Buf[17] = 0x01; /* 1烘干开 */
	}
	else
	{
		TX_Buf[17] = 0x00; /* 0烘干关 */
	}
	TX_Buf[18] = DRY_CNT_DWON;	/* 烘干定时到计时(dryCountdown)	Byte7 */
	/* 消毒功能状态(disinfectStatus，Byte8:Bit0 */
	if(OKuvc == SET)
	{
		TX_Buf[19] = 0x01;	/* 消毒开 */
	}
	else
	{
		TX_Buf[19] = 0x00;	/* 消毒关 */
	}
	TX_Buf[20] = UVC_CNT_DWON;	/* 消毒定时到计时(disinfectCountdown)  byte9 */
	TX_Buf[21] = TM_UVC;		/* 消毒定时时间(disinfectTimingTime)，Byte10, 暂无此功能 */
	TX_Buf[22] = TM_DRY;		/* 烘干定时时间(dryTimingTime) Byte11 */
	TX_Buf[23] = TM_FAN;		/* 风干定时时间(airDryTimingTime), Byte12 */
	TX_Buf[24] = LGT_CNT_DWON;	/* 照明定时到计时(lightCountdown), Byte13 */
	TX_Buf[25] = FAN_CNT_DWON;	/* 负离子定时到计时(anionCountdown), Byte14, 暂无此功能 */

	TX_Buf[26] = 0x00;			/* 和校验 */
	for(TX_i = 2; TX_i < 26; TX_i++)
	{
		TX_Buf[26] += TX_Buf[TX_i];
	}
	tx_index = 27;		/* 发送字节数 */
	TX1IE = 1;			/* 打开发送中断 */
	CREN1 = 1;			/* 允许接收 */

	// /* 设备状态，10bytes， 12-21byte */
	// TX_Buf[12] = 0x00;	/* 数值归零 */
	// /* 运动状态(moveStatus) Byte1:Bit7~ Byte1:Bit6 */
	// if(OKhang_UP == SET)
	// {
	// 	TX_Buf[12] = 0x40; /* 01上升 */
	// }
	// else if(OKhang_DWN == SET)
	// {
	// 	TX_Buf[12] = 0x80; /* 02下降 */
	// }
	// else
	// {
	// 	TX_Buf[12] = 0x00; /* 00停止 */
	// }
	// /* 停留位置(position) Byte1:Bit5~Byte1:Bit4 */
	// if(PIhang_H == SET)
	// {
	// 	TX_Buf[12] |= 0x00;	/* 00最上面 */
	// }
	// else if(PIhang_L == SET)
	// {
	// 	TX_Buf[12] |= 0x20;	/* 02最下面 */
	// }
	// else
	// {
	// 	TX_Buf[12] |= 0x10;	/* 01中间 */
	// }
	// /* 照明功能状态(lightStatus) Byte1:Bit3 */
	// if(Flight == SET)
	// {
	// 	TX_Buf[12] |= 0x08;	/* 1照明开 */
	// }
	// // else
	// // {
	// // 	TX_Buf[12] &= ~0x08;	/* 照明关 */
	// // }
	// /* 风干功能状态(airDryStatus) Byte1:Bit2 */
	// if(OKfan == SET)
	// {
	// 	TX_Buf[12] |= 0x04; /* 1风干开 */
	// }
	// /* 烘干功能状态(dryStatus) Byte1:Bit1  */
	// if(OKdry == SET)
	// {
	// 	TX_Buf[12] |= 0x02; /* 1烘干开 */
	// }
	// /* 消毒功能状态(disinfectStatus，Byte1:Bit0 */
	// if(OKuvc == SET)
	// {
	// 	TX_Buf[12] |= 0x01; /* 1消毒开 */
	// }

	// TX_Buf[13] = DRY_CNT_DWON;	/* 烘干定时到计时(dryCountdown)	Byte2 */
	// TX_Buf[14] = FAN_CNT_DWON;	/* 风干定时到计时(airDryCountdown) Byte3 */
	// TX_Buf[15] = UVC_CNT_DWON;	/* 消毒定时到计时(disinfectCountdown) Byte4, 暂无此功能 */
	// TX_Buf[16] = TM_UVC;		/* 消毒定时时间(disinfectTimingTime)，Byte5, 暂无此功能 */
	// TX_Buf[17] = TM_DRY;		/* 烘干定时时间(dryTimingTime) Byte6 */
	// TX_Buf[18] = TM_FAN;		/* 风干定时时间(airDryTimingTime), Byte7 */
	// TX_Buf[19] = LGT_CNT_DWON;	/* 照明定时到计时(lightCountdown), Byte8 */
	// TX_Buf[20] = 0x00;			/* 负离子定时到计时(anionCountdown), Byte9, 暂无此功能 */
	// TX_Buf[21] = 0x00;			/* 预留 */
	// TX_Buf[22] = 0x00;			/* 和校验 */
	// for(TX_i = 2; TX_i < 22; TX_i++)
	// {
	// 	TX_Buf[22] += TX_Buf[TX_i];
	// }
	// tx_index = 23;		/* 发送字节数 */
	// TX1IE = 1;			/* 打开发送中断 */
	// CREN1 = 1;			/* 允许接收 */
	// // Uart_MaxRrNo = 15; 	/* 接收字节数(最大15) */
}

/* 设备通知模块进入配置模式 */
void WiFiConfigModeTx(void)
{
	TX_Buf[0] = 0xFF; 	/* 帧头1 */
	TX_Buf[1] = 0xFF; 	/* 帧头2 */
	TX_Buf[2] = 0x0A; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	TX_Buf[4] = 0x00; 	/* 预留位1 */
	TX_Buf[5] = 0x00; 	/* 预留位2 */
	TX_Buf[6] = 0x00; 	/* 预留位3 */
	TX_Buf[7] = 0x00; 	/* 预留位4 */
	TX_Buf[8] = 0x00; 	/* 预留位5 */
	TX_Buf[9] = 0xF2; 	/* 帧类型 */
	TX_Buf[10] = 0x00;	/*  */
	TX_Buf[11] = 0x00;	/* softAp和BT配置模式（推荐） */
	TX_Buf[12] = 0xFC;	/* 和校验 */
	tx_index = 13;		/* 发送字节数 */
	TX1IE = 1;			/* 打开发送中断 */
	CREN1 = 1;			/* 允许接收 */
	// Uart_MaxRrNo = 15; 	/* 接收字节数(最大15) */
}

/* 设备通知模块进入工作模式0xF4 */
void WiFiWorkModeTX(void)
{
	TX_Buf[0] = 0xFF; 	/* 帧头1 */
	TX_Buf[1] = 0xFF; 	/* 帧头2 */
	TX_Buf[2] = 0x0A; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	TX_Buf[4] = 0x00; 	/* 预留位1 */
	TX_Buf[5] = 0x00; 	/* 预留位2 */
	TX_Buf[6] = 0x00; 	/* 预留位3 */
	TX_Buf[7] = 0x00; 	/* 预留位4 */
	TX_Buf[8] = 0x00; 	/* 预留位5 */
	TX_Buf[9] = 0xF4; 	/* 帧类型 */
	TX_Buf[10] = 0x00;	/*  */
	TX_Buf[11] = 0x00;	/* 工作模式 */
	TX_Buf[12] = 0xFE;	/* 和校验 */
	tx_index = 13;		/* 发送字节数 */
	TX1IE = 1;			/* 打开发送中断 */
	CREN1 = 1;			/* 允许接收 */
	// Uart_MaxRrNo = 15; 	/* 接收字节数(最大15) */
}

/* 设备主动汇报间隔0x7D */
void DeviceFreqSetTx(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* 帧头1 */
	TX_Buf[1] = 0xFF; 	/* 帧头2 */
	TX_Buf[2] = 0x0A; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	TX_Buf[4] = 0x00; 	/* 预留位1 */
	TX_Buf[5] = 0x00; 	/* 预留位2 */
	TX_Buf[6] = 0x00; 	/* 预留位3 */
	TX_Buf[7] = 0x00; 	/* 预留位4 */
	TX_Buf[8] = 0x00; 	/* 预留位5 */
	TX_Buf[9] = 0x7D; 	/* 帧类型 */
	// TX_Buf[10] = 0xFF;	/* 默认值 */
	// TX_Buf[11] = 0xFF;	/* 默认值 */
	TX_Buf[10] = (unsigned char)(TM_DEV_TX>> 8);	/* 高位 */
	TX_Buf[11] = (unsigned char)(TM_DEV_TX);	/* 低位 */
	TX_Buf[12] = 0x00;	/* 和校验 */
	for(TX_i = 2; TX_i < 12; TX_i++)
	{
		TX_Buf[12] += TX_Buf[TX_i];
	}
	tx_index = 13;		/* 发送字节数 */
	TX1IE = 1;			/* 打开发送中断 */
	CREN1 = 1;			/* 允许接收 */
	// Uart_MaxRrNo = 15; 	/* 接收字节数(最大15) */
}

/* 设备大数据汇报间隔FB */
void DataFreqSetTx(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* 帧头1 */
	TX_Buf[1] = 0xFF; 	/* 帧头2 */
	TX_Buf[2] = 0x0A; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	TX_Buf[4] = 0x00; 	/* 预留位1 */
	TX_Buf[5] = 0x00; 	/* 预留位2 */
	TX_Buf[6] = 0x00; 	/* 预留位3 */
	TX_Buf[7] = 0x00; 	/* 预留位4 */
	TX_Buf[8] = 0x00; 	/* 预留位5 */
	TX_Buf[9] = 0xFB; 	/* 帧类型 */
	// TX_Buf[10] = 0xFF;	/* 默认值 */
	// TX_Buf[11] = 0xFF;	/* 默认值 */
	TX_Buf[10] = (unsigned char)(TM_DATA_TX >> 8);	/* 高位 */
	TX_Buf[11] = (unsigned char)(TM_DATA_TX);	/* 低位 */
	TX_Buf[12] = 0x00;	/* 和校验 */
	for(TX_i = 2; TX_i < 12; TX_i++)
	{
		TX_Buf[12] += TX_Buf[TX_i];
	}
	tx_index = 13;		/* 发送字节数 */
	TX1IE = 1;			/* 打开发送中断 */
	CREN1 = 1;			/* 允许接收 */
	// Uart_MaxRrNo = 15; 	/* 接收字节数(最大15) */
}

/* 波特率更改设定，0xE7(可选，OTA必选) */
void WifiUartBpsSet(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* 帧头1 */
	TX_Buf[1] = 0xFF; 	/* 帧头2 */
	TX_Buf[2] = 0x09; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	TX_Buf[4] = 0x00; 	/* 预留位1 */
	TX_Buf[5] = 0x00; 	/* 预留位2 */
	TX_Buf[6] = 0x00; 	/* 预留位3 */
	TX_Buf[7] = 0x00; 	/* 预留位4 */
	TX_Buf[8] = 0x00; 	/* 预留位5 */
	TX_Buf[9] = 0xE7; 	/* 帧类型 */
	TX_Buf[10] = 0x05;	/* 波特率代码，19200 */
	TX_Buf[11] = 0x00;	/* 和校验 */
	for(TX_i = 2; TX_i < 11; TX_i++)
	{
		TX_Buf[11] += TX_Buf[TX_i];
	}
	tx_index = 12;		/* 发送字节数 */
	TX1IE = 1;			/* 打开发送中断 */
	CREN1 = 1;			/* 允许接收 */
	// Uart_MaxRrNo = 15; 	/* 接收字节数(最大15) */
}

/* 查询子板信息,0xEA(WiFi - 0xE9) */
void WifiSubBoardInfoTx(void)
{
	// unsigned char TX_i = 0;
	// TX_Buf[0] = 0xFF; 	/* 帧头1 */
	// TX_Buf[1] = 0xFF; 	/* 帧头2 */
	// TX_Buf[2] = 0x2C; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	// TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	// TX_Buf[4] = 0x00; 	/* 预留位1 */
	// TX_Buf[5] = 0x00; 	/* 预留位2 */
	// TX_Buf[6] = 0x00; 	/* 预留位3 */
	// TX_Buf[7] = 0x00; 	/* 预留位4 */
	// TX_Buf[8] = 0x00; 	/* 预留位5 */
	// TX_Buf[9] = 0xEA; 	/* 帧类型 */
	// TX_Buf[10] = 0x00;	/* 数据信息，子板号 */
	// /* 子板软件标识符，20bytes，11-30 */
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
	// /* 子板软件版本号，14bytes，31-44 */
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
	// /* 是否支持升级 */
	// TX_Buf[45] = 0x00;

	// TX_Buf[46] = 0x00;	/* 和校验 */
	// for(TX_i = 2; TX_i < 46; TX_i++)
	// {
	// 	TX_Buf[46] += TX_Buf[TX_i];
	// }
	// tx_index = 47;		/* 发送字节数 */
	// TX1IE = 1;			/* 打开发送中断 */
	// CREN1 = 1;			/* 允许接收 */
}

/* 整机数据答复0xEC */
void WifiMachineInfoTx(void)
{
	// unsigned char TX_i = 0;
	// TX_Buf[0] = 0xFF; 	/* 帧头1 */
	// TX_Buf[1] = 0xFF; 	/* 帧头2 */
	// TX_Buf[2] = 0x2C; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	// TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	// TX_Buf[4] = 0x00; 	/* 预留位1 */
	// TX_Buf[5] = 0x00; 	/* 预留位2 */
	// TX_Buf[6] = 0x00; 	/* 预留位3 */
	// TX_Buf[7] = 0x00; 	/* 预留位4 */
	// TX_Buf[8] = 0x00; 	/* 预留位5 */
	// TX_Buf[9] = 0xEC; 	/* 帧类型 */

	// // tx_index = 47;		/* 发送字节数 */
	// TX1IE = 1;			/* 打开发送中断 */
	// CREN1 = 1;			/* 允许接收 */
}

/* 模块清除配置信息帧 */
void WifiInfoClearTx(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* 帧头1 */
	TX_Buf[1] = 0xFF; 	/* 帧头2 */
	TX_Buf[2] = 0x08; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	TX_Buf[4] = 0x00; 	/* 预留位1 */
	TX_Buf[5] = 0x00; 	/* 预留位2 */
	TX_Buf[6] = 0x00; 	/* 预留位3 */
	TX_Buf[7] = 0x00; 	/* 预留位4 */
	TX_Buf[8] = 0x00; 	/* 预留位5 */
	TX_Buf[9] = 0xF8; 	/* 帧类型 */
	TX_Buf[10] = 0x00;	/* 和校验 */
	for(TX_i = 2; TX_i < 10; TX_i++)
	{
		TX_Buf[10] += TX_Buf[TX_i];
	}
	tx_index = 11;		/* 发送字节数 */
	TX1IE = 1;			/* 打开发送中断 */
	CREN1 = 1;			/* 允许接收 */
}

/* 模块进入生产测试模式帧,0xF9 */
void WifiProductTestTx(void)
{
	unsigned char TX_i = 0;
	TX_Buf[0] = 0xFF; 	/* 帧头1 */
	TX_Buf[1] = 0xFF; 	/* 帧头2 */
	TX_Buf[2] = 0x08; 	/* 帧长，包括预留位、帧类型、数据信息和校验和在内的整个帧长度的字节数，帧长长度为1个字节，取值范围 8～254，不包括“CRC校验和”的字节数 。 */
	TX_Buf[3] = 0x00; 	/* 标志位，bit6为1，CRC校验, 0x40 */
	TX_Buf[4] = 0x00; 	/* 预留位1 */
	TX_Buf[5] = 0x00; 	/* 预留位2 */
	TX_Buf[6] = 0x00; 	/* 预留位3 */
	TX_Buf[7] = 0x00; 	/* 预留位4 */
	TX_Buf[8] = 0x00; 	/* 预留位5 */
	TX_Buf[9] = 0xF9; 	/* 帧类型 */
	TX_Buf[10] = 0x00;	/* 和校验 */
	for(TX_i = 2; TX_i < 10; TX_i++)
	{
		TX_Buf[10] += TX_Buf[TX_i];
	}
	tx_index = 11;		/* 发送字节数 */
	TX1IE = 1;			/* 打开发送中断 */
	CREN1 = 1;			/* 允许接收 */
}

/* WIFI模块发送信息处理 */
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
			Flash_Write(0x59, 0x01);	/* 将变化标识符记录 */
		}
		else
		{
			Flash_Write(0x59, 0x00);	/* 将变化标识符记录 */
		}
	}

	if(++CNTwifiTx100ms >= 10)
	{
		CNTwifiTx100ms = 0;
		if(FdevActOff == CLR)	/* 主动汇报开启 */
		{
			if(FdevActTx == CLR)
			{
				if(++CNTuartTxd >= TM_DEV_TX)	/* 默认间隔5s（改为60s） */
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

		/* 大数据，功能暂无 */
		// if(FdataAtoOff == CLR)
		// {
			
		// }
	}

	if(F1s_Uart == SET)
	{
		F1s_Uart = CLR;
		if(FwifiCfgSts == SET)
		{
			if(++CNTwifiCfgSts >= 1800)	/* 进入配置模式30分钟后未成功配网，通知WiFi进入工作模式 */
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

		/* 收到05确认帧，5s后继续上报报警信息 */
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

	/* 接收到模块指令后50ms内回复该命令 */
	if(FdevTx62 == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			FdevTx62 = CLR;
			DeviceVersionTx();	/* 20ms后回复设备版本信息 */
		}
	}
	else if(FdevTx71 == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			FdevTx71 = CLR;
			DeviceTypeTx();		/* 20ms后回复设备类型信息（产品信息表TYPEID） */
		}
	}
	else if(Fwifi_OKtx == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			Fwifi_OKtx = CLR;
			WiFiDeviceReturn();	/* 控制指令信息状态返回 */
		}
	}
	else if(FinvalidCom == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			FinvalidCom = CLR;
			WiFiInvalidCom(); 	/* 无效信息（指令） */
		}	
	}
	else if(FdevOK_Tx == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			FdevOK_Tx = CLR;
			WiFiDeviceOKTx(); 	/* 设备发送确认信息 */
		}
	}
	else if(FdevFreqSet == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			FdevFreqSet = CLR;
			DeviceFreqSetTx();		/* 设定用户数据发送间隔 */
		}
	}
	else if(FdatFreqSet == SET)
	{
		if(++CNTwifiReplyTX >= 2)
		{
			CNTwifiReplyTX = 0;
			FdatFreqSet = CLR;
			DataFreqSetTx();	/* WiFi设定大数据应答间隔 */
		}
	}
	// else if(FsubBoardTx == SET)
	// {
	// 	if(++CNTwifiReplyTX >= 3)
	// 	{
	// 		CNTwifiReplyTX = 0;
	// 		FsubBoardTx = CLR;
	// 		WifiSubBoardInfoTx();	/* 子板信息回复 */
	// 	}
	// }
	// else if(FmacTx == SET)
	// {
	// 	if(++CNTwifiReplyTX >= 3)
	// 	{
	// 		CNTwifiReplyTX = 0;
	// 		FmacTx = CLR;
	// 		WifiMachineInfoTx();	/* 子板信息回复 */
	// 	}
	// }
	else if(FalarmCheck == SET)
	{
		WiFiAlarmTx();		/* WiFi查询报警回复 */
	}
	else if(FwifiWork == SET)
	{
		FwifiWork = CLR;
		WiFiWorkModeTX();	/* 0x74, 通知WiFi模块进入工作模式 */
	}
	else if(Freset == SET)
	{
		if(++CNTwifiReplyTX >= 4)
		{
			CNTwifiReplyTX = 0;
			Freset = CLR;
			FcodeAdd_M = SET;
			GbuzOutSet(5);
			// WifiInfoClearTx();	/* WiFi清除配置信息(待确认，清除后断网) */
		}
		else if(CNTwifiReplyTX == 3)
		{
			TM_DATA_TX = 600;	/* 大数据汇报间隔60s */
			TM_DEV_TX = TM_TX_60S;	/* 设备主动汇报间隔600s */
			TM_UVC = 120;       /* 紫外杀菌定时时间 */
			UVC_CNT_DWON = 0;   /* 紫外杀菌倒计时 */
			LGT_CNT_DWON = 0; 	/* 照明倒计时 */
			TM_DRY = 120;       /* 烘干定时时间 */
			TM_FAN = 120;       /* 风干定时时间 */
			DRY_CNT_DWON = 0; 	/* 烘干倒计时 */
			FAN_CNT_DWON = 0; 	/* 风干倒计时 */
			OKdry = CLR;
			OKfan = CLR;
			OKhang_DWN = CLR;
			OKhang_UP = CLR;
			OKoneLine = CLR;
			OKuvc = CLR;
			Flight = CLR;
			DeviceActiveInfoTX();	/* 设备主动汇报信息 */
		}
		else if(CNTwifiReplyTX == 2)
		{
			DeviceActiveInfoTX();	/* 设备主动汇报信息 */
		}
	}
	else
	{
		CNTwifiReplyTX = 0;
	}

	/* 如200ms时间内未收到模块的ACK帧，设备重发汇报帧，最多重发2次，间隔200ms。 */
	if(++CNTwifiTx200ms >= 20)
	{
		CNTwifiTx200ms = 0;
		if(FdevActTx == SET)
		{
			DeviceActiveInfoTX();	/* 设备主动汇报信息 */
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
		WiFiAlarmTx();	/* 每隔200ms一次 */
	}
	else if(CNTwifiTx200ms == 10)
	{
		if(FwifiCfg == SET)
		{
			// FwifiCfg = CLR;
			WiFiConfigModeTx(); 	/* 设备通知模块进入配对模式 */
		}
	}
}

/* 读取通电后WiFi是否配对标识符 */
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
/* 矽控离线语音 */
/* 语音数据串口发送 */
void VoiceUartTxd(void)
{
	unsigned char voice_i = 0;
	if(++CNTuartTxd >= 10)	/* 200ms间隔 */
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
			TX_Buf[6] = 0x00; /* 0-6，和校验 */
			for(voice_i = 0; voice_i < 6; voice_i++)
			{
				TX_Buf[6] += TX_Buf[voice_i];
			}
			tx_index = 7;		/* 发送字节数 */
			TX1IE = 1;			/* 打开发送中断 */
			CREN1 = 1;			/* 允许接收 */
		}
	}
}

/* 语音数据串口接收判定 */
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
				case 0x01:						/* 晾衣架上升 */
					Fvoice_Set = SET;
					Voice_Key = 0x01;			/* 晾衣杆已上升 */
					SETuart_code = KEY_UP;		/* 上升 */
					break;
				case 0x02:						/* 晾衣架下降 */
					Fvoice_Set = SET;
					Voice_Key = 0x02;			/* 晾衣架已下降 */
					SETuart_code = KEY_DOWN;	/* 下降 */
					break;
				case 0x03:
					Fvoice_Set = SET;
					Voice_Key = 0x03;
					SETuart_code = KEY_STP;	/* 停止 */
					break;
				case 0x04:						/* 开灯 */
					if(Flight == SET)
					{
						Fuart_OK = CLR;
						Fvoice_Set = SET;
						// Voice_Key = 0x31;		/* 0x31抱歉，本次操作无效 */
						Voice_Key = 0x04;			/* 灯光已打开 */
						break;
					}
					Fvoice_Set = SET;
					Voice_Key = 0x04;			/* 灯光已打开 */
					SETuart_code = KEY_LIGHT;
					break;
				case 0x05:						/* 关灯 */
					if(Flight == CLR)
					{
						Fuart_OK = CLR;
						Fvoice_Set = SET;
						// Voice_Key = 0x31;		/* 0x31抱歉，本次操作无效 */
						Voice_Key = 0x05;			/* 灯光已关闭 */
						break;
					}
					Fvoice_Set = SET;
					Voice_Key = 0x05;			/* 灯光已关闭 */
					SETuart_code = KEY_LIGHT;
					break;
#if VER_2510M
				case 0x06:						/* 打开烘干 */
					if(OKdry == SET)
					{
						Fuart_OK = CLR;
						Fvoice_Set = SET;
						// Voice_Key = 0x31;		/* 0x31抱歉，本次操作无效 */
						Voice_Key = 0x06;			/* 烘干已打开 */
						break;
					}
					Fvoice_Set = SET;
					Voice_Key = 0x06;			/* 烘干已打开 */
					SETuart_code = KEY_DRY;
					break;
				case 0x07:						/* 关闭烘干 */
					if(OKdry == CLR)
					{
						Fuart_OK = CLR;
						Fvoice_Set = SET;
						// Voice_Key = 0x31;		/* 0x31抱歉，本次操作无效 */
						Voice_Key = 0x07;			/* 烘干已关闭 */
						break;
					}
					Fvoice_Set = SET;
					Voice_Key = 0x07;			/* 烘干已关闭 */
					SETuart_code = KEY_DRY;
					break;
				case 0x08:						/* 打开风干 */
					if(OKfan == SET)
					{
						Fuart_OK = CLR;
						Fvoice_Set = SET;
						// Voice_Key = 0x31;		/* 0x31抱歉，本次操作无效 */
						Voice_Key = 0x08;			/* 烘干已打开 */
						break;
					}
					Fvoice_Set = SET;
					Voice_Key = 0x08;			/* 烘干已打开 */
					SETuart_code = KEY_FAN;
					break;
				case 0x09:						/* 关闭风干 */
					if(OKfan == CLR)
					{
						Fuart_OK = CLR;
						Fvoice_Set = SET;
						// Voice_Key = 0x31;		/* 0x31抱歉，本次操作无效 */
						Voice_Key = 0x09;			/* 风干已关闭 */
						break;
					}
					Fvoice_Set = SET;
					Voice_Key = 0x09;			/* 风干已关闭 */
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

/* 起始语音 */
void GstartVoice(void)
{
	Fvoice_Set = SET;
	Voice_Key = 0x0A;
	FvoiceSta = SET;
	// FuartBpsSw = SET;
}

/* 串口指令 */
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

/* 开机发送一次当前电机信息，预警值及锁死值 */
void MotorAVuartInit(void)
{
	FwrSend = SET;
}


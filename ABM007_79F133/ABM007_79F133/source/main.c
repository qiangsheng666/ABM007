// #include <cms.h>	//芯片头文件，会根据工程选项自动寻找对应型号头文件
#include "cfg_user.h"
#include "cfg_case.h"
#include "math.h"
#include "string.h"

volatile unsigned int TMR1 @0x000E;
#define TIMER1_TIME 0xE0C0

/**********************************************************************/
/*全局变量声明*/
/**********************************************************************/

/*变量*/
v_uint8 RX_Buf;
v_uint8 templ = 0;
v_uint8 SEQmain = 0;
v_uint8 MainTime_1min = 0;	/* 定时1min计数 */
v_uint16 MainTime_1s = 0;	/* 定时1s计数 */
v_uint16 AD_Result = 0;

extern  void INT_LED_SHOW(void);
#if FCT_TEST
	extern void FCTloop(void);
#endif

/***********************************************************************
函数功能：延时子函数，13个指令周期1循环
***********************************************************************/
void Delay(unsigned int dtemp)
{
	while (dtemp--)
		;
}
/***********************************************************************
子函数功能：延时templ  ms，有中断则不准
***********************************************************************/
void Delay_nms(unsigned int inittempl)
{
	unsigned int i;
	unsigned char gtemp;
	/******************************************************************/
	gtemp = 0;
	if (GIE == 1)
	{
		gtemp = 1;
		GIE = 0;
	}
	for (i = 0; i < inittempl; i++)
	{
		Delay(154);
		asm("clrwdt");
	}
	if (gtemp == 1)
		GIE = 1;
}

/************************************************************
函数名称：Init_GPIO()
函数功能：初始化IO端口
入口参数：
出口参数：
备注：
************************************************************/
void Init_GPIO(void)
{

	/*引脚数据*/
	PORTA = 0B00000000;
	PORTB = 0B00000000;
	PORTC = 0B00000000;

	/* 全部配置成输入状态，1: 输入，0: 输出 */
	TRISA = 0B00000000; /* RA2-气泵	RA4-主阀 RA5-氛围灯 */
	TRISB = 0B00000010; /* RB1-龙头感应 */
	TRISC = 0B00000000;

	/*内部上拉关闭, 1: 开启, 0: 关闭 */
	WPUA = 0B00000000; /* RA2-气泵	RA4-主阀 RA5-氛围灯 */
	WPUB = 0B00000010; /* RB1-龙头感应<置1则不插为有人状态，RB1低有效> */
	WPUC = 0B00000000;

	/* 内部下拉 */
	// WPDB =  0B00000000; /* RB1-龙头感应<1不插为无人状态，RB1高有效> */

	/*模拟通道选择*/
//	ANSEL0 = 0B00000000; // AN7 - AN0
//	ANSEL1 = 0B00000000; // AN15 - AN8
//	ANSEL2 = 0B00000000; //------AN17 AN16
}

/************************************************************
函数名称：Init_IC()
函数功能：上电初始化系统寄存器
入口参数：
出口参数：
备注：
************************************************************/
void Init_IC(void)
{
	asm("clrwdt");

	// 7			6			5			4			3			2			1			0
	// GIE		PEIE		TOIE		INTE		RBIE		TOIF		INTF		RBIF
	// 全局允许	外设允许	T0允许		INT允许		PB允许		T0标志		INT标志		PB标志
	INTCON = 0x00; // 中断控制寄存器

	// 7			6			5			4			3			2			1			0
	//--		ADIF		RCIF		TXIF		--			CCP1IF		TMR2IF		TMR1IF
	// NC		AD转换完成	UART接收满	UART发送满		NC		CCP1中断	T2与PR2匹配		T1
	PIR1 = 0; // 外设中断请求寄存器

	// 7			6			5			4			3			2			1			0
	//--		TKIF		RACIF		EEIF		--			--			--			CCP2IF
	// NC		触摸检测结束 PA变化		 EEP写完成	  NC		  NC		  NC		  CCP2中断
	PIR2 = 0; // 外设中断请求寄存器

	// 7			6			5			4			3			2			1			0
	//--		--			--			--			--			--			--			SWDTEN
	// NC		NC			NC			NC			NC			NC			NC			使能
	WDTCON = 0x01; // 看门狗

	// 7				6			5			4			3			2			1		0
	// RBPU			INTEDG			T0CS		T0SE		PSA			PS2			PS1		PS0
	// PB上拉使能	中断边沿选择  	T0时钟源	  T0边沿选择	预分配		预分配参数
	OPTION_REG = 0b00001110; // 开启PORTB上来使能，看门狗复位时间=18*分频系数 (规格书 2.6/2.8.1)

	// 7			6			5			4			3			2			1			0
	//--		IRCF2		IRCF1		IRCF0		--			--			--			--
	// NC		内振分频							NC			NC			NC			NC
	OSCCON = 0x71; // 振荡器控制

	// 7			6			5			4			3			2			1				0
	//--		ADIE		RCIE		TXIE		--			CCP1IE		TMR2IE			TMR1IE
	// NC		AD转换允许	UART接收允许 UART发送允许 NC		  CCP1允许	  T2与PR2匹配允许	T1溢出允许
	PIE1 = 0; // 外设中断允许

	//
	//--	TKIE				RACIE			EEIE			--		--		--		CCP2IE
	// NC	触摸检测结束允许	PA变化允许			EEP写允许		NC		NC		NC		CCP2中断允许
	PIE2 = 0; // 外设中断允许
}

/************************************************************
函数名称：Init_TIMER1()
函数功能：定时器1初始化函数
入口参数：
出口参数：
备注：	  定时时间计算方法
		  定时时间T = {1/[(Fosc)*预分频比)]}*(65535-[TMR1H:TMR1L])
		  本程序计算示例：
		  T = {1/[(8)*(1/1)]}*(65536 - 63936)
			= 125 us
************************************************************/
void Init_TIMER1(void)
{
	// TMR1L = 0xC0; //赋初值
	// TMR1H = 0xF9;
	TMR1 = TIMER1_TIME;
	TMR1IF = 0;	  // 清中断标志位
	TMR1IE = 1;	  // 允许Timer1中断
	T1CON = 0x01; // 开启Timer1，使用内部时钟源Fosc，预分频比为1:1
}

/************************************************************
函数名称：Init_TIMER2()
函数功能：定时器2初始化函数
入口参数：
出口参数：
备注：	  定时时间计算方法
		  时钟输入为系统指令时钟（即为Fosc/4）
		  定时时间T = {1/[(Fosc/4)*预分频比*后分频比]}*(PR2+1)
		  本程序计算示例：
		  T = {1/[(8/4)*(1/4)*1]}*50 = 100 us

************************************************************/
void Init_TIMER2(void)
{
	PR2 = 24;	// 8M下将TMR2设置为50us中断?
	TMR2IF = 0; // 清中断标志位
	TMR2IE = 1; // 允许Timer2中断
	T2CON = 5;	// 开启Timer2，预分频值为4，后分频比为1:1
}

/* 遥控器接收数据时钟，50μs */
// void Init_TIMER2_Remo(void)
//{
//	PR2 = 24;		//16M下将TMR2设置为50μs中断
//	TMR2IF = 0; 	//清中断标志位
//	TMR2IE = 1; 	//允许Timer2中断
//	T2CON = 5;		//开启Timer2，预分频值为4，后分频比为1:1
// }

/***********************************************
函数名称：Set_CCP_PWM
函数功能：CCP PWM模式初始化
入口参数：无
出口参数：无
备注：
	   周期 = (PWMxCYC+1)*4/Fosc*PWMxCNT预分频值
	  占空比 = (CCPRxL:CCPCON<5:4>)/(4*(PWMxCYC + 1))
	  由于CCPx 引脚与端口数据锁存器复用，必须清零相应的TRIS 位才能使能CCPx 引脚的输出驱动器。
************************************************/
void Set_CCP_PWM()
{
//	PWMCON = 0B00000001; // PWM1设置为16分频，使能PWM1

	// // PWM1 周期设置为500us，占空比50%
	// CCP1CON = 0B00001100; // PWM模式,10位占空比数据低2位为0；
	// PWM1CYC = 124;		  // PWM1周期为：(249+1)* （4/8） * 4 =500uS
	// CCPR1L = 62;		  // 低2位为0,(CCPRxL:CCPCON<5:4>)=CCPR1L*4
	// CYC1EN = 1;			  /* PWM1的周期计数器使能位,1使能，0禁止 */
	// PWMTL = 0x8f;					//PWM0~3共周期，周期低位
	PWMT4L = 0x7C;					//PWM4独立周期，周期低位,0x7C,(124+1)* （4/8） * 4 =250μs
	PWMTH = 0B00011101;				//周期高两位及PWM4占空比高两位	
	/* PWMTH: bit5~bit4- PWM4占空比高2位，bit3~bit2-PWM周期高2位，bit1~bit0-PWM0~PWM3周期高2位 */
	
	//PWM0~3周期为：(0B110001111+1)*(1/16)*2 =50uS
	//PWM4周期为：(0B1110001111+1)*(1/16)*2 =114uS
	/* PWM4 0B00001100 */
	
	// PWMD01H = 0x00;					//高位改变后不能立即生效，需要给占空比的低位寄存器后才能加载
	// //PWM0 占空比设置为20%
	// PWMD0L = 0x4f;					//(79+1)/(399+1) = 20%
	// //PWM1 占空比设置为40%
	// PWMD1L = 0x9f;					//(159+1)/(399+1) = 40%

	// PWMD23H = 0x10;
	// //PWM2 占空比设置为60%
	// PWMD2L = 0xef;					//(239+1)/(399+1) = 60%
	// //PWM3 占空比设置为80%
	// PWMD3L = 0x3f;					//(319+1)/(399+1) = 80%

	//PWM4 占空比设置为25%
	PWMD4L = 0xC7;					//(227+1)/(911+1) = 25% ()
	/* 50% 0x01C7, (455+1)/(911+1) */
	
	// PWM01DT = 0x3F;					//死区时间，低6位有效位=(0B00111111+1)*(1/16)*1 =4uS
	// PWM23DT = 0;
	
	PWMCON2 = 0B00000000;			//正常输出
	PWMCON1 = 0B00000000;			//PWM01位置选择为RB5/RB4;禁止死区；可使能PWM0/1互补，PWM2/3互补
	PWMCON0 = 0B00110000;			//PWM分频Fosc/2，使能PWM4
}

/***********************************************
函数名称：Memory_Write
函数功能：写数据
入口参数：Addr - 写入地址
		  Value - 写入数值
出口参数：返回值 0 - 写操作错误 1 - 写完毕
备注：
写程序EE过程中需要暂时关闭中断，以保证写EE时序中的写55H和写AAH能够连续进行，否则将有可能写错，并且写EE的可靠工作电压范围为3V以上。
************************************************/
unsigned char Memory_Write(unsigned char Addr, unsigned char Value)
{

	volatile unsigned char i = 0;
	// 将要写入的地址放入EEADDR寄存器
	EEADR = Addr;
	EEDAT = Value; // 将要写入的数据给EEPROM的数据寄存器
	EECON1 = 0;
	EEPGD = 0;		 // 访问数据存储器
	EECON1 | = 0x10; // 烧写时间10ms（0x30）,时间非固定精准,用户可自定义(最长烧写等待时间2.5ms, 0x10)
	asm("clrwdt");

	WREN = 1; // 允许写周期
	GIE = 0;  // 关闭中断
	GIE = 0;
	GIE = 0;
	while (GIE)
	{
		GIE = 0; // 确保中断已关闭
		if (0 == --i)
		{
			// 注：程序使用了中断需执行GIE = 1，否则需屏蔽此条语句
			GIE = 1; // 总中断GIE置1
			return 0;
		}
	}
	asm("clrwdt");

	EECON2 = 0x55; // 给EECON2写入0x55
	EECON2 = 0xaa; // 给EECON2写入0xaa
	WR = 1;		   // 启动写周期
	asm("nop");
	asm("nop");
	asm("clrwdt");
	WREN = 0; // 禁止写入
	// 注：程序使用了中断需执行GIE = 1，否则需屏蔽此条语句
	GIE = 1; // 总中断GIE置1

	if (WRERR)
		return 0; // 写操作错误
	else
		return 1; // 写完毕
}

void Flash_Write(unsigned char Addr, unsigned char Value)
{
	uint8_t bufAddress;
	uint8_t bufValue;
	bufAddress = Addr;
	bufValue = Value;
	templ = 10; //错误计数，用户可自定义
	do
	{
		asm("clrwdt");
		asm("clrwdt");
	} while ((0 == Memory_Write(bufAddress, bufValue)) && (templ--)); //调用写函数：地址0x00处写入数据0x5a
}

/***********************************************
函数名称：Memory_Read
函数功能：读数据
入口参数：Addr - 读取地址
出口参数：返回读取地址相应数值
备注：
************************************************/
unsigned char Memory_Read(unsigned char Addr)
{

	EEADR = Addr;
	EEPGD = 0; // 访问数据存储器

	RD = 1; // 允许读操作
	asm("nop");
	asm("nop");

	return (EEDAT);
}

/************************************************************
函数名称：AD_Testing()
函数功能：AD采样函数
入口参数：ad_fd - 分频 00Fosc/8; 01Fosc/16; 10Fosc/32; 11Frc;
		  ad_ch - AD通道选择1~15，15通道为内部基准1.2V固定输入值
		  ad_lr - 左/右对齐，输入0或1，0为左对齐，1为右对齐

出口参数：AdResult - AD结果
备    注：BUFmotor_ad = AD_Testing(0, 10, 0); //8分频，AN10通道，右对齐	规格书11.2.4，8M主频最快8分频
************************************************************/
unsigned int AD_Testing(unsigned char ad_fd, unsigned char ad_ch, unsigned char ad_lr)
{
	// static volatile unsigned char adtimes;
	// static volatile unsigned int admin, admax, adsum;
	volatile unsigned int data;
	volatile unsigned char i = 0;

	if (!ad_lr)
		ADCON1 = 0; // 左对齐,出12位
	else
		ADCON1 = 0x80; // 右对齐,出10位

	if (ad_ch & 0x10) // 设置CHS4，此位在ADCON1寄存器中
		ADCON1 |= 0x40;

	ADCON0 = 0;
	ad_ch &= 0x0f;
	ADCON0 |= (unsigned char)(ad_fd << 6); // 不同的VDD或参考电压需要配置合理的分频
	ADCON0 |= (unsigned char)(ad_ch << 2); // 设置通道
	ADCON0 |= 0x01;						   // 使能ADC

	asm("nop");
	asm("nop");
	GODONE = 1; // 开始转换

	while (GODONE)
	{
		asm("nop");
		asm("nop");
		if ((--i) == 0) // ad等待限时，防止出现死循环，但要考虑转换时间不能长于此时间
			return 0;
	}

	if (!ad_lr) // 左对齐
	{
		data = (unsigned int)(ADRESH << 4);
		data |= (unsigned int)(ADRESL >> 4);
	}
	else // 右对齐
	{
		data = (unsigned int)(ADRESH << 8);
		data |= (unsigned int)ADRESL;
	}

	return data;
}

/***********************************************
函数名称：Set_Usart_Async
函数功能：Usart状态设置（异步）
入口参数：无
出口参数：无
备注：
1、串口通讯，设置波特率寄存器时，应控制在19200及以下，实际应用时应考虑到芯片内振的电压及温度特性。
2、SYNC = 0;目标波特率 = Fosc/(16*(SPBRG+1))
************************************************/
void Set_Usart_Async()
{
	BRGHEN1 = 1;
	BRG16EN1 = 0; //设置BRG是一个8位定时器

	SPBRGH1 = 0;
	SPBRG1 = 51; //设置波特率为9600 bps (8M/(16*52))

//	SPBRG = 25; /* 19200bps, 8M/(16*26) */

	SYNC1 = 0; // 0为异步模式，1为同步模式
	SCKP1 = 0; // 直接将数据字符发送到TX/CK引脚

	SPEN1 = 1;  // 允许串口操作
	RC1IE = 1;  // 接收中断  //暂时关闭
	TX1IE = 0;  // 发送中断
	RX9EN1 = 0; // 0为8位接收，1为9位接收
	TX9EN1 = 0; // 0为8位发送，1为9位发送
	CREN1 = 1;  // 0为禁止接收，1为使能接收 //暂时关闭
	TXEN1 = 1;  // 0为禁止发送，1为使能发送
}

/************************************************************
函数名称：Uart_Send_NByte()
函数功能：串口多字节发送函数
入口参数：n 待发送字节数量
		  nSendByte 待发送数组
出口参数：
备    注：
************************************************************/
// void Uart_Send_NByte(uint8_t n, uint8_t *nSendByte)
// {
// 	uint8_t i;
// 	for(i = 0; i < n; i++)
// 	{
// 		TX_Buf[i] = nSendByte[i];
// 	}
// 	tx_index = n;
// 	TXIE = 1;
// }

/************************************************************
函数名称：Init_PA_Isr()
函数功能：PA中断初始化函数
入口参数：
出口参数：
备    注：
************************************************************/
// void Init_PA_Isr()
// {
// 	IOCA = 0B01100110; // 允许RA1的IO口电平变化中断
// 	RACIE = 1;		   // 使能PORTA电平变化中断
// 	PORTA;			   // 读取PORTA并锁存
// }

/************************************************************
函数名称：Init_PB_Isr()
函数功能：PB中断初始化函数
入口参数：
出口参数：
备    注：
************************************************************/
// void Init_PB_Isr()
// {
// 	IOCB = 0B00000001; // 允许RB0的IO口电平变化中断
// 	RBIE = 1;		   // 使能PORTB电平变化中断
// 	// INTCON = 0x88;			//允许所有未被屏蔽的中断、禁止外设中断，使能PORTB电平变化中断
// 	PORTB;			   // 读取PORTB并锁存
// }

/************************************************************
函数名称：mainr()
函数功能：主循环
入口参数：
出口参数：
备    注：
************************************************************/
void main(void)
{
	/******************************************************************/
	asm("nop");
	asm("clrwdt");
	INTCON = 0;		 //禁止中断

	Init_GPIO();	// 初始化GPIO
	Init_IC();		// 相关寄存器初始化
	Delay_nms(200); // 上电延时200ms 非精准延时
	Init_TIMER1();	// 定时器1初始化
	Init_TIMER2();	// 定时器2初始化
//	Init_PA_Isr();		 //PA中断初始化函数
//	Init_PB_Isr();		 //PB中断初始化函数
// #if FCT
// 	/* FCT串口不初始化，TX、RX作为普通端口使用 */
// #else
// 	Set_Usart_Async(); // 串口初始化
// #endif

	//	Set_CCP_PWM();		 //PWM初始化

	INTCON = 0XC0;	   // 允许所有未被屏蔽的中断、外设中断

	// RemoFlash_Read();  /* 读取存储的数值 */
	while (1)
	{
		/*主循环10ms*/
		if (F1ms == SET)
		{
			CLRWDT(); /*清看门狗*/
			F1ms = CLR;
			switch (SEQmain)
			{
#if FCT_TEST
				case 0:
					FCTloop();
					break;
#else
				case 0:
					GsensorLoop();
					break;
				case 1:

					break;
				case 2:

					break;
				case 3:

					break;
				case 4:
					GflushLoop();
					break;
				case 5:

					break;
				case 6:

					break;
				case 7:

					break;
				case 8:
					GledLoop();
				break;
				case 9:

					break;
#endif
				default:
					// SEQmain = 0;
					break;
			}
			if (++SEQmain >= 10)
			{
				SEQmain = 0;
			}
		}
	}
}

// /***********************************************************************
// 函数功能：中断入口函数
// RISC内核无中断优先级，不可嵌套
// ***********************************************************************/
void interrupt Int_ALL(void)
{
	// 1ms定时器中断服务函数
	if (TMR1IF)
	{
		// ---------------------------------------
		// TMR1L += 0xC0;
		// TMR1H += 0xF9; //重新赋初值，在赋值前Timer1已有计数，故在该基础上加初值
		// 在进入中断等过程中其实Time是一直在计数的
		// ---------------------------------------
		TMR1 = TIMER1_TIME;
		TMR1IF = 0; // 清中断标志位

		/* 主循环1ms标志位 */
		F1ms = 1;

		/* 1s标志位 */
		if (++MainTime_1s >= 1000)
		{
			MainTime_1s = 0;
			Fsys1s.byte = 0xFF; /* 1s' flag */
// #if (VER_2510M || VER_2510U)
// 			if (++MainTime_1min >= 60) /* 1min标识位 */
// 			{
// 				MainTime_1min = 0;
// 				Fsys1m.byte = 0xFF; /* 1min' flag */
// 			}
// #endif
		}
	}

	// 50us定时器中断服务函数
	if (TMR2IF)
	{
		TMR2IF = 0; /*	8位，自重载，无需二次配置	*/
		INT_LED_SHOW(); /* 氛围灯中断函数 */
	}

// #if FCT
// 	/* FCT停止uart通讯中断服务 */
// #else
// 	// 串口接收中断服务函数
// 	if (RC1IF)
// 	{
// 		//-------------------------------------------
// 		// 接收控制，如果接收标志位为1，说明有数据接收完毕
// 		// RCIF在寄存器被读出后自动清零
// 		if (FERR1)
// 		{
// 			RCREG1; // 帧错误
// 			return;
// 		}

// 		RX_Buf = RCREG1; // 将接收缓冲区内容读出

// 		Uart_ReceiveLogic(); /* UART*/

// 		if (OERR1) // 如果有溢出错误
// 		{
// 			CREN1 = 0; // 清零CREN1位可将OERR位清零
// 			CREN1 = 1; // 再次将CREN1置一，以允许继续接收
// 		}
// 	}

// 	// 串口发送中断服务函数
// 	if (TX1IF && TX1IE)
// 	{
// 		// 发送控制
// 		if (TRMT1)
// 		{
// 			Uart_SendLogic();
// 			// TXREG = TX_Buf[tx_cnt];
// 			// tx_cnt++;
// 			// if(tx_cnt >= tx_index)
// 			// {
// 			// 	tx_cnt = 0;
// 			// 	TXIE = 0;
// 			// }
// 		}
// 	}
// #endif
	// PA中断服务函数，IO口电平变化就会进入中断，上升或下降沿类型需要自行进行应用判断
	// if(RACIF)
	// {
	// 	PORTA;		 //读取PORTA状态
	// 	RACIF = 0; //清中断标志
	// }

	// PB中断服务函数，IO口电平变化就会进入中断，上升或下降沿类型需要自行进行应用判断
	// if(RBIF)
	// {
	// 	PORTB;		//读取PORTB状态
	// 	RBIF = 0; //清中断标志
	// }
}

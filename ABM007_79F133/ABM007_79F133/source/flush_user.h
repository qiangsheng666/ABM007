#ifndef __FLUSH_USER_H__
#define __FLUSH_USER_H__

extern volatile BYTE Fflush1;
#define YKfls_Big		Fflush1.bits.bit_0
#define OKfls_Big		Fflush1.bits.bit_1
#define YKfls_Sml		Fflush1.bits.bit_2
#define OKfls_Sml		Fflush1.bits.bit_3
#define FbufFlush       Fflush1.bits.bit_4  /* 冲水确认缓存标识 */
#define f_STSflush		Fflush1.bits.bit_6
#define Flush_AutoLeaveWait Fflush1.bits.bit_7  /* 离开自动冲水标识 */

extern void GflushLoop(void);

#endif

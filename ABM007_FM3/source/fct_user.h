#ifndef __FCT_USER_H__
#define __FCT_USER_H__

extern BYTE fctBits001;

#define FfctTest    fctBits001.bits.bit_0
#define bufFcttest  fctBits001.bits.bit_1

uint16_t My_test_time = 100;
uint16_t My_test_cnt;

extern void FCTloop(void);

#endif
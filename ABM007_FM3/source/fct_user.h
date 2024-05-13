#ifndef __FCT_USER_H__
#define __FCT_USER_H__

extern BYTE fctBits001;

#define FfctTest    fctBits001.bits.bit_0
#define bufFcttest  fctBits001.bits.bit_1

extern void FCTloop(void);

#endif
#ifndef __LIGHT_USER_H__
#define __LIGHT_USER_H__

extern volatile BYTE FledBits01;
#define	Flight      FledBits01.bits.bit_0
#define	Fbuflight   FledBits01.bits.bit_1
#define	FlightLeave FledBits01.bits.bit_2
#define FbreathDir  FledBits01.bits.bit_3

extern void GledLoop(void);

#endif
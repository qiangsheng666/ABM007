#ifndef __SENSOR_USER_H__
#define __SENSOR_USER_H__

extern volatile BYTE Fbodysensor;

#define Fbody       Fbodysensor.bits.bit_0  /* 人体感应标识 */
#define FbodyEnter  Fbodysensor.bits.bit_1  /* 感应到有人瞬间标识 */
#define FbodyExit   Fbodysensor.bits.bit_2  /* 感应到人离开瞬间标识 */
#define FbodyIn60s  Fbodysensor.bits.bit_3  /* 感应到人60s标识 */
#define FbodyIn5s   Fbodysensor.bits.bit_4  /* 感应到人5s标识 */
#define FbodyEx5s   Fbodysensor.bits.bit_5  /* 感应到人离开5秒标识 */
#define Fbufbody    Fbodysensor.bits.bit_6  /* 人体感应缓存标识 */

/* 状态确认时间 */
#define BODY_ENTER_KEEP_60S     6000  /* 感应到人60s */
#define BODY_ENTER_KEEP_5S      500   /* 感应到人5s */
#define BODY_EXIT_KEEP_5S       500   /* 感应到人离开5s */

/* 信号确认时间参数 */
#define SENSOR_TRG                  3       /* 确认信号 */
#define SENSOR_ERROR                6      /* 错误信号 */
#define SENSOR_BODY_ENTER_X_0S      30 /* 传感器感应到有人持续?*10ms */
#define SENSOR_BODY_EXIT_X_0S       500 /* 传感器没有感应到有人持续?*10ms */

extern void GsensorLoop(void);

#endif
#ifndef __SENSOR_USER_H__
#define __SENSOR_USER_H__

extern volatile BYTE Fbodysensor;

#define Fbody       Fbodysensor.bits.bit_0  /* �����Ӧ��ʶ */
#define FbodyEnter  Fbodysensor.bits.bit_1  /* ��Ӧ������˲���ʶ */
#define FbodyExit   Fbodysensor.bits.bit_2  /* ��Ӧ�����뿪˲���ʶ */
#define FbodyIn60s  Fbodysensor.bits.bit_3  /* ��Ӧ����60s��ʶ */
#define FbodyIn5s   Fbodysensor.bits.bit_4  /* ��Ӧ����5s��ʶ */
#define FbodyEx5s   Fbodysensor.bits.bit_5  /* ��Ӧ�����뿪5���ʶ */
#define Fbufbody    Fbodysensor.bits.bit_6  /* �����Ӧ�����ʶ */

/* ״̬ȷ��ʱ�� */
#define BODY_ENTER_KEEP_60S     6000  /* ��Ӧ����60s */
#define BODY_ENTER_KEEP_5S      500   /* ��Ӧ����5s */
#define BODY_EXIT_KEEP_5S       500   /* ��Ӧ�����뿪5s */

/* �ź�ȷ��ʱ����� */
#define SENSOR_TRG                  3       /* ȷ���ź� */
#define SENSOR_ERROR                6      /* �����ź� */
#define SENSOR_BODY_ENTER_X_0S      30 /* ��������Ӧ�����˳���?*10ms */
#define SENSOR_BODY_EXIT_X_0S       500 /* ������û�и�Ӧ�����˳���?*10ms */

extern void GsensorLoop(void);

#endif
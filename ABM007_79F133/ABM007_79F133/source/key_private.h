#ifndef __KEY_PRIVATE_H__
#define __KEY_PRIVATE_H__

volatile uint8_t CurrentIO;
typedef enum _SignalLines{
    PortA,  
    PortB,  
}SignalLines;
volatile SignalLines SeletedLine;


#define CNTKeyTime    10  //100ms
#define CNTKeyOutTime 600 //1min


#define key_KEEP_100ms             10  /* ��������ʱ��Ϊ100ms */
#define key_RELEASE_100ms      10   /* �����ɿ�ʱ��Ϊ100ms */


typedef struct _KEY_PRIVATE
{
   struct 
   {
    unsigned char   is_forbidden : 1;
    unsigned char   is_pressing : 1;
    unsigned char   level : 1;
    unsigned char    : 1;

    unsigned char    : 1;
    unsigned char    : 1;
    unsigned char    : 1;
    unsigned char    : 1;
   }flags;
   uint8_t cnt;
   uint16_t cnt_timeout;  //��ʱʱ��
}KEY_PRIVATE;

volatile KEY_PRIVATE KeyLines[2];



// uint8_t KeyScan(uint8_t i);
uint8_t GkeyLoop();
uint8_t ScanKey(SignalLines line_num) ;
uint8_t KeyControl(KEY_PRIVATE* this);
#endif





	
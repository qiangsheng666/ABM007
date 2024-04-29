#ifndef __KEY_PRIVATE_H__
#define __KEY_PRIVATE_H__

volatile uint8_t CurrentIO;
typedef enum _SignalLines{
    PortA,  
    PortB,  
}SignalLines;
volatile SignalLines SeletedLine;

volatile uint8_t current_IO_Trgging[2];
volatile uint8_t last_IO_value[2];
volatile uint8_t key_flag;
#endif
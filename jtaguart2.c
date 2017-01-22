#define JTAG_UART_DATA ((volatile int*) 0x10001000)
#define JTAG_UART_CONTROL ((volatile int*) (0x10001000+4))

int main()
{
    unsigned char hwld[] = {'H','e','l','l','o',' ','W','o','r','l','d','\0'};
    unsigned char *pOutput;

    pOutput = hwld;
    while(*pOutput) //strings in C are zero terminated
    {
         //if room in output buffer
         if((*JTAG_UART_CONTROL)&0xffff0000  ) 
         {
            //then write the next character
            *JTAG_UART_DATA = (*pOutput++); 
         }
     }
}
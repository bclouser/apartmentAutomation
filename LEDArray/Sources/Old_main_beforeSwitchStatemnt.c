 

#include <hidef.h>      /* common defines and macros */
#include <mc9s12dg256.h>     /* derivative information */
#pragma LINK_INFO DERIVATIVE "mc9s12dg256b"
#include "main_asm.h" /*interface to the assembly module*/

void ms_delay(unsigned int);
void lightLed(int, int);
void dispCheckerBoard(void);
void dispGhost(void);
void dispmovingGhost(void);


  void lightLed(row, column){    // This will clear PORTS B and T and then light up the specified LED
  PORTB = 0x00; //just in case
  PTM = 0x00;   //just in case
  

  if(led == 1){
    PORTB = 0b00000001;
    PTM = 0b11111111;
  }
    
    
  else if(led == 2)
  {
    PORTB = 0b00000010;
    PTM = 0b11111111;
  }
  else if(row ==3) 
  {
    
    PORTB = 0b00000100;
    PTM = 0b11111111;
  }
  else if(row == 4) 
  {
    PORTB = 0b00001000;
    PTM = 0b11111111;
  }
  else if(row == 5)
  {
     PORTB = 0b00010000;
     PTM = 0b00010000; 
  }
    
  else if(row == 6)
  {
    PORTB = 0b00100000;
    PTM = 0b00100000;
  }
    
  else if(row == 7)
  {
     PORTB = 0b01000000;
     PTM = 0b01000000;
  }
    
  else if(row == 8)
  {
     PORTB = 0b10000000; 
     PTM = 0b10000000; 
  }
    

  if(column == 1)             // the specific combinations of each Column
    PTM = 0b11111110;
  else if(column == 2)
    PTM = 0b11111101;
  else if(column ==3)
    PTM = 0b11111011;
  else if(column == 4)
    PTM = 0b11110111;
  else if(column == 5)
    PTM = 0b11101111;
  else if(column == 6)
    PTM = 0b11011111;
  else if(column == 7)
    PTM = 0b10111111;
  else if(column == 8)
    PTM = 0b01111111; 
  
  //ms_delay(50);   // give time for LED to actually ignite before moving onto the next led
}

void dispCheckerBoard(void) {
  lightLed(1,1);
  lightLed(1,3);
  lightLed(1,5);
  lightLed(1,7);
  lightLed(2,2);
  lightLed(2,4);
  lightLed(2,6);
  lightLed(2,8);
  lightLed(3,1);
  lightLed(3,3);
  lightLed(3,5);
  lightLed(3,7);
  lightLed(4,2);
  lightLed(4,4);
  lightLed(4,6);
  lightLed(4,8);
  lightLed(5,1);
  lightLed(5,3);
  lightLed(5,5);
  lightLed(5,7);
  lightLed(6,2);
  lightLed(6,4);
  lightLed(6,6);
  lightLed(6,8);
  lightLed(7,1);
  lightLed(7,3);
  lightLed(7,5);
  lightLed(7,7);
  lightLed(8,2);
  lightLed(8,4);
  lightLed(8,6);
  lightLed(8,8);   
}

void dispGhost(void)
{
      
}
 void ms_delay(unsigned int itime)
  {
    unsigned int i; unsigned int j;
    for(i=0;i<itime;i++)
      for(j=0;j<325;j++);    //1 msec. tested using Scope
  }


void main(void) 
{
  
  int animation = 0;
  int checkerBoard = 1;
  int ghost = 2;
  int movingGhost = 3;

  /* put your own code here */
 
    //PLL_init(); //set system clock to 24 MHz
        
    DDRB = 0xFF;    //PORTB7-PORTB4 as output since LEDs are connected to it, 
    
    DDRM = 0xFF;    //PORTM is an output
    
    DDRA = 0b11110000;    //PORTA is half input half output
    
    DDRP = 0xFF;
    DDRJ = 0xFF;
    
    PTJ = 0x00;    //disable 7 segment display
    PTP = 0xFF;
    PTM = 0x00;   // enable PORTM
    PORTA = 0x00;  // enable PORTA
 	
    PORTB = 0x55;    //Toggle upper 4-bit of PORTB
    
    while(1)    //infinite loop, this will house the function calls of the main loop
    {
      PORTA = 0b11110000;
      PORTB = PORTA;
       
      if(PORTA & 0b00001111)
      {
        
        
        if(PORTA == 0b11110001)
          animation = checkerBoard;
         
        else if(PORTA == 0b11110010)
          animation = ghost;
        
        else if(PORTA == 0b11110100)
          animation = movingGhost;
        
        else if(PORTA == 0b11111000)
          animation = 4;
            
      }
      else
        PORTB = 0;    // just to do something
      
      
      /*calls the display function based on the button pressed*/ 
    
      if(animation == checkerBoard && animation !=0)    
      {
        dispCheckerBoard();
      }
      
      if(animation == ghost && animation != 0)
      {
        dispGhost();
      }
     
    }
}


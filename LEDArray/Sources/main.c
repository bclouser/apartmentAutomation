 

#include <hidef.h>      /* common defines and macros */
#include <mc9s12dg256.h>     /* derivative information */
#pragma LINK_INFO DERIVATIVE "mc9s12dg256b"
#include "main_asm.h" /*interface to the assembly module*/

void ms_delay(unsigned int);
void lightLed(int, int);		

			/*These variables are the moveGhost Function that i did not get to finish*/
//int stepLed;						
//int moveGhostRate = 2000; // the slower the faster it will move


			/* These are the display functions available from buttons on port A */
void dispCheckerBoard(void); // row 1 button 1 
void dispGhost(void);        // row 1 button 2
void dispfullBrick(void);    // row 1 button 3
void dispCornerOut(void);    // row 1 button 4
void dispInvCornerOut(void); // row 2 button 1
void dispLoopFlush(void);    // row 2 button 2this links both flush functions together       
void dispGhostMove(void);    // row 2 button 3



/* THIS IS THE ROOT FUNCTION, IT LIGHTS LEDS BASED ON THE "ROW" AND "COLUMN' VARIABLES SENT TO IT*/
 
void lightLed(row, column){    
  
  PORTB = 0x00;
  PTM = 0x00;
  PTH = 0b00111111; 
  
  if(row == 1)                   // ROW is 1
  {
    
    if(column == 1)              
    {
      PORTB = 0b00000001;
      PTM = 0b11111110;  
    }
    else if(column == 2) 
    {
      PORTB = 0b00000001;
      PTM = 0b11111101;    
    }
    else if(column == 3)
    {
      PORTB = 0b00000001;
      PTM = 0b11111011;   
    }
    else if(column == 4) 
    {
      PORTB = 0b00000001;
      PTM = 0b11110111;    
    }
    else if(column == 5)
    {
      PORTB = 0b00000001;
      PTM = 0b11101111;   
    }
    else if(column == 6) 
    {
      PORTB = 0b00000001;
      PTM = 0b11011111;    
    }
    else if(column == 7)
    {
      PORTB = 0b00000001;
      PTM = 0b10111111;   
    }
    else if(column == 8) 
    {
      PORTB = 0b00000001;
      PTM = 0b01111111;    
    }
    else if(column == 9)
    {
      PORTB = 0b00000001;
      PTM = 0xFF;
      PTH = 0b00011111;   
    }
    else if(column == 10) 
    {
      PORTB = 0b00000001;
      PTM = 0xFF;
      PTH = 0b00101111;  
    }
  }
  
  else if(row == 2)                      //ROW is 2
  {
    
    if(column == 1) 
    {
     PORTB = 0b00000010;
     PTM = 0b11111110;    
    }
    else if(column == 2) 
    {
     PORTB = 0b00000010;
     PTM = 0b11111101;     
    }
    else if(column == 3)
    {
      PORTB = 0b00000010;
      PTM = 0b11111011;    
    }
    else if(column == 4) 
    {
      PORTB = 0b00000010;
      PTM = 0b11110111;    
    }
    else if(column == 5)
    {
      PORTB = 0b00000010;
      PTM = 0b11101111;      
    }
    else if(column == 6) 
    {
      PORTB = 0b00000010;
      PTM = 0b11011111;    
    }
    else if(column == 7)
    {
      PORTB = 0b00000010;
      PTM = 0b10111111;     
    }
    else if(column == 8) 
    {
      PORTB = 0b00000010;
      PTM = 0b01111111;    
    }
    else if(column == 9)
    {
      PORTB = 0b00000010;
      PTM = 0xFF;
      PTH = 0b00011111;   
    }
    else if(column == 10) 
    {
      PORTB = 0b00000010;
      PTM = 0xFF;
      PTH = 0b00101111;  
    }
  }
  
  else if(row == 3)                   //ROW is 3
  {
    
    if(column == 1) 
    {
      PORTB = 0b00000100;
      PTM = 0b11111110;   
    }
    else if(column == 2) 
    {
     PORTB = 0b00000100;
     PTM = 0b11111101;    
    }
    else if(column == 3)
    {
      PORTB = 0b00000100;
      PTM = 0b11111011;    
    }
    else if(column == 4) 
    {
      PORTB = 0b00000100;
      PTM = 0b11110111;    
    }
    else if(column == 5)
    {
      PORTB = 0b00000100;
      PTM = 0b11101111;       
    }
    else if(column == 6) 
    {
      PORTB = 0b00000100;
      PTM = 0b11011111;    
    }
    else if(column == 7)
    {
      PORTB = 0b00000100;
      PTM = 0b10111111;     
    }
    else if(column == 8) 
    {
      PORTB = 0b00000100;
      PTM = 0b01111111;    
    }
    else if(column == 9)
    {
      PORTB = 0b00000100;
      PTM = 0xFF;
      PTH = 0b00011111;   
    }
    else if(column == 10) 
    {
      PORTB = 0b00000100;
      PTM = 0xFF;
      PTH = 0b00101111;  
    }
  }
    
  else if(row == 4)               //ROW is 4
  {
    
    if(column == 1) 
    {
      PORTB = 0b00001000;
      PTM = 0b11111110;   
    }
    else if(column == 2) 
    {
      PORTB = 0b00001000;
      PTM = 0b11111101;    
    }
    else if(column == 3)
    {
      PORTB = 0b00001000;
      PTM = 0b11111011; 
    }
    else if(column == 4) 
    {
      PORTB = 0b00001000;
      PTM = 0b11110111; 
    }
    else if(column == 5)
    {
      PORTB = 0b00001000;
      PTM = 0b11101111;   
    }
    else if(column == 6) 
    {
      PORTB = 0b00001000;
      PTM = 0b11011111; 
    }
    else if(column == 7)
    {
      PORTB = 0b00001000;
      PTM = 0b10111111;  
    }
    else if(column == 8) 
    {
      PORTB = 0b00001000;
      PTM = 0b01111111; 
    }
    else if(column == 9)
    {
      PORTB = 0b00001000;
      PTM = 0xFF;
      PTH = 0b00011111;   
    }
    else if(column == 10) 
    {
      PORTB = 0b00001000;
      PTM = 0xFF;
      PTH = 0b00101111;  
    }
  }
  
  else if(row == 5)               //ROW is 5
  {
    
    if(column == 1) 
    {
      PORTB = 0b00010000; 
      PTM = 0b11111110;
    }
    else if(column == 2) 
    {
      PORTB = 0b00010000; 
      PTM = 0b11111101;
    }
    else if(column == 3)
    {
      PORTB = 0b00010000; 
      PTM = 0b11111011; 
    }
    else if(column == 4) 
    {
      PORTB = 0b00010000; 
      PTM = 0b11110111; 
    }
    else if(column == 5)
    {
      PORTB = 0b00010000; 
      PTM = 0b11101111;  
    }
    else if(column == 6) 
    {
      PORTB = 0b00010000; 
      PTM = 0b11011111; 
    }
    else if(column == 7)
    {
      PORTB = 0b00010000; 
      PTM = 0b10111111; 
    }
    else if(column == 8) 
    {
      PORTB = 0b00010000; 
      PTM = 0b01111111;  
    }
    else if(column == 9)
    {
      PORTB = 0b00010000;
      PTM = 0xFF;
      PTH = 0b00011111;   
    }
    else if(column == 10) 
    {
      PORTB = 0b00010000;
      PTM = 0xFF;
      PTH = 0b00101111;  
    }
  }
  
  else if(row == 6)               //ROW is 6
  {
    
    if(column == 1) 
    {
      PORTB = 0b00100000;
      PTM = 0b11111110;
    }
    else if(column == 2) 
    {
      PORTB = 0b00100000;
      PTM = 0b11111101; 
    }
    else if(column == 3)
    {
      PORTB = 0b00100000;
      PTM = 0b11111011;  
    }
    else if(column == 4) 
    {
      PORTB = 0b00100000;
      PTM = 0b11110111;  
    }
    else if(column == 5)
    {
      PORTB = 0b00100000;
      PTM = 0b11101111;    
    }
    else if(column == 6) 
    {
      PORTB = 0b00100000;
      PTM = 0b11011111;  
    }
    else if(column == 7)
    {
      PORTB = 0b00100000;
      PTM = 0b10111111;   
    }
    else if(column == 8) 
    {
      PORTB = 0b00100000;
      PTM = 0b01111111;  
    }
    else if(column == 9)
    {
      PORTB = 0b00100000;
      PTM = 0xFF;
      PTH = 0b00011111;   
    }
    else if(column == 10) 
    {
      PORTB = 0b00100000;
      PTM = 0xFF;
      PTH = 0b00101111;  
    }
  }
  
  else if(row == 7)               //ROW is 7
  {
    
    if(column == 1) 
    {
      PORTB = 0b01000000;
      PTM = 0b11111110; 
    }
    else if(column == 2) 
    {
      PORTB = 0b01000000;
      PTM = 0b11111101;    
    }
    else if(column == 3)
    {
      PORTB = 0b01000000;
      PTM = 0b11111011;    
    }
    else if(column == 4) 
    {
      PORTB = 0b01000000;
      PTM = 0b11110111;    
    }
    else if(column == 5)
    {
      PORTB = 0b01000000;
      PTM = 0b11101111;      
    }
    else if(column == 6) 
    {
      PORTB = 0b01000000;
      PTM = 0b11011111;    
    }
    else if(column == 7)
    {
      PORTB = 0b01000000;
      PTM = 0b10111111;     
    }
    else if(column == 8) 
    {
      PORTB = 0b01000000;
      PTM = 0b01111111;    
    }
    else if(column == 9)
    {
      PORTB = 0b01000000;
      PTM = 0xFF;
      PTH = 0b00011111;   
    }
    else if(column == 10) 
    {
      PORTB = 0b01000000;
      PTM = 0xFF;
      PTH = 0b00101111;  
    }
  }
  
  else if(row == 8)               //ROW is 8
  {
    
    if(column == 1) 
    {
      PORTB = 0b10000000;
      PTM = 0b11111110;  
    }
    else if(column == 2) 
    {
      PORTB = 0b10000000;
      PTM = 0b11111101;      
    }
    else if(column == 3)
    {
      PORTB = 0b10000000;
      PTM = 0b11111011;      
    }
    else if(column == 4) 
    {
      PORTB = 0b10000000;
      PTM = 0b11110111;      
    }
    else if(column == 5)
    {
      PORTB = 0b10000000;
      PTM = 0b11101111;        
    }
    else if(column == 6) 
    {
      PORTB = 0b10000000;
      PTM = 0b11011111;      
    }
    else if(column == 7)
    {
      PORTB = 0b10000000;
      PTM = 0b10111111;       
    }
    else if(column == 8) 
    {
      PORTB = 0b10000000;
      PTM = 0b01111111;      
    }
    else if(column == 9)
    {
      PORTB = 0b10000000;
      PTM = 0xFF;
      PTH = 0b00011111;   
    }
    else if(column == 10) 
    {
      PORTB = 0b10000000;
      PTM = 0xFF;
      PTH = 0b00101111;  
    }
  }
  
  else if(row == 9)               //ROW is 9
  {
    if(column == 1) 
    {
      PTH = 0b10111111;
      PTM = 0b11111110;  
    }
    else if(column == 2) 
    { 
      PTH = 0b10111111;
      PTM = 0b11111101;    
    }
    else if(column == 3)
    {
      PTH = 0b10111111;
      PTM = 0b11111011;     
    }
    else if(column == 4) 
    {
      PTH = 0b10111111;
      PTM = 0b11110111;       
    }
    else if(column == 5)
    {
      PTH = 0b10111111;
      PTM = 0b11101111;       
    }
    else if(column == 6) 
    {
      PTH = 0b10111111;
      PTM = 0b11011111;     
    }
    else if(column == 7)
    {
      PTH = 0b10111111;
      PTM = 0b10111111;    
    }
    else if(column == 8) 
    {
      PTH = 0b10111111;
      PTM = 0b01111111;    
    }
    else if(column == 9)
    {
      
      PTH = 0b10011111;
      PTM = 0xFF;
           
    }
    else if(column == 10) 
    {
      PTH = 0b10101111;
      PTM = 0xFF;    
    } 
     
  }
      
  else if(row == 10)               //ROW is 9
  {
    if(column == 1) 
    {
      PTH = 0b01111111;
      PTM = 0b11111110;  
    }
    else if(column == 2) 
    { 
      PTH = 0b01111111;
      PTM = 0b11111101;    
    }
    else if(column == 3)
    {
      PTH = 0b01111111;
      PTM = 0b11111011;     
    }
    else if(column == 4) 
    {
      PTH = 0b01111111;
      PTM = 0b11110111;       
    }
    else if(column == 5)
    {
      PTH = 0b01111111;
      PTM = 0b11101111;       
    }
    else if(column == 6) 
    {
      PTH = 0b01111111;
      PTM = 0b11011111;     
    }
    else if(column == 7)
    {
      PTH = 0b01111111;
      PTM = 0b10111111;    
    }
    else if(column == 8) 
    {
      PTH = 0b01111111;
      PTM = 0b01111111;    
    }
    else if(column == 9)
    {
      PTH = 0b01011111;
      PTM = 0xFF;      
    }
    else if(column == 10) 
    {
      PTH = 0b01101111;
      PTM = 0xFF;    
    } 
     
  }
   
  ms_delay(3);   // give time for LED to actually ignite before moving onto the next led
}


/* HERE WE GO!!! THIS IS THE DISPLAY FUNCTION FOR THE CHECKBOARD PATTERN*/
void dispCheckerBoard(void) {   // button 1
  lightLed(1,1);
  lightLed(1,3);        //row 1
  lightLed(1,5);
  lightLed(1,7);
  lightLed(1,9);
  
  lightLed(2,2);
  lightLed(2,4);
  lightLed(2,6);         //row 2
  lightLed(2,8);
  lightLed(2,10);
  
  lightLed(3,1);
  lightLed(3,3);         //row 3
  lightLed(3,5);
  lightLed(3,7);
  lightLed(3,9);
  
  lightLed(4,2);
  lightLed(4,4);        //row 4
  lightLed(4,6);
  lightLed(4,8);
  lightLed(4,10);
  
  lightLed(5,1);
  lightLed(5,3);        //row 5
  lightLed(5,5);
  lightLed(5,7);
  lightLed(5,9);
  
  lightLed(6,2);
  lightLed(6,4);
  lightLed(6,6);        //row 6
  lightLed(6,8);
  lightLed(6,10);
  
  lightLed(7,1);
  lightLed(7,3);
  lightLed(7,5);       //row 7
  lightLed(7,7);
  lightLed(7,9);
  
  lightLed(8,2);
  lightLed(8,4);
  lightLed(8,6);      // row 8
  lightLed(8,8);
  lightLed(8,10);
  
  lightLed(9,1);
  lightLed(9,3);
  lightLed(9,5);      // row 9
  lightLed(9,7);
  lightLed(9,9);   
  
  lightLed(10,2);
  lightLed(10,4);
  lightLed(10,6);      // row 10
  lightLed(10,8);
  lightLed(10,10);      
}


      /*THIS IS THE DISPLAY FUNCTION FOR IGNITING ALL OF THE LEDS*/

void dispfullBrick(void)    // when button 4 is pressed
{
  PORTB = 0xFF;
  PTM = 0x00;
  PTH = 0b11001111;
  
  //ms_delay(5000);
}


      /*THIS IS THE DISPLAY FUNCTION FOR IGNITING LEDS IN PACMAN GHOST FORMATION!*/
void dispGhost(void)
{
  lightLed(1,5);
  lightLed(1,6);
  lightLed(2,4);
  lightLed(2,3);
  lightLed(2,7);
  lightLed(2,8);
  lightLed(3,2);
  lightLed(3,9);
  lightLed(4,2);
  lightLed(4,9);
  
  lightLed(5,1);
  lightLed(5,10);
  lightLed(6,1);
  lightLed(6,10);
  lightLed(7,1);
  lightLed(7,10);
  lightLed(8,1);
  lightLed(8,10);
  lightLed(9,1);
  lightLed(9,10);
  
  
  /*bottom part of the ghost, the phalanges if you will*/
  
  lightLed(10,1);
  lightLed(10,2);
  lightLed(9,3);
  lightLed(9,4);
  lightLed(10,5);
  lightLed(10,6);
  lightLed(9,7);
  lightLed(9,8);
  lightLed(10,9);
  lightLed(10,10);
  
  /* the eyes of the ghost */
  
  lightLed(4,4);  //eyes 
  lightLed(5,4);
  lightLed(5,3);
 
  lightLed(4,7);  //eyes
  lightLed(5,7);
  lightLed(5,6);       
}


                  /*THIS DISPLAYS A "FLUSH OF LEDS FROM THE TOP LEFT CORNER*/
                  
/*flushSpeed must change in length to compensate for the
                  steps in each "for loop"*/

void dispCornerOut(void)
{
   unsigned int k;
   int flushSpeed = 200;
   int endWait = 2000;
   
   for(k = 0; k < flushSpeed; k++)
   {
    lightLed(1,1); 
   }
   
   
   
   for(k = 0; k < flushSpeed; k+=2)
   {
    lightLed(1,2);
    lightLed(2,1);
   
   }
   
   for(k = 0; k < flushSpeed; k+=4)
   {
    lightLed(1,3);
    lightLed(2,2);
    lightLed(3,1);
    
   }
   
   for(k = 0; k < flushSpeed; k+=6)
   {
    lightLed(1,4);
    lightLed(2,3);
    lightLed(3,2);
    lightLed(4,1); 
   }
   
   for(k = 0; k < flushSpeed; k+=8)
   {
    lightLed(1,5);
    lightLed(2,4);
     lightLed(3,3);
     lightLed(4,2);
     lightLed(5,1); 
   }
   
   for(k = 0; k < flushSpeed; k+=10)
   {
    lightLed(1,6);
    lightLed(2,5);
    lightLed(3,4);
    lightLed(4,3);
    lightLed(5,2);
    lightLed(6,1);  
   }
   
   for(k = 0; k < flushSpeed; k+=12)
   {
    lightLed(1,7);
    lightLed(2,6);
    lightLed(3,5);
    lightLed(4,4);
    lightLed(5,3);
    lightLed(6,2);
    lightLed(7,1); 
   }
   
   for(k = 0; k < flushSpeed; k+=14)
   {
    lightLed(1,8);
    lightLed(2,7);
    lightLed(3,6);
    lightLed(4,5);
    lightLed(5,4);
    lightLed(6,3);
    lightLed(7,2);
    lightLed(8,1); 
   }
   
   for(k = 0; k < flushSpeed; k+=16)
   {
    lightLed(1,9);
    lightLed(2,8);
    lightLed(3,7);
    lightLed(4,6);
    lightLed(5,5);
    lightLed(6,4);
    lightLed(7,3);
    lightLed(8,2);
    lightLed(9,1); 
   }
   
   for(k = 0; k < flushSpeed; k+=18)
   {
    lightLed(1,10);
    lightLed(2,9);
    lightLed(3,8);
    lightLed(4,7);
    lightLed(5,6);
    lightLed(6,5);
    lightLed(7,4);
    lightLed(8,3);
    lightLed(9,2);
    lightLed(10,1);  
   }
   
   for(k = 0; k < flushSpeed; k+=16)
   {
    lightLed(2,10);
    lightLed(3,9);
    lightLed(4,8);
    lightLed(5,7);
    lightLed(6,6);
    lightLed(7,5);
    lightLed(8,4);
    lightLed(9,3);
    lightLed(10,2);
   }
   
   for(k = 0; k < flushSpeed; k+=14)
   {
    lightLed(3,10);
    lightLed(4,9);
    lightLed(5,8);
    lightLed(6,7);
    lightLed(7,6);
    lightLed(8,5);
    lightLed(9,4);
    lightLed(10,3);
   }
   
   for(k = 0; k < flushSpeed; k+=12)
   {
    lightLed(4,10);
    lightLed(5,9);
    lightLed(6,8);
    lightLed(7,7);
    lightLed(8,6);
    lightLed(9,5);
    lightLed(10,4);
   }
   
   for(k = 0; k < flushSpeed; k+=10)
   {
    lightLed(5,10);
    lightLed(6,9);
    lightLed(7,8);
    lightLed(8,7);
    lightLed(9,6);
    lightLed(10,5);
   }
   
   for(k = 0; k < flushSpeed; k+=8)
   {
    lightLed(6,10);
    lightLed(7,9);
    lightLed(8,8);
    lightLed(9,7);
    lightLed(10,6);
   }
   
   for(k = 0; k < flushSpeed; k+=6)
   {
    lightLed(7,10);
    lightLed(8,9);
    lightLed(9,8);
    lightLed(10,7);
   }
   
   for(k = 0; k < flushSpeed; k+=4)
   {
    lightLed(8,10);
    lightLed(9,9);
    lightLed(10,8);

   }
   
   for(k = 0; k < flushSpeed; k+=2)
   {
    lightLed(9,10);
    lightLed(10,9);
   }
   
   for(k = 0; k < flushSpeed; k++)
   {
    lightLed(10,10);
   }
   
   PORTB = 0x00;
   PTM = 0x00;
   PTH = 0x00;
   
   ms_delay(endWait);
}
                    /*THIS DISPLAYS A FLUSH OF LEDS FROM THE BOTTOM RIGHT CORNER*/
                    
void dispInvCornerOut()
{
  int invFlushSpeed = 200;
  unsigned int k;
  int invEndWait = 2000;
  
 for(k = 0; k < invFlushSpeed; k++)
   {
    lightLed(10,10); 
   }
   
   
   
   for(k = 0; k < invFlushSpeed; k+=2)
   {
    lightLed(10,9);
    lightLed(9,10);
   
   }
   
   for(k = 0; k < invFlushSpeed; k+=4)
   {
     lightLed(10,8);
   lightLed(9,9);
   lightLed(8,10);
    
   }
   
   for(k = 0; k < invFlushSpeed; k+=6)
   {
    lightLed(10,7);
   lightLed(9,8);
   lightLed(8,9);
   lightLed(7,10); 
   }
   
   for(k = 0; k < invFlushSpeed; k+=8)
   {
    lightLed(10,6);
   lightLed(9,7);
   lightLed(8,8);
   lightLed(7,9);
   lightLed(6,10); 
   }
   
   for(k = 0; k < invFlushSpeed; k+=10)
   {
   lightLed(10,5);
   lightLed(9,6);
   lightLed(8,7);
   lightLed(7,8);
   lightLed(6,9);
   lightLed(5,10);  
   }
   
   for(k = 0; k < invFlushSpeed; k+=12)
   {
   lightLed(10,4);
   lightLed(9,5);
   lightLed(8,6);
   lightLed(7,7);
   lightLed(6,8);
   lightLed(5,9);
   lightLed(4,10); 
   }
   
   for(k = 0; k < invFlushSpeed; k+=14)
   {
   lightLed(10,3);
   lightLed(9,4);
   lightLed(8,5);
   lightLed(7,6);
   lightLed(6,7);
   lightLed(5,8);
   lightLed(4,9);
   lightLed(3,10); 
   }
   
   for(k = 0; k < invFlushSpeed; k+=16)
   {
   lightLed(10,2);
   lightLed(9,3);
   lightLed(8,4);
   lightLed(7,5);
   lightLed(6,6);
   lightLed(5,7);
   lightLed(4,8);
   lightLed(3,9);
   lightLed(2,10); 
   }
   
   for(k = 0; k < invFlushSpeed; k+=18)
   {
    lightLed(10,1);
    lightLed(9,2);
    lightLed(8,3);
    lightLed(7,4);
    lightLed(6,5);
    lightLed(5,6);
    lightLed(4,7);
    lightLed(3,8);
    lightLed(2,9);
    lightLed(1,10);  
   }
   
   for(k = 0; k < invFlushSpeed; k+=16)
   {
    lightLed(9,1);
    lightLed(8,2);
    lightLed(7,3);
    lightLed(6,4);
    lightLed(5,5);
    lightLed(4,6);
    lightLed(3,7);
    lightLed(2,8);
    lightLed(1,9);
   }
   
   for(k = 0; k < invFlushSpeed; k+=14)
   {
    lightLed(8,1);
    lightLed(7,2);
    lightLed(6,3);
    lightLed(5,4);
    lightLed(4,5);
    lightLed(3,6);
    lightLed(2,7);
    lightLed(1,8);
   }
   
   for(k = 0; k < invFlushSpeed; k+=12)
   {
    lightLed(7,1);
    lightLed(6,2);
    lightLed(5,3);
    lightLed(4,4);
    lightLed(3,5);
    lightLed(2,6);
    lightLed(1,7);
   }
   
   for(k = 0; k < invFlushSpeed; k+=10)
   {
    lightLed(6,1);
    lightLed(5,2);
    lightLed(4,3);
    lightLed(3,4);
    lightLed(2,5);
    lightLed(1,6);
   }
   
   for(k = 0; k < invFlushSpeed; k+=8)
   {
    lightLed(5,1);
    lightLed(4,2);
    lightLed(3,3);
    lightLed(2,4);
    lightLed(1,5);
   }
   
   for(k = 0; k < invFlushSpeed; k+=6)
   {
    lightLed(4,1);
    lightLed(3,2);
    lightLed(2,3);
    lightLed(1,4);
   }
   
   for(k = 0; k < invFlushSpeed; k+=4)
   {
    lightLed(3,1);
    lightLed(2,2);
    lightLed(1,3);

   }
   
   for(k = 0; k < invFlushSpeed; k+=2)
   {
    lightLed(2,1);
    lightLed(1,2);
   }
   
   for(k = 0; k < invFlushSpeed; k++)
   {
    lightLed(1,1);
   }
   
   PORTB = 0x00;
   PTM = 0x00;
   PTH = 0x00;
   
   ms_delay(invEndWait);
   
 
}
                    /*THIS COMBINES THE FLUSH FUNCTIONS INTO AN ALTERNATING PATTERN*/
void dispLoopFlush()
{ 
 dispCornerOut();
 dispInvCornerOut();   
}


              /*THIS ANIMATION LOOPS THE GHOST MOVING TO THE RIGHT, but i didnt finish it.. sigh */
/*void dispGhostMove()
{    
  if(stepLed == 11)
    stepLed = -1;
  
  else
    stepLed ++;  

  lightLed(1,5 + stepLed);
  lightLed(1,6 + stepLed);
  lightLed(2,4 + stepLed);
  lightLed(2,3 + stepLed);
  lightLed(2,7 + stepLed);
  lightLed(2,8 + stepLed);
  lightLed(3,2 + stepLed);
  lightLed(3,9 + stepLed);
  lightLed(4,2 + stepLed);
  lightLed(4,9 + stepLed);
  
 
  
  lightLed(5,1 + stepLed);
  lightLed(5,10 + stepLed);
  lightLed(6,1 + stepLed);
  lightLed(6,10 + stepLed);
  lightLed(7,1 + stepLed);
  lightLed(7,10 + stepLed);
  lightLed(8,1 + stepLed);
  lightLed(8,10 + stepLed);
  lightLed(9,1 + stepLed);
  lightLed(9,10 + stepLed);
  
  
  /*bottom part of the ghost, the phalanges if you will*/
  
 /* lightLed(10,1 + stepLed);
  lightLed(10,2 + stepLed);
  lightLed(9,3 + stepLed);
  lightLed(9,4 + stepLed);
  lightLed(10,5 + stepLed);
  lightLed(10,6 + stepLed);
  lightLed(9,7 + stepLed);
  lightLed(9,8 + stepLed);
  lightLed(10,9 + stepLed);
  lightLed(10,10 + stepLed);
  
  /* the eyes of the ghost */
 /* 
  lightLed(4,4 + stepLed);  //eyes 
  lightLed(5,4 + stepLed);
  lightLed(5,3 + stepLed);
 
  lightLed(4,7 + stepLed);  //eyes
  lightLed(5,7 + stepLed);
  lightLed(5,6 + stepLed); 
  
  
  ms_delay(5000);
  
  //if(stepLed == 11)
   // stepLed = 0;
  
  //else
   // stepLed = stepLed + 1;
       
}

 
                          /*THIS IS THE DELAY FUNCTION*/
 void ms_delay(unsigned int itime)
  {
    unsigned int i; unsigned int j;
    for(i=0;i<itime;i++)
      for(j=0;j<325;j++);    //1 msec. tested using Scope (NOT SURE I TRUST THIS)
  }


void main(void) 
{
  
  int animation = 0;
  
  int checkerBoard = 1;
  int ghost = 2;
  int cornerOut = 3;
  int fullBrick = 4;
  int invCornerOut = 5;
  int loopFlush = 6;
  //int ghostMove = 7;
          
  int stepLed = 0;

  /* put your own code here */
 
    //PLL_init(); //set system clock to 24 MHz
        
    DDRB = 0xFF;    //PORTB7-PORTB4 as output since LEDs are connected to it, 
    
    DDRM = 0xFF;    //PORTM is an output
    DDRH = 0xFF;   //PORTH as an output
    DDRA = 0b11110000;    //PORTA is half input half output
    
    DDRP = 0xFF;
    DDRJ = 0xFF;
    
    PTJ = 0x00;    //disable 7 segment display
    PTP = 0xFF;
    PTM = 0x00;   // enable PORTM
    PORTA = 0x00;  // enable PORTA
 	  
 	  
 	  /*PORTH bits 0 and 1 are rows 9 and 10. bits 2 and 3 are columns 9 and 10 respectively*/ 	
    
    
    while(1)    //infinite loop, this will house the function calls of the main loop
    {
      PORTA = 0b11110000;
       
      if(PORTA & 0b00001111)  // a button is being pressed read from the keypad
      {
      
              /*ROW 1*/
        PORTA = 0b00010000;
        
        if(PORTA & 0b00000001)     // & is the logical operator AND
          animation = checkerBoard;
        
        else if(PORTA & 0b00000010)
          animation = ghost;
        
        else if(PORTA & 0b00000100)
          animation = cornerOut;
        
        else if(PORTA & 0b00001000)
          animation = fullBrick;
       
       
               /*ROW 2*/
         PORTA = 0b00100000;
         ms_delay(3); // give a chance for the voltage to drop on previous line 
         
         if(PORTA & 0b00000001)
           animation = invCornerOut;
         
         else if(PORTA & 0b00000010)
            animation = loopFlush;
         
        // else if (PORTA & 0b00000100)
        //    animation = ghostMove;
            
      }
      
      
      /*calls the display function based on the button pressed*/ 
    
      if(animation == checkerBoard && animation !=0)    
      {
        dispCheckerBoard(); //button 1
      }
      
      else if(animation == cornerOut && animation != 0)    
      {
        dispCornerOut();  //button 3
      }
      
      else if(animation == fullBrick && animation != 0)    
      {
        dispfullBrick();  //button 4
      }
      
      else if(animation == ghost && animation != 0)    
      {
       dispGhost();       //button 2
      }
      
      else if(animation == invCornerOut && animation != 0)
      {
        dispInvCornerOut(); // row 2 button 1
      }
      
      else if(animation == loopFlush && animation != 0)
      {
        dispLoopFlush(); // row 2 button 2
      }
      
      //else if(animation == ghostMove && animation != 0)   //this has to do with the function i didnt finish
     // {
       // dispGhostMove(); //row 2 button 3
      //}
     
    }
}


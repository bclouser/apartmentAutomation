/*
 * File:   newmain.c
 * Author: Home
 *
 * Created on March 26, 2013, 8:43 PM
 */

#include <stdio.h>
#include <stdlib.h>
#include <htc.h>

__CONFIG(FOSC_HS & WDTE_OFF &  PWRTE_OFF & CP_OFF & BOREN_OFF & WRT_OFF & LVP_OFF);


//#include <pic14/pic16f877a.h>

 #define row1 0b10000000  //PORTB
 #define row2 0b01000000  //"   "
 #define row3 0b00100000  //"   "
 #define row4 0b00010000  //"   "
 #define row5 0b00001000  //"   "
 #define row6 0b00000100  //"   "
 #define row7 0b00000010  //"   "
 #define row8 0b00000001  //"   "
 #define row9 0b10000000  //PORTD
 #define allRows 0xFF

const int column[171] = { //this will hold the dmux command for every column... it repeats every 15 members
        0,0,0,0,0,0, 0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,
        0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

        0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,
        0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

        0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,
        0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

        0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,
        0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

        0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,
        0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

        0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,
        0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

        0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,
        0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

        0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,
        0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

        0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,
        0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

        0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,
        0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

        0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,
        0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000

};

/*
 [Number of options], [Number of columns]

 NOTE: In the columns, there are two options for each column. 1st space refers to PORTB (rows 1-8).
 the 2nd option refers to PORTD (row9).

 */
const int characters[26][12] = {
        {
        // {rows 1-8, row 9}

        //A 0
        row3 + row4 + row5 + row6 + row7 + row8, row9,
        row2 + row5, 0,
        row1 + row5, 0,
        row1 + row5, 0,
        row2 + row5, 0,
        row3 + row4 + row5 + row6 + row7 + row8, row9
        },
        {
        //B 1
        allRows, row9,
        row1+row5, row9,
        row1+row5, row9,
        row1+row5, row9,
        row1+row5, row9,
        row2+row3+row4+row6+row7+row8, 0
        },
        {
        //C 2
        row2+row3+row4+row5+row6+row7+row8, 0,
        row1, row9,
        row1, row9,
        row1, row9,
        row1, row9,
        row2+row8, 0
        },
        {
        //D 3
        allRows, row9,
        row1, row9,
        row1, row9,
        row1, row9,
        row2+row8, 0,
        row3+row4+row6, 0
        },
        {
        //E 4
        allRows, row9,
        row1+row5, row9,
        row1+row5, row9,
        row1+row5, row9,
        row1, row9,
        row1, row9
        },
        {
        //F 5
        allRows, row9,
        row1+row5, 0,
        row1+row5, 0,
        row1+row5, 0,
        row1, 0,
        row1, 0
        },
        {
        //G 6
        row2+row3+row4+row6+row7, 0,
        row1, row9,
        row1, row9,
        row1+row5, row9,
        row1+row5, row9,
        row2+row5+row6+row7+row8, 0
        },
        {
        //H 7
        allRows, row9,
        row5, 0,
        row5, 0,
        row5, 0,
        row5, 0,
        allRows, row9
        },
        {
        //I 8
        row1, row9,
        row1, row9,
        allRows, row9,
        row1, row9,
        row1, row9,
        0, 0
        },
        {
        //J 9
        row1+row8, 0,
        row1, row9,
        row1, row9,
        allRows, 0,
        row1, 0,
        row1, 0
        },
        {
        //K 10
        allRows, row9,
        row5, 0,
        row5, 0,
        row4+row6, 0,
        row3+row7, 0,
        row1+row2+row8, row9
        },
        {
        //L 11
        allRows, row9,
        0, row9,
        0, row9,
        0, row9,
        0, row9,
        0, row9
        },
        {
        //M 12
        allRows, row9,
        row2+row3, 0,
        row4, 0,
        row4, 0,
        row2+row3, 0,
        allRows, row9
        },
        {
        //N 13
        allRows, row9,
        row2+row3, 0,
        row4+row5, 0,
        row6+row7, 0,
        row8, row9,
        allRows, row9
        },
        {
        //0 14
        row3+row4+row5+row6+row7, 0,
        row2+row7, 0,
        row1, row9,
        row1, row9,
        row2+row7, 0,
        row3+row4+row5+row6+row7, 0
        },
        {
        //P 15
        allRows, row9,
        row1+row5, 0,
        row1+row5, 0,
        row1+row5, 0,
        row1+row5, 0,
        row2+row3+row4, 0
        },
        {
        //Q 16
        row3+row4+row5+row6+row7, 0,
        row2+row8, 0,
        row1, row9,
        row1+row7, row9,
        row2+row8, 0,
        row3+row4+row5+row6+row7, row9
        },
        {
        //R 17
        allRows, row9,
        row1 + row5, 0,
        row1 + row5, 0,
        row1 + row5 + row6, 0,
        row1 + row5 + row7, 0,
        row4 + row3 + row2 + row8, row9
        },
        {
        //S 18
        row2+row3+row4+row8, 0,
        row1+row5, row9,
        row1+row5, row9,
        row1+row5, row9,
        row1+row5, row9,
        row2+row6+row7+row8, 0
        },
        {
        //T 19
        row1, 0,
        row1, 0,
        allRows, row9,
        row1, 0,
        row1, 0,
        0, 0
        },
        {
        //U 20
        allRows, 0,
        0, row9,
        0, row9,
        0, row9,
        0, row9,
        allRows, 0
        },
        {
        //V 21
        row1+row2+row3+row4+row5+row6, 0,
        row7+row8, 0,
        0, row9,
        0, row9,
        row7+row8, 0,
        row1+row2+row3+row4+row5+row6, 0
        },
        {
        //W 22
        allRows, 0,
        0, row9,
        row8, 0,
        row8, 0,
        0, row9,
        allRows, 0
        },
        {
        //X 23
        row1+row2+row8, row9,
        row3+row4+row6+row7, 0,
        row5, 0,
        row5, 0,
        row3+row4+row6+row7, 0,
        row1+row2+row8, row9
        },
        {
        //Y 24
        row1+row2, 0,
        row3+row4, 0,
        row5+row6+row7+row8, row9,
        row3+row4, 0,
        row1+row2, 0
        },
        {
        //Z 25
        row1+row8, row9,
        row1+row7, row9,
        row1+row5+row6, row9,
        row1+row4+row5, row9,
        row1+row3, row9,
        row1+row2, row9
        }
};

int index = 0x00;



void init_ports(){
        PORTA = 0x00;
    TRISA = 0x00;
    PORTB = 0x00;
    TRISB = 0x00;      // data direction control, 0 for output 1 for input
    PORTC = 0x00;
    TRISC = 0x00;
    PORTD = 0x00;
    TRISD = 0x00;
}

void display(int charNum, signed int start){  //ignites a capital R starting at column specified by "start"

        int i = 0x00;
        PORTB = 0x00;
        PORTC = 0x00;
        PORTD = 0x00;
        PORTA = 0x00;

/************************* REFERENCE COLUMN 1 **************************/

        if((start < 21)){
           PORTC = column[start];  //holds address of PORTD, columns 0-7
           PORTD |= 0b01000000;   //control line for DMUX 1
           PORTA = 0x00;

        }
        else if (start < 36){
                PORTC = column[start];  //columns 7-13
                PORTD |= 0b00100000;
                PORTA = 0x00;

        }

        else if (start < 51){
                PORTC = column[start];  //columns 30-45
                PORTD |= 0b00010000;
                PORTA = 0x00;
        }
        else if (start < 66){
                PORTC = column[start];  //columns 45-60
                PORTD |= 0b00001000;
                PORTA = 0x00;
        }
        else{
                PORTC = 0x00;
        }
        start++;
        PORTB = characters[charNum][0];
        PORTD |= characters[charNum][1];
        for(i=0; i<20; i++){;}  //homebrew delay
        PORTA = 0x00;
        PORTB = 0x00;
        PORTC = 0x00;
        PORTD = 0x00;
        PORTE = 0x00;



/************************* REFERENCE COLUMN 2 **************************/
        //if(start < 0 ){
        //        ;
        //}
        if((start < 21)){
           PORTC = column[start];  //holds address of PORTD, columns 0-7
           PORTD |= 0b01000000;   //control line for DMUX 1
           PORTA = 0x00;

        }
        else if (start < 36){
                PORTC = column[start];  //columns 7-13
                PORTD |= 0b00100000;
                PORTA = 0x00;

        }
        else if (start < 51){
                PORTC = column[start];  //columns 30-45
                PORTD |= 0b00010000;
                PORTA = 0x00;
        }
        else if (start < 66){
                PORTC = column[start];  //columns 45-60
                PORTD |= 0b00001000;
                PORTA = 0x00;
        }
        else{
                PORTC = 0x00;
        }
        start++;
        PORTB = characters[charNum][2];
        PORTD |= characters[charNum][3];
        for(i=0; i<20; i++){;}  //homebrew delay
        PORTA = 0x00;
        PORTB = 0x00;
        PORTC = 0x00;
        PORTD = 0x00;
        PORTE = 0x00;



/************************* REFERENCE COLUMN 3 **************************/
        //if(start < 0 ){
        //        ;
        //}
        if((start < 21)){
           PORTC = column[start];  //holds address of PORTD, columns 0-7
           PORTD |= 0b01000000;   //control line for DMUX 1
           PORTA = 0x00;

        }
        else if (start < 36){
                PORTC = column[start];  //columns 7-13
                PORTD |= 0b00100000;
                PORTA = 0x00;

        }
        else if (start < 51){
                PORTC = column[start];  //columns 30-45
                PORTD |= 0b00010000;
                PORTA = 0x00;
        }
        else if (start < 66){
                PORTC = column[start];  //columns 45-60
                PORTD |= 0b00001000;
                PORTA = 0x00;
        }
        else{
                PORTB = 0x00;
        }
        start++;
        PORTB = characters[charNum][4];
        PORTD |= characters[charNum][5];
        for(i=0; i<20; i++){;}  //homebrew delay
        PORTA = 0x00;
        PORTB = 0x00;
        PORTC = 0x00;
        PORTD = 0X00;
        PORTE = 0x00;


/************************* REFERENCE COLUMN 4 **************************/
        //if(start < 0 ){
        //        ;
        //}
        if((start < 21)){
           PORTC = column[start];  //holds address of PORTD, columns 0-7
           PORTD |= 0b01000000;   //control line for DMUX 1
           PORTA = 0x00;

        }
        else if (start < 36){
                PORTC = column[start];  //columns 7-14
                PORTD |= 0b00100000;
                PORTA = 0x00;

        }
        else if (start < 51){
                PORTC = column[start];  //columns 30-45
                PORTD |= 0b00010000;
                PORTA = 0x00;
        }
        else if (start < 66){
                PORTC = column[start];  //columns 45-60
                PORTD |= 0b00001000;
                PORTA = 0x00;
        }
        else{
                PORTB = 0x00;
        }
        start++;
        PORTB = characters[charNum][6];
        PORTD |= characters[charNum][7];
        for(i=0; i<20; i++){;}  //homebrew delay
        PORTA = 0x00;
        PORTB = 0x00;
        PORTC = 0x00;
        PORTD = 0x00;
        PORTE = 0x00;



/************************* REFERENCE COLUMN 5 **************************/
        //if(start < 0 ){
        //        ;
        //}
        if((start < 21)){
           PORTC = column[start];  //holds address of PORTD, columns 0-7
           PORTD |= 0b01000000;   //control line for DMUX 1
           PORTA = 0x00;

        }
        else if (start < 36){
                PORTC = column[start];  //columns 7-14
                PORTD |= 0b00100000;
                PORTA = 0x00;

        }
        else if (start < 51){
                PORTC = column[start];  //columns 30-45
                PORTD |= 0b00010000;
                PORTA = 0x00;
        }
        else if (start < 66){
                PORTC = column[start];  //columns 45-60
                PORTD |= 0b00001000;
                PORTA = 0x00;
        }
        else{
                PORTB = 0x00;
        }
        start++;
        PORTB = characters[charNum][8];
        PORTD |= characters[charNum][9];
        for(i=0; i<20; i++){;}  //homebrew delay
        PORTA = 0x00;
        PORTB = 0x00;
        PORTC = 0x00;
        PORTD = 0x00;
        PORTE = 0x00;



/************************* REFERENCE COLUMN 6 **************************/
        //if(start < 0 ){
        //        ;
        //}
        if((start < 21)){
           PORTC = column[start];  //holds address of PORTD, columns 0-7
           PORTD |= 0b01000000;   //control line for DMUX 1
           PORTA = 0x00;

        }
        else if (start < 36){
                PORTC = column[start];  //columns 7-14
                PORTD |= 0b00100000;
                PORTA = 0x00;

        }
        else if (start < 51){
                PORTC = column[start];  //columns 30-45
                PORTD |= 0b00010000;
                PORTA = 0x00;
        }
        else if (start < 66){
                PORTC = column[start];  //columns 45-60
                PORTD |= 0b00001000;
                PORTA = 0x00;
        }
        else{
                PORTB = 0x00;
        }
        start++;
        PORTB = characters[charNum][10];
        PORTD |= characters[charNum][11];
        for(i=0; i<20; i++){  //HomeBrew Delay
        ;
        }
        PORTA = 0x00;
        PORTB = 0x00;
        PORTC = 0x00;
        PORTD = 0x00;
        PORTE = 0x00;



/************************* REFERENCE COLUMN 7 **************************
        if(start < 15){
           PORTC = column[start];  //holds address of PORTD, columns 0-7
           PORTD |= 0b01000000;   //control line for DMUX 1
           PORTA = 0x00;

        }
        else if (start < 30){
                PORTC = column[start];  //columns 7-13
                PORTD |= 0b00100000;
                PORTA = 0x00;

        }
        else if (start < 45){
                PORTC = column[start];  //columns 30-45
                PORTD |= 0b00010000;
                PORTA = 0x00;
        }
        else if (start < 60){
                PORTC = column[start];  //columns 45-60
                PORTD |= 0b00001000;
                PORTA = 0x00;
        }
        else{
                PORTA = 0x00;   //this is just filler
        }
        start++;
        PORTB = 0x00;  //turn off rows 1-8
        PORTD &= ~row9;  //turns off row9
        for(i=0; i<20; i++);  //homebrew delay
        PORTA = 0x00;
        PORTB = 0x00;
        PORTC = 0x00;
        PORTD = 0x00;
        PORTE = 0x00;                                                */
}
//}





/*void test(int start){
        PORTB = 0xff;

        if(start < 15){
           PORTC = column[start];  //holds address of PORTD, columns 0-7
           PORTD |= 0b01000000;   //control line for DMUX 1
           PORTA = 0x00;

        }
        else if (start < 30){
                PORTC = column[start];  //columns 7-13
                PORTD |= 0b00100000;  //control line for demux 2
                PORTA = 0x00;

        }
        else if (start < 45){
                PORTC = column[start];  //columns 30-45
                PORTD |= 0b00010000;  //control line for demux 3
                PORTA = 0x00;
        }
        else if (start < 60){
                PORTC = column[start];  //columns 45-60
                PORTD |= 0b00001000;  //control line for demux 4
                PORTA = 0x00;
        }
        else
                PORTA = 0x00;   //this is just filler

        //PORTC = column[start++];
        delay_ms(500);
        start++;

        PORTC = column[start++];
        delay_ms(500);

        PORTC = column[start++];
        delay_ms(500);

        PORTC = column[start++];
        delay_ms(500);

        PORTC = column[start++];
        delay_ms(500);

        PORTC = column[start++];
        delay_ms(500);

        PORTC = column[start++];
        delay_ms(500);

        PORTC = column[start++];
        delay_ms(500);

        PORTC = column[start++];
        delay_ms(500);

        PORTC = column[start++];
        delay_ms(500);

        PORTC = column[start++];
        delay_ms(500);

        PORTC = column[start++];
        delay_ms(500);

        PORTC = column[start++];
        delay_ms(500);

        PORTC = column[start++];
        delay_ms(500);

        PORTC = column[start++];
        delay_ms(500);

        PORTA = 0x00;
        PORTB = 0x00;
        PORTC = 0x00;
        PORTD = 0X00;
        PORTE = 0x00;
} */


void main() {
    int counter = 0;
    int offset = 0;
    int streamChars[9] = {1,0,11,11,18};  //this array will probs be maxed at 140 (for tweets) 
    int numChars = 5;  //this should be like arraysize(streamChars); it should return the number of actual characters used in array
    init_ports();

    index = 65;  //DEBUG... reset before entering loop

    while(1){


        //test(45);
       // test(0);
        //index += 15;

        //display(1, index + 36);
        //display(3, index + 43);
        //display(0, index + 50);
        //display(24, index + 57);
        
        if(index>(-(numChars * 7)-1)){  //number of characters times # of columns for each(6 columns + space) 
            
          /*  if(index >-1){
                display(5, index);
                offset +=7;
            }
            else{
                offset += 7;
                for(int i=0; i<80; i++); //delay to match the absence of a character
            }
            if((index + offset)> -1){
                display(20, (index + offset));
                offset +=7;
            }
            else{
                offset += 7;
                for(int i=0; i<120; i++); //delay to match the absence of a character
            }
            if((index + offset) > -1){
                display(2, (index + offset));
                offset +=7;
            }
            else{
                offset += 7;
                for(int i =0; i<180; i++); //delay to match the absence of a character
            }
            if((index + offset) > -1)
                display(10, (index + offset));
            else{
                for(int i=0; i<230; i++); //delay to match the absence of a character
            }  */


            for(int i = 0; i < numChars; i++){
                if((index + offset) > (-1)){
                    display(streamChars[i],(index + offset));
                    offset += 7;
                }
                else{
                    offset +=7;
                    for(int j=0; j <= (i * 20); j++); //delay needs to increase to compensate for non displayed letters
                }
            }

            offset = 0;
            counter++;

            if(counter > 4){
                 counter = 0x00;  //reset counter
                 index--; //decrement index
            }

        }
        else{
           index = 65;
        }
    }
}
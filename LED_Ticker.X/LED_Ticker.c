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


//communication variables
const int dataPin = 0b00000001;
const int pulsePin = 0b00000010;
const int parityPin = 0b00000100;

int binaryArray[8]={128,64,32,16,8,4,2,1};

int flickerDelay = 20;
//using these arrays to hold byte size integers
char streamChars1[70] = {'C'-32,'o'-32,'c'-32,'k'-32,'p'-32, 'i'-32, 't'-32, ' '-32, 'W'-32, 'T'-32, 'F'-32};
char streamChars2[70] = {'C'-32,'o'-32,'c'-32,'k'-32,'p'-32, 'i'-32, 't'-32, ' '-32, 'W'-32, 'T'-32, 'F'-32};


const char column[1100] = { //this will hold the dmux command for every column...the zeroes are for below 0
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //40
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //80
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //120
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //160
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //200
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //240
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //280
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //320
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //360
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //400
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //440
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //480
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //520
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //560
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //600
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //640
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //680
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //720
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //760
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //800
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //840
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //880
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //920
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //960
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, //980  index 979
       

        //indexs 980-1100, this is where the dmux commands start, they repeat every 15 members
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
        0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000  //120 columns (15*8)
};

/*
 [Number of options], [Number of columns]

 NOTE: In the columns, there are two options for each column. 1st space refers to PORTB (rows 1-8).
 the 2nd option refers to PORTD (row9).

 */

const int characters[127][12] =
     
{    
    { 
    // spacebar 32
        0, 0,
        0, 0,
        0, 0,
        0, 0,
        0, 0,
        0, 0
    },    
  
    //SYMBOLS
    
    {
        //! 33  (25+26+12)
        0, 0,
        0, 0,
        row2+row3+row4+row5+row6+row8, 0,
        0, 0,
        0, 0,
        0, 0
    },
    {
        //" 34 (25+26+35)
        0, 0,
        row2+row3, 0,
        0, 0,
        0, 0,
        row2+row3, 0,
        0, 0
    },
    {
        //# 35  (25+26+14)
        row4+row7, 0,
        row2+row3+row4+row5+row6+row7+row8, row9,
        row4+row7, 0,
        row2+row3+row4+row5+row6+row7+row8, row9,
        row4+row7, 0,
        0, 0
    },
    {
        //$ 36  (25+26+15)
        row3+row4+row7, 0,
        row2+row5+row8, 0,
        row1+row2+row5+row8, row9,
        row2+row5+row8, 0,
        row3+row6+row7, 0,
        0, 0
    },
    {
        //% 37
        row2+row8, row9,
        row1+row3+row7, 0,
        row2+row6, 0,
        row4+row5+row8, 0,
        row3+row7, row9,
        row1+row2+row8, 0
    },
    {
        //& 38
        row3+row7+row8, 0,
        row2+row4+row6, row9,
        row1+row5, row9,
        row1+row4+row6+row8, 0,
        row2+row3+row7, 0,
        row6+row8, row9
    },
    {
        //' 39 
        0, 0,
        row2+row3, 0,
        0, 0,
        0, 0,
        0, 0,
        0, 0
    },
    {
        //( 40
        0, 0,
        row3+row4+row5+row6+row7, 0,
        row2+row8, 0,
        row1, 0,
        0, 0,
        0, 0
    },
    {
        //) 41
        0, 0,
        row1, row9,
        row2+row8, 0,
        row3+row4+row5+row6+row7, 0,
        0, 0,
        0, 0
    },
    {
        //* 42
        row3+row5+row7, 0,
        row4+row6, 0,
        row5, 0,
        row4+row6, 0,
        row3+row5+row7, 0,
        0, 0
    },
    {
        //+ 43
        row5, 0,
        row5, 0,
        row3+row4+row5+row6+row7, 0,
        row5, 0,
        row5, 0,
        0, 0
    },
    {
        //' 44 
        0, 0,
        row2+row3, 0,
        0, 0,
        0, 0,
        0, 0,
        0, 0
    },
    {
        //- 45
        0, 0,
        row5, 0,
        row5, 0,
        row5, 0,
        row5, 0,
        0, 0
    },
    {
        //. 46 
        0, 0, 
        0, 0,
        0, 0,
        0, 0,
        row8, 0,
        0, 0
    },
    {
        /// 47
        0, 0,
        row8, row9,
        row6+row7, 0,
        row4+row5, 0,
        row2+row3, 0,
        0, 0
    },
    

     
    //Numbers
    


    {
        //0 48
        row2+row3+row4+row5+row6+row7+row8, 0,
        row1+row7, row9,
        row1+row5+row6, row9,
        row1+row3+row4, row9,
        row1+row2, row9,
        row2+row3+row4+row5+row6+row7+row8, 0
    },
    {
        //1 49
        0, row9,
        row1, row9,
        row1, row9,
        allRows, row9,
        0, row9,
        0, row9
    },
    {
        //2 50
        row2+row8, row9,
        row1+row7, row9,
        row1+row6, row9,
        row1+row5, row9,
        row1+row4, row9,
        row2+row3, row9
    },
    {
        //3 51
        row2+row8, 0,
        row1, row9,
        row1+row4, row9,
        row1+row4, row9,
        row1+row4, row9,
        row2+row3+row4+row5+row6+row7+row8, 0
    },
    {
        //4 52
        row4+row5, 0,
        row3+row5, 0,
        row2+row5, 0, 
        row1+row5, 0, 
        allRows, row9,
        row5, 0
    },
    {
        //5 53
        row2+row3+row4+row5, 0,
        row1+row5, row9,
        row1+row3, row9,
        row1+row3, row9,
        row1+row4+row8, 0,
        row1+row6+row7, 0
    },
    {
        //6 54
        row3+row4+row5+row6+row7, 0,
        row2+row5+row8, 0,
        row1+row4, row9,
        row1+row4, row9,
        row1+row5+row8, 0,
        row1+row6+row7, 0
    },
    {
        //7 55
        row2, 0,
        row1, 0,
        row1, 0,
        row1+row7+row8, row9,
        row1+row4+row5, 0,
        row2+row3+row4, 0
    },
    {
        //8 56
        row3+row7, 0,
        row2+row4+row6+row8, 0,
        row1+row4, row9,
        row1+row4, row9,
        row2+row4+row6+row8, 0,
        row3+row7, 0
    },
    {
        //9 57
        row3, 0,
        row2+row4+row8, 0,
        row1+row5, row9,
        row1+row5, row9,
        row2+row4+row8, 0,
        row3+row4+row5+row6+row7, 0
    },


    
    //Additonal Symbols
    
    {
        //: 58
        0, 0,
        0, 0,
        0, 0, 
        row4+row7, 0,
        0, 0,
        0, 0
    },
    {
        //; 59
        0, 0,
        0, 0,
        row8, 0,
        row4+row7, 0,
        0, 0, 
        0, 0
    },
    {
        //< 60
        0, 0,
        row5, 0,
        row4+row6, 0,
        row3+row7, 0,
        row2+row8, 0,
        0, 0
    },
    {
        //= 61
        0, 0,
        row4+row6, 0,
        row4+row6, 0,
        row4+row6, 0,
        row4+row6, 0,
        0, 0
    },
    {
        //> 62
        0, 0,
        row2+row8, 0,
        row3+row7, 0,
        row4+row6, 0,
        row5, 0,
        0, 0
    },
    {
        //? 63
        0, 0, 
        row3, 0,
        row2, 0,
        row1+row5+row6, row9,
        row2+row4, 0,
        row3, 0
    },
    {
        //@ 64
        row3+row4+row5+row6, 0,
        row2+row7, 0,
        row1+row4+row5+row8, 0,
        row1+row3+row6+row8, 0,
        row1+row4+row5+row8, 0,
        row2+row3+row4+row5+row6, 0
    },
    
    
    
    //UPPERCASE LETTERS
    
    
    {
        //A 65
        row3+row4+row5+row6+row7+row8, row9, 
        row2+row5, 0, 
        row1+row5, 0,
        row1+row5, 0,
        row2+row5, 0,
        row3+row4+row5+row6+row7+row8, row9
    },
    { 
        //B 66
        allRows, row9,
        row1+row5, row9,
        row1+row5, row9,
        row1+row5, row9,
        row1+row5, row9,
        row2+row3+row4+row6+row7+row8, 0
    },  
    {   
        //C 67
        row2+row3+row4+row5+row6+row7+row8, 0,
        row1, row9,
        row1, row9,
        row1, row9,
        row1, row9,
        row2+row8, 0    
    },   
    {   
        //D 68
        allRows, row9,
        row1, row9,
        row1, row9,
        row1, row9,
        row2+row8, 0,
        row3+row4+row5+row6+row7, 0
    },
    {
        //E 69
        allRows, row9,
        row1+row5, row9,
        row1+row5, row9,
        row1+row5, row9,
        row1, row9,
        row1, row9
    },  
    { 
        //F 70
        allRows, row9,
        row1+row5, 0,
        row1+row5, 0,
        row1+row5, 0,
        row1, 0,
        row1, 0 
    },
    {
        //G 71
        row2+row3+row4+row6+row7, 0,
        row1, row9,
        row1, row9,
        row1+row5, row9,
        row1+row5, row9,
        row2+row5+row6+row7+row8, 0
    },
    {
        //H 72
        allRows, row9,
        row5, 0,
        row5, 0,
        row5, 0,
        row5, 0,
        allRows, row9
    },
    { 
        //I 73
        row1, row9,
        row1, row9,
        allRows, row9,
        row1, row9,
        row1, row9,
        0, 0
    },
    { 
        //J 74
        row1+row8, 0,
        row1, row9,
        row1, row9,
        allRows, 0,
        row1, 0,
        row1, 0
    },
    {
        //K 75
        allRows, row9,
        row5, 0,
        row5, 0, 
        row4+row6, 0,
        row3+row7, 0,
        row1+row2+row8, row9
    },
    {
        //L 76
        allRows, row9,
        0, row9,
        0, row9,
        0, row9,
        0, row9,
        0, row9
    },
    {  
        //M 77
        allRows, row9,
        row2+row3, 0,
        row4, 0,
        row4, 0,
        row2+row3, 0,
        allRows, row9   
    },
    {  
        //N 78
        allRows, row9,
        row2+row3, 0,
        row4+row5, 0,
        row6+row7, 0,
        row8, row9,
        allRows, row9
    },
    {
        //0 79
        row3+row4+row5+row6+row7, 0,
        row2+row8, 0,
        row1, row9,
        row1, row9,
        row2+row8, 0,
        row3+row4+row5+row6+row7, 0
    },
    {  
        //P 80
        allRows, row9,
        row1+row5, 0,
        row1+row5, 0,
        row1+row5, 0,
        row1+row5, 0,
        row2+row3+row4, 0
    },
    {
        //Q 81
        row3+row4+row5+row6+row7, 0,
        row2+row8, 0,
        row1, row9,
        row1+row7, row9,
        row2+row8, 0,
        row3+row4+row5+row6+row7, row9
    },
    {  
        //R 82
        allRows, row9, 
        row1 + row5, 0, 
        row1 + row5, 0, 
        row1 + row5 + row6, 0,
        row1 + row5 + row7, 0, 
        row4 + row3 + row2 + row8, row9  
    },  
    {
        //S 83
        row2+row3+row4+row8, 0,
        row1+row5, row9,
        row1+row5, row9,
        row1+row5, row9,
        row1+row5, row9,
        row2+row6+row7+row8, 0
    },
    {
        //T 84
        row1, 0,
        row1, 0, 
        allRows, row9,
        row1, 0,
        row1, 0,
        0, 0
    },
    {  
        //U 85
        allRows, 0,
        0, row9,
        0, row9,
        0, row9,
        0, row9,
        allRows, 0
    },
    {
        //V 86
        row1+row2+row3+row4+row5+row6, 0,
        row7+row8, 0,
        0, row9,
        0, row9,
        row7+row8, 0,
        row1+row2+row3+row4+row5+row6, 0
    },
    {
        //W 87
        allRows, 0,
        0, row9,
        row8, 0,
        row8, 0,
        0, row9,
        allRows, 0
    },
    {
        //X 88
        row1+row2+row8, row9,
        row3+row4+row6+row7, 0,
        row5, 0,
        row5, 0,
        row3+row4+row6+row7, 0,
        row1+row2+row8, row9
    },
    {
        //Y 89
        row1+row2, 0,
        row3+row4, 0, 
        row5+row6+row7+row8, row9,
        row3+row4, 0, 
        row1+row2, 0
    },
    {
        //Z 90 
        row1+row8, row9,
        row1+row7, row9,
        row1+row5+row6, row9,
        row1+row4+row5, row9,
        row1+row3, row9,
        row1+row2, row9
    },


    {
        //[ 91
        0, 0,
        row2+row3+row4+row5+row6+row7+row8, 0,
        row2, row8,
        row2, row8,
        0, 0, 
        0, 0
    },
    {
        //\ 92
        0, 0,
        row2+row3, 0,
        row4+row5, 0,
        row6+row7, 0,
        row8, row9,
        0, 0
    },
    {
        //] 93
        0, 0, 
        0, 0,
        row2+row8, 0,
        row2+row8, 0, 
        row2+row3+row4+row5+row6+row7+row8, 0,
        0, 0, 
    },
    {
        //^ 94
        row4, 0,
        row3, 0,
        row2, 0,
        row3, 0,
        row4, 0,
        0, 0
    },
    {
        //_ 95
        0, row9,
        0, row9,
        0, row9,
        0, row9,
        0, row9,
        0, row9
    },
    {
        //` 96
        0, 0,
        0, 0,
        row2, 0,
        row3, 0,
        0, 0, 
        0, 0
    },

    
    
    //LOWERCASE LETTERS
    
    
    
    {
    //a 97
    row5+row6+row7+row8, 0,
    row4, row9,
    row4, row9,
    row4+row8, 0,
    row5+row6+row7+row8, row9
    },
    {
    //b 98
    allRows, row9,
    row5+row8, 0,
    row4, 0, 
    row4, 0, 
    row4, 0,
    row5+row6+row7+row8, 0
    },
    {
    //c 99
    row5+row6+row7+row8, 0,
    row4, row9,
    row4, row9,
    row4, row9, 
    row4, row9,
    row5+row8, 0
    },
    {
    //d 100
    row5+row6+row7+row8, 0,
    row4, row9,
    row4, row9,
    row4, row9,
    row5+row8, 0,
    allRows, row9
    },
    {
    //e 101
    row6+row7+row8, 0,
    row5+row7, row9,
    row4+row7, row9,
    row4+row7, row9,
    row5+row7, row9,
    row6, 0
    },
    {
    //f 102
    row6, 0,
    row3+row4+row5+row6+row7+row8, row9,
    row2+row6, 0,
    row2, 0,
    row3, 0,
    0, 0
    },
    {
    //g 103
    row6, row9,
    row5+row7, 0,
    row4+row8, 0,
    row4+row8, 0,
    row5+row7, 0,
    row6+row7+row8, row9
    },
    {
    //h 104
    allRows, row9,
    row5, 0, 
    row4, 0, 
    row4, 0,
    row4, 0, 
    row5+row6+row7+row8, row9
    },
    {
    //i 105
    0, 0,
    0, 0,
    row3+row6+row7+row8, row9,
    0, 0,
    0, 0,
    0, 0
    },
    {
    //j 106
    row8, 0,
    0, row9,
    0, row9,
    row2+row5+row6+row7+row8, 0,
    0, 0,
    0, 0
    },
    {
    //k 107
    row3+row4+row5+row6+row7+row8, row9,
    row6, 0, 
    row6, 0, 
    row5+row7, 0,
    row4+row8, row9,
    0, 0
    },
    {
    //l 108
    0, 0,
    0, 0,
    row3+row4+row5+row6+row7+row8, row9,
    0, 0,
    0, 0,
    0, 0
    },
    {
    //m  109
    row4+row5+row6+row7+row8, row9,
    row5+row6, 0,
    row7, 0,
    row7, 0,
    row5+row6, 0,
    row4+row5+row6+row7+row8, row9
    },
    {
    //n 110
    row4+row5+row6+row7+row8, row9, 
    row5, 0,
    row4, 0,
    row4, 0,
    row5, 0,
    row6+row7+row8, row9
    },
    {
    //o 111
    row6+row7, 0,
    row5+row8, 0,
    row4, row9,
    row4, row9,
    row5+row8, 0,
    row6+row7, 0
    },
    {
    //p 112
    row6+row7+row8, row9,
    row5+row7, 0,
    row4+row8, 0,
    row4+row8, 0,
    row5+row7, 0,
    row6, 0
    },
    {
    //q 113
    row6, 0,
    row5+row7, 0,
    row4+row8, 0,
    row4+row8, 0,
    row5+row7, 0,
    row6+row7+row8, row9
    },
    {
    //r 114
    row6+row7+row8, row9,
    row5, 0,
    row4, 0,
    row4, 0,
    row5, 0,
    0, 0
    },
    {
    //s 115
    row5, row9,
    row4+row6, row9,
    row4+row6, row9,
    row4+row6, row9,
    row4+row7+row8, 0,
    0, 0
    },
    {
    //t 116
    0, 0,
    row5, 0,
    row3+row4+row5+row6+row7+row8, row9,
    row5, 0,
    0, 0,
    0, 0
    },
    {
    //u 117
    row4+row5+row6+row7+row8, 0,
    0, row9,
    0, row9,
    0, row9,
    row4+row5+row6+row7+row8, 0,
    0, 0
    },
    {
    //v 118
    row4+row5+row6+row7, 0,
    row8, 0,
    0, row9,
    row8, 0, 
    row4+row5+row6+row7, 0,
    0, 0
    },
    {
    //w 119
    row4+row5+row6+row7+row8, 0,
    0, row9,
    row8, 0,
    row8, 0,
    0, row9,
    row4+row5+row6+row7+row8, 0
    },
    {
    //x 120
    row4, row9,
    row5+row8, 0,
    row6+row7, 0, 
    row5+row8, 0,
    row4, row9,
    0, 0
    },
    {
    //y 121
    row4+row5, 0,
    row6, row9,
    row7+row8, 0,
    row6, 0,
    row4+row5, 0,
    0, 0
    },
    {
    //z 122
    0, 0,
    row4+row8, row9,
    row4+row7, row9,
    row4+row6, row9,
    row5, row9,
    0, 0
    },


   
    //More Symbols
    


    {
        //{ 123
        0, 0,
        0, 0,
        row5, 0,
        row2+row3+row4+row6+row7+row8, 0,
        row2+row8,
        0, 0
    },
    {
        //| 124
        0, 0, 
        0, 0,
        0, 0,
        row1+row2+row3+row4+row6+row7+row8, row9,
        0, 0,
        0, 0
    },
    {
        //} 125
        0, 0,
        row2+row8, 0,
        row2+row3+row4+row6+row7+row8, 0,
        row5, 0,
        0, 0,
        0, 0
    },
    {
        //~ 126
        row4, 0,
        row3, 0,
        row4, 0,
        row5, 0,
        row6, 0,
        row5, 0
    },
};



int index = 0x00;



void init_ports(){
    PORTA = 0x00;
    TRISA = 0b00000111;  //A0, A1, A2 are inputs for communication.
    PORTB = 0x00;
    TRISB = 0x00;      // data direction control, 0 for output 1 for input
    PORTC = 0x00;
    TRISC = 0x00;
    PORTD = 0x00;
    TRISD = 0x00;

    //disable adcon cmcon, cvrcon;
    ADCON0 = 0b11100000;  //turns A/D off
    ADCON1 = 0b00000111;  //makes A0-A3 digital i/o
    CMCON = 0b00000111;  //makes A0, A1, A2, digital I/O
    CVRCON = 0x00;   //i dont think necessary
}

void display(int charNum, signed int start){  //ignites a letter starting at column specified by "start"

        int i = 0x00;
        PORTB = 0x00;
        PORTC = 0x00;
        PORTD = 0b01111111;
        PORTA = 0x00;

/************************* REFERENCE COLUMN 1 **************************/
    for(int k=0; k<12; k++){  //12 because I increment below so it needs to increment double

        if(start < 980){
            PORTC = 0x00; //zero command, will not ignite any columns
            PORTD = 0x00; //all control lines are off as well.
        }

        else if((start < 995)){
           PORTC = column[start];  //holds address of PORTD, columns 0-7
           PORTD &= 0b10111111;   //control line for DMUX 1
           PORTA = 0x00;
        }
        else if (start < 1010){
            PORTC = column[start];  //columns 7-13
            PORTD &= 0b11011111;
            PORTA = 0x00;
        }
        else if (start < 1025){
            PORTC = column[start];  //columns 30-45
            PORTD &= 0b11101111;
            PORTA = 0x00;
        }
        else if (start < 1040){
            PORTC = column[start];  //columns 45-60
            PORTD &= 0b11110111;
            PORTA = 0x00;
        }
        else if (start < 1055){
            PORTC = column[start];  //columns 66-80
            PORTD &= 0b11111011;
            PORTA = 0x00;
        }
        else if (start < 1070){
            PORTC = column[start];  //columns 81-95
            PORTD &= 0b11111101;
            PORTA = 0x00;
        }
        else if (start < 1085){
            PORTC = column[start];  //columns 96-110
            PORTD &= 0b11111110;
            PORTA = 0x00;
        }
        else if (start < 1100){
            PORTC = column[start];
            //add whatever port and pin used for last control line
        }
        else{
            PORTC = 0x00;  //yeah, this should never happen
        }
        start++;
        PORTB = characters[charNum][k]; //puts the rows on the column
        PORTD |= characters[charNum][++k]; //puts row 9 on the column
        for(i=0; i<flickerDelay; i++){;}  //homebrew delay
        PORTB = 0x00;  //turns off all rows
        PORTC = 0x00;  //zero command
        PORTD = 0b01111111;  //turns off row 9 and all dmux
    }    
}


void test(int start){
    long delay = 20000;
    PORTB = 0xff;
    /*PORTD = 0b01111001;

    PORTC = 0b00000000;
    for(int i = 0; i<delay; i++);  //delay  
    PORTC = 0b00010000;
    for(int i = 0; i<delay; i++);  //delay 
    PORTC = 0b00100000;
    for(int i = 0; i<delay; i++);  //delay 
    PORTC = 0b00110000;
    for(int i = 0; i<delay; i++);  //delay 
    PORTC = 0b01000000;
    for(int i = 0; i<delay; i++);  //delay 
    PORTC = 0b01010000;
    for(int i = 0; i<delay; i++);  //delay 
    PORTC = 0b01100000;
    for(int i = 0; i<delay; i++);  //delay 
    PORTC = 0b01110000;
    for(int i = 0; i<delay; i++);  //delay 
    PORTC = 0b10000000;
    for(int i = 0; i<delay; i++);  //delay 
    PORTC = 0b10010000;
    for(int i = 0; i<delay; i++);  //delay 
    PORTC = 0b10100000;
    for(int i = 0; i<delay; i++);  //delay 
    PORTC = 0b10110000;
    for(int i = 0; i<delay; i++);  //delay 
    PORTC = 0b11000000;
    for(int i = 0; i<delay; i++);  //delay
    PORTC = 0b11010000;
    for(int i = 0; i<delay; i++);  //delay 
    PORTC = 0b11100000;
    for(int i = 0; i<delay; i++);  //delay 
    PORTC = 0b11110000;
    for(int i = 0; i<delay; i++);  //delay  */

   //for(int i = 0; i<)
}

void displayLoading(int columnSelect){
    PORTD = 0b00111111;   //control line for DMUX 1
    PORTB = row1+row2+row3+ row7+row8;
    PORTD |= row9;
    PORTC = column[columnSelect + 980];
    return;
}

void displaySuccess(){
    PORTD = 0b01011111;   //control line for DMUX 2
    PORTB = row1+row2+row3+ row7+row8;
    PORTD |= row9;
    PORTC = column[980];
    return;
}

void displayTesting(int start){
    PORTD = 0b01111110;   //control line for DMUX 2
    PORTB = row1+row2+row3+ row7+row8;
    PORTD |= row9;
    PORTC = column[1070 + start];
    return;
}

void main() {
    int totalCounter = 0;
    int lastDivision = 0;
    int charOffset = 0;
    int totalOffset = 0;
    int charCount = 0;
    int charBegin = 0;
    int charEnd = 0;
    int zeroCounter = 0;
     
    int numChars1 = 30;  //this should be like arraysize(streamChars); it should return the number of actual characters used in array
    int numChars2 = 0;
    int spacesCounter1 = 0;
    int spacesCounter2 = 0;
    char commandTemp[8];
    init_ports();

    index = 1099;  //DEBUG... reset before entering loop

    while(1){  //the infinite loop
        /*
        displayLoading(0);
        for(int i = 0; i<5000; i++){;}
        displayLoading(1);
        for(int i = 0; i<5000; i++){;}
        displayLoading(2);
        for(int i = 0; i<5000; i++){;}
        displayLoading(3);
        for(int i = 0; i<5000; i++){;}
        displayLoading(4);
        for(int i = 0; i<5000; i++){;}
        displayLoading(5);
        for(int i = 0; i<5000; i++){;}
        displayLoading(6);
        for(int i = 0; i<5000; i++){;}
        displayLoading(7);
        for(int i = 0; i<5000; i++){;}
        displayLoading(8);
        for(int i = 0; i<5000; i++){;}    */


        
        if(PORTA & (dataPin + parityPin)){  //the ardi is requesting to transmit data
            for(int t=0; t<2; t++){;} //tiny delay to prevent noise
            if(PORTA & (dataPin + parityPin)){  //the ardi is still requesting, lets go with it
                PORTA = 0x00;
                TRISA = 0b11111101;  //A0, A2 are inputs for communication. A1 is output for reply
                PORTA = 0b00000010;  //send back the yes signal
                for(int t=0; t<3; t++){;}  //quick time to send back yes signal
                
                //while(PORTA & (parityPin+dataPin)) {;}  //stay here until this opening frame goes away
                
                PORTA = 0x00;  //turn off yes signal   
                TRISA = 0b00000111;  //changes all comm pins back to input

                    while(!(PORTA & (dataPin+pulsePin+parityPin))) && (timer < timeOut) { //wait for this to begin
                        timer++;
                    }
                    timer = 0;    
                    while((PORTA & (dataPin+pulsePin+parityPin)) && (timer < timeOut )){ //wait for this to end before entering the for loop.
                        timer++;
                    }
                    timer = 0;
                for(int streamNum = 0; streamNum < 140; streamNum++){  //for all ascii chars
                    for(int k=0; k<9; k++){
                        displayLoading(k);
                        
                        while(!(PORTA & pulsePin) && (timer < timeOut)){ //wait for the pulse pin
                            timer++;
                        }  
                        timer = 0;  
                        if( k < 8){
                            commandTemp[k] = (PORTA & dataPin); // WRITE DATA
                        }
                        else if(k == 8){
                            commandTemp[k] = (PORTA & (dataPin + parityPin));  // closing bracket

                            if(commandTemp[8] == (dataPin + parityPin)){
                                displaySuccess(); //debug, this means it was a succesful frame
                            }
                        }
                        while((PORTA & pulsePin) && (timer < timeOut)){ // wait till pulse from the last one is over 
                            timer++;
                        }    
                        timer = 0;
                    }

                    //PUT ZEROES IN ARRAY SPOTS SO OUR ADDITION BELOW STARTS FROM 0
                    // and not whatever it was before.
                    if(streamNum < 70){
                        streamChars1[streamNum] = 0; 
                    }
                    else {
                        streamChars2[streamNum -70] = 0;
                    }
                    
                    //CONVERTS FROM BINARY INTO INTEGER AND PUTS THE VALUE INTO CORRECT ARRAY VALUE
                    for (int z = 0; z<8; z++) {
                        if (commandTemp[z]){  //if its zero we dont care... so theres that.
                            if(streamNum < 70){
                                streamChars1[streamNum] += binaryArray[z]; //puts decimal value into asciiCode
                            }
                            else{
                                streamChars2[streamNum-70] += binaryArray[z]; //puts decimal value into asciiCode
                            }    
                        }
                        else{
                            zeroCounter ++;
                        }
                    }

                    //THIS WILL MAKE SPACES AT END OF STRING INSTEAD OF OLD DATA
                    if(zeroCounter == 8) {
                        if(streamNum < 70){
                            streamChars1[streamNum] =' '; //puts decimal value into asciiCode
                        }
                        else{
                            streamChars2[streamNum-70] =' '; //puts decimal value into asciiCode
                        }    
                    }
                    zeroCounter = 0;
                }

                //COMPENSATES FOR THE OFFSET OF OUR ASCII ARRAY... our characters[0] = "realWorldAscii[32]"
                for(int j = 0; j<140; j++){ 

                    if(j < 70){
                        if(streamChars1[j] >= 32) {  //prevents out of bounds if faulty data
                            streamChars1[j] -= 32;  //subtract ascii offset

                            if(streamChars1[j] == 0){
                                spacesCounter1++;  //only incremented if successive, these are the trailing zeroes
                            }
                            else{
                                spacesCounter1 = 0; 
                            }
                        } 

                    }
                    else{
                        if(streamChars2[j-70] >= 32){  //prevents out of bounds if faulty data
                            streamChars2[j-70] -= 32;  //subtract the ascii offset

                            if(streamChars2[j-70] == 0){
                                spacesCounter2++;  //only incremented if successive, these are the trailing zeroes
                            }  
                            else{
                                spacesCounter2 = 0;
                            }
                        }  
                    }               
                }
                numChars1 = 70-spacesCounter1;
                numChars2 = 70-spacesCounter2;
            }   
        }

        











        //display(ascii character, start location )
       
         //number of characters times # of columns for each(6 columns + space) 
        //controls how far to go negative before restarting scroll.

        //854 = 1100-120.  

        
        
        if(totalCounter > (980-((numChars1+numChars2)*7))) {  //number of characters times # of columns for each(6 columns + space) 

            for(int i = 0; i < 17; i++){  //this is always running 17 times to populate the screen
                if(charCount<70){
                    display(streamChars1[charCount],(index + charOffset));
                }
                else if(charCount < 140){
                    display(streamChars2[charCount - 70],(index + charOffset));
                }
                charCount++;  //increments the characters placed... this will increase by 17 each time
                charOffset += 7;
            }
             
            totalCounter--;

            if(index > 973) {  //this is only for the first descent of characters across the screen
                charCount -= 17;
                charOffset = 0;
                index--;
            }
            else {  // all other cases
                charCount -= 17; //subtract 17 added from for loop
                charCount ++;
                charOffset = 0;
                index = 979;
            }

            for(int i = 0; i< 400; i++){;}  //delay, mainly for debug
        }

        else{
            index = 1099; //top of columns
            totalCounter = 1099; //top # of columns
            charCount = 0;
        }  
    }
}
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

int flickerDelay = 1;
//using these arrays to hold byte size integers
char streamChars1[70] = {'n'-32,'o'-32,'a'-32,'h'-32,' '-32, 'i'-32, 's'-32, ' '-32, 'b'-32, 'a'-32, 'd'-32, ' '-32, 'a'-32, 't'-32,
 ' '-32, 't'-32, 'h'-32, 'i'-32, 's'-32, ' '-32, 'g'-32, 'a'-32, 'm'-32, 'e'-32, '!'-32};
char streamChars2[70] = {'s'-32,'u'-32,'c'-32,'k'-32,'s'-32,'.'-32};


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
    TRISA = 0x00;
    PORTB = 0x00;
    TRISB = 0x00;      // data direction control, 0 for output 1 for input
    PORTC = 0x00;
    TRISC = 0x00;
    PORTD = 0x00;
    TRISD = 0x00;
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

        if((start < 995)){
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
        PORTB = characters[charNum][k]; //puts the rows  on the column
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


void main() {
    int counter = 0;
    int lastDivision = 0;
    int smallOffset = 0;
    int totalOffset = 0;
    int charCount = 0;
    int charBegin = 0;
    int charEnd = 0;
    int sevensCounter = 0;
     
    int numChars1 = 34;  //this should be like arraysize(streamChars); it should return the number of actual characters used in array
    int numChars2 = 34;
    int numChars3 = 34;
    int numChars4 = 40;
    init_ports();

    index = 1099;  //DEBUG... reset before entering loop

    while(1){  //the infinite loop

        //display(ascii character, start location )

       
         //number of characters times # of columns for each(6 columns + space) 
        //controls how far to go negative before restarting scroll.

        //854 = 1100-120.  
        
        if(index > 0){  //number of characters times # of columns for each(6 columns + space) 
            charBegin = index+totalOffset; //after 120 columns, this is zero
            charEnd = charCount + 17;
            for(int i = 0; i < 17; i++){  //this is always running 17 times to populate the screen
                display(streamChars1[charCount],(index + smallOffset));
                for(int i = 0; i< 200; i++){;}  //delay
                charCount++;  //increments the characters placed... this will increase by 17 each time
                smallOffset += 7;
            }
             smallOffset = 0;
             counter++;
             index --;
             sevensCounter++;


             if(sevensCounter == 49) {   //17 characters, 7 columns a piece  
                charCount -= 17; //subtract 17 added from for loop
                charCount --;
                sevensCounter = 0;
             }
             else{
                charCount -= 17;  //subtract 17 added from for loop
             }
             for(int i = 0; i< 1000; i++){;}  //delay
        }
        else{
            lastDivision = 0;
            counter = 0;
            charCount = 0;
            index = 1099;
        }
    }
}
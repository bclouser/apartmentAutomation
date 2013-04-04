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
const int characters[94][12] =
     
{    
    { 
    // {rows 1-8, row 9}
    
    
    /*
    UPPERCASE LETTERS
    */
    

    //A 0
    row3+row4+row5+row6+row7+row8, row9, 
    row2+row5, 0, 
    row1+row5, 0,
    row1+row5, 0,
    row2+row5, 0,
    row3+row4+row5+row6+row7+row8, row9
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
    row3+row4+row5+row6+row7, 0
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
    row2+row8, 0,
    row1, row9,
    row1, row9,
    row2+row8, 0,
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
    },
    
    
    /*
    LOWERCASE LETTERS
    */
    
    
    {
    //a 26 (25+1)
    row5+row6+row7+row8, 0,
    row4, row9,
    row4, row9,
    row4, row9,
    row5+row8, 0
    },
    {
    //b 27 (25+2)
    allRows, row9,
    row5+row8, 0,
    row4, 0, 
    row4, 0, 
    row4, 0,
    row5+row6+row7+row8, 0
    },
    {
    //c 28 (25+3)
    row5+row6+row7+row8, 0,
    row4, row9,
    row4, row9,
    row4, row9, 
    row4, row9,
    row5+row8, 0
    },
    {
    //d 29 (25+4)
    row5+row6+row7+row8, 0,
    row4, row9,
    row4, row9,
    row4, row9,
    row5+row8, 0,
    allRows, row9
    },
    {
    //e 30 (25+5)
    row6+row7+row8, 0,
    row5+row7, row9,
    row4+row7, row9,
    row4+row7, row9,
    row5+row7, row9,
    row6, 0
    },
    {
    //f 31 (25+6)
    row6, 0,
    row3+row4+row5+row6+row7+row8, row9,
    row2+row6, 0,
    row2, 0,
    row3, 0,
    0, 0
    },
    {
    //g 32(25+7)
    row6, row9,
    row5+row7, 0,
    row4+row8, 0,
    row4+row8, 0,
    row5+row7, 0,
    row6+row7+row8, row9
    },
    {
    //h 33(25+8)
    allRows, row9,
    row5, 0, 
    row4, 0, 
    row4, 0,
    row4, 0, 
    row5+row6+row7+row8, row9
    },
    {
    //i 34 (25+9)
    0, 0,
    0, 0,
    row3+row6+row7+row8, row9,
    0, 0,
    0, 0,
    0, 0
    },
    {
    //j 35 (25+10)
    row8, 0,
    0, row9,
    0, row9,
    row2+row5+row6+row7+row8, 0,
    0, 0,
    0, 0
    },
    {
    //k 36 (25+11)
    row3+row4+row5+row6+row7+row8, row9,
    row6, 0, 
    row6, 0, 
    row5+row7, 0,
    row4+row8, row9,
    0, 0
    },
    {
    //l 37 (25+12)
    0, 0,
    0, 0,
    row3+row4+row5+row6+row7+row8, row9,
    0, 0,
    0, 0,
    0, 0
    },
    {
    //m 38 (25+13)
    row4+row5+row6+row7+row8, row9,
    row5+row6, 0,
    row7, 0,
    row7, 0,
    row5+row6, 0,
    row4+row5+row6+row7+row8, row9
    },
    {
    //n 39 (25+14)
    row4+row5+row6+row7+row8, row9, 
    row5, 0,
    row4, 0,
    row4, 0,
    row5, 0,
    row6+row7+row8, row9
    },
    {
    //o 40 (25+15)
    row6+row7, 0,
    row5+row8, 0,
    row4, row9,
    row4, row9,
    row5+row8, 0,
    row6+row7, 0
    },
    {
    //p 41 (25+16)
    row6+row7+row8, row9,
    row5+row7, 0,
    row4+row8, 0,
    row4+row8, 0,
    row5+row7, 0,
    row6, 0
    },
    {
    //q 42 (25+17)
    row6, 0,
    row5+row7, 0,
    row4+row8, 0,
    row4+row8, 0,
    row5+row7, 0,
    row6+row7+row8, row9
    },
    {
    //r 43 (25+18)
    row6+row7+row8, row9,
    row5, 0,
    row4, 0,
    row4, 0,
    row5, 0,
    0, 0
    },
    {
    //s 44 (25+19)
    row5, row9,
    row4+row6, row9,
    row4+row6, row9,
    row4+row6, row9,
    row4+row7+row8, 0,
    0, 0
    },
    {
    //t 45 (25+20)
    0, 0,
    row5, 0,
    row3+row4+row5+row6+row7+row8, row9,
    row5, 0,
    0, 0,
    0, 0
    },
    {
    //u 46 (25+21)
    row4+row5+row6+row7+row8, 0,
    0, row9,
    0, row9,
    0, row9,
    row4+row5+row6+row7+row8, 0,
    0, 0
    },
    {
    //v 47 (25+22)
    row4+row5+row6+row7, 0,
    row8, 0,
    0, row9,
    row8, 0, 
    row4+row5+row6+row7, 0,
    0, 0
    },
    {
    //w 48 (25+23)
    row4+row5+row6+row7+row8, 0,
    0, row9,
    row8, 0,
    row8, 0,
    0, row9,
    row4+row5+row6+row7+row8, 0
    },
    {
    //x 49 (25+24)
    row4, row9,
    row5+row8, 0,
    row6+row7, 0, 
    row5+row8, 0,
    row4, row9,
    0, 0
    },
    {
    //y 50 (25+25)
    row4+row5, 0,
    row6, row9,
    row7+row8, 0,
    row6, 0,
    row4+row5, 0,
    0, 0
    },
    {
    //z 51 (25+26)
    0, 0,
    row4+row8, row9,
    row4+row7, row9,
    row4+row6, row9,
    row5, row9,
    0, 0
    },
    
    
    /*
    NUMBERS
    */
    
    
    
    {
    //0 52 (25+26+1)
    row2+row3+row4+row5+row6+row7+row8, 0,
    row1+row7, row9,
    row1+row5+row6, row9,
    row1+row3+row4, row9,
    row1+row2, row9,
    row2+row3+row4+row5+row6+row7+row8, 0
    },
    {
    //1 53  (25+26+2)
    0, row9,
    row1, row9,
    row1, row9,
    allRows, row9,
    0, row9,
    0, row9
    },
    {
    //2 54  (25+26+3)
    row2+row8, row9,
    row1+row7, row9,
    row1+row6, row9,
    row1+row5, row9,
    row1+row4, row9,
    row2+row3, row9
    },
    {
    //3 55  (25+26+4)
    row2+row8, 0,
    row1, row9,
    row1+row4, row9,
    row1+row4, row9,
    row1+row4, row9,
    row2+row3+row4+row5+row6+row7+row8, 0
    },
    {
    //4 56 (25+26+5)
    row4+row5, 0,
    row3+row5, 0,
    row2+row5, 0, 
    row1+row5, 0, 
    allRows, row9,
    row5, 0
    },
    {
    //5 57 (25+26+6)
    row2+row3+row4+row5, 0,
    row1+row5, row9,
    row1+row3, row9,
    row1+row3, row9,
    row1+row4+row8, 0,
    row1+row6+row7, 0
    },
    {
    //6 58 (25+26+7)
    row3+row4+row5+row6+row7, 0,
    row2+row5+row8, 0,
    row1+row4, row9,
    row1+row4, row9,
    row1+row5+row8, 0,
    row1+row6+row7, 0
    },
    {
    //7 59 (25+26+8)
    row2, 0,
    row1, 0,
    row1, 0,
    row1+row7+row8, row9,
    row1+row4+row5, 0,
    row2+row3+row4, 0
    },
    {
    //8 60  (25+26+9)
    row3+row7, 0,
    row2+row4+row6+row8, 0,
    row1+row4, row9,
    row1+row4, row9,
    row2+row4+row6+row8, 0,
    row3+row7, 0
    },
    {
    //9 61 (25+26+10)
    row3, 0,
    row2+row4+row8, 0,
    row1+row5, row9,
    row1+row5, row9,
    row2+row4+row8, 0,
    row3+row4+row5+row6+row7, 0
    },
    
    
    /*
    SYMBOLS
    */
    {
    //) 62  (25+26+11)
    0, 0,
    row1, row9,
    row2+row8, 0,
    row3+row4+row5+row6+row7, 0,
    0, 0,
    0, 0
    },
    {
    //! 63  (25+26+12)
    0, 0,
    0, 0,
    row2+row3+row4+row5+row6+row8, 0,
    0, 0,
    0, 0,
    0, 0
    },
    {
    //@ 64  (25+26+13)
    row3+row4+row5+row6, 0,
    row2+row7, 0,
    row1+row4+row5+row8, 0,
    row1+row3+row6+row8, 0,
    row1+row4+row5+row8, 0,
    row2+row3+row4+row5+row6, 0
    },
    {
    //# 65  (25+26+14)
    row4+row7, 0,
    row2+row3+row4+row5+row6+row7+row8, row9,
    row4+row7, 0,
    row2+row3+row4+row5+row6+row7+row8, row9,
    row4+row7, 0,
    0, 0
    },
    {
    //$ 66  (25+26+15)
    row3+row4+row7, 0,
    row2+row5+row8, 0,
    row1+row2+row5+row8, row9,
    row2+row5+row8, 0,
    row3+row6+row7, 0,
    0, 0
    },
    {
    //% 67 (25+26+16)
    row2+row8, row9,
    row1+row3+row7, 0,
    row2+row6, 0,
    row4+row5+row8, 0,
    row3+row7, row9,
    row1+row2+row8, 0
    },
    {
    //^ 68 (25+26+17)
    row4, 0,
    row3, 0,
    row2, 0,
    row3, 0,
    row4, 0,
    0, 0
    },
    {
    //& 69 (25+26+18)
    row3+row7+row8, 0,
    row2+row4+row6, row9,
    row1+row5, row9,
    row1+row4+row6+row8, 0,
    row2+row3+row7, 0,
    row6+row8, row9
    },
    {
    //* 70 (25+26+19)
    row3+row5+row7, 0,
    row4+row6, 0,
    row5, 0,
    row4+row6, 0,
    row3+row5+row7, 0,
    0, 0
    },
    {
    //( 71 (25+26+20)
    0, 0,
    row3+row4+row5+row6+row7, 0,
    row2+row8, 0,
    row1, 0,
    0, 0,
    0, 0
    },
    {
    //` 72 (25+26+21)
    0, 0,
    0, 0,
    row2, 0,
    row3, 0,
    0, 0, 
    0, 0
    },
    {
    //~ 73 (25+26+22)
    row4, 0,
    row3, 0,
    row4, 0,
    row5, 0,
    row6, 0,
    row5, 0
    },
    {
    //- 74 (25+26+23)
    0, 0,
    row5, 0,
    row5, 0,
    row5, 0,
    row5, 0,
    0, 0
    },
    {
    //_ 75  (25+26+24)
    0, row9,
    0, row9,
    0, row9,
    0, row9,
    0, row9,
    0, row9
    },
    {
    //= 76 (25+26+25)
    0, 0,
    row4+row6, 0,
    row4+row6, 0,
    row4+row6, 0,
    row4+row6, 0,
    0, 0
    },
    {
    //+ 77 (25+26+26)
    row5, 0,
    row5, 0,
    row3+row4+row5+row6+row7, 0,
    row5, 0,
    row5, 0,
    0, 0
    },
    {
    //[ 78 (25+26+27)
    0, 0,
    row2+row3+row4+row5+row6+row7+row8, 0,
    row2, row8,
    row2, row8,
    0, 0, 
    0, 0
    },
    {
    //{ 79 (25+26+28)
    0, 0,
    0, 0,
    row5, 0,
    row2+row3+row4+row6+row7+row8, 0,
    row2+row8,
    0, 0
    },
    {
    //] 80 (25+26+29)
    0, 0, 
    0, 0,
    row2+row8, 0,
    row2+row8, 0, 
    row2+row3+row4+row5+row6+row7+row8, 0,
    0, 0, 
    },
    {
    //} 81 (25+26+30)
    0, 0,
    row2+row8, 0,
    row2+row3+row4+row6+row7+row8, 0,
    row5, 0,
    0, 0,
    0, 0
    },
    {
    //\ 82  (25+26+31)
    0, 0,
    row2+row3, 0,
    row4+row5, 0,
    row6+row7, 0,
    row8, row9,
    0, 0
    },
    {
    //| 83  (25+26+32)
    0, 0, 
    0, 0,
    0, 0,
    row1+row2+row3+row4+row6+row7+row8, row9,
    0, 0,
    0, 0
    },
    {
    //; 84  (25+26+33)
    0, 0,
    0, 0,
    row8, 0,
    row4+row7, 0,
    0, 0, 
    0, 0
    },
    {
    //: 85 (25+26+34)
    0, 0,
    0, 0,
    0, 0, 
    row4+row7, 0,
    0, 0,
    0, 0
    },
    {
    //" 86 (25+26+35)
    0, 0,
    row2+row3, 0,
    0, 0,
    0, 0,
    row2+row3, 0,
    0, 0
    },
    {
    //' 87 (25+26+36)
    0, 0,
    row2+row3, 0,
    0, 0,
    0, 0,
    0, 0,
    0, 0
    },
    {
    //< 88 (25+26+37)
    0, 0,
    row5, 0,
    row4+row6, 0,
    row3+row7, 0,
    row2+row8, 0,
    0, 0
    },
    {
    //. 89 (25+26+38)
    0, 0, 
    0, 0,
    0, 0,
    0, 0,
    row8, 0,
    0, 0
    },
    {
    //> 90 (25+26+39)
    0, 0,
    row2+row8, 0,
    row3+row7, 0,
    row4+row6, 0,
    row5, 0,
    0, 0
    },
    {
    /// 91 (25+26+40)
    0, 0,
    row8, row9,
    row6+row7, 0,
    row4+row5, 0,
    row2+row3, 0,
    0, 0
    },
    {
    //? 92 (25+26+41)
    0, 0, 
    row3, 0,
    row2, 0,
    row1+row5+row6, row9,
    row2+row4, 0,
    row3, 0
    },
    {
    // spacebar 93
        0, 0,
        0, 0,
        0, 0,
        0, 0,
        0, 0,
        0, 0
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
        PORTD = 0b01111111;
        PORTA = 0x00;

/************************* REFERENCE COLUMN 1 **************************/
    for(int k=0; k<12; k++){

        if((start < 21)){
           PORTC = column[start];  //holds address of PORTD, columns 0-7
           PORTD &= 0b10111111;   //control line for DMUX 1
           PORTA = 0x00;
        }
        else if (start < 36){
                PORTC = column[start];  //columns 7-13
                PORTD &= 0b11011111;
                PORTA = 0x00;
        }
        else if (start < 51){
                PORTC = column[start];  //columns 30-45
                PORTD &= 0b11101111;
                PORTA = 0x00;
        }
        else if (start < 66){
                PORTC = column[start];  //columns 45-60
                PORTD &= 0b11110111;
                PORTA = 0x00;
        }
        else if (start < 81){
                PORTC = column[start];  //columns 66-80
                PORTD &= 0b11111011;
                PORTA = 0x00;
        }
        else if (start < 96){
                PORTC = column[start];  //columns 81-95
                PORTD &= 0b11111101;
                PORTA = 0x00;
        }
        else if (start < 111){
                PORTC = column[start];  //columns 96-110
                PORTD &= 0b11111110;
                PORTA = 0x00;
        }
        else{
                PORTC = 0x00;
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
    int offset = 0;
    int streamChars[12] = {7,4,11,11,14,93,22,14,17,11,3};  //this array will probs be maxed at 140 (for tweets) 
    int numChars = 11;  //this should be like arraysize(streamChars); it should return the number of actual characters used in array
    init_ports();

    index = 112;  //DEBUG... reset before entering loop

    while(1){


       // test(111);
       // test(0);
        //index += 15;

        //display(1, 36);
        //display(3, index + 43);
        //display(0, index + 50);
        //display(24, index + 57);
        
        if(index>(-(numChars * 7)-1)){  //number of characters times # of columns for each(6 columns + space) 
            
            


            for(int i = 0; i < numChars; i++){
                if((index + offset) > (-1)){
                    display(streamChars[i],(index + offset));
                    offset += 7;
                }
                else{
                    offset +=7;
                    for(int j=0; j <= (i * 15); j++); //delay needs to increase to compensate for non displayed letters
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
           index = 112;
        } 
    }
}
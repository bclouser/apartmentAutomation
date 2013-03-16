#line 1 "C:/Users/Home/apartmentAutomation/LEDTicker/MyProject.c"



int counter = 0x00;

const int row1 = 0b10000000;
const int row2 = 0b01000000;
const int row3 = 0b00100000;
const int row4 = 0b00010000;
const int row5 = 0b00001000;
const int row6 = 0b00000100;
const int row7 = 0b00000010;
const int row8 = 0b00000001;
const int row9 = 0b10000000;
const int allRows = 0xFF;

const int column[90] = {
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
#line 45 "C:/Users/Home/apartmentAutomation/LEDTicker/MyProject.c"
const int characters[1][12] = {
 {
 allRows, row9, row1 + row5, 0, row1 + row5, 0, row1 + row5 + row6, 0,
 row1 + row5 + row7, 0, row4 + row3 + row2 + row8, row9 },
#line 79 "C:/Users/Home/apartmentAutomation/LEDTicker/MyProject.c"
};

int index = 0;

int *portSelection;

int *beA = &PORTA;

sbit bit0 at PORTA.B0;
sbit bit1 at PORTA.B1;


void init_ports(){
 PORTA = 0x00;
 TRISA = 0x00;
 PORTB = 0x00;
 TRISB = 0x00;
 PORTC = 0x00;
 TRISC = 0x00;
 PORTD = 0x00;
 TRISD = 0x00;
}

void capitalR(int charNum, int start){

 int i = 0;
 PORTB = 0x00;
 PORTC = 0x00;
 PORTD = 0x00;
 PORTA = 0x00;


 if(start < 15){
 PORTC = column[start];
 PORTD |= 0b01000000;
 PORTA = 0x00;

 }
 else if (start < 28){
 PORTC = column[start];
 PORTD |= 0b00100000;
 PORTA = 0x00;

 }
 else if (start < 29){
 PORTA |= column[start];
 PORTC = 0x00;
 PORTD &= row9;
 }
 start++;
 PORTB = characters[charNum][0];
 PORTD |= characters[charNum][1];
 for(i=0; i<20; i++);
 PORTA = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;
 PORTD = 0x00;
 PORTE = 0x00;




 if(start < 15){
 PORTC = column[start];
 PORTD |= 0b01000000;
 PORTA = 0x00;

 }
 else if (start < 28){
 PORTC = column[start];
 PORTD |= 0b00100000;
 PORTA = 0x00;

 }
 else if (start < 29){
 PORTA |= column[start];
 PORTC = 0x00;
 PORTD &= row9;
 }
 start++;
 PORTB = characters[charNum][2];
 PORTD |= characters[charNum][3];
 for(i=0; i<20; i++);
 PORTA = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;
 PORTD = 0x00;
 PORTE = 0x00;





 if(start < 15){
 PORTC = column[start];
 PORTD |= 0b01000000;
 PORTA = 0x00;

 }
 else if (start < 28){
 PORTC = column[start];
 PORTD |= 0b00100000;
 PORTA = 0x00;

 }
 else if (start < 29){
 PORTA |= column[start];
 PORTC = 0x00;
 PORTD = 0x00;
 }
 start++;
 PORTB = characters[charNum][4];
 PORTD |= characters[charNum][5];
 for(i=0; i<20; i++);
 PORTA = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;
 PORTD = 0X00;
 PORTE = 0x00;



 if(start < 15){
 PORTC = column[start];
 PORTD |= 0b01000000;
 PORTA = 0x00;

 }
 else if (start < 28){
 PORTC = column[start];
 PORTD |= 0b00100000;
 PORTA = 0x00;

 }
 else if (start < 29){
 PORTA |= column[start];
 PORTC = 0x00;
 PORTD &= row9;
 }
 start++;
 PORTB = characters[charNum][6];
 PORTD |= characters[charNum][7];
 for(i=0; i<20; i++);
 PORTA = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;
 PORTD = 0x00;
 PORTE = 0x00;




 if(start < 15){
 PORTC = column[start];
 PORTD |= 0b01000000;
 PORTA = 0x00;

 }
 else if (start < 28){
 PORTC = column[start];
 PORTD |= 0b00100000;
 PORTA = 0x00;

 }
 else if (start < 29){
 PORTA |= column[start];
 PORTC = 0x00;
 PORTD &= row9;
 }
 start++;
 PORTB = characters[charNum][8];
 PORTD |= characters[charNum][9];
 for(i=0; i<20; i++);
 PORTA = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;
 PORTD = 0x00;
 PORTE = 0x00;




 if(start < 15){
 PORTC = column[start];
 PORTD |= 0b01000000;
 PORTA = 0x00;

 }
 else if (start < 28){
 PORTC = column[start];
 PORTD |= 0b00100000;
 PORTA = 0x00;

 }
 else if (start < 29){
 PORTA |= column[start];
 PORTC = 0x00;
 PORTD &= row9;
 }
 start++;
 PORTB = characters[charNum][10];
 PORTD |= characters[charNum][11];
 for(i=0; i<20; i++);
 PORTA = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;
 PORTD = 0x00;
 PORTE = 0x00;




 if(start < 15){
 PORTC = column[start];
 PORTD |= 0b01000000;
 PORTA = 0x00;

 }
 else if (start < 28){
 PORTC = column[start];
 PORTD |= 0b00100000;
 PORTA = 0x00;

 }
 else if (start < 29){
 PORTA |= column[start];
 PORTC = 0x00;
 PORTD = 0x00;
 }
 start++;
 PORTB = 0x00;
 PORTD &= ~row9;
 for(i=0; i<20; i++);
 PORTA = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;
 PORTD = 0x00;
 PORTE = 0x00;


 if(start < 15){
 PORTC = column[start];
 PORTD |= 0b01000000;
 PORTA = 0x00;

 }
 else if (start < 28){
 PORTC = column[start];
 PORTD |= 0b00100000;
 PORTA = 0x00;

 }
 else if (start < 29){
 PORTA |= column[start];
 PORTC = 0x00;
 PORTD = 0x00;
 }
 PORTB = 0x00;
 PORTD &= ~row9;
 for(i=0; i<20; i++);
 PORTA = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;
 PORTD = 0x00;
 PORTE = 0x00;
}



void test(int start){
 PORTB = 0xff;
 PORTD = 0b10100000;


 PORTC = 0b11110000;
 delay_ms(500);

 PORTC = 0b11100000;
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
}


void main() {

 init_ports();
 delay_ms(20);


 while(1){


 capitalR(0, index);



 if(counter > 90){
 if(index < 29)
 index++;
 else
 index = 0x00;

 counter = 0x00;
 }
 else
 counter++;

 }
}

#line 1 "C:/Users/Home/Google Drive/Freelance_MicroProcessing/KC104_Lights_WSerialCommands/KC104_Lights-2.c"
#line 9 "C:/Users/Home/Google Drive/Freelance_MicroProcessing/KC104_Lights_WSerialCommands/KC104_Lights-2.c"
static const int dataPin = 0b00010000;
static const int pulsePin = 0b00100000;
static const int parityPin = 0b01000000;
static const int flashDelay = 200;
static const int pulseDelay = 20;
char currentStatus = 'f';




void sendStatus(char lightStatus){
 int i = 0;
 PORTB &= 0b10001111;

 TRISB &= 0b10101111;
 delay_ms(5);
 PORTB |= (parityPin + dataPin);



 while(!(PORTB & pulsePin));
 delay_ms(1);
 while(!(PORTB & pulsePin));
 delay_ms(1);
 while(PORTB & pulsePin);
 delay_ms(5);
 PORTB &= 0b10001111;
 delay_ms(1);
 TRISB &= 0b10001111;


 if(lightStatus == 'o'){
 for(i=0; i<8; i++){

 PORTB |= dataPin;
 PORTB |= pulsePin;

 delay_ms(pulseDelay);
 PORTB &= 0b10001111;
 delay_ms(pulseDelay);
 }
 }
 else if(lightStatus == 'f'){
 for(i=0; i<8; i++){

 PORTB &= 0b10001111;
 PORTB |= pulsePin;

 delay_ms(pulseDelay);
 PORTB &= 0b10001111;
 delay_ms(pulseDelay);
 }
 }

 PORTB |= 0b01010000;
 PORTB |= pulsePin;
 delay_ms(pulseDelay);
 PORTB &= 0b10001111;
 TRISB |= 0b01110000;
 return;
}



void init_ports(void){
 OSCCON = 0x71;
 ANSEL=0x00;
 ANSELH = 0x00;
 CM1CON0 = 0x00;
 CM2CON0 = 0x00;
 IOCB = 0b00000000;

 TRISA=0x00;

 PORTB = 0x00;
 TRISB=0b01111111;
 PORTC = 0x00;
 TRISC=0b00000111;

 PORTA = 0x00;
}

void main(void){

 int lightsTemp[9];
 int lightsFinal[9];
 long j = 0;
 int i = 0;
 int k = 0;
 char currentToSend = 'n';
 long timeOut = 50000;
 int dataPin = 0b00010000;
 int pulsePin = 0b00100000;
 int parityPin = 0b01000000;


 init_ports();
 PORTC |= 0b11111000;
 delay_ms(2000);
 PORTC &= 0b00000111;
 while(1){

 if((PORTB & 0b01110000) == (dataPin + parityPin)){
 j = 0;
 for(i = 0; i < 9; i++ ){
 while((!(PORTB & pulsePin)) ){
 PORTA = 0b00000001;
 j++;
 }
 delay_ms(1);

 if( i < 8)
 lightsTemp[i] = (PORTB & dataPin);
 else if(i == 8)
 lightsTemp[i] = (PORTB & (dataPin + parityPin));

 while((PORTB & pulsePin) ){
 PORTA = 0b00000100;
 j++;
 }
 delay_ms(1);
#line 133 "C:/Users/Home/Google Drive/Freelance_MicroProcessing/KC104_Lights_WSerialCommands/KC104_Lights-2.c"
 }

 if((lightsTemp[8] == (dataPin + parityPin)) ){


 for(i = 0; i < 8; i++){
 lightsFinal[i] = lightsTemp[i];
 }


 PORTC &= 0b00000111;
 PORTB &= 0b01111111;



 if(lightsFinal[1])
 PORTC |= 0b10000000;
 if(lightsFinal[2])
 PORTC = 0b01000000;
 if(lightsFinal[3])
 PORTC |= 0b00001000;
 if(lightsFinal[4])
 PORTC |= 0b00010000;
 if(lightsFinal[5])
 PORTC |= 0b00100000;


 if(!((PORTB & 0b10000000) || (PORTC & 0b11111000)))
 currentStatus = 'f';
 else
 currentStatus = 'o';

 while(PORTB & 0b01110000);
 }
 }


 else if(PORTC & 0b00000001){
 delay_ms(15);
 if(PORTC & 0b00000001){

 if(currentStatus == 'o'){
 currentStatus = 'f';
 currentToSend = 'f';
 PORTC &= 0b00000111;
 }
 else if(currentStatus == 'f'){
 currentStatus = 'o';
 currentToSend = 'o';
 PORTC |= 0b11111000;
 }
 sendStatus(currentToSend);
 }
 }
 while(PORTC & 0b00000001);
 PORTB &= 0b10001111;
 currentToSend = 0;
 }
}

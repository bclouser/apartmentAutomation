#line 1 "C:/Users/Home/apartmentAutomation/KC104_SidePartShades/PartingShades.c"
#line 4 "C:/Users/Home/apartmentAutomation/KC104_SidePartShades/PartingShades.c"
static const int dataPin = 0b00010000;
static const int pulsePin = 0b00100000;
static const int parityPin = 0b01000000;
static const int flashDelay = 200;
static const int pulseDelay = 20;

void init_ports(void){
 OSCCON = 0x71;
 ANSEL=0x00;
 ANSELH = 0x00;
 CM1CON0 = 0x00;
 CM2CON0 = 0x00;
 IOCB = 0b00000000;

 TRISA=0x00;

 PORTB = 0x00;
 TRISB=0xFF;
 PORTC = 0x00;
 TRISC=0b10000111;

 PORTA = 0x00;
}


void blinkLights(void){
 PORTA = 0xFF;
 delay_ms(flashDelay);
 PORTA = 0x00;
 delay_ms(flashDelay);
 PORTA = 0xFF;
 delay_ms(flashDelay);
 PORTA = 0x00;
 delay_ms(flashDelay);
 PORTA = 0xFF;
 delay_ms(flashDelay);
 PORTA = 0x00;
 delay_ms(flashDelay);
 PORTA = 0xFF;
 delay_ms(flashDelay);
 PORTA = 0x00;
 delay_ms(flashDelay);
 PORTA = 0xFF;
 delay_ms(flashDelay);
 PORTA = 0x00;
 delay_ms(flashDelay);
 PORTA = 0xFF;
 delay_ms(flashDelay);
 PORTA = 0x00;
}


int *getCommand(void){
 int commandTemp[9];
 static int commandFinal[9];
 long j = 0;
 int i = 0;
 int k = 0;
 long timeOut = 50000;
 int error = 0;

 j = 0;
 for(i = 0; i < 9; i++ ){
 while((!(PORTB & pulsePin)) ){
 j++;
 }
 delay_ms(1);

 if( i < 8)
 commandTemp[i] = (PORTB & dataPin);
 else if(i == 8)
 commandTemp[i] = (PORTB & (dataPin + parityPin));

 while((PORTB & pulsePin) ){
 j++;
 }
 delay_ms(1);
#line 84 "C:/Users/Home/apartmentAutomation/KC104_SidePartShades/PartingShades.c"
 }

 if((commandTemp[8] == (dataPin + parityPin)) ){
 for(i = 0; i < 8; i++) {
 commandFinal[i] = commandTemp[i];
 }

 return commandFinal;
 }
 else{
 blinkLights();
 while(PORTB & 0b01110000);
 return 0;
 }
}

void openShades(long setTimeOut){
 long timeOut = 0;
 PORTA = 0b00000001;
 while(!(PORTC & 0b10000000) && (timeOut < setTimeOut)){
 delay_ms(300);




 if(PORTC & 0b00000001){
 delay_ms(50);
 if(PORTC & 0b00000001){

 timeOut=setTimeOut;
 }
 }

 timeOut++;
 }

 PORTA = 0x00;
 timeOut = 0;
}

void closeShades(long setTimeOut){
 long timeOut = 0;
 PORTA = 0b00000010;
 while(!(PORTB & 0b10000000) && (timeOut < setTimeOut)){
 delay_ms(300);




 if(PORTC & 0b00000001){
 delay_ms(50);
 if(PORTC & 0b00000001){

 timeOut=setTimeOut;
 }
 }

 timeOut++;
 }
 PORTA = 0x00;
 timeOut = 0;
}

void sendStatus(char shadeStatus){
 int i = 0;
 PORTB = 0x00;


 TRISB &= 0b10101111;
 delay_ms(5);
 PORTB |= (parityPin + dataPin);
 delay_ms(1);


 while(!(PORTB & pulsePin));
 delay_ms(1);
 while(PORTB & pulsePin);
 delay_ms(5);
 PORTB &= 0b10001111;
 delay_ms(1);
 TRISB &= 0b10001111;


 if(shadeStatus == 'o'){
 for(i=0; i<8; i++){

 PORTB |= dataPin;
 PORTB |= pulsePin;

 delay_ms(pulseDelay);
 PORTB &= 0b10001111;
 delay_ms(pulseDelay);
 }
 }
 else if(shadeStatus == 'c'){
 for(i=0; i<8; i++){

 PORTB |= 0x00;
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
 TRISB = 0xFF;
 return;
}


main(){
 long timeOut = 0;

 long setTimeOut = 1000000;
 int *currentCommand;
 char currentSetting = 'c';
 int k = 0;
 int i = 0;

 init_ports();


 while(1){

 if((PORTB & 0b01110000) == (dataPin + parityPin)){
 currentCommand = getCommand();
#line 230 "C:/Users/Home/apartmentAutomation/KC104_SidePartShades/PartingShades.c"
 if (*currentCommand == dataPin){
 openShades(setTimeOut);
 currentSetting = 'o';
 }
 else if(*(currentCommand +1) == 0x00){
 closeShades(setTimeOut);
 currentSetting = 'c';
 }
 while(PORTB & 0b01110000);
 }

 else if(PORTC & 0b00000001){
 delay_ms(1);
 if(PORTC & 0b00000001){
 if(currentSetting == 'c'){
 openShades(setTimeOut);
 sendStatus('o');
 currentSetting = 'o';
 }
 else if(currentSetting =='o'){
 closeShades(setTimeOut);
 sendStatus('c');
 currentSetting = 'c';
 }
 }
 }
 }
}

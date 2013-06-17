#line 1 "C:/Users/Home/apartmentAutomation/KeyPadWithWeb18f4620/KeyPadWithWeb18f4620.c"
#line 8 "C:/Users/Home/apartmentAutomation/KeyPadWithWeb18f4620/KeyPadWithWeb18f4620.c"
char psw[4] = {'1', '2', '3', '4'};
const int delay1 = 200;
const int delay2 = 200;
const int parityPin = 0b01000000;
const int pulsePin = 0b00100000;
const int dataPin = 0b00010000;
const int unlockDoorCmd = 0b11111111;
const int lockDoorCmd =0b00000000;

int timeOutLimit = 500;
long resetLimit = 80000;
long lockLimit = 3000;

const int moveMotorLock = 600;
const int moveMotorUnlock = 600;


static const int pulseDelay = 5;
char currentStatus = 'u';

void init_ports(){
 PORTB = 0;
 TRISB = 0b00011111;
 PORTC = 0x00;
 TRISC = 0b11110000;
 PORTA = 0x00;
 TRISA &= 0b00000001;
 PORTD = 0x00;
 TRISD = 0x00;

}


void ADCInit(){
 ADCON1 = 0b00000111;


 ADCON2 = 0x8A;

}


int ADCRead( unsigned char ch){

 ADCON0 = 0x00;
 ADCON0 = (ch<<2);
 ADON_bit = 1;
 GO_DONE_bit =1;

 while(GO_DONE_bit);
 ADON_bit =0;

 return (ADRESL + (255*ADRESH));
 }


 char checkColumn1(){
 PORTB = 0b00100000;
 delay_ms(1);

 if((PORTB & 0b00011111) == 0b00000010){
 return '1';
 }
 else if ((PORTB & 0b00011111) == 0b00000100){
 return '4';
 }
 else if ((PORTB & 0b00011111) == 0b00001000){
 return '7';
 }
 else if ((PORTB & 0b00011111) == 0b00010000){
 return '*';
 }
 else return 0;
}

char checkColumn2(){
 PORTB = 0b01000000;
 delay_ms(1);


 if((PORTB & 0b00011111) == 0b00000010){
 return '2';
 }
 else if ((PORTB & 0b00011111) == 0b00000100){
 return '5';
 }
 else if ((PORTB & 0b00011111) == 0b00001000){
 return '8';
 }
 else if ((PORTB & 0b00011111) == 0b00010000){
 return '0';
 }
 else return 0;
}

char checkColumn3(){
 PORTB = 0b10000000;
 delay_ms(1);

 if((PORTB & 0b00011111) == 0b00000010){
 return '3';
 }
 else if ((PORTB & 0b00011111) == 0b00000100){
 return '6';
 }
 else if ((PORTB & 0b00011111) == 0b00001000){
 return '9';
 }
 else if ((PORTB & 0b00011111) == 0b00010000){
 return '#';
 }
 else return 0;
}

int checkPassword(){
 int counter = 0;
 long resetCounter = 0;
 long lockCounter = 0;
 int i = 0;
 int keysPressed = 0;

 while(1){
 counter++;
 if(checkColumn1()){
 keysPressed++;
 counter = 0;

 if(checkColumn1() == psw[i]){
 i++;
 }
 else
 i = 0;

 while(PORTB & 0b00010000){
 resetCounter++;
 if((resetCounter >= resetLimit) && (i == 0)){
 return -1;
 }
 }
 resetCounter = 0;
 while(PORTB & 0b00011110);
 }
 else if(checkColumn2()){
 keysPressed++;
 counter = 0;

 if(checkColumn2() == psw[i])
 i++;
 else
 i = 0;

 while(PORTB & 0b00011110);
 }
 else if(checkColumn3()){
 keysPressed++;
 counter = 0;

 if(checkColumn3() == psw[i])
 i++;
 else
 i = 0;

 while((PORTB & 0b00010000) && (i == 0)){
 lockCounter++;
 if((lockCounter >= lockLimit) && (i == 0)){
 return 7;
 }
 }
 lockCounter = 0;

 while(PORTB & 0b00011110);
 }

 if(counter >= timeOutLimit)
 return 0;

 if(keysPressed == 4){
 if(i == 4){
 i = 0;
 keysPressed = 0;
 return 1;
 }
 else{
 i = 0;
 keysPressed = 0;
 return 0;
 }
 }
 }
}
#line 201 "C:/Users/Home/apartmentAutomation/KeyPadWithWeb18f4620/KeyPadWithWeb18f4620.c"
int newPassword(){
 char temp1[sizeof(psw)];
 char temp2[sizeof(psw)];
 int counter = 0;
 int i = 0;
 int keysPressed = 0;
 int j = 0;
 int confirmed = 0;
 PORTA |= 0b00001000;

 while((counter <= timeOutLimit) && keysPressed < 4){
 counter++;
 if(checkColumn1()){
 keysPressed++;
 counter = 0;

 temp1[i] = checkColumn1();
 i++;

 while(PORTB & 0b00011110);
 }
 else if(checkColumn2()){
 keysPressed++;
 counter = 0;

 temp1[i] = checkColumn2();
 i++;

 while(PORTB & 0b00011110);
 }
 else if(checkColumn3()){
 keysPressed++;
 counter = 0;

 temp1[i] = checkColumn3();
 i++;

 while(PORTB & 0b00011110);
 }
 }

 if(keysPressed != 4)
 return 0;

 else if(keysPressed == 4){
 PORTA |= 0b00001010;

 delay_ms(delay1);
 PORTA &= 0b11111101;
 PORTA |= 0b00001000;


 keysPressed = 0;
 i = 0;
 counter = 0;
 while(counter < timeOutLimit && keysPressed < 4){
 if(checkColumn1()){
 keysPressed++;
 counter = 0;

 temp2[i] = checkColumn1();
 i++;

 while(PORTB & 0b00011110);
 }
 else if(checkColumn2()){
 keysPressed++;
 counter = 0;

 temp2[i] = checkColumn2();
 i++;

 while(PORTB & 0b00011110);
 }
 else if(checkColumn3()){
 keysPressed++;
 counter = 0;

 temp2[i] = checkColumn3();
 i++;

 while(PORTB & 0b00011110);
 }
 }
 if(keysPressed != 4)
 return 0;

 else if(keysPressed == 4){
 for(j = 0; j < sizeof(psw); j++){
 if(temp1[j] == temp2[j])
 confirmed ++;
 else
 confirmed = 0;
 }
 if(confirmed == sizeof(psw)){
 for(j = 0; j < sizeof(psw); j++){
 psw[j] = temp1[j];
 }
 return 1;
 }
 else
 return 0;
 }
 }
}


void resetMode(){
 PORTA &= 0b11110111;
 delay_ms(15);
 PORTA |= 0b00001000;

 if(checkPassword() == 1){
 PORTA |= 0b00001010;
 delay_ms(delay1);
 PORTA &= 0b11111101;


 if(newPassword()){
 PORTA |= 0b00001010;
 delay_ms(delay1);
 PORTA &= 0b11111101;

 }
 else{
 PORTA |= 0b00000100;

 }
 }
 else{
 PORTA |= 0b00000100;


 }
}


void moveLock(){
 long moveTimer = 800000;
 int j = 0;
 PORTA |= 0b00010010;
 delay_ms(50);

 while((ADCRead(0) <= 600) && j<moveTimer){
 j++;
 }
 j=0;
 PORTA &= 0b11101111;
 delay_ms(100);
 PORTA |= 0b00100010;
 delay_ms(50);

 while((ADCRead(0) >=300) && j<moveTimer){
 j++;
 }

 j=0;
 PORTA &= 0b11011111;
 delay_ms(2);
}

void moveUnlock(){
 long moveTimer = 800000;
 int j = 0;
 PORTA |= 0b00100010;
 delay_ms(50);

 while((ADCRead(0) >= 165) && j<moveTimer){
 j++;
 }

 j=0;
 PORTA &= 0b11011111;
 delay_ms(100);
 PORTA |= 0b00010000;
 delay_ms(50);

 while((ADCRead(0) <= 300) && j<moveTimer){
 j++;
 }

 PORTA &= 0b11101111;
 j=0;
 delay_ms(2);
}


int getCommand(void){
 int commandTemp[9];
 long j = 0;
 int i = 0;
 int k = 0;
 long timeOut = 50000;
 int error = 0;
 int result = 0;

 int binaryArray[8]={128,64,32,16,8,4,2,1};


 j = 0;
 for(i = 0; i < 9; i++ ){
 while((!(PORTC & pulsePin)) ){
 j++;
 }
 delay_ms(1);

 if( i < 8)
 commandTemp[i] = (PORTC & dataPin);
 else if(i == 8)
 commandTemp[i] = (PORTC & (dataPin + parityPin));

 while((PORTC & pulsePin) ){
 j++;
 }
 delay_ms(1);
#line 419 "C:/Users/Home/apartmentAutomation/KeyPadWithWeb18f4620/KeyPadWithWeb18f4620.c"
 }
 PORTA = 0x00;

 if((commandTemp[8] == (dataPin + parityPin)) ){
 result = 0;
 for (i = 0; i<9; i++){
 if (commandTemp[i] && (i<8)){
 result += binaryArray[i];
 }
 }
 return result;
 }
 else{


 while(PORTC & 0b01110000);
 return -1;
 }
}



void sendStatus(char doorStatus){
 int i = 0;
 PORTC &= 0b10001111;

 TRISC &= 0b10101111;
 delay_ms(5);
 PORTC |= (parityPin + dataPin);



 while(!(PORTC & pulsePin));
 delay_ms(1);
 while(!(PORTC & pulsePin));
 delay_ms(1);
 while(PORTC & pulsePin);
 delay_ms(5);
 PORTC &= 0b10001111;
 delay_ms(1);
 TRISC &= 0b10001111;


 if(doorStatus == 'l'){
 for(i=0; i<8; i++){

 PORTC |= dataPin;
 PORTC |= pulsePin;

 delay_ms(pulseDelay);
 PORTC &= 0b10001111;
 delay_ms(pulseDelay);
 }
 }
 else if(doorStatus == 'u'){
 for(i=0; i<8; i++){
 if(i<4){
 PORTC &= 0b10001111;
 PORTC |= pulsePin;
 }
 else{
 PORTC |= dataPin;
 PORTC |= pulsePin;
 }
 delay_ms(pulseDelay);
 PORTC &= 0b10001111;
 delay_ms(pulseDelay);
 }
 }

 PORTC |= 0b01010000;
 PORTC |= pulsePin;
 delay_ms(pulseDelay);
 PORTC &= 0b10001111;
 TRISC |= 0b01110000;
 return;
}



void main() {
 int input = 0;
 int x = 0;
 int lockTimer = 100;
 int keypadCmd = 0;
 char currentToSend = 'n';
 init_ports();
 ADCInit();




 while(1){

 if((PORTC & 0b01010000) == 0b01010000){
 keypadCmd = getCommand();


 if(keypadCmd == unlockDoorCmd){
 moveUnlock();
 }
 else if(keypadCmd == lockDoorCmd){
 moveLock();
 }
 }


 if(PORTC & 0b10000000){
 delay_ms(15);
 if(PORTC & 0b10000000){
 if(currentStatus == 'u'){
 currentStatus = 'l';
 currentToSend = 'l';
 moveLock();
 }
 else if(currentStatus == 'l'){
 currentStatus = 'u';
 currentToSend = 'u';
 moveUnlock();
 }
 sendStatus(currentStatus);
 }
 }
 PORTC &= 0b10001111;
 currentToSend = 0;



 PORTB = 0b11100000;
 if(PORTB & 0b00011110){
 input = checkPassword();
 if(input == 1){
 PORTA |= 0b00000010;
 moveUnlock();
 PORTA = 0x00;
 }
 else if(input == (-1)){
 PORTA |= 0b00001000;
 delay_ms(delay1);
 resetMode();
 PORTA = 0x00;
 }
 else if(input == 7){
 PORTA |= 0b00000010;
 moveLock();
 PORTA = 0x00;
 }
 else{
 PORTA = 0b00000100;
 delay_ms(delay1);
 PORTA = 0x00;
 }
 }
 }
}

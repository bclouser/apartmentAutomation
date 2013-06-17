/*This code is written for use with a PIC18F4620. 
It is written to control a deadbolt lock mechanism with both a
keypad on the outside of the door as well as web control. */

/*Last updated, Ben Clouser, March 10 2013*/


char psw[4] = {'1', '2', '3', '4'};
const int delay1 = 200;
const int delay2 = 200; //probs unecessary
const int parityPin = 0b01000000;
const int pulsePin = 0b00100000;
const int dataPin = 0b00010000;
const int unlockDoorCmd = 0b11111111;
const int lockDoorCmd =0b00000000;

int timeOutLimit = 500;   //good at 8mhz
long resetLimit = 80000;   //good at 8mhz
long lockLimit = 3000;   //currently testing

const int moveMotorLock = 600;
const int moveMotorUnlock = 600;  //theoretically these should be the same.


static const int pulseDelay = 5;  // how long to pulse during communications
char currentStatus = 'u'; // 'u' = unlocked, or 'l' = locked

void init_ports(){
    PORTB = 0;               //initializes port for use  (keypad on PORTB)
    TRISB = 0b00011111;      // data direction control, 0 for output 1 for input
    PORTC = 0x00;
    TRISC = 0b11110000; //RC4, RC5, and RC6 for web and RC7 for toggle button
    PORTA = 0x00;               // 0 is output
    TRISA &= 0b00000001;
    PORTD = 0x00;
    TRISD = 0x00;

}

//ADC conversion and outputting digital value on leds
void ADCInit(){ //configuring A/D module
    ADCON1 = 0b00000111; //channels AN8-An12 are digital and AN0-AN7 are analog
    //Vref+ = Vdd and Vref- = Vss

    ADCON2 = 0x8A; //Right justified, Tad=2xacquisition time
    //conversion clock = 32Tosc
}

 //function to read ADC channel
int ADCRead( unsigned char ch){

    ADCON0 = 0x00;//configuring analog channel
    ADCON0 = (ch<<2); //selecting analog channel
    ADON_bit = 1; //switch on adc module
    GO_DONE_bit =1;//Start conversion

    while(GO_DONE_bit); //wait for the conversion to finish
    ADON_bit =0; //switch off adc

    return (ADRESL + (255*ADRESH));  // puts all ten bits into one variable (math might be off)
 }


 char checkColumn1(){                //checks the first column of the keypad
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

char checkColumn2(){  //checks the second column of the keypad
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

char checkColumn3(){   //checks the third column of the keypad
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
        counter++;  //for timeouts
        if(checkColumn1()){
            keysPressed++;
            counter = 0;  //reset timeout counter

            if(checkColumn1() == psw[i]){
                i++;
            }
            else
                i = 0;
            //checks for reset button being held to enter the reset mode
            while(PORTB & 0b00010000){ // the asterisk key
                resetCounter++;
                if((resetCounter >= resetLimit) && (i == 0)){
                      return -1;
                }
            }
            resetCounter = 0;
            while(PORTB & 0b00011110); //debounce
        }
        else if(checkColumn2()){
            keysPressed++;
            counter = 0;

            if(checkColumn2() == psw[i])
                i++;
            else
                i = 0;

            while(PORTB & 0b00011110); //debounce
        }
        else if(checkColumn3()){
            keysPressed++;
            counter = 0;

            if(checkColumn3() == psw[i])
                i++;
            else
                i = 0;

            while((PORTB & 0b00010000) && (i == 0)){ // the pound key
                lockCounter++;
                if((lockCounter >= lockLimit) && (i == 0)){
                    return 7;
                }
            }
            lockCounter = 0;

            while(PORTB & 0b00011110); //debounce
        }

        if(counter >= timeOutLimit)    // timeout
              return 0;

        if(keysPressed == 4){
            if(i == 4){
                i = 0;
                keysPressed = 0;
                return 1;   // the password was correct
            }
            else{          //password wrong
                i = 0;
                keysPressed = 0;
                return 0;  // the password was wrong
            }
        }
    }
}

/*THIS RETURNS A 1 IF THE TWO PASSWORDS MATCH AND ARE THEREFORE CONFIRMED
IN ALL OTHER SITUATIONS IT RETURNS A 0*/
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

            while(PORTB & 0b00011110); //debounce
        }
        else if(checkColumn2()){
            keysPressed++;
            counter = 0;

            temp1[i] = checkColumn2();
            i++;

            while(PORTB & 0b00011110); //debounce
        }
        else if(checkColumn3()){
            keysPressed++;
            counter = 0;

            temp1[i] = checkColumn3();
            i++;

            while(PORTB & 0b00011110); //debounce
        }
    }

    if(keysPressed != 4)    // the user timed out
        return 0;

    else if(keysPressed == 4){
        PORTA |= 0b00001010; //green led (keeping reset led on)
        //BEEP because you need to confirm the password
        delay_ms(delay1);
        PORTA &= 0b11111101;
                    PORTA |= 0b00001000;

        /*move onto confirming the password just entered*/
        keysPressed = 0;
        i = 0;
        counter = 0;
        while(counter < timeOutLimit && keysPressed < 4){
            if(checkColumn1()){
                keysPressed++;
                counter = 0;

                temp2[i] = checkColumn1();
                i++;

                while(PORTB & 0b00011110); //debounce
            }
            else if(checkColumn2()){
                keysPressed++;
                counter = 0;

                temp2[i] = checkColumn2();
                i++;

                while(PORTB & 0b00011110); //debounce
            }
            else if(checkColumn3()){
                keysPressed++;
                counter = 0;

                temp2[i] = checkColumn3();
                i++;

                while(PORTB & 0b00011110); //debounce
            }
        }
        if(keysPressed != 4)    // the user timed out
            return 0;

        else if(keysPressed == 4){
            for(j = 0; j < sizeof(psw); j++){
                if(temp1[j] == temp2[j])
                    confirmed ++;
                else
                    confirmed = 0;
            }
            if(confirmed == sizeof(psw)){  // two passwords match, so change overall password
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
    PORTA &= 0b11110111; //flashes blue LED indicating that the current password should be input
    delay_ms(15);
    PORTA |= 0b00001000;

    if(checkPassword() == 1){ // password verified time to enter & verify new password
        PORTA |= 0b00001010; //green LED
        delay_ms(delay1);
        PORTA &= 0b11111101;
        //BEEP would be good here!

        if(newPassword()){   //prompts for new password, confirms, and changes
              PORTA |= 0b00001010;  //green LED
              delay_ms(delay1);
              PORTA &= 0b11111101;
              //BEEP would be good here!
        }
        else{
              PORTA |= 0b00000100;  //red led
              //offensive beep indicating your two passwords were incorrect
        }
    }
    else{
        PORTA |= 0b00000100; //red led
        //offensive beep indicating the password was wrong, timeout
        // or you tried to enter reset mode while you were in reset mode!!!
    }
}


void moveLock(){
	long moveTimer = 800000;
	int j = 0;
    PORTA |= 0b00010010;  //unlock direction
    delay_ms(50); //avoid voltage spike

    while((ADCRead(0) <= 600) && j<moveTimer){ //wait until motor has moved far enough
        j++;  //wait, count though
    }    
    j=0;
    PORTA &= 0b11101111; //turn motor off
    delay_ms(100);
    PORTA |= 0b00100010; // lock direction
    delay_ms(50); //to allow any voltage spike to simmer down

    while((ADCRead(0) >=300) && j<moveTimer){ //wait for Home position
        j++;
    }

    j=0;
    PORTA &= 0b11011111;
    delay_ms(2);
}

void moveUnlock(){
	long moveTimer = 800000;
	int j = 0;
    PORTA |= 0b00100010;  //lock direction
    delay_ms(50); //avoid voltage spike

    while((ADCRead(0) >= 165) && j<moveTimer){
		j++;
    }

    j=0;
    PORTA &= 0b11011111;  //turn off
    delay_ms(100);
    PORTA |= 0b00010000;  //unlock direction
    delay_ms(50); //voltage spike protection

    while((ADCRead(0) <= 300) && j<moveTimer){  //home position
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
	// for converting decimal to binary... its important!
	int binaryArray[8]={128,64,32,16,8,4,2,1};
	//PORTA = 0b00000011;

	j = 0; //clear the counter
	for(i = 0; i < 9; i++ ){  //all 8 bits of data and the closing bracket. 9 total
		while((!(PORTC & pulsePin))  ){ //  && (j < timeOut)){ // wait till pulse starts
			j++;
		}
		delay_ms(1); //tiny delay to ensure we have good data before writing it

		if( i < 8)
			commandTemp[i] = (PORTC & dataPin); // WRITE DATA
		else if(i == 8)
			commandTemp[i] = (PORTC & (dataPin + parityPin));  // closing bracket

		while((PORTC & pulsePin)  ){   //&& (j < timeOut)){ // wait till pulse is over
			j++;
		}
		delay_ms(1); //tiny delay to ensure pulse is really over before starting again

		/* if(j >= timeOut)
				break; // leaves the FOR loop because we timed out */
	}
	PORTA = 0x00;

	if((commandTemp[8] == (dataPin + parityPin))   ){  // && (j < timeOut)){  //all went well
		result = 0;
		for (i = 0; i<9; i++){
			if (commandTemp[i] && (i<8)){
				result += binaryArray[i];
			}
		}
		return result;
	}
	else{  //something is wrong

		//blinkLights();
		while(PORTC & 0b01110000);  // wait until port B is clean before continuing
		return -1;  //something is wrong
	}
}

//when we get a finalized sending sequence it will go here.
 /* FUNCTION THAT SENDS A REPORT OF THE CURRENT STATUS BACK TO THE ARDI*/
void sendStatus(char doorStatus){  // o = on, f = off
	int i = 0;
	PORTC &= 0b10001111;

	TRISC &= 0b10101111;// changes to output leaves pulse pin as an input
	delay_ms(5);
	PORTC |= (parityPin + dataPin); //stick out our thumb

	//wait for the ardi to acknowledge
	//we have something to say
	while(!(PORTC & pulsePin));// wait for ardi pulse
	delay_ms(1);
	while(!(PORTC & pulsePin));
	delay_ms(1);
	while(PORTC & pulsePin); //wait for pulse to end
	delay_ms(5); //give ardi time to change dataDirection, usually real quick (5)
	PORTC &= 0b10001111;
	delay_ms(1);
	TRISC &= 0b10001111; //lastly puts pulse pin to output

	//and finally send...
	if(doorStatus == 'l'){  //0b11111111
		for(i=0; i<8; i++){
			//writes all ones
			PORTC |= dataPin;
			PORTC |= pulsePin;

			delay_ms(pulseDelay);
			PORTC &= 0b10001111;  //clears comm pins
			delay_ms(pulseDelay);
		}
	}
	else if(doorStatus == 'u'){ //0b11110000 turns all pins to zero
		for(i=0; i<8; i++){
			if(i<4){
				PORTC &= 0b10001111; //clear
				PORTC |= pulsePin;  //pulse
			}
			else{
				PORTC |= dataPin;
				PORTC |= pulsePin;
			}
			delay_ms(pulseDelay);
			PORTC &= 0b10001111;  //clears comm pins
			delay_ms(pulseDelay);
		}
	}
			//***********CLOSING FRAME***********//
	PORTC |= 0b01010000;
	PORTC |= pulsePin;
	delay_ms(pulseDelay);
	PORTC &= 0b10001111; //clear comm pins
	TRISC |= 0b01110000;  //sets comm pins back to input
	return;
}



void main() {
    int input = 0;
    int x = 0;
    int lockTimer = 100;
    int keypadCmd = 0;
    char currentToSend = 'n';  //null
    init_ports();
    ADCInit();  // initialize A/D
    //delay_ms(100);
    //moveLock();
    //delay_ms(1000);
    //moveUnlock();  //debug for testing potentiometer
	while(1){

		if((PORTC & 0b01010000) == 0b01010000){ //opening frame. The arduino is sending a command
			keypadCmd = getCommand();
			//PORTD = keypadCmd;   //debug
			//delay_ms(2000);
			if(keypadCmd == unlockDoorCmd){
				moveUnlock();
			}
			else if(keypadCmd == lockDoorCmd){
				moveLock();
			}
		}

		/************** Toggle Button *************/
		if(PORTC & 0b10000000){ //direction from the wall panel, toggles on or off
			delay_ms(15); 		//noise check
			if(PORTC & 0b10000000){
				if(currentStatus == 'u'){ //it was unlocked, so lock it
					currentStatus = 'l';
					currentToSend = 'l';
					moveLock();  //locks door
				}
				else if(currentStatus == 'l'){  //it was locked, so unlock it
					currentStatus = 'u';
					currentToSend = 'u';
					moveUnlock(); //unlock the door
				}
				sendStatus(currentStatus);  //sends the command
			}
		}
		PORTC &= 0b10001111; //turns off comm pins
		currentToSend = 0;    // resets it for next time


			/**************** keypad *******************/
        PORTB = 0b11100000;
        if(PORTB & 0b00011110){
            input = checkPassword();
            if(input == 1){ // password correct
                PORTA |= 0b00000010; //green led
                moveUnlock();
                PORTA = 0x00;
            }
            else if(input == (-1)){ //enter reset mode
                PORTA |= 0b00001000;  //blue led
                delay_ms(delay1);
                resetMode();
                PORTA = 0x00;
            }
            else if(input == 7){   //lock button hit
                PORTA |= 0b00000010;  //green led
                moveLock();
                PORTA = 0x00;
            }
            else{                     //fail or timeout
                PORTA = 0b00000100; //red led
                delay_ms(delay1);
                PORTA = 0x00;
            }
        }  
    }
}
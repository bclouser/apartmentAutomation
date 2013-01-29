



static const int dataPin = 0b00010000;
static const int pulsePin = 0b00100000;
static const int parityPin = 0b01000000;
static const int flashDelay = 200;
static const int pulseDelay = 20;

void init_ports(void){
      OSCCON = 0x71;   //configures the internal oscillator
      ANSEL=0x00;        // Set inputs to digital
      ANSELH = 0x00;     //disables something that is holding pins RB5 and RB6
      CM1CON0 = 0x00;
      CM2CON0 = 0x00;
      IOCB = 0b00000000;

      TRISA=0x00;        // port a is an output

      PORTB = 0x00;
      TRISB=0xFF; //all of port B is an input... woot
      PORTC = 0x00;
      TRISC=0b10000111; //pins 3-6 are output, 0-2, 7 are input

      PORTA = 0x00;
}


void blinkLights(void){  // this is called to simply flash lights
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

        j = 0; //clear the counter
        for(i = 0; i < 9; i++ ){  //all 8 bits of data and the closing bracket. 9 total
                while((!(PORTB & pulsePin))  ){ //  && (j < timeOut)){ // wait till pulse starts
                        j++;
                }
                delay_ms(1); //tiny delay to ensure we have good data before writing it

                if( i < 8)
                        commandTemp[i] = (PORTB & dataPin); // WRITE DATA
                else if(i == 8)
                        commandTemp[i] = (PORTB & (dataPin + parityPin));  // closing bracket

                while((PORTB & pulsePin)  ){   //&& (j < timeOut)){ // wait till pulse is over
                        j++;
                }
                delay_ms(1); //tiny delay to ensure pulse is really over before starting again

                /* if(j >= timeOut)
                        break; // leaves the FOR loop because we timed out */

        }

        if((commandTemp[8] == (dataPin + parityPin))   ){  // && (j < timeOut)){  //all went well
			for(i = 0; i < 8; i++) {                           //put temp into final array
				commandFinal[i] = commandTemp[i];
			}

			return commandFinal;
        }
        else{
			blinkLights();
			while(PORTB & 0b01110000);  // wait until port B is clean before continuing
            return 0;  //something is wrong
        }
}

void openShades(long setTimeOut){
	long timeOut = 0;
	PORTA = 0b00000001;
		while(!(PORTC & 0b10000000) && (timeOut < setTimeOut)){
				//keep the shades opening until the sensors
				//produce logical 1 indicating the shades are now open
				//Or until ot times out
				timeOut++;
		}
		//delay_ms(100);
		PORTA = 0x00;  // turn motor off becuase of time out or sensor triggered
		timeOut = 0;
}

void closeShades(long setTimeOut){
	long timeOut = 0;
	PORTA = 0b00000010;
	while(!(PORTB & 0b10000000) && (timeOut < setTimeOut)){
		delay_ms(1);
			//keep the shades closing until the sensors
			//produce logical 1 indicating the shades are now closed
			//or until it times out
			timeOut++;
	}
	delay_ms(1);
	if(PORTB & 0b10000000){
		PORTA = 0x00; // turn motor off becuase of time out or sensor triggered
		timeOut = 0;
	}
}

void sendStatus(char shadeStatus){  // o = open, c = closed
	int i = 0;
	PORTB = 0x00;
	//PORTC = 0x00;

	TRISB &= 0b10101111;// changes to output leaves pulse pin as an input
	delay_ms(5);
	PORTB |= (parityPin + dataPin); //stick out our thumb
	delay_ms(1);
	//wait for the ardi to acknowledge
	//we have something to say
	while(!(PORTB & pulsePin));// ardi pulses when ready to listen
	delay_ms(1);
	while(PORTB & pulsePin); //wait for pulse to end
	delay_ms(5); //give ardi time to change dataDirection, usually real quick "1"
	PORTB &= 0b10001111;
	delay_ms(1);
	TRISB &= 0b10001111; //puts pulse pin to output

	//and finally send...
	if(shadeStatus == 'o'){  //0b11111111 is the open code
		for(i=0; i<8; i++){
			
			PORTB |= dataPin;  //set one
			PORTB |= pulsePin;
			
			delay_ms(pulseDelay);
			PORTB &= 0b10001111;  //clears comm pins
			delay_ms(pulseDelay);
		}
	}
	else if(shadeStatus == 'c'){  //0b00000000 is the close code
		for(i=0; i<8; i++){
			
			PORTB |= 0x00; //sets zero
			PORTB |= pulsePin;
			
			delay_ms(pulseDelay);
			PORTB &= 0b10001111;  //clears comm pins
			delay_ms(pulseDelay);
		}
	}
			//***********CLOSING FRAME***********//
	PORTB |= 0b01010000;
	PORTB |= pulsePin;
	delay_ms(pulseDelay);
	PORTB &= 0b10001111; //clear comm pins
	TRISB = 0xFF;
	return;
}

main(){
        long timeOut = 0;
		//safety precaution, the motor won't spin forever
		long setTimeOut = 1000000; //default 1000000
		int *currentCommand;
		char currentSetting = 'c'; //shades always start closed.
        int k = 0;
		int i = 0;

        init_ports();


	while(1){
		if((PORTB & 0b01110000) == (dataPin + parityPin)){ //initialization bracket
			currentCommand = getCommand();

			//for debug
			/* for(i=0; i<8; i){
				PORTC = 0xff;
				delay_ms(40);
				PORTC = 0x00;
				if(*(currentCommand+i) == dataPin){
					PORTA = 0b0000010;
				}
				else
					PORTA = 0b00000100;
				delay_ms(2000);
				PORTA = 0x00;
			} */

			if (*currentCommand == dataPin){   //if its 0b00000001
				openShades(setTimeOut); //Pin RA0 trips "open" relay
				currentSetting = 'o';
			}
			else if(*(currentCommand +1) == 0x00){ //0b00000000
				closeShades(setTimeOut); //Pin RA1 trips "close" relay
				currentSetting = 'c';
			}
			while(PORTB & 0b01110000);  // wait until port B is clean before continuing
		}

		else if(PORTC & 0b00000001){
		delay_ms(1); //debounce
			if(PORTC & 0b00000001){  // OPEN THE SHADES
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
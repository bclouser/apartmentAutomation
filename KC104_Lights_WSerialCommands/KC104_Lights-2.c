/* This is the code for the Light settings in KC104
It will accept commands from the ardi, as well as from
the wall panel

Chip: pic16F690
Date: (6/21/12)
*/

static const int dataPin = 0b00010000;  //RB4
static const int pulsePin = 0b00100000;  //RB5
static const int parityPin = 0b01000000;  //RB6
static const int flashDelay = 200;  //obsolete, consider deleting
static const int pulseDelay = 20;  // how long to pulse during communications
char currentStatus = 'f'; // 'o' = on, or 'f' = off



                        /* FUNCTION THAT SENDS A REPORT OF THE CURRENT STATUS BACK TO THE ARDI*/
void sendStatus(char lightStatus){  // o = on, f = off
	int i = 0;
	PORTB &= 0b10001111;

	TRISB &= 0b10101111;// changes to output leaves pulse pin as an input
	delay_ms(5);
	PORTB |= (parityPin + dataPin); //stick out our thumb

	//wait for the ardi to acknowledge
	//we have something to say
	while(!(PORTB & pulsePin));// wait for ardi pulse
	delay_ms(1);
	while(!(PORTB & pulsePin));  
	delay_ms(1);
	while(PORTB & pulsePin); //wait for pulse to end
	delay_ms(5); //give ardi time to change dataDirection, usually real quick "1"
	PORTB &= 0b10001111;
	delay_ms(1);
	TRISB &= 0b10001111; //puts pulse pin to output

	//and finally send...
	if(lightStatus == 'o'){  //0b11111111 turns all lights on
		for(i=0; i<8; i++){
				//writes all ones
				PORTB |= dataPin;
				PORTB |= pulsePin;
			
			delay_ms(pulseDelay);
			PORTB &= 0b10001111;  //clears comm pins
			delay_ms(pulseDelay);
		}
	}
	else if(lightStatus == 'f'){ //0b00000000 turns all pins to zero
		for(i=0; i<8; i++){
			
			PORTB &= 0b10001111; //clear
			PORTB |= pulsePin;  //pulse
			
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
	TRISB |= 0b01110000;  //sets comm pins back to input
	return;
}


                                /* INITIALIZE DEM PORTS! */
void init_ports(void){
      OSCCON = 0x71;   //configures the internal oscillator
      ANSEL=0x00;        // Set inputs to digital
      ANSELH = 0x00;     //disables something that is holding pins RB5 and RB6
      CM1CON0 = 0x00;
      CM2CON0 = 0x00;
	  IOCB = 0b00000000;

      TRISA=0x00;        // port a is an output

      PORTB = 0x00;
      TRISB=0b01111111; //pin 7 is an output, 0-6 are input
      PORTC = 0x00;
      TRISC=0b00000111; //pins 3-7 are output, 0-2 are input

      PORTA = 0x00;
}

void main(void){

	int lightsTemp[9];
	int lightsFinal[9];
	long j = 0;
	int i = 0;
	int k = 0;
	char currentToSend = 'n';  //null
	long timeOut = 50000;
	int dataPin = 0b00010000;  //RB4
	int pulsePin = 0b00100000;  //RB5
	int parityPin = 0b01000000;  //RB6


    init_ports();
	PORTC |= 0b11111000;
	delay_ms(2000);
	PORTC &= 0b00000111;
	while(1){
		/************************ ~DIRECTION FROM THE ARDUINO~ ***************************/
		if((PORTB & 0b01110000) == (dataPin + parityPin)){ //initialization bracket
			j = 0; //clear the counter
			for(i = 0; i < 9; i++ ){  //all 8 bits of data and the closing bracket. 9 total
				while((!(PORTB & pulsePin))  ){ //  && (j < timeOut)){ // wait till pulse starts
					PORTA = 0b00000001; // counting while we wait
					j++;
				}
				delay_ms(1); //tiny delay to ensure we have good data before writing it

				if( i < 8)
					lightsTemp[i] = (PORTB & dataPin); // WRITE DATA
				else if(i == 8)
				    lightsTemp[i] = (PORTB & (dataPin + parityPin));  // closing bracket

				while((PORTB & pulsePin)  ){   //&& (j < timeOut)){ // wait till pulse is over
					PORTA = 0b00000100; // counting while we wait
					j++;
				}
				delay_ms(1); //tiny delay to ensure pulse is really over before starting again

				/* if(j >= timeOut)
					break; // leaves the FOR loop because we timed out */
			}

			if((lightsTemp[8] == (dataPin + parityPin))   ){  // && (j < timeOut)){  //all went well
				
				for(i = 0; i < 8; i++){   			 //put temp into final array
					lightsFinal[i] = lightsTemp[i];
				}	
				
				/*TURN ON THE SPECIFIED LIGHTS*/
				PORTC &= 0b00000111; //clear output pins on portC
				PORTB &= 0b01111111; //clear output PIN (SINGULAR) on PORTB
				
				//	PORTB |= 0b10000000; //msb, this is not working right now 11/27/12
				
				if(lightsFinal[1])
					PORTC |= 0b10000000;
				if(lightsFinal[2])
					PORTC = 0b01000000;
				if(lightsFinal[3])
					PORTC |= 0b00001000;   // the pins on the chip are not in ascending order
				if(lightsFinal[4])
					PORTC |= 0b00010000;
				if(lightsFinal[5])
					PORTC |= 0b00100000; 
						
				
				if(!((PORTB & 0b10000000) || (PORTC & 0b11111000))) // all lights off so set to off
					currentStatus = 'f'; 
				else
					currentStatus = 'o'; //sets it to on
					
				while(PORTB & 0b01110000);  // wait until port B is clean before continuing
			}
		}
		
		/************************ ~DIRECTION FROM THE WALL PANEL~ ***************************/
	     else if(PORTC & 0b00000001){ //direction from the wall panel, toggles on or off
			delay_ms(15); 		//debounce
			if(PORTC & 0b00000001){
			
				if(currentStatus == 'o'){ //it was on, so turn off
					currentStatus = 'f';
					currentToSend = 'f';
					PORTC &= 0b00000111;
				}
				else if(currentStatus == 'f'){  //it was off, so turn on
					currentStatus = 'o';
					currentToSend = 'o'; 
					PORTC |= 0b11111000;
				}
				sendStatus(currentToSend);  //sends the command
			}
		}
		while(PORTC & 0b00000001); // waits for user to get off the button!!!!
		PORTB &= 0b10001111; //turns off
		currentToSend = 0;    // resets it for next time 
	}
}


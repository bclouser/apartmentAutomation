
_sendStatus:

;KC104_Lights-2.c,19 :: 		void sendStatus(char lightStatus){  // o = on, f = off
;KC104_Lights-2.c,20 :: 		int i = 0;
	CLRF       sendStatus_i_L0+0
	CLRF       sendStatus_i_L0+1
;KC104_Lights-2.c,21 :: 		PORTB &= 0b10001111;
	MOVLW      143
	ANDWF      PORTB+0, 1
;KC104_Lights-2.c,23 :: 		TRISB &= 0b10101111;// changes to output leaves pulse pin as an input
	MOVLW      175
	ANDWF      TRISB+0, 1
;KC104_Lights-2.c,24 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_sendStatus0:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus0
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus0
	NOP
	NOP
;KC104_Lights-2.c,25 :: 		PORTB |= (parityPin + dataPin); //stick out our thumb
	MOVLW      80
	IORWF      PORTB+0, 1
;KC104_Lights-2.c,29 :: 		while(!(PORTB & pulsePin));// wait for ardi pulse
L_sendStatus1:
	BTFSC      PORTB+0, 5
	GOTO       L_sendStatus2
	GOTO       L_sendStatus1
L_sendStatus2:
;KC104_Lights-2.c,30 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_sendStatus3:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus3
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus3
	NOP
	NOP
;KC104_Lights-2.c,31 :: 		while(!(PORTB & pulsePin));
L_sendStatus4:
	BTFSC      PORTB+0, 5
	GOTO       L_sendStatus5
	GOTO       L_sendStatus4
L_sendStatus5:
;KC104_Lights-2.c,32 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_sendStatus6:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus6
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus6
	NOP
	NOP
;KC104_Lights-2.c,33 :: 		while(PORTB & pulsePin); //wait for pulse to end
L_sendStatus7:
	BTFSS      PORTB+0, 5
	GOTO       L_sendStatus8
	GOTO       L_sendStatus7
L_sendStatus8:
;KC104_Lights-2.c,34 :: 		delay_ms(5); //give ardi time to change dataDirection, usually real quick "1"
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_sendStatus9:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus9
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus9
	NOP
	NOP
;KC104_Lights-2.c,35 :: 		PORTB &= 0b10001111;
	MOVLW      143
	ANDWF      PORTB+0, 1
;KC104_Lights-2.c,36 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_sendStatus10:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus10
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus10
	NOP
	NOP
;KC104_Lights-2.c,37 :: 		TRISB &= 0b10001111; //puts pulse pin to output
	MOVLW      143
	ANDWF      TRISB+0, 1
;KC104_Lights-2.c,40 :: 		if(lightStatus == 'o'){  //0b11111111 turns all lights on
	MOVF       FARG_sendStatus_lightStatus+0, 0
	XORLW      111
	BTFSS      STATUS+0, 2
	GOTO       L_sendStatus11
;KC104_Lights-2.c,41 :: 		for(i=0; i<8; i++){
	CLRF       sendStatus_i_L0+0
	CLRF       sendStatus_i_L0+1
L_sendStatus12:
	MOVLW      128
	XORWF      sendStatus_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__sendStatus66
	MOVLW      8
	SUBWF      sendStatus_i_L0+0, 0
L__sendStatus66:
	BTFSC      STATUS+0, 0
	GOTO       L_sendStatus13
;KC104_Lights-2.c,43 :: 		PORTB |= dataPin;
	BSF        PORTB+0, 4
;KC104_Lights-2.c,44 :: 		PORTB |= pulsePin;
	BSF        PORTB+0, 5
;KC104_Lights-2.c,46 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus15:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus15
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus15
	NOP
	NOP
;KC104_Lights-2.c,47 :: 		PORTB &= 0b10001111;  //clears comm pins
	MOVLW      143
	ANDWF      PORTB+0, 1
;KC104_Lights-2.c,48 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus16:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus16
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus16
	NOP
	NOP
;KC104_Lights-2.c,41 :: 		for(i=0; i<8; i++){
	INCF       sendStatus_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       sendStatus_i_L0+1, 1
;KC104_Lights-2.c,49 :: 		}
	GOTO       L_sendStatus12
L_sendStatus13:
;KC104_Lights-2.c,50 :: 		}
	GOTO       L_sendStatus17
L_sendStatus11:
;KC104_Lights-2.c,51 :: 		else if(lightStatus == 'f'){ //0b00000000 turns all pins to zero
	MOVF       FARG_sendStatus_lightStatus+0, 0
	XORLW      102
	BTFSS      STATUS+0, 2
	GOTO       L_sendStatus18
;KC104_Lights-2.c,52 :: 		for(i=0; i<8; i++){
	CLRF       sendStatus_i_L0+0
	CLRF       sendStatus_i_L0+1
L_sendStatus19:
	MOVLW      128
	XORWF      sendStatus_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__sendStatus67
	MOVLW      8
	SUBWF      sendStatus_i_L0+0, 0
L__sendStatus67:
	BTFSC      STATUS+0, 0
	GOTO       L_sendStatus20
;KC104_Lights-2.c,54 :: 		PORTB &= 0b10001111; //clear
	MOVLW      143
	ANDWF      PORTB+0, 1
;KC104_Lights-2.c,55 :: 		PORTB |= pulsePin;  //pulse
	BSF        PORTB+0, 5
;KC104_Lights-2.c,57 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus22:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus22
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus22
	NOP
	NOP
;KC104_Lights-2.c,58 :: 		PORTB &= 0b10001111;  //clears comm pins
	MOVLW      143
	ANDWF      PORTB+0, 1
;KC104_Lights-2.c,59 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus23:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus23
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus23
	NOP
	NOP
;KC104_Lights-2.c,52 :: 		for(i=0; i<8; i++){
	INCF       sendStatus_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       sendStatus_i_L0+1, 1
;KC104_Lights-2.c,60 :: 		}
	GOTO       L_sendStatus19
L_sendStatus20:
;KC104_Lights-2.c,61 :: 		}
L_sendStatus18:
L_sendStatus17:
;KC104_Lights-2.c,63 :: 		PORTB |= 0b01010000;
	MOVLW      80
	IORWF      PORTB+0, 1
;KC104_Lights-2.c,64 :: 		PORTB |= pulsePin;
	BSF        PORTB+0, 5
;KC104_Lights-2.c,65 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus24:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus24
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus24
	NOP
	NOP
;KC104_Lights-2.c,66 :: 		PORTB &= 0b10001111; //clear comm pins
	MOVLW      143
	ANDWF      PORTB+0, 1
;KC104_Lights-2.c,67 :: 		TRISB |= 0b01110000;  //sets comm pins back to input
	MOVLW      112
	IORWF      TRISB+0, 1
;KC104_Lights-2.c,68 :: 		return;
;KC104_Lights-2.c,69 :: 		}
L_end_sendStatus:
	RETURN
; end of _sendStatus

_init_ports:

;KC104_Lights-2.c,73 :: 		void init_ports(void){
;KC104_Lights-2.c,74 :: 		OSCCON = 0x71;   //configures the internal oscillator
	MOVLW      113
	MOVWF      OSCCON+0
;KC104_Lights-2.c,75 :: 		ANSEL=0x00;        // Set inputs to digital
	CLRF       ANSEL+0
;KC104_Lights-2.c,76 :: 		ANSELH = 0x00;     //disables something that is holding pins RB5 and RB6
	CLRF       ANSELH+0
;KC104_Lights-2.c,77 :: 		CM1CON0 = 0x00;
	CLRF       CM1CON0+0
;KC104_Lights-2.c,78 :: 		CM2CON0 = 0x00;
	CLRF       CM2CON0+0
;KC104_Lights-2.c,79 :: 		IOCB = 0b00000000;
	CLRF       IOCB+0
;KC104_Lights-2.c,81 :: 		TRISA=0x00;        // port a is an output
	CLRF       TRISA+0
;KC104_Lights-2.c,83 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;KC104_Lights-2.c,84 :: 		TRISB=0b01111111; //pin 7 is an output, 0-6 are input
	MOVLW      127
	MOVWF      TRISB+0
;KC104_Lights-2.c,85 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;KC104_Lights-2.c,86 :: 		TRISC=0b00000111; //pins 3-7 are output, 0-2 are input
	MOVLW      7
	MOVWF      TRISC+0
;KC104_Lights-2.c,88 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;KC104_Lights-2.c,89 :: 		}
L_end_init_ports:
	RETURN
; end of _init_ports

_main:

;KC104_Lights-2.c,91 :: 		void main(void){
;KC104_Lights-2.c,95 :: 		long j = 0;
;KC104_Lights-2.c,96 :: 		int i = 0;
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
	MOVLW      110
	MOVWF      main_currentToSend_L0+0
	MOVLW      16
	MOVWF      main_dataPin_L0+0
	MOVLW      0
	MOVWF      main_dataPin_L0+1
	MOVLW      32
	MOVWF      main_pulsePin_L0+0
	MOVLW      0
	MOVWF      main_pulsePin_L0+1
	MOVLW      64
	MOVWF      main_parityPin_L0+0
	MOVLW      0
	MOVWF      main_parityPin_L0+1
;KC104_Lights-2.c,105 :: 		init_ports();
	CALL       _init_ports+0
;KC104_Lights-2.c,106 :: 		PORTC |= 0b11111000;
	MOVLW      248
	IORWF      PORTC+0, 1
;KC104_Lights-2.c,107 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	DECFSZ     R11+0, 1
	GOTO       L_main25
	NOP
;KC104_Lights-2.c,108 :: 		PORTC &= 0b00000111;
	MOVLW      7
	ANDWF      PORTC+0, 1
;KC104_Lights-2.c,109 :: 		while(1){
L_main26:
;KC104_Lights-2.c,111 :: 		if((PORTB & 0b01110000) == (dataPin + parityPin)){ //initialization bracket
	MOVLW      112
	ANDWF      PORTB+0, 0
	MOVWF      R3+0
	MOVF       main_parityPin_L0+0, 0
	ADDWF      main_dataPin_L0+0, 0
	MOVWF      R1+0
	MOVF       main_dataPin_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_parityPin_L0+1, 0
	MOVWF      R1+1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main70
	MOVF       R1+0, 0
	XORWF      R3+0, 0
L__main70:
	BTFSS      STATUS+0, 2
	GOTO       L_main28
;KC104_Lights-2.c,113 :: 		for(i = 0; i < 9; i++ ){  //all 8 bits of data and the closing bracket. 9 total
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main29:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main71
	MOVLW      9
	SUBWF      main_i_L0+0, 0
L__main71:
	BTFSC      STATUS+0, 0
	GOTO       L_main30
;KC104_Lights-2.c,114 :: 		while((!(PORTB & pulsePin))  ){ //  && (j < timeOut)){ // wait till pulse starts
L_main32:
	MOVF       main_pulsePin_L0+0, 0
	ANDWF      PORTB+0, 0
	MOVWF      R0+0
	MOVLW      0
	ANDWF      main_pulsePin_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main33
;KC104_Lights-2.c,115 :: 		PORTA = 0b00000001; // counting while we wait
	MOVLW      1
	MOVWF      PORTA+0
;KC104_Lights-2.c,117 :: 		}
	GOTO       L_main32
L_main33:
;KC104_Lights-2.c,118 :: 		delay_ms(1); //tiny delay to ensure we have good data before writing it
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	DECFSZ     R12+0, 1
	GOTO       L_main34
	NOP
	NOP
;KC104_Lights-2.c,120 :: 		if( i < 8)
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main72
	MOVLW      8
	SUBWF      main_i_L0+0, 0
L__main72:
	BTFSC      STATUS+0, 0
	GOTO       L_main35
;KC104_Lights-2.c,121 :: 		lightsTemp[i] = (PORTB & dataPin); // WRITE DATA
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	MOVF       main_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      main_lightsTemp_L0+0
	MOVWF      FSR
	MOVF       main_dataPin_L0+0, 0
	ANDWF      PORTB+0, 0
	MOVWF      R0+0
	MOVLW      0
	ANDWF      main_dataPin_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	GOTO       L_main36
L_main35:
;KC104_Lights-2.c,122 :: 		else if(i == 8)
	MOVLW      0
	XORWF      main_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main73
	MOVLW      8
	XORWF      main_i_L0+0, 0
L__main73:
	BTFSS      STATUS+0, 2
	GOTO       L_main37
;KC104_Lights-2.c,123 :: 		lightsTemp[i] = (PORTB & (dataPin + parityPin));  // closing bracket
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	MOVF       main_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      main_lightsTemp_L0+0
	MOVWF      FSR
	MOVF       main_parityPin_L0+0, 0
	ADDWF      main_dataPin_L0+0, 0
	MOVWF      R0+0
	MOVF       main_dataPin_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_parityPin_L0+1, 0
	MOVWF      R0+1
	MOVF       PORTB+0, 0
	ANDWF      R0+0, 1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
L_main37:
L_main36:
;KC104_Lights-2.c,125 :: 		while((PORTB & pulsePin)  ){   //&& (j < timeOut)){ // wait till pulse is over
L_main38:
	MOVF       main_pulsePin_L0+0, 0
	ANDWF      PORTB+0, 0
	MOVWF      R0+0
	MOVLW      0
	ANDWF      main_pulsePin_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main39
;KC104_Lights-2.c,126 :: 		PORTA = 0b00000100; // counting while we wait
	MOVLW      4
	MOVWF      PORTA+0
;KC104_Lights-2.c,128 :: 		}
	GOTO       L_main38
L_main39:
;KC104_Lights-2.c,129 :: 		delay_ms(1); //tiny delay to ensure pulse is really over before starting again
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_main40:
	DECFSZ     R13+0, 1
	GOTO       L_main40
	DECFSZ     R12+0, 1
	GOTO       L_main40
	NOP
	NOP
;KC104_Lights-2.c,113 :: 		for(i = 0; i < 9; i++ ){  //all 8 bits of data and the closing bracket. 9 total
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;KC104_Lights-2.c,133 :: 		}
	GOTO       L_main29
L_main30:
;KC104_Lights-2.c,135 :: 		if((lightsTemp[8] == (dataPin + parityPin))   ){  // && (j < timeOut)){  //all went well
	MOVF       main_parityPin_L0+0, 0
	ADDWF      main_dataPin_L0+0, 0
	MOVWF      R1+0
	MOVF       main_dataPin_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_parityPin_L0+1, 0
	MOVWF      R1+1
	MOVF       main_lightsTemp_L0+17, 0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main74
	MOVF       R1+0, 0
	XORWF      main_lightsTemp_L0+16, 0
L__main74:
	BTFSS      STATUS+0, 2
	GOTO       L_main41
;KC104_Lights-2.c,138 :: 		for(i = 0; i < 8; i++){   			 //put temp into final array
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main42:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main75
	MOVLW      8
	SUBWF      main_i_L0+0, 0
L__main75:
	BTFSC      STATUS+0, 0
	GOTO       L_main43
;KC104_Lights-2.c,139 :: 		lightsFinal[i] = lightsTemp[i];
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	MOVF       main_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      main_lightsFinal_L0+0
	MOVWF      R2+0
	MOVF       R0+0, 0
	ADDLW      main_lightsTemp_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;KC104_Lights-2.c,138 :: 		for(i = 0; i < 8; i++){   			 //put temp into final array
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;KC104_Lights-2.c,140 :: 		}
	GOTO       L_main42
L_main43:
;KC104_Lights-2.c,143 :: 		PORTC &= 0b00000111; //clear output pins on portC
	MOVLW      7
	ANDWF      PORTC+0, 1
;KC104_Lights-2.c,144 :: 		PORTB &= 0b01111111; //clear output PIN (SINGULAR) on PORTB
	MOVLW      127
	ANDWF      PORTB+0, 1
;KC104_Lights-2.c,148 :: 		if(lightsFinal[1])
	MOVF       main_lightsFinal_L0+2, 0
	IORWF      main_lightsFinal_L0+3, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main45
;KC104_Lights-2.c,149 :: 		PORTC |= 0b10000000;
	BSF        PORTC+0, 7
L_main45:
;KC104_Lights-2.c,150 :: 		if(lightsFinal[2])
	MOVF       main_lightsFinal_L0+4, 0
	IORWF      main_lightsFinal_L0+5, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main46
;KC104_Lights-2.c,151 :: 		PORTC = 0b01000000;
	MOVLW      64
	MOVWF      PORTC+0
L_main46:
;KC104_Lights-2.c,152 :: 		if(lightsFinal[3])
	MOVF       main_lightsFinal_L0+6, 0
	IORWF      main_lightsFinal_L0+7, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main47
;KC104_Lights-2.c,153 :: 		PORTC |= 0b00001000;   // the pins on the chip are not in ascending order
	BSF        PORTC+0, 3
L_main47:
;KC104_Lights-2.c,154 :: 		if(lightsFinal[4])
	MOVF       main_lightsFinal_L0+8, 0
	IORWF      main_lightsFinal_L0+9, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main48
;KC104_Lights-2.c,155 :: 		PORTC |= 0b00010000;
	BSF        PORTC+0, 4
L_main48:
;KC104_Lights-2.c,156 :: 		if(lightsFinal[5])
	MOVF       main_lightsFinal_L0+10, 0
	IORWF      main_lightsFinal_L0+11, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main49
;KC104_Lights-2.c,157 :: 		PORTC |= 0b00100000;
	BSF        PORTC+0, 5
L_main49:
;KC104_Lights-2.c,160 :: 		if(!((PORTB & 0b10000000) || (PORTC & 0b11111000))) // all lights off so set to off
	BTFSC      PORTB+0, 7
	GOTO       L_main51
	MOVLW      248
	ANDWF      PORTC+0, 0
	MOVWF      R0+0
	BTFSS      STATUS+0, 2
	GOTO       L_main51
	CLRF       R0+0
	GOTO       L_main50
L_main51:
	MOVLW      1
	MOVWF      R0+0
L_main50:
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main52
;KC104_Lights-2.c,161 :: 		currentStatus = 'f';
	MOVLW      102
	MOVWF      _currentStatus+0
	GOTO       L_main53
L_main52:
;KC104_Lights-2.c,163 :: 		currentStatus = 'o'; //sets it to on
	MOVLW      111
	MOVWF      _currentStatus+0
L_main53:
;KC104_Lights-2.c,165 :: 		while(PORTB & 0b01110000);  // wait until port B is clean before continuing
L_main54:
	MOVLW      112
	ANDWF      PORTB+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_main55
	GOTO       L_main54
L_main55:
;KC104_Lights-2.c,166 :: 		}
L_main41:
;KC104_Lights-2.c,167 :: 		}
	GOTO       L_main56
L_main28:
;KC104_Lights-2.c,170 :: 		else if(PORTC & 0b00000001){ //direction from the wall panel, toggles on or off
	BTFSS      PORTC+0, 0
	GOTO       L_main57
;KC104_Lights-2.c,171 :: 		delay_ms(15); 		//debounce
	MOVLW      39
	MOVWF      R12+0
	MOVLW      245
	MOVWF      R13+0
L_main58:
	DECFSZ     R13+0, 1
	GOTO       L_main58
	DECFSZ     R12+0, 1
	GOTO       L_main58
;KC104_Lights-2.c,172 :: 		if(PORTC & 0b00000001){
	BTFSS      PORTC+0, 0
	GOTO       L_main59
;KC104_Lights-2.c,174 :: 		if(currentStatus == 'o'){ //it was on, so turn off
	MOVF       _currentStatus+0, 0
	XORLW      111
	BTFSS      STATUS+0, 2
	GOTO       L_main60
;KC104_Lights-2.c,175 :: 		currentStatus = 'f';
	MOVLW      102
	MOVWF      _currentStatus+0
;KC104_Lights-2.c,176 :: 		currentToSend = 'f';
	MOVLW      102
	MOVWF      main_currentToSend_L0+0
;KC104_Lights-2.c,177 :: 		PORTC &= 0b00000111;
	MOVLW      7
	ANDWF      PORTC+0, 1
;KC104_Lights-2.c,178 :: 		}
	GOTO       L_main61
L_main60:
;KC104_Lights-2.c,179 :: 		else if(currentStatus == 'f'){  //it was off, so turn on
	MOVF       _currentStatus+0, 0
	XORLW      102
	BTFSS      STATUS+0, 2
	GOTO       L_main62
;KC104_Lights-2.c,180 :: 		currentStatus = 'o';
	MOVLW      111
	MOVWF      _currentStatus+0
;KC104_Lights-2.c,181 :: 		currentToSend = 'o';
	MOVLW      111
	MOVWF      main_currentToSend_L0+0
;KC104_Lights-2.c,182 :: 		PORTC |= 0b11111000;
	MOVLW      248
	IORWF      PORTC+0, 1
;KC104_Lights-2.c,183 :: 		}
L_main62:
L_main61:
;KC104_Lights-2.c,184 :: 		sendStatus(currentToSend);  //sends the command
	MOVF       main_currentToSend_L0+0, 0
	MOVWF      FARG_sendStatus_lightStatus+0
	CALL       _sendStatus+0
;KC104_Lights-2.c,185 :: 		}
L_main59:
;KC104_Lights-2.c,186 :: 		}
L_main57:
L_main56:
;KC104_Lights-2.c,187 :: 		while(PORTC & 0b00000001); // waits for user to get off the button!!!!
L_main63:
	BTFSS      PORTC+0, 0
	GOTO       L_main64
	GOTO       L_main63
L_main64:
;KC104_Lights-2.c,188 :: 		PORTB &= 0b10001111; //turns off
	MOVLW      143
	ANDWF      PORTB+0, 1
;KC104_Lights-2.c,189 :: 		currentToSend = 0;    // resets it for next time
	CLRF       main_currentToSend_L0+0
;KC104_Lights-2.c,190 :: 		}
	GOTO       L_main26
;KC104_Lights-2.c,191 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

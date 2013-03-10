
_init_ports:

;PartingShades.c,10 :: 		void init_ports(void){
;PartingShades.c,11 :: 		OSCCON = 0x71;   //configures the internal oscillator
	MOVLW      113
	MOVWF      OSCCON+0
;PartingShades.c,12 :: 		ANSEL=0x00;        // Set inputs to digital
	CLRF       ANSEL+0
;PartingShades.c,13 :: 		ANSELH = 0x00;     //disables something that is holding pins RB5 and RB6
	CLRF       ANSELH+0
;PartingShades.c,14 :: 		CM1CON0 = 0x00;
	CLRF       CM1CON0+0
;PartingShades.c,15 :: 		CM2CON0 = 0x00;
	CLRF       CM2CON0+0
;PartingShades.c,16 :: 		IOCB = 0b00000000;
	CLRF       IOCB+0
;PartingShades.c,18 :: 		TRISA=0x00;        // port a is an output
	CLRF       TRISA+0
;PartingShades.c,20 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;PartingShades.c,21 :: 		TRISB=0xFF; //all of port B is an input... woot
	MOVLW      255
	MOVWF      TRISB+0
;PartingShades.c,22 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;PartingShades.c,23 :: 		TRISC=0b10000111; //pins 3-6 are output, 0-2, 7 are input
	MOVLW      135
	MOVWF      TRISC+0
;PartingShades.c,25 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,26 :: 		}
L_end_init_ports:
	RETURN
; end of _init_ports

_blinkLights:

;PartingShades.c,29 :: 		void blinkLights(void){  // this is called to simply click the relays
;PartingShades.c,30 :: 		PORTA = 0xFF;
	MOVLW      255
	MOVWF      PORTA+0
;PartingShades.c,31 :: 		delay_ms(flashDelay);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_blinkLights0:
	DECFSZ     R13+0, 1
	GOTO       L_blinkLights0
	DECFSZ     R12+0, 1
	GOTO       L_blinkLights0
	DECFSZ     R11+0, 1
	GOTO       L_blinkLights0
;PartingShades.c,32 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,33 :: 		delay_ms(flashDelay);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_blinkLights1:
	DECFSZ     R13+0, 1
	GOTO       L_blinkLights1
	DECFSZ     R12+0, 1
	GOTO       L_blinkLights1
	DECFSZ     R11+0, 1
	GOTO       L_blinkLights1
;PartingShades.c,34 :: 		PORTA = 0xFF;
	MOVLW      255
	MOVWF      PORTA+0
;PartingShades.c,35 :: 		delay_ms(flashDelay);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_blinkLights2:
	DECFSZ     R13+0, 1
	GOTO       L_blinkLights2
	DECFSZ     R12+0, 1
	GOTO       L_blinkLights2
	DECFSZ     R11+0, 1
	GOTO       L_blinkLights2
;PartingShades.c,36 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,37 :: 		delay_ms(flashDelay);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_blinkLights3:
	DECFSZ     R13+0, 1
	GOTO       L_blinkLights3
	DECFSZ     R12+0, 1
	GOTO       L_blinkLights3
	DECFSZ     R11+0, 1
	GOTO       L_blinkLights3
;PartingShades.c,38 :: 		PORTA = 0xFF;
	MOVLW      255
	MOVWF      PORTA+0
;PartingShades.c,39 :: 		delay_ms(flashDelay);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_blinkLights4:
	DECFSZ     R13+0, 1
	GOTO       L_blinkLights4
	DECFSZ     R12+0, 1
	GOTO       L_blinkLights4
	DECFSZ     R11+0, 1
	GOTO       L_blinkLights4
;PartingShades.c,40 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,41 :: 		delay_ms(flashDelay);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_blinkLights5:
	DECFSZ     R13+0, 1
	GOTO       L_blinkLights5
	DECFSZ     R12+0, 1
	GOTO       L_blinkLights5
	DECFSZ     R11+0, 1
	GOTO       L_blinkLights5
;PartingShades.c,42 :: 		PORTA = 0xFF;
	MOVLW      255
	MOVWF      PORTA+0
;PartingShades.c,43 :: 		delay_ms(flashDelay);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_blinkLights6:
	DECFSZ     R13+0, 1
	GOTO       L_blinkLights6
	DECFSZ     R12+0, 1
	GOTO       L_blinkLights6
	DECFSZ     R11+0, 1
	GOTO       L_blinkLights6
;PartingShades.c,44 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,45 :: 		delay_ms(flashDelay);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_blinkLights7:
	DECFSZ     R13+0, 1
	GOTO       L_blinkLights7
	DECFSZ     R12+0, 1
	GOTO       L_blinkLights7
	DECFSZ     R11+0, 1
	GOTO       L_blinkLights7
;PartingShades.c,46 :: 		PORTA = 0xFF;
	MOVLW      255
	MOVWF      PORTA+0
;PartingShades.c,47 :: 		delay_ms(flashDelay);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_blinkLights8:
	DECFSZ     R13+0, 1
	GOTO       L_blinkLights8
	DECFSZ     R12+0, 1
	GOTO       L_blinkLights8
	DECFSZ     R11+0, 1
	GOTO       L_blinkLights8
;PartingShades.c,48 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,49 :: 		delay_ms(flashDelay);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_blinkLights9:
	DECFSZ     R13+0, 1
	GOTO       L_blinkLights9
	DECFSZ     R12+0, 1
	GOTO       L_blinkLights9
	DECFSZ     R11+0, 1
	GOTO       L_blinkLights9
;PartingShades.c,50 :: 		PORTA = 0xFF;
	MOVLW      255
	MOVWF      PORTA+0
;PartingShades.c,51 :: 		delay_ms(flashDelay);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_blinkLights10:
	DECFSZ     R13+0, 1
	GOTO       L_blinkLights10
	DECFSZ     R12+0, 1
	GOTO       L_blinkLights10
	DECFSZ     R11+0, 1
	GOTO       L_blinkLights10
;PartingShades.c,52 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,53 :: 		}
L_end_blinkLights:
	RETURN
; end of _blinkLights

_getCommand:

;PartingShades.c,56 :: 		int *getCommand(void){
;PartingShades.c,59 :: 		long j = 0;
;PartingShades.c,60 :: 		int i = 0;
	CLRF       getCommand_i_L0+0
	CLRF       getCommand_i_L0+1
;PartingShades.c,66 :: 		for(i = 0; i < 9; i++ ){  //all 8 bits of data and the closing bracket. 9 total
	CLRF       getCommand_i_L0+0
	CLRF       getCommand_i_L0+1
L_getCommand11:
	MOVLW      128
	XORWF      getCommand_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getCommand89
	MOVLW      9
	SUBWF      getCommand_i_L0+0, 0
L__getCommand89:
	BTFSC      STATUS+0, 0
	GOTO       L_getCommand12
;PartingShades.c,67 :: 		while((!(PORTB & pulsePin))  ){ //  && (j < timeOut)){ // wait till pulse starts
L_getCommand14:
	BTFSC      PORTB+0, 5
	GOTO       L_getCommand15
;PartingShades.c,69 :: 		}
	GOTO       L_getCommand14
L_getCommand15:
;PartingShades.c,70 :: 		delay_ms(1); //tiny delay to ensure we have good data before writing it
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_getCommand16:
	DECFSZ     R13+0, 1
	GOTO       L_getCommand16
	DECFSZ     R12+0, 1
	GOTO       L_getCommand16
	NOP
	NOP
;PartingShades.c,72 :: 		if( i < 8)
	MOVLW      128
	XORWF      getCommand_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getCommand90
	MOVLW      8
	SUBWF      getCommand_i_L0+0, 0
L__getCommand90:
	BTFSC      STATUS+0, 0
	GOTO       L_getCommand17
;PartingShades.c,73 :: 		commandTemp[i] = (PORTB & dataPin); // WRITE DATA
	MOVF       getCommand_i_L0+0, 0
	MOVWF      R0+0
	MOVF       getCommand_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      getCommand_commandTemp_L0+0
	MOVWF      FSR
	MOVLW      16
	ANDWF      PORTB+0, 0
	MOVWF      R0+0
	MOVLW      0
	ANDLW      0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	GOTO       L_getCommand18
L_getCommand17:
;PartingShades.c,74 :: 		else if(i == 8)
	MOVLW      0
	XORWF      getCommand_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getCommand91
	MOVLW      8
	XORWF      getCommand_i_L0+0, 0
L__getCommand91:
	BTFSS      STATUS+0, 2
	GOTO       L_getCommand19
;PartingShades.c,75 :: 		commandTemp[i] = (PORTB & (dataPin + parityPin));  // closing bracket
	MOVF       getCommand_i_L0+0, 0
	MOVWF      R0+0
	MOVF       getCommand_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      getCommand_commandTemp_L0+0
	MOVWF      FSR
	MOVLW      80
	ANDWF      PORTB+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
L_getCommand19:
L_getCommand18:
;PartingShades.c,77 :: 		while((PORTB & pulsePin)  ){   //&& (j < timeOut)){ // wait till pulse is over
L_getCommand20:
	BTFSS      PORTB+0, 5
	GOTO       L_getCommand21
;PartingShades.c,79 :: 		}
	GOTO       L_getCommand20
L_getCommand21:
;PartingShades.c,80 :: 		delay_ms(1); //tiny delay to ensure pulse is really over before starting again
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_getCommand22:
	DECFSZ     R13+0, 1
	GOTO       L_getCommand22
	DECFSZ     R12+0, 1
	GOTO       L_getCommand22
	NOP
	NOP
;PartingShades.c,66 :: 		for(i = 0; i < 9; i++ ){  //all 8 bits of data and the closing bracket. 9 total
	INCF       getCommand_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       getCommand_i_L0+1, 1
;PartingShades.c,84 :: 		}
	GOTO       L_getCommand11
L_getCommand12:
;PartingShades.c,86 :: 		if((commandTemp[8] == (dataPin + parityPin))   ){  // && (j < timeOut)){  //all went well
	MOVLW      0
	XORWF      getCommand_commandTemp_L0+17, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getCommand92
	MOVLW      80
	XORWF      getCommand_commandTemp_L0+16, 0
L__getCommand92:
	BTFSS      STATUS+0, 2
	GOTO       L_getCommand23
;PartingShades.c,87 :: 		for(i = 0; i < 8; i++) {                           //put temp into final array
	CLRF       getCommand_i_L0+0
	CLRF       getCommand_i_L0+1
L_getCommand24:
	MOVLW      128
	XORWF      getCommand_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getCommand93
	MOVLW      8
	SUBWF      getCommand_i_L0+0, 0
L__getCommand93:
	BTFSC      STATUS+0, 0
	GOTO       L_getCommand25
;PartingShades.c,88 :: 		commandFinal[i] = commandTemp[i];
	MOVF       getCommand_i_L0+0, 0
	MOVWF      R0+0
	MOVF       getCommand_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      getCommand_commandFinal_L0+0
	MOVWF      R2+0
	MOVF       R0+0, 0
	ADDLW      getCommand_commandTemp_L0+0
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
;PartingShades.c,87 :: 		for(i = 0; i < 8; i++) {                           //put temp into final array
	INCF       getCommand_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       getCommand_i_L0+1, 1
;PartingShades.c,89 :: 		}
	GOTO       L_getCommand24
L_getCommand25:
;PartingShades.c,91 :: 		return commandFinal;
	MOVLW      getCommand_commandFinal_L0+0
	MOVWF      R0+0
	GOTO       L_end_getCommand
;PartingShades.c,92 :: 		}
L_getCommand23:
;PartingShades.c,94 :: 		blinkLights();
	CALL       _blinkLights+0
;PartingShades.c,95 :: 		while(PORTB & 0b01110000);  // wait until port B is clean before continuing
L_getCommand28:
	MOVLW      112
	ANDWF      PORTB+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_getCommand29
	GOTO       L_getCommand28
L_getCommand29:
;PartingShades.c,96 :: 		return 0;  //something is wrong
	CLRF       R0+0
;PartingShades.c,98 :: 		}
L_end_getCommand:
	RETURN
; end of _getCommand

_openShades:

;PartingShades.c,100 :: 		void openShades(long setTimeOut){
;PartingShades.c,101 :: 		long timeOut = 0;
	CLRF       openShades_timeOut_L0+0
	CLRF       openShades_timeOut_L0+1
	CLRF       openShades_timeOut_L0+2
	CLRF       openShades_timeOut_L0+3
;PartingShades.c,102 :: 		PORTA = 0b00000001; //turns on the motor
	MOVLW      1
	MOVWF      PORTA+0
;PartingShades.c,103 :: 		while(!(PORTC & 0b10000000) && (timeOut < setTimeOut)){
L_openShades30:
	BTFSC      PORTC+0, 7
	GOTO       L_openShades31
	MOVLW      128
	XORWF      openShades_timeOut_L0+3, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_openShades_setTimeOut+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__openShades95
	MOVF       FARG_openShades_setTimeOut+2, 0
	SUBWF      openShades_timeOut_L0+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__openShades95
	MOVF       FARG_openShades_setTimeOut+1, 0
	SUBWF      openShades_timeOut_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__openShades95
	MOVF       FARG_openShades_setTimeOut+0, 0
	SUBWF      openShades_timeOut_L0+0, 0
L__openShades95:
	BTFSC      STATUS+0, 0
	GOTO       L_openShades31
L__openShades84:
;PartingShades.c,104 :: 		delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_openShades34:
	DECFSZ     R13+0, 1
	GOTO       L_openShades34
	DECFSZ     R12+0, 1
	GOTO       L_openShades34
	DECFSZ     R11+0, 1
	GOTO       L_openShades34
	NOP
	NOP
;PartingShades.c,109 :: 		if(PORTC & 0b00000001){
	BTFSS      PORTC+0, 0
	GOTO       L_openShades35
;PartingShades.c,110 :: 		delay_ms(50);  //debounce
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_openShades36:
	DECFSZ     R13+0, 1
	GOTO       L_openShades36
	DECFSZ     R12+0, 1
	GOTO       L_openShades36
	NOP
	NOP
;PartingShades.c,111 :: 		if(PORTC & 0b00000001){
	BTFSS      PORTC+0, 0
	GOTO       L_openShades37
;PartingShades.c,113 :: 		timeOut=setTimeOut; //this will end the while loop early
	MOVF       FARG_openShades_setTimeOut+0, 0
	MOVWF      openShades_timeOut_L0+0
	MOVF       FARG_openShades_setTimeOut+1, 0
	MOVWF      openShades_timeOut_L0+1
	MOVF       FARG_openShades_setTimeOut+2, 0
	MOVWF      openShades_timeOut_L0+2
	MOVF       FARG_openShades_setTimeOut+3, 0
	MOVWF      openShades_timeOut_L0+3
;PartingShades.c,114 :: 		}
L_openShades37:
;PartingShades.c,115 :: 		}
L_openShades35:
;PartingShades.c,117 :: 		timeOut++;
	MOVF       openShades_timeOut_L0+0, 0
	MOVWF      R0+0
	MOVF       openShades_timeOut_L0+1, 0
	MOVWF      R0+1
	MOVF       openShades_timeOut_L0+2, 0
	MOVWF      R0+2
	MOVF       openShades_timeOut_L0+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      openShades_timeOut_L0+0
	MOVF       R0+1, 0
	MOVWF      openShades_timeOut_L0+1
	MOVF       R0+2, 0
	MOVWF      openShades_timeOut_L0+2
	MOVF       R0+3, 0
	MOVWF      openShades_timeOut_L0+3
;PartingShades.c,118 :: 		}
	GOTO       L_openShades30
L_openShades31:
;PartingShades.c,120 :: 		PORTA = 0x00;  // turn motor off because of time out or sensor triggered
	CLRF       PORTA+0
;PartingShades.c,121 :: 		timeOut = 0;
	CLRF       openShades_timeOut_L0+0
	CLRF       openShades_timeOut_L0+1
	CLRF       openShades_timeOut_L0+2
	CLRF       openShades_timeOut_L0+3
;PartingShades.c,122 :: 		}
L_end_openShades:
	RETURN
; end of _openShades

_closeShades:

;PartingShades.c,124 :: 		void closeShades(long setTimeOut){
;PartingShades.c,125 :: 		long timeOut = 0;
	CLRF       closeShades_timeOut_L0+0
	CLRF       closeShades_timeOut_L0+1
	CLRF       closeShades_timeOut_L0+2
	CLRF       closeShades_timeOut_L0+3
;PartingShades.c,126 :: 		PORTA = 0b00000010;
	MOVLW      2
	MOVWF      PORTA+0
;PartingShades.c,127 :: 		while(!(PORTB & 0b10000000) && (timeOut < setTimeOut)){
L_closeShades38:
	BTFSC      PORTB+0, 7
	GOTO       L_closeShades39
	MOVLW      128
	XORWF      closeShades_timeOut_L0+3, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_closeShades_setTimeOut+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__closeShades97
	MOVF       FARG_closeShades_setTimeOut+2, 0
	SUBWF      closeShades_timeOut_L0+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__closeShades97
	MOVF       FARG_closeShades_setTimeOut+1, 0
	SUBWF      closeShades_timeOut_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__closeShades97
	MOVF       FARG_closeShades_setTimeOut+0, 0
	SUBWF      closeShades_timeOut_L0+0, 0
L__closeShades97:
	BTFSC      STATUS+0, 0
	GOTO       L_closeShades39
L__closeShades85:
;PartingShades.c,128 :: 		delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_closeShades42:
	DECFSZ     R13+0, 1
	GOTO       L_closeShades42
	DECFSZ     R12+0, 1
	GOTO       L_closeShades42
	DECFSZ     R11+0, 1
	GOTO       L_closeShades42
	NOP
	NOP
;PartingShades.c,133 :: 		if(PORTC & 0b00000001){
	BTFSS      PORTC+0, 0
	GOTO       L_closeShades43
;PartingShades.c,134 :: 		delay_ms(50);  //debounce
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_closeShades44:
	DECFSZ     R13+0, 1
	GOTO       L_closeShades44
	DECFSZ     R12+0, 1
	GOTO       L_closeShades44
	NOP
	NOP
;PartingShades.c,135 :: 		if(PORTC & 0b00000001){
	BTFSS      PORTC+0, 0
	GOTO       L_closeShades45
;PartingShades.c,137 :: 		timeOut=setTimeOut; //this will end the while loop early
	MOVF       FARG_closeShades_setTimeOut+0, 0
	MOVWF      closeShades_timeOut_L0+0
	MOVF       FARG_closeShades_setTimeOut+1, 0
	MOVWF      closeShades_timeOut_L0+1
	MOVF       FARG_closeShades_setTimeOut+2, 0
	MOVWF      closeShades_timeOut_L0+2
	MOVF       FARG_closeShades_setTimeOut+3, 0
	MOVWF      closeShades_timeOut_L0+3
;PartingShades.c,138 :: 		}
L_closeShades45:
;PartingShades.c,139 :: 		}
L_closeShades43:
;PartingShades.c,141 :: 		timeOut++;
	MOVF       closeShades_timeOut_L0+0, 0
	MOVWF      R0+0
	MOVF       closeShades_timeOut_L0+1, 0
	MOVWF      R0+1
	MOVF       closeShades_timeOut_L0+2, 0
	MOVWF      R0+2
	MOVF       closeShades_timeOut_L0+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      closeShades_timeOut_L0+0
	MOVF       R0+1, 0
	MOVWF      closeShades_timeOut_L0+1
	MOVF       R0+2, 0
	MOVWF      closeShades_timeOut_L0+2
	MOVF       R0+3, 0
	MOVWF      closeShades_timeOut_L0+3
;PartingShades.c,142 :: 		}
	GOTO       L_closeShades38
L_closeShades39:
;PartingShades.c,143 :: 		PORTA = 0x00; // turn motor off becuase of time out or sensor triggered
	CLRF       PORTA+0
;PartingShades.c,144 :: 		timeOut = 0;
	CLRF       closeShades_timeOut_L0+0
	CLRF       closeShades_timeOut_L0+1
	CLRF       closeShades_timeOut_L0+2
	CLRF       closeShades_timeOut_L0+3
;PartingShades.c,145 :: 		}
L_end_closeShades:
	RETURN
; end of _closeShades

_sendStatus:

;PartingShades.c,147 :: 		void sendStatus(char shadeStatus){  // o = open, c = closed
;PartingShades.c,148 :: 		int i = 0;
	CLRF       sendStatus_i_L0+0
	CLRF       sendStatus_i_L0+1
;PartingShades.c,149 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;PartingShades.c,152 :: 		TRISB &= 0b10101111;// changes to output leaves pulse pin as an input
	MOVLW      175
	ANDWF      TRISB+0, 1
;PartingShades.c,153 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_sendStatus46:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus46
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus46
	NOP
	NOP
;PartingShades.c,154 :: 		PORTB |= (parityPin + dataPin); //stick out our thumb
	MOVLW      80
	IORWF      PORTB+0, 1
;PartingShades.c,155 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_sendStatus47:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus47
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus47
	NOP
	NOP
;PartingShades.c,158 :: 		while(!(PORTB & pulsePin));// ardi pulses when ready to listen
L_sendStatus48:
	BTFSC      PORTB+0, 5
	GOTO       L_sendStatus49
	GOTO       L_sendStatus48
L_sendStatus49:
;PartingShades.c,159 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_sendStatus50:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus50
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus50
	NOP
	NOP
;PartingShades.c,160 :: 		while(PORTB & pulsePin); //wait for pulse to end
L_sendStatus51:
	BTFSS      PORTB+0, 5
	GOTO       L_sendStatus52
	GOTO       L_sendStatus51
L_sendStatus52:
;PartingShades.c,161 :: 		delay_ms(5); //give ardi time to change dataDirection, usually real quick "1"
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_sendStatus53:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus53
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus53
	NOP
	NOP
;PartingShades.c,162 :: 		PORTB &= 0b10001111;
	MOVLW      143
	ANDWF      PORTB+0, 1
;PartingShades.c,163 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_sendStatus54:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus54
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus54
	NOP
	NOP
;PartingShades.c,164 :: 		TRISB &= 0b10001111; //puts pulse pin to output
	MOVLW      143
	ANDWF      TRISB+0, 1
;PartingShades.c,167 :: 		if(shadeStatus == 'o'){  //0b11111111 is the open code
	MOVF       FARG_sendStatus_shadeStatus+0, 0
	XORLW      111
	BTFSS      STATUS+0, 2
	GOTO       L_sendStatus55
;PartingShades.c,168 :: 		for(i=0; i<8; i++){
	CLRF       sendStatus_i_L0+0
	CLRF       sendStatus_i_L0+1
L_sendStatus56:
	MOVLW      128
	XORWF      sendStatus_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__sendStatus99
	MOVLW      8
	SUBWF      sendStatus_i_L0+0, 0
L__sendStatus99:
	BTFSC      STATUS+0, 0
	GOTO       L_sendStatus57
;PartingShades.c,170 :: 		PORTB |= dataPin;  //set one
	BSF        PORTB+0, 4
;PartingShades.c,171 :: 		PORTB |= pulsePin;
	BSF        PORTB+0, 5
;PartingShades.c,173 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus59:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus59
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus59
	NOP
	NOP
;PartingShades.c,174 :: 		PORTB &= 0b10001111;  //clears comm pins
	MOVLW      143
	ANDWF      PORTB+0, 1
;PartingShades.c,175 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus60:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus60
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus60
	NOP
	NOP
;PartingShades.c,168 :: 		for(i=0; i<8; i++){
	INCF       sendStatus_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       sendStatus_i_L0+1, 1
;PartingShades.c,176 :: 		}
	GOTO       L_sendStatus56
L_sendStatus57:
;PartingShades.c,177 :: 		}
	GOTO       L_sendStatus61
L_sendStatus55:
;PartingShades.c,178 :: 		else if(shadeStatus == 'c'){  //0b00000000 is the close code
	MOVF       FARG_sendStatus_shadeStatus+0, 0
	XORLW      99
	BTFSS      STATUS+0, 2
	GOTO       L_sendStatus62
;PartingShades.c,179 :: 		for(i=0; i<8; i++){
	CLRF       sendStatus_i_L0+0
	CLRF       sendStatus_i_L0+1
L_sendStatus63:
	MOVLW      128
	XORWF      sendStatus_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__sendStatus100
	MOVLW      8
	SUBWF      sendStatus_i_L0+0, 0
L__sendStatus100:
	BTFSC      STATUS+0, 0
	GOTO       L_sendStatus64
;PartingShades.c,181 :: 		PORTB |= 0x00; //sets zero
;PartingShades.c,182 :: 		PORTB |= pulsePin;
	BSF        PORTB+0, 5
;PartingShades.c,184 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus66:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus66
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus66
	NOP
	NOP
;PartingShades.c,185 :: 		PORTB &= 0b10001111;  //clears comm pins
	MOVLW      143
	ANDWF      PORTB+0, 1
;PartingShades.c,186 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus67:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus67
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus67
	NOP
	NOP
;PartingShades.c,179 :: 		for(i=0; i<8; i++){
	INCF       sendStatus_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       sendStatus_i_L0+1, 1
;PartingShades.c,187 :: 		}
	GOTO       L_sendStatus63
L_sendStatus64:
;PartingShades.c,188 :: 		}
L_sendStatus62:
L_sendStatus61:
;PartingShades.c,190 :: 		PORTB |= 0b01010000;
	MOVLW      80
	IORWF      PORTB+0, 1
;PartingShades.c,191 :: 		PORTB |= pulsePin;
	BSF        PORTB+0, 5
;PartingShades.c,192 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus68:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus68
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus68
	NOP
	NOP
;PartingShades.c,193 :: 		PORTB &= 0b10001111; //clear comm pins
	MOVLW      143
	ANDWF      PORTB+0, 1
;PartingShades.c,194 :: 		TRISB = 0xFF;
	MOVLW      255
	MOVWF      TRISB+0
;PartingShades.c,195 :: 		return;
;PartingShades.c,196 :: 		}
L_end_sendStatus:
	RETURN
; end of _sendStatus

_main:

;PartingShades.c,199 :: 		main(){
;PartingShades.c,200 :: 		long timeOut = 0;
;PartingShades.c,202 :: 		long setTimeOut = 1000000; //default 1000000
	MOVLW      64
	MOVWF      main_setTimeOut_L0+0
	MOVLW      66
	MOVWF      main_setTimeOut_L0+1
	MOVLW      15
	MOVWF      main_setTimeOut_L0+2
	MOVLW      0
	MOVWF      main_setTimeOut_L0+3
	MOVLW      99
	MOVWF      main_currentSetting_L0+0
;PartingShades.c,208 :: 		init_ports();
	CALL       _init_ports+0
;PartingShades.c,211 :: 		while(1){
L_main69:
;PartingShades.c,213 :: 		if((PORTB & 0b01110000) == (dataPin + parityPin)){ //initialization bracket
	MOVLW      112
	ANDWF      PORTB+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      80
	BTFSS      STATUS+0, 2
	GOTO       L_main71
;PartingShades.c,214 :: 		currentCommand = getCommand();
	CALL       _getCommand+0
	MOVF       R0+0, 0
	MOVWF      main_currentCommand_L0+0
;PartingShades.c,230 :: 		if (*currentCommand == dataPin){   //if its 0b00000001
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVF       R1+1, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main102
	MOVLW      16
	XORWF      R1+0, 0
L__main102:
	BTFSS      STATUS+0, 2
	GOTO       L_main72
;PartingShades.c,231 :: 		openShades(setTimeOut); //Pin RA0 trips "open" relay
	MOVF       main_setTimeOut_L0+0, 0
	MOVWF      FARG_openShades_setTimeOut+0
	MOVF       main_setTimeOut_L0+1, 0
	MOVWF      FARG_openShades_setTimeOut+1
	MOVF       main_setTimeOut_L0+2, 0
	MOVWF      FARG_openShades_setTimeOut+2
	MOVF       main_setTimeOut_L0+3, 0
	MOVWF      FARG_openShades_setTimeOut+3
	CALL       _openShades+0
;PartingShades.c,232 :: 		currentSetting = 'o';
	MOVLW      111
	MOVWF      main_currentSetting_L0+0
;PartingShades.c,233 :: 		}
	GOTO       L_main73
L_main72:
;PartingShades.c,234 :: 		else if(*(currentCommand +1) == 0x00){ //0b00000000
	MOVLW      2
	ADDWF      main_currentCommand_L0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main103
	MOVLW      0
	XORWF      R1+0, 0
L__main103:
	BTFSS      STATUS+0, 2
	GOTO       L_main74
;PartingShades.c,235 :: 		closeShades(setTimeOut); //Pin RA1 trips "close" relay
	MOVF       main_setTimeOut_L0+0, 0
	MOVWF      FARG_closeShades_setTimeOut+0
	MOVF       main_setTimeOut_L0+1, 0
	MOVWF      FARG_closeShades_setTimeOut+1
	MOVF       main_setTimeOut_L0+2, 0
	MOVWF      FARG_closeShades_setTimeOut+2
	MOVF       main_setTimeOut_L0+3, 0
	MOVWF      FARG_closeShades_setTimeOut+3
	CALL       _closeShades+0
;PartingShades.c,236 :: 		currentSetting = 'c';
	MOVLW      99
	MOVWF      main_currentSetting_L0+0
;PartingShades.c,237 :: 		}
L_main74:
L_main73:
;PartingShades.c,238 :: 		while(PORTB & 0b01110000);  // wait until port B is clean before continuing
L_main75:
	MOVLW      112
	ANDWF      PORTB+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_main76
	GOTO       L_main75
L_main76:
;PartingShades.c,239 :: 		}
	GOTO       L_main77
L_main71:
;PartingShades.c,241 :: 		else if(PORTC & 0b00000001){  //the button on the console
	BTFSS      PORTC+0, 0
	GOTO       L_main78
;PartingShades.c,242 :: 		delay_ms(1); //debounce
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_main79:
	DECFSZ     R13+0, 1
	GOTO       L_main79
	DECFSZ     R12+0, 1
	GOTO       L_main79
	NOP
	NOP
;PartingShades.c,243 :: 		if(PORTC & 0b00000001){  // OPEN THE SHADES
	BTFSS      PORTC+0, 0
	GOTO       L_main80
;PartingShades.c,244 :: 		if(currentSetting == 'c'){
	MOVF       main_currentSetting_L0+0, 0
	XORLW      99
	BTFSS      STATUS+0, 2
	GOTO       L_main81
;PartingShades.c,245 :: 		openShades(setTimeOut);
	MOVF       main_setTimeOut_L0+0, 0
	MOVWF      FARG_openShades_setTimeOut+0
	MOVF       main_setTimeOut_L0+1, 0
	MOVWF      FARG_openShades_setTimeOut+1
	MOVF       main_setTimeOut_L0+2, 0
	MOVWF      FARG_openShades_setTimeOut+2
	MOVF       main_setTimeOut_L0+3, 0
	MOVWF      FARG_openShades_setTimeOut+3
	CALL       _openShades+0
;PartingShades.c,246 :: 		sendStatus('o');
	MOVLW      111
	MOVWF      FARG_sendStatus_shadeStatus+0
	CALL       _sendStatus+0
;PartingShades.c,247 :: 		currentSetting = 'o';
	MOVLW      111
	MOVWF      main_currentSetting_L0+0
;PartingShades.c,248 :: 		}
	GOTO       L_main82
L_main81:
;PartingShades.c,249 :: 		else if(currentSetting =='o'){
	MOVF       main_currentSetting_L0+0, 0
	XORLW      111
	BTFSS      STATUS+0, 2
	GOTO       L_main83
;PartingShades.c,250 :: 		closeShades(setTimeOut);
	MOVF       main_setTimeOut_L0+0, 0
	MOVWF      FARG_closeShades_setTimeOut+0
	MOVF       main_setTimeOut_L0+1, 0
	MOVWF      FARG_closeShades_setTimeOut+1
	MOVF       main_setTimeOut_L0+2, 0
	MOVWF      FARG_closeShades_setTimeOut+2
	MOVF       main_setTimeOut_L0+3, 0
	MOVWF      FARG_closeShades_setTimeOut+3
	CALL       _closeShades+0
;PartingShades.c,251 :: 		sendStatus('c');
	MOVLW      99
	MOVWF      FARG_sendStatus_shadeStatus+0
	CALL       _sendStatus+0
;PartingShades.c,252 :: 		currentSetting = 'c';
	MOVLW      99
	MOVWF      main_currentSetting_L0+0
;PartingShades.c,253 :: 		}
L_main83:
L_main82:
;PartingShades.c,254 :: 		}
L_main80:
;PartingShades.c,255 :: 		}
L_main78:
L_main77:
;PartingShades.c,256 :: 		}
	GOTO       L_main69
;PartingShades.c,257 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

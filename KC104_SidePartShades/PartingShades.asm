
_init_ports:

;PartingShades.c,11 :: 		void init_ports(void){
;PartingShades.c,12 :: 		OSCCON = 0x71;   //configures the internal oscillator
	MOVLW      113
	MOVWF      OSCCON+0
;PartingShades.c,13 :: 		ANSEL=0x00;        // Set inputs to digital
	CLRF       ANSEL+0
;PartingShades.c,14 :: 		ANSELH = 0x00;     //disables something that is holding pins RB5 and RB6
	CLRF       ANSELH+0
;PartingShades.c,15 :: 		CM1CON0 = 0x00;
	CLRF       CM1CON0+0
;PartingShades.c,16 :: 		CM2CON0 = 0x00;
	CLRF       CM2CON0+0
;PartingShades.c,17 :: 		IOCB = 0b00000000;
	CLRF       IOCB+0
;PartingShades.c,19 :: 		TRISA=0x00;        // port a is an output
	CLRF       TRISA+0
;PartingShades.c,21 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;PartingShades.c,22 :: 		TRISB=0xFF; //all of port B is an input... woot
	MOVLW      255
	MOVWF      TRISB+0
;PartingShades.c,23 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;PartingShades.c,24 :: 		TRISC=0b10000111; //pins 3-6 are output, 0-2, 7 are input
	MOVLW      135
	MOVWF      TRISC+0
;PartingShades.c,26 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,27 :: 		}
L_end_init_ports:
	RETURN
; end of _init_ports

_blinkLights:

;PartingShades.c,30 :: 		void blinkLights(void){  // this is called to simply flash lights
;PartingShades.c,31 :: 		PORTA = 0xFF;
	MOVLW      255
	MOVWF      PORTA+0
;PartingShades.c,32 :: 		delay_ms(flashDelay);
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
;PartingShades.c,33 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,34 :: 		delay_ms(flashDelay);
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
;PartingShades.c,35 :: 		PORTA = 0xFF;
	MOVLW      255
	MOVWF      PORTA+0
;PartingShades.c,36 :: 		delay_ms(flashDelay);
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
;PartingShades.c,37 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,38 :: 		delay_ms(flashDelay);
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
;PartingShades.c,39 :: 		PORTA = 0xFF;
	MOVLW      255
	MOVWF      PORTA+0
;PartingShades.c,40 :: 		delay_ms(flashDelay);
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
;PartingShades.c,41 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,42 :: 		delay_ms(flashDelay);
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
;PartingShades.c,43 :: 		PORTA = 0xFF;
	MOVLW      255
	MOVWF      PORTA+0
;PartingShades.c,44 :: 		delay_ms(flashDelay);
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
;PartingShades.c,45 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,46 :: 		delay_ms(flashDelay);
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
;PartingShades.c,47 :: 		PORTA = 0xFF;
	MOVLW      255
	MOVWF      PORTA+0
;PartingShades.c,48 :: 		delay_ms(flashDelay);
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
;PartingShades.c,49 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,50 :: 		delay_ms(flashDelay);
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
;PartingShades.c,51 :: 		PORTA = 0xFF;
	MOVLW      255
	MOVWF      PORTA+0
;PartingShades.c,52 :: 		delay_ms(flashDelay);
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
;PartingShades.c,53 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;PartingShades.c,54 :: 		}
L_end_blinkLights:
	RETURN
; end of _blinkLights

_getCommand:

;PartingShades.c,57 :: 		int *getCommand(void){
;PartingShades.c,60 :: 		long j = 0;
;PartingShades.c,61 :: 		int i = 0;
	CLRF       getCommand_i_L0+0
	CLRF       getCommand_i_L0+1
;PartingShades.c,67 :: 		for(i = 0; i < 9; i++ ){  //all 8 bits of data and the closing bracket. 9 total
	CLRF       getCommand_i_L0+0
	CLRF       getCommand_i_L0+1
L_getCommand11:
	MOVLW      128
	XORWF      getCommand_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getCommand84
	MOVLW      9
	SUBWF      getCommand_i_L0+0, 0
L__getCommand84:
	BTFSC      STATUS+0, 0
	GOTO       L_getCommand12
;PartingShades.c,68 :: 		while((!(PORTB & pulsePin))  ){ //  && (j < timeOut)){ // wait till pulse starts
L_getCommand14:
	BTFSC      PORTB+0, 5
	GOTO       L_getCommand15
;PartingShades.c,70 :: 		}
	GOTO       L_getCommand14
L_getCommand15:
;PartingShades.c,71 :: 		delay_ms(1); //tiny delay to ensure we have good data before writing it
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
;PartingShades.c,73 :: 		if( i < 8)
	MOVLW      128
	XORWF      getCommand_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getCommand85
	MOVLW      8
	SUBWF      getCommand_i_L0+0, 0
L__getCommand85:
	BTFSC      STATUS+0, 0
	GOTO       L_getCommand17
;PartingShades.c,74 :: 		commandTemp[i] = (PORTB & dataPin); // WRITE DATA
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
;PartingShades.c,75 :: 		else if(i == 8)
	MOVLW      0
	XORWF      getCommand_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getCommand86
	MOVLW      8
	XORWF      getCommand_i_L0+0, 0
L__getCommand86:
	BTFSS      STATUS+0, 2
	GOTO       L_getCommand19
;PartingShades.c,76 :: 		commandTemp[i] = (PORTB & (dataPin + parityPin));  // closing bracket
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
;PartingShades.c,78 :: 		while((PORTB & pulsePin)  ){   //&& (j < timeOut)){ // wait till pulse is over
L_getCommand20:
	BTFSS      PORTB+0, 5
	GOTO       L_getCommand21
;PartingShades.c,80 :: 		}
	GOTO       L_getCommand20
L_getCommand21:
;PartingShades.c,81 :: 		delay_ms(1); //tiny delay to ensure pulse is really over before starting again
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
;PartingShades.c,67 :: 		for(i = 0; i < 9; i++ ){  //all 8 bits of data and the closing bracket. 9 total
	INCF       getCommand_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       getCommand_i_L0+1, 1
;PartingShades.c,86 :: 		}
	GOTO       L_getCommand11
L_getCommand12:
;PartingShades.c,88 :: 		if((commandTemp[8] == (dataPin + parityPin))   ){  // && (j < timeOut)){  //all went well
	MOVLW      0
	XORWF      getCommand_commandTemp_L0+17, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getCommand87
	MOVLW      80
	XORWF      getCommand_commandTemp_L0+16, 0
L__getCommand87:
	BTFSS      STATUS+0, 2
	GOTO       L_getCommand23
;PartingShades.c,89 :: 		for(i = 0; i < 8; i++) {                           //put temp into final array
	CLRF       getCommand_i_L0+0
	CLRF       getCommand_i_L0+1
L_getCommand24:
	MOVLW      128
	XORWF      getCommand_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getCommand88
	MOVLW      8
	SUBWF      getCommand_i_L0+0, 0
L__getCommand88:
	BTFSC      STATUS+0, 0
	GOTO       L_getCommand25
;PartingShades.c,90 :: 		commandFinal[i] = commandTemp[i];
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
;PartingShades.c,89 :: 		for(i = 0; i < 8; i++) {                           //put temp into final array
	INCF       getCommand_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       getCommand_i_L0+1, 1
;PartingShades.c,91 :: 		}
	GOTO       L_getCommand24
L_getCommand25:
;PartingShades.c,93 :: 		return commandFinal;
	MOVLW      getCommand_commandFinal_L0+0
	MOVWF      R0+0
	GOTO       L_end_getCommand
;PartingShades.c,94 :: 		}
L_getCommand23:
;PartingShades.c,96 :: 		blinkLights();
	CALL       _blinkLights+0
;PartingShades.c,97 :: 		while(PORTB & 0b01110000);  // wait until port B is clean before continuing
L_getCommand28:
	MOVLW      112
	ANDWF      PORTB+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_getCommand29
	GOTO       L_getCommand28
L_getCommand29:
;PartingShades.c,98 :: 		return 0;  //something is wrong
	CLRF       R0+0
;PartingShades.c,100 :: 		}
L_end_getCommand:
	RETURN
; end of _getCommand

_openShades:

;PartingShades.c,102 :: 		void openShades(long setTimeOut){
;PartingShades.c,103 :: 		long timeOut = 0;
	CLRF       openShades_timeOut_L0+0
	CLRF       openShades_timeOut_L0+1
	CLRF       openShades_timeOut_L0+2
	CLRF       openShades_timeOut_L0+3
;PartingShades.c,104 :: 		PORTA = 0b00000001;
	MOVLW      1
	MOVWF      PORTA+0
;PartingShades.c,105 :: 		while(!(PORTC & 0b10000000) && (timeOut < setTimeOut)){
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
	GOTO       L__openShades90
	MOVF       FARG_openShades_setTimeOut+2, 0
	SUBWF      openShades_timeOut_L0+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__openShades90
	MOVF       FARG_openShades_setTimeOut+1, 0
	SUBWF      openShades_timeOut_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__openShades90
	MOVF       FARG_openShades_setTimeOut+0, 0
	SUBWF      openShades_timeOut_L0+0, 0
L__openShades90:
	BTFSC      STATUS+0, 0
	GOTO       L_openShades31
L__openShades79:
;PartingShades.c,109 :: 		timeOut++;
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
;PartingShades.c,110 :: 		}
	GOTO       L_openShades30
L_openShades31:
;PartingShades.c,112 :: 		PORTA = 0x00;  // turn motor off becuase of time out or sensor triggered
	CLRF       PORTA+0
;PartingShades.c,113 :: 		timeOut = 0;
	CLRF       openShades_timeOut_L0+0
	CLRF       openShades_timeOut_L0+1
	CLRF       openShades_timeOut_L0+2
	CLRF       openShades_timeOut_L0+3
;PartingShades.c,114 :: 		}
L_end_openShades:
	RETURN
; end of _openShades

_closeShades:

;PartingShades.c,116 :: 		void closeShades(long setTimeOut){
;PartingShades.c,117 :: 		long timeOut = 0;
	CLRF       closeShades_timeOut_L0+0
	CLRF       closeShades_timeOut_L0+1
	CLRF       closeShades_timeOut_L0+2
	CLRF       closeShades_timeOut_L0+3
;PartingShades.c,118 :: 		PORTA = 0b00000010;
	MOVLW      2
	MOVWF      PORTA+0
;PartingShades.c,119 :: 		while(!(PORTB & 0b10000000) && (timeOut < setTimeOut)){
L_closeShades34:
	BTFSC      PORTB+0, 7
	GOTO       L_closeShades35
	MOVLW      128
	XORWF      closeShades_timeOut_L0+3, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_closeShades_setTimeOut+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__closeShades92
	MOVF       FARG_closeShades_setTimeOut+2, 0
	SUBWF      closeShades_timeOut_L0+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__closeShades92
	MOVF       FARG_closeShades_setTimeOut+1, 0
	SUBWF      closeShades_timeOut_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__closeShades92
	MOVF       FARG_closeShades_setTimeOut+0, 0
	SUBWF      closeShades_timeOut_L0+0, 0
L__closeShades92:
	BTFSC      STATUS+0, 0
	GOTO       L_closeShades35
L__closeShades80:
;PartingShades.c,120 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_closeShades38:
	DECFSZ     R13+0, 1
	GOTO       L_closeShades38
	DECFSZ     R12+0, 1
	GOTO       L_closeShades38
	NOP
	NOP
;PartingShades.c,124 :: 		timeOut++;
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
;PartingShades.c,125 :: 		}
	GOTO       L_closeShades34
L_closeShades35:
;PartingShades.c,126 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_closeShades39:
	DECFSZ     R13+0, 1
	GOTO       L_closeShades39
	DECFSZ     R12+0, 1
	GOTO       L_closeShades39
	NOP
	NOP
;PartingShades.c,127 :: 		if(PORTB & 0b10000000){
	BTFSS      PORTB+0, 7
	GOTO       L_closeShades40
;PartingShades.c,128 :: 		PORTA = 0x00; // turn motor off becuase of time out or sensor triggered
	CLRF       PORTA+0
;PartingShades.c,129 :: 		timeOut = 0;
	CLRF       closeShades_timeOut_L0+0
	CLRF       closeShades_timeOut_L0+1
	CLRF       closeShades_timeOut_L0+2
	CLRF       closeShades_timeOut_L0+3
;PartingShades.c,130 :: 		}
L_closeShades40:
;PartingShades.c,131 :: 		}
L_end_closeShades:
	RETURN
; end of _closeShades

_sendStatus:

;PartingShades.c,133 :: 		void sendStatus(char shadeStatus){  // o = open, c = closed
;PartingShades.c,134 :: 		int i = 0;
	CLRF       sendStatus_i_L0+0
	CLRF       sendStatus_i_L0+1
;PartingShades.c,135 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;PartingShades.c,138 :: 		TRISB &= 0b10101111;// changes to output leaves pulse pin as an input
	MOVLW      175
	ANDWF      TRISB+0, 1
;PartingShades.c,139 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_sendStatus41:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus41
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus41
	NOP
	NOP
;PartingShades.c,140 :: 		PORTB |= (parityPin + dataPin); //stick out our thumb
	MOVLW      80
	IORWF      PORTB+0, 1
;PartingShades.c,141 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_sendStatus42:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus42
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus42
	NOP
	NOP
;PartingShades.c,144 :: 		while(!(PORTB & pulsePin));// ardi pulses when ready to listen
L_sendStatus43:
	BTFSC      PORTB+0, 5
	GOTO       L_sendStatus44
	GOTO       L_sendStatus43
L_sendStatus44:
;PartingShades.c,145 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_sendStatus45:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus45
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus45
	NOP
	NOP
;PartingShades.c,146 :: 		while(PORTB & pulsePin); //wait for pulse to end
L_sendStatus46:
	BTFSS      PORTB+0, 5
	GOTO       L_sendStatus47
	GOTO       L_sendStatus46
L_sendStatus47:
;PartingShades.c,147 :: 		delay_ms(5); //give ardi time to change dataDirection, usually real quick "1"
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_sendStatus48:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus48
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus48
	NOP
	NOP
;PartingShades.c,148 :: 		PORTB &= 0b10001111;
	MOVLW      143
	ANDWF      PORTB+0, 1
;PartingShades.c,149 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_sendStatus49:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus49
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus49
	NOP
	NOP
;PartingShades.c,150 :: 		TRISB &= 0b10001111; //puts pulse pin to output
	MOVLW      143
	ANDWF      TRISB+0, 1
;PartingShades.c,153 :: 		if(shadeStatus == 'o'){  //0b11111111 is the open code
	MOVF       FARG_sendStatus_shadeStatus+0, 0
	XORLW      111
	BTFSS      STATUS+0, 2
	GOTO       L_sendStatus50
;PartingShades.c,154 :: 		for(i=0; i<8; i++){
	CLRF       sendStatus_i_L0+0
	CLRF       sendStatus_i_L0+1
L_sendStatus51:
	MOVLW      128
	XORWF      sendStatus_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__sendStatus94
	MOVLW      8
	SUBWF      sendStatus_i_L0+0, 0
L__sendStatus94:
	BTFSC      STATUS+0, 0
	GOTO       L_sendStatus52
;PartingShades.c,156 :: 		PORTB |= dataPin;  //set one
	BSF        PORTB+0, 4
;PartingShades.c,157 :: 		PORTB |= pulsePin;
	BSF        PORTB+0, 5
;PartingShades.c,159 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus54:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus54
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus54
	NOP
	NOP
;PartingShades.c,160 :: 		PORTB &= 0b10001111;  //clears comm pins
	MOVLW      143
	ANDWF      PORTB+0, 1
;PartingShades.c,161 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus55:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus55
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus55
	NOP
	NOP
;PartingShades.c,154 :: 		for(i=0; i<8; i++){
	INCF       sendStatus_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       sendStatus_i_L0+1, 1
;PartingShades.c,162 :: 		}
	GOTO       L_sendStatus51
L_sendStatus52:
;PartingShades.c,163 :: 		}
	GOTO       L_sendStatus56
L_sendStatus50:
;PartingShades.c,164 :: 		else if(shadeStatus == 'c'){  //0b00000000 is the close code
	MOVF       FARG_sendStatus_shadeStatus+0, 0
	XORLW      99
	BTFSS      STATUS+0, 2
	GOTO       L_sendStatus57
;PartingShades.c,165 :: 		for(i=0; i<8; i++){
	CLRF       sendStatus_i_L0+0
	CLRF       sendStatus_i_L0+1
L_sendStatus58:
	MOVLW      128
	XORWF      sendStatus_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__sendStatus95
	MOVLW      8
	SUBWF      sendStatus_i_L0+0, 0
L__sendStatus95:
	BTFSC      STATUS+0, 0
	GOTO       L_sendStatus59
;PartingShades.c,167 :: 		PORTB |= 0x00; //sets zero
;PartingShades.c,168 :: 		PORTB |= pulsePin;
	BSF        PORTB+0, 5
;PartingShades.c,170 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus61:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus61
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus61
	NOP
	NOP
;PartingShades.c,171 :: 		PORTB &= 0b10001111;  //clears comm pins
	MOVLW      143
	ANDWF      PORTB+0, 1
;PartingShades.c,172 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus62:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus62
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus62
	NOP
	NOP
;PartingShades.c,165 :: 		for(i=0; i<8; i++){
	INCF       sendStatus_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       sendStatus_i_L0+1, 1
;PartingShades.c,173 :: 		}
	GOTO       L_sendStatus58
L_sendStatus59:
;PartingShades.c,174 :: 		}
L_sendStatus57:
L_sendStatus56:
;PartingShades.c,176 :: 		PORTB |= 0b01010000;
	MOVLW      80
	IORWF      PORTB+0, 1
;PartingShades.c,177 :: 		PORTB |= pulsePin;
	BSF        PORTB+0, 5
;PartingShades.c,178 :: 		delay_ms(pulseDelay);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_sendStatus63:
	DECFSZ     R13+0, 1
	GOTO       L_sendStatus63
	DECFSZ     R12+0, 1
	GOTO       L_sendStatus63
	NOP
	NOP
;PartingShades.c,179 :: 		PORTB &= 0b10001111; //clear comm pins
	MOVLW      143
	ANDWF      PORTB+0, 1
;PartingShades.c,180 :: 		TRISB = 0xFF;
	MOVLW      255
	MOVWF      TRISB+0
;PartingShades.c,181 :: 		return;
;PartingShades.c,182 :: 		}
L_end_sendStatus:
	RETURN
; end of _sendStatus

_main:

;PartingShades.c,184 :: 		main(){
;PartingShades.c,185 :: 		long timeOut = 0;
;PartingShades.c,187 :: 		long setTimeOut = 1000000; //default 1000000
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
;PartingShades.c,193 :: 		init_ports();
	CALL       _init_ports+0
;PartingShades.c,196 :: 		while(1){
L_main64:
;PartingShades.c,197 :: 		if((PORTB & 0b01110000) == (dataPin + parityPin)){ //initialization bracket
	MOVLW      112
	ANDWF      PORTB+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      80
	BTFSS      STATUS+0, 2
	GOTO       L_main66
;PartingShades.c,198 :: 		currentCommand = getCommand();
	CALL       _getCommand+0
	MOVF       R0+0, 0
	MOVWF      main_currentCommand_L0+0
;PartingShades.c,214 :: 		if (*currentCommand == dataPin){   //if its 0b00000001
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
	GOTO       L__main97
	MOVLW      16
	XORWF      R1+0, 0
L__main97:
	BTFSS      STATUS+0, 2
	GOTO       L_main67
;PartingShades.c,215 :: 		openShades(setTimeOut); //Pin RA0 trips "open" relay
	MOVF       main_setTimeOut_L0+0, 0
	MOVWF      FARG_openShades_setTimeOut+0
	MOVF       main_setTimeOut_L0+1, 0
	MOVWF      FARG_openShades_setTimeOut+1
	MOVF       main_setTimeOut_L0+2, 0
	MOVWF      FARG_openShades_setTimeOut+2
	MOVF       main_setTimeOut_L0+3, 0
	MOVWF      FARG_openShades_setTimeOut+3
	CALL       _openShades+0
;PartingShades.c,216 :: 		currentSetting = 'o';
	MOVLW      111
	MOVWF      main_currentSetting_L0+0
;PartingShades.c,217 :: 		}
	GOTO       L_main68
L_main67:
;PartingShades.c,218 :: 		else if(*(currentCommand +1) == 0x00){ //0b00000000
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
	GOTO       L__main98
	MOVLW      0
	XORWF      R1+0, 0
L__main98:
	BTFSS      STATUS+0, 2
	GOTO       L_main69
;PartingShades.c,219 :: 		closeShades(setTimeOut); //Pin RA1 trips "close" relay
	MOVF       main_setTimeOut_L0+0, 0
	MOVWF      FARG_closeShades_setTimeOut+0
	MOVF       main_setTimeOut_L0+1, 0
	MOVWF      FARG_closeShades_setTimeOut+1
	MOVF       main_setTimeOut_L0+2, 0
	MOVWF      FARG_closeShades_setTimeOut+2
	MOVF       main_setTimeOut_L0+3, 0
	MOVWF      FARG_closeShades_setTimeOut+3
	CALL       _closeShades+0
;PartingShades.c,220 :: 		currentSetting = 'c';
	MOVLW      99
	MOVWF      main_currentSetting_L0+0
;PartingShades.c,221 :: 		}
L_main69:
L_main68:
;PartingShades.c,222 :: 		while(PORTB & 0b01110000);  // wait until port B is clean before continuing
L_main70:
	MOVLW      112
	ANDWF      PORTB+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_main71
	GOTO       L_main70
L_main71:
;PartingShades.c,223 :: 		}
	GOTO       L_main72
L_main66:
;PartingShades.c,225 :: 		else if(PORTC & 0b00000001){
	BTFSS      PORTC+0, 0
	GOTO       L_main73
;PartingShades.c,226 :: 		delay_ms(1); //debounce
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_main74:
	DECFSZ     R13+0, 1
	GOTO       L_main74
	DECFSZ     R12+0, 1
	GOTO       L_main74
	NOP
	NOP
;PartingShades.c,227 :: 		if(PORTC & 0b00000001){  // OPEN THE SHADES
	BTFSS      PORTC+0, 0
	GOTO       L_main75
;PartingShades.c,228 :: 		if(currentSetting == 'c'){
	MOVF       main_currentSetting_L0+0, 0
	XORLW      99
	BTFSS      STATUS+0, 2
	GOTO       L_main76
;PartingShades.c,229 :: 		openShades(setTimeOut);
	MOVF       main_setTimeOut_L0+0, 0
	MOVWF      FARG_openShades_setTimeOut+0
	MOVF       main_setTimeOut_L0+1, 0
	MOVWF      FARG_openShades_setTimeOut+1
	MOVF       main_setTimeOut_L0+2, 0
	MOVWF      FARG_openShades_setTimeOut+2
	MOVF       main_setTimeOut_L0+3, 0
	MOVWF      FARG_openShades_setTimeOut+3
	CALL       _openShades+0
;PartingShades.c,230 :: 		sendStatus('o');
	MOVLW      111
	MOVWF      FARG_sendStatus_shadeStatus+0
	CALL       _sendStatus+0
;PartingShades.c,231 :: 		currentSetting = 'o';
	MOVLW      111
	MOVWF      main_currentSetting_L0+0
;PartingShades.c,232 :: 		}
	GOTO       L_main77
L_main76:
;PartingShades.c,233 :: 		else if(currentSetting =='o'){
	MOVF       main_currentSetting_L0+0, 0
	XORLW      111
	BTFSS      STATUS+0, 2
	GOTO       L_main78
;PartingShades.c,234 :: 		closeShades(setTimeOut);
	MOVF       main_setTimeOut_L0+0, 0
	MOVWF      FARG_closeShades_setTimeOut+0
	MOVF       main_setTimeOut_L0+1, 0
	MOVWF      FARG_closeShades_setTimeOut+1
	MOVF       main_setTimeOut_L0+2, 0
	MOVWF      FARG_closeShades_setTimeOut+2
	MOVF       main_setTimeOut_L0+3, 0
	MOVWF      FARG_closeShades_setTimeOut+3
	CALL       _closeShades+0
;PartingShades.c,235 :: 		sendStatus('c');
	MOVLW      99
	MOVWF      FARG_sendStatus_shadeStatus+0
	CALL       _sendStatus+0
;PartingShades.c,236 :: 		currentSetting = 'c';
	MOVLW      99
	MOVWF      main_currentSetting_L0+0
;PartingShades.c,237 :: 		}
L_main78:
L_main77:
;PartingShades.c,238 :: 		}
L_main75:
;PartingShades.c,239 :: 		}
L_main73:
L_main72:
;PartingShades.c,240 :: 		}
	GOTO       L_main64
;PartingShades.c,241 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

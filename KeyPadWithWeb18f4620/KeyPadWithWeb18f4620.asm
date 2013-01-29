
_init_ports:

;KeyPadWithWeb18f4620.c,23 :: 		void init_ports(){
;KeyPadWithWeb18f4620.c,25 :: 		PORTB = 0;               //initializes port for use  (keypad on PORTB)
	CLRF        PORTB+0 
;KeyPadWithWeb18f4620.c,26 :: 		TRISB = 0b00011111;      // data direction control, 0 for output 1 for input
	MOVLW       31
	MOVWF       TRISB+0 
;KeyPadWithWeb18f4620.c,27 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;KeyPadWithWeb18f4620.c,28 :: 		TRISC = 0b11110000; //RC4, RC5, and RC6 for web and RC7 for toggle button
	MOVLW       240
	MOVWF       TRISC+0 
;KeyPadWithWeb18f4620.c,29 :: 		PORTA = 0x00;               // 0 is output
	CLRF        PORTA+0 
;KeyPadWithWeb18f4620.c,30 :: 		TRISA &= 0b00000001;
	MOVLW       1
	ANDWF       TRISA+0, 1 
;KeyPadWithWeb18f4620.c,32 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;KeyPadWithWeb18f4620.c,33 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;KeyPadWithWeb18f4620.c,35 :: 		}
L_end_init_ports:
	RETURN      0
; end of _init_ports

_ADCInit:

;KeyPadWithWeb18f4620.c,38 :: 		void ADCInit(){ //configuring A/D module
;KeyPadWithWeb18f4620.c,39 :: 		ADCON1 = 0b00000111; //channels AN8-An12 are digital and AN0-AN7 are analog
	MOVLW       7
	MOVWF       ADCON1+0 
;KeyPadWithWeb18f4620.c,42 :: 		ADCON2 = 0x8A; //Right justified, Tad=2xacquisition time
	MOVLW       138
	MOVWF       ADCON2+0 
;KeyPadWithWeb18f4620.c,44 :: 		}
L_end_ADCInit:
	RETURN      0
; end of _ADCInit

_ADCRead:

;KeyPadWithWeb18f4620.c,47 :: 		int ADCRead( unsigned char ch){
;KeyPadWithWeb18f4620.c,49 :: 		ADCON0 = 0x00;//configuring analog channel
	CLRF        ADCON0+0 
;KeyPadWithWeb18f4620.c,50 :: 		ADCON0 = (ch<<2); //selecting analog channel
	MOVF        FARG_ADCRead_ch+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       ADCON0+0 
;KeyPadWithWeb18f4620.c,51 :: 		ADON_bit = 1; //switch on adc module
	BSF         ADON_bit+0, 0 
;KeyPadWithWeb18f4620.c,52 :: 		GO_DONE_bit =1;//Start conversion
	BSF         GO_DONE_bit+0, 1 
;KeyPadWithWeb18f4620.c,54 :: 		while(GO_DONE_bit); //wait for the conversion to finish
L_ADCRead0:
	BTFSS       GO_DONE_bit+0, 1 
	GOTO        L_ADCRead1
	GOTO        L_ADCRead0
L_ADCRead1:
;KeyPadWithWeb18f4620.c,55 :: 		ADON_bit =0; //switch off adc
	BCF         ADON_bit+0, 0 
;KeyPadWithWeb18f4620.c,57 :: 		return (ADRESL + (255*ADRESH));  // puts all ten bits into one variable (math might be off)
	MOVLW       255
	MULWF       ADRESH+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        ADRESL+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
;KeyPadWithWeb18f4620.c,58 :: 		}
L_end_ADCRead:
	RETURN      0
; end of _ADCRead

_checkColumn1:

;KeyPadWithWeb18f4620.c,61 :: 		char checkColumn1(){                //checks the first column of the keypad
;KeyPadWithWeb18f4620.c,62 :: 		PORTB = 0b00100000;
	MOVLW       32
	MOVWF       PORTB+0 
;KeyPadWithWeb18f4620.c,63 :: 		delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_checkColumn12:
	DECFSZ      R13, 1, 1
	BRA         L_checkColumn12
	DECFSZ      R12, 1, 1
	BRA         L_checkColumn12
	NOP
	NOP
;KeyPadWithWeb18f4620.c,66 :: 		if((PORTB & 0b00011111) == 0b00000010){
	MOVLW       31
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_checkColumn13
;KeyPadWithWeb18f4620.c,67 :: 		return '1';
	MOVLW       49
	MOVWF       R0 
	GOTO        L_end_checkColumn1
;KeyPadWithWeb18f4620.c,68 :: 		}
L_checkColumn13:
;KeyPadWithWeb18f4620.c,69 :: 		else if ((PORTB & 0b00011111) == 0b00000100){
	MOVLW       31
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_checkColumn15
;KeyPadWithWeb18f4620.c,70 :: 		return '4';
	MOVLW       52
	MOVWF       R0 
	GOTO        L_end_checkColumn1
;KeyPadWithWeb18f4620.c,71 :: 		}
L_checkColumn15:
;KeyPadWithWeb18f4620.c,72 :: 		else if ((PORTB & 0b00011111) == 0b00001000){
	MOVLW       31
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_checkColumn17
;KeyPadWithWeb18f4620.c,73 :: 		return '7';
	MOVLW       55
	MOVWF       R0 
	GOTO        L_end_checkColumn1
;KeyPadWithWeb18f4620.c,74 :: 		}
L_checkColumn17:
;KeyPadWithWeb18f4620.c,75 :: 		else if ((PORTB & 0b00011111) == 0b00010000){
	MOVLW       31
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_checkColumn19
;KeyPadWithWeb18f4620.c,76 :: 		return '*';
	MOVLW       42
	MOVWF       R0 
	GOTO        L_end_checkColumn1
;KeyPadWithWeb18f4620.c,77 :: 		}
L_checkColumn19:
;KeyPadWithWeb18f4620.c,78 :: 		else return 0;
	CLRF        R0 
;KeyPadWithWeb18f4620.c,79 :: 		}
L_end_checkColumn1:
	RETURN      0
; end of _checkColumn1

_checkColumn2:

;KeyPadWithWeb18f4620.c,81 :: 		char checkColumn2(){            //checks the second column of the keypad
;KeyPadWithWeb18f4620.c,82 :: 		PORTB = 0b01000000;
	MOVLW       64
	MOVWF       PORTB+0 
;KeyPadWithWeb18f4620.c,83 :: 		delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_checkColumn211:
	DECFSZ      R13, 1, 1
	BRA         L_checkColumn211
	DECFSZ      R12, 1, 1
	BRA         L_checkColumn211
	NOP
	NOP
;KeyPadWithWeb18f4620.c,86 :: 		if((PORTB & 0b00011111) == 0b00000010){
	MOVLW       31
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_checkColumn212
;KeyPadWithWeb18f4620.c,87 :: 		return '2';
	MOVLW       50
	MOVWF       R0 
	GOTO        L_end_checkColumn2
;KeyPadWithWeb18f4620.c,88 :: 		}
L_checkColumn212:
;KeyPadWithWeb18f4620.c,89 :: 		else if ((PORTB & 0b00011111) == 0b00000100){
	MOVLW       31
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_checkColumn214
;KeyPadWithWeb18f4620.c,90 :: 		return '5';
	MOVLW       53
	MOVWF       R0 
	GOTO        L_end_checkColumn2
;KeyPadWithWeb18f4620.c,91 :: 		}
L_checkColumn214:
;KeyPadWithWeb18f4620.c,92 :: 		else if ((PORTB & 0b00011111) == 0b00001000){
	MOVLW       31
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_checkColumn216
;KeyPadWithWeb18f4620.c,93 :: 		return '8';
	MOVLW       56
	MOVWF       R0 
	GOTO        L_end_checkColumn2
;KeyPadWithWeb18f4620.c,94 :: 		}
L_checkColumn216:
;KeyPadWithWeb18f4620.c,95 :: 		else if ((PORTB & 0b00011111) == 0b00010000){
	MOVLW       31
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_checkColumn218
;KeyPadWithWeb18f4620.c,96 :: 		return '0';
	MOVLW       48
	MOVWF       R0 
	GOTO        L_end_checkColumn2
;KeyPadWithWeb18f4620.c,97 :: 		}
L_checkColumn218:
;KeyPadWithWeb18f4620.c,98 :: 		else return 0;
	CLRF        R0 
;KeyPadWithWeb18f4620.c,99 :: 		}
L_end_checkColumn2:
	RETURN      0
; end of _checkColumn2

_checkColumn3:

;KeyPadWithWeb18f4620.c,101 :: 		char checkColumn3(){                 //checks the third column of the keypad
;KeyPadWithWeb18f4620.c,102 :: 		PORTB = 0b10000000;
	MOVLW       128
	MOVWF       PORTB+0 
;KeyPadWithWeb18f4620.c,103 :: 		delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_checkColumn320:
	DECFSZ      R13, 1, 1
	BRA         L_checkColumn320
	DECFSZ      R12, 1, 1
	BRA         L_checkColumn320
	NOP
	NOP
;KeyPadWithWeb18f4620.c,105 :: 		if((PORTB & 0b00011111) == 0b00000010){
	MOVLW       31
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_checkColumn321
;KeyPadWithWeb18f4620.c,106 :: 		return '3';
	MOVLW       51
	MOVWF       R0 
	GOTO        L_end_checkColumn3
;KeyPadWithWeb18f4620.c,107 :: 		}
L_checkColumn321:
;KeyPadWithWeb18f4620.c,108 :: 		else if ((PORTB & 0b00011111) == 0b00000100){
	MOVLW       31
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_checkColumn323
;KeyPadWithWeb18f4620.c,109 :: 		return '6';
	MOVLW       54
	MOVWF       R0 
	GOTO        L_end_checkColumn3
;KeyPadWithWeb18f4620.c,110 :: 		}
L_checkColumn323:
;KeyPadWithWeb18f4620.c,111 :: 		else if ((PORTB & 0b00011111) == 0b00001000){
	MOVLW       31
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_checkColumn325
;KeyPadWithWeb18f4620.c,112 :: 		return '9';
	MOVLW       57
	MOVWF       R0 
	GOTO        L_end_checkColumn3
;KeyPadWithWeb18f4620.c,113 :: 		}
L_checkColumn325:
;KeyPadWithWeb18f4620.c,114 :: 		else if ((PORTB & 0b00011111) == 0b00010000){
	MOVLW       31
	ANDWF       PORTB+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_checkColumn327
;KeyPadWithWeb18f4620.c,115 :: 		return '#';
	MOVLW       35
	MOVWF       R0 
	GOTO        L_end_checkColumn3
;KeyPadWithWeb18f4620.c,116 :: 		}
L_checkColumn327:
;KeyPadWithWeb18f4620.c,117 :: 		else return 0;
	CLRF        R0 
;KeyPadWithWeb18f4620.c,118 :: 		}
L_end_checkColumn3:
	RETURN      0
; end of _checkColumn3

_checkPassword:

;KeyPadWithWeb18f4620.c,120 :: 		int checkPassword(){
;KeyPadWithWeb18f4620.c,121 :: 		int counter = 0;
	CLRF        checkPassword_counter_L0+0 
	CLRF        checkPassword_counter_L0+1 
	CLRF        checkPassword_resetCounter_L0+0 
	CLRF        checkPassword_resetCounter_L0+1 
	CLRF        checkPassword_resetCounter_L0+2 
	CLRF        checkPassword_resetCounter_L0+3 
	CLRF        checkPassword_lockCounter_L0+0 
	CLRF        checkPassword_lockCounter_L0+1 
	CLRF        checkPassword_lockCounter_L0+2 
	CLRF        checkPassword_lockCounter_L0+3 
	CLRF        checkPassword_i_L0+0 
	CLRF        checkPassword_i_L0+1 
	CLRF        checkPassword_keysPressed_L0+0 
	CLRF        checkPassword_keysPressed_L0+1 
;KeyPadWithWeb18f4620.c,127 :: 		while(1){
L_checkPassword29:
;KeyPadWithWeb18f4620.c,128 :: 		counter++;  //for timeouts
	INFSNZ      checkPassword_counter_L0+0, 1 
	INCF        checkPassword_counter_L0+1, 1 
;KeyPadWithWeb18f4620.c,129 :: 		if(checkColumn1()){
	CALL        _checkColumn1+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_checkPassword31
;KeyPadWithWeb18f4620.c,130 :: 		keysPressed++;
	INFSNZ      checkPassword_keysPressed_L0+0, 1 
	INCF        checkPassword_keysPressed_L0+1, 1 
;KeyPadWithWeb18f4620.c,131 :: 		counter = 0;  //reset timeout counter
	CLRF        checkPassword_counter_L0+0 
	CLRF        checkPassword_counter_L0+1 
;KeyPadWithWeb18f4620.c,133 :: 		if(checkColumn1() == psw[i]){
	CALL        _checkColumn1+0, 0
	MOVLW       _psw+0
	ADDWF       checkPassword_i_L0+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_psw+0)
	ADDWFC      checkPassword_i_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        R0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_checkPassword32
;KeyPadWithWeb18f4620.c,134 :: 		i++;
	INFSNZ      checkPassword_i_L0+0, 1 
	INCF        checkPassword_i_L0+1, 1 
;KeyPadWithWeb18f4620.c,135 :: 		}
	GOTO        L_checkPassword33
L_checkPassword32:
;KeyPadWithWeb18f4620.c,137 :: 		i = 0;
	CLRF        checkPassword_i_L0+0 
	CLRF        checkPassword_i_L0+1 
L_checkPassword33:
;KeyPadWithWeb18f4620.c,139 :: 		while(PORTB & 0b00010000){ // the asterisk key
L_checkPassword34:
	BTFSS       PORTB+0, 4 
	GOTO        L_checkPassword35
;KeyPadWithWeb18f4620.c,140 :: 		resetCounter++;
	MOVLW       1
	ADDWF       checkPassword_resetCounter_L0+0, 1 
	MOVLW       0
	ADDWFC      checkPassword_resetCounter_L0+1, 1 
	ADDWFC      checkPassword_resetCounter_L0+2, 1 
	ADDWFC      checkPassword_resetCounter_L0+3, 1 
;KeyPadWithWeb18f4620.c,141 :: 		if((resetCounter >= resetLimit) && (i == 0)){
	MOVLW       128
	XORWF       checkPassword_resetCounter_L0+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _resetLimit+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__checkPassword231
	MOVF        _resetLimit+2, 0 
	SUBWF       checkPassword_resetCounter_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__checkPassword231
	MOVF        _resetLimit+1, 0 
	SUBWF       checkPassword_resetCounter_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__checkPassword231
	MOVF        _resetLimit+0, 0 
	SUBWF       checkPassword_resetCounter_L0+0, 0 
L__checkPassword231:
	BTFSS       STATUS+0, 0 
	GOTO        L_checkPassword38
	MOVLW       0
	XORWF       checkPassword_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__checkPassword232
	MOVLW       0
	XORWF       checkPassword_i_L0+0, 0 
L__checkPassword232:
	BTFSS       STATUS+0, 2 
	GOTO        L_checkPassword38
L__checkPassword216:
;KeyPadWithWeb18f4620.c,142 :: 		return -1;
	MOVLW       255
	MOVWF       R0 
	MOVLW       255
	MOVWF       R1 
	GOTO        L_end_checkPassword
;KeyPadWithWeb18f4620.c,143 :: 		}
L_checkPassword38:
;KeyPadWithWeb18f4620.c,144 :: 		}
	GOTO        L_checkPassword34
L_checkPassword35:
;KeyPadWithWeb18f4620.c,145 :: 		resetCounter = 0;
	CLRF        checkPassword_resetCounter_L0+0 
	CLRF        checkPassword_resetCounter_L0+1 
	CLRF        checkPassword_resetCounter_L0+2 
	CLRF        checkPassword_resetCounter_L0+3 
;KeyPadWithWeb18f4620.c,146 :: 		while(PORTB & 0b00011110); //debounce
L_checkPassword39:
	MOVLW       30
	ANDWF       PORTB+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_checkPassword40
	GOTO        L_checkPassword39
L_checkPassword40:
;KeyPadWithWeb18f4620.c,147 :: 		}
	GOTO        L_checkPassword41
L_checkPassword31:
;KeyPadWithWeb18f4620.c,148 :: 		else if(checkColumn2()){
	CALL        _checkColumn2+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_checkPassword42
;KeyPadWithWeb18f4620.c,149 :: 		keysPressed++;
	INFSNZ      checkPassword_keysPressed_L0+0, 1 
	INCF        checkPassword_keysPressed_L0+1, 1 
;KeyPadWithWeb18f4620.c,150 :: 		counter = 0;
	CLRF        checkPassword_counter_L0+0 
	CLRF        checkPassword_counter_L0+1 
;KeyPadWithWeb18f4620.c,152 :: 		if(checkColumn2() == psw[i]){
	CALL        _checkColumn2+0, 0
	MOVLW       _psw+0
	ADDWF       checkPassword_i_L0+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_psw+0)
	ADDWFC      checkPassword_i_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        R0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_checkPassword43
;KeyPadWithWeb18f4620.c,153 :: 		i++;
	INFSNZ      checkPassword_i_L0+0, 1 
	INCF        checkPassword_i_L0+1, 1 
;KeyPadWithWeb18f4620.c,154 :: 		}
	GOTO        L_checkPassword44
L_checkPassword43:
;KeyPadWithWeb18f4620.c,156 :: 		i = 0;
	CLRF        checkPassword_i_L0+0 
	CLRF        checkPassword_i_L0+1 
L_checkPassword44:
;KeyPadWithWeb18f4620.c,158 :: 		while(PORTB & 0b00011110); //debounce
L_checkPassword45:
	MOVLW       30
	ANDWF       PORTB+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_checkPassword46
	GOTO        L_checkPassword45
L_checkPassword46:
;KeyPadWithWeb18f4620.c,159 :: 		}
	GOTO        L_checkPassword47
L_checkPassword42:
;KeyPadWithWeb18f4620.c,160 :: 		else if(checkColumn3()){
	CALL        _checkColumn3+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_checkPassword48
;KeyPadWithWeb18f4620.c,161 :: 		keysPressed++;
	INFSNZ      checkPassword_keysPressed_L0+0, 1 
	INCF        checkPassword_keysPressed_L0+1, 1 
;KeyPadWithWeb18f4620.c,162 :: 		counter = 0;
	CLRF        checkPassword_counter_L0+0 
	CLRF        checkPassword_counter_L0+1 
;KeyPadWithWeb18f4620.c,164 :: 		if(checkColumn3() == psw[i]){
	CALL        _checkColumn3+0, 0
	MOVLW       _psw+0
	ADDWF       checkPassword_i_L0+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(_psw+0)
	ADDWFC      checkPassword_i_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        R0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_checkPassword49
;KeyPadWithWeb18f4620.c,165 :: 		i++;
	INFSNZ      checkPassword_i_L0+0, 1 
	INCF        checkPassword_i_L0+1, 1 
;KeyPadWithWeb18f4620.c,166 :: 		}
	GOTO        L_checkPassword50
L_checkPassword49:
;KeyPadWithWeb18f4620.c,168 :: 		i = 0;
	CLRF        checkPassword_i_L0+0 
	CLRF        checkPassword_i_L0+1 
L_checkPassword50:
;KeyPadWithWeb18f4620.c,169 :: 		while((PORTB & 0b00010000) && (i == 0)){ // the pound key
L_checkPassword51:
	BTFSS       PORTB+0, 4 
	GOTO        L_checkPassword52
	MOVLW       0
	XORWF       checkPassword_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__checkPassword233
	MOVLW       0
	XORWF       checkPassword_i_L0+0, 0 
L__checkPassword233:
	BTFSS       STATUS+0, 2 
	GOTO        L_checkPassword52
L__checkPassword215:
;KeyPadWithWeb18f4620.c,170 :: 		lockCounter++;
	MOVLW       1
	ADDWF       checkPassword_lockCounter_L0+0, 1 
	MOVLW       0
	ADDWFC      checkPassword_lockCounter_L0+1, 1 
	ADDWFC      checkPassword_lockCounter_L0+2, 1 
	ADDWFC      checkPassword_lockCounter_L0+3, 1 
;KeyPadWithWeb18f4620.c,171 :: 		if((lockCounter >= lockLimit) && (i == 0)){
	MOVLW       128
	XORWF       checkPassword_lockCounter_L0+3, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _lockLimit+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__checkPassword234
	MOVF        _lockLimit+2, 0 
	SUBWF       checkPassword_lockCounter_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__checkPassword234
	MOVF        _lockLimit+1, 0 
	SUBWF       checkPassword_lockCounter_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__checkPassword234
	MOVF        _lockLimit+0, 0 
	SUBWF       checkPassword_lockCounter_L0+0, 0 
L__checkPassword234:
	BTFSS       STATUS+0, 0 
	GOTO        L_checkPassword57
	MOVLW       0
	XORWF       checkPassword_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__checkPassword235
	MOVLW       0
	XORWF       checkPassword_i_L0+0, 0 
L__checkPassword235:
	BTFSS       STATUS+0, 2 
	GOTO        L_checkPassword57
L__checkPassword214:
;KeyPadWithWeb18f4620.c,172 :: 		return 7;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_checkPassword
;KeyPadWithWeb18f4620.c,173 :: 		}
L_checkPassword57:
;KeyPadWithWeb18f4620.c,174 :: 		}
	GOTO        L_checkPassword51
L_checkPassword52:
;KeyPadWithWeb18f4620.c,175 :: 		lockCounter = 0;
	CLRF        checkPassword_lockCounter_L0+0 
	CLRF        checkPassword_lockCounter_L0+1 
	CLRF        checkPassword_lockCounter_L0+2 
	CLRF        checkPassword_lockCounter_L0+3 
;KeyPadWithWeb18f4620.c,177 :: 		while(PORTB & 0b00011110); //debounce
L_checkPassword58:
	MOVLW       30
	ANDWF       PORTB+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_checkPassword59
	GOTO        L_checkPassword58
L_checkPassword59:
;KeyPadWithWeb18f4620.c,178 :: 		}
L_checkPassword48:
L_checkPassword47:
L_checkPassword41:
;KeyPadWithWeb18f4620.c,180 :: 		if(counter >= timeOutLimit)    // timeout
	MOVLW       128
	XORWF       checkPassword_counter_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _timeOutLimit+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__checkPassword236
	MOVF        _timeOutLimit+0, 0 
	SUBWF       checkPassword_counter_L0+0, 0 
L__checkPassword236:
	BTFSS       STATUS+0, 0 
	GOTO        L_checkPassword60
;KeyPadWithWeb18f4620.c,181 :: 		return 0;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_checkPassword
L_checkPassword60:
;KeyPadWithWeb18f4620.c,183 :: 		if(keysPressed == 4){
	MOVLW       0
	XORWF       checkPassword_keysPressed_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__checkPassword237
	MOVLW       4
	XORWF       checkPassword_keysPressed_L0+0, 0 
L__checkPassword237:
	BTFSS       STATUS+0, 2 
	GOTO        L_checkPassword61
;KeyPadWithWeb18f4620.c,184 :: 		if(i == 4){
	MOVLW       0
	XORWF       checkPassword_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__checkPassword238
	MOVLW       4
	XORWF       checkPassword_i_L0+0, 0 
L__checkPassword238:
	BTFSS       STATUS+0, 2 
	GOTO        L_checkPassword62
;KeyPadWithWeb18f4620.c,185 :: 		i = 0;
	CLRF        checkPassword_i_L0+0 
	CLRF        checkPassword_i_L0+1 
;KeyPadWithWeb18f4620.c,186 :: 		keysPressed = 0;
	CLRF        checkPassword_keysPressed_L0+0 
	CLRF        checkPassword_keysPressed_L0+1 
;KeyPadWithWeb18f4620.c,187 :: 		return 1;   // the password was correct
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_checkPassword
;KeyPadWithWeb18f4620.c,188 :: 		}
L_checkPassword62:
;KeyPadWithWeb18f4620.c,190 :: 		i = 0;
	CLRF        checkPassword_i_L0+0 
	CLRF        checkPassword_i_L0+1 
;KeyPadWithWeb18f4620.c,191 :: 		keysPressed = 0;
	CLRF        checkPassword_keysPressed_L0+0 
	CLRF        checkPassword_keysPressed_L0+1 
;KeyPadWithWeb18f4620.c,192 :: 		return 0;  // the password was wrong
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_checkPassword
;KeyPadWithWeb18f4620.c,194 :: 		}
L_checkPassword61:
;KeyPadWithWeb18f4620.c,196 :: 		}
	GOTO        L_checkPassword29
;KeyPadWithWeb18f4620.c,197 :: 		}
L_end_checkPassword:
	RETURN      0
; end of _checkPassword

_newPassword:

;KeyPadWithWeb18f4620.c,201 :: 		int newPassword(){
;KeyPadWithWeb18f4620.c,204 :: 		int counter = 0;
	CLRF        newPassword_counter_L0+0 
	CLRF        newPassword_counter_L0+1 
	CLRF        newPassword_i_L0+0 
	CLRF        newPassword_i_L0+1 
	CLRF        newPassword_keysPressed_L0+0 
	CLRF        newPassword_keysPressed_L0+1 
	CLRF        newPassword_j_L0+0 
	CLRF        newPassword_j_L0+1 
	CLRF        newPassword_confirmed_L0+0 
	CLRF        newPassword_confirmed_L0+1 
;KeyPadWithWeb18f4620.c,209 :: 		PORTA |= 0b00001000;
	BSF         PORTA+0, 3 
;KeyPadWithWeb18f4620.c,211 :: 		while((counter <= timeOutLimit) && keysPressed < 4){
L_newPassword64:
	MOVLW       128
	XORWF       _timeOutLimit+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       newPassword_counter_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__newPassword240
	MOVF        newPassword_counter_L0+0, 0 
	SUBWF       _timeOutLimit+0, 0 
L__newPassword240:
	BTFSS       STATUS+0, 0 
	GOTO        L_newPassword65
	MOVLW       128
	XORWF       newPassword_keysPressed_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__newPassword241
	MOVLW       4
	SUBWF       newPassword_keysPressed_L0+0, 0 
L__newPassword241:
	BTFSC       STATUS+0, 0 
	GOTO        L_newPassword65
L__newPassword218:
;KeyPadWithWeb18f4620.c,212 :: 		counter++;
	INFSNZ      newPassword_counter_L0+0, 1 
	INCF        newPassword_counter_L0+1, 1 
;KeyPadWithWeb18f4620.c,213 :: 		if(checkColumn1()){
	CALL        _checkColumn1+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword68
;KeyPadWithWeb18f4620.c,214 :: 		keysPressed++;
	INFSNZ      newPassword_keysPressed_L0+0, 1 
	INCF        newPassword_keysPressed_L0+1, 1 
;KeyPadWithWeb18f4620.c,215 :: 		counter = 0;
	CLRF        newPassword_counter_L0+0 
	CLRF        newPassword_counter_L0+1 
;KeyPadWithWeb18f4620.c,217 :: 		temp1[i] = checkColumn1();
	MOVLW       newPassword_temp1_L0+0
	ADDWF       newPassword_i_L0+0, 0 
	MOVWF       FLOC__newPassword+0 
	MOVLW       hi_addr(newPassword_temp1_L0+0)
	ADDWFC      newPassword_i_L0+1, 0 
	MOVWF       FLOC__newPassword+1 
	CALL        _checkColumn1+0, 0
	MOVFF       FLOC__newPassword+0, FSR1
	MOVFF       FLOC__newPassword+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;KeyPadWithWeb18f4620.c,218 :: 		i++;
	INFSNZ      newPassword_i_L0+0, 1 
	INCF        newPassword_i_L0+1, 1 
;KeyPadWithWeb18f4620.c,220 :: 		while(PORTB & 0b00011110); //debounce
L_newPassword69:
	MOVLW       30
	ANDWF       PORTB+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword70
	GOTO        L_newPassword69
L_newPassword70:
;KeyPadWithWeb18f4620.c,221 :: 		}
	GOTO        L_newPassword71
L_newPassword68:
;KeyPadWithWeb18f4620.c,222 :: 		else if(checkColumn2()){
	CALL        _checkColumn2+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword72
;KeyPadWithWeb18f4620.c,223 :: 		keysPressed++;
	INFSNZ      newPassword_keysPressed_L0+0, 1 
	INCF        newPassword_keysPressed_L0+1, 1 
;KeyPadWithWeb18f4620.c,224 :: 		counter = 0;
	CLRF        newPassword_counter_L0+0 
	CLRF        newPassword_counter_L0+1 
;KeyPadWithWeb18f4620.c,226 :: 		temp1[i] = checkColumn2();
	MOVLW       newPassword_temp1_L0+0
	ADDWF       newPassword_i_L0+0, 0 
	MOVWF       FLOC__newPassword+0 
	MOVLW       hi_addr(newPassword_temp1_L0+0)
	ADDWFC      newPassword_i_L0+1, 0 
	MOVWF       FLOC__newPassword+1 
	CALL        _checkColumn2+0, 0
	MOVFF       FLOC__newPassword+0, FSR1
	MOVFF       FLOC__newPassword+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;KeyPadWithWeb18f4620.c,227 :: 		i++;
	INFSNZ      newPassword_i_L0+0, 1 
	INCF        newPassword_i_L0+1, 1 
;KeyPadWithWeb18f4620.c,229 :: 		while(PORTB & 0b00011110); //debounce
L_newPassword73:
	MOVLW       30
	ANDWF       PORTB+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword74
	GOTO        L_newPassword73
L_newPassword74:
;KeyPadWithWeb18f4620.c,230 :: 		}
	GOTO        L_newPassword75
L_newPassword72:
;KeyPadWithWeb18f4620.c,231 :: 		else if(checkColumn3()){
	CALL        _checkColumn3+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword76
;KeyPadWithWeb18f4620.c,232 :: 		keysPressed++;
	INFSNZ      newPassword_keysPressed_L0+0, 1 
	INCF        newPassword_keysPressed_L0+1, 1 
;KeyPadWithWeb18f4620.c,233 :: 		counter = 0;
	CLRF        newPassword_counter_L0+0 
	CLRF        newPassword_counter_L0+1 
;KeyPadWithWeb18f4620.c,235 :: 		temp1[i] = checkColumn3();
	MOVLW       newPassword_temp1_L0+0
	ADDWF       newPassword_i_L0+0, 0 
	MOVWF       FLOC__newPassword+0 
	MOVLW       hi_addr(newPassword_temp1_L0+0)
	ADDWFC      newPassword_i_L0+1, 0 
	MOVWF       FLOC__newPassword+1 
	CALL        _checkColumn3+0, 0
	MOVFF       FLOC__newPassword+0, FSR1
	MOVFF       FLOC__newPassword+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;KeyPadWithWeb18f4620.c,236 :: 		i++;
	INFSNZ      newPassword_i_L0+0, 1 
	INCF        newPassword_i_L0+1, 1 
;KeyPadWithWeb18f4620.c,238 :: 		while(PORTB & 0b00011110); //debounce
L_newPassword77:
	MOVLW       30
	ANDWF       PORTB+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword78
	GOTO        L_newPassword77
L_newPassword78:
;KeyPadWithWeb18f4620.c,239 :: 		}
L_newPassword76:
L_newPassword75:
L_newPassword71:
;KeyPadWithWeb18f4620.c,240 :: 		}
	GOTO        L_newPassword64
L_newPassword65:
;KeyPadWithWeb18f4620.c,241 :: 		if(keysPressed != 4)    // the user timed out
	MOVLW       0
	XORWF       newPassword_keysPressed_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__newPassword242
	MOVLW       4
	XORWF       newPassword_keysPressed_L0+0, 0 
L__newPassword242:
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword79
;KeyPadWithWeb18f4620.c,242 :: 		return 0;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_newPassword
L_newPassword79:
;KeyPadWithWeb18f4620.c,244 :: 		else if(keysPressed == 4){
	MOVLW       0
	XORWF       newPassword_keysPressed_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__newPassword243
	MOVLW       4
	XORWF       newPassword_keysPressed_L0+0, 0 
L__newPassword243:
	BTFSS       STATUS+0, 2 
	GOTO        L_newPassword81
;KeyPadWithWeb18f4620.c,245 :: 		PORTA |= 0b00001010; //green led (keeping reset led on)
	MOVLW       10
	IORWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,247 :: 		delay_ms(delay1);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_newPassword82:
	DECFSZ      R13, 1, 1
	BRA         L_newPassword82
	DECFSZ      R12, 1, 1
	BRA         L_newPassword82
	DECFSZ      R11, 1, 1
	BRA         L_newPassword82
;KeyPadWithWeb18f4620.c,248 :: 		PORTA &= 0b11111101;
	MOVLW       253
	ANDWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,249 :: 		PORTA |= 0b00001000;
	BSF         PORTA+0, 3 
;KeyPadWithWeb18f4620.c,252 :: 		keysPressed = 0;
	CLRF        newPassword_keysPressed_L0+0 
	CLRF        newPassword_keysPressed_L0+1 
;KeyPadWithWeb18f4620.c,253 :: 		i = 0;
	CLRF        newPassword_i_L0+0 
	CLRF        newPassword_i_L0+1 
;KeyPadWithWeb18f4620.c,254 :: 		counter = 0;
	CLRF        newPassword_counter_L0+0 
	CLRF        newPassword_counter_L0+1 
;KeyPadWithWeb18f4620.c,255 :: 		while(counter < timeOutLimit && keysPressed < 4){
L_newPassword83:
	MOVLW       128
	XORWF       newPassword_counter_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _timeOutLimit+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__newPassword244
	MOVF        _timeOutLimit+0, 0 
	SUBWF       newPassword_counter_L0+0, 0 
L__newPassword244:
	BTFSC       STATUS+0, 0 
	GOTO        L_newPassword84
	MOVLW       128
	XORWF       newPassword_keysPressed_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__newPassword245
	MOVLW       4
	SUBWF       newPassword_keysPressed_L0+0, 0 
L__newPassword245:
	BTFSC       STATUS+0, 0 
	GOTO        L_newPassword84
L__newPassword217:
;KeyPadWithWeb18f4620.c,256 :: 		if(checkColumn1()){
	CALL        _checkColumn1+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword87
;KeyPadWithWeb18f4620.c,257 :: 		keysPressed++;
	INFSNZ      newPassword_keysPressed_L0+0, 1 
	INCF        newPassword_keysPressed_L0+1, 1 
;KeyPadWithWeb18f4620.c,258 :: 		counter = 0;
	CLRF        newPassword_counter_L0+0 
	CLRF        newPassword_counter_L0+1 
;KeyPadWithWeb18f4620.c,260 :: 		temp2[i] = checkColumn1();
	MOVLW       newPassword_temp2_L0+0
	ADDWF       newPassword_i_L0+0, 0 
	MOVWF       FLOC__newPassword+0 
	MOVLW       hi_addr(newPassword_temp2_L0+0)
	ADDWFC      newPassword_i_L0+1, 0 
	MOVWF       FLOC__newPassword+1 
	CALL        _checkColumn1+0, 0
	MOVFF       FLOC__newPassword+0, FSR1
	MOVFF       FLOC__newPassword+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;KeyPadWithWeb18f4620.c,261 :: 		i++;
	INFSNZ      newPassword_i_L0+0, 1 
	INCF        newPassword_i_L0+1, 1 
;KeyPadWithWeb18f4620.c,263 :: 		while(PORTB & 0b00011110); //debounce
L_newPassword88:
	MOVLW       30
	ANDWF       PORTB+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword89
	GOTO        L_newPassword88
L_newPassword89:
;KeyPadWithWeb18f4620.c,264 :: 		}
	GOTO        L_newPassword90
L_newPassword87:
;KeyPadWithWeb18f4620.c,265 :: 		else if(checkColumn2()){
	CALL        _checkColumn2+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword91
;KeyPadWithWeb18f4620.c,266 :: 		keysPressed++;
	INFSNZ      newPassword_keysPressed_L0+0, 1 
	INCF        newPassword_keysPressed_L0+1, 1 
;KeyPadWithWeb18f4620.c,267 :: 		counter = 0;
	CLRF        newPassword_counter_L0+0 
	CLRF        newPassword_counter_L0+1 
;KeyPadWithWeb18f4620.c,269 :: 		temp2[i] = checkColumn2();
	MOVLW       newPassword_temp2_L0+0
	ADDWF       newPassword_i_L0+0, 0 
	MOVWF       FLOC__newPassword+0 
	MOVLW       hi_addr(newPassword_temp2_L0+0)
	ADDWFC      newPassword_i_L0+1, 0 
	MOVWF       FLOC__newPassword+1 
	CALL        _checkColumn2+0, 0
	MOVFF       FLOC__newPassword+0, FSR1
	MOVFF       FLOC__newPassword+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;KeyPadWithWeb18f4620.c,270 :: 		i++;
	INFSNZ      newPassword_i_L0+0, 1 
	INCF        newPassword_i_L0+1, 1 
;KeyPadWithWeb18f4620.c,272 :: 		while(PORTB & 0b00011110); //debounce
L_newPassword92:
	MOVLW       30
	ANDWF       PORTB+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword93
	GOTO        L_newPassword92
L_newPassword93:
;KeyPadWithWeb18f4620.c,273 :: 		}
	GOTO        L_newPassword94
L_newPassword91:
;KeyPadWithWeb18f4620.c,274 :: 		else if(checkColumn3()){
	CALL        _checkColumn3+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword95
;KeyPadWithWeb18f4620.c,275 :: 		keysPressed++;
	INFSNZ      newPassword_keysPressed_L0+0, 1 
	INCF        newPassword_keysPressed_L0+1, 1 
;KeyPadWithWeb18f4620.c,276 :: 		counter = 0;
	CLRF        newPassword_counter_L0+0 
	CLRF        newPassword_counter_L0+1 
;KeyPadWithWeb18f4620.c,278 :: 		temp2[i] = checkColumn3();
	MOVLW       newPassword_temp2_L0+0
	ADDWF       newPassword_i_L0+0, 0 
	MOVWF       FLOC__newPassword+0 
	MOVLW       hi_addr(newPassword_temp2_L0+0)
	ADDWFC      newPassword_i_L0+1, 0 
	MOVWF       FLOC__newPassword+1 
	CALL        _checkColumn3+0, 0
	MOVFF       FLOC__newPassword+0, FSR1
	MOVFF       FLOC__newPassword+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;KeyPadWithWeb18f4620.c,279 :: 		i++;
	INFSNZ      newPassword_i_L0+0, 1 
	INCF        newPassword_i_L0+1, 1 
;KeyPadWithWeb18f4620.c,281 :: 		while(PORTB & 0b00011110); //debounce
L_newPassword96:
	MOVLW       30
	ANDWF       PORTB+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword97
	GOTO        L_newPassword96
L_newPassword97:
;KeyPadWithWeb18f4620.c,282 :: 		}
L_newPassword95:
L_newPassword94:
L_newPassword90:
;KeyPadWithWeb18f4620.c,283 :: 		}
	GOTO        L_newPassword83
L_newPassword84:
;KeyPadWithWeb18f4620.c,284 :: 		if(keysPressed != 4)    // the user timed out
	MOVLW       0
	XORWF       newPassword_keysPressed_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__newPassword246
	MOVLW       4
	XORWF       newPassword_keysPressed_L0+0, 0 
L__newPassword246:
	BTFSC       STATUS+0, 2 
	GOTO        L_newPassword98
;KeyPadWithWeb18f4620.c,285 :: 		return 0;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_newPassword
L_newPassword98:
;KeyPadWithWeb18f4620.c,287 :: 		else if(keysPressed == 4){
	MOVLW       0
	XORWF       newPassword_keysPressed_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__newPassword247
	MOVLW       4
	XORWF       newPassword_keysPressed_L0+0, 0 
L__newPassword247:
	BTFSS       STATUS+0, 2 
	GOTO        L_newPassword100
;KeyPadWithWeb18f4620.c,288 :: 		for(j = 0; j < sizeof(psw); j++){
	CLRF        newPassword_j_L0+0 
	CLRF        newPassword_j_L0+1 
L_newPassword101:
	MOVLW       128
	XORWF       newPassword_j_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__newPassword248
	MOVLW       4
	SUBWF       newPassword_j_L0+0, 0 
L__newPassword248:
	BTFSC       STATUS+0, 0 
	GOTO        L_newPassword102
;KeyPadWithWeb18f4620.c,289 :: 		if(temp1[j] == temp2[j])
	MOVLW       newPassword_temp1_L0+0
	ADDWF       newPassword_j_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(newPassword_temp1_L0+0)
	ADDWFC      newPassword_j_L0+1, 0 
	MOVWF       FSR0H 
	MOVLW       newPassword_temp2_L0+0
	ADDWF       newPassword_j_L0+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(newPassword_temp2_L0+0)
	ADDWFC      newPassword_j_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_newPassword104
;KeyPadWithWeb18f4620.c,290 :: 		confirmed ++;
	INFSNZ      newPassword_confirmed_L0+0, 1 
	INCF        newPassword_confirmed_L0+1, 1 
	GOTO        L_newPassword105
L_newPassword104:
;KeyPadWithWeb18f4620.c,292 :: 		confirmed = 0;
	CLRF        newPassword_confirmed_L0+0 
	CLRF        newPassword_confirmed_L0+1 
L_newPassword105:
;KeyPadWithWeb18f4620.c,288 :: 		for(j = 0; j < sizeof(psw); j++){
	INFSNZ      newPassword_j_L0+0, 1 
	INCF        newPassword_j_L0+1, 1 
;KeyPadWithWeb18f4620.c,293 :: 		}
	GOTO        L_newPassword101
L_newPassword102:
;KeyPadWithWeb18f4620.c,294 :: 		if(confirmed == sizeof(psw)){  // two passwords match, so change overall password
	MOVLW       0
	XORWF       newPassword_confirmed_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__newPassword249
	MOVLW       4
	XORWF       newPassword_confirmed_L0+0, 0 
L__newPassword249:
	BTFSS       STATUS+0, 2 
	GOTO        L_newPassword106
;KeyPadWithWeb18f4620.c,295 :: 		for(j = 0; j < sizeof(psw); j++){
	CLRF        newPassword_j_L0+0 
	CLRF        newPassword_j_L0+1 
L_newPassword107:
	MOVLW       128
	XORWF       newPassword_j_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__newPassword250
	MOVLW       4
	SUBWF       newPassword_j_L0+0, 0 
L__newPassword250:
	BTFSC       STATUS+0, 0 
	GOTO        L_newPassword108
;KeyPadWithWeb18f4620.c,296 :: 		psw[j] = temp1[j];
	MOVLW       _psw+0
	ADDWF       newPassword_j_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_psw+0)
	ADDWFC      newPassword_j_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       newPassword_temp1_L0+0
	ADDWF       newPassword_j_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(newPassword_temp1_L0+0)
	ADDWFC      newPassword_j_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;KeyPadWithWeb18f4620.c,295 :: 		for(j = 0; j < sizeof(psw); j++){
	INFSNZ      newPassword_j_L0+0, 1 
	INCF        newPassword_j_L0+1, 1 
;KeyPadWithWeb18f4620.c,297 :: 		}
	GOTO        L_newPassword107
L_newPassword108:
;KeyPadWithWeb18f4620.c,299 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_newPassword
;KeyPadWithWeb18f4620.c,300 :: 		}
L_newPassword106:
;KeyPadWithWeb18f4620.c,302 :: 		return 0;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_newPassword
;KeyPadWithWeb18f4620.c,303 :: 		}
L_newPassword100:
;KeyPadWithWeb18f4620.c,304 :: 		}
L_newPassword81:
;KeyPadWithWeb18f4620.c,305 :: 		}
L_end_newPassword:
	RETURN      0
; end of _newPassword

_resetMode:

;KeyPadWithWeb18f4620.c,307 :: 		void resetMode(){
;KeyPadWithWeb18f4620.c,308 :: 		PORTA &= 0b11110111; //flashes blue LED indicating that the current password should be input
	MOVLW       247
	ANDWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,309 :: 		delay_ms(15);
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_resetMode111:
	DECFSZ      R13, 1, 1
	BRA         L_resetMode111
	DECFSZ      R12, 1, 1
	BRA         L_resetMode111
;KeyPadWithWeb18f4620.c,310 :: 		PORTA |= 0b00001000;
	BSF         PORTA+0, 3 
;KeyPadWithWeb18f4620.c,311 :: 		if(checkPassword() == 1){ // password verified time to enter & verify new password
	CALL        _checkPassword+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__resetMode252
	MOVLW       1
	XORWF       R0, 0 
L__resetMode252:
	BTFSS       STATUS+0, 2 
	GOTO        L_resetMode112
;KeyPadWithWeb18f4620.c,312 :: 		PORTA |= 0b00001010; //green LED
	MOVLW       10
	IORWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,313 :: 		delay_ms(delay1);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_resetMode113:
	DECFSZ      R13, 1, 1
	BRA         L_resetMode113
	DECFSZ      R12, 1, 1
	BRA         L_resetMode113
	DECFSZ      R11, 1, 1
	BRA         L_resetMode113
;KeyPadWithWeb18f4620.c,314 :: 		PORTA &= 0b11111101;
	MOVLW       253
	ANDWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,317 :: 		if(newPassword()){   //prompts for new password, confirms, and changes
	CALL        _newPassword+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_resetMode114
;KeyPadWithWeb18f4620.c,318 :: 		PORTA |= 0b00001010;  //green LED
	MOVLW       10
	IORWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,319 :: 		delay_ms(delay1);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_resetMode115:
	DECFSZ      R13, 1, 1
	BRA         L_resetMode115
	DECFSZ      R12, 1, 1
	BRA         L_resetMode115
	DECFSZ      R11, 1, 1
	BRA         L_resetMode115
;KeyPadWithWeb18f4620.c,320 :: 		PORTA &= 0b11111101;
	MOVLW       253
	ANDWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,322 :: 		}
	GOTO        L_resetMode116
L_resetMode114:
;KeyPadWithWeb18f4620.c,324 :: 		PORTA |= 0b00000100;  //red led
	BSF         PORTA+0, 2 
;KeyPadWithWeb18f4620.c,326 :: 		}
L_resetMode116:
;KeyPadWithWeb18f4620.c,327 :: 		}
	GOTO        L_resetMode117
L_resetMode112:
;KeyPadWithWeb18f4620.c,329 :: 		PORTA |= 0b00000100; //red led
	BSF         PORTA+0, 2 
;KeyPadWithWeb18f4620.c,332 :: 		}
L_resetMode117:
;KeyPadWithWeb18f4620.c,333 :: 		}
L_end_resetMode:
	RETURN      0
; end of _resetMode

_moveLock:

;KeyPadWithWeb18f4620.c,336 :: 		void moveLock(){
;KeyPadWithWeb18f4620.c,337 :: 		long moveTimer = 800000;
	MOVLW       0
	MOVWF       moveLock_moveTimer_L0+0 
	MOVLW       53
	MOVWF       moveLock_moveTimer_L0+1 
	MOVLW       12
	MOVWF       moveLock_moveTimer_L0+2 
	MOVLW       0
	MOVWF       moveLock_moveTimer_L0+3 
	CLRF        moveLock_j_L0+0 
	CLRF        moveLock_j_L0+1 
;KeyPadWithWeb18f4620.c,339 :: 		PORTA |= 0b00010010;  //unlock direction
	MOVLW       18
	IORWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,340 :: 		delay_ms(50); //avoid voltage spike
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_moveLock118:
	DECFSZ      R13, 1, 1
	BRA         L_moveLock118
	DECFSZ      R12, 1, 1
	BRA         L_moveLock118
	NOP
	NOP
;KeyPadWithWeb18f4620.c,341 :: 		while((ADCRead(0) <= 600) && j<moveTimer)
L_moveLock119:
	CLRF        FARG_ADCRead_ch+0 
	CALL        _ADCRead+0, 0
	MOVLW       128
	XORLW       2
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveLock254
	MOVF        R0, 0 
	SUBLW       88
L__moveLock254:
	BTFSS       STATUS+0, 0 
	GOTO        L_moveLock120
	MOVLW       128
	BTFSC       moveLock_j_L0+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       moveLock_moveTimer_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveLock255
	MOVLW       0
	BTFSC       moveLock_j_L0+1, 7 
	MOVLW       255
	MOVWF       R0 
	MOVF        moveLock_moveTimer_L0+2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveLock255
	MOVF        moveLock_moveTimer_L0+1, 0 
	SUBWF       moveLock_j_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveLock255
	MOVF        moveLock_moveTimer_L0+0, 0 
	SUBWF       moveLock_j_L0+0, 0 
L__moveLock255:
	BTFSC       STATUS+0, 0 
	GOTO        L_moveLock120
L__moveLock220:
;KeyPadWithWeb18f4620.c,342 :: 		j++;  //wait, count though
	INFSNZ      moveLock_j_L0+0, 1 
	INCF        moveLock_j_L0+1, 1 
	GOTO        L_moveLock119
L_moveLock120:
;KeyPadWithWeb18f4620.c,343 :: 		j=0;
	CLRF        moveLock_j_L0+0 
	CLRF        moveLock_j_L0+1 
;KeyPadWithWeb18f4620.c,344 :: 		PORTA &= 0b11101111; //turn off
	MOVLW       239
	ANDWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,345 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_moveLock123:
	DECFSZ      R13, 1, 1
	BRA         L_moveLock123
	DECFSZ      R12, 1, 1
	BRA         L_moveLock123
	DECFSZ      R11, 1, 1
	BRA         L_moveLock123
	NOP
;KeyPadWithWeb18f4620.c,346 :: 		PORTA |= 0b00100010; // lock direction
	MOVLW       34
	IORWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,347 :: 		delay_ms(50); //to allow any voltage spike to simmer down
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_moveLock124:
	DECFSZ      R13, 1, 1
	BRA         L_moveLock124
	DECFSZ      R12, 1, 1
	BRA         L_moveLock124
	NOP
	NOP
;KeyPadWithWeb18f4620.c,348 :: 		while((ADCRead(0) >=300) && j<moveTimer) // Home position
L_moveLock125:
	CLRF        FARG_ADCRead_ch+0 
	CALL        _ADCRead+0, 0
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	XORLW       1
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveLock256
	MOVLW       44
	SUBWF       R0, 0 
L__moveLock256:
	BTFSS       STATUS+0, 0 
	GOTO        L_moveLock126
	MOVLW       128
	BTFSC       moveLock_j_L0+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       moveLock_moveTimer_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveLock257
	MOVLW       0
	BTFSC       moveLock_j_L0+1, 7 
	MOVLW       255
	MOVWF       R0 
	MOVF        moveLock_moveTimer_L0+2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveLock257
	MOVF        moveLock_moveTimer_L0+1, 0 
	SUBWF       moveLock_j_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveLock257
	MOVF        moveLock_moveTimer_L0+0, 0 
	SUBWF       moveLock_j_L0+0, 0 
L__moveLock257:
	BTFSC       STATUS+0, 0 
	GOTO        L_moveLock126
L__moveLock219:
;KeyPadWithWeb18f4620.c,349 :: 		j++;
	INFSNZ      moveLock_j_L0+0, 1 
	INCF        moveLock_j_L0+1, 1 
	GOTO        L_moveLock125
L_moveLock126:
;KeyPadWithWeb18f4620.c,350 :: 		j=0;
	CLRF        moveLock_j_L0+0 
	CLRF        moveLock_j_L0+1 
;KeyPadWithWeb18f4620.c,351 :: 		PORTA &= 0b11011111;
	MOVLW       223
	ANDWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,352 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_moveLock129:
	DECFSZ      R13, 1, 1
	BRA         L_moveLock129
	DECFSZ      R12, 1, 1
	BRA         L_moveLock129
	NOP
;KeyPadWithWeb18f4620.c,353 :: 		}
L_end_moveLock:
	RETURN      0
; end of _moveLock

_moveUnlock:

;KeyPadWithWeb18f4620.c,355 :: 		void moveUnlock(){
;KeyPadWithWeb18f4620.c,356 :: 		long moveTimer = 800000;
	MOVLW       0
	MOVWF       moveUnlock_moveTimer_L0+0 
	MOVLW       53
	MOVWF       moveUnlock_moveTimer_L0+1 
	MOVLW       12
	MOVWF       moveUnlock_moveTimer_L0+2 
	MOVLW       0
	MOVWF       moveUnlock_moveTimer_L0+3 
	CLRF        moveUnlock_j_L0+0 
	CLRF        moveUnlock_j_L0+1 
;KeyPadWithWeb18f4620.c,358 :: 		PORTA |= 0b00100010;  //lock direction
	MOVLW       34
	IORWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,359 :: 		delay_ms(50); //avoid voltage spike
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_moveUnlock130:
	DECFSZ      R13, 1, 1
	BRA         L_moveUnlock130
	DECFSZ      R12, 1, 1
	BRA         L_moveUnlock130
	NOP
	NOP
;KeyPadWithWeb18f4620.c,360 :: 		while((ADCRead(0) >= 165) && j<moveTimer)
L_moveUnlock131:
	CLRF        FARG_ADCRead_ch+0 
	CALL        _ADCRead+0, 0
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveUnlock259
	MOVLW       165
	SUBWF       R0, 0 
L__moveUnlock259:
	BTFSS       STATUS+0, 0 
	GOTO        L_moveUnlock132
	MOVLW       128
	BTFSC       moveUnlock_j_L0+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       moveUnlock_moveTimer_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveUnlock260
	MOVLW       0
	BTFSC       moveUnlock_j_L0+1, 7 
	MOVLW       255
	MOVWF       R0 
	MOVF        moveUnlock_moveTimer_L0+2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveUnlock260
	MOVF        moveUnlock_moveTimer_L0+1, 0 
	SUBWF       moveUnlock_j_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveUnlock260
	MOVF        moveUnlock_moveTimer_L0+0, 0 
	SUBWF       moveUnlock_j_L0+0, 0 
L__moveUnlock260:
	BTFSC       STATUS+0, 0 
	GOTO        L_moveUnlock132
L__moveUnlock222:
;KeyPadWithWeb18f4620.c,361 :: 		j++;
	INFSNZ      moveUnlock_j_L0+0, 1 
	INCF        moveUnlock_j_L0+1, 1 
	GOTO        L_moveUnlock131
L_moveUnlock132:
;KeyPadWithWeb18f4620.c,362 :: 		j=0;
	CLRF        moveUnlock_j_L0+0 
	CLRF        moveUnlock_j_L0+1 
;KeyPadWithWeb18f4620.c,363 :: 		PORTA &= 0b11011111;  //turn off
	MOVLW       223
	ANDWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,364 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_moveUnlock135:
	DECFSZ      R13, 1, 1
	BRA         L_moveUnlock135
	DECFSZ      R12, 1, 1
	BRA         L_moveUnlock135
	DECFSZ      R11, 1, 1
	BRA         L_moveUnlock135
	NOP
;KeyPadWithWeb18f4620.c,365 :: 		PORTA |= 0b00010000;  //unlock direction
	BSF         PORTA+0, 4 
;KeyPadWithWeb18f4620.c,366 :: 		delay_ms(50); //voltage spike protection
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_moveUnlock136:
	DECFSZ      R13, 1, 1
	BRA         L_moveUnlock136
	DECFSZ      R12, 1, 1
	BRA         L_moveUnlock136
	NOP
	NOP
;KeyPadWithWeb18f4620.c,367 :: 		while((ADCRead(0) <= 300) && j<moveTimer)  //home position
L_moveUnlock137:
	CLRF        FARG_ADCRead_ch+0 
	CALL        _ADCRead+0, 0
	MOVLW       128
	XORLW       1
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveUnlock261
	MOVF        R0, 0 
	SUBLW       44
L__moveUnlock261:
	BTFSS       STATUS+0, 0 
	GOTO        L_moveUnlock138
	MOVLW       128
	BTFSC       moveUnlock_j_L0+1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	XORWF       moveUnlock_moveTimer_L0+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveUnlock262
	MOVLW       0
	BTFSC       moveUnlock_j_L0+1, 7 
	MOVLW       255
	MOVWF       R0 
	MOVF        moveUnlock_moveTimer_L0+2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveUnlock262
	MOVF        moveUnlock_moveTimer_L0+1, 0 
	SUBWF       moveUnlock_j_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__moveUnlock262
	MOVF        moveUnlock_moveTimer_L0+0, 0 
	SUBWF       moveUnlock_j_L0+0, 0 
L__moveUnlock262:
	BTFSC       STATUS+0, 0 
	GOTO        L_moveUnlock138
L__moveUnlock221:
;KeyPadWithWeb18f4620.c,368 :: 		j++;
	INFSNZ      moveUnlock_j_L0+0, 1 
	INCF        moveUnlock_j_L0+1, 1 
	GOTO        L_moveUnlock137
L_moveUnlock138:
;KeyPadWithWeb18f4620.c,369 :: 		PORTA &= 0b11101111;
	MOVLW       239
	ANDWF       PORTA+0, 1 
;KeyPadWithWeb18f4620.c,370 :: 		j=0;
	CLRF        moveUnlock_j_L0+0 
	CLRF        moveUnlock_j_L0+1 
;KeyPadWithWeb18f4620.c,371 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_moveUnlock141:
	DECFSZ      R13, 1, 1
	BRA         L_moveUnlock141
	DECFSZ      R12, 1, 1
	BRA         L_moveUnlock141
	NOP
;KeyPadWithWeb18f4620.c,372 :: 		}
L_end_moveUnlock:
	RETURN      0
; end of _moveUnlock

_getCommand:

;KeyPadWithWeb18f4620.c,376 :: 		int getCommand(void){
;KeyPadWithWeb18f4620.c,378 :: 		long j = 0;
;KeyPadWithWeb18f4620.c,379 :: 		int i = 0;
	MOVLW       ?ICSgetCommand_i_L0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICSgetCommand_i_L0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICSgetCommand_i_L0+0)
	MOVWF       TBLPTRU 
	MOVLW       getCommand_i_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(getCommand_i_L0+0)
	MOVWF       FSR1H 
	MOVLW       20
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;KeyPadWithWeb18f4620.c,389 :: 		for(i = 0; i < 9; i++ ){  //all 8 bits of data and the closing bracket. 9 total
	CLRF        getCommand_i_L0+0 
	CLRF        getCommand_i_L0+1 
L_getCommand142:
	MOVLW       128
	XORWF       getCommand_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getCommand264
	MOVLW       9
	SUBWF       getCommand_i_L0+0, 0 
L__getCommand264:
	BTFSC       STATUS+0, 0 
	GOTO        L_getCommand143
;KeyPadWithWeb18f4620.c,390 :: 		while((!(PORTC & pulsePin))  ){ //  && (j < timeOut)){ // wait till pulse starts
L_getCommand145:
	BTFSC       PORTC+0, 5 
	GOTO        L_getCommand146
;KeyPadWithWeb18f4620.c,392 :: 		}
	GOTO        L_getCommand145
L_getCommand146:
;KeyPadWithWeb18f4620.c,393 :: 		delay_ms(1); //tiny delay to ensure we have good data before writing it
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_getCommand147:
	DECFSZ      R13, 1, 1
	BRA         L_getCommand147
	DECFSZ      R12, 1, 1
	BRA         L_getCommand147
	NOP
	NOP
;KeyPadWithWeb18f4620.c,395 :: 		if( i < 8)
	MOVLW       128
	XORWF       getCommand_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getCommand265
	MOVLW       8
	SUBWF       getCommand_i_L0+0, 0 
L__getCommand265:
	BTFSC       STATUS+0, 0 
	GOTO        L_getCommand148
;KeyPadWithWeb18f4620.c,396 :: 		commandTemp[i] = (PORTC & dataPin); // WRITE DATA
	MOVF        getCommand_i_L0+0, 0 
	MOVWF       R0 
	MOVF        getCommand_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       getCommand_commandTemp_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(getCommand_commandTemp_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       16
	ANDWF       PORTC+0, 0 
	MOVWF       R0 
	MOVLW       0
	ANDLW       0
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_getCommand149
L_getCommand148:
;KeyPadWithWeb18f4620.c,397 :: 		else if(i == 8)
	MOVLW       0
	XORWF       getCommand_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getCommand266
	MOVLW       8
	XORWF       getCommand_i_L0+0, 0 
L__getCommand266:
	BTFSS       STATUS+0, 2 
	GOTO        L_getCommand150
;KeyPadWithWeb18f4620.c,398 :: 		commandTemp[i] = (PORTC & (dataPin + parityPin));  // closing bracket
	MOVF        getCommand_i_L0+0, 0 
	MOVWF       R0 
	MOVF        getCommand_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       getCommand_commandTemp_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(getCommand_commandTemp_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       80
	ANDWF       PORTC+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
L_getCommand150:
L_getCommand149:
;KeyPadWithWeb18f4620.c,400 :: 		while((PORTC & pulsePin)  ){   //&& (j < timeOut)){ // wait till pulse is over
L_getCommand151:
	BTFSS       PORTC+0, 5 
	GOTO        L_getCommand152
;KeyPadWithWeb18f4620.c,402 :: 		}
	GOTO        L_getCommand151
L_getCommand152:
;KeyPadWithWeb18f4620.c,403 :: 		delay_ms(1); //tiny delay to ensure pulse is really over before starting again
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_getCommand153:
	DECFSZ      R13, 1, 1
	BRA         L_getCommand153
	DECFSZ      R12, 1, 1
	BRA         L_getCommand153
	NOP
	NOP
;KeyPadWithWeb18f4620.c,389 :: 		for(i = 0; i < 9; i++ ){  //all 8 bits of data and the closing bracket. 9 total
	INFSNZ      getCommand_i_L0+0, 1 
	INCF        getCommand_i_L0+1, 1 
;KeyPadWithWeb18f4620.c,407 :: 		}
	GOTO        L_getCommand142
L_getCommand143:
;KeyPadWithWeb18f4620.c,408 :: 		PORTA = 0x00;
	CLRF        PORTA+0 
;KeyPadWithWeb18f4620.c,410 :: 		if((commandTemp[8] == (dataPin + parityPin))   ){  // && (j < timeOut)){  //all went well
	MOVLW       0
	XORWF       getCommand_commandTemp_L0+17, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getCommand267
	MOVLW       80
	XORWF       getCommand_commandTemp_L0+16, 0 
L__getCommand267:
	BTFSS       STATUS+0, 2 
	GOTO        L_getCommand154
;KeyPadWithWeb18f4620.c,411 :: 		result = 0;
	CLRF        getCommand_result_L0+0 
	CLRF        getCommand_result_L0+1 
;KeyPadWithWeb18f4620.c,412 :: 		for (i = 0; i<9; i++){
	CLRF        getCommand_i_L0+0 
	CLRF        getCommand_i_L0+1 
L_getCommand155:
	MOVLW       128
	XORWF       getCommand_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getCommand268
	MOVLW       9
	SUBWF       getCommand_i_L0+0, 0 
L__getCommand268:
	BTFSC       STATUS+0, 0 
	GOTO        L_getCommand156
;KeyPadWithWeb18f4620.c,413 :: 		if (commandTemp[i] && (i<8)){
	MOVF        getCommand_i_L0+0, 0 
	MOVWF       R0 
	MOVF        getCommand_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       getCommand_commandTemp_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(getCommand_commandTemp_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_getCommand160
	MOVLW       128
	XORWF       getCommand_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getCommand269
	MOVLW       8
	SUBWF       getCommand_i_L0+0, 0 
L__getCommand269:
	BTFSC       STATUS+0, 0 
	GOTO        L_getCommand160
L__getCommand223:
;KeyPadWithWeb18f4620.c,414 :: 		result += binaryArray[i];
	MOVF        getCommand_i_L0+0, 0 
	MOVWF       R0 
	MOVF        getCommand_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       getCommand_binaryArray_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(getCommand_binaryArray_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       getCommand_result_L0+0, 1 
	MOVF        POSTINC2+0, 0 
	ADDWFC      getCommand_result_L0+1, 1 
;KeyPadWithWeb18f4620.c,415 :: 		}
L_getCommand160:
;KeyPadWithWeb18f4620.c,412 :: 		for (i = 0; i<9; i++){
	INFSNZ      getCommand_i_L0+0, 1 
	INCF        getCommand_i_L0+1, 1 
;KeyPadWithWeb18f4620.c,416 :: 		}
	GOTO        L_getCommand155
L_getCommand156:
;KeyPadWithWeb18f4620.c,417 :: 		return result;
	MOVF        getCommand_result_L0+0, 0 
	MOVWF       R0 
	MOVF        getCommand_result_L0+1, 0 
	MOVWF       R1 
	GOTO        L_end_getCommand
;KeyPadWithWeb18f4620.c,418 :: 		}
L_getCommand154:
;KeyPadWithWeb18f4620.c,422 :: 		while(PORTC & 0b01110000);  // wait until port B is clean before continuing
L_getCommand162:
	MOVLW       112
	ANDWF       PORTC+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_getCommand163
	GOTO        L_getCommand162
L_getCommand163:
;KeyPadWithWeb18f4620.c,423 :: 		return -1;  //something is wrong
	MOVLW       255
	MOVWF       R0 
	MOVLW       255
	MOVWF       R1 
;KeyPadWithWeb18f4620.c,425 :: 		}
L_end_getCommand:
	RETURN      0
; end of _getCommand

_sendStatus:

;KeyPadWithWeb18f4620.c,429 :: 		void sendStatus(char doorStatus){  // o = on, f = off
;KeyPadWithWeb18f4620.c,430 :: 		int i = 0;
	CLRF        sendStatus_i_L0+0 
	CLRF        sendStatus_i_L0+1 
;KeyPadWithWeb18f4620.c,431 :: 		PORTC &= 0b10001111;
	MOVLW       143
	ANDWF       PORTC+0, 1 
;KeyPadWithWeb18f4620.c,433 :: 		TRISC &= 0b10101111;// changes to output leaves pulse pin as an input
	MOVLW       175
	ANDWF       TRISC+0, 1 
;KeyPadWithWeb18f4620.c,434 :: 		delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_sendStatus164:
	DECFSZ      R13, 1, 1
	BRA         L_sendStatus164
	DECFSZ      R12, 1, 1
	BRA         L_sendStatus164
	NOP
	NOP
;KeyPadWithWeb18f4620.c,435 :: 		PORTC |= (parityPin + dataPin); //stick out our thumb
	MOVLW       80
	IORWF       PORTC+0, 1 
;KeyPadWithWeb18f4620.c,439 :: 		while(!(PORTC & pulsePin));// wait for ardi pulse
L_sendStatus165:
	BTFSC       PORTC+0, 5 
	GOTO        L_sendStatus166
	GOTO        L_sendStatus165
L_sendStatus166:
;KeyPadWithWeb18f4620.c,440 :: 		delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_sendStatus167:
	DECFSZ      R13, 1, 1
	BRA         L_sendStatus167
	DECFSZ      R12, 1, 1
	BRA         L_sendStatus167
	NOP
	NOP
;KeyPadWithWeb18f4620.c,441 :: 		while(!(PORTC & pulsePin));
L_sendStatus168:
	BTFSC       PORTC+0, 5 
	GOTO        L_sendStatus169
	GOTO        L_sendStatus168
L_sendStatus169:
;KeyPadWithWeb18f4620.c,442 :: 		delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_sendStatus170:
	DECFSZ      R13, 1, 1
	BRA         L_sendStatus170
	DECFSZ      R12, 1, 1
	BRA         L_sendStatus170
	NOP
	NOP
;KeyPadWithWeb18f4620.c,443 :: 		while(PORTC & pulsePin); //wait for pulse to end
L_sendStatus171:
	BTFSS       PORTC+0, 5 
	GOTO        L_sendStatus172
	GOTO        L_sendStatus171
L_sendStatus172:
;KeyPadWithWeb18f4620.c,444 :: 		delay_ms(5); //give ardi time to change dataDirection, usually real quick (5)
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_sendStatus173:
	DECFSZ      R13, 1, 1
	BRA         L_sendStatus173
	DECFSZ      R12, 1, 1
	BRA         L_sendStatus173
	NOP
	NOP
;KeyPadWithWeb18f4620.c,445 :: 		PORTC &= 0b10001111;
	MOVLW       143
	ANDWF       PORTC+0, 1 
;KeyPadWithWeb18f4620.c,446 :: 		delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_sendStatus174:
	DECFSZ      R13, 1, 1
	BRA         L_sendStatus174
	DECFSZ      R12, 1, 1
	BRA         L_sendStatus174
	NOP
	NOP
;KeyPadWithWeb18f4620.c,447 :: 		TRISC &= 0b10001111; //lastly puts pulse pin to output
	MOVLW       143
	ANDWF       TRISC+0, 1 
;KeyPadWithWeb18f4620.c,450 :: 		if(doorStatus == 'l'){  //0b11111111
	MOVF        FARG_sendStatus_doorStatus+0, 0 
	XORLW       108
	BTFSS       STATUS+0, 2 
	GOTO        L_sendStatus175
;KeyPadWithWeb18f4620.c,451 :: 		for(i=0; i<8; i++){
	CLRF        sendStatus_i_L0+0 
	CLRF        sendStatus_i_L0+1 
L_sendStatus176:
	MOVLW       128
	XORWF       sendStatus_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__sendStatus271
	MOVLW       8
	SUBWF       sendStatus_i_L0+0, 0 
L__sendStatus271:
	BTFSC       STATUS+0, 0 
	GOTO        L_sendStatus177
;KeyPadWithWeb18f4620.c,453 :: 		PORTC |= dataPin;
	BSF         PORTC+0, 4 
;KeyPadWithWeb18f4620.c,454 :: 		PORTC |= pulsePin;
	BSF         PORTC+0, 5 
;KeyPadWithWeb18f4620.c,456 :: 		delay_ms(pulseDelay);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_sendStatus179:
	DECFSZ      R13, 1, 1
	BRA         L_sendStatus179
	DECFSZ      R12, 1, 1
	BRA         L_sendStatus179
	NOP
	NOP
;KeyPadWithWeb18f4620.c,457 :: 		PORTC &= 0b10001111;  //clears comm pins
	MOVLW       143
	ANDWF       PORTC+0, 1 
;KeyPadWithWeb18f4620.c,458 :: 		delay_ms(pulseDelay);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_sendStatus180:
	DECFSZ      R13, 1, 1
	BRA         L_sendStatus180
	DECFSZ      R12, 1, 1
	BRA         L_sendStatus180
	NOP
	NOP
;KeyPadWithWeb18f4620.c,451 :: 		for(i=0; i<8; i++){
	INFSNZ      sendStatus_i_L0+0, 1 
	INCF        sendStatus_i_L0+1, 1 
;KeyPadWithWeb18f4620.c,459 :: 		}
	GOTO        L_sendStatus176
L_sendStatus177:
;KeyPadWithWeb18f4620.c,460 :: 		}
	GOTO        L_sendStatus181
L_sendStatus175:
;KeyPadWithWeb18f4620.c,461 :: 		else if(doorStatus == 'u'){ //0b11110000 turns all pins to zero
	MOVF        FARG_sendStatus_doorStatus+0, 0 
	XORLW       117
	BTFSS       STATUS+0, 2 
	GOTO        L_sendStatus182
;KeyPadWithWeb18f4620.c,462 :: 		for(i=0; i<8; i++){
	CLRF        sendStatus_i_L0+0 
	CLRF        sendStatus_i_L0+1 
L_sendStatus183:
	MOVLW       128
	XORWF       sendStatus_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__sendStatus272
	MOVLW       8
	SUBWF       sendStatus_i_L0+0, 0 
L__sendStatus272:
	BTFSC       STATUS+0, 0 
	GOTO        L_sendStatus184
;KeyPadWithWeb18f4620.c,463 :: 		if(i<4){
	MOVLW       128
	XORWF       sendStatus_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__sendStatus273
	MOVLW       4
	SUBWF       sendStatus_i_L0+0, 0 
L__sendStatus273:
	BTFSC       STATUS+0, 0 
	GOTO        L_sendStatus186
;KeyPadWithWeb18f4620.c,464 :: 		PORTC &= 0b10001111; //clear
	MOVLW       143
	ANDWF       PORTC+0, 1 
;KeyPadWithWeb18f4620.c,465 :: 		PORTC |= pulsePin;  //pulse
	BSF         PORTC+0, 5 
;KeyPadWithWeb18f4620.c,466 :: 		}
	GOTO        L_sendStatus187
L_sendStatus186:
;KeyPadWithWeb18f4620.c,468 :: 		PORTC |= dataPin;
	BSF         PORTC+0, 4 
;KeyPadWithWeb18f4620.c,469 :: 		PORTC |= pulsePin;
	BSF         PORTC+0, 5 
;KeyPadWithWeb18f4620.c,470 :: 		}
L_sendStatus187:
;KeyPadWithWeb18f4620.c,471 :: 		delay_ms(pulseDelay);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_sendStatus188:
	DECFSZ      R13, 1, 1
	BRA         L_sendStatus188
	DECFSZ      R12, 1, 1
	BRA         L_sendStatus188
	NOP
	NOP
;KeyPadWithWeb18f4620.c,472 :: 		PORTC &= 0b10001111;  //clears comm pins
	MOVLW       143
	ANDWF       PORTC+0, 1 
;KeyPadWithWeb18f4620.c,473 :: 		delay_ms(pulseDelay);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_sendStatus189:
	DECFSZ      R13, 1, 1
	BRA         L_sendStatus189
	DECFSZ      R12, 1, 1
	BRA         L_sendStatus189
	NOP
	NOP
;KeyPadWithWeb18f4620.c,462 :: 		for(i=0; i<8; i++){
	INFSNZ      sendStatus_i_L0+0, 1 
	INCF        sendStatus_i_L0+1, 1 
;KeyPadWithWeb18f4620.c,474 :: 		}
	GOTO        L_sendStatus183
L_sendStatus184:
;KeyPadWithWeb18f4620.c,475 :: 		}
L_sendStatus182:
L_sendStatus181:
;KeyPadWithWeb18f4620.c,477 :: 		PORTC |= 0b01010000;
	MOVLW       80
	IORWF       PORTC+0, 1 
;KeyPadWithWeb18f4620.c,478 :: 		PORTC |= pulsePin;
	BSF         PORTC+0, 5 
;KeyPadWithWeb18f4620.c,479 :: 		delay_ms(pulseDelay);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_sendStatus190:
	DECFSZ      R13, 1, 1
	BRA         L_sendStatus190
	DECFSZ      R12, 1, 1
	BRA         L_sendStatus190
	NOP
	NOP
;KeyPadWithWeb18f4620.c,480 :: 		PORTC &= 0b10001111; //clear comm pins
	MOVLW       143
	ANDWF       PORTC+0, 1 
;KeyPadWithWeb18f4620.c,481 :: 		TRISC |= 0b01110000;  //sets comm pins back to input
	MOVLW       112
	IORWF       TRISC+0, 1 
;KeyPadWithWeb18f4620.c,482 :: 		return;
;KeyPadWithWeb18f4620.c,483 :: 		}
L_end_sendStatus:
	RETURN      0
; end of _sendStatus

_main:

;KeyPadWithWeb18f4620.c,487 :: 		void main() {
;KeyPadWithWeb18f4620.c,488 :: 		int input = 0;
	CLRF        main_input_L0+0 
	CLRF        main_input_L0+1 
	CLRF        main_keypadCmd_L0+0 
	CLRF        main_keypadCmd_L0+1 
;KeyPadWithWeb18f4620.c,493 :: 		init_ports();
	CALL        _init_ports+0, 0
;KeyPadWithWeb18f4620.c,494 :: 		ADCInit();  // initialize A/D
	CALL        _ADCInit+0, 0
;KeyPadWithWeb18f4620.c,499 :: 		while(1){
L_main191:
;KeyPadWithWeb18f4620.c,501 :: 		if((PORTC & 0b01010000) == 0b01010000){ //opening frame. The arduino is sending a command
	MOVLW       80
	ANDWF       PORTC+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       80
	BTFSS       STATUS+0, 2 
	GOTO        L_main193
;KeyPadWithWeb18f4620.c,502 :: 		keypadCmd = getCommand();
	CALL        _getCommand+0, 0
	MOVF        R0, 0 
	MOVWF       main_keypadCmd_L0+0 
	MOVF        R1, 0 
	MOVWF       main_keypadCmd_L0+1 
;KeyPadWithWeb18f4620.c,505 :: 		if(keypadCmd == unlockDoorCmd){
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main275
	MOVLW       255
	XORWF       R0, 0 
L__main275:
	BTFSS       STATUS+0, 2 
	GOTO        L_main194
;KeyPadWithWeb18f4620.c,506 :: 		moveUnlock();
	CALL        _moveUnlock+0, 0
;KeyPadWithWeb18f4620.c,507 :: 		}
	GOTO        L_main195
L_main194:
;KeyPadWithWeb18f4620.c,508 :: 		else if(keypadCmd == lockDoorCmd){
	MOVF        main_keypadCmd_L0+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main276
	MOVLW       0
	XORWF       main_keypadCmd_L0+0, 0 
L__main276:
	BTFSS       STATUS+0, 2 
	GOTO        L_main196
;KeyPadWithWeb18f4620.c,509 :: 		moveLock();
	CALL        _moveLock+0, 0
;KeyPadWithWeb18f4620.c,510 :: 		}
L_main196:
L_main195:
;KeyPadWithWeb18f4620.c,511 :: 		}
L_main193:
;KeyPadWithWeb18f4620.c,514 :: 		if(PORTC & 0b10000000){ //direction from the wall panel, toggles on or off
	BTFSS       PORTC+0, 7 
	GOTO        L_main197
;KeyPadWithWeb18f4620.c,515 :: 		delay_ms(15); 		//noise check
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_main198:
	DECFSZ      R13, 1, 1
	BRA         L_main198
	DECFSZ      R12, 1, 1
	BRA         L_main198
;KeyPadWithWeb18f4620.c,516 :: 		if(PORTC & 0b10000000){
	BTFSS       PORTC+0, 7 
	GOTO        L_main199
;KeyPadWithWeb18f4620.c,517 :: 		if(currentStatus == 'u'){ //it was unlocked, so lock it
	MOVF        _currentStatus+0, 0 
	XORLW       117
	BTFSS       STATUS+0, 2 
	GOTO        L_main200
;KeyPadWithWeb18f4620.c,518 :: 		currentStatus = 'l';
	MOVLW       108
	MOVWF       _currentStatus+0 
;KeyPadWithWeb18f4620.c,520 :: 		moveLock();  //locks door
	CALL        _moveLock+0, 0
;KeyPadWithWeb18f4620.c,521 :: 		}
	GOTO        L_main201
L_main200:
;KeyPadWithWeb18f4620.c,522 :: 		else if(currentStatus == 'l'){  //it was locked, so unlock it
	MOVF        _currentStatus+0, 0 
	XORLW       108
	BTFSS       STATUS+0, 2 
	GOTO        L_main202
;KeyPadWithWeb18f4620.c,523 :: 		currentStatus = 'u';
	MOVLW       117
	MOVWF       _currentStatus+0 
;KeyPadWithWeb18f4620.c,525 :: 		moveUnlock(); //unlock the door
	CALL        _moveUnlock+0, 0
;KeyPadWithWeb18f4620.c,526 :: 		}
L_main202:
L_main201:
;KeyPadWithWeb18f4620.c,527 :: 		sendStatus(currentStatus);  //sends the command
	MOVF        _currentStatus+0, 0 
	MOVWF       FARG_sendStatus_doorStatus+0 
	CALL        _sendStatus+0, 0
;KeyPadWithWeb18f4620.c,528 :: 		}
L_main199:
;KeyPadWithWeb18f4620.c,529 :: 		}
L_main197:
;KeyPadWithWeb18f4620.c,530 :: 		while(PORTC & 0b10000000); // waits for user to get off the button!!!!
L_main203:
	BTFSS       PORTC+0, 7 
	GOTO        L_main204
	GOTO        L_main203
L_main204:
;KeyPadWithWeb18f4620.c,531 :: 		PORTC &= 0b10001111; //turns off comm pins
	MOVLW       143
	ANDWF       PORTC+0, 1 
;KeyPadWithWeb18f4620.c,537 :: 		PORTB = 0b11100000;
	MOVLW       224
	MOVWF       PORTB+0 
;KeyPadWithWeb18f4620.c,538 :: 		if(PORTB & 0b00011110){
	MOVLW       30
	ANDWF       PORTB+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main205
;KeyPadWithWeb18f4620.c,539 :: 		input = checkPassword();
	CALL        _checkPassword+0, 0
	MOVF        R0, 0 
	MOVWF       main_input_L0+0 
	MOVF        R1, 0 
	MOVWF       main_input_L0+1 
;KeyPadWithWeb18f4620.c,540 :: 		if(input == 1){ // password correct
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main277
	MOVLW       1
	XORWF       R0, 0 
L__main277:
	BTFSS       STATUS+0, 2 
	GOTO        L_main206
;KeyPadWithWeb18f4620.c,541 :: 		PORTA |= 0b00000010; //green led
	BSF         PORTA+0, 1 
;KeyPadWithWeb18f4620.c,542 :: 		moveUnlock();
	CALL        _moveUnlock+0, 0
;KeyPadWithWeb18f4620.c,543 :: 		PORTA = 0x00;
	CLRF        PORTA+0 
;KeyPadWithWeb18f4620.c,544 :: 		}
	GOTO        L_main207
L_main206:
;KeyPadWithWeb18f4620.c,545 :: 		else if(input == (-1)){ //enter reset mode
	MOVLW       255
	XORWF       main_input_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main278
	MOVLW       255
	XORWF       main_input_L0+0, 0 
L__main278:
	BTFSS       STATUS+0, 2 
	GOTO        L_main208
;KeyPadWithWeb18f4620.c,546 :: 		PORTA |= 0b00001000;  //blue led
	BSF         PORTA+0, 3 
;KeyPadWithWeb18f4620.c,547 :: 		delay_ms(delay1);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main209:
	DECFSZ      R13, 1, 1
	BRA         L_main209
	DECFSZ      R12, 1, 1
	BRA         L_main209
	DECFSZ      R11, 1, 1
	BRA         L_main209
;KeyPadWithWeb18f4620.c,548 :: 		resetMode();
	CALL        _resetMode+0, 0
;KeyPadWithWeb18f4620.c,549 :: 		PORTA = 0x00;
	CLRF        PORTA+0 
;KeyPadWithWeb18f4620.c,550 :: 		}
	GOTO        L_main210
L_main208:
;KeyPadWithWeb18f4620.c,551 :: 		else if(input == 7){   //lock button hit
	MOVLW       0
	XORWF       main_input_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main279
	MOVLW       7
	XORWF       main_input_L0+0, 0 
L__main279:
	BTFSS       STATUS+0, 2 
	GOTO        L_main211
;KeyPadWithWeb18f4620.c,552 :: 		PORTA |= 0b00000010;  //green led
	BSF         PORTA+0, 1 
;KeyPadWithWeb18f4620.c,553 :: 		moveLock();
	CALL        _moveLock+0, 0
;KeyPadWithWeb18f4620.c,554 :: 		PORTA = 0x00;
	CLRF        PORTA+0 
;KeyPadWithWeb18f4620.c,555 :: 		}
	GOTO        L_main212
L_main211:
;KeyPadWithWeb18f4620.c,557 :: 		PORTA = 0b00000100; //red led
	MOVLW       4
	MOVWF       PORTA+0 
;KeyPadWithWeb18f4620.c,558 :: 		delay_ms(delay1);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main213:
	DECFSZ      R13, 1, 1
	BRA         L_main213
	DECFSZ      R12, 1, 1
	BRA         L_main213
	DECFSZ      R11, 1, 1
	BRA         L_main213
;KeyPadWithWeb18f4620.c,559 :: 		PORTA = 0x00;
	CLRF        PORTA+0 
;KeyPadWithWeb18f4620.c,560 :: 		}
L_main212:
L_main210:
L_main207:
;KeyPadWithWeb18f4620.c,561 :: 		}
L_main205:
;KeyPadWithWeb18f4620.c,562 :: 		}
	GOTO        L_main191
;KeyPadWithWeb18f4620.c,563 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

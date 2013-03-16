
_init_ports:

;MyProject.c,77 :: 		void init_ports(){
;MyProject.c,78 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,79 :: 		TRISA = 0x00;
	CLRF       TRISA+0
;MyProject.c,80 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,81 :: 		TRISB = 0x00;      // data direction control, 0 for output 1 for input
	CLRF       TRISB+0
;MyProject.c,82 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,83 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;MyProject.c,84 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,85 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;MyProject.c,86 :: 		}
L_end_init_ports:
	RETURN
; end of _init_ports

_capitalR:

;MyProject.c,88 :: 		void capitalR(int charNum, int start){  //ignites a capital R starting at column specified by "start"
;MyProject.c,90 :: 		int i = 0;
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
;MyProject.c,91 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,92 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,93 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,94 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,97 :: 		if(start < 16){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR80
	MOVLW      16
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR80:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR0
;MyProject.c,98 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,99 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,100 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,102 :: 		}
	GOTO       L_capitalR1
L_capitalR0:
;MyProject.c,103 :: 		else if (start < 14){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR81
	MOVLW      14
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR81:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR2
;MyProject.c,104 :: 		PORTC = column[start];  //columns 7-13
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,105 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,106 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,107 :: 		}
	GOTO       L_capitalR3
L_capitalR2:
;MyProject.c,108 :: 		else if (start < 29){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR82
	MOVLW      29
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR82:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR4
;MyProject.c,109 :: 		PORTA |= column[start];  //columns 14-28
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTA+0, 1
;MyProject.c,110 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,111 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,112 :: 		}
L_capitalR4:
L_capitalR3:
L_capitalR1:
;MyProject.c,113 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,114 :: 		PORTB = characters[charNum][0];
	MOVLW      24
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       FARG_capitalR_charNum+0, 0
	MOVWF      R4+0
	MOVF       FARG_capitalR_charNum+1, 0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      _characters+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_characters+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTB+0
;MyProject.c,115 :: 		PORTD |= characters[charNum][1];
	MOVLW      2
	ADDWF      R0+0, 1
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTD+0, 1
;MyProject.c,116 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR5:
	MOVLW      128
	XORWF      capitalR_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR83
	MOVLW      20
	SUBWF      capitalR_i_L0+0, 0
L__capitalR83:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR6
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR5
L_capitalR6:
;MyProject.c,117 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,118 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,122 :: 		if(start < 16){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR84
	MOVLW      16
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR84:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR8
;MyProject.c,123 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,124 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,125 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,127 :: 		}
	GOTO       L_capitalR9
L_capitalR8:
;MyProject.c,128 :: 		else if (start < 14){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR85
	MOVLW      14
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR85:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR10
;MyProject.c,129 :: 		PORTC = column[start];  //columns 7-13
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,130 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,131 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,132 :: 		}
	GOTO       L_capitalR11
L_capitalR10:
;MyProject.c,133 :: 		else if (start < 29){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR86
	MOVLW      29
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR86:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR12
;MyProject.c,134 :: 		PORTA |= column[start];  //columns 14-28
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTA+0, 1
;MyProject.c,135 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,136 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,137 :: 		}
L_capitalR12:
L_capitalR11:
L_capitalR9:
;MyProject.c,138 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,139 :: 		PORTB = characters[charNum][2];
	MOVLW      24
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       FARG_capitalR_charNum+0, 0
	MOVWF      R4+0
	MOVF       FARG_capitalR_charNum+1, 0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	ADDLW      _characters+0
	MOVWF      R2+0
	MOVLW      hi_addr(_characters+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVLW      4
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTB+0
;MyProject.c,140 :: 		PORTD |= characters[charNum][3];
	MOVLW      6
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTD+0, 1
;MyProject.c,141 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR13:
	MOVLW      128
	XORWF      capitalR_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR87
	MOVLW      20
	SUBWF      capitalR_i_L0+0, 0
L__capitalR87:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR14
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR13
L_capitalR14:
;MyProject.c,142 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,143 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,148 :: 		if(start < 16){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR88
	MOVLW      16
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR88:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR16
;MyProject.c,149 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,150 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,151 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,153 :: 		}
	GOTO       L_capitalR17
L_capitalR16:
;MyProject.c,154 :: 		else if (start < 14){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR89
	MOVLW      14
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR89:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR18
;MyProject.c,155 :: 		PORTC = column[start];  //columns 7-13
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,156 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,157 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,158 :: 		}
	GOTO       L_capitalR19
L_capitalR18:
;MyProject.c,159 :: 		else if (start < 29){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR90
	MOVLW      29
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR90:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR20
;MyProject.c,160 :: 		PORTA |= column[start];  //columns 14-28
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTA+0, 1
;MyProject.c,161 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,162 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,163 :: 		}
L_capitalR20:
L_capitalR19:
L_capitalR17:
;MyProject.c,164 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,165 :: 		PORTB = characters[charNum][4];
	MOVLW      24
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       FARG_capitalR_charNum+0, 0
	MOVWF      R4+0
	MOVF       FARG_capitalR_charNum+1, 0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	ADDLW      _characters+0
	MOVWF      R2+0
	MOVLW      hi_addr(_characters+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVLW      8
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTB+0
;MyProject.c,166 :: 		PORTD |= characters[charNum][5];
	MOVLW      10
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTD+0, 1
;MyProject.c,167 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR21:
	MOVLW      128
	XORWF      capitalR_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR91
	MOVLW      20
	SUBWF      capitalR_i_L0+0, 0
L__capitalR91:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR22
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR21
L_capitalR22:
;MyProject.c,168 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,169 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,173 :: 		if(start < 16){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR92
	MOVLW      16
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR92:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR24
;MyProject.c,174 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,175 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,176 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,178 :: 		}
	GOTO       L_capitalR25
L_capitalR24:
;MyProject.c,179 :: 		else if (start < 14){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR93
	MOVLW      14
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR93:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR26
;MyProject.c,180 :: 		PORTC = column[start];  //columns 7-13
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,181 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,182 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,183 :: 		}
	GOTO       L_capitalR27
L_capitalR26:
;MyProject.c,184 :: 		else if (start < 29){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR94
	MOVLW      29
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR94:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR28
;MyProject.c,185 :: 		PORTA |= column[start];  //columns 14-28
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTA+0, 1
;MyProject.c,186 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,187 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,188 :: 		}
L_capitalR28:
L_capitalR27:
L_capitalR25:
;MyProject.c,189 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,190 :: 		PORTB = characters[charNum][6];
	MOVLW      24
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       FARG_capitalR_charNum+0, 0
	MOVWF      R4+0
	MOVF       FARG_capitalR_charNum+1, 0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	ADDLW      _characters+0
	MOVWF      R2+0
	MOVLW      hi_addr(_characters+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVLW      12
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTB+0
;MyProject.c,191 :: 		PORTD |= characters[charNum][7];
	MOVLW      14
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTD+0, 1
;MyProject.c,192 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR29:
	MOVLW      128
	XORWF      capitalR_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR95
	MOVLW      20
	SUBWF      capitalR_i_L0+0, 0
L__capitalR95:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR30
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR29
L_capitalR30:
;MyProject.c,193 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,194 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,198 :: 		if(start < 16){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR96
	MOVLW      16
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR96:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR32
;MyProject.c,199 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,200 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,201 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,203 :: 		}
	GOTO       L_capitalR33
L_capitalR32:
;MyProject.c,204 :: 		else if (start < 14){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR97
	MOVLW      14
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR97:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR34
;MyProject.c,205 :: 		PORTC = column[start];  //columns 7-13
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,206 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,207 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,208 :: 		}
	GOTO       L_capitalR35
L_capitalR34:
;MyProject.c,209 :: 		else if (start < 29){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR98
	MOVLW      29
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR98:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR36
;MyProject.c,210 :: 		PORTA |= column[start];  //columns 14-28
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTA+0, 1
;MyProject.c,211 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,212 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,213 :: 		}
L_capitalR36:
L_capitalR35:
L_capitalR33:
;MyProject.c,214 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,215 :: 		PORTB = characters[charNum][8];
	MOVLW      24
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       FARG_capitalR_charNum+0, 0
	MOVWF      R4+0
	MOVF       FARG_capitalR_charNum+1, 0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	ADDLW      _characters+0
	MOVWF      R2+0
	MOVLW      hi_addr(_characters+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVLW      16
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTB+0
;MyProject.c,216 :: 		PORTD |= characters[charNum][9];
	MOVLW      18
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTD+0, 1
;MyProject.c,217 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR37:
	MOVLW      128
	XORWF      capitalR_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR99
	MOVLW      20
	SUBWF      capitalR_i_L0+0, 0
L__capitalR99:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR38
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR37
L_capitalR38:
;MyProject.c,218 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,219 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,223 :: 		if(start < 16){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR100
	MOVLW      16
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR100:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR40
;MyProject.c,224 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,225 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,226 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,228 :: 		}
	GOTO       L_capitalR41
L_capitalR40:
;MyProject.c,229 :: 		else if (start < 14){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR101
	MOVLW      14
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR101:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR42
;MyProject.c,230 :: 		PORTC = column[start];  //columns 7-13
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,231 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,232 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,233 :: 		}
	GOTO       L_capitalR43
L_capitalR42:
;MyProject.c,234 :: 		else if (start < 29){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR102
	MOVLW      29
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR102:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR44
;MyProject.c,235 :: 		PORTA |= column[start];  //columns 14-28
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTA+0, 1
;MyProject.c,236 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,237 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,238 :: 		}
L_capitalR44:
L_capitalR43:
L_capitalR41:
;MyProject.c,239 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,240 :: 		PORTB = characters[charNum][10];
	MOVLW      24
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       FARG_capitalR_charNum+0, 0
	MOVWF      R4+0
	MOVF       FARG_capitalR_charNum+1, 0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	ADDLW      _characters+0
	MOVWF      R2+0
	MOVLW      hi_addr(_characters+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVLW      20
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTB+0
;MyProject.c,241 :: 		PORTD |= characters[charNum][11];
	MOVLW      22
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTD+0, 1
;MyProject.c,242 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR45:
	MOVLW      128
	XORWF      capitalR_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR103
	MOVLW      20
	SUBWF      capitalR_i_L0+0, 0
L__capitalR103:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR46
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR45
L_capitalR46:
;MyProject.c,243 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,244 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,248 :: 		if(start < 16){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR104
	MOVLW      16
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR104:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR48
;MyProject.c,249 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,250 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,251 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,253 :: 		}
	GOTO       L_capitalR49
L_capitalR48:
;MyProject.c,254 :: 		else if (start < 14){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR105
	MOVLW      14
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR105:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR50
;MyProject.c,255 :: 		PORTC = column[start];  //columns 7-13
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,256 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,257 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,258 :: 		}
	GOTO       L_capitalR51
L_capitalR50:
;MyProject.c,259 :: 		else if (start < 29){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR106
	MOVLW      29
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR106:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR52
;MyProject.c,260 :: 		PORTA |= column[start];  //columns 14-28
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTA+0, 1
;MyProject.c,261 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,262 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,263 :: 		}
L_capitalR52:
L_capitalR51:
L_capitalR49:
;MyProject.c,264 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,265 :: 		PORTB = 0x00;  //turn off rows 1-8
	CLRF       PORTB+0
;MyProject.c,266 :: 		PORTD &= ~row9;  //turns off row9
	BCF        PORTD+0, 7
;MyProject.c,267 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR53:
	MOVLW      128
	XORWF      capitalR_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR107
	MOVLW      20
	SUBWF      capitalR_i_L0+0, 0
L__capitalR107:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR54
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR53
L_capitalR54:
;MyProject.c,268 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,269 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,272 :: 		if(start < 16){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR108
	MOVLW      16
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR108:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR56
;MyProject.c,273 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,274 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,275 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,277 :: 		}
	GOTO       L_capitalR57
L_capitalR56:
;MyProject.c,278 :: 		else if (start < 14){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR109
	MOVLW      14
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR109:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR58
;MyProject.c,279 :: 		PORTC = column[start];  //columns 7-13
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      PORTC+0
;MyProject.c,280 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,281 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,282 :: 		}
	GOTO       L_capitalR59
L_capitalR58:
;MyProject.c,283 :: 		else if (start < 29){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR110
	MOVLW      29
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR110:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR60
;MyProject.c,284 :: 		PORTA |= column[start];  //columns 14-28
	MOVF       FARG_capitalR_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_capitalR_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      PORTA+0, 1
;MyProject.c,285 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,286 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,287 :: 		}
L_capitalR60:
L_capitalR59:
L_capitalR57:
;MyProject.c,288 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,289 :: 		PORTD &= ~row9;  //turns off row9;
	BCF        PORTD+0, 7
;MyProject.c,290 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR61:
	MOVLW      128
	XORWF      capitalR_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR111
	MOVLW      20
	SUBWF      capitalR_i_L0+0, 0
L__capitalR111:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR62
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR61
L_capitalR62:
;MyProject.c,291 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,292 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,294 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,295 :: 		}
L_end_capitalR:
	RETURN
; end of _capitalR

_test:

;MyProject.c,299 :: 		void test(int start){
;MyProject.c,301 :: 		portSelection = &PORTA;
	MOVLW      PORTA+0
	MOVWF      _portSelection+0
;MyProject.c,304 :: 		PORTB = 0xFF;  //all rows
	MOVLW      255
	MOVWF      PORTB+0
;MyProject.c,305 :: 		*portSelection &= column[start++]; //reference column 1
	MOVF       FARG_test_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_test_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	ANDWF      R0+1, 1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,306 :: 		PORTD |= row9;  //additonal row on port d
	BSF        PORTD+0, 7
;MyProject.c,307 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test64:
	DECFSZ     R13+0, 1
	GOTO       L_test64
	DECFSZ     R12+0, 1
	GOTO       L_test64
;MyProject.c,308 :: 		PORTD &= ~row9;
	BCF        PORTD+0, 7
;MyProject.c,309 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,311 :: 		PORTB = row1 + row5;
	MOVLW      136
	MOVWF      PORTB+0
;MyProject.c,312 :: 		*portSelection &= column[start++]; //reference column 2
	MOVF       FARG_test_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_test_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	ANDWF      R0+1, 1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,313 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test65:
	DECFSZ     R13+0, 1
	GOTO       L_test65
	DECFSZ     R12+0, 1
	GOTO       L_test65
;MyProject.c,314 :: 		PORTD &= ~row9;
	BCF        PORTD+0, 7
;MyProject.c,315 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,317 :: 		PORTB = row1 + row5;
	MOVLW      136
	MOVWF      PORTB+0
;MyProject.c,318 :: 		*portSelection &= column[start++]; //reference column 3
	MOVF       FARG_test_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_test_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	ANDWF      R0+1, 1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,319 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test66:
	DECFSZ     R13+0, 1
	GOTO       L_test66
	DECFSZ     R12+0, 1
	GOTO       L_test66
;MyProject.c,320 :: 		PORTD &= ~row9;
	BCF        PORTD+0, 7
;MyProject.c,321 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,323 :: 		PORTB = row1 + row5 + row6;
	MOVLW      140
	MOVWF      PORTB+0
;MyProject.c,324 :: 		*portSelection &= column[start++];  //reference column 4
	MOVF       FARG_test_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_test_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	ANDWF      R0+1, 1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,325 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test67:
	DECFSZ     R13+0, 1
	GOTO       L_test67
	DECFSZ     R12+0, 1
	GOTO       L_test67
;MyProject.c,326 :: 		PORTD &= ~row9;
	BCF        PORTD+0, 7
;MyProject.c,327 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,329 :: 		PORTB = row1 + row5 + row7;
	MOVLW      138
	MOVWF      PORTB+0
;MyProject.c,330 :: 		*portSelection &= column[start++];  //reference column 5
	MOVF       FARG_test_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_test_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	ANDWF      R0+1, 1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,331 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test68:
	DECFSZ     R13+0, 1
	GOTO       L_test68
	DECFSZ     R12+0, 1
	GOTO       L_test68
;MyProject.c,332 :: 		PORTD &= ~row9;
	BCF        PORTD+0, 7
;MyProject.c,333 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,335 :: 		PORTB = row4 + row3 + row2 + row8;
	MOVLW      113
	MOVWF      PORTB+0
;MyProject.c,336 :: 		*portSelection &= column[start++];  	//reference column 6
	MOVF       FARG_test_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_test_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	ANDWF      R0+1, 1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,337 :: 		PORTD |= row9;  //...that extra row
	BSF        PORTD+0, 7
;MyProject.c,338 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test69:
	DECFSZ     R13+0, 1
	GOTO       L_test69
	DECFSZ     R12+0, 1
	GOTO       L_test69
;MyProject.c,339 :: 		PORTD &= ~row9;
	BCF        PORTD+0, 7
;MyProject.c,340 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,342 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,343 :: 		*portSelection &= column[start++];  //reference column 7
	MOVF       FARG_test_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_test_start+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _column+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_column+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	INCF       ___DoICPAddr+0, 1
	BTFSC      STATUS+0, 2
	INCF       ___DoICPAddr+1, 1
	CALL       _____DoICP+0
	MOVWF      R0+1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ANDWF      R0+0, 1
	INCF       FSR, 1
	MOVF       INDF+0, 0
	ANDWF      R0+1, 1
	MOVF       _portSelection+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,344 :: 		PORTD &= ~row9;  //turns off row9;
	BCF        PORTD+0, 7
;MyProject.c,345 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test70:
	DECFSZ     R13+0, 1
	GOTO       L_test70
	DECFSZ     R12+0, 1
	GOTO       L_test70
;MyProject.c,346 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,347 :: 		}
L_end_test:
	RETURN
; end of _test

_main:

;MyProject.c,350 :: 		void main() {
;MyProject.c,352 :: 		init_ports();
	CALL       _init_ports+0
;MyProject.c,353 :: 		delay_ms(20);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main71:
	DECFSZ     R13+0, 1
	GOTO       L_main71
	DECFSZ     R12+0, 1
	GOTO       L_main71
	NOP
	NOP
;MyProject.c,356 :: 		while(1){
L_main72:
;MyProject.c,359 :: 		capitalR(0, index);
	CLRF       FARG_capitalR_charNum+0
	CLRF       FARG_capitalR_charNum+1
	MOVF       _index+0, 0
	MOVWF      FARG_capitalR_start+0
	MOVF       _index+1, 0
	MOVWF      FARG_capitalR_start+1
	CALL       _capitalR+0
;MyProject.c,363 :: 		if(counter > 80){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _counter+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main114
	MOVF       _counter+0, 0
	SUBLW      80
L__main114:
	BTFSC      STATUS+0, 0
	GOTO       L_main74
;MyProject.c,364 :: 		if(index < 29)
	MOVLW      128
	XORWF      _index+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main115
	MOVLW      29
	SUBWF      _index+0, 0
L__main115:
	BTFSC      STATUS+0, 0
	GOTO       L_main75
;MyProject.c,365 :: 		index++;
	INCF       _index+0, 1
	BTFSC      STATUS+0, 2
	INCF       _index+1, 1
	GOTO       L_main76
L_main75:
;MyProject.c,367 :: 		index = 0x00; //reset index
	CLRF       _index+0
	CLRF       _index+1
L_main76:
;MyProject.c,369 :: 		counter = 0x00;  //reset counter
	CLRF       _counter+0
	CLRF       _counter+1
;MyProject.c,370 :: 		}
	GOTO       L_main77
L_main74:
;MyProject.c,372 :: 		counter++;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
L_main77:
;MyProject.c,374 :: 		}
	GOTO       L_main72
;MyProject.c,375 :: 		}
L_end_main:
	GOTO       $+0
; end of _main


_init_ports:

;MyProject.c,76 :: 		void init_ports(){
;MyProject.c,77 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,78 :: 		TRISA = 0x00;
	CLRF       TRISA+0
;MyProject.c,79 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,80 :: 		TRISB = 0x00;      // data direction control, 0 for output 1 for input
	CLRF       TRISB+0
;MyProject.c,81 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,82 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;MyProject.c,83 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,84 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;MyProject.c,85 :: 		}
L_end_init_ports:
	RETURN
; end of _init_ports

_capitalR:

;MyProject.c,87 :: 		void capitalR(int charNum, int start){  //ignites a capital R starting at column specified by "start"
;MyProject.c,89 :: 		int i = 0;
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
;MyProject.c,90 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,91 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,92 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,93 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,96 :: 		if(start < 7){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR80
	MOVLW      7
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR80:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR0
;MyProject.c,97 :: 		PORTD = column[start];  //holds address of PORTD, columns 0-7
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
	MOVWF      PORTD+0
;MyProject.c,98 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,99 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,100 :: 		}
	GOTO       L_capitalR1
L_capitalR0:
;MyProject.c,101 :: 		else if (start < 14){
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
;MyProject.c,102 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,103 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,104 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,105 :: 		}
	GOTO       L_capitalR3
L_capitalR2:
;MyProject.c,106 :: 		else if (start < 29){
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
;MyProject.c,107 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,108 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,109 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,110 :: 		}
L_capitalR4:
L_capitalR3:
L_capitalR1:
;MyProject.c,111 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,112 :: 		PORTB = characters[charNum][0];
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
;MyProject.c,113 :: 		PORTD |= characters[charNum][1];
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
;MyProject.c,114 :: 		for(i=0; i<20; i++);  //homebrew delay
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
;MyProject.c,115 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,116 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,121 :: 		if(start < 7){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR84
	MOVLW      7
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR84:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR8
;MyProject.c,122 :: 		PORTD = column[start];  //holds address of PORTD, columns 0-7
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
	MOVWF      PORTD+0
;MyProject.c,123 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,124 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,125 :: 		}
	GOTO       L_capitalR9
L_capitalR8:
;MyProject.c,126 :: 		else if (start < 14){
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
;MyProject.c,127 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,128 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,129 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,130 :: 		}
	GOTO       L_capitalR11
L_capitalR10:
;MyProject.c,131 :: 		else if (start < 29){
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
;MyProject.c,132 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,133 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,134 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,135 :: 		}
L_capitalR12:
L_capitalR11:
L_capitalR9:
;MyProject.c,136 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,137 :: 		PORTB = characters[charNum][2];
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
;MyProject.c,138 :: 		PORTD |= characters[charNum][3];
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
;MyProject.c,139 :: 		for(i=0; i<20; i++);  //homebrew delay
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
;MyProject.c,140 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,141 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,146 :: 		if(start < 7){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR88
	MOVLW      7
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR88:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR16
;MyProject.c,147 :: 		PORTD = column[start];  //holds address of PORTD, columns 0-7
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
	MOVWF      PORTD+0
;MyProject.c,148 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,149 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,150 :: 		}
	GOTO       L_capitalR17
L_capitalR16:
;MyProject.c,151 :: 		else if (start < 14){
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
;MyProject.c,152 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,153 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,154 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,155 :: 		}
	GOTO       L_capitalR19
L_capitalR18:
;MyProject.c,156 :: 		else if (start < 29){
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
;MyProject.c,157 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,158 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,159 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,160 :: 		}
L_capitalR20:
L_capitalR19:
L_capitalR17:
;MyProject.c,161 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,162 :: 		PORTB = characters[charNum][4];
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
;MyProject.c,163 :: 		PORTD |= characters[charNum][5];
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
;MyProject.c,164 :: 		for(i=0; i<20; i++);  //homebrew delay
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
;MyProject.c,165 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,166 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,170 :: 		if(start < 7){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR92
	MOVLW      7
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR92:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR24
;MyProject.c,171 :: 		PORTD = column[start];  //holds address of PORTD, columns 0-7
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
	MOVWF      PORTD+0
;MyProject.c,172 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,173 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,174 :: 		}
	GOTO       L_capitalR25
L_capitalR24:
;MyProject.c,175 :: 		else if (start < 14){
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
;MyProject.c,176 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,177 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,178 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,179 :: 		}
	GOTO       L_capitalR27
L_capitalR26:
;MyProject.c,180 :: 		else if (start < 29){
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
;MyProject.c,181 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,182 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,183 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,184 :: 		}
L_capitalR28:
L_capitalR27:
L_capitalR25:
;MyProject.c,185 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,186 :: 		PORTB = characters[charNum][6];
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
;MyProject.c,187 :: 		PORTD |= characters[charNum][7];
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
;MyProject.c,188 :: 		for(i=0; i<20; i++);  //homebrew delay
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
;MyProject.c,189 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,190 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,194 :: 		if(start < 7){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR96
	MOVLW      7
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR96:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR32
;MyProject.c,195 :: 		PORTD = column[start];  //holds address of PORTD, columns 0-7
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
	MOVWF      PORTD+0
;MyProject.c,196 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,197 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,198 :: 		}
	GOTO       L_capitalR33
L_capitalR32:
;MyProject.c,199 :: 		else if (start < 14){
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
;MyProject.c,200 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,201 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,202 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,203 :: 		}
	GOTO       L_capitalR35
L_capitalR34:
;MyProject.c,204 :: 		else if (start < 29){
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
;MyProject.c,205 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,206 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,207 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,208 :: 		}
L_capitalR36:
L_capitalR35:
L_capitalR33:
;MyProject.c,209 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,210 :: 		PORTB = characters[charNum][8];
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
;MyProject.c,211 :: 		PORTD |= characters[charNum][9];
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
;MyProject.c,212 :: 		for(i=0; i<20; i++);  //homebrew delay
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
;MyProject.c,213 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,214 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,218 :: 		if(start < 7){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR100
	MOVLW      7
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR100:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR40
;MyProject.c,219 :: 		PORTD = column[start];  //holds address of PORTD, columns 0-7
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
	MOVWF      PORTD+0
;MyProject.c,220 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,221 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,222 :: 		}
	GOTO       L_capitalR41
L_capitalR40:
;MyProject.c,223 :: 		else if (start < 14){
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
;MyProject.c,224 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,225 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,226 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,227 :: 		}
	GOTO       L_capitalR43
L_capitalR42:
;MyProject.c,228 :: 		else if (start < 29){
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
;MyProject.c,229 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,230 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,231 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,232 :: 		}
L_capitalR44:
L_capitalR43:
L_capitalR41:
;MyProject.c,233 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,234 :: 		PORTB = characters[charNum][10];
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
;MyProject.c,235 :: 		PORTD |= characters[charNum][11];
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
;MyProject.c,236 :: 		for(i=0; i<20; i++);  //homebrew delay
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
;MyProject.c,237 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,238 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,242 :: 		if(start < 7){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR104
	MOVLW      7
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR104:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR48
;MyProject.c,243 :: 		PORTD = column[start];  //holds address of PORTD, columns 0-7
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
	MOVWF      PORTD+0
;MyProject.c,244 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,245 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,246 :: 		}
	GOTO       L_capitalR49
L_capitalR48:
;MyProject.c,247 :: 		else if (start < 14){
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
;MyProject.c,248 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,249 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,250 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,251 :: 		}
	GOTO       L_capitalR51
L_capitalR50:
;MyProject.c,252 :: 		else if (start < 29){
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
;MyProject.c,253 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,254 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,255 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,256 :: 		}
L_capitalR52:
L_capitalR51:
L_capitalR49:
;MyProject.c,257 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,258 :: 		PORTB = 0x00;  //turn off rows 1-8
	CLRF       PORTB+0
;MyProject.c,259 :: 		PORTD &= ~row9;  //turns off row9
	BCF        PORTD+0, 7
;MyProject.c,260 :: 		for(i=0; i<20; i++);  //homebrew delay
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
;MyProject.c,261 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,262 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,265 :: 		if(start < 7){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR108
	MOVLW      7
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR108:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR56
;MyProject.c,266 :: 		PORTD = column[start];  //holds address of PORTD, columns 0-7
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
	MOVWF      PORTD+0
;MyProject.c,267 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,268 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,269 :: 		}
	GOTO       L_capitalR57
L_capitalR56:
;MyProject.c,270 :: 		else if (start < 14){
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
;MyProject.c,271 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,272 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,273 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,274 :: 		}
	GOTO       L_capitalR59
L_capitalR58:
;MyProject.c,275 :: 		else if (start < 29){
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
;MyProject.c,276 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,277 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,278 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,279 :: 		}
L_capitalR60:
L_capitalR59:
L_capitalR57:
;MyProject.c,280 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,281 :: 		PORTD &= ~row9;  //turns off row9;
	BCF        PORTD+0, 7
;MyProject.c,282 :: 		for(i=0; i<20; i++);  //homebrew delay
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
;MyProject.c,283 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,284 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,286 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,287 :: 		}
L_end_capitalR:
	RETURN
; end of _capitalR

_test:

;MyProject.c,291 :: 		void test(int start){
;MyProject.c,335 :: 		portSelection = &PORTA;
	MOVLW      PORTA+0
	MOVWF      _portSelection+0
;MyProject.c,338 :: 		PORTB = 0xFF;  //all rows
	MOVLW      255
	MOVWF      PORTB+0
;MyProject.c,339 :: 		*portSelection &= column[start++]; //reference column 1
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
;MyProject.c,340 :: 		PORTD |= row9;  //additonal row on port d
	BSF        PORTD+0, 7
;MyProject.c,341 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test64:
	DECFSZ     R13+0, 1
	GOTO       L_test64
	DECFSZ     R12+0, 1
	GOTO       L_test64
;MyProject.c,342 :: 		PORTD &= ~row9;
	BCF        PORTD+0, 7
;MyProject.c,343 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,345 :: 		PORTB = row1 + row5;
	MOVLW      136
	MOVWF      PORTB+0
;MyProject.c,346 :: 		*portSelection &= column[start++]; //reference column 2
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
;MyProject.c,347 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test65:
	DECFSZ     R13+0, 1
	GOTO       L_test65
	DECFSZ     R12+0, 1
	GOTO       L_test65
;MyProject.c,348 :: 		PORTD &= ~row9;
	BCF        PORTD+0, 7
;MyProject.c,349 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,351 :: 		PORTB = row1 + row5;
	MOVLW      136
	MOVWF      PORTB+0
;MyProject.c,352 :: 		*portSelection &= column[start++]; //reference column 3
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
;MyProject.c,353 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test66:
	DECFSZ     R13+0, 1
	GOTO       L_test66
	DECFSZ     R12+0, 1
	GOTO       L_test66
;MyProject.c,354 :: 		PORTD &= ~row9;
	BCF        PORTD+0, 7
;MyProject.c,355 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,357 :: 		PORTB = row1 + row5 + row6;
	MOVLW      140
	MOVWF      PORTB+0
;MyProject.c,358 :: 		*portSelection &= column[start++];  //reference column 4
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
;MyProject.c,359 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test67:
	DECFSZ     R13+0, 1
	GOTO       L_test67
	DECFSZ     R12+0, 1
	GOTO       L_test67
;MyProject.c,360 :: 		PORTD &= ~row9;
	BCF        PORTD+0, 7
;MyProject.c,361 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,363 :: 		PORTB = row1 + row5 + row7;
	MOVLW      138
	MOVWF      PORTB+0
;MyProject.c,364 :: 		*portSelection &= column[start++];  //reference column 5
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
;MyProject.c,365 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test68:
	DECFSZ     R13+0, 1
	GOTO       L_test68
	DECFSZ     R12+0, 1
	GOTO       L_test68
;MyProject.c,366 :: 		PORTD &= ~row9;
	BCF        PORTD+0, 7
;MyProject.c,367 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,369 :: 		PORTB = row4 + row3 + row2 + row8;
	MOVLW      113
	MOVWF      PORTB+0
;MyProject.c,370 :: 		*portSelection &= column[start++];  	//reference column 6
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
;MyProject.c,371 :: 		PORTD |= row9;  //...that extra row
	BSF        PORTD+0, 7
;MyProject.c,372 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test69:
	DECFSZ     R13+0, 1
	GOTO       L_test69
	DECFSZ     R12+0, 1
	GOTO       L_test69
;MyProject.c,373 :: 		PORTD &= ~row9;
	BCF        PORTD+0, 7
;MyProject.c,374 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,376 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,377 :: 		*portSelection &= column[start++];  //reference column 7
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
;MyProject.c,378 :: 		PORTD &= ~row9;  //turns off row9;
	BCF        PORTD+0, 7
;MyProject.c,379 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_test70:
	DECFSZ     R13+0, 1
	GOTO       L_test70
	DECFSZ     R12+0, 1
	GOTO       L_test70
;MyProject.c,380 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,381 :: 		}
L_end_test:
	RETURN
; end of _test

_main:

;MyProject.c,384 :: 		void main() {
;MyProject.c,386 :: 		init_ports();
	CALL       _init_ports+0
;MyProject.c,387 :: 		delay_ms(20);
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
;MyProject.c,390 :: 		while(1){
L_main72:
;MyProject.c,393 :: 		capitalR(0, index);
	CLRF       FARG_capitalR_charNum+0
	CLRF       FARG_capitalR_charNum+1
	MOVF       _index+0, 0
	MOVWF      FARG_capitalR_start+0
	MOVF       _index+1, 0
	MOVWF      FARG_capitalR_start+1
	CALL       _capitalR+0
;MyProject.c,397 :: 		if(counter > 80){
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
;MyProject.c,398 :: 		if(index < 29)
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
;MyProject.c,399 :: 		index++;
	INCF       _index+0, 1
	BTFSC      STATUS+0, 2
	INCF       _index+1, 1
	GOTO       L_main76
L_main75:
;MyProject.c,401 :: 		index = 0x00; //reset index
	CLRF       _index+0
	CLRF       _index+1
L_main76:
;MyProject.c,403 :: 		counter = 0x00;  //reset counter
	CLRF       _counter+0
	CLRF       _counter+1
;MyProject.c,404 :: 		}
	GOTO       L_main77
L_main74:
;MyProject.c,406 :: 		counter++;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
L_main77:
;MyProject.c,408 :: 		}
	GOTO       L_main72
;MyProject.c,409 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

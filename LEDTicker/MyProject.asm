
_init_ports:

;MyProject.c,91 :: 		void init_ports(){
;MyProject.c,92 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,93 :: 		TRISA = 0x00;
	CLRF       TRISA+0
;MyProject.c,94 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,95 :: 		TRISB = 0x00;      // data direction control, 0 for output 1 for input
	CLRF       TRISB+0
;MyProject.c,96 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,97 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;MyProject.c,98 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,99 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;MyProject.c,100 :: 		}
L_end_init_ports:
	RETURN
; end of _init_ports

_capitalR:

;MyProject.c,102 :: 		void capitalR(int charNum, int start){  //ignites a capital R starting at column specified by "start"
;MyProject.c,104 :: 		int i = 0;
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
;MyProject.c,105 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,106 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,107 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,108 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,111 :: 		if(start < 15){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR88
	MOVLW      15
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR88:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR0
;MyProject.c,112 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
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
;MyProject.c,113 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,114 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,116 :: 		}
	GOTO       L_capitalR1
L_capitalR0:
;MyProject.c,117 :: 		else if (start < 28){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR89
	MOVLW      28
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR89:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR2
;MyProject.c,118 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,119 :: 		PORTD |= 0b00100000;
	BSF        PORTD+0, 5
;MyProject.c,120 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,122 :: 		}
	GOTO       L_capitalR3
L_capitalR2:
;MyProject.c,123 :: 		else if (start < 29){
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
	GOTO       L_capitalR4
;MyProject.c,124 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,125 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,126 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,127 :: 		}
L_capitalR4:
L_capitalR3:
L_capitalR1:
;MyProject.c,128 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,129 :: 		PORTB = characters[charNum][0];
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
;MyProject.c,130 :: 		PORTD |= characters[charNum][1];
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
;MyProject.c,131 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR5:
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
	GOTO       L_capitalR6
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR5
L_capitalR6:
;MyProject.c,132 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,133 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,134 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,135 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,136 :: 		PORTE = 0x00;
	CLRF       PORTE+0
;MyProject.c,141 :: 		if(start < 15){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR92
	MOVLW      15
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR92:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR8
;MyProject.c,142 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
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
;MyProject.c,143 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,144 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,146 :: 		}
	GOTO       L_capitalR9
L_capitalR8:
;MyProject.c,147 :: 		else if (start < 28){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR93
	MOVLW      28
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR93:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR10
;MyProject.c,148 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,149 :: 		PORTD |= 0b00100000;
	BSF        PORTD+0, 5
;MyProject.c,150 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,152 :: 		}
	GOTO       L_capitalR11
L_capitalR10:
;MyProject.c,153 :: 		else if (start < 29){
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
	GOTO       L_capitalR12
;MyProject.c,154 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,155 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,156 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,157 :: 		}
L_capitalR12:
L_capitalR11:
L_capitalR9:
;MyProject.c,158 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,159 :: 		PORTB = characters[charNum][2];
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
;MyProject.c,160 :: 		PORTD |= characters[charNum][3];
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
;MyProject.c,161 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR13:
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
	GOTO       L_capitalR14
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR13
L_capitalR14:
;MyProject.c,162 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,163 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,164 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,165 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,166 :: 		PORTE = 0x00;
	CLRF       PORTE+0
;MyProject.c,172 :: 		if(start < 15){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR96
	MOVLW      15
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR96:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR16
;MyProject.c,173 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
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
;MyProject.c,174 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,175 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,177 :: 		}
	GOTO       L_capitalR17
L_capitalR16:
;MyProject.c,178 :: 		else if (start < 28){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR97
	MOVLW      28
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR97:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR18
;MyProject.c,179 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,180 :: 		PORTD |= 0b00100000;
	BSF        PORTD+0, 5
;MyProject.c,181 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,183 :: 		}
	GOTO       L_capitalR19
L_capitalR18:
;MyProject.c,184 :: 		else if (start < 29){
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
	GOTO       L_capitalR20
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
;MyProject.c,187 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,188 :: 		}
L_capitalR20:
L_capitalR19:
L_capitalR17:
;MyProject.c,189 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,190 :: 		PORTB = characters[charNum][4];
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
;MyProject.c,191 :: 		PORTD |= characters[charNum][5];
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
;MyProject.c,192 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR21:
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
	GOTO       L_capitalR22
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR21
L_capitalR22:
;MyProject.c,193 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,194 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,195 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,196 :: 		PORTD = 0X00;
	CLRF       PORTD+0
;MyProject.c,197 :: 		PORTE = 0x00;
	CLRF       PORTE+0
;MyProject.c,201 :: 		if(start < 15){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR100
	MOVLW      15
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR100:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR24
;MyProject.c,202 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
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
;MyProject.c,203 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,204 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,206 :: 		}
	GOTO       L_capitalR25
L_capitalR24:
;MyProject.c,207 :: 		else if (start < 28){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR101
	MOVLW      28
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR101:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR26
;MyProject.c,208 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,209 :: 		PORTD |= 0b00100000;
	BSF        PORTD+0, 5
;MyProject.c,210 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,212 :: 		}
	GOTO       L_capitalR27
L_capitalR26:
;MyProject.c,213 :: 		else if (start < 29){
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
	GOTO       L_capitalR28
;MyProject.c,214 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,215 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,216 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,217 :: 		}
L_capitalR28:
L_capitalR27:
L_capitalR25:
;MyProject.c,218 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,219 :: 		PORTB = characters[charNum][6];
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
;MyProject.c,220 :: 		PORTD |= characters[charNum][7];
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
;MyProject.c,221 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR29:
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
	GOTO       L_capitalR30
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR29
L_capitalR30:
;MyProject.c,222 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,223 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,224 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,225 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,226 :: 		PORTE = 0x00;
	CLRF       PORTE+0
;MyProject.c,231 :: 		if(start < 15){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR104
	MOVLW      15
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR104:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR32
;MyProject.c,232 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
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
;MyProject.c,233 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,234 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,236 :: 		}
	GOTO       L_capitalR33
L_capitalR32:
;MyProject.c,237 :: 		else if (start < 28){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR105
	MOVLW      28
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR105:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR34
;MyProject.c,238 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,239 :: 		PORTD |= 0b00100000;
	BSF        PORTD+0, 5
;MyProject.c,240 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,242 :: 		}
	GOTO       L_capitalR35
L_capitalR34:
;MyProject.c,243 :: 		else if (start < 29){
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
	GOTO       L_capitalR36
;MyProject.c,244 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,245 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,246 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,247 :: 		}
L_capitalR36:
L_capitalR35:
L_capitalR33:
;MyProject.c,248 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,249 :: 		PORTB = characters[charNum][8];
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
;MyProject.c,250 :: 		PORTD |= characters[charNum][9];
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
;MyProject.c,251 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR37:
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
	GOTO       L_capitalR38
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR37
L_capitalR38:
;MyProject.c,252 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,253 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,254 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,255 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,256 :: 		PORTE = 0x00;
	CLRF       PORTE+0
;MyProject.c,261 :: 		if(start < 15){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR108
	MOVLW      15
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR108:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR40
;MyProject.c,262 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
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
;MyProject.c,263 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,264 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,266 :: 		}
	GOTO       L_capitalR41
L_capitalR40:
;MyProject.c,267 :: 		else if (start < 28){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR109
	MOVLW      28
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR109:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR42
;MyProject.c,268 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,269 :: 		PORTD |= 0b00100000;
	BSF        PORTD+0, 5
;MyProject.c,270 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,272 :: 		}
	GOTO       L_capitalR43
L_capitalR42:
;MyProject.c,273 :: 		else if (start < 29){
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
	GOTO       L_capitalR44
;MyProject.c,274 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,275 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,276 :: 		PORTD &= row9;
	MOVLW      128
	ANDWF      PORTD+0, 1
;MyProject.c,277 :: 		}
L_capitalR44:
L_capitalR43:
L_capitalR41:
;MyProject.c,278 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,279 :: 		PORTB = characters[charNum][10];
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
;MyProject.c,280 :: 		PORTD |= characters[charNum][11];
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
;MyProject.c,281 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR45:
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
	GOTO       L_capitalR46
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR45
L_capitalR46:
;MyProject.c,282 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,283 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,284 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,285 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,286 :: 		PORTE = 0x00;
	CLRF       PORTE+0
;MyProject.c,291 :: 		if(start < 15){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR112
	MOVLW      15
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR112:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR48
;MyProject.c,292 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
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
;MyProject.c,293 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,294 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,296 :: 		}
	GOTO       L_capitalR49
L_capitalR48:
;MyProject.c,297 :: 		else if (start < 28){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR113
	MOVLW      28
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR113:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR50
;MyProject.c,298 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,299 :: 		PORTD |= 0b00100000;
	BSF        PORTD+0, 5
;MyProject.c,300 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,302 :: 		}
	GOTO       L_capitalR51
L_capitalR50:
;MyProject.c,303 :: 		else if (start < 29){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR114
	MOVLW      29
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR114:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR52
;MyProject.c,304 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,305 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,306 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,307 :: 		}
L_capitalR52:
L_capitalR51:
L_capitalR49:
;MyProject.c,308 :: 		start++;
	INCF       FARG_capitalR_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_capitalR_start+1, 1
;MyProject.c,309 :: 		PORTB = 0x00;  //turn off rows 1-8
	CLRF       PORTB+0
;MyProject.c,310 :: 		PORTD &= ~row9;  //turns off row9
	BCF        PORTD+0, 7
;MyProject.c,311 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR53:
	MOVLW      128
	XORWF      capitalR_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR115
	MOVLW      20
	SUBWF      capitalR_i_L0+0, 0
L__capitalR115:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR54
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR53
L_capitalR54:
;MyProject.c,312 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,313 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,314 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,315 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,316 :: 		PORTE = 0x00;
	CLRF       PORTE+0
;MyProject.c,319 :: 		if(start < 15){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR116
	MOVLW      15
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR116:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR56
;MyProject.c,320 :: 		PORTC = column[start];  //holds address of PORTD, columns 0-7
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
;MyProject.c,321 :: 		PORTD |= 0b01000000;   //control line for DMUX 1
	BSF        PORTD+0, 6
;MyProject.c,322 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,324 :: 		}
	GOTO       L_capitalR57
L_capitalR56:
;MyProject.c,325 :: 		else if (start < 28){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR117
	MOVLW      28
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR117:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR58
;MyProject.c,326 :: 		PORTC = column[start];  //columns 7-13
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
;MyProject.c,327 :: 		PORTD |= 0b00100000;
	BSF        PORTD+0, 5
;MyProject.c,328 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,330 :: 		}
	GOTO       L_capitalR59
L_capitalR58:
;MyProject.c,331 :: 		else if (start < 29){
	MOVLW      128
	XORWF      FARG_capitalR_start+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR118
	MOVLW      29
	SUBWF      FARG_capitalR_start+0, 0
L__capitalR118:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR60
;MyProject.c,332 :: 		PORTA |= column[start];  //columns 14-28
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
;MyProject.c,333 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,334 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,335 :: 		}
L_capitalR60:
L_capitalR59:
L_capitalR57:
;MyProject.c,336 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,337 :: 		PORTD &= ~row9;  //turns off row9;
	BCF        PORTD+0, 7
;MyProject.c,338 :: 		for(i=0; i<20; i++);  //homebrew delay
	CLRF       capitalR_i_L0+0
	CLRF       capitalR_i_L0+1
L_capitalR61:
	MOVLW      128
	XORWF      capitalR_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__capitalR119
	MOVLW      20
	SUBWF      capitalR_i_L0+0, 0
L__capitalR119:
	BTFSC      STATUS+0, 0
	GOTO       L_capitalR62
	INCF       capitalR_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       capitalR_i_L0+1, 1
	GOTO       L_capitalR61
L_capitalR62:
;MyProject.c,339 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;MyProject.c,340 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;MyProject.c,341 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;MyProject.c,342 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,343 :: 		PORTE = 0x00;
	CLRF       PORTE+0
;MyProject.c,344 :: 		}
L_end_capitalR:
	RETURN
; end of _capitalR

_test:

;MyProject.c,348 :: 		void test(int start){
;MyProject.c,349 :: 		PORTB = 0xff;
	MOVLW      255
	MOVWF      PORTB+0
;MyProject.c,350 :: 		PORTD = 0b10100000;
	MOVLW      160
	MOVWF      PORTD+0
;MyProject.c,353 :: 		PORTC = 0b11110000;
	MOVLW      240
	MOVWF      PORTC+0
;MyProject.c,354 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test64:
	DECFSZ     R13+0, 1
	GOTO       L_test64
	DECFSZ     R12+0, 1
	GOTO       L_test64
	DECFSZ     R11+0, 1
	GOTO       L_test64
	NOP
;MyProject.c,356 :: 		PORTC = 0b11100000;
	MOVLW      224
	MOVWF      PORTC+0
;MyProject.c,357 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test65:
	DECFSZ     R13+0, 1
	GOTO       L_test65
	DECFSZ     R12+0, 1
	GOTO       L_test65
	DECFSZ     R11+0, 1
	GOTO       L_test65
	NOP
;MyProject.c,359 :: 		PORTC = column[start++];
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
	MOVWF      PORTC+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,360 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test66:
	DECFSZ     R13+0, 1
	GOTO       L_test66
	DECFSZ     R12+0, 1
	GOTO       L_test66
	DECFSZ     R11+0, 1
	GOTO       L_test66
	NOP
;MyProject.c,362 :: 		PORTC = column[start++];
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
	MOVWF      PORTC+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,363 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test67:
	DECFSZ     R13+0, 1
	GOTO       L_test67
	DECFSZ     R12+0, 1
	GOTO       L_test67
	DECFSZ     R11+0, 1
	GOTO       L_test67
	NOP
;MyProject.c,365 :: 		PORTC = column[start++];
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
	MOVWF      PORTC+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,366 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test68:
	DECFSZ     R13+0, 1
	GOTO       L_test68
	DECFSZ     R12+0, 1
	GOTO       L_test68
	DECFSZ     R11+0, 1
	GOTO       L_test68
	NOP
;MyProject.c,368 :: 		PORTC = column[start++];
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
	MOVWF      PORTC+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,369 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test69:
	DECFSZ     R13+0, 1
	GOTO       L_test69
	DECFSZ     R12+0, 1
	GOTO       L_test69
	DECFSZ     R11+0, 1
	GOTO       L_test69
	NOP
;MyProject.c,371 :: 		PORTC = column[start++];
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
	MOVWF      PORTC+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,372 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test70:
	DECFSZ     R13+0, 1
	GOTO       L_test70
	DECFSZ     R12+0, 1
	GOTO       L_test70
	DECFSZ     R11+0, 1
	GOTO       L_test70
	NOP
;MyProject.c,374 :: 		PORTC = column[start++];
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
	MOVWF      PORTC+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,375 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test71:
	DECFSZ     R13+0, 1
	GOTO       L_test71
	DECFSZ     R12+0, 1
	GOTO       L_test71
	DECFSZ     R11+0, 1
	GOTO       L_test71
	NOP
;MyProject.c,377 :: 		PORTC = column[start++];
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
	MOVWF      PORTC+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,378 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test72:
	DECFSZ     R13+0, 1
	GOTO       L_test72
	DECFSZ     R12+0, 1
	GOTO       L_test72
	DECFSZ     R11+0, 1
	GOTO       L_test72
	NOP
;MyProject.c,380 :: 		PORTC = column[start++];
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
	MOVWF      PORTC+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,381 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test73:
	DECFSZ     R13+0, 1
	GOTO       L_test73
	DECFSZ     R12+0, 1
	GOTO       L_test73
	DECFSZ     R11+0, 1
	GOTO       L_test73
	NOP
;MyProject.c,383 :: 		PORTC = column[start++];
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
	MOVWF      PORTC+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,384 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test74:
	DECFSZ     R13+0, 1
	GOTO       L_test74
	DECFSZ     R12+0, 1
	GOTO       L_test74
	DECFSZ     R11+0, 1
	GOTO       L_test74
	NOP
;MyProject.c,386 :: 		PORTC = column[start++];
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
	MOVWF      PORTC+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,387 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test75:
	DECFSZ     R13+0, 1
	GOTO       L_test75
	DECFSZ     R12+0, 1
	GOTO       L_test75
	DECFSZ     R11+0, 1
	GOTO       L_test75
	NOP
;MyProject.c,389 :: 		PORTC = column[start++];
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
	MOVWF      PORTC+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,390 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test76:
	DECFSZ     R13+0, 1
	GOTO       L_test76
	DECFSZ     R12+0, 1
	GOTO       L_test76
	DECFSZ     R11+0, 1
	GOTO       L_test76
	NOP
;MyProject.c,392 :: 		PORTC = column[start++];
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
	MOVWF      PORTC+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,393 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test77:
	DECFSZ     R13+0, 1
	GOTO       L_test77
	DECFSZ     R12+0, 1
	GOTO       L_test77
	DECFSZ     R11+0, 1
	GOTO       L_test77
	NOP
;MyProject.c,395 :: 		PORTC = column[start++];
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
	MOVWF      PORTC+0
	INCF       FARG_test_start+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_test_start+1, 1
;MyProject.c,396 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_test78:
	DECFSZ     R13+0, 1
	GOTO       L_test78
	DECFSZ     R12+0, 1
	GOTO       L_test78
	DECFSZ     R11+0, 1
	GOTO       L_test78
	NOP
;MyProject.c,397 :: 		}
L_end_test:
	RETURN
; end of _test

_main:

;MyProject.c,400 :: 		void main() {
;MyProject.c,402 :: 		init_ports();
	CALL       _init_ports+0
;MyProject.c,403 :: 		delay_ms(20);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main79:
	DECFSZ     R13+0, 1
	GOTO       L_main79
	DECFSZ     R12+0, 1
	GOTO       L_main79
	NOP
	NOP
;MyProject.c,406 :: 		while(1){
L_main80:
;MyProject.c,409 :: 		capitalR(0, index);
	CLRF       FARG_capitalR_charNum+0
	CLRF       FARG_capitalR_charNum+1
	MOVF       _index+0, 0
	MOVWF      FARG_capitalR_start+0
	MOVF       _index+1, 0
	MOVWF      FARG_capitalR_start+1
	CALL       _capitalR+0
;MyProject.c,413 :: 		if(counter > 90){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _counter+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main122
	MOVF       _counter+0, 0
	SUBLW      90
L__main122:
	BTFSC      STATUS+0, 0
	GOTO       L_main82
;MyProject.c,414 :: 		if(index < 29)
	MOVLW      128
	XORWF      _index+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main123
	MOVLW      29
	SUBWF      _index+0, 0
L__main123:
	BTFSC      STATUS+0, 0
	GOTO       L_main83
;MyProject.c,415 :: 		index++;
	INCF       _index+0, 1
	BTFSC      STATUS+0, 2
	INCF       _index+1, 1
	GOTO       L_main84
L_main83:
;MyProject.c,417 :: 		index = 0x00; //reset index
	CLRF       _index+0
	CLRF       _index+1
L_main84:
;MyProject.c,419 :: 		counter = 0x00;  //reset counter
	CLRF       _counter+0
	CLRF       _counter+1
;MyProject.c,420 :: 		}
	GOTO       L_main85
L_main82:
;MyProject.c,422 :: 		counter++;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
L_main85:
;MyProject.c,424 :: 		}
	GOTO       L_main80
;MyProject.c,425 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

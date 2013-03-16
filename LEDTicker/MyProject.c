//Benjamin Clouser presents, the "TICKER" THIS IS THE BEST THING EVA! 
//Jacob Francis?

int counter = 0x00;

const int row1 = 0b10000000;  //PORTB
const int row2 = 0b01000000;  //"   "
const int row3 = 0b00100000;  //"   "
const int row4 = 0b00010000;  //"   "
const int row5 = 0b00001000;  //"   "
const int row6 = 0b00000100;  //"   "
const int row7 = 0b00000010;  //"   "
const int row8 = 0b00000001;  //"   "
const int row9 = 0b10000000;  //PORTD
const int allRows = 0xFF;

const int column[90] = { //this will hold the dmux command for every column... it repeats every 15 members
	0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,  
	0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

	0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,  
	0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

	0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,  
	0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

	0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,  
	0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

	0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,  
	0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000,

	0b11110000, 0b11100000, 0b11010000, 0b11000000, 0b10110000, 0b10100000, 0b10010000,  
	0b10000000, 0b01110000, 0b01100000, 0b01010000, 0b01000000, 0b00110000, 0b00100000, 0b00010000

};

/*
 [Number of options], [Number of columns]

 NOTE: In the columns, there are two options for each column. 1st space refers to PORTB (rows 1-8).
 the 2nd option refers to PORTD (row9).

 */
const int characters[1][12] = {
	{    //R 17
		allRows, row9, row1 + row5, 0, row1 + row5, 0, row1 + row5 + row6, 0,
		  row1 + row5 + row7, 0, row4 + row3 + row2 + row8, row9  },  
	/*{
	},  //A 0

	{},  //B 1
	{},  //C 2 
	{},  //D 3
	{},  //E 4
	{},  //F 5
	{},  //G 6
	{},  //H 7
	{},  //I 8
	{},  //J 9
	{},  //K 10
	{},  //L 11 
	{},  //M 12
	{},  //N 13
	{},  //0 14
	{},  //P 15
	{},  //Q 16
	{    //R 17
		allRows, row9, row1 + row5, 0, row1 + row5, 0, row1 + row5 + row6, 0,
		  row1 + row5 + row7, 0, row4 + row3 + row2 + row8, row9  },  
	{},  //S 18
	{},  //T 19
	{},  //U 20
	{},  //V 21
	{},  //W 22
	{},  //X 23
	{},  //Y 24
	{}  //Z 25  */
};

int index = 0;

int *portSelection;  //pointer for changing ports.

int *beA = &PORTA;   //debug

sbit bit0 at PORTA.B0;
sbit bit1 at PORTA.B1;


void init_ports(){
	PORTA = 0x00;               
    TRISA = 0x00;
    PORTB = 0x00;          
    TRISB = 0x00;      // data direction control, 0 for output 1 for input
    PORTC = 0x00;
    TRISC = 0x00; 
    PORTD = 0x00;
    TRISD = 0x00;
}

void capitalR(int charNum, int start){  //ignites a capital R starting at column specified by "start"

	int i = 0;
	PORTB = 0x00;
	PORTC = 0x00;
	PORTD = 0x00;
	PORTA = 0x00;

/************************* REFERENCE COLUMN 1 **************************/
	if(start < 15){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 28){
		PORTC = column[start];  //columns 7-13
		PORTD |= 0b00100000;
		PORTA = 0x00;
		
	}
	else if (start < 29){
		PORTA |= column[start];  //columns 14-28
		PORTC = 0x00;
		PORTD &= row9;
	}
	start++;
	PORTB = characters[charNum][0];
	PORTD |= characters[charNum][1];
	for(i=0; i<20; i++);  //homebrew delay
	PORTA = 0x00;
	PORTB = 0x00;
	PORTC = 0x00;
	PORTD = 0x00;
	PORTE = 0x00;



/************************* REFERENCE COLUMN 2 **************************/
	if(start < 15){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 28){
		PORTC = column[start];  //columns 7-13
		PORTD |= 0b00100000;
		PORTA = 0x00;
		
	}
	else if (start < 29){
		PORTA |= column[start];  //columns 14-28
		PORTC = 0x00;
		PORTD &= row9;
	}
	start++;
	PORTB = characters[charNum][2];
	PORTD |= characters[charNum][3];
	for(i=0; i<20; i++);  //homebrew delay
	PORTA = 0x00;
	PORTB = 0x00;
	PORTC = 0x00;
	PORTD = 0x00;
	PORTE = 0x00;

/************************* END OF REFERENCE COLUMN 2 **************************/	


/************************* REFERENCE COLUMN 3 **************************/
	if(start < 15){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 28){
		PORTC = column[start];  //columns 7-13
		PORTD |= 0b00100000;
		PORTA = 0x00;
	
	}
	else if (start < 29){
		PORTA |= column[start];  //columns 14-28
		PORTC = 0x00;
		PORTD = 0x00;
	}
	start++;
	PORTB = characters[charNum][4];
	PORTD |= characters[charNum][5];
	for(i=0; i<20; i++);  //homebrew delay
	PORTA = 0x00;
	PORTB = 0x00;
	PORTC = 0x00;
	PORTD = 0X00;
	PORTE = 0x00;


/************************* REFERENCE COLUMN 4 **************************/
	if(start < 15){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 28){
		PORTC = column[start];  //columns 7-13
		PORTD |= 0b00100000;
		PORTA = 0x00;
		
	}
	else if (start < 29){
		PORTA |= column[start];  //columns 14-28
		PORTC = 0x00;
		PORTD &= row9;
	}
	start++;
	PORTB = characters[charNum][6];
	PORTD |= characters[charNum][7];
	for(i=0; i<20; i++);  //homebrew delay
	PORTA = 0x00;
	PORTB = 0x00;
	PORTC = 0x00;
	PORTD = 0x00;
	PORTE = 0x00;



/************************* REFERENCE COLUMN 5 **************************/
	if(start < 15){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 28){
		PORTC = column[start];  //columns 7-13
		PORTD |= 0b00100000;
		PORTA = 0x00;
		
	}
	else if (start < 29){
		PORTA |= column[start];  //columns 14-28
		PORTC = 0x00;
		PORTD &= row9;
	}
	start++;
	PORTB = characters[charNum][8];
	PORTD |= characters[charNum][9];
	for(i=0; i<20; i++);  //homebrew delay
	PORTA = 0x00;
	PORTB = 0x00;
	PORTC = 0x00;
	PORTD = 0x00;
	PORTE = 0x00;



/************************* REFERENCE COLUMN 6 **************************/
	if(start < 15){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 28){
		PORTC = column[start];  //columns 7-13
		PORTD |= 0b00100000;
		PORTA = 0x00;
		
	}
	else if (start < 29){
		PORTA |= column[start];  //columns 14-28
		PORTC = 0x00;
		PORTD &= row9;
	}
	start++;	
	PORTB = characters[charNum][10];
	PORTD |= characters[charNum][11];
	for(i=0; i<20; i++);  //homebrew delay
	PORTA = 0x00;
	PORTB = 0x00;
	PORTC = 0x00;
	PORTD = 0x00;
	PORTE = 0x00;



/************************* REFERENCE COLUMN 7 **************************/
	if(start < 15){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 28){
		PORTC = column[start];  //columns 7-13
		PORTD |= 0b00100000;
		PORTA = 0x00;
	
	}
	else if (start < 29){
		PORTA |= column[start];  //columns 14-28
		PORTC = 0x00;
		PORTD = 0x00;
	}
	start++;
	PORTB = 0x00;  //turn off rows 1-8
	PORTD &= ~row9;  //turns off row9
	for(i=0; i<20; i++);  //homebrew delay
	PORTA = 0x00;
	PORTB = 0x00;
	PORTC = 0x00;
	PORTD = 0x00;
	PORTE = 0x00;


	if(start < 15){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 28){
		PORTC = column[start];  //columns 7-13
		PORTD |= 0b00100000;
		PORTA = 0x00;
	
	}
	else if (start < 29){
		PORTA |= column[start];  //columns 14-28
		PORTC = 0x00;
		PORTD = 0x00;
	}
	PORTB = 0x00;
	PORTD &= ~row9;  //turns off row9;
	for(i=0; i<20; i++);  //homebrew delay
	PORTA = 0x00;
	PORTB = 0x00;
	PORTC = 0x00;
	PORTD = 0x00;
	PORTE = 0x00;
}
	


void test(int start){
	PORTB = 0xff;
	PORTD = 0b10100000;


	PORTC = 0b11110000;
	delay_ms(500);

	PORTC = 0b11100000;
	delay_ms(500);

	PORTC = column[start++];
	delay_ms(500);

	PORTC = column[start++];
	delay_ms(500);

	PORTC = column[start++];
	delay_ms(500);

	PORTC = column[start++];
	delay_ms(500);

	PORTC = column[start++];
	delay_ms(500);

	PORTC = column[start++];
	delay_ms(500);

	PORTC = column[start++];
	delay_ms(500);

	PORTC = column[start++];
	delay_ms(500);

	PORTC = column[start++];
	delay_ms(500);

	PORTC = column[start++];
	delay_ms(500);

	PORTC = column[start++];
	delay_ms(500);

	PORTC = column[start++];
	delay_ms(500);

	PORTC = column[start++];
	delay_ms(500);
}


void main() {
	
	init_ports();
	delay_ms(20);
	

	while(1){

		//capitalR(16);
		capitalR(0, index);
		
		//test(0);

		if(counter > 90){
			if(index < 29)
				index++;
			else
				index = 0x00; //reset index

			counter = 0x00;  //reset counter
		}
		else
			counter++;
		//PORTD &= 0b11000000;
	}
}
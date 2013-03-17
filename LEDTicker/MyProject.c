
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

const int column[80] = { //this will hold the dmux command for every column... lots of work
	0b00010000, 0b00100000, 0b00110000, 0b01000000, 0b01010000, 0b01100000, 0b01110000,  //DMUX 1
	0b10000000, 0b10010000, 0b10100000, 0b10110000, 0b11000000, 0b11010000, 0b11100000, 0b11110000,  //DMUX 1

	0b00001111, 0b00001110, 0b00001101, 0b00001100, 0b00001011, 0b00001010, 0b00001001,  //DMUX 2
	0b00001000, 0b00000111, 0b00000110, 0b00000101, 0b00000100, 0b00000011, 0b00000010, 0b00000001 //DMUX 2
};

/*
 [Number of options], [Number of columns]

 NOTE: In the columns, there are two options for each column. 1st space refers to PORTB (rows 1-8).
 the 2nd option refers to PORTD (row9).

 */
const int characters[52][12] =
	 
{	 
	{ 
	// {rows 1-8, row 9}
	
	//A 0
	row3+row4+row5+row6+row7+row8, row9, 
	row2+row5, 0, 
	row1+row5, 0,
	row1+row5, 0,
	row2+row5, 0,
	row3+row4+row5+row6+row7+row8, row9
	},
	{ 
	//B 1
	allRows, row9,
	row1+row5, row9,
	row1+row5, row9,
	row1+row5, row9,
	row1+row5, row9,
	row2+row3+row4+row6+row7+row8, 0
	},  
	{	
	//C 2
	row2+row3+row4+row5+row6+row7+row8, 0,
	row1, row9,
	row1, row9,
	row1, row9,
	row1, row9,
	row2+row8, 0	
	},   
	{	
	//D 3
	allRows, row9,
	row1, row9,
	row1, row9,
	row1, row9,
	row2+row8, 0,
	row3+row4+row6, 0
	},
	{
	//E 4
	allRows, row9,
	row1+row5, row9,
	row1+row5, row9,
	row1+row5, row9,
	row1, row9,
	row1, row9
	},  
	{ 
	//F 5
	allRows, row9,
	row1+row5, 0,
	row1+row5, 0,
	row1+row5, 0,
	row1, 0,
	row1, 0	
	},
	{
	//G 6
	row2+row3+row4+row6+row7, 0,
	row1, row9,
	row1, row9,
	row1+row5, row9,
	row1+row5, row9,
	row2+row5+row6+row7+row8, 0
	},
	{
	//H 7
	allRows, row9,
	row5, 0,
	row5, 0,
	row5, 0,
	row5, 0,
	allRows, row9
	},
	{ 
	//I 8
	row1, row9,
	row1, row9,
	allRows, row9,
	row1, row9,
	row1, row9,
	0, 0
	},
	{ 
	//J 9
	row1+row8, 0,
	row1, row9,
	row1, row9,
	allRows, 0,
	row1, 0,
	row1, 0
	},
	{
	//K 10
	allRows, row9,
	row5, 0,
	row5, 0, 
	row4+row6, 0,
	row3+row7, 0,
	row1+row2+row8, row9
	},
	{
	//L 11 
	allRows, row9,
	0, row9,
	0, row9,
	0, row9,
	0, row9,
	0, row9
	},
	{  
	//M 12
	allRows, row9,
	row2+row3, 0,
	row4, 0,
	row4, 0,
	row2+row3, 0,
	allRows, row9	
	},
	{  
	//N 13
	allRows, row9,
	row2+row3, 0,
	row4+row5, 0,
	row6+row7, 0,
	row8, row9,
	allRows, row9
	},
	{
	//0 14
	row3+row4+row5+row6+row7, 0,
	row2+row7, 0,
	row1, row9,
	row1, row9,
	row2+row7, 0,
	row3+row4+row5+row6+row7, 0
	},
	{  
	//P 15
	allRows, row9,
	row1+row5, 0,
	row1+row5, 0,
	row1+row5, 0,
	row1+row5, 0,
	row2+row3+row4, 0
	},
	{
	//Q 16
	row3+row4+row5+row6+row7, 0,
	row2+row8, 0,
	row1, row9,
	row1+row7, row9,
	row2+row8, 0,
	row3+row4+row5+row6+row7, row9
	},
	{  
	//R 17
	allRows, row9, 
	row1 + row5, 0, 
	row1 + row5, 0, 
	row1 + row5 + row6, 0,
	row1 + row5 + row7, 0, 
	row4 + row3 + row2 + row8, row9  
	},  
	{
	//S 18
	row2+row3+row4+row8, 0,
	row1+row5, row9,
	row1+row5, row9,
	row1+row5, row9,
	row1+row5, row9,
	row2+row6+row7+row8, 0
	},
	{
	//T 19
	row1, 0,
	row1, 0, 
	allRows, row9,
	row1, 0,
	row1, 0,
	0, 0
	},
	{  
	//U 20
	allRows, 0,
	0, row9,
	0, row9,
	0, row9,
	0, row9,
	allRows, 0
	},
	{
	//V 21
	row1+row2+row3+row4+row5+row6, 0,
	row7+row8, 0,
	0, row9,
	0, row9,
	row7+row8, 0,
	row1+row2+row3+row4+row5+row6, 0
	},
	{
	//W 22
	allRows, 0,
	0, row9,
	row8, 0,
	row8, 0,
	0, row9,
	allRows, 0
	},
	{
	//X 23
	row1+row2+row8, row9,
	row3+row4+row6+row7, 0,
	row5, 0,
	row5, 0,
	row3+row4+row6+row7, 0,
	row1+row2+row8, row9
	},
	{
	//Y 24
	row1+row2, 0,
	row3+row4, 0, 
	row5+row6+row7+row8, row9,
	row3+row4, 0, 
	row1+row2, 0
	},
	{
	//Z 25  
	row1+row8, row9,
	row1+row7, row9,
	row1+row5+row6, row9,
	row1+row4+row5, row9,
	row1+row3, row9,
	row1+row2, row9
	},
	
	
	
	
	{
	//a 26 (25+1)
	row5+row6+row7+row8, 0,
	row4, row9,
	row4, row9,
	row4, row9,
	row5+row8, 0
	},
	{
	//b 27 (25+2)
	allRows, row9,
	row5+row8, 0,
	row4, 0, 
	row4, 0, 
	row4, 0,
	row5+row6+row7+row8, 0
	},
	{
	//c 28 (25+3)
	row5+row6+row7+row8, 0,
	row4, row9,
	row4, row9,
	row4, row9, 
	row4, row9,
	row5+row8, 0
	},
	{
	//d 29 (25+4)
	row5+row6+row7+row8, 0,
	row4, row9,
	row4, row9,
	row4, row9,
	row5+row8, 0,
	allRows, row9
	},
	{
	//e 30 (25+5)
	row6+row7+row8, 0,
	row5+row7, row9,
	row4+row7, row9,
	row4+row7, row9,
	row5+row7, row9,
	row6, 0
	},
	{
	//f 31 (25+6)
	row6, 0,
	row3+row4+row5+row6+row7+row8, row9,
	row2+row6, 0,
	row2, 0,
	row3, 0,
	0, 0
	},
	{
	//g 32(25+7)
	row6, row9,
	row5+row7, 0,
	row4+row8, 0,
	row4+row8, 0,
	row5+row7, 0,
	row6+row7+row8, row9
	},
	{
	//h 33(25+8)
	allRows, row9,
	row5, 0, 
	row4, 0, 
	row4, 0,
	row4, 0, 
	row5+row6+row7+row8, row9
	},
	{
	//i 34 (25+9)
	0, 0,
	0, 0,
	row3+row6+row7+row8, row9,
	0, 0,
	0, 0,
	0, 0
	},
	{
	//j 35 (25+10)
	row8, 0,
	0, row9,
	0, row9,
	row2+row5+row6+row7+row8, 0,
	0, 0,
	0, 0
	},
	{
	//k 36 (25+11)
	row3+row4+row5+row6+row7+row8, row9,
	row6, 0, 
	row6, 0, 
	row5+row7, 0,
	row4+row8, row9,
	0, 0
	},
	{
	//l 37 (25+12)
	0, 0,
	0, 0,
	row3+row4+row5+row6+row7+row8, row9,
	0, 0,
	0, 0,
	0, 0
	},
	{
	//m 38 (25+13)
	row4+row5+row6+row7+row8, row9,
	row5+row6, 0,
	row7, 0,
	row7, 0,
	row5+row6, 0,
	row4+row5+row6+row7+row8, row9
	},
	{
	//n 39 (25+14)
	row4+row5+row6+row7+row8, row9, 
	row5, 0,
	row4, 0,
	row4, 0,
	row5, 0,
	row6+row7+row8, row9
	},
	{
	//o 40 (25+15)
	row6+row7, 0,
	row5+row8, 0,
	row4, row9,
	row4, row9,
	row5+row8, 0,
	row6+row7, 0
	},
	{
	//p 41 (25+16)
	row6+row7+row8, row9
	row5+row7, 0,
	row4+row8, 0,
	row4+row8, 0,
	row5+row7, 0,
	row6, 0
	},
	{
	//q 42 (25+17)
	row6, 0,
	row5+row7, 0,
	row4+row8, 0,
	row4+row8, 0,
	row5+row7, 0,
	row6+row7+row8, row9
	},
	{
	//r 43 (25+18)
	row6+row7+row8, row9,
	row5, 0,
	row4, 0,
	row4, 0,
	row5, 0,
	0, 0
	},
	{
	//s 44 (25+19)
	row5, row9,
	row4+row6, row9,
	row4+row6, row9,
	row4+row6, row9,
	row4+row7+row8, 0,
	0, 0
	},
	{
	//t 45 (25+20)
	0, 0,
	row5, 0,
	row3+row4+row5+row6+row7+row8, row9,
	row5, 0,
	0, 0,
	0, 0
	},
	{
	//u 46 (25+21)
	row4+row5+row6+row7+row8, 0,
	0, row9,
	0, row9,
	0, row9,
	row4+row5+row6+row7+row8, 0,
	0, 0
	},
	{
	//v 47 (25+22)
	row4+row5+row6+row7, 0,
	row8, 0,
	0, row9,
	row8, 0, 
	row4+row5+row6+row7, 0,
	0, 0
	},
	{
	//w 48 (25+23)
	row4+row5+row6+row7+row8, 0,
	0, row9,
	row8, 0,
	row8, 0,
	0, row9,
	row4+row5+row6+row7+row8, 0
	},
	{
	//x 49 (25+24)
	row4, row9,
	row5+row8, 0,
	row6+row7, 0, 
	row5+row8, 0,
	row4, row9,
	0, 0
	},
	{
	//y 50 (25+25)
	row4+row5, 0,
	row6, row9,
	row7+row8, 0,
	row6, 0,
	row4+row5, 0,
	0, 0
	},
	{
	//z 51 (25+26)
	0, 0,
	row4+row8, row9,
	row4+row7, row9,
	row4+row6, row9,
	row5, row9,
	0, 0
	}
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
	if(start < 16){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 14){
		PORTC = column[start];  //columns 7-13
		PORTA = 0x00;
		PORTD &= row9;
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
	PORTB = 0x00;
	PORTD = 0x00;	


/************************* REFERENCE COLUMN 2 **************************/
	if(start < 16){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 14){
		PORTC = column[start];  //columns 7-13
		PORTA = 0x00;
		PORTD &= row9;
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
	PORTB = 0x00;
	PORTD = 0x00;
/************************* END OF REFERENCE COLUMN 2 **************************/	


/************************* REFERENCE COLUMN 3 **************************/
	if(start < 16){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 14){
		PORTC = column[start];  //columns 7-13
		PORTA = 0x00;
		PORTD = 0x00;
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
	PORTB = 0x00;
	PORTD = 0x00;


/************************* REFERENCE COLUMN 4 **************************/
	if(start < 16){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 14){
		PORTC = column[start];  //columns 7-13
		PORTA = 0x00;
		PORTD &= row9;
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
	PORTB = 0x00;
	PORTD = 0x00;


/************************* REFERENCE COLUMN 5 **************************/
	if(start < 16){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 14){
		PORTC = column[start];  //columns 7-13
		PORTA = 0x00;
		PORTD &= row9;
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
	PORTB = 0x00;
	PORTD = 0x00;


/************************* REFERENCE COLUMN 6 **************************/
	if(start < 16){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 14){
		PORTC = column[start];  //columns 7-13
		PORTA = 0x00;
		PORTD &= row9;
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
	PORTB = 0x00;
	PORTD = 0x00;	


/************************* REFERENCE COLUMN 7 **************************/
	if(start < 16){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 14){
		PORTC = column[start];  //columns 7-13
		PORTA = 0x00;
		PORTD = 0x00;
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
	PORTB = 0x00;
	PORTD = 0x00;


	if(start < 16){
	   PORTC = column[start];  //holds address of PORTD, columns 0-7
	   PORTD |= 0b01000000;   //control line for DMUX 1
	   PORTA = 0x00;

	}
	else if (start < 14){
		PORTC = column[start];  //columns 7-13
		PORTA = 0x00;
		PORTD = 0x00;
	}
	else if (start < 29){
		PORTA |= column[start];  //columns 14-28
		PORTC = 0x00;
		PORTD = 0x00;
	}
	PORTB = 0x00;
	PORTD &= ~row9;  //turns off row9;
	for(i=0; i<20; i++);  //homebrew delay
	PORTB = 0x00;
	PORTD = 0x00;

	PORTA = 0x00;
}
	


void test(int start){




	portSelection = &PORTA;	


	PORTB = 0xFF;  //all rows
	*portSelection &= column[start++]; //reference column 1
	PORTD |= row9;  //additonal row on port d
	delay_ms(1);
	PORTD &= ~row9;
	PORTB = 0x00;

	PORTB = row1 + row5;
	*portSelection &= column[start++]; //reference column 2
	delay_ms(1);
	PORTD &= ~row9;
	PORTB = 0x00;

	PORTB = row1 + row5;
	*portSelection &= column[start++]; //reference column 3  []
	delay_ms(1);
	PORTD &= ~row9;
	PORTB = 0x00;

	PORTB = row1 + row5 + row6;
	*portSelection &= column[start++];  //reference column 4
	delay_ms(1);
	PORTD &= ~row9;
	PORTB = 0x00;

	PORTB = row1 + row5 + row7;
	*portSelection &= column[start++];  //reference column 5
	delay_ms(1);
	PORTD &= ~row9;
	PORTB = 0x00;

	PORTB = row4 + row3 + row2 + row8;
	*portSelection &= column[start++];  	//reference column 6
	PORTD |= row9;  //...that extra row
	delay_ms(1);
	PORTD &= ~row9;
	PORTB = 0x00;

	PORTB = 0x00;
	*portSelection &= column[start++];  //reference column 7
	PORTD &= ~row9;  //turns off row9;
	delay_ms(1);
	PORTB = 0x00;
}


void main() {
	
	init_ports();
	delay_ms(20);
	

	while(1){

		//capitalR(16);
		capitalR(0, index);
		
		//test( 14);

		if(counter > 80){
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
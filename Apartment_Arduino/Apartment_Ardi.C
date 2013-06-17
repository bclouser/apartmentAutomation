
//ARDUINO 1.0+ ONLY
//Ben Clouser
//All code, circuit diagrams, pictures and videos can be found on www.benclouser.com

/*This code is written for use with an Arduino Uno with connected Peripheral Devices
In the apartment of Kelly C102. It serves as the Hub which monitors the database, and 
sends out commands when a setting changes.*/

#include <Ethernet.h>
#include <SPI.h>
#include <string.h>

////////////////////////////////////////////////////////////////////////
//CONFIGURE
////////////////////////////////////////////////////////////////////////
byte server[] = { 153 , 42, 193, 63 }; //ip Address of the server you will connect to. THIS WILL CHANGE FROM PLACE TO PLACE
byte ip[] = { 153, 42, 193, 177 };  //assignes the ardi this ip address

//The location to go to on the server
//make sure to keep HTTP/1.0 at the end, this is telling it what type of file it is
String location = "http://153.42.193.63/ardi_status.php HTTP/1.0";

// if need to change the MAC address (Very Rare)
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
////////////////////////////////////////////////////////////////////////

EthernetClient client;

int firstTime=5;  //flag to indicate that it is the first time running through

char inString[200]; // string for incoming DB stream

// these arrays store the values of the commands pulled from DB stream
char lights[9];
char shades[9];
char door[9];
char display[141];

// used for checks against what is currently held on the client side
char currentLights[9]; //holds 8 items plus termination character
char currentShades[9];
char currentDoor[9];

// for converting decimal to binary... its important!
int binaryArray[8]={128,64,32,16,8,4,2,1};

//////////////////DELAYS/////////////
const int reconnectDelay = 50; // wait before reconnect and repolling server, had it as low as 2
const int listenDelay = 80; //(80) how long to listen to each client when looking for any changes
const int pulseDelay = 12;  //this is set at 20 usually, pulse time during communication

// These are set when there are new client commands to be processed, otherwise 0
int clientLights;
int clientShades;
int clientDoor;
int clientDisplay;

//these are specific pins on PORTD
int parityPin = B01000000;
int pulsePin = B00100000;
int dataPin = B00010000;

int lightsChanged = 0; // a flag to let the ardi know to not send out commands
int shadesChanged = 0;
int doorChanged = 0;
int displayChanged = 0;

void setup(){
	DDRC = 0xFF;  //set PORTC as an output, this never changes...
	Ethernet.begin(mac, ip);
	Serial.begin(9600);
	PORTC = B00100000;  //sets A5, using as Testing power for client chip (turn off when done testing)
}

/*********************************************************************************
									~MAIN~
*********************************************************************************/
void loop(){ 
	int lightsCmd;
	int shadesCmd;
	int doorCmd;
	int displayCmd;
	
	while(!connectAndRead()){ // chill here until a connection is established
		Ethernet.begin(mac, ip);  //try restarting the network connection
	}  

	String pageValue = readPage(); //connect to the server and read the output
	
	//Serial.println(pageValue); //print out the findings.
	specifyArrays(); // this takes raw data from php page and puts them in their arrays
	
	//LIGHTS
	for(byte i =0; i<8; i++){
		if(!(lights[i]==currentLights[i])){
			Serial.println("lights");
			Serial.println(lights); 

			// converts characters in array to a binary integer
			lightsCmd = atob(lights);
		
			//Serial.println("lightsCmd:");
			//Serial.println(lightsCmd,BIN); 

			//I am not using the binary version right now (08/4/2012)
			if(!lightsChanged && !firstTime){
				sendLightCmd();
				Serial.println("sent lights command");
			}
			lightsChanged = 0; 
	
			for(byte i = 0; i<8; i++)
				currentLights[i] = lights[i];  // make it the new current
			break; // exit the for loop after just one bit is different
		}
	}	
	delay(10);
	
	//SHADES
	for(byte i =0; i<8; i++){
		if(!(shades[i]==currentShades[i])){
			Serial.println("shades");
			Serial.println(shades);
		
			shadesCmd = atob(shades);
			
			//Serial.println("shadesCmd:");
			//Serial.println(shadesCmd, BIN);
			
			if(!shadesChanged && !firstTime){
				sendShadesCmd();
				Serial.println("sent shades command");
			}
			shadesChanged = 0;
			
			for(int i = 0; i<8; i++)
				currentShades[i] = shades[i];
			break;
		}
	}
	delay(10);

	//Door
	for(byte i=0; i<8; i++){
		if(!(door[i]==currentDoor[i])){  //if they are different
			Serial.println("door");
			Serial.println(door);
		
			doorCmd = atob(door);
			
			//Serial.println("doorCmd:");
			//Serial.println(doorCmd, BIN);
			
			if(!doorChanged && !firstTime){  //"doorChanged" is set when the client is changed independent of web
				sendDoorCmd();
				Serial.println("sent door command");
			}
			doorChanged = 0;
			
			for(int i = 0; i<8; i++)
				currentDoor[i] = door[i];
			break;
		}
	}
	delay(10);

	//DISPLAY (LED TICKER)
	if(displayChanged){
		sendDisplayCmd();
	}

	delay(10);
	
	firstTime=0;  //No longer the first time through
	
	//change data direction register for inputs
	DDRD &= B10001111;  //com pins are input now
	PORTC = B00000001; //lights control line
	delay(10);
	if(PIND & B01110000){ //check if lights are talking
		DDRD |= B01110000; //turn com pins back into output
		Serial.println("Lights are talking... Listening");
		clientLights = listenToLights();
		Serial.println(clientLights,BIN);
		updateDB_Lights();
	}
	else
		clientLights = 0x00;
		
	PORTC = B00000010;  //shades control line
	delay(10);
	if(PIND & B01110000){ //check if shades are talking
		DDRD |= B01110000; //turn com pins back into output
		Serial.println("Shades are talking... Listening");
		clientShades = listenToShades();
		Serial.println(clientShades,BIN);
		updateDB_Shades();
	}
	else
		clientShades = 0x00;
	
	PORTC = B00000100;  //door control line
	delay(10);
	if(PIND & B01110000){ //check if the door is talking
		DDRD |= B01110000; //turn com pins back into output
		Serial.println("door is talking... Listening");
		clientDoor = listenToDoor();
		Serial.println(clientDoor,BIN);
		updateDB_Door();
	}
	else
		clientDoor = 0x00;
	
	DDRD |= B01110000; //turn com pins back into output
	
	memset(&shades, 0, 8 ); //clear memory
	memset(&lights, 0, 8 ); //clear memory
	
	delay(reconnectDelay); //waits before connecting again prevent data loss
}
/*********************************************************************************
									~END OF MAIN~
*********************************************************************************/

//This makes a binary int from a char array
int atob(const char * makeInt){
	int result = 0;
	int i;
	for (i = 0; makeInt[i] != '\0'; i++){
		result <<= 1; // Shift the values in result left once.  Same as
		if (makeInt[i] == '1'){
			result += 1;
		}
	}
 return result;
}

int connectAndRead(){
	//connect to the server
	Serial.println(Ethernet.localIP());
	Serial.println("connecting for DB poll...");
  
	//port 80 is typical of a www page
	if (client.connect(server, 80)) {
		client.print("GET ");
		client.println(location);
		client.println();
		return 1;  // connection successful
	}
	else{
		return 0;  //connection failed
	}
}

String readPage(){
	int stringPos = 0; // string index counter
	boolean startRead = false; 
    //read the page, and capture & return everything between '?' and '~'

    stringPos = 0;
    memset(inString,' ', 200); //clear inString memory

	while(true){

		if (client.available()) {
		char c = client.read();
		Serial.print(c);

			if (c == '?' ) { 			//'?' is our begining character
				startRead = true; 		//Ready to start reading the part 
			}
			else if(startRead){
				if(c != '~'){ 			//'~' is our ending character
					inString[stringPos] = c;
					stringPos ++;
				}
				else{
					//got what we needed, disconnect
					startRead = false;
					c = 0;
					client.stop();
					client.flush();
					Serial.println("end of poll disconnecting.");
          
				return inString;
				}
			}
		}
	}
}

			/*PULLS COMMANDS OUT OF "inString" AND ASSIGNS THEM TO THE CORRECT CATEGORY*/
void specifyArrays(){
	//I had a better way of doing this but it was super confusing
	// to look at... it's ugly, i know
	lights[0] = inString[7];
	lights[1] = inString[8];
	lights[2] = inString[9];
	lights[3] = inString[10];
	lights[4] = inString[11];
	lights[5] = inString[12];
	lights[6] = inString[13];
	lights[7] = inString[14];
	lights[8] = '\0';
	
	Serial.println("lights: ");
	Serial.print(lights);
	Serial.println(" \n");
	
	shades[0] = inString[23];
	shades[1] = inString[24];
	shades[2] = inString[25];
	shades[3] = inString[26];
	shades[4] = inString[27];
	shades[5] = inString[28];
	shades[6] = inString[29];
	shades[7] = inString[30];
	
	Serial.println("shades: ");
	Serial.println(shades);
	Serial.println(" \n");
	
	door[0] = inString[37];
	door[1] = inString[38];
	door[2] = inString[39];
	door[3] = inString[40];
	door[4] = inString[41];
	door[5] = inString[42];
	door[6] = inString[43];
	door[7] = inString[44];
	
	Serial.println("door: ");
	Serial.println(door);
	Serial.println(" \n");

	for(int z = 0; z<140; z++){
		if(display[z] != inString[57+z]){
			displayChanged = 1;  // a flag indicating a change, reset when command sent to display.
			break;  //leave this for loop
		}
	}

	for(int i = 0; i<140; i++){
		display[i] = inString[57+i];
	}
	Serial.println("display: ");
	Serial.println(display);
	Serial.println("\n");
	Serial.println("\n");
	Serial.println("\n");
}

/* Sends commands to the lights client. This uses a serial like communication */
void sendLightCmd(){

	DDRD = (B11110000 | DDRD);  // sets our 4 comm pins as outputs
	PORTC = B00000001;    // lights control line

	PORTD = B01010000; // sends begining of command string signal
	delay(pulseDelay);
	PORTD = 0x00;  
    for(int i = 0; i < 9; i++){    		
    	if(lights[i] == '1'){ 
    		PORTD |= B00010000;  // data pin high for when its a one
    		PORTD |= B00100000; // pulse signal	
    	}
    	else if(lights[i] == '0'){ 
    		PORTD |= B00000000;  // data pin low for when its zero
    		PORTD |= B00100000; // pulse signal
    	}
    	else if(i == 8){   // send the closing bracket signal
    		PORTD |= B01010000;
    		PORTD |= B00100000; // pulse signal
    	}
    	delay(pulseDelay);
    	PORTD &= B10001111;  // clears comm pins
    	delay(pulseDelay);  // delay here, because I get nervous
    }

	PORTD &= B00000111; // turns pins off, stops transmitting
	PORTC = 0x00;  // turns off all control lines
}

	
void sendShadesCmd(){	
	DDRD = (DDRD | B11110000);  // sets our 4 comm pins as outputs
	PORTC = B00000010;    // shades control line
	delay(10);  //give switches time to change
	PORTD = B01010000; // sends begining of command string signal
	delay(pulseDelay);
	PORTD = 0x00;  
    for(int i = 0; i < 9; i++){    		
    	if(shades[i] == '1'){ 
    		PORTD |= B00010000;  //data pin high for when its a one
    		PORTD |= B00100000; // pulse signal	
    	}
    	else if(shades[i] == '0'){ 
    		PORTD |= B00000000;  // data pin low for when its zero
    		PORTD |= B00100000; // pulse signal
    	}
    	else if(i == 8){   //send the closing bracket signal
    		PORTD |= B01010000;
    		PORTD |= B00100000; // pulse signal
    	}
    	delay(pulseDelay);
    	PORTD &= B10001111;  // clears comm pins
    	delay(pulseDelay);  //delay here, because I get nervous
    }

	PORTD &= B00000111; // turns pins off, stops transmitting
	PORTC = 0x00;  // turns off shades control line
}


void sendDoorCmd(){	
 	DDRD = (DDRD | B11110000);  // sets our 4 comm pins as outputs
	PORTC = B00000100; // door control line
	delay(10);  //give switches time to change
	PORTD = B01010000; // sends begining of command string signal
	delay(pulseDelay);
	PORTD = 0x00;  
    for(int i = 0; i < 9; i++){    		
    	if(door[i] == '1'){ 
    		PORTD |= B00010000;  //data pin high for when its a one
    		PORTD |= B00100000; // pulse signal	
    	}
    	else if(door[i] == '0'){ 
    		PORTD |= B00000000;  // data pin low for when its zero
    		PORTD |= B00100000; // pulse signal
    	}
    	else if(i == 8){   //send the closing bracket signal
    		PORTD |= B01010000;
    		PORTD |= B00100000; // pulse signal
    	}
		
    	delay(pulseDelay);
    	PORTD &= B10001111;  // clears comm pins
    	delay(pulseDelay);  //delay here, because I get nervous
    }
	PORTD &= B00000111; // turns pins off, stops transmitting
	PORTC = 0x00;  // turns off door control line
}



void sendDisplayCmd(){
	int zeros;
	char tempBuffer[9] = {64, 64, 64, 64, 64, 64, 64, 64};
	char sendBuffer[9];
	char r = 0;
	char displayPulseDelay = 50;
	char quickDelay = 1;
	
	/*Begin transmission, we will send out each character as we go through it*/
	//first time through
	DDRD |= B11110000;  // comm pins as outputs
	PORTC = B00001000; // ticker control line
	delay(1);  //give switches time to change
	PORTD = B01010000; // sends out request signal to transmit
	delay(100);  //make sure the ticker has enough time to see this
	PORTD &=B00001111;  //clears comm pins
	PORTD = 0x00;  //stop opening signal


									// SEND OVER TO TICKER, 140 CHARS OF DATA
	for(int i =0; i<140; i++){ 
		PORTD &= B00001111;
		//Serial.println("*Starting conversion process*") //debug
		//converting character to binary representation   //debug
		//Serial.println("integer form of character");  //debug
	 	//Serial.println(display[i]+0);                //debug
	 	//Serial.println(display[i]+0, BIN);            //debug

		//puts binary into char array "tempBuffer
	 	itoa(display[i],tempBuffer,2);   //(arrayFrom, arrayTo, base)
	 	for(int t = 0; t<8; t++){
	 		Serial.println(tempBuffer[t]);
	 	}
		//converts char to ascii value and then masks all but binary bit
		
		// counts the number of MSB zeros, we will never be below 32,
		// because we dont go below ascii char value 32... yet
	 	if(display[i] < 128){
	 		zeros++;
	 		if(display[i] < 64){
	 			zeros++;
	 			if(display[i] < 32){
	 				zeros++;
	 				if(display[i] < 16){
	 					zeros++;
	 				}
	 			}
	 		}
	 	}
	 	else {
	 		zeros = 0;
	 	}

		//Serial.println("zeros:");
		//Serial.println(zeros);
		if(zeros>0){
			for (int q=0; q<8; q++) {  //puts trailing zeroes into array
				if(zeros > q){
					sendBuffer[q] = '0';  //puts msb zeros into the beginning of the array
				}
				else{
					sendBuffer[q] = tempBuffer[q-zeros]; //puts actual data into the array
				}	
			}
		}

		PORTD &= B00001111;

		//Now, we will actually transmit the character
	    for(r = 0; r < 9; r++){ 
	   		if(r < 8) {
		    	if(sendBuffer[r] == '1'){ 
		    		PORTD |= B00010000;  //data pin high for when its a one
		    		PORTD |= B00100000; // pulse signal	
		    	}
		    	else { 
		    		PORTD |= B00000000;  // data pin low for when its zero
		    		PORTD |= B00100000; // pulse signal
		    	}
		    }
	    	else if (r == 8){  //send the closing bracket signal
	    		PORTD |= B01010000;
	    		PORTD |= B00100000; // pulse signal
	    	}
	    	delayMicroseconds(displayPulseDelay);  //pulse delay

	    	PORTD &= B00001111;  // clears comm pins
	    	delayMicroseconds(displayPulseDelay);  //delay here, because I get nervous
	    }
		PORTD &= B00000111; // turns pins off, stops transmitting
		zeros = 0; //reset
		
	}  /* End of transmission, End of big 'for-loop', this will have transmitted each character*/

	PORTC = 0x00;  // turns off ticker control line
	DDRD &= B00001111; //return comm pins as inputs	
	Serial.println("we just transmitted each character");
	displayChanged = 0; //reset flag.
}


/****************** GET COMMAND FROM CLIENT CHIP ****************/
int getCommand(void){  
	int commandTemp[9];
	int binaryArray[8]={1,2,4,8,16,32,64,128};// convert array to int
	long j = 0;
	int i = 0;
	long timeOut = 50000;
	int result = 0;
	
	DDRD &= B10001111;
	
	j = 0; //clear the counter
	for(i = 0; i < 9; i++ ){  //all 8 bits of data and the closing bracket. 9 total
		Serial.println(i);
		while((!(PIND & pulsePin))  ){ //  && (j < timeOut)){ // wait till pulse starts
			j++;
		}
		delay(1); //tiny delay to ensure we have good data before writing it

		if( i < 8)
			commandTemp[i] = (PIND & dataPin); // WRITE DATA
		else if(i == 8)
			commandTemp[i] = (PIND & (dataPin + parityPin));  // closing bracket

		while((PIND & pulsePin)){   //&& (j < timeOut)){ // wait till pulse is over
			j++;
		}
		Serial.println(commandTemp[i]);
		delay(1); //tiny delay to ensure pulse is really over before starting again

		/* if(j >= timeOut)
			return -7; // leaves the FOR loop because we timed out */
	}

	if((commandTemp[8] == (dataPin + parityPin))   ){  // && (j < timeOut)){  //all went well
		Serial.println("Command Received Successfully");
		result = 0;
		for (i = 0; i<8; i++){
			if (commandTemp[i]){  //if its zero we dont care
				result += binaryArray[i];
			}
		}
		DDRD |= B01110000;  //turn comm pins back to output
		return result;	
	}
	else{
		while(PIND & B01110000);  // wait until port B is clean before continuing
		DDRD |= B01110000;  //turn comm pins back to output
		return -1;  //something is wrong   
	}
}

int listenToLights(){  
	int lightsTemp;
	/*************HandShake**************/
	Serial.println("sending light hand shake");
	PORTC = B00000001;  //lights control line
	delay(3);
	
	DDRD |= pulsePin;// make the pulse pin an output
	PORTD |= pulsePin;
	//this is letting the chip know that we are ready to listen
	delay(pulseDelay);
	PORTD &=B11011111; //turn off the pulse
	Serial.println("we are done shaking hands");
	
	DDRD &=B11011111; //change pulsePin back to input
	/*************End of HandShake**************/
	
	//Chip is ready to send data, listen to it
	lightsTemp = getCommand(); //gets the command coming from chip as an integer
		
	PORTC &= B11111110; // turn light control line off(A0)	
	return lightsTemp;
}

int listenToShades(){  
	int shadesTemp;
	
	/************* HandShake **************/
	Serial.println("sending shade hand shake");
	PORTC = B00000010;  //shades control line
	delay(3);

	DDRD |= B00100000;// make the pulse pin an output
	PORTD |= pulsePin;
	//this is letting the chip know that we are ready to listen
	delay(pulseDelay);
	PORTD &=B11011111; //turn off the pulse
	Serial.println("we are done shaking hands");
	
	DDRD &=B11011111; //change pulsePin back to input
	
	PORTD &= B10001111;  //clear PORTD
	/************* End of HandShake **************/
	
	//Chip is ready to send data, listen to it
	shadesTemp = getCommand(); //gets the command coming from chip as an integer
		
	PORTC &= B11111101; // turn door control line off(A0)	
	return shadesTemp;
}


int listenToDoor(){  
	int doorTemp;
	
	/************* HandShake **************/
	Serial.println("sending door hand shake");
	PORTC = B00000100;  //door control line
	delay(3);

	DDRD |= B00100000;// make the pulse pin an output
	PORTD |= pulsePin;
	//this is letting the chip know that we are ready to listen
	delay(pulseDelay);
	PORTD &=B11011111; //turn off the pulse
	Serial.println("we are done shaking hands");
	
	DDRD &=B11011111; //change pulsePin back to input
	
	PORTD &= B10001111;  //clear PORTD
	//END OF HANDSHAKE
	
	//Chip is ready to send data, listen to it
	doorTemp = getCommand(); //gets the command coming from chip as an integer
		
	PORTC &= B11111011; // turn door control line off(A0)	
	return doorTemp;
}


void updateDB_Lights(){
	Serial.println("connecting for DB update");
	if (client.connect(server, 80)) {
		client.print("GET http://153.42.193.63/ardi_db_update.php?lights=");
		if(clientLights)
			client.print(clientLights,BIN);
		else
			client.print("'0'");
			
		client.print(" HTTP/1.0");
		client.println("Host: http://153.42.193.63");
		client.println();
		Serial.println("connection successful");
		
		lightsChanged = 1;
		
	} 
	else {
		lightsChanged = 0;
		Serial.println("connection failed");
	}
	client.stop();
	client.flush();
}	

void updateDB_Shades(){	
	Serial.println("connecting for DB update");
	if (client.connect(server, 80)) {
		client.print("GET http://153.42.193.63/ardi_db_update.php?shades=");
		if(clientShades)
			client.print(clientShades,BIN);
		else
			client.print("'0'");
			
		client.print(" HTTP/1.0");
		client.println("Host: http://153.42.193.63");
		client.println();
		shadesChanged = 1;
	} 
	else {
		Serial.println("connection failed");
		shadesChanged = 0;
	}

	client.stop();
	client.flush();
}


void updateDB_Door(){	
	Serial.println("connecting for DB update");
	if (client.connect(server, 80)) {
		client.print("GET http://153.42.193.63/ardi_db_update.php?door=");
		if(clientDoor)
			client.print(clientDoor,BIN);
		else
			client.print("'0'");
			
		client.print(" HTTP/1.0");
		client.println("Host: http://153.42.193.63");
		client.println();
		doorChanged = 1;
	} 
	else {  //connection failed
		Serial.println("connection failed");
		doorChanged = 0;
	}
	client.stop();
	client.flush();
}

	

char testArray[1] = {'C'};
char outputArray[8];

void setup(){
	Serial.begin(9600);
}

void loop(){

	//testArray



	String((testArray[0]+0),BIN).toCharArray(outputArray, 8); //puts binary into char array
	Serial.println(outputArray);
	delay(5000);
	for(int i = 0; i<8; i++){
		Serial.println(outputArray[i]);

		if(outputArray[i]=='1') {	
			Serial.println("hey its a one");
		}
		else if(outputArray[i]=='0') {
			Serial.println("oh yeah... this is a zero");
		}
	}



	delay(20000);

}
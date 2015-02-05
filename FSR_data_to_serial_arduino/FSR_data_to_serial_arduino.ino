int a0 = A0; //analog input 0
int valA0 = 0; //variable to store the value of analog input 0

void setup(){
  Serial.begin(115200);
}

void loop(){
//Read the value from analog input 0 and store in 'valA0' 
  valA0 = analogRead(a0);
//Print data and custom headers to the serial port
  Serial.print("An0:");  //'An0' is the label for this data, ':' is an arbitrary delimiter
  Serial.print(valA0, DEC); //data from analog 0 printed in decimal format
  Serial.print(";");//Another arbitrary delimiter to indicate the end of the line
  delay(10);
}





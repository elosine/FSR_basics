int a0 = A0;
int a1 = A1;
int valA0 = 0;
int valA1 = 0;
int pvalA0 = 0;
int pvalA1 = 0;
boolean readVelocity0 = false;
boolean readVelocity1 = false;
int ivelocity0 = 0;
int ivelocity1 = 0;
int velocity0 = 0;
int velocity1 = 0;
int pvelocity0 = 0;
int pvelocity1 = 0;
int accel0 = 0;
int accel1 = 0;

void setup(){
  Serial.begin(115200);
}

void loop(){

  valA0 = analogRead(a0);
  valA1 = analogRead(a1);
  
  velocity0 = abs(valA0-pvalA0);
  velocity1 = abs(valA1-pvalA1);
  
  accel0 = abs(velocity0-pvelocity0);
  accel1 = abs(velocity1-pvelocity1);

  Serial.print("An0:");
  Serial.print(valA0, DEC);
  Serial.print(";");
  Serial.print("An1:");
  Serial.print(valA1, DEC);
  Serial.print(";");
  Serial.print("vl0:");
  Serial.print(velocity0, DEC);
  Serial.print(";");
  Serial.print("vl1:");
  Serial.print(velocity1, DEC);
  Serial.print(";");
  Serial.print("ac0:");
  Serial.print(accel0, DEC);
  Serial.print(";");
  Serial.print("ac1:");
  Serial.print(accel1, DEC);
  Serial.print(";");


  //velocity
  //Multiple if statements to create a one-shot trigger
  if(!readVelocity0){
    if(valA0>0){
      readVelocity0 = true;
      // Serial.println("reading");
      ivelocity0 = valA0-pvalA0;
      // Serial.println(ivelocity0);
      Serial.print("iv0:");
      Serial.print(ivelocity0, DEC);
      Serial.print(";");
    }
  }
  if(readVelocity0){
    if(valA0==0){
      readVelocity0 = false;
      // Serial.println("not reading");
    }
  }

  if(!readVelocity1){
    if(valA1>0){
      readVelocity1 = true;
      // Serial.println("reading");
      ivelocity1 = valA1-pvalA1;
      //  Serial.println(ivelocity1);
      Serial.print("iv1:");
      Serial.print(ivelocity1, DEC);
      Serial.print(";");
    }
  }
  if(readVelocity1){
    if(valA1==0){
      readVelocity1 = false;
      // Serial.println("not reading");
    }
  }


  pvalA0 = valA0;
  pvalA1 = valA1;
  pvelocity0 = velocity0;
  pvelocity1 = velocity1;


  Serial.print("om:");
  Serial.println(1999, DEC);
  delay(10);

}





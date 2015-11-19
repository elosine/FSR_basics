int nfsrs = 1;
//int fsr[] = {A0, A1, A2};
int fsr[] = {A0};
int val[1];
//int pval[] = {0, 0, 0};
//boolean readVelocity[] = {false, false, false};
//int velocity[] = {0, 0, 0};

void setup() {
  Serial.begin(9600);
}

void loop() {
  for (int i = 0; i < nfsrs; i++) {
    val[i] = analogRead(fsr[i]); //read analog pins
   // velocity[i] = abs(val[i] - pval[i]); //calculate velocity by
    //Print out raw fsr value
    Serial.print("fsr" + String(i) + ":");
    Serial.println(val[i], DEC);

  }//end for(int i=0;i<nfsrs;i++)
  delay(5);
}//end loop





#define TRIG_L 13
#define ECHO_L 12
#define TRIG_M1 11
#define ECHO_M1 10
#define TRIG_M2 9
#define ECHO_M2 8
#define TRIG_R 7
#define ECHO_R 6

float durL, durM1, durM2, durR;
float disL, disM1, disM2, disR;
float PrevM, PrevL, PrevR;
int Check;
void setup() {
  Serial.begin(9600); 
  pinMode(TRIG_L, OUTPUT);
  pinMode(ECHO_L, INPUT);
  pinMode(TRIG_M1, OUTPUT);
  pinMode(ECHO_M1, INPUT);
  pinMode(TRIG_M2, OUTPUT);
  pinMode(ECHO_M2, INPUT);
  pinMode(TRIG_R, OUTPUT);
  pinMode(ECHO_R, INPUT);
  PrevM = PrevL = PrevR = 0;
  Check = 0;
}

void loop() {
  
  digitalWrite(TRIG_M1, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_M1, LOW);
  durM1  = pulseIn(ECHO_M1, HIGH);
  disM1 = durM1 * (17.0/1000);

  digitalWrite(TRIG_M2, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_M2, LOW);
  durM2  = pulseIn(ECHO_M2, HIGH);
  disM2 = durM2 * (17.0/1000);
  
  digitalWrite(TRIG_L, HIGH);
  delayMicroseconds(10); // Added this line
  digitalWrite(TRIG_L, LOW);
  durL = pulseIn(ECHO_L, HIGH);
  disL = durL * (17.0/1000);

  digitalWrite(TRIG_R, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_R, LOW);
  durR  = pulseIn(ECHO_R, HIGH);
  disR = durR * (17.0/1000);

  if(CheckPrev(disM1,PrevM) && CheckPrev(disL,PrevL) && CheckPrev(disR,PrevR))
    Check ++;
  else
    Check = 0;

  if(Check < 30){
  int check;
  if(disM1 <= disL)
    (disM1 < disR)?check = 1 : check = 3;
  else
    (disM1 < disL)?check = 1 : check = 2;

  switch(check){
    case 1:
      if(disM1 <= 70){
        float distance = disM1 - disM2;
        if(distance <= 50)
          Serial.println("the Tall Object is On your Front");
        else
          Serial.println("the Short Object is On your Front");
      }
    break;
    case 2:
      if(disL <= 70)
        Serial.println("The Object is On your Left");
    break;
    case 3:
      if(disR <= 70)
        Serial.println("The Object is On your Right");
    break;
  } 
  }
  PrevM = disM1;
  PrevL = disL;
  PrevR = disR;
  delay(1000);
}

float CheckPrev(float Present, float Prev){
  if(abs(Present - Prev) < 10)
    return true;
  else
    return false;
}



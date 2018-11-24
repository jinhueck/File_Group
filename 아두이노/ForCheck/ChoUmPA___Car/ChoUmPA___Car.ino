#define TRIG_L 13
#define ECHO_L 12
#define TRIG_M1 11
#define ECHO_M1 10
#define TRIG_R 9
#define ECHO_R 8

float durL, durM1, durR;
float disL, disM1, disR;

void setup() {
  Serial.begin(9600); 
  pinMode(TRIG_L, OUTPUT);
  pinMode(ECHO_L, INPUT);
  pinMode(TRIG_M1, OUTPUT);
  pinMode(ECHO_M1, INPUT);
  pinMode(TRIG_R, OUTPUT);
  pinMode(ECHO_R, INPUT);
}

void loop() {
  
  digitalWrite(TRIG_M1, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_M1, LOW);
  durM1  = pulseIn(ECHO_M1, HIGH);
  disM1 = durM1 * (17.0/1000);
  
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

  int check;
  if(disM1 <= disL)
    (disM1 < disR)?check = 1 : check = 3;
  else
    (disM1 < disL)?check = 1 : check = 2;
  
  bool dis;
  switch(check){
    case 1:
        (disR < disL)?dis = true : dis = false;
        if(dis == true)
          Serial.println("Go Left");
        else if(dis == false)
          Serial.println("Go Right");
    break;
    case 2:
        (disR < disM1)?dis = true : dis = false;
        if(dis == true)
          Serial.println("Go to Center");
        else if(dis == false)
          Serial.println("Go Right");
    break;
    case 3:
      (disL < disM1)?dis = true : dis = false;
        if(dis == true)
          Serial.println("Go to Center");
        else if(dis == false)
          Serial.println("Go Left");
    break;
  }
}



#include <Wire.h>
#define SLAVE 4 // 슬레이브 주소

#define TRIG_L 13
#define ECHO_L 12
#define TRIG_M1 11
#define ECHO_M1 10
#define TRIG_M2 9
#define ECHO_M2 8
#define TRIG_R 7
#define ECHO_R 6

long durL, durM1, durM2, durR;
long disL[2], disM1, disM2,disMT[2], disR[2];

void setup() {
  Wire.begin(SLAVE); // Wire 라이브러리 초기화
  Wire.onRequest(sendToMaster);
   Serial.begin(9600);
   
  pinMode(TRIG_L, OUTPUT);
  pinMode(ECHO_L, INPUT);
  pinMode(TRIG_M1, OUTPUT);
  pinMode(ECHO_M1, INPUT);
  pinMode(TRIG_M2, OUTPUT);
  pinMode(ECHO_M2, INPUT);
  pinMode(TRIG_R, OUTPUT);
  pinMode(ECHO_R, INPUT);
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

  disM1>disM2 ? disMT[0]=disM2:disMT[0]=disM1;



  digitalWrite(TRIG_L, HIGH);
  delayMicroseconds(10); // Added this line
  digitalWrite(TRIG_L, LOW);
  durL = pulseIn(ECHO_L, HIGH);
  disL[0] = durL * (17.0/1000);


  
  
  digitalWrite(TRIG_R, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_R, LOW);
  durR  = pulseIn(ECHO_R, HIGH);
  disR[0] = durR * (17.0/1000);

  int Final = Status();
  switch(Final % 10){
  case 1: Serial.println("The Object is On your Front"); 
  break;
  case 2: Serial.println("The Object is On your Left");
  break;
  case 3: Serial.println("The Object is On your Right");
  break;
  case 4: Serial.println("The Object is moving Mid To Mid ");
  break;
  case 5: Serial.println("The Object is moving Left To Mid");
  break;
  case 7: Serial.println("The Object is moving Right To Mid");
  break;
  }
  
  //print();
  delay(1000);
}

void print(){
  Serial.print("Distance_Left = ");
  Serial.print(disL[0]);
  Serial.println("cm");
  Serial.print("Distance_Mid1 = ");
  Serial.print(disMT[0]);
  Serial.println("cm");

 
  Serial.print("Distance_Right = ");
  Serial.print(disR[0]);
  Serial.println("cm");

  disL[1]=disL[0];
  disMT[1]=disMT[0];
  disR[1]=disR[0];
}
int Status(){
  int flag=0;
  if(disMT[0]>200)               //flag는 2미터 밖에 물체가 있을 경우 10, 2미터 안으로 들어왔을 경우 0으로 값이 할당되며, 
  flag=10;                       //이는 처음의 2미터 거리확보 및 방향 정보를 알수 있는 변수입니다.
  
  if(disMT[0]<100&&disMT[0]>30) //중앙이 1미터 이내에 들어왔을 경우
    return flag+1;
  
  else if((disL[0]<100&&disL[0]>30)||(disR[0]<100&&disR[0]>30)) //중앙은 1미터 이내에 들어오지 않았으며, 왼쪽과 오른쪽중 한쪽이라도 1미터 이내에 들어왔을 경우
  if(disL[0]<=disR[0])                                          //왼쪽과 오른쪽의 길이를 비교하여 왼쪽이 짧으면 flag + 2; 오른쪽이 짧으면 3을 리턴해준다.
    return flag+2;
  else
    return flag+3;
  
  return flag+Moved();
  
}

int Moved(){
  bool lCheck=false,rCheck=false;
  if(disL[1]-disL[0]<10&&disR[1]-disR[0]<10) //왼쪽과 오른쪽의 움직임의 이전과의 움직임의 차이가 얼마 없는데 중앙이 더 가까워졌을 경우
    if(disMT[1]-disMT[0]>10)
    return 4; // 정면 접근중  
    
  if(disL[0]>disMT[0]&&disL[1]<disMT[1])     //왼쪽의 예전과 중앙의 예전, 왼쪽의 현재와 중앙의 현재를 비교했을때 예전은 왼쪽이, 현재는 중앙이 더 가까울 경우
   lCheck=true;                              //왼쪽에서 중앙으로 물체가 옴겨졌다고 가정
  if(disR[0]>disMT[0]&&disR[1]<disMT[1])     //위와 같은 방식 오른쪽
   rCheck=true;

  if(lCheck&&rCheck)                         //둘다 움직였을 경우
  return 7;
  else if(lCheck)
  return 5; // 왼쪽에서 정면으로 접근중      //왼쪽만 움직였을 경우
  else if(rCheck)
   return 6; // 오른쪽에서 정면으로 접근중   //오른쪽만 움직였을 경우
    
   }
void sendToMaster() {
  Wire.write(Status());
}

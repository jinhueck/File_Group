#include <Wire.h>
#include <SoftwareSerial.h>
#define SLAVE 4 // 슬레이브 주소

#define TRIG_M1 7
#define ECHO_M1 6
#define TRIG_M2 5
#define ECHO_M2 4

int blueTx=2;   //Tx (보내는핀 설정)at
int blueRx=3;   //Rx (받는핀 설정)
SoftwareSerial mySerial(blueTx, blueRx); 
  float Now;
  float Prev;
  
  long height = 160;
  long DistanceForCheck;
  long Check_i2c;

  int CountForStart;

  long duration_M1, duration_M2;
  long distance_cm_M1, distance_cm_M2;
  
void setup() {
  mySerial.begin(9600);
  Wire.begin(); // Wire 라이브러리 초기화
  Serial.begin(9600); // 직렬 통신 초기화
  Serial.println("I2C");
  Now = millis();
  Prev = Now;
  
  bool Check_Start = false;
  while(Check_Start != true){
    if (mySerial.available()) {
      Check_Start =true;
      height = (long)mySerial.parseInt();
      Serial.print("Height : ");  
      Serial.println(height);  //블루투스측 내용을 시리얼모니터에 출력
      Serial.println((200*200) + (height * height));
      DistanceForCheck = sqrt((200.0*200.0) + (height * height));
      Serial.print("DistanceForCheck : ");
      Serial.println(DistanceForCheck);
    }
  }
  CountForStart = 5;
}

void loop() {
  Serial.println("Wow");
    Now = millis();
    if(Now - Prev > 1000){                                                                        //1초에 한번씩
      Prev = Now;
    long ShortMidDistance = Check_Distance();                                                     //거리 측정 및 두개중 가까운 거리 출력
  
   
    i2c_communication();    //방향 기기 쪽에서 넘어온 값 확인
    if(CountForStart > 0){  //지속적으로 거리가 맞는지 잡아주기 위한 확인, 고정전
      if(Check_i2c >= 10){                                                                         //방향쪽의 정면방향의 거리가 2m보다 멀때
        if(DistanceForCheck - 10 < ShortMidDistance && DistanceForCheck + 10 > ShortMidDistance){ //설정 거리 10cm 내외에 있을때
          Serial.println("Stay There");                                                            //그대로 있게 하여 거리가 맞는지 확인
          CountForStart --;                                                                       //확인 횟수를 1회 줄인다.
        }
        else if(DistanceForCheck + 10 <= ShortMidDistance){                                       //만약 10cm보다 더 멀리 있으면
          CountForStart = 5;                                                                      //확인횟수를 5로 초기화
          Serial.println("Get Down Your Glass");                                                   //너무 멀리 바라보고 있으니 안경의 각도를 낮추어 거리 조절
        }
        else if(DistanceForCheck - 10 >= ShortMidDistance){                                       //만약 10cm보더 더 가까이 있으면
          CountForStart = 5;                                                                      //확인횟수를 5로 초기화
          Serial.println("Get Up Your Glass");                                                     //너무 가까이 바라보고 있으니 각도롤 높여 거리 조절
        }
      }
    }
    else{                                                                                         //확인횟수가 끝나고 안경이 고정된 후
      if(Check_i2c == 2)                                                                          //방향이 왼쪽일 경우
        Serial.println("The Object is on your Left");
      else if(Check_i2c == 3)                                                                     //방향이 오른쪽일 경우
        Serial.println("The Object is on your Right");
      else{                                                                                       //방향이 중앙일 경우
        if(ShortMidDistance <= DistanceForCheck/4*3){                                             //가로 길이 1.5m의 대각선의 위치보다 가까워 졌을 경우
          switch(Check_i2c % 10){
            case 1:
              Serial.println("The Object is on your Front");              //그저 정면일 경우
            break;
            case 4:
              Serial.println("The Object is moving Front");              //정면에서 접근중일 경우
            break;
            case 5:
              Serial.println("The Object is moving, Left to Mid");        //왼쪽에서 중앙으로 이동중일 경우
            break;
            case 6:
              Serial.println("The Object is moving, Right to Mid");       //오른쪽에서 중앙으로 이동중일 경우
            break;
            case 7:
              Serial.println("Plz Stop just a moment");                   //양쪽의 방향에서 둘다 왔다고 가정이 될 경우 잠시 기달려 달라 한다.
            break;
          }
        }
      }
    }
  }
}
void i2c_communication() {
  Wire.requestFrom(SLAVE, 4); // 1 바이트 크기의 데이터 요청
 Check_i2c = Wire.read(); // 수신 데이터 읽기
 Serial.println(Check_i2c); // 수신 데이터 출력
}

long Check_Distance(){
  digitalWrite(TRIG_M1, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_M1, LOW);
  duration_M1  = pulseIn(ECHO_M1, HIGH);
  distance_cm_M1 = duration_M1 * (17.0/1000);

  digitalWrite(TRIG_M2, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_M2, LOW);
  duration_M2  = pulseIn(ECHO_M2, HIGH);
  distance_cm_M2 = duration_M2 * (17.0/1000);

  long FinalDistance;
  (distance_cm_M1 > distance_cm_M2)?FinalDistance = distance_cm_M2 : FinalDistance = distance_cm_M1;
  return FinalDistance;
}


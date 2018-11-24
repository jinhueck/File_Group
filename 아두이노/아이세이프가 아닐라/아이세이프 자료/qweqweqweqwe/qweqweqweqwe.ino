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
  
void setup() {
  mySerial.begin(9600);
  Wire.begin(); // Wire 라이브러리 초기화
  Serial.begin(9600); // 직렬 통신 초기화
}

void loop() {
  Now = millis();
  i2c_communication();    //방향 기기 쪽에서 넘어온 값 확인
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
void i2c_communication() {
  Wire.requestFrom(SLAVE, 4); // 1 바이트 크기의 데이터 요청
 Check_i2c = Wire.read(); // 수신 데이터 읽기
 Serial.println(Check_i2c); // 수신 데이터 출력
}



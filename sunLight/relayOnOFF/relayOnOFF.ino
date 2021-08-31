#include <MsTimer2.h>

void flash() {
  static boolean output = HIGH;
  Serial.println(output);
  digitalWrite(10, output);
  output = !output;
}

void setup() {
  Serial.begin(9600);
  Serial.println("start");
  pinMode(8, OUTPUT);
  MsTimer2::set(28800000, flash); //6시간마다 인러터럽트
  MsTimer2::start();
}

void loop() {
  digitalWrite(8, HIGH);
}

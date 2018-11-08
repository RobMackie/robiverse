
#include <SoftwareSerial.h>

SoftwareSerial sw(2, 3); // RX, TX


bool lightOn = false;
int LONG = 2000;
int SHORT= 1000;
int VERY_SHORT = 250;

enum Speed { FAST, SLOW, LAST_STATE};
Speed speed_state = LAST_STATE;

void setup() {
  Serial.begin(115200);
  Serial.println("Interfacfing arduino with nodemcu");
//  sw.begin(115200);
  pinMode(LED_BUILTIN, OUTPUT);
  sw.begin(115200);
  sw.setTimeout(500);
}
 
void loop() {
  
  if (sw.available() > 0) {
    char bfr[101];
    memset(bfr,0, 101);
    sw.readBytesUntil( '\n',bfr,100);
    if(bfr[0] == 'F') {
      speed_state = FAST;
    } else if(bfr[0] == 'S') {
      speed_state = SLOW;
    } else {
      speed_state = LAST_STATE;
    }
  }

  switch (speed_state) {
    case SLOW:
      delay(LONG);
      break;
    case FAST:
      delay(SHORT);
      break;
    case LAST_STATE:
      delay(VERY_SHORT);
      break;
  }  

  if (lightOn) {
    lightOn = false;
  } else {
    lightOn = true;
  }
  
  if (lightOn) {
    digitalWrite(LED_BUILTIN, HIGH);
  } else {
    digitalWrite(LED_BUILTIN, LOW);
  }

}

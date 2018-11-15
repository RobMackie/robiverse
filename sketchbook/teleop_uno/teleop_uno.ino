
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
  pinMode(LED_BUILTIN, OUTPUT);
  sw.begin(115200);
  sw.setTimeout(500);
}


/* 
 *  getDriverStationInputNB
 *  returns an ascii character
 *  
 *  Each time this is called it gathers 1 ascii keystroke that was sent from the driver's station
 *  OR
 *  it return a char == '\0' which means there was no keystroke available from the driver's station
 *  The driver's station only sends when the keyboard provides a new keystroke
 *  There is no encoding for non-ascii keys
 */

char getDriverStationInputNB() {
  char bfr[10];
  memset(bfr,0, 101);
  if (sw.available() > 0) {
    sw.readBytesUntil( '\n',bfr,100);
  }
  return bfr[0];
}

 
void loop() {
    char input = getDriverStationInputNB();
    if(input == 'F') {
      speed_state = FAST;
    } else if(input == 'S') {
      speed_state = SLOW;
    } else if(input == 'H') {
      speed_state = LAST_STATE;
    } else {
      speed_state = LAST_STATE;
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

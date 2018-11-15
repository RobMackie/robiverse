
#include <time.h>
#include "ds_interface.h"

DS_Interface ds(2, 3);


bool lightOn = false;
int LONG_BLINK = 2000;
int SHORT_BLINK = 1000;
int VERY_SHORT_BLINK = 250;

enum Speed { SLOW, FAST, HYPER, SPEED_ARRAY_SIZE};
Speed speed_state = HYPER;

int speed[SPEED_ARRAY_SIZE] = {LONG_BLINK, SHORT_BLINK, VERY_SHORT_BLINK};

void service_blink(Speed state) {
  static bool lightOn = false;
  static long state_start_time = 0;
  long current_time = millis();

  if (current_time - state_start_time > speed[state]) {
    //toggle LED - built in LED is on an inverted signal
    if (lightOn) {
      digitalWrite(LED_BUILTIN, HIGH);
      lightOn = false;
      state_start_time = millis();
    } else {
      digitalWrite(LED_BUILTIN, LOW);
      lightOn = true;
      state_start_time = millis();
    }
  }
}

void setup() {
  Serial.begin(115200);
  Serial.println("Interfacfing arduino with nodemcu");
  pinMode(LED_BUILTIN, OUTPUT);
  ds.init();
}

void loop() {
    char input = ds.readInputIfAvailable();
    switch (input) {
      case 'f':
        speed_state = FAST;
        break;
      case 's':
        speed_state = SLOW;
        break;
      case 'h':
        speed_state = HYPER;
        break;
      default:
        // no change to speed state if no keystroke
        break;
    }

    service_blink(speed_state);

}

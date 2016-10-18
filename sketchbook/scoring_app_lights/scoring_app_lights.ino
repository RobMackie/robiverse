#include <Adafruit_NeoPixel.h>

const int LAST_PIN = 4;

const int INPUT_PIN[LAST_PIN] = {1, 2, 3, 4}; // D1, D2, D3, D4

const int CONTROL_PIN = 6;
const int NUM_LEDS = 40;

const int LED_POS[LAST_PIN] = {4, 14, 24, 34};

const int ALERT_PIN = 7;


Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LEDS, CONTROL_PIN, NEO_GRB + NEO_KHZ800);

uint32_t on;
uint32_t off;
uint32_t alert;
uint32_t red;

enum  redflag_t {
  PRE,
  TRANS,
  POST
};

int captured_state[] = {0, 0, 0, 0};

redflag_t redflag = PRE;

void setup() {

  for (int ii = 0; ii < LAST_PIN; ii++) {
    pinMode(INPUT_PIN[ii], INPUT_PULLUP);
  }
  pinMode(ALERT_PIN, INPUT_PULLUP);
  strip.begin();

  on = strip.Color(0, 255, 0);
  alert = strip.Color(0, 0, 100);
  off = strip.Color(0, 0, 0);
  red = strip.Color(255, 0, 0);
}

void loop() {
  // put your main code here, to run repeatedly:

  for (int ii = 0; ii < LAST_PIN; ii++) {
    if (digitalRead(INPUT_PIN[ii])) {
      if (redflag == TRANS) {
        captured_state[ii] = 1;
      }
      if (redflag == PRE || redflag == TRANS) {
        strip.setPixelColor(LED_POS[ii], on);
      }
      if (redflag == POST) {
        if (!captured_state[ii]) {
          strip.setPixelColor(LED_POS[ii], red);
        } else {
          strip.setPixelColor(LED_POS[ii], on);
        }
      }
    } else {
      if (redflag == TRANS) {
        captured_state[ii] = 0;
      }
      if (redflag == POST) {
        captured_state[ii] = 0;
      }
      strip.setPixelColor(LED_POS[ii], off);
    }
  }


for (int jj = 0; jj < NUM_LEDS; jj++) {
  if (jj == 4 || jj == 14  || jj == 24 || jj == 34) {
    continue;
  }
  if (digitalRead(ALERT_PIN) == LOW) {
    strip.setPixelColor(jj, alert);
    redflag = TRANS;
  } else {
    strip.setPixelColor(jj, off);
    if (redflag == TRANS) {
      redflag = POST;
    }
  }
}
strip.show();
delay(25);
}

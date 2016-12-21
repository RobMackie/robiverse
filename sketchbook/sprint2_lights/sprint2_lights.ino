#include <Adafruit_NeoPixel.h>

const int LAST_PIN = 4;
const int CONTROL_PIN = 6;
const int NUM_LEDS = 40;

Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LEDS, CONTROL_PIN, NEO_GRB + NEO_KHZ800);

uint32_t off;
uint32_t ready_color;
uint32_t team_red_color;
uint32_t team_blue_color;
uint32_t team_coop_color;

int active = 0;
int team_one = 0;
int team_two = 0;
int team_coop = 0;

void init_vars() {
  active = 0;
  team_one = 0;
  team_two = 0;
  team_coop = 0;
}

const int start_pin = 3;
const int team_one_pin = 4;
const int team_two_pin = 5;

void setup() {
  // put your setup code here, to run once:
  strip.begin();
  off = strip.Color(0, 0, 0);
  ready_color = strip.Color(255, 255, 255);
  team_red_color = strip.Color(255, 0, 0);
  team_blue_color = strip.Color(0, 0, 255);
  team_coop_color = strip.Color(0, 255, 0);

  pinMode(start_pin, INPUT_PULLUP);
  pinMode(team_one_pin, INPUT_PULLUP);
  pinMode(team_two_pin, INPUT_PULLUP);
  init_vars();

  for (int ii = 0; ii < 40; ii++) {
    strip.setPixelColor(ii, off);
  }
}

void loop() {

  int start_pin_in = digitalRead(start_pin);
  int team_one_in = digitalRead(team_one_pin);
  int team_two_in = digitalRead(team_two_pin);

  if (HIGH == team_one_in) {
    team_one = 1;
  }
  if (HIGH == team_two_in) {
    team_two = 1;
  }

  if (team_one_in && team_two_in) {
    team_coop = 1;
  }

  if (LOW == start_pin_in) {
    // put your main code here, to run repeatedly:
    for (int ii = 0; ii < 40; ii++) {
      strip.setPixelColor(ii, ready_color);
    }
  } else {
    init_vars();
    for (int ii = 0; ii < 40; ii++) {
      strip.setPixelColor(ii, off);
    }
  }

  if (team_one) {
    for (int ii = 0; ii < 15; ii++) {
      strip.setPixelColor(ii, team_blue_color);
    }
  }
  if (team_two) {
    for (int ii = 25; ii < 40; ii++) {
      strip.setPixelColor(ii, team_red_color);
    }
  }
  if (team_coop) {
    for (int ii = 15; ii < 25; ii++) {
      strip.setPixelColor(ii, team_coop_color);
    }
  }
  

  strip.show();
  delay(25);
}





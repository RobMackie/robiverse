/* 
 *  2019 Training Season code for Arduino NANO v3 neopixel control
 *  
 *  Pin 11 NeoPixel signal out
 *  Pin  4 DIO from RoboRIO
 *    HIGH means BLUE
 *    LOW  means RED
 *    
 *    VIN 12 V from VRM 12V2A terminal
 *    GND from from VRM and from RoboRIO DIO
 */

#include <Arduino.h>
#include <Adafruit_NeoPixel.h>

#define LED_COUNT 20
#define NEOPIXEL_CONTROL_PIN 11
#define ROBORIO_COLOR_CONTROL_PIN 4


Adafruit_NeoPixel strip = Adafruit_NeoPixel(LED_COUNT, NEOPIXEL_CONTROL_PIN, NEO_GRB + NEO_KHZ800);
                              /* strip.Color(RED, GREEN, BLUE) */
const uint32_t BLUE = strip.Color(0, 0, 255);
const uint32_t GREEN = strip.Color(0, 255, 0);
const uint32_t RED = strip.Color(255, 0, 0);
const uint32_t OFF = strip.Color(0, 0, 0);

void setup() {
  // put your setup code here, to run once:
  pinMode(ROBORIO_COLOR_CONTROL_PIN, INPUT_PULLUP);
  strip.begin();
  for (int ii = 0; ii < LED_COUNT; ii++) {
      strip.setPixelColor(ii, GREEN);
  }
  strip.show();
}

void loop() {
  // put your main code here, to run repeatedly:
  bool blueRequested = false;
  int pinState = digitalRead(ROBORIO_COLOR_CONTROL_PIN);
  if (pinState == HIGH) {
    blueRequested = true;
  }

  for (int ii = 0; ii < LED_COUNT; ii++) {
    if (blueRequested) {
      strip.setPixelColor(ii, BLUE);
    } else {
      strip.setPixelColor(ii, RED);
    }
  }
  
  strip.show();
  delay(25);

}

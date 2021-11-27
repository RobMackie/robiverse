#include <Adafruit_NeoPixel.h>
//#include <rp2040_pio.h>

/*
loading lights choatic candy craze
*/

int LEDPIN = 13;
int INPUT_PIN_1 = 2;
int INPUT_PIN_2 = 3;
#define PIXEL_COUNT 6
#define PIXEL_PIN 6
Adafruit_NeoPixel strip(PIXEL_COUNT, PIXEL_PIN, NEO_GRB + NEO_KHZ800);
//Adafruit_NeoPixel strip(PIXEL_COUNT, PIXEL_PIN, NEO_GRB + NEO_KHZ800);
// Argument 1 = Number of pixels in NeoPixel strip
// Argument 2 = Arduino pin number (most are valid)
// Argument 3 = Pixel type flags, add together as needed:
//   NEO_KHZ800  800 KHz bitstream (most NeoPixel products w/WS2812 LEDs)

void r_colorSet(uint32_t color);
void r_colorWipe(uint32_t color, int wait);

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(LEDPIN, OUTPUT);  
  pinMode(INPUT_PIN_1, INPUT_PULLUP);
  pinMode(INPUT_PIN_2, INPUT_PULLUP);
  strip.begin(); // Initialize NeoPixel strip object (REQUIRED)
  strip.clear();
  r_colorSet(strip.Color(255,   0,   0));    // Red
  strip.show();  // Initialize all pixels to 'off'
}

// the loop function runs over and over again forever
void loop() {

  int switch1 = digitalRead(INPUT_PIN_1);
  int switch2 = digitalRead(INPUT_PIN_2);
  
  if (switch1 == LOW) {
    digitalWrite(LEDPIN, HIGH);   // turn the LED on (HIGH is the voltage level)
    r_colorSet(strip.Color(  0, 255,   0));    // Green
    delay(5000);
     r_colorWipe(strip.Color(255,   0,   0), 300);    // Red
  } else if (switch2 == LOW) {
    digitalWrite(LEDPIN, HIGH);   // turn the LED on (HIGH is the voltage level)
    r_colorSet(strip.Color(  0, 255,   0));    // Green
    delay(10000);
    r_colorWipe(strip.Color(255,   0,   0), 300);    // Red
  } else {
     digitalWrite(LEDPIN, LOW);    // turn the LED off by making the voltage LOW
  }          
}

// Fill strip pixels one after another with a color. Strip is NOT cleared
// first; anything there will be covered pixel by pixel. Pass in color
// (as a single 'packed' 32-bit value, which you can get by calling
// strip.Color(red, green, blue) as shown in the loop() function above),
// and a delay time (in milliseconds) between pixels.
void r_colorWipe(uint32_t color, int wait) {
  for(int i=0; i<strip.numPixels(); i++) { // For each pixel in strip...
    strip.setPixelColor(i, color);         //  Set pixel's color (in RAM)
    strip.show();                          //  Update strip to match
    delay(wait);                           //  Pause for a moment
  }
}
// Fill strip pixels one after another with a color. Strip is NOT cleared
// first; anything there will be covered pixel by pixel. Pass in color
// (as a single 'packed' 32-bit value, which you can get by calling
// strip.Color(red, green, blue) as shown in the loop() function above),
// and a delay time (in milliseconds) between pixels.
void r_colorSet(uint32_t color) {
  for(int i=0; i<strip.numPixels(); i++) { // For each pixel in strip...
    strip.setPixelColor(i, color);         //  Set pixel's color (in RAM)
    strip.show();                          //  Update 
  }
}

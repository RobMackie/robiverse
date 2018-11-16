
#include <time.h>
#include <Servo.h>
#include "ds_interface.h"

DS_Interface ds(2, 3);


/*
 * Code to suppport lights blinking in the background
 */
int LONG_BLINK = 2000;
int SHORT_BLINK = 1000;
int VERY_SHORT_BLINK = 250;

enum Speed { SLOW, FAST, HYPER, SPEED_ARRAY_SIZE};
Speed speed_state = HYPER;

int speed[SPEED_ARRAY_SIZE] = {LONG_BLINK, SHORT_BLINK, VERY_SHORT_BLINK};
void init_blink() {
  pinMode(LED_BUILTIN, OUTPUT);
}

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

/* 
 * code to support driving with motors
 */

const int LEFT_MOTOR = 5;
const int RIGHT_MOTOR = 6;

Servo left_motor;
Servo right_motor;

void init_motors(int left, int right) {
  left_motor.attach(left);
  right_motor.attach(right);
}

#define  FORWARD 1
#define  REVERSE 2
#define  LEFT    3
#define  RIGHT   4
#define  BACK    5
#define  STOP    6

int current_direction = FORWARD;

void drivetrain(int dir) {
  switch(dir) {
    case FORWARD:
      left_motor.write(180);
      right_motor.write(0);
      break;
    case REVERSE:
      left_motor.write(0);
      right_motor.write(180);
      break;
    case LEFT:
      left_motor.write(90);
      right_motor.write(180);
      break;
    case RIGHT:
      left_motor.write(180);
      right_motor.write(90);
      break;
    case STOP:
      left_motor.write(90);
      right_motor.write(90);
      break;
  }
}

/* 
 * Setup where we initialize subsytems
 */

void setup() {
  Serial.begin(115200);
  Serial.println("Interfacfing arduino with nodemcu");
  ds.init();
  init_blink();
  init_motors(LEFT_MOTOR, RIGHT_MOTOR);
}

/* 
 * loop - where we get input and invoke our programs subsystems
 */
void loop() {
    char input = ds.readInputIfAvailable();
    switch (input) {
      case 'f':
        speed_state = FAST;
        break;
      case 'g':
        speed_state = SLOW;
        break;
      case 'h':
        speed_state = HYPER;
        break;
      case 'w':
        current_direction = FORWARD;
        break;
      case 'a':
        current_direction = LEFT;
        break;
      case 'd':
        current_direction = RIGHT;
        break;
      case 's':
        current_direction = STOP;
        break;
      case 'x':
        current_direction = REVERSE;
        break;
      default:
        // no change to speed state if no keystroke
        break;
    }

    service_blink(speed_state);
    drivetrain(current_direction);
}

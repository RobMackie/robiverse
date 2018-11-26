#include <time.h>
#include <Servo.h>
#include "ds_interface.h"
#include "Blinker.h"

#define RX_FROM_NMCU 2
#define TX_TO_NMCU 3

// ---------------------------------------------------------------------------
/* 
 * Create a Drive Station Interface "DS_Interface" object
 */
DS_Interface ds(RX_FROM_NMCU, TX_TO_NMCU);

// ---------------------------------------------------------------------------
/* Declarations to support having a remote control flashy flashyLight
 *
 * Create (instantiate) a Blinker object to blink the built in LED on pin 13
 * and a variable that let's tell the Blinker service routine how fast 
 * we want it to blink the LED.
 */
Blinker flashyLight(LED_BUILTIN);
Blinker::Speed_t speed_state = Blinker::HYPER;


// ---------------------------------------------------------------------------
/*
 * Section containing code to support driving with motors
 */

/*
 * servos on digital pins 5 & 6
 */
const int LEFT_MOTOR = 5;
const int RIGHT_MOTOR = 6;

/*
 * Instantiate objects to control the two motors
 */
Servo left_motor;
Servo right_motor;

/*
 * Call from “init()” to connect the servo objects to their 
 * pins
 */
void init_drivetrain(int left_motor_pin, int right_motor_pin) {
  left_motor.attach(left_motor_pin);
  right_motor.attach(right_motor_pin);
}

/*
 * Define some words so we don’t have to remember arbitrary numbers
 */
#define  FORWARD 1
#define  REVERSE 2
#define  LEFT    3
#define  RIGHT   4
#define  BACK    5
#define  STOP    6

/*
 * Let’s start with the wheels still so it doesn’t run away
 */
int current_direction = STOP;

/*
 * Call this function from “loop()” with a direction. A good plan is 
 * to remember a direction and use it over and over, unless you get 
 * a new keystroke. The directions are the words defined above, 
 * including the ‘STOP’ direction. Everytime you call this, the 
 * code will set the motors to go in the direction needed to
 * implement that direction and leave them running that way
 */
void service_drivetrain(int dir) {
  switch(dir) {
    case FORWARD:
      left_motor.write(0); // forward
      right_motor.write(180); // forward
      break;
    case REVERSE:
      left_motor.write(180); // backward
      right_motor.write(0);  // backward
      break;
    case LEFT:
      left_motor.write(180);  //backward
      right_motor.write(180); //forward
      break;
    case RIGHT:
      left_motor.write(0);  // forward
      right_motor.write(0); // backward
      break;
    case STOP:
      left_motor.write(90);  // stop
      right_motor.write(90); // stop
      break;
  }
}

/* 
 * Arduino Setup where we initialize subsystems
 */
void setup() {
  Serial.begin(115200);
  Serial.println("Interfacing arduino with nodemcu");
  ds.init();     // setup drive station comms 
  flashyLight.init(); // setup the LED blinker

  init_drivetrain(LEFT_MOTOR, RIGHT_MOTOR); // setup the drivetrain
}

/* 
 * Arduino loop - where we get input and invoke our program’s
 * subsystems
 */
void loop() {

    char input = ds.readInputIfAvailable();
    // decide if this input should trigger a change our recorded
    // state:
    switch (input) {
      case 'f':
        speed_state = Blinker::FAST;
        break;
      case 'g':
        speed_state = Blinker::SLOW;
        break;
      case 'h':
        speed_state = Blinker::HYPER;
        break;
      case 'H': // NOTE: capital ‘H’ is different from lower ‘h’
        speed_state = Blinker::SUPERHYPER;
        break;
      case 'w':
        current_direction = FORWARD;
        break;
      case 'a':
        current_direction = RIGHT;
        break;
      case 'd':
        current_direction = LEFT;
        break;
      case 's':
        current_direction = STOP;
        break;
      case 'x':
        current_direction = REVERSE;
        break;
      default:
        /*
         * no reason to make changes to any state if there was
         * no keystroke or the keystroke was a letter we don’t
         * recognize in the list above
         */
        break;
    }

    flashyLight.service(speed_state);
    service_drivetrain(current_direction);
}


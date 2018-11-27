#include "ServoDriveTrain.h"


/*
 * Name the servo speeds for full speed forward and REVERSE
 * Remember that the Left servo is reversed because it mounted
 * mirror image to the right servo, so needs to spin in the opposite 
 * direction for the same effect. It might be smarter to wrap the 
 * servos in a "motor" class that has an "invert()" function, 
 * but this will do for now. Just allways use a constant ending
 * in "_R" for the right servo and one ending in "_L" for the left
 * servo.
 */ 
// right servo:
#define SERVO_FWD_R 180
#define SERVO_REV_R 0
// left servo:
#define SERVO_FWD_L 0 
#define SERVO_REV_L 180
// they  both "stop" in the same direction. :-)
#define SERVO_STOP 90


/*
 * Constructor to create a new drivetrain object
 * leftPin - the index of the DIO pin delivering PWM signal to the left servo
 * rightPin - the index of the DIO pin delivering PWM signal to the right servo
 */
ServoDriveTrain::ServoDriveTrain(int leftPin, int rightPin) {
    left_motor_pin = leftPin;
    right_motor_pin = rightPin;
}

/*
 * A destructor so the compiler has instructions for how to clean up
 * when a ServoDriveTrain object is destroyed. Program should never
 * invoke in directly.
 */
ServoDriveTrain::~ServoDriveTrain() {
    left_motor_pin = 0;
    right_motor_pin = 0;
    current_direction = STOP;
}

/*
 * init()
 * This function should be called from the arduino "setup()" function
 */
void ServoDriveTrain::init() {
    left_motor.attach(left_motor_pin);
    right_motor.attach(right_motor_pin);
    current_direction = STOP;
    service(current_direction);
}

/*
 * service()
 * Call this function to change the state of the servos. Pass in a Direction
 * wayToGo - is the direction you'd like the robot to go, inlcuding "ServoDriveTrain::STOP"
 */
void ServoDriveTrain::service(ServoDriveTrain::Direction wayToGo) {
    switch(wayToGo) {
        case FORWARD:
            left_motor.write(SERVO_FWD_L);
            right_motor.write(SERVO_FWD_R);
            break;
        case REVERSE:
            left_motor.write(SERVO_REV_L);
            right_motor.write(SERVO_REV_R);
            break;
        case LEFT:
            left_motor.write(SERVO_REV_L);
            right_motor.write(SERVO_FWD_R);
            break;
        case RIGHT:
            left_motor.write(SERVO_FWD_L);
            right_motor.write(SERVO_REV_R);
            break;
        case STOP:
            left_motor.write(SERVO_STOP);
            right_motor.write(SERVO_STOP);
            break;
    }
}

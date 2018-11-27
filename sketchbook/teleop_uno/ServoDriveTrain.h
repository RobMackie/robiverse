#ifndef SERVO_DRIVE_TRAIN_H_INCLUDED
#define SERVO_DRIVE_TRAIN_H_INCLUDED

#include <Servo.h>


class ServoDriveTrain {
    public:
        /*
        * Define some words for directions, so we don’t have to remember arbitrary 
        * numbers
        */
        enum Direction {STOP, FORWARD, REVERSE, RIGHT, LEFT, END_OF_DIRECTIONS};

        /*
         * A function to create a new ServoDriveTrain object. Needs to know 
         * which pins the yellow signal wires of the 2 servos are plugged into.
         * This class assumes 2 continuous rotation servos, one on the left
         * and one on the right side of the robot. 
         */
        ServoDriveTrain(int leftPin, int rightPin);

        /*
         * A clean up function for when the object is destroyed
         */
        virtual ~ServoDriveTrain();

        /* 
         * Call this function from the arduino "setup()" function.
         * This will attach the software to the pins that were
         * specified in the constructor and configure them appropriately
         */
        void init();

        /*
         * Call this anytime your wants to change the state of the 
         * motors. Once you call it, the motors (servos) will keep 
         * moving (or not moving) in the way you specified until you
         * call it again. Calling it again with the same direction will
         * do no harm, but no need to do so until you want something 
         * to change.
         */
        void service(ServoDriveTrain::Direction goThisWay);

        /*
         * This method/function allows you to find out which way the drivetrain 
         * thinks it is currently going. (how was it last set)
         */
        Direction getCurrentDirection();

    private:
        Direction current_direction;
        int right_motor_pin;
        int left_motor_pin;

        Servo left_motor;
        Servo right_motor;

};


#endif // SERVO_DRIVE_TRAIN_H_INCLUDED
#include <FRC_Arduino.h>
#include <Arduino.h>

ContinuousServoMotorDriver motor(9);


void setup ()
{
    motor.attach();
}

void loop() 
{
    motor.set(0.1);
    delay(3000);
    motor.set(0.0);
    delay(500);
    motor.set(-1.0);
    delay(500);
    motor.set(0.0);
    delay(500);
}

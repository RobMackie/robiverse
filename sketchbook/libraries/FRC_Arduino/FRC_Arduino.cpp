// ArdiunoFRC
// 
// Libary by Rob Mackie, for Geode Insights
//  This library provides some abstractions for some accessories
//  that work with Arduinos. The abstractions are chosen to 
//  resemble but not duplicate the JAVA classes used in the FRC WPI 
//  libraries used by FRC teams.

/*
 * Usage Notes:
 */


#include "FRC_Arduino.h"
#include <Arduino.h>

#define MAX_READ   1023
#define MAX_VOLTS  5.0

// ContinousServoMotor

ContinuousServoMotorDriver::ContinuousServoMotorDriver(int channel) 
{
    this->channel = channel;
    rawSpeed = 0;
    speed = 0;
    inverted = false;
}

void ContinuousServoMotorDriver::attach()
{
    motor.attach(channel);
    motor.write(0);
}

void ContinuousServoMotorDriver::set(float speed)
{
#define MAX_RAW_SPEED 90
    this->speed = speed;
    rawSpeed = MAX_RAW_SPEED * speed;

    if (inverted) {
        rawSpeed *= -1;
    }
    motor.write(rawSpeed + MAX_RAW_SPEED);
}


int ContinuousServoMotorDriver::getRawSpeed() 
{
    return (rawSpeed);
}

boolean ContinuousServoMotorDriver::getInverted() 
{
    return (inverted);
}

void ContinuousServoMotorDriver::setInverted(boolean isInverted)
{
    inverted = isInverted;
}

// FRC_Servo

FRC_Servo::FRC_Servo(int channel)
{
    this->channel = channel;
    angle = 0;
    angleDegrees = 0;
    rawAngle = 0;
}

void FRC_Servo::set(double angle)
{
    this->angle = angle;
    angleDegrees = (angle * 180);
    rawAngle = int(angleDegrees);
    servo.write(rawAngle);
}

void FRC_Servo::attach()
{
    servo.attach(channel);
    servo.write(0);
}

double FRC_Servo::get()
{
    return (angle);
}

void FRC_Servo::setAngle(double degrees)
{
    angleDegrees = degrees;
    rawAngle = int(angleDegrees);
    angle = degrees/180.0;
    servo.write(rawAngle);
}

double FRC_Servo::getAngle()
{
    return (angleDegrees);
}

double FRC_Servo::getRawAngle()
{
    return (rawAngle);
}

// FRC_AnalogInput

FRC_AnalogInput::FRC_AnalogInput(int channel)
{
    this->channel = channel;
}

int FRC_AnalogInput::getValue()
{
    return (analogRead(channel));
}

double FRC_AnalogInput::getVoltage()
{
    return (MAX_VOLTS * analogRead(channel)/MAX_READ);
}

// FRC_DigitalInput
/*
FRC_DigitalInput::FRC_DigitalInput(int channel)
{
    this->channel = channel;
    pinMode(channel, INPUT);
    ai = NULL;
    threshold = 0;
}

FRC_DigitalInput::FRC_DigitalInput(AnalogInput *ai, int threshold)
{
    this->ai = ai;
    this->threshold = threshold;
}
*/

boolean FRC_DigitalInput::get()
{
    int value;
    if (ai) {
        value = ai->getValue();
        return (value > threshold);
    } else {
        return (digitalRead(channel));
    }
}

void FRC_DigitalInput::setThreshold(int threshold)
{
    this->threshold = threshold;
}

DigitalOutput::DigitalOutput(int channel)
{
    this->channel = channel;
    pinMode(channel, OUTPUT);
}

void DigitalOutput::set(boolean isHigh)
{
    digitalWrite(channel, (isHigh ? HIGH : LOW));
}

// FRC_Ultrasonic

FRC_Ultrasonic::FRC_Ultrasonic(int triggerPin, int echoPin, int maxDistance)
{
    currentUnits = kInches;
    this->maxDistance = maxDistance;
    trigger = triggerPin;
    echo = echoPin;
    uS = 0;
    isValid = false;
    sonar = new NewPing(triggerPin, echoPin, 400);
    pinMode(trigger, OUTPUT);
}

FRC_Ultrasonic::~FRC_Ultrasonic()
{
    if (sonar) {
        delete sonar;
    }
    sonar = NULL;
}

boolean FRC_Ultrasonic::isOk()
{
    return (sonar);
}

void FRC_Ultrasonic::ping()
{
    isValid = false;
    if (sonar) {
        uS = sonar->ping();
        isValid = true;
    }
}

boolean FRC_Ultrasonic::isRangeValid()
{
    return (isValid && sonar);
}

int FRC_Ultrasonic::getRangeInches()
{
    return (uS/US_ROUNDTRIP_IN);
}

int FRC_Ultrasonic::getRangeMM()
{
    return (uS/US_ROUNDTRIP_CM);
}

void FRC_Ultrasonic::setDistanceUnits(FRC_Ultrasonic::Unit units)
{
    currentUnits = units;
}


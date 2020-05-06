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


#ifndef _FRC_ARDUINO_
#define _FRC_ARDUINO_

#include <Arduino.h>
#include <Servo.h>
#include <NewPing.h>

class FRC_PWMSpeedConroller {
    /* sets the speed of the attached motor
     * Parameters:
     *  speed: range from -1.0 to +1.0
     *          Meaning -1.0 means full reverse, 1.0 full forward, 0 means stop
     */
    public:
        virtual ~FRC_PWMSpeedConroller() {}
        virtual void set(float speed);
        virtual bool getInverted();
        virtual void setInverted(bool isInverted);
    protected:
        FRC_PWMSpeedConroller() {;}
};

class ContinuousServoMotorDriver: public FRC_PWMSpeedConroller {
    public:
        ContinuousServoMotorDriver(int channel);
        virtual ~ContinuousServoMotorDriver() {;}
        virtual void attach();

        virtual void set(float speed);
        virtual void setInverted(bool isInverted);
        virtual bool getInverted();

        virtual int getRawSpeed();

    private:
        Servo motor;
        int rawSpeed = 0;
        float speed = 0;
        bool inverted = false;
        int channel;
};

class FRC_Servo {
    public:
        FRC_Servo(int channel);
        virtual ~FRC_Servo() {;}

        virtual void attach();

        virtual void set(double angle);
        virtual double get();

        virtual void setAngle(double degrees);
        virtual double getAngle();
        
        /* Arduino only */
        virtual double getRawAngle();

    private:
        Servo servo; 
        double angle;
        double angleDegrees;
        int rawAngle;
        int channel;
};


class FRC_AnalogInput {
    public:
        FRC_AnalogInput(int channel);
        virtual ~FRC_AnalogInput();

        virtual int getValue();
        virtual double getVoltage();

        /* not supported 
            int getAverageValue();
            double getAverageVolts();
            void setAccumulatorInitialValue(0);
            void setAccumulatorCenter(2048);
            void setAccumulatorDeadband(10);
            void resetAccumulator();
        */

    private:
        int channel;
};

class FRC_DigitalInput {
    public:
        FRC_DigitalInput(int channel);
        FRC_DigitalInput(FRC_AnalogInput ai, int threshold);
        virtual ~FRC_DigitalInput() {;}

        virtual bool get();
        virtual void setThreshold(int threshold);

    private:
        int channel;
        FRC_AnalogInput *ai;
        int threshold;
};

class DigitalOutput {
    public:
        DigitalOutput(int channel);
        virtual ~DigitalOutput();

        virtual void set(bool isHigh);
        /* not supported 
            void enablePWM();
            void disablePWM();
            void setPWMRate(double rate); // actual value will be (rate * 1023) 
            int getPWMInt();
            double getPWMdouble();
        */

    private:
        int channel;
};


class FRC_Ultrasonic {
    public:
        typedef enum {
            kInches,
            kMillimeters
        } Unit;

        FRC_Ultrasonic(int triggerPin, int echoPin, int maxDistance = 200);
        virtual ~FRC_Ultrasonic();

        virtual bool isOk();

        /* not supported at this time
            virtual void setAutomaticMode(bool enabling);
        */
        virtual void ping();
        virtual bool isRangeValid();

        virtual int getRangeInches();
        virtual int getRangeMM();

        virtual void setDistanceUnits(FRC_Ultrasonic::Unit units);

    private:
        Unit currentUnits = kInches;
        int maxDistance;
        int trigger;
        int echo;
        int uS;
        bool isValid;
        NewPing *sonar;
};


#endif

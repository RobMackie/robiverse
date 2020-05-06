#include <Servo.h>

int LED=13;        //define LED port
int SENSOR_PIN=A0;  //define switch port
int BUZZER_PIN=4;
int  val;          //define digital variable val

Servo right;
Servo left;

int lastReading = 0;

int REFRESH_COUNT = 1000;
int DIFF=40;
boolean detectTransition(int newReading)
{
    static int count = 0;
    count++; 
    count = count % REFRESH_COUNT;

    boolean result = false; 

    int diff = abs(newReading-lastReading);
    if(diff > DIFF) {
        result = true;
        lastReading = newReading;
    }
    if (!count) {
        lastReading = newReading;
    }

    return result;
}

void pause()
{
    right.write(90);
    left.write(90);
    delay(2000);
    right.write(180);
    left.write(0);
}

void buzz(int time) 
{
    digitalWrite(BUZZER_PIN, HIGH);
    delay(time);
    digitalWrite(BUZZER_PIN, LOW);
}

void  setup() 
{
    pinMode(LED,OUTPUT);      //define LED as a output port
    digitalWrite(LED,LOW);
    pinMode(BUZZER_PIN, OUTPUT);
    digitalWrite(BUZZER_PIN, LOW);
    Serial.begin(115200);
    right.attach(9);
    left.attach(5);
    right.write(180);
    left.write(0);
    lastReading = 0;
    buzz(500);
}
void  loop()
{ 
    val=analogRead(SENSOR_PIN);  //read the value of the digital interface 3 assigned to val 
    if(detectTransition(val)) {              //when the switch sensor have signal, LED blink 
        digitalWrite(LED,LOW);
//        pause();
        buzz(25);
    } else {
        digitalWrite(LED,HIGH);
        right.write(180);
        left.write(0);
//        buzz(10);
    }
}

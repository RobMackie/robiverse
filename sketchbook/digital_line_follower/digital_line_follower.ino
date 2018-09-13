int LED=13;//define LED port
int sensorPin=7; //define switch port
int  val;        //define digital variable val
int BUZZER_PIN=4;

void buzz(int time)
{
    digitalWrite(BUZZER_PIN, HIGH);
    delay(time);
    digitalWrite(BUZZER_PIN, LOW);
}

void  setup() 
{
    pinMode(LED,OUTPUT);      //define LED as a output port
    pinMode(sensorPin,INPUT); //define switch as a input port
    pinMode(BUZZER_PIN, OUTPUT);
    digitalWrite(BUZZER_PIN, LOW);
    buzz(500);

}
void  loop()
{ 
    val=digitalRead(sensorPin);  //read the value of the digital interface 3 assigned to val 
    if(val==HIGH) {              //when the switch sensor have signal, LED blink 
        digitalWrite(LED,HIGH);
    } else {
        digitalWrite(LED,LOW);
        buzz(10);
    }
}
digitalWrite
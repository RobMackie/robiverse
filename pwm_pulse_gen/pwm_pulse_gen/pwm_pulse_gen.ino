#define OUTPUT_PIN 6

void setup() {
  
  pinMode(OUTPUT_PIN, OUTPUT);
}

void loop() {
  
  digitalWrite(OUTPUT_PIN, HIGH);   
  delayMicroseconds(2400); 
  digitalWrite(OUTPUT_PIN, LOW);   
  delayMicroseconds(17600);
}

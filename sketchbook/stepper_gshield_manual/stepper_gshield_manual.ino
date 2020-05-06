

#define X_STEP_PIN 2
#define X_DIR_PIN 5
#define ENABLE_PIN 8


void setup() {
  // put your setup code here, to run once:
  pinMode(X_STEP_PIN, OUTPUT);
  pinMode(X_DIR_PIN, OUTPUT);
  pinMode(ENABLE_PIN, OUTPUT);

  digitalWrite(ENABLE_PIN, HIGH);
  digitalWrite(X_STEP_PIN, LOW);
  digitalWrite(X_DIR_PIN, LOW);

}

void loop() {
  // put your main code here, to run repeatedly:

  digitalWrite(X_STEP_PIN, HIGH);
  delay(10);
  digitalWrite(X_STEP_PIN, LOW);
  delay(250);
  
}

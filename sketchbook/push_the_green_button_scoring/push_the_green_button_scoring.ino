#include <ESP8266WiFi.h>

//////////////////////
// WiFi Definitions //
//////////////////////
// const char WiFiAPPSK[] = "PT_FIELD1";

/////////////////////
// Pin Definitions //
/////////////////////

const int LAST_BUTTON = 4;

const int LED_PIN[LAST_BUTTON] = {5, 4, 0, 2};    // D1, D2, D3, D4 (ignore D0)

const int SCORE_PIN[LAST_BUTTON] = {14, 12, 13, 3}; // D5, D6, D7, D9
const int LEVEL_UP_PIN = 1;                         // D10
const int ALERT_PIN = 16;                           // D0

bool button_state[LAST_BUTTON] = {false, false , false, false};

const int LAST_LEVEL = 3;
int level = LAST_LEVEL - 1;
int level_value[LAST_LEVEL] = {1, 10, 100};

const unsigned long int RESET_DEBOUNCE = 5000;

unsigned long int last_level_reset = 0;

int captured_score = 0;
int endgame = 0;

int score = 0;

WiFiServer server(80);

uint32_t start_time = 0;

void setup()
{
  initHardware();
  setupWiFi();
  server.begin();
}

void print_state()
{
  Serial.print("Level: "); Serial.println(level);
  for (int ii = 0; ii < LAST_BUTTON; ii++) {
    Serial.print(ii); Serial.print(" - "); Serial.println(button_state[ii]);
    Serial.print("Score: "); Serial.println(score);
  }
}

uint32_t now = 0;
uint32_t run_time = 0;

bool started = false;

void loop()
{
  int flag = 0;
  if (!start_time) {
    start_time = millis();
  }
  now = millis();
  run_time = now - start_time;
  if (run_time > 120000 && run_time <= 125000) {
    digitalWrite(ALERT_PIN, LOW);
    flag = 1;
  } else if (run_time > 125000 && run_time < 150000) {
    digitalWrite(ALERT_PIN, HIGH);
    flag = 0;
  } else if (run_time > 150000 && run_time < 151000) {
    if (!endgame) {
      captured_score = score;
      endgame = 1;
    }
  } else {
    flag = 0;
  }
  print_state();
  // check reset pin, if on, and not recently pushed, then set everything to new level
  // Serial.println(digitalRead(LEVEL_UP_PIN));
  int levelup_read;
  levelup_read = 0;
  levelup_read = digitalRead(LEVEL_UP_PIN);
  if (!levelup_read && ((millis() - last_level_reset) >  RESET_DEBOUNCE )) {
    for (int ii = 0; ii < LAST_BUTTON; ii++) {
      button_state[ii] = false;
      digitalWrite(LED_PIN[ii], LOW);
    }
    level--;
    if (level < 0) {
      level = 0;
    }
    last_level_reset = millis();
    print_state();
  }
  // check scoring pins, add score, set state and light LEDs
  int button_press = 0;
  for (int button = 0; button < LAST_BUTTON; button++) {
    button_press = digitalRead(SCORE_PIN[button]);
    if (!button_press && !button_state[button]) {
      button_state[button] = true;
      score += level_value[level];
      digitalWrite(LED_PIN[button], HIGH);
      Serial.print("Score! :"); Serial.println(button);
    }
  }

  // Check if a client has connected
  WiFiClient client = server.available();
  if (client) {
    // Read the first line of the request
    String request = client.readStringUntil('\r');

    client.flush();

    // Prepare the response. Start with the common header:
    String s;

    if (request.indexOf("score") != -1) {
      // if first time retrieval then start clock and scoring
      if (!started) {
        started = true;
        button_state[0] = false;
        digitalWrite(LED_PIN[0], LOW);
        button_state[1] = false;
        digitalWrite(LED_PIN[1], LOW);
        button_state[2] = false;
        digitalWrite(LED_PIN[2], LOW);
        button_state[3] = false;
        digitalWrite(LED_PIN[3], LOW);
        last_level_reset = 0;
        level = LAST_LEVEL - 1;
        score = 0;
        start_time = millis();
        run_time = 0;
        flag = 0;
        endgame = 0;
        captured_score = 0;
      }
      
      s = "HTTP/1.0 200 OK\r\n";
      s += "Content-Type: text/html\r\n\r\n";
      s += "<!DOCTYPE HTML>\r\n<html>\r\n";
      s += "<head><meta http-equiv=\"refresh\" content=\"1\"> <title>Field 1 Scoring Page </title> </head>";

      s += String("<p><h1>");
      s += "Score: ";
      if (endgame) {
        s += String(captured_score);
      } else {
        s += String(score);
      }
      s += String("</h1></p>");
      s += String("<p> <h1> run time: ") + String(run_time/1000) + String("</h1></p>");

      s += "<br>"; // Go to the next line.
      s += "</html>\n";

    } else {

      s = "HTTP/1.0 200 OK\r\n";
      s += "Content-Type: text/html\r\n\r\n";
      s += "<!DOCTYPE HTML>\r\n<html>\r\n";
      s += "<head> <title>Field 1 Scoring Page </title> </head>";
      s += String("<table><tr><td>");
      s += String("<a href=\"/score\"><button> <H1> Start Now !  </H1> </button></a>");
      s += String("</td>");
      s += String("</tr></table>");
      s += "</html>\n";
      
    }
    // Send the response to the client
    client.print(s);
    client.flush();
    Serial.println("Client disonnected");
    delay(1);
  }
}

void setupWiFi()
{
  Serial.println("Set up WiFi");
  WiFi.mode(WIFI_AP);

  char* AP_SSID = "PT_FIELD1";
  char* AP_PW = "password";

  WiFi.softAP(AP_SSID, AP_PW);

  IPAddress myIP = WiFi.softAPIP();

  Serial.print("AP IP address: ");

  Serial.println(myIP);
}

void initHardware()
{
  Serial.begin(115200);
  for (int ii = 0; ii < LAST_BUTTON; ii++) {
    pinMode(SCORE_PIN[ii], INPUT_PULLUP);
    pinMode(LED_PIN[ii], OUTPUT);
    pinMode(ALERT_PIN, OUTPUT);
    digitalWrite(LED_PIN[ii], LOW);
    digitalWrite(ALERT_PIN, HIGH);
  }
  pinMode(LEVEL_UP_PIN, INPUT_PULLUP);
}

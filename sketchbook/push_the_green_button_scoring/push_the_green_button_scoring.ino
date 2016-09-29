#include <ESP8266WiFi.h>

//////////////////////
// WiFi Definitions //
//////////////////////
const char WiFiAPPSK[] = "pyrotech2016";

/////////////////////
// Pin Definitions //
/////////////////////

const int LAST_BUTTON = 4;

const int LED_PIN[LAST_BUTTON] = {5,4,0,2};
const int SCORE_PIN[LAST_BUTTON] = {14,12,13,15};
const int LEVEL_UP_PIN = 12;

bool button_state[LAST_BUTTON] = {false, false , false, false};

const int LAST_LEVEL = 3;
int level = LAST_LEVEL - 1;
int level_value[LAST_LEVEL] = {1, 10, 100};

const unsigned long int RESET_DEBOUNCE = 5000;

unsigned long int last_level_reset = 0;

int score = 0;

WiFiServer server(80);

void setup()
{
  initHardware();
  setupWiFi();
  server.begin();
}

void loop()
{
  // check reset pin, if on, and not recently pushed, then set everything to new level
  if (digitalRead(LEVEL_UP_PIN) && last_level_reset > RESET_DEBOUNCE) {
    level--;
    for (int ii; ii < LAST_BUTTON; ii++) {
      button_state[ii] = false;
      digitalWrite(LED_PIN[ii], LOW);
    }
    if (level > 0) {
      level = 0;
    }
    last_level_reset = millis();
  }
  // check scoring pins, add score, set state and light LEDs
  int state = 0;
  for (int button = 0; button < LAST_BUTTON; button++) {
    state = digitalRead(SCORE_PIN[button]);
    if (state && !button_state[button]) {
      button_state[button] = state;
      score += level_value[level];
      digitalWrite(LED_PIN[button], HIGH);
    }
  }

  // Check if a client has connected
  WiFiClient client = server.available();
  // Read the first line of the request
  String req = client.readStringUntil('\r');
  Serial.println(req);
  client.flush();


  // Prepare the response. Start with the common header:
  String s = "HTTP/1.0 200 OK\r\n";
  s += "Content-Type: text/html\r\n\r\n";
  s += "<!DOCTYPE HTML>\r\n<html>\r\n";

  s += String("<p><h1>");
  s += "Score: ";
  s += String(score);
  s += String("</h1></p>");;

  s += "<br>"; // Go to the next line.
  s += "</html>\n";

  // Send the response to the client
  client.print(s);
  delay(1);
  Serial.println("Client disonnected");
}

void setupWiFi()
{
  WiFi.mode(WIFI_AP);

  // Do a little work to get a unique-ish name. Append the
  // last two bytes of the MAC (HEX'd) to "Thing-":
  uint8_t mac[WL_MAC_ADDR_LENGTH];
  WiFi.softAPmacAddress(mac);
  String macID = String(mac[WL_MAC_ADDR_LENGTH - 2], HEX) +
                 String(mac[WL_MAC_ADDR_LENGTH - 1], HEX);
  macID.toUpperCase();
  String AP_NameString = "PyroTech2016";

  char AP_NameChar[AP_NameString.length() + 1];
  memset(AP_NameChar, 0, AP_NameString.length() + 1);

  for (int i = 0; i < AP_NameString.length(); i++)
    AP_NameChar[i] = AP_NameString.charAt(i);

  WiFi.softAP(AP_NameChar, WiFiAPPSK);
}

void initHardware()
{
  Serial.begin(115200);
  for (int ii; ii < LAST_BUTTON; ii++) {
    pinMode(SCORE_PIN[ii], INPUT_PULLUP);
    pinMode(LED_PIN[ii], OUTPUT);
    digitalWrite(LED_PIN[ii], LOW);
  }
}

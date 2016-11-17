#include <ESP8266WiFi.h>

//////////////////////
// WiFi Definitions //
//////////////////////
char WiFiAPPSK[] = "kira-wifi";

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


uint32_t now = 0;
uint32_t run_time = 0;

bool started = false;

void loop()
{
  // Check if a client has connected
  WiFiClient client = server.available();
  if (client) {
    // Read the first line of the request
    String request = client.readStringUntil('\r');

    client.flush();

    // Prepare the response. Start with the common header:
    String s;

    s = "HTTP/1.0 200 OK\r\n";
    s += "Content-Type: text/html\r\n\r\n";
    s += "<!DOCTYPE HTML>\r\n<html>\r\n";
    s += "<head><meta http-equiv=\"refresh\" content=\"1\"> <title>K9 Temperature Report </title> </head>";


    int temperature = 99;
    temperature = analogRead(A0);
    
    // Kira's code goes here
    s += String("<body>");
    s +=   String("<h1>Temperature:</h1>");
    s +=   String(temperature);
    s +=   String(" F");

    // this is the end code
    s +=    String("<br /> \
              </body> \
            </html>");

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

  char* AP_SSID = WiFiAPPSK;
  char* AP_PW = "password";

  WiFi.softAP(AP_SSID, AP_PW);

  IPAddress myIP = WiFi.softAPIP();

  Serial.print("AP IP address: ");

  Serial.println(myIP);
}

void initHardware()
{
  Serial.begin(115200);
}

#include <ESP8266WiFi.h>

//////////////////////
// WiFi Definitions //
//////////////////////
char WiFiAPPSK[] = "kira-wifi";

/////////////////////
// Pin Definitions //
/////////////////////


WiFiServer server(80);


void setup()
{
  initHardware();
  setupWiFi();
  server.begin();
}

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
    temperature = 1023 - temperature;
    temperature = temperature/10;
    
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

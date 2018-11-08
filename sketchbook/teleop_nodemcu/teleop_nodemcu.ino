#include <ESP8266WiFi.h>
#include <WiFiClient.h> 
#include <ESP8266WebServer.h>

// Update these with values suitable for your network.
const char *ssid = "MackieLand";
const char *password = "thereisnospoon";

ESP8266WebServer server(80);
char buffer[1024];

const char* format = 
          "<html>"
             "<head> <title> MackieLand Main Page </title> </head>"
             "<body>"
                 "<h2> MackieLand Home Page </h2>"
                 "<h2> Status </h2>"
                 "<p> %s </p>"
              "</body>"
           "</html>";               

char* thePage(const char* theMessage) {
  snprintf(buffer, 1024, format, theMessage);
  return buffer;
}

void handleRoot() {
  server.send(200, "text/html", thePage("unchanged"));
}

void blickSpeedSlow() {
  Serial.println("S");
  server.send(200, "text/html", thePage("slow"));
}

void blickSpeedFast() {
  Serial.println("F");
  server.send(200, "text/html", thePage("fast"));
}

void setup() {
  // serial setup
  Serial.begin(115200);
  
  // webserver set up
  WiFi.softAP(ssid, password);

  IPAddress myIP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(myIP);

  // server pages setup
  server.on("/", handleRoot);
  server.on("/fast", blickSpeedFast);
  server.on("/slow", blickSpeedSlow);
  server.begin();

  // status
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient();
}

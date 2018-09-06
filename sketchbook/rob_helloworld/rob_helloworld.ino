/* MINIMAL WEB SERVER: Create a WiFi access point and provide a web server on it. */

#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>

/* Set these to your desired credentials. */
const char *ssid = "MackieLand";  // limit of 32 characters
const char *password = "thereisaspoon";

ESP8266WebServer server(80);
int LIGHT_1 = 2;
int POWER_TAIL = 5;

/* Just a little test message.  Go to http://192.168.4.1 in a web browser
 */
void handleRoot() {
        server.send(200, "text/html", 
                         "<p>Hello World</p>");
}

void lightOn() {
        server.send(200, "text/html", 
                         "<p>Light On</p>");
        digitalWrite(LIGHT_1, LOW); //remember 2 & 16 are backwards
        digitalWrite(POWER_TAIL, HIGH);
}
void lightOff(){
        server.send(200, "text/html", 
                         "<p>Light Off</p>");
        digitalWrite(LIGHT_1, HIGH);
        digitalWrite(POWER_TAIL, LOW);
}

void setup() {
        delay(1000);
        Serial.begin(115200);
        Serial.println();
        Serial.print("Configuring access point...");
        WiFi.softAP(ssid, password);

        IPAddress myIP = WiFi.softAPIP();
        Serial.print("AP IP address: ");
        Serial.println(myIP);
        server.on("/", handleRoot);
        server.on("/rob", handleRoot);
       
        server.on("/light/on", lightOn);
        server.on("/light/off", lightOff);
        
        pinMode(LIGHT_1, OUTPUT);     // Initialize GPIO2 pin as an output
        digitalWrite(LIGHT_1, HIGH);
        pinMode(POWER_TAIL, OUTPUT);     // Initialize GPIO2 pin as an output
        digitalWrite(POWER_TAIL, LOW);
        
        server.begin();
        Serial.println("HTTP server started");
}

void loop() {
        server.handleClient();
}


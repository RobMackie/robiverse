/* MINIMAL WEB SERVER: Create a WiFi access point and provide a web server on it. */

#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>

/* Set these to your desired credentials. */
const char *ssid = "MackieLand";  // limit of 32 characters
const char *password = "thereisnospoon";

ESP8266WebServer server(80);

/* Just a little test message.  Go to http://192.168.4.1 in a web browser
 */
void handleRoot() {
        server.send(200, "text/html", 
                         "<h1>Hello World</h1>"
                         "<p> This is <strong>text</strong> that is strong</p>"
                         "<h1> This is the second header</h1>" 
                         "<p> This is some text</p>");
}
void handleJeremy() {
        server.send(200, "text/html", 
                         "<h1>Hello Jeremy</h1>"
                         "<p> Do What I say, not what I do!</p>");
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
        server.on("/jeremy", handleJeremy);
        server.begin();
        Serial.println("HTTP server started");
}

void loop() {
        server.handleClient();
}


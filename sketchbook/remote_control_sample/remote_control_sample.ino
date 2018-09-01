#include <ESP8266WiFi.h>

// Choose your wifi login:
const char* ssid="ForgeHQ_Shop";
const char* password = "robotsWin2017!";

int ledPin = 13; 
int value = LOW;
int sensorReading = 0;

WiFiServer server(80);

void setup() {
   Serial.begin(115200);
   delay(10);

   pinMode(ledPin, OUTPUT);
   digitalWrite(ledPin, LOW);

   Serial.println();
   Serial.println();
   Serial.print("Connecting to ");
   Serial.println(ssid);

   WiFi.begin(ssid, password);

   while(WiFi.status() != WL_CONNECTED) {
      delay(500);
      Serial.print(".");
   }

   Serial.println("");
   Serial.println("WiFi connected");

   server.begin();
   Serial.println("Server started");
   Serial.print("Use this URL to connect:");
   Serial.print("http://");
   Serial.print(WiFi.localIP());
   Serial.println("/");
}

void loop() {


   WiFiClient client = server.available();
   if (!client) {
      return;
   }

   Serial.println("new client");
   while(!client.available()) {
     delay(1);
   }

   String request = client.readStringUntil('\r');
   Serial.println(request);
   client.flush();

// Your code goes here and looks like this:
/* 
    if(request.indexOf("/left.cgi") != -1) {
       digitalWrite(ledPin, HIGH);
       value = HIGH;
   }
*/
 
   if(request.indexOf("/left.cgi") != -1) {
       digitalWrite(ledPin, HIGH);
       value = HIGH;
   }

   digitalWrite(ledPin, value);
   client.println("HTTP/1.1 200 OK");
   client.println("Content-Type: text/html");
   client.println("");
   client.println("<html><hr /><center>");
   client.println("<H1> Your Device Name goes here </H1><br /> <hr />");
// your html code goes here, example link
/*
 * client.println("<a href=\"/left.cgi\">LEFT</a>");
 */
   client.println("<a href=\"/left.cgi\">LEFT</a>");

   
   client.println("</html>");

   delay(1);
   Serial.println("Client disconnected");
   Serial.println("");
   
}

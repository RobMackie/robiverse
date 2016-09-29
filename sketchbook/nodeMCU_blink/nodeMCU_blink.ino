#include <ESP8266WiFi.h>

const char* ssid="typhoon";
const char* password = "23923836091946991609196211";

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


   //int sensorReading = analogRead(17);

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

 
   if(request.indexOf("/LED=ON") != -1) {
       digitalWrite(ledPin, HIGH);
       value = HIGH;
   }
   if(request.indexOf("/LED=OFF") != -1) {
       digitalWrite(ledPin, LOW);
       value = LOW;
   }
   sensorReading = analogRead(0);

   digitalWrite(ledPin, value);
   client.println("HTTP/1.1 200 OK");
   client.println("Content-Type: text/html");
   client.println("");
   client.println("<html><hr /><center>");
   client.println("<H1> IoT Control System </H1><br /> <hr />");
   // client.print("<H1>analog input is ");
   // client.print(sensorReading);
   // client.println("</H1>");
   client.println("<table><tr><td>");
   client.println("<a href=\"/LED=OFF\"><button> <H1> Turn Off </H1> </button></a>");
   client.println("</td>");
   client.println("<td> <-------------------->"); 
   client.println("</td><td>");
   client.println("<a href=\"/LED=ON\"> <button> <H1> Turn On </H1> </button> </a>");
   client.println("</td></tr></table>");   
   client.println("<hr /></center></html>");

   delay(1);
   Serial.println("Client disconnected");
   Serial.println("");
   
}

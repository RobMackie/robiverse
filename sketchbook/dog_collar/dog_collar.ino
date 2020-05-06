#include <ESP8266WiFi.h>

//////////////////////
// WiFi Definitions //
//////////////////////
char WiFiAPPSK[] = "FLLPROJ";

/////////////////////
// Pin Definitions //
/////////////////////


WiFiServer server(80);

int temperature = 0;

void setup()
{
  initHardware();
  setupWiFi();
  server.begin();
}

void print_state()
{
  Serial.print("Level: "); Serial.println(temperature);

}

int counter = 0;
int started = 0;
void loop()
{
   // check scoring pins, add score, set state and light LEDs
  /*
  temperature = analogRead(A0);
  counter++;
  if (!counter%100) {
    Serial.print("Temperature: "); Serial.println(temperature);
  }
  */
  if (!started) {
     Serial.println("started");
     started++;
  }
  // Check if a client has connected
  WiFiClient client = server.available();
  if (client) {
    // Read the first line of the request
    String request = client.readStringUntil('\r');

    client.flush();

    // Prepare the response. Start with the common header:
    String s;


      s += String("<p><h1>");
      s += "Temperature: ";

      s += String("</h1></p>");

      s += "<br>"; // Go to the next line.
      s += "</html>\n";


      s = "HTTP/1.0 200 OK\r                                   \
           Content-Type: text/html \r                          \
           \r                                                  \
           <!DOCTYPE HTML> \r                                  \
           <html> \r                                           \
             <head>                                            \
                <meta http-equiv=\"refresh\" content=\"5\">    \
                <title> K9 Temperature Report </title>         \
             </head>                                           \
             <body>                                            \
             ";
             
      // Kira's code goes here    
      s +=   "<h1>Temperature:</h1>";
      s +=   String(temperature);
      s +=   " F";

      // this is the end code
      s +=    "<br / \
              </body> \
            </html>";

 
    // Send the response to the client
    client.print(s);
    client.flush();
    Serial.println("Client disonnected");
  }
  delay(2);
}

void setupWiFi()
{
  Serial.println("Set up WiFi");
  WiFi.mode(WIFI_AP);

  char* AP_SSID = WiFiAPPSK;
  char* AP_PW = "pass";

  WiFi.softAP(AP_SSID, AP_PW);
  IPAddress myIP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(myIP);
}

void initHardware()
{
  Serial.begin(115200);
  pinMode(A0, INPUT);
}

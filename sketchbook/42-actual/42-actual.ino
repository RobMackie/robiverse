/* 
D0 = GPIO16;
D1 = GPIO5;
D2 = GPIO4;
D3 = GPIO0;
D4 = GPIO2;
D5 = GPIO14;
D6 = GPIO12;
D7 = GPIO13;
D8 = GPIO15;
D9 = GPIO3;
D10 = GPIO1;
 */
/* Create a WiFi access point and provide a web server on it. */

#include <ESP8266WiFi.h>
#include <WiFiClient.h> 
#include <ESP8266WebServer.h>
#include <Servo.h> 

/* Set these to your desired credentials. */
const char *ssid = "MackieLand";
const char *password = "thereisnospoon";


ESP8266WebServer server(80);
Servo myservo;  // create servo object to control a servo 
                // twelve servo objects can be created on most boards

int LIGHT_1 = 2;
int LIGHT_2 = 16;
int SERVO_1 = 5;


const char* status_on = "on";
const char* status_off = "off";
const char* status_straight = "STRAIGHT";
const char* status_right = "RIGHT";
const char* status_left = "LEFT";
const char* light1_status = status_on;
const char* light2_status = status_on;
const char* direction_status = status_left;

int buffer_length = 1024; 
char buffer[1024];

const char* format =
         "<html>"
             "<head> <title> MackieLand Main Page </title> </head>"
             "<body>"
                      "<h1> MackieLand Home Page </h1>"
                 "<p>"
                      "These are the options publicly supported by this server"
                 "</p>"
                 "<h2> Status </h2>"
                      "<ul>"
                          "<li> light 1: %s</li>"  
                          "<li> light 2: %s</li>"  
                          "<li> Direction: %s </li>"
                      "</ul>"
                 "<h2> Commands </h2>"
                 "<ul>"
                      "<li> <a href=\"/\"> No operation </a> <p/> </li>"
                      "<li> <a href=\"/light/1/on\"> Turn light 1 on </a> </li>"
                      "<li> <a href=\"/light/1/off\"> Turn light 1 off  </a> </li>"
                      "<li> <a href=\"/light/2/on\"> Turn light 2 on </a> </li>"
                      "<li> <a href=\"/light/2/off\"> Turn light 2 off  </a> </li>"
                      "<li> <a href=\"/left\"> Rotate counterclockwise </a> </li>"
                      "<li> <a href=\"/straight\"> Go straight </a>  </li>"
                      "<li> <a href=\"/right\"> Rotate clockwise </a> </li>"
                 "</ul>"
              "</body>"
           "</html>";

char* thePage() {
  snprintf(buffer, buffer_length, format, light1_status, light2_status, direction_status);
  return buffer;
}

/* Just a little test message.  Go to http://192.168.4.1 in a web browser
 * connected to this access point to see it.
 */
void handleRoot() {
  server.send(200, "text/html", thePage());
}

void turnOn_1() {
  light1_status = status_on;
  server.send(200, "text/html", thePage());
  digitalWrite(LIGHT_1, LOW);
}
void turnOff_1() {
  light1_status = status_off;
  server.send(200, "text/html", thePage());
  digitalWrite(LIGHT_1, HIGH);
}

void turnOn_2() {
  light2_status = status_on;
  server.send(200, "text/html", thePage());
  digitalWrite(LIGHT_2, LOW);
}
void turnOff_2() {
  light2_status = status_off;
  server.send(200, "text/html", thePage());
  digitalWrite(LIGHT_2, HIGH);
}

void handleLeft() {
  direction_status = status_left;
  server.send(200, "text/html", thePage());
  myservo.write(10);
}

void handleRight() {
  direction_status = status_right;
  server.send(200, "text/html", thePage());
  myservo.write(170);
}

void handleStraight() {
  direction_status = status_straight;
  server.send(200, "text/html", thePage());
  myservo.write(90);
}

void setup() {
  delay(1000);
  Serial.begin(115200);
  Serial.println();
  Serial.print("Configuring access point...");
  /* You can remove the password parameter if you want the AP to be open. */
  WiFi.softAP(ssid, password);

  IPAddress myIP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(myIP);
  server.on("/", handleRoot);
  server.on("/left", handleLeft);
  server.on("/right", handleRight);
  server.on("/straight", handleStraight);
  server.on("/light/1/on", turnOn_1);
  server.on("/light/1/off", turnOff_1); 
  server.on("/light/2/on", turnOn_2);  
  server.on("/light/2/off", turnOff_2);  
  server.begin();
  Serial.println("HTTP server started");

   pinMode(LIGHT_1, OUTPUT);     // Initialize GPIO2 pin as an output
   pinMode(LIGHT_2, OUTPUT);     // Initialize GPI16 pin as an output
   myservo.attach(SERVO_1);  // attaches the servo on D1 to the servo object )
   thePage();
   int buffer_length = strlen(buffer);
   Serial.print("buffer length: ");
   Serial.print(buffer_length);
}

void loop() {
  server.handleClient();
}


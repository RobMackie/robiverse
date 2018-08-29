/*
 * Copyright (c) 2015, Majenko Technologies
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 * 
 * * Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 * 
 * * Redistributions in binary form must reproduce the above copyright notice, this
 *   list of conditions and the following disclaimer in the documentation and/or
 *   other materials provided with the distribution.
 * 
 * * Neither the name of Majenko Technologies nor the names of its
 *   contributors may be used to endorse or promote products derived from
 *   this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
// http://192.168.4.1/left
// http://192.168.4.1/right

ESP8266WebServer server(80);
Servo myservo;  // create servo object to control a servo 
                // twelve servo objects can be created on most boards

int LIGHT_1 = 2;
int LIGHT_2 = 16;


const char* status_on = "on";
const char* status_off = "off";
const char* status_straight = "STRAIGHT";
const char* status_right = "RIGHT";
const char* status_left = "LEFT";
const char* light1_status = status_on;
const char* light2_status = status_on;
const char* direction_status = status_left;

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
                          "<li> light 1: %s</li>"  //arg 1
                          "<li> light 2: %s</li>"  //arg 2
                          "<li> Direction: %s </li>" //arg 3
                      "</ul>"
                 "<h2> Commands </h2>"
                 "<ul>"
                      "<li> <a href=\"/\"> No operation </a> <p/> </li>"
                      "<li> <a href=\"/light/1/on\"> Turn light 1 on <p/> </a> </li>"
                      "<li> <a href=\"/light/1/off\"> Turn light 1 off <p/> </a> </li>"
                      "<li> <a href=\"/light/2/on\"> Turn light 2 on <br/> </a> </li>"
                      "<li> <a href=\"/light/2/off\"> Turn light 2 off <p/> </a> </li>"
                      "<li> <a href=\"/left\"> Rotate counterclockwise <p/> </a> </li>"
                      "<li> <a href=\"/straight\"> Go straight </a> <p/> </li>"
                      "<li> <a href=\"/right\"> Rotate clockwise </a> <p/> </li>"
                 "</ul>"
              "</body>"
           "</html>";

char* thePage() {
  sprintf(buffer, format, light1_status, light2_status, direction_status);
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
   pinMode(LIGHT_2, OUTPUT);     // Initialize GPIO2 pin as an output
   myservo.attach(5);  // attaches the servo on D1 to the servo object 
}

void loop() {
	server.handleClient();
}

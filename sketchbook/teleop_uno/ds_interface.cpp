#include "ds_interface.h"

#define BUFFER_SIZE 10
#define BAUD_RATE 115200
#define SERIAL_TIMEOUT 500

DS_Interface::DS_Interface (int serial_rx, int serial_tx)
    :SoftwareSerial(serial_rx, serial_tx) 
{
    // nothing to do in here at this time
}

DS_Interface::~DS_Interface () 
{
    //nothing much to do here at this time
}

void DS_Interface::init()
{
    this->begin(BAUD_RATE);
    this->setTimeout(SERIAL_TIMEOUT);
}

char DS_Interface::readInputIfAvailable() 
{
  char bfr[BUFFER_SIZE];
  memset(bfr, 0, BUFFER_SIZE);
  if (this->available() > 0) {
    this->readBytesUntil( '\n',bfr,BUFFER_SIZE);
  }
  return bfr[0];
}


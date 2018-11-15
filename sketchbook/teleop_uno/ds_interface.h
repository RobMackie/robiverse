#include <SoftwareSerial.h>

class DS_Interface : public SoftwareSerial {
    public:
        // Create an instance in the overall scope above your code for Setup() & Loop()
        DS_Interface (int serial_rx, int serial_tx);
        virtual ~DS_Interface ();

        // Call from Setup()
        void init();

        /* 
         * readInputIfAvailable
         *  Each time this is called it gathers 1 ascii keystroke that was sent from the driver's station
         *  OR
         *  it return a char == '\0' which means there was no keystroke available from the driver's station
         *  The driver's station only sends when the keyboard provides a new keystroke
         *  There is no encoding for non-ascii keys
         */
        char readInputIfAvailable();

    private:
        char bfr[10];

};
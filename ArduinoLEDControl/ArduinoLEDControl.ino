/*
 * Derek Prince
 * Eli Kopp-Devol
 * 1/31/18
*/

#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN 6
#define NUM_LEDS 60   //might want to curb this to restrict current
#define BRIGHTNESS 64 //alternatively, this (1/4 brightness)

Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LEDS, PIN, NEO_GRBW + NEO_KHZ800);  //If this doesnt work as expected, change to RGBW first

void setup() {
  Serial.begin(115200); //I somewhat worry about this messing with our serial ports.
  while(!Serial){};
  strip.setBrightness(BRIGHTNESS);
  strip.begin();
  strip.show(); // Initialize all pixels to 'off'
}

void loop() {
  uint8_t red, green, blue;
  //only dealing with three inputs to avoid any unfortunate async loop nonesense
  if(serial.available() > 3){
    red = serial.read();
    green = serial.read();
    blue = serial.read();
    strip.Color(red, green, blue);
  }
  //else do nothing
}


/*
 * Derek Prince
 * Eli Kopp-Devol
 * 1/31/18
*/

import oscP5.*;
import netP5.*;
import processing.serial.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
Serial myPort; 

void setup() {
  /* listen on port 12000 */
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
  oscP5.plug(this,"RGBVals","/wek/outputs");
  String portName = Serial.list()[0];           //adjust to target Arduino port
  myPort = new Serial(this, portName, 115200);  //adjust baud as needed
}

public void RGBVals(float red, float green, float blue) {
  println(">Message from /wek/outputs received");
  println(" RGB Received: Red="+red+", Green="+green+", Blue="+blue);
  
  //lets keep it functional. It is Java after all.
  //fit to 8-bit values
  myPort.write((byte)(255/red));
  println(" Wrote red="+(255/red));
  myPort.write((byte)(255/green));
  println(" Wrote green="+(255/green));
  myPort.write((byte)(255/blue));
  println(" Wrote blue="+(255/blue));
}

void oscEvent(OscMessage theOscMessage) {
  // double-check event was handled
  if(theOscMessage.isPlugged()==false) {
  /* print the address pattern and the typetag of the received OscMessage */
  println(">received an unmatched osc message.");
  println(" addrpattern\t"+theOscMessage.addrPattern());
  println(" typetag\t"+theOscMessage.typetag());
  }
}
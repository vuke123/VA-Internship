/*   
 *  ------ [RS-485_01] Send Data -------- 
 *   
 *  This sketch shows how to send data through RS-485 standard. 
 *  This standard defines the electrical characteristics of drivers
 *  and receivers for use in digital systems. It does not specify
 *  or recommend any communications protocol. For a complete 
 *  communication protocol, please see the Modbus examples. 
 *   
 *  Copyright (C) 2016 Libelium Comunicaciones Distribuidas S.L. 
 *  http://www.libelium.com 
 *   
 *  This program is free software: you can redistribute it and/or modify 
 *  it under the terms of the GNU General Public License as published by 
 *  the Free Software Foundation, either version 2 of the License, or 
 *  (at your option) any later version. 
 *   
 *  This program is distributed in the hope that it will be useful, 
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of 
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 *  GNU General Public License for more details. 
 *   
 *  You should have received a copy of the GNU General Public License 
 *  along with this program. If not, see <http://www.gnu.org/licenses/>. 
 *   
 *  Version:          3.0 
 *  Implementation:   Ahmad Saad
 */

// Include always this library when you are using the Wasp485 functions  
#include <Wasp485.h>

void setup() {

  // Power on the USB for viewing data in the serial monitor
  USB.ON();
  // Print hello message
  USB.println(F("Hello this is RS-485 communication send data example."));
  delay(100);

  // Powers on the module and assigns the SPI in socket0
  if ( W485.ON() == 0) 
  {
     USB.println(F("RS-485 module started successfully"));
  } 
  else 
  {
     USB.println(F("RS-485 did not initialize correctly"));
  }
  
  delay(100);

  // Configure the baud rate of the module
  W485.baudRateConfig(9600);
  // Configure the parity bit as disabled 
  W485.parityBit(DISABLE);
  // Use one stop bit configuration
  W485.stopBitConfig(1);  
}

void loop() {     

  // Reading the analog input 1 
  int analog1 = analogRead(ANALOG1);
  // Reading the analog input 2 
  int analog2 = analogRead(ANALOG2); 

  // Send data through RS-485 line
  W485.send("Data from analog1 input: ");
  W485.send(analog1);
  W485.send("\n");

  W485.send("Data from analog2 input: ");
  W485.send(analog2);
  W485.send("\n");  

  delay(500);

}






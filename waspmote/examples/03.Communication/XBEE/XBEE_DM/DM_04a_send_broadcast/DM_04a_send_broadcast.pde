/*  
 *  ------ [DM_04a] - broadcast packets  -------- 
 *  
 *  Explanation: This program shows how to send packets with 
 *  XBee-Digimesh modules. Broadcast address (0x000000000000FFFF)
 *  is specified as destination address
 *  
 *  Copyright (C) 2015 Libelium Comunicaciones Distribuidas S.L. 
 *  http://www.libelium.com 
 *  
 *  This program is free software: you can redistribute it and/or modify 
 *  it under the terms of the GNU General Public License as published by 
 *  the Free Software Foundation, either version 3 of the License, or 
 *  (at your option) any later version. 
 *  
 *  This program is distributed in the hope that it will be useful, 
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of 
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 *  GNU General Public License for more details. 
 *  
 *  You should have received a copy of the GNU General Public License 
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>. 
 *  
 *  Version:           0.2
 *  Design:            David Gascón 
 *  Implementation:    Yuri Carmona
 */

#include <WaspXBeeDM.h>
#include <WaspFrame.h>

// Define BROADCAST MAC address
//////////////////////////////////////////
char RX_ADDRESS[] = "000000000000FFFF";
//////////////////////////////////////////

// Define the Waspmote ID
char WASPMOTE_ID[] = "node_01";


// define variable
uint8_t error;



void setup()
{
  // init USB port
  USB.ON();
  USB.println(F("Sending BROADCAST packets example"));
  
  // store Waspmote identifier in EEPROM memory
  frame.setID( WASPMOTE_ID );
  
  // init XBee
  xbeeDM.ON();
  
}


void loop()
{
  ///////////////////////////////////////////
  // 1. Create ASCII frame
  ///////////////////////////////////////////  

  // create new frame
  frame.createFrame(ASCII);  
  
  // add frame fields
  frame.addSensor(SENSOR_STR, "new_sensor_frame");
  frame.addSensor(SENSOR_BAT, PWR.getBatteryLevel()); 
  

  ///////////////////////////////////////////
  // 2. Send packet
  ///////////////////////////////////////////  

  // send XBee packet
  error = xbeeDM.send( RX_ADDRESS, frame.buffer, frame.length );   
  
  // check TX flag
  if( error == 0 )
  {
    USB.println(F("send ok"));
    
    // blink green LED
    Utils.blinkGreenLED();
    
  }
  else 
  {
    USB.println(F("send error"));
    
    // blink red LED
    Utils.blinkRedLED();
  }

  // wait for five seconds
  delay(5000);
}




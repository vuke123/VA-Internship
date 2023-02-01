/*  
 *  ------ [900_11] - send packets to a gateway -------- 
 *  
 *  Explanation: This program shows how to send AT commands to the XBee
 *  modules
 *  
 *  Copyright (C) 2012 Libelium Comunicaciones Distribuidas S.L. 
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
 *  Version:           0.1 
 *  Design:            David Gascón 
 *  Implementation:    Yuri Carmona
 */
 
#include <WaspXBee900.h>


void setup()
{
  // init USB port
  USB.ON();
  USB.println(F("900_11 example"));

  //////////////////////////
  // 1. init XBee
  //////////////////////////
  xbee900.ON();
  
  
  //////////////////////////
  // 2. Request channel
  //////////////////////////  
  if(!xbee900.sendCommandAT("CH#")) 
  {
    USB.print(F("Channel: "));
    USB.printHex(xbee900.commandAT[0]);
    USB.println();
  }
  else 
  {
    USB.println(F("at error"));
  }
  
  
  //////////////////////////
  // 3. Request PAN ID
  //////////////////////////  
  if(!xbee900.sendCommandAT("ID#")) 
  {
    USB.print(F("PANID: "));
    USB.printHex(xbee900.commandAT[0]);
    USB.printHex(xbee900.commandAT[1]);
    USB.println();
  }
  else
  {
    USB.println(F("at error"));
  }
  
  
  //////////////////////////
  // 4. Request encryption mode
  //////////////////////////  
  if(!xbee900.sendCommandAT("EE#")) 
  {
    USB.print(F("encryption mode: "));
    USB.printHex(xbee900.commandAT[0]);
    USB.println();
  }
  else
  {
    USB.println(F("at error"));
  }
  
}


void loop()
{
  // Do nothing
  delay(5000);
}




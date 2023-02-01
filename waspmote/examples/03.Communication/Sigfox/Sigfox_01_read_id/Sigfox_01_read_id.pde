/*  
 *  ------ Sigfox Code Example -------- 
 *  
 *  Explanation: This example shows how to display the module's ID
 *  
 *  Copyright (C) 2016 Libelium Comunicaciones Distribuidas S.L. 
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
 *  Version:           3.0
 *  Design:            David Gascon 
 *  Implementation:    Yuri Carmona  
 */
#include <WaspSigfox.h>

//////////////////////////////////////////////
uint8_t socket = SOCKET0;
//////////////////////////////////////////////

uint8_t error;


void setup() 
{
  USB.ON();  
  
  //////////////////////////////////////////////
  // switch on
  //////////////////////////////////////////////
  error = Sigfox.ON(socket);
  
  // Check status
  if( error == 0 ) 
  {
    USB.println(F("Switch ON OK"));     
  }
  else 
  {
    USB.println(F("Switch ON ERROR")); 
  } 
  
  USB.println();
}



void loop() 
{
  //////////////////////////////////////////////
  // show Firmware data
  //////////////////////////////////////////////
  error = Sigfox.getID();
    
  // Check status
  if( error == 0 ) 
  {
    USB.println(F("Get ID OK"));     
    
    USB.print(F("Module ID: "));
    USB.println(Sigfox._id, HEX);
  }
  else 
  {
    USB.println(F("Get ID ERROR")); 
  } 
 
  USB.println(F("-------------------------------")); 
  
  delay(5000);
}

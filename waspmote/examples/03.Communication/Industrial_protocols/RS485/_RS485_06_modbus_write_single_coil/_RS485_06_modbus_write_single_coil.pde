/*   
 *  ------ [RS-485_06] Modbus Write Single Coil-------- 
 *   
 *  This sketch shows the use of the Modbus communication protocol over 
 *  RS-485 standard, and the use of the main functions of the library. 
 *  Modbus allows for communication between many devices connected
 *  to the same network. There are many variants of Modbus protocols, 
 *  but Waspmote implements the RTU format. Modbus RTU is the most 
 *  common implementation available for Modbus. 
 *  
 *  This example shows the use of the function readCoils. 
 *  This funtion writes a single coil to either ON or OFF.
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


// Include these libraries for using the RS-485 and Modbus functions
#include <ModbusMaster.h>

// Instantiate ModbusMaster object as slave ID 1
ModbusMaster node(RS485_COM, 1);
// Define one address for reading
#define address 1
// Bit to write 
#define bitData 1

void setup()
{
  // Power on the USB for viewing data in the serial monitor 
  USB.ON();
  // Print hello message
  USB.println(F("Modbus communication over RS-485"));
  delay(100);
  // Initialize Modbus communication baud rate
  node.begin(9600);
}


void loop()
{
  // This variable will store the result of the communication
  // result = 0 : no errors
  // result = 1 : error occurred  
  int result =  node.writeSingleCoil(address,bitData);

  if (result != 0) {
    // If no response from the slave, print an error message
    USB.println(F("Communication error"));
    delay(100);
  } 
  else 
  {     
    // If all ok
    USB.print(F("Data written successfully"));
    delay(100);
  }

  USB.print(F("\n"));
  delay(1000);

  // Clear the response buffer 
  node.clearResponseBuffer();

}






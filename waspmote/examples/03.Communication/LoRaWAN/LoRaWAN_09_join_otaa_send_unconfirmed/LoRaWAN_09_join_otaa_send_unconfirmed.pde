/*  
 *  ------ LoRaWAN Code Example -------- 
 *  
 *  Explanation: This example shows how to configure the module and
 *  send packets to a LoRaWAN gateway without ACK after join a network
 *  using OTAA
 *  
 *  Copyright (C) 2019 Libelium Comunicaciones Distribuidas S.L. 
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
 *  Version:           3.2
 *  Design:            David Gascon 
 *  Implementation:    Luis Miguel Marti
 */

#include <WaspLoRaWAN.h>

// socket to use
//////////////////////////////////////////////
uint8_t socket = SOCKET0;
//////////////////////////////////////////////

// Device parameters for Back-End registration
////////////////////////////////////////////////////////////
char DEVICE_EUI[]  = "0102030405060708";
char APP_EUI[] = "0102030405060708";
char APP_KEY[] = "01020304050607080910111213141516";
////////////////////////////////////////////////////////////

// Define port to use in Back-End: from 1 to 223
uint8_t PORT = 3;

// Define data payload to send (maximum is up to data rate)
char data[] = "0102030405060708090A0B0C0D0E0F";

// variable
uint8_t error;
uint8_t error_config = 0;



void setup() 
{
  USB.ON();
  USB.println(F("LoRaWAN example - Send Unconfirmed packets (ACK)\n"));


  USB.println(F("------------------------------------"));
  USB.println(F("Module configuration"));
  USB.println(F("------------------------------------\n"));


  //////////////////////////////////////////////
  // 1. Switch on
  //////////////////////////////////////////////

  error = LoRaWAN.ON(socket);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("1. Switch ON OK"));     
  }
  else 
  {
    USB.print(F("1. Switch ON error = ")); 
    USB.println(error, DEC);
    error_config = 1;
  }
  
  
  //////////////////////////////////////////////
  // 2. Change data rate
  //////////////////////////////////////////////

  error = LoRaWAN.setDataRate(3);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("2. Data rate set OK"));     
  }
  else 
  {
    USB.print(F("2. Data rate set error= ")); 
    USB.println(error, DEC);
     error_config = 2;
  }


  //////////////////////////////////////////////
  // 3. Set Device EUI
  //////////////////////////////////////////////

  error = LoRaWAN.setDeviceEUI(DEVICE_EUI);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("3. Device EUI set OK"));     
  }
  else 
  {
    USB.print(F("3. Device EUI set error = ")); 
    USB.println(error, DEC);
    error_config = 3;
  }

  //////////////////////////////////////////////
  // 4. Set Application EUI
  //////////////////////////////////////////////

  error = LoRaWAN.setAppEUI(APP_EUI);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("4. Application EUI set OK"));     
  }
  else 
  {
    USB.print(F("4. Application EUI set error = ")); 
    USB.println(error, DEC);
    error_config = 4;
  }

  //////////////////////////////////////////////
  // 5. Set Application Session Key
  //////////////////////////////////////////////

  error = LoRaWAN.setAppKey(APP_KEY);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("5. Application Key set OK"));     
  }
  else 
  {
    USB.print(F("5. Application Key set error = ")); 
    USB.println(error, DEC);
    error_config = 5;
  }

  /////////////////////////////////////////////////
  // 6. Join OTAA to negotiate keys with the server
  /////////////////////////////////////////////////
  
  error = LoRaWAN.joinOTAA();

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("6. Join network OK"));         
  }
  else 
  {
    USB.print(F("6. Join network error = ")); 
    USB.println(error, DEC);
    error_config = 6;
  }


  //////////////////////////////////////////////
  // 7. Save configuration
  //////////////////////////////////////////////

  error = LoRaWAN.saveConfig();

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("7. Save configuration OK"));     
  }
  else 
  {
    USB.print(F("7. Save configuration error = ")); 
    USB.println(error, DEC);
    error_config = 7;
  }

  //////////////////////////////////////////////
  // 8. Switch off
  //////////////////////////////////////////////

  error = LoRaWAN.OFF(socket);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("8. Switch OFF OK"));     
  }
  else 
  {
    USB.print(F("8. Switch OFF error = ")); 
    USB.println(error, DEC);
    error_config = 8;
  }
  
  if (error_config == 0){
    USB.println(F("\n---------------------------------------------------------------"));
    USB.println(F("Module configured"));
    USB.println(F("After joining through OTAA, the module and the network exchanged "));
    USB.println(F("the Network Session Key and the Application Session Key which "));
    USB.println(F("are needed to perform communications. After that, 'ABP mode' is used"));
    USB.println(F("to join the network and send messages after powering on the module"));
    USB.println(F("---------------------------------------------------------------\n"));
    USB.println();  
  }
  else{
    USB.println(F("\n---------------------------------------------------------------"));
    USB.println(F("Module not configured"));
    USB.println(F("Check OTTA parameters and restart the code."));
    USB.println(F("If you continue executing the code, frames might not be sent even"));
    USB.println(F("though the code prints: Send unconfirmed packet OK"));
    USB.println(F("\n---------------------------------------------------------------"));
    
  }
}



void loop() 
{

  //////////////////////////////////////////////
  // 1. Switch on
  //////////////////////////////////////////////

  error = LoRaWAN.ON(socket);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("1. Switch ON OK"));     
  }
  else 
  {
    USB.print(F("1. Switch ON error = ")); 
    USB.println(error, DEC);
  }


  //////////////////////////////////////////////
  // 2. Join network
  //////////////////////////////////////////////

  error = LoRaWAN.joinABP();

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("2. Join network OK"));     

    //////////////////////////////////////////////
    // 3. Send unconfirmed packet 
    //////////////////////////////////////////////

    error = LoRaWAN.sendUnconfirmed( PORT, data);

    // Error messages:
    /*
     * '6' : Module hasn't joined a network
     * '5' : Sending error
     * '4' : Error with data length   
     * '2' : Module didn't response
     * '1' : Module communication error   
     */
    // Check status
    if( error == 0 ) 
    {
      USB.println(F("3. Send unconfirmed packet OK"));  
      if (LoRaWAN._dataReceived == true)
      { 
        USB.print(F("   There's data on port number "));
        USB.print(LoRaWAN._port,DEC);
        USB.print(F(".\r\n   Data: "));
        USB.println(LoRaWAN._data);
      }   
    }
    else 
    {
      USB.print(F("3. Send unconfirmed packet error = ")); 
      USB.println(error, DEC);
    } 
  }
  else 
  {
    USB.print(F("2. Join network error = ")); 
    USB.println(error, DEC);
  }


  //////////////////////////////////////////////
  // 4. Switch off
  //////////////////////////////////////////////

  error = LoRaWAN.OFF(socket);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("4. Switch OFF OK"));     
  }
  else 
  {
    USB.print(F("4. Switch OFF error = ")); 
    USB.println(error, DEC);
    USB.println();
  }


  delay(10000);
}

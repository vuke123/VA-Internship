/*  
 *  ------   [ZB_07b] - Use of Expansion board     -------- 
 *  
 *  Explanation: This example shows how to receive packet via
 *  the Expansion board (SOCKET1). 
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


#include <WaspXBeeZB.h>

// define variable
uint8_t error;


void setup()
{  
  // init USB port
  USB.ON();
  USB.println(F("Receiving example via Expansion Board"));

  //////////////////////////
  // 1. init XBees
  //////////////////////////
  
  // 1.2. initiliaze object in SOCKET1
  xbeeZB.ON( SOCKET1 ); 
 
  delay(3000);


  //////////////////////////
  // 2. check both XBee's network parameters
  //////////////////////////
  checkNetworkParams();
}


void loop()
{ 
  // receive XBee packet
  error = xbeeZB.receivePacketTimeout( 10000 );
  
  // check answer  
  if( error == 0 ) 
  {
    // Show data stored in '_payload' buffer indicated by '_length'
    USB.print(F("\nData: "));  
    USB.println( xbeeZB._payload, xbeeZB._length);
    
    // Show data stored in '_payload' buffer indicated by '_length'
    USB.print(F("Length: "));  
    USB.println( xbeeZB._length,DEC);
  }
  else
  {
    // Print error message:
    /*
     * '7' : Buffer full. Not enough memory space
     * '6' : Error escaping character within payload bytes
     * '5' : Error escaping character in checksum byte
     * '4' : Checksum is not correct	  
     * '3' : Checksum byte is not available	
     * '2' : Frame Type is not valid
     * '1' : Timeout when receiving answer   
    */
    USB.print(F("Error receiving a packet:"));
    USB.println(error,DEC);     
  }

} 




/*******************************************
 *
 *  checkNetworkParams - Check operating
 *  network parameters in the XBee module
 *
 *******************************************/
void checkNetworkParams()
{
  // 1. get operating 64-b PAN ID
  xbeeZB.getOperating64PAN();  

  // 2. wait for association indication
  xbeeZB.getAssociationIndication();  

  USB.println(F("Wait for association"));
  while( xbeeZB.associationIndication != 0  )
  { 
    delay(2000);

    USB.print(F("."));   

    xbeeZB.getAssociationIndication();
  }

  USB.println(F("\nmodule joined a network!"));

}




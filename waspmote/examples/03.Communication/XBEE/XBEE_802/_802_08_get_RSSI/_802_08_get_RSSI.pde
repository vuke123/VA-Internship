/*  
 *  ------ [802_08] - get RSSI from last received packet  -------- 
 *  
 *  Explanation: This program shows how to get RSSI value from the 
 *  last received packet. In this protocol it is possible to extract this 
 *  information from each packet. Besides, there is an API function which
 *  shows this information. Before running this example, make sure there 
 *  is another emitter sending packets to this XBee module in order to 
 *  receive information.
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
 *  Design:            David Gascón 
 *  Implementation:    Yuri Carmona
 */

#include <WaspXBee802.h>

// define variable
uint8_t error;

// variable to store RSSI
int rssi;


void setup()
{  
  // init USB port
  USB.ON();
  USB.println(F("Get RRSI example"));

  // init XBee 
  xbee802.ON(); 

}



void loop()
{ 
  // receive XBee packet (wait for 10 seconds)
  error = xbee802.receivePacketTimeout( 10000 );

  // check answer  
  if( error == 0 ) 
  {
    // Show data stored in '_payload' buffer indicated by '_length'
    USB.print(F("Data: "));  
    USB.println( xbee802._payload, xbee802._length);
    
    // Show data stored in '_payload' buffer indicated by '_length'
    USB.print(F("Length: "));  
    USB.println( xbee802._length,DEC);
    
    USB.print(F("RSSI(dBm): "));   
    USB.println(xbee802._rssi);

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


  // Getting RSSI using the API function
  // This function returns the last received packet's RSSI
  xbee802.getRSSI();
  
  // check AT flag  
  if( !xbee802.error_AT )
  {      
    USB.print(F("getRSSI(dBm): ")); 
    
    //get rssi from getRSSI function and make conversion
    rssi=xbee802.valueRSSI[0];
    rssi*=-1;  
    USB.println(rssi,DEC);
  }
  USB.println();
  
  
  delay(5000);
}







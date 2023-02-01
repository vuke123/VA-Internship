/*
    ------ [ZB_01b] - coordinator resets network --------

    Explanation: This program shows how to set reset a network
    from the coordinator. After reseting the network a new PAN ID
    is set.

    Copyright (C) 2016 Libelium Comunicaciones Distribuidas S.L.
    http://www.libelium.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    Version:           0.2
    Design:            David Gascón
    Implementation:    Yuri Carmona
*/

#include <WaspXBeeZB.h>

/**************************************************
  IMPORTANT: Beware of the channel selected by the
  coordinator because routers are not able to scan
  both 0x19 and 0x1A channels
**************************************************/


// coordinator's 64-bit PAN ID to set
//////////////////////////////////////////////////////////////////
uint8_t  PANID[8] = { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88};
//////////////////////////////////////////////////////////////////


void setup()
{
  // init USB
  USB.ON();
  USB.println(F("ZB_01b example"));


  ///////////////////////////////////////////////
  // Init XBee
  ///////////////////////////////////////////////
  xbeeZB.ON();

  
  ///////////////////////////////////////////////
  // 1. Set Coordinator Enable
  ///////////////////////////////////////////////

  /*************************************
    WARNING: Only XBee ZigBee S2C and
    XBee ZigBee S2D are able to use
    this function properly
  ************************************/
  xbeeZB.setCoordinator(ENABLED);

  // check at command flag
  if (xbeeZB.error_AT == 0)
  {
    USB.println(F("1. Coordinator Enabled OK"));
  }
  else
  {
    USB.println(F("1. Error while enabling Coordinator mode"));
  }


  //////////////////////////////////////////////////
  // 2. Reset network before setting the new PAN ID
  //////////////////////////////////////////////////

  // 2.1. reset network
  xbeeZB.resetNetwork(0x01);

  // 2.2. check AT command flag
  if (xbeeZB.error_AT == 0)
  {
    USB.println(F("2. Reset network before setting the new PAN ID --> OK"));
  }
  else
  {
    USB.println(F("2. Error while resetting network"));
  }

  // 2.3. wait for the reset
  delay(5000);


  //////////////////////////////////////////////////
  // 3. set the new PAN ID
  //////////////////////////////////////////////////

  // 3.1. set PANID
  xbeeZB.setPAN(PANID);

  // 3.2. check AT command flag
  if (xbeeZB.error_AT == 0)
  {
    USB.println(F("3. PANID set OK"));
  }
  else
  {
    USB.println(F("3. Error while setting PANID"));
  }

  // 3.3. save values
  xbeeZB.writeValues();

  // 3.4. wait for the module to set the parameters
  delay(10000);
  USB.println();

}


void loop()
{
  //////////////////////////////////////////////////
  // 3. get network parameters
  //////////////////////////////////////////////////

  xbeeZB.getOperating16PAN();
  xbeeZB.getOperating64PAN();
  xbeeZB.getChannel();

  USB.print(F("operating 16-bit PAN: "));
  USB.printHex(xbeeZB.operating16PAN[0]);
  USB.printHex(xbeeZB.operating16PAN[1]);
  USB.println();

  USB.print(F("operating 64-bit PAN: "));
  USB.printHex(xbeeZB.operating64PAN[0]);
  USB.printHex(xbeeZB.operating64PAN[1]);
  USB.printHex(xbeeZB.operating64PAN[2]);
  USB.printHex(xbeeZB.operating64PAN[3]);
  USB.printHex(xbeeZB.operating64PAN[4]);
  USB.printHex(xbeeZB.operating64PAN[5]);
  USB.printHex(xbeeZB.operating64PAN[6]);
  USB.printHex(xbeeZB.operating64PAN[7]);
  USB.println();

  USB.print(F("channel: "));
  USB.printHex(xbeeZB.channel);
  USB.println();

  delay(3000);
}








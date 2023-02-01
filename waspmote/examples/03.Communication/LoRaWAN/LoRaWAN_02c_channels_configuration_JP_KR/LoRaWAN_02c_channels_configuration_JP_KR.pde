/*
    ------ LoRaWAN Code Example --------

    Explanation: TThis example shows how to configure the channels settings.

    Copyright (C) 2019 Libelium Comunicaciones Distribuidas S.L.
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

    Version:           3.0
    Design:            David Gascon
    Implementation:    Luismi Marti
*/

#include <WaspLoRaWAN.h>

//////////////////////////////////////////////
uint8_t socket = SOCKET0;
//////////////////////////////////////////////

// variable
uint8_t error;

/*
  JAPAN = BAND_JP923
  KOREA = BAND_KR920
*/
uint8_t band = BAND_JP923;


void setup()
{
  USB.ON();
  USB.println(F("LoRaWAN example - LoRaWAN JP/KR Channels Configuration"));

  //////////////////////////////////////////////
  // 1. switch on
  //////////////////////////////////////////////

  error = LoRaWAN.ON(socket);

  // Check status
  if ( error == 0 )
  {
    USB.println(F("1. Switch ON OK"));
  }
  else
  {
    USB.print(F("1. Switch ON error = "));
    USB.println(error, DEC);
  }

  if (LoRaWAN._version != ABZ_MODULE)
  {
    USB.println(F("\n---------------------------------------------------------------"));
    USB.println(F("Module version error"));
    USB.println(F("This is not a JP/KR LoRaWAN module"));
    USB.println(F("Please open the example 01a or 01b related to your module"));
    USB.println(F("\n---------------------------------------------------------------"));
    while (1);
  }

  //////////////////////////////////////////////
  // 2. Configure region and channels
  //////////////////////////////////////////////

  // Set band
  error = LoRaWAN.setBand(band);

  // Check status
  if ( error == 0 )
  {
    USB.println(F("2.1. Set band OK"));
  }
  else
  {
    USB.print(F("2.1. Set band error = "));
    USB.println(error, DEC);
  }

  // Get band
  error = LoRaWAN.getBand();

  // Check status
  if ( error == 0 )
  {
    USB.print(F("2.2. Get band OK. "));
    USB.print(F("Band: "));
    USB.print(LoRaWAN._bandABZ, DEC);
  }
  else
  {
    USB.print(F("2.2. Get band error = "));
    USB.println(error, DEC);
  }

  switch (LoRaWAN._bandABZ)
  {

    case BAND_JP923:
      //////////////////////////////////////////////
      // 3. Configure LoRaWAN JP channels
      //////////////////////////////////////////////

      USB.println(F(" - Region is AS923 JAPAN"));

      error = LoRaWAN.setChannelFreq(0, 923200000);
      if ( error == 0 )
      {
        USB.print(F("3.0. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 0: "));
        USB.println(LoRaWAN._freq[0]);
      }
      else
      {
        USB.print(F("3.0. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      error = LoRaWAN.setChannelFreq(1, 923400000);
      if ( error == 0 )
      {
        USB.print(F("3.1. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 1: "));
        USB.println(LoRaWAN._freq[1]);
      }
      else
      {
        USB.print(F("3.1. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      error = LoRaWAN.setChannelFreq(2, 923600000);
      if ( error == 0 )
      {
        USB.print(F("3.2. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 2: "));
        USB.println(LoRaWAN._freq[2]);
      }
      else
      {
        USB.print(F("3.2. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      error = LoRaWAN.setChannelFreq(3, 923800000);
      if ( error == 0 )
      {
        USB.print(F("3.3. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 3: "));
        USB.println(LoRaWAN._freq[3]);
      }
      else
      {
        USB.print(F("3.3. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      error = LoRaWAN.setChannelFreq(4, 924000000);
      if ( error == 0 )
      {
        USB.print(F("3.4. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 4: "));
        USB.println(LoRaWAN._freq[4]);
      }
      else
      {
        USB.print(F("3.4. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      error = LoRaWAN.setChannelFreq(5, 924200000);
      if ( error == 0 )
      {
        USB.print(F("3.5. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 5: "));
        USB.println(LoRaWAN._freq[5]);
      }
      else
      {
        USB.print(F("3.5. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      error = LoRaWAN.setChannelFreq(6, 924400000);
      if ( error == 0 )
      {
        USB.print(F("3.6. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 6: "));
        USB.println(LoRaWAN._freq[6]);
      }
      else
      {
        USB.print(F("3.6. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      break;


    case BAND_KR920:
      //////////////////////////////////////////////
      // 3. Configure LoRaWAN KR channels
      //////////////////////////////////////////////

      USB.println(F(" - Region is KR920"));

      error = LoRaWAN.setChannelFreq(0, 922100000);
      if ( error == 0 )
      {
        USB.print(F("3.0. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 0: "));
        USB.println(LoRaWAN._freq[0]);
      }
      else
      {
        USB.print(F("3.0. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      error = LoRaWAN.setChannelFreq(1, 922300000);
      if ( error == 0 )
      {
        USB.print(F("3.1. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 1: "));
        USB.println(LoRaWAN._freq[1]);
      }
      else
      {
        USB.print(F("3.1. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      error = LoRaWAN.setChannelFreq(2, 922500000);
      if ( error == 0 )
      {
        USB.print(F("3.2. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 2: "));
        USB.println(LoRaWAN._freq[2]);
      }
      else
      {
        USB.print(F("3.2. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      error = LoRaWAN.setChannelFreq(3, 921900000);
      if ( error == 0 )
      {
        USB.print(F("3.3. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 3: "));
        USB.println(LoRaWAN._freq[3]);
      }
      else
      {
        USB.print(F("3.3. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      error = LoRaWAN.setChannelFreq(4, 922700000);
      if ( error == 0 )
      {
        USB.print(F("3.4. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 4: "));
        USB.println(LoRaWAN._freq[4]);
      }
      else
      {
        USB.print(F("3.4. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      error = LoRaWAN.setChannelFreq(5, 922900000);
      if ( error == 0 )
      {
        USB.print(F("3.5. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 5: "));
        USB.println(LoRaWAN._freq[5]);
      }
      else
      {
        USB.print(F("3.5. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      error = LoRaWAN.setChannelFreq(6, 923100000);
      if ( error == 0 )
      {
        USB.print(F("3.6. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 6: "));
        USB.println(LoRaWAN._freq[6]);
      }
      else
      {
        USB.print(F("3.6. Set channel frequency error = "));
        USB.println(error, DEC);
      }

      error = LoRaWAN.setChannelFreq(7, 923300000);
      if ( error == 0 )
      {
        USB.print(F("3.7. Set channel frequency OK. "));
        USB.print(F("Frequency in channel 7: "));
        USB.println(LoRaWAN._freq[7]);
      }
      else
      {
        USB.print(F("3.7. Set channel frequency error = "));
        USB.println(error, DEC);
      }


      break;

  }

  //////////////////////////////////////////////
  // 4. Set Data rate range for specific channel
  //////////////////////////////////////////////

  error = LoRaWAN.setChannelDRRange(3, 0, 2);

  // Check status
  if ( error == 0 )
  {
    USB.print(F("4. Data Rate range set OK. "));
    USB.print(F("Data Rate min:"));
    USB.print(LoRaWAN._drrMin[3], DEC);
    USB.print(F(". Data Rate max:"));
    USB.println(LoRaWAN._drrMax[3], DEC);
  }
  else
  {
    USB.print(F("4. Data rate range set error = "));
    USB.println(error, DEC);
  }


  ///////////////////////////////////////////////////////////
  // show configuration for all channels available
  ///////////////////////////////////////////////////////////

    USB.println(F("\n----------------------------"));

    for ( int i = 0; i < 16; i++)
    {
      LoRaWAN.getChannelFreq(i);
      LoRaWAN.getChannelDRRange(i);

      USB.print(F("Channel: "));
      USB.println(i);
      USB.print(F("  Freq: "));
      USB.println(LoRaWAN._freq[i]);
      USB.print(F("  DR min: "));
      USB.println(LoRaWAN._drrMin[i], DEC);
      USB.print(F("  DR max: "));
      USB.println(LoRaWAN._drrMax[i], DEC);
      USB.println(F("----------------------------"));
    }

}


void loop()
{
  // do nothing
}

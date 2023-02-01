/*
    ------------  [SCP_v30_07] - Luxes sensor  --------------

    Explanation: This is the basic code to manage and read the
    luxes sensor.Cycle time: 30 seconds

    Copyright (C) 2017 Libelium Comunicaciones Distribuidas S.L.
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

    Version:		    3.1
    Design:         David Gascón
    Implementation: Alejandro Gállego
*/

#include <WaspSensorCities_PRO.h>

/*
   Waspmote OEM. Possibilities for this sensor:
    - SOCKET_1
    - SOCKET_2
    - SOCKET_3
    - SOCKET_4
    - SOCKET_5
   P&S! Possibilities for this sensor:
    - SOCKET_A
    - SOCKET_B
    - SOCKET_C
    - SOCKET_E
    - SOCKET_F
*/
luxesCitiesSensor  luxes(SOCKET_E);

// variable
uint32_t luminosity;


void setup()
{
  USB.println(F("Luxes sensor example"));
}


void loop()
{
  ///////////////////////////////////////////
  // 1. Turn on the sensor
  ///////////////////////////////////////////
  luxes.ON();


  ///////////////////////////////////////////
  // 2. Read sensor
  ///////////////////////////////////////////

  // Read the luminosity sensor
  luminosity = luxes.getLuminosity();

  // And print the value via USB
  USB.println(F("***************************************"));
  USB.print(F("Luminosity: "));
  USB.print(luminosity);
  USB.println(F(" luxes"));


  ///////////////////////////////////////////
  // 3. Power off sensor
  ///////////////////////////////////////////
  luxes.OFF();


  ///////////////////////////////////////////
  // 4. Sleep
  ///////////////////////////////////////////

  // Go to deepsleep
  // After 10 seconds, Waspmote wakes up thanks to the RTC Alarm
  USB.println(F("Enter deep sleep mode"));
  PWR.deepSleep("00:00:00:10", RTC_OFFSET, RTC_ALM1_MODE1, ALL_OFF);
  USB.ON();
  USB.println(F("wake up!!"));

}

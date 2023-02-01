/*  
 *  --[Ev_v30_05] - Reading Liquid Presense
 *  
 *  Explanation: This example shows how the Liquid Presence sensor works.
 *  
 *  Copyright (C) 2017 Libelium Comunicaciones Distribuidas S.L. 
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
 *  Design:            David Gascón 
 *  Implementation:    Carlos Bello
 */

#include <WaspSensorEvent_v30.h>

/*
 * Define object for sensor. Choose board socket. 
 * Waspmote OEM. Possibilities for this sensor:
 *  - SOCKET_1 
 *  - SOCKET_2
 *  - SOCKET_3
 *  - SOCKET_4
 *  - SOCKET_6
 * P&S! Possibilities for this sensor:
 *  - SOCKET_A
 *  - SOCKET_C
 *  - SOCKET_D
 *  - SOCKET_E
 */
liquidPresenceClass liquidPresence(SOCKET_E);

#define DRY 0.0
#define WET 0.2
#define VERY_WET 1.0

uint8_t value;
float voltage;
float resistance;

void setup() 
{
  // Turn on the USB and print a start message
  USB.ON();
  USB.println(F("Start program"));
  
  // Turn on the sensor board
  Events.ON();
  
  // Enable interruptions from the board
  Events.attachInt();
}


void loop() 
{
  ///////////////////////////////////////
  // 1. Read the sensor level 
  ///////////////////////////////////////

  // Read the sensor level
  value = liquidPresence.readliquidPresence();

  // Print the info
  if (value == 1)
  {  
    USB.println(F("Sensor output: Water detected!"));
  }
  else
  {
    USB.println(F("Sensor output: Water not detected"));    
  }

  // Read the sensor level
  voltage = liquidPresence.readVoltage();

  // Print the info
  USB.print(F("Voltage: "));
  USB.printFloat(voltage, 3);
  USB.println(" Volts");

  // Read the sensor resistance
  resistance = liquidPresence.readResistance(voltage);

  // Print the info
  USB.print(F("Resistance: "));
  USB.printFloat(resistance, 3);
  USB.println(" kohms");

  
  // Print the info
  if ((DRY <= voltage) && (voltage <= WET))
  {  
    USB.println(F("Voltage output: Water not detected"));
  }
  else if ((WET <= voltage) && (voltage <= VERY_WET))
  {
    USB.println(F("Voltage output: Water detected!"));    
  }
  else if (voltage >= VERY_WET)
  {
    USB.println(F("Voltage output: A lot of water detected!")); 
  }


  ///////////////////////////////////////
  // 2. Go to deep sleep mode
  ///////////////////////////////////////
  USB.println(F("enter deep sleep"));
  PWR.deepSleep("00:00:00:10", RTC_OFFSET, RTC_ALM1_MODE1, SENSOR_ON);
  USB.ON();
  USB.println(F("wake up\n"));


  ///////////////////////////////////////
  // 3. Check Interruption Flags
  ///////////////////////////////////////
   
  // 3.1. Check interruption from RTC alarm
  if (intFlag & RTC_INT)
  {   
    USB.println(F("-----------------------------"));
    USB.println(F("RTC INT captured"));
    USB.println(F("-----------------------------\n"));
  
    // clear flag
    intFlag &= ~(RTC_INT);
  }  
  
  // 3.2. Check interruption from Sensor Board
  if (intFlag & SENS_INT)
  {
    // Disable interruptions from the board
    Events.detachInt();
    
    // Load the interruption flag
    Events.loadInt();  
    
    // In case the interruption came from liquid presence
    if((liquidPresence.getInt()))
    {
      USB.println(F("-----------------------------------"));
      USB.println(F("Interruption from Liquid Presence"));
      USB.println(F("-----------------------------------\n"));
    }
      
    // Clean the interruption flag
    intFlag &= ~(SENS_INT);
    
    // Enable interruptions from the board
    Events.attachInt();
  }

}


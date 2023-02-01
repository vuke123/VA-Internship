/*  
 *  ------  GPRS_SIM908_02 - Changing power mode from ON to RF_OFF  -------- 
 *  
 *  Explanation: This example shows how power off the RF circuits 
 *  from GPRS_SIM908 module
 *  
 *  Copyright (C) 2014 Libelium Comunicaciones Distribuidas S.L. 
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
 *  Implementation:    Alejandro Gállego
 */

#include "WaspGPRS_SIM908.h"
int answer;

void setup()
{
    // setup for Serial port over USB:
    USB.ON();
    USB.println(F("USB port started..."));

    // 1. activates the GPRS_SIM908 module:
    answer = GPRS_SIM908.ON();
    if ((answer == 1) || (answer == -3))
    {
        USB.println(F("GPRS_SIM908 module ready..."));
             
        // 2. changes the power mode from ON to OFF:
        USB.println(F("Power off the RF circuits of GPRS_SIM908 module")); 
        
        if (GPRS_SIM908.setMode(GPRS_PRO_RF_OFF) == 1)
        {
            USB.println(F("Mode changed succesfully"));
        }
        else
        {
            USB.println(F("Error changing power mode"));
        }
    }
    else
    {
        USB.println(F("GPRS_SIM908 module NOT ready..."));
    }
}

void loop()
{
}

/*  
 *  ------  GPRS_07 - Making call  -------- 
 *  
 *  Explanation: This example shows how to make a call,
 *  with a duration of 20 seconds.
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
 *  Version:           0.4
 *  Design:            David Gascón 
 *  Implementation:    Alejandro Gállego
 */

#include "WaspGPRS_Pro.h"
int answer;

void setup()
{
    // setup for Serial port over USB:
    USB.ON();
    USB.println(F("USB port started..."));

    // 1. activates the GPRS_SIM908 module:
    answer = GPRS_Pro.ON(); 
    if ((answer == 1) || (answer == -3))
    {
        USB.println(F("GPRS_Pro module ready..."));
        
        // 2. sets pin code
        USB.println(F("Setting PIN code..."));
        // **** must be substituted by the SIM code
        if (GPRS_Pro.setPIN("****") == 1) 
        {
            USB.println(F("PIN code accepted"));
        }
        else
        {
            USB.println(F("PIN code incorrect"));
        }
        
        // 3. waits for connection to the network
        answer = GPRS_Pro.check(180);    
        if (answer == 1)
        {
            USB.println(F("GPRS_Pro module connected to the network..."));
            
            USB.print(F("Making call..."));
    
            // ********* must be substituted by the phone number
            // 4. makes a call
            if (GPRS_Pro.makeCall("*********") == 1)
            {
                USB.println(F("done"));
                delay(20000); // waits 20 seconds and then hang up the call
                GPRS_Pro.hangUp();        
            }
            else
            {
                USB.println(F("\nError making the call"));
            }
        }
        else
        {
            USB.println(F("GPRS_Pro module cannot connect to the network..."));
        }
    
    }
    else
    {
        USB.println(F("GPRS_Pro module NOT ready..."));
    }
    
    GPRS_Pro.OFF();

}

void loop()
{
   
}



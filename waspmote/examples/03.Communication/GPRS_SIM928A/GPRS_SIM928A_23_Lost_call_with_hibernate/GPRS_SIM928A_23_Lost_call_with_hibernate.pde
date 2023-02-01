/*  
 *  ------  GPRS_SIM928A_23 - Lost call with hibernate  -------- 
 *  
 *  Explanation: This example shows how make Hibernate with Waspmote_PRO and 
 *  GPRS_SIM928A. Waspmote does a lost call when wakes up.
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
 *  Version:           0.1
 *  Design:            David Gascón 
 *  Implementation:    Alejandro Gállego
 */

#include "WaspGPRS_SIM928A.h"

int answer;

void setup() 
{ 
    // 1. checks if we come from a normal reset or an hibernate reset 
    PWR.ifHibernate(); 

} 

void loop() 
{ 
    // 2. if Hibernate has been captured, execute the associated function 
    if( intFlag & HIB_INT ) 
    { 
        Utils.blinkLEDs(1000);	 
        Utils.blinkLEDs(1000);  
        intFlag &= ~(HIB_INT); 

        USB.ON();
        USB.println("USB started");

        // 3. clears the RTC alarm flag to allow the connection with the GPRS_Pro
        RTC.ON();
        RTC.clearAlarmFlag();
        RTC.OFF();

        // 4. activates the GPRS_SIM928A module:
        answer = GPRS_SIM928A.ON(); 
        if ((answer == 1) || (answer == -3))
        {
            USB.println("GPRS_SIM928A module ready..."); 

            // 5. sets pin code:
            USB.println(F("Setting PIN code..."));
            // **** must be substituted by the SIM code
            if (GPRS_SIM928A.setPIN("****") == 1) 
            {
                USB.println(F("PIN code accepted"));
            }
            else
            {
                USB.println(F("PIN code incorrect"));
            }

            // 6. waits for connection to the network:
            answer = GPRS_SIM928A.check(180);    
            if (answer == 1)
            {
                USB.println("GPRS SIM908 connected to the network"); 

                // 7. makes a lost call
                GPRS_SIM928A.makeLostCall("*********", 15);
            }
            else
            {
                USB.println(F("GPRS SIM908 module cannot connect to the network"));     
            }
        }
        else
        {
            USB.println(F("GPRS_SIM928A module not ready"));    
        }

        // 8. powers off the GPRS_SIM928A
        GPRS_SIM928A.OFF(); 
    } 

    // 9. set Waspmote to Hibernate, waking up after 30 seconds 
    PWR.hibernate("00:00:00:30",RTC_OFFSET,RTC_ALM1_MODE2); 
} 




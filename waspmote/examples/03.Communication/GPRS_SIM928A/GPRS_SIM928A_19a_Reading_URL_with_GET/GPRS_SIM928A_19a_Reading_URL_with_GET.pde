/*  
 *  -------------- GPRS_SIM928A_19a - Reading URL with GET -------------- 
 *  
 *  Explanation: This example shows how to read an URL with a GET request.
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
 *  Version:           1.1
 *  Design:            David Gascón 
 *  Implementation:    Alejandro Gállego
 */

#include "WaspGPRS_SIM928A.h"

char apn[] = "apn";
char login[] = "login";
char password[] = "password";

int answer;
char url[150];
unsigned int counter = 0;


void setup()
{  
    // setup for Serial port over USB:
    USB.ON();
    USB.println(F("USB port started..."));

    USB.println(F("---******************************************************************************---"));
    USB.println(F("GET request to the libelium's test url..."));
    USB.println(F("You can use this php to test the HTTP connection of the module."));
    USB.println(F("The php returns the parameters that the user sends with the URL."));
    USB.println(F("In this case the loop counter (counter) and the battery level."));
    USB.println(F("The syntax to add parameters is below:"));
    USB.println(F("getpost_frame_parser.php?parameter1=value1&parameter2=value2&...&last_parameter=last_value"));
    USB.println(F("---******************************************************************************---"));

    // 1. sets operator parameters
    GPRS_SIM928A.set_APN(apn, login, password);
    // And shows them
    GPRS_SIM928A.show_APN();
    USB.println(F("---******************************************************************************---"));

}

void loop()
{
    // 2. activate the GPRS_SIM928A module:
    answer = GPRS_SIM928A.ON(); 
    if ((answer == 1) || (answer == -3))
    { 
        USB.println(F("GPRS_SIM928A module ready..."));

        // 3. set pin code:
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

        // 4. wait for connection to the network:
        answer = GPRS_SIM928A.check(180);    
        if (answer == 1)
        {             
            USB.println(F("GPRS_SIM928A module connected to the network..."));

            // 5. configures GPRS connection for HTTP or FTP applications:
            answer = GPRS_SIM928A.configureGPRS_HTTP_FTP(1);
            if (answer == 1)
            {
                USB.println(F("Get the URL with GET request..."));          
                RTC.ON();

                sprintf(url, "http://test.libelium.com/getpost_frame_parser.php?counter=%d&battery=%u", counter, PWR.getBatteryLevel());

                USB.println(F("-------------------------------------------"));
                USB.println(url);                
                USB.println(F("-------------------------------------------"));

                // 6. gets URL from the solicited URL
                answer = GPRS_SIM928A.readURL(url, 1);

                // check answer
                if ( answer == 1)
                {
                    USB.println(F("Done"));  
                    USB.println(F("The server has replied with:")); 
                    USB.println(GPRS_SIM928A.buffer_GPRS);
                }
                else if (answer < -9)
                {
                    USB.print(F("Failed. Error code: "));
                    USB.println(answer, DEC);
                    USB.print(F("CME error code: "));
                    USB.println(GPRS_SIM928A.CME_CMS_code, DEC);
                }
                else 
                {
                    USB.print(F("Failed. Error code: "));
                    USB.println(answer, DEC);
                }

            }
            else
            {
                USB.println(F("Configuration 1 failed. Error code: "));
                USB.println(answer, DEC);
            }
        }
        else
        {
            USB.println(F("GPRS_SIM928A module cannot connect to the network"));     
        }
    }
    else
    {
        USB.println(F("GPRS_SIM928A module not ready"));    
    }
    
    // 7. powers off the GPRS_SIM928A module
    GPRS_SIM928A.OFF(); 

    counter++;

    delay(5000);

}






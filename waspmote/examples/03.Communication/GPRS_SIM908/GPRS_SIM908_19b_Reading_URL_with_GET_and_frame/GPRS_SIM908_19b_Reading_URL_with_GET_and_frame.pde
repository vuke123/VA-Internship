/*  
 *  -------------- GPRS_SIM908_19b - Reading URL with GET and frame -------------- 
 *  
 *  Explanation: This example shows how to read an URL with a GET request 
 *  including a frame into the GET request.
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
 *  Version:           1.0
 *  Design:            David Gascón 
 *  Implementation:    Alejandro Gállego
 */

#include <WaspFrame.h>
#include "WaspGPRS_SIM908.h"

char apn[] = "apn";
char login[] = "login";
char password[] = "password";

int answer;
unsigned int counter = 0;

////////////////////////////////////////////////////////////////////////
#define URL "http://pruebas.libelium.com/getpost_frame_parser.php?"
////////////////////////////////////////////////////////////////////////


void setup()
{
    // setup for Serial port over USB:
    USB.ON();
    USB.println(F("USB port started..."));

    USB.println(F("---******************************************************************************---"));
    USB.println(F("GET method to the libelium's test url with frame..."));
    USB.println(F("You can use this php to test the HTTP connection of the module."));
    USB.println(F("The php returns the parameters that the user sends with the URL."));
    USB.println(F("In this case the RTC time and the battery level."));
    USB.println(F("---******************************************************************************---"));

    // Sets operator parameters
    GPRS_SIM908.set_APN(apn, login, password);
    // And shows them
    GPRS_SIM908.show_APN();
    USB.println(F("---******************************************************************************---"));
}


void loop()
{

    // 2. activate the GPRS_SIM908 module:
    answer = GPRS_SIM908.ON(); 
    if ((answer == 1) || (answer == -3))
    { 
        USB.println(F("GPRS_SIM908 module ready..."));

        // 3. set pin code:
        USB.println(F("Setting PIN code..."));
        // **** must be substituted by the SIM code
        if (GPRS_SIM908.setPIN("****") == 1) 
        {
            USB.println(F("PIN code accepted"));
        }
        else
        {
            USB.println(F("PIN code incorrect"));
        }

        // 4.wait for connection to the network:
        answer = GPRS_SIM908.check(180);    
        if (answer == 1)
        {

            USB.println(F("GPRS_SIM908 module connected to the network..."));

            // 5. configure GPRS connection for HTTP or FTP applications:
            answer = GPRS_SIM908.configureGPRS_HTTP_FTP(1);
            if (answer == 1)
            {
                USB.println(F("Get the URL with GET request and frame..."));                

                // switch on RTC
                RTC.ON();

                // Create new frame (ASCII)
                frame.createFrame(ASCII,"Waspmote_PRO"); 
                // set frame fields (Time from RTC)
                frame.addSensor(SENSOR_TIME, RTC.getTime());
                // set frame fields (Battery sensor - uint8_t)
                frame.addSensor(SENSOR_BAT, PWR.getBatteryLevel());
                // show Frame
                frame.showFrame();                

                // 6. get URL from the solicited URL
                answer = GPRS_SIM908.readURL(URL, frame.buffer, frame.length, 1, GET);
                
                // check answer
                if ( answer == 1)
                {
                    USB.println(F("Done"));  
                    USB.println(F("The server has replied with:")); 
                    USB.println(GPRS_SIM908.buffer_GPRS);
                }
                else if (answer < -9)
                {
                    USB.print(F("Failed. Error code: "));
                    USB.println(answer, DEC);
                    USB.print(F("CME error code: "));
                    USB.println(GPRS_SIM908.CME_CMS_code, DEC);
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
            USB.println(F("GPRS_SIM908 module cannot connect to the network"));     
        }
    }
    else
    {
        USB.println(F("GPRS_SIM908 module not ready"));    
    }

    // 7. powers off the GPRS_SIM908 module
    GPRS_SIM908.OFF(); 

    delay(5000);
}






/*  
 *  ------  GPRS_SIM928A_11 - Non transparent TCP client in single connection  -------- 
 *  
 *  Explanation: This example shows how to create a non-transparent TCP client 
 *  in single connection
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

#include "WaspGPRS_SIM928A.h"
#include <WaspFrame.h>

char apn[] = "apn";
char login[] = "login";
char password[] = "password";

char test_string[]="Test string from Waspmote!\r\n";
int8_t answer;

void setup()
{
    USB.println(F("**************************"));
    // 1. sets operator parameters
    GPRS_SIM928A.set_APN(apn, login, password);
    // And shows them
    GPRS_SIM928A.show_APN();
    USB.println(F("**************************"));
}

void loop()
{

    // setup for Serial port over USB:
    USB.ON();
    USB.println(F("USB port started..."));
    USB.println(F("**************************"));

    // 2. activates the GPRS_SIM928A module:
    answer = GPRS_SIM928A.ON(); 
    if ((answer == 1) || (answer == -3))
    {
        USB.println(F("GPRS_SIM928A module ready..."));

        // 3. sets pin code:
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

        // 4. waits for connection to the network:
        answer = GPRS_SIM928A.check(180);    
        if (answer == 1)
        {
            USB.println(F("GPRS_SIM928A module connected to the network..."));

            // 5. configures IP connection
            USB.print(F("Setting connection..."));
            answer = GPRS_SIM928A.configureGPRS_TCP_UDP(SINGLE_CONNECTION, NON_TRANSPARENT);
            if (answer == 1)
            {
                USB.println(F("Done"));

                // if configuration is success shows the IP address
                USB.print(F("Configuration success. IP address: ")); 
                USB.println(GPRS_SIM928A.IP_dir);
                USB.print(F("Opening TCP socket..."));  

                // 6. create a TCP socket
                // “IP” and “port” must be substituted by the IP address and the port
                answer = GPRS_SIM928A.createSocket(TCP_CLIENT, "IP", "port");
                if (answer == 1)
                {
                    USB.println(F("Conected"));


                    //************************************************
                    //             Send a string of text
                    //************************************************

                    USB.print(F("Sending test string..."));
                    // 7. sending 'test_string'
                    if (GPRS_SIM928A.sendData(test_string) == 1) 
                    {
                        USB.println(F("Done"));
                    }
                    else
                    {
                        USB.println(F("Fail"));
                    }


                    //************************************************
                    //             Send a ASCII frame
                    //************************************************

                    // create new frame (ASCII)
                    frame.createFrame(ASCII,"Waspmote_Pro"); 
                    // add frame fields
                    frame.addSensor(SENSOR_STR, test_string); 
                    frame.addSensor(SENSOR_BAT, PWR.getBatteryLevel());

                    USB.print(F("Sending a frame...")); 
                    // 8. sending a frame
                    if (GPRS_SIM928A.sendData(frame.buffer, frame.length) == 1) 
                    {
                        USB.println(F("Done"));
                    }
                    else
                    {
                        USB.println(F("Fail"));
                    }


                    USB.print(F("Closing TCP socket..."));  
                    // 9. closes socket
                    if (GPRS_SIM928A.closeSocket() == 1) 
                    {
                        USB.println(F("Done"));
                    }
                    else
                    {
                        USB.println(F("Fail"));
                    }
                }
                else if (answer == -2)
                {
                    USB.print(F("Connection failed. Error code: "));
                    USB.println(answer, DEC);
                    USB.print(F("CME error code: "));
                    USB.println(GPRS_SIM928A.CME_CMS_code, DEC);
                }
                else 
                {
                    USB.print(F("Connection failed. Error code: "));
                    USB.println(answer, DEC);
                }           
            }
            else if (answer < -14)
            {
                USB.print(F("Configuration failed. Error code: "));
                USB.println(answer, DEC);
                USB.print(F("CME error code: "));
                USB.println(GPRS_SIM928A.CME_CMS_code, DEC);
            }
            else 
            {
                USB.print(F("Configuration failed. Error code: "));
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

    // 10. powers off the GPRS_SIM928A module
    GPRS_SIM928A.OFF(); 

    USB.println(F("Sleeping..."));

    // 11. sleeps one hour
    PWR.deepSleep("00:01:00:00", RTC_OFFSET, RTC_ALM1_MODE1, ALL_OFF);

}





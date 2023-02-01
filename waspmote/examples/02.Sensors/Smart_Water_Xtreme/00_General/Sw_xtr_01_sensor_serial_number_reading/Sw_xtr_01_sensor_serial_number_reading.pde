/*
    ----------- [Sw_xtr_01] - Serial number reading --------------------

    Explanation: Basic example that turns on a sensor, reads serial 
    number and turn off the sensor. Sensor serial number is stored in the 
    corresponding class variable and printed by the serial monitor.

    Measured parameters:
      - Sensor serial number

    Copyright (C) 2018 Libelium Comunicaciones Distribuidas S.L.
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
    Design:            David Gascón
    Implementation:    J.Siscart, V.Boria
*/

#include <WaspSensorXtr.h>


  //******************************************************
  //          SELECT THE RIGHT SOCKET & SENSOR
  //******************************************************

  /* 
    Possible sockets are:
    - XTR_SOCKET_A
    - XTR_SOCKET_B
    - XTR_SOCKET_C
    - XTR_SOCKET_D
    - XTR_SOCKET_E

    Example: a CTZN sensor on socket A
    Aqualabo_CTZN mySensor(XTR_SOCKET_A);

  */

//   [Sensor Class] [Sensor Name] [Selected socket]
//Uncomment the sensor that you want to read the serial number
Aqualabo_OPTOD mySensor(XTR_SOCKET_A);
//Aqualabo_PHEHT mySensor(XTR_SOCKET_A);
//Aqualabo_C4E mySensor(XTR_SOCKET_A);
//Aqualabo_NTU mySensor(XTR_SOCKET_A);
//Aqualabo_CTZN mySensor(XTR_SOCKET_A);
//Aqualabo_MES5 mySensor(XTR_SOCKET_A);

void setup()
{
  USB.println(F("Sensor serial number reading example"));
}

void loop()
{
  // 1. Turn ON the sensor
  mySensor.ON();
  
  // 2. Read the sensor
  /*
    Note: read() function does not directly return sensor values.
    They are stored in the class vector variables defined for that purpose.
  */
  mySensor.readSerialNumber();
  
  // 3. Turn off the sensor
  mySensor.OFF();

  // 4. Print information
  USB.println(F("---------------------------"));
  USB.print(F("Sensor serial number: "));
  USB.println(mySensor.sensorOPTOD.sensorSerialNumber);
  //USB.println(mySensor.sensorPHEHT.sensorSerialNumber);
  //USB.println(mySensor.sensorC4E.sensorSerialNumber);
  //USB.println(mySensor.sensorNTU.sensorSerialNumber);
  //USB.println(mySensor.sensorCTZN.sensorSerialNumber);
  //USB.println(mySensor.sensorMES5.sensorSerialNumber);
  USB.println(F("---------------------------\n"));

  delay(5000);

}

/*
    ----------- [Sw_xtr_17] - C4E Temperature calibration --------------------

    Explanation: MENU ASSISTED CALIBRATION PROCESS for temperature of 
    C4E sensor

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

/*
  SELECT THE RIGHT SOCKET FOR EACH SENSOR.

  Possible sockets for this sensor are:
  - XTR_SOCKET_E (Only valid socket for init() or calibrating)
                           _________
                          |---------|
                          | A  B  C |
                          |_D__E__F_|


  Refer to the technical guide for information about possible combinations.
  www.libelium.com/downloads/documentation/smart_agriculture_xtreme_sensor_board.pdf
*/

//Uncomment the sensor that you want to read the serial number
Aqualabo_C4E mySensor(XTR_SOCKET_E);


uint8_t response = 0;


void setup()
{
  //Turn on the sensor
  mySensor.ON();

  response = mySensor.init();
  if (response)
  {
    USB.println(F("Error initializing the sensor. \r\nCheck the sensor is in Socket E and restart the code."));
    while (1);
  }
  
  //Run menu assisted calibration process via monitor serial
  mySensor.calibrationProcess(TEMPERATURE);
  
  //Turn off the sensor
  mySensor.OFF();
}

void loop()
{
  // Turn ON the sensor
  mySensor.ON();

  // Read the sensor
  /*
    Note: read() function does not directly return sensor values.
    They are stored in the class vector variables defined for that purpose.
    Values are available as a float value
  */
  mySensor.read();

  // Turn off the sensor
  mySensor.OFF();

  // 7. Print information
  USB.println(F("---------------------------"));
  USB.println(F("C4E"));
  USB.print(F("Temperature: "));
  USB.printFloat(mySensor.sensorC4E.temperature, 2);
  USB.println(F(" degrees Celsius"));
  USB.print(F("Conductivity: "));
  USB.printFloat(mySensor.sensorC4E.conductivity, 2);
  USB.println(F(" uS/cm"));
  USB.print(F("Salinity: "));
  USB.printFloat(mySensor.sensorC4E.salinity, 2);
  USB.println(F(" ppt"));
  USB.print(F("Total dissolved solids: "));
  USB.printFloat(mySensor.sensorC4E.totalDissolvedSolids, 2);
  USB.println(F(" ppm"));
  USB.println(F("---------------------------"));

  delay(5000);
}

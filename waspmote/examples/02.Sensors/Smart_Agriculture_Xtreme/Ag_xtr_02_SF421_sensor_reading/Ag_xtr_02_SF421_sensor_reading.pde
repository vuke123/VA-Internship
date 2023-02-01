/*
    ----------- [Ag_xtr_02] - SI-421 sensor reading --------------------

    Explanation: Basic example that turns on, reads and turn off the
    sensor. Measured parameters are stored in the corresponding class
    variables and printed by the serial monitor.

    Measured parameters:
      - Bud temperature
      - Leaf temperature

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

    Version:           3.1
    Design:            David Gascón
    Implementation:    J.Siscart, V.Boria
*/

#include <WaspSensorXtr.h>

/*
  SELECT THE RIGHT SOCKET FOR EACH SENSOR.

  Possible sockets for this sensor are:
  - XTR_SOCKET_A       _________
  - XTR_SOCKET_B      |---------|
  - XTR_SOCKET_C      | A  B  C |
  - XTR_SOCKET_D      |_D__E__F_|


  Example: a 5TM sensor on socket A will be
  [Sensor Class] [Sensor Name] [Selected socket]
  Decagon_5TM    mySensor      (XTR_SOCKET_A);

  Refer to the technical guide for information about possible combinations.
  www.libelium.com/downloads/documentation/smart_agriculture_xtreme_sensor_board.pdf
*/

//   [Sensor Class] [Sensor Name] [Selected socket]
Apogee_SF421 mySensor(XTR_SOCKET_A);

void setup()
{
  USB.println(F("SF-421 example"));
}

void loop()
{
  // 1. Turn ON the sensor
  mySensor.ON();

  // 2. Read the sensor
  /*
    Note: read() function does not directly return sensor values.
    They are stored in the class vector variables defined for that purpose.
    Values are available as a float value
  */
  mySensor.read();

  // 3. Turn off the sensor
  mySensor.OFF();

  // 4. Print information
  USB.println(F("---------------------------"));
  USB.println(F("SF-421"));
  USB.print(F("Bud Temperature: "));
  USB.printFloat(mySensor.sensorSF421.budTemperature, 3);
  USB.println(F(" degrees Celsius"));
  USB.print(F("Leaf Temperature: "));
  USB.printFloat(mySensor.sensorSF421.leafTemperature, 3);
  USB.println(F(" degrees Celsius"));
  USB.println(F("---------------------------\n"));

  delay(5000);

}

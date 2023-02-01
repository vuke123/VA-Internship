/*
    ----------- [Sw_xtr_33] - TSL2561 sensor reading --------------------

    Explanation: Basic example that turns on, reads and turn off the
    sensor. Measured parameters are stored in the corresponding class
    variables and printed by the serial monitor.

    Measured parameters:
      - Luminosity (Luxes)

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
  - XTR_SOCKET_A           _________
  - XTR_SOCKET_D          |---------|
                          | A  B  C |
                          |_D__E__F_|

  Refer to the technical guide for information about possible combinations.
  www.libelium.com/downloads/documentation/smart_agriculture_xtreme_sensor_board.pdf
*/

//   [Sensor Class] [Sensor Name] [Selected socket]
luxes mySensor(XTR_SOCKET_A);

void setup()
{
  USB.println(F("TSL2561 example"));


}

void loop()
{
  // 1. Turn ON the sensor
  mySensor.ON();

  // 2. Read the sensor. Store parameter in local variable
  uint32_t luminosity = mySensor.getLuminosity();

  // 3. Turn off the sensor
  mySensor.OFF();

  // 4. Print information
  USB.println(F("---------------------------"));
  USB.println(F("TSL2561"));
  USB.print(F("Luminosity: "));
  USB.print(luminosity);
  USB.println(F(" luxes"));
  USB.println(F("---------------------------\n"));
  delay(5000);

}

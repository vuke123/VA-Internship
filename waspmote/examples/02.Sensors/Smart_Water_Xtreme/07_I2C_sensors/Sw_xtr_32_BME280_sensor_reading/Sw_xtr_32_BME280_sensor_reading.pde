/*
    ----------- [Sw_xtr_32] - BME280 sensor reading --------------------

    Explanation: Basic example that turns on, reads and turn off the
    sensor. Measured parameters are stored in the corresponding class
    variables and printed by the serial monitor.

    Measured parameters:
      - Air temperature
      - Relative humidity
      - Air pressure


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
bme mySensor(XTR_SOCKET_A);

void setup()
{
  USB.println(F("BME280 example"));


}

void loop()
{
  // 1. Turn ON the sensor
  mySensor.ON();

  // 2. Read the sensor. Store parameters in local variables
  float temperature = mySensor.getTemperature();
  float humidity = mySensor.getHumidity();
  float pressure = mySensor.getPressure();

  // 3. Turn off the sensor
  mySensor.OFF();

  // 4. Print information
  USB.println(F("---------------------------"));
  USB.println(F("BME280"));
  USB.print(F("Air temperature: "));
  USB.printFloat(temperature, 2);
  USB.println(F(" degrees Celsius"));
  USB.print(F("Relative Humidity: "));
  USB.printFloat(humidity, 1);
  USB.println(F(" %RH"));
  USB.print(F("Air pressure: "));
  USB.printFloat(pressure, 2);
  USB.println(F(" Pa"));
  USB.println(F("---------------------------\n"));
  
  delay(5000);

}

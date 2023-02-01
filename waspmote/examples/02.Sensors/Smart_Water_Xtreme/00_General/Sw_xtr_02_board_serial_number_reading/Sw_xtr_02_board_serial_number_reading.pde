/*
    ----------- [Sw_xtr_02] - Board serial number reading --------------------

    Explanation: Basic example that reads the xtreme board serial number.
    Serial number is stored in the corresponding class variable and
    printed by the serial monitor.

    Measured parameters:
      - Smart Water Xtreme board serial number


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


void setup()
{
  if (SensorXtr.readBoardSerialNumber() == 1)
  {
    USB.print(F("Board serial number:"));

    USB.printHex(SensorXtr.boardSerialNumber[0]);
    USB.print(F("-"));
    USB.printHex(SensorXtr.boardSerialNumber[1]);
    USB.print(F("-"));
    USB.printHex(SensorXtr.boardSerialNumber[2]);
    USB.print(F("-"));
    USB.printHex(SensorXtr.boardSerialNumber[3]);
    USB.println();
  }
  else
  {
    USB.println("Error reading board serial number");
  }
  
}

void loop()
{
  delay(5000);
}

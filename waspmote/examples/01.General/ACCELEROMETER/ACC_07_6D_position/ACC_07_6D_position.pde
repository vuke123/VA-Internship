/*
 *  ------ [ACC_07] Waspmote Accelerometer 6D Position Example--------
 *
 *  Explanation: This example shows how to manage the 6D Position
 *  recognition interruption
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
 *  Version:           3.0
 *  Design:            David Gascón 
 *  Implementation:    Marcos Yarza
 */

void setup()
{ 
  // open serial port
  USB.ON();
  USB.println(F("ACC_07 example"));

}


void loop()
{
  ///////////////////////////////////////////////
  // 1. Starts accelerometer
  ///////////////////////////////////////////////
  ACC.ON();

  ///////////////////////////////////////////////
  // 2. Enable interruption: 6D Position
  ///////////////////////////////////////////////
  ACC.set6DPosition(); 


  ///////////////////////////////////////////////
  // 3. Set low-power consumption state
  ///////////////////////////////////////////////  
  USB.println(F("Waspmote goes into sleep mode until the Accelerometer causes an interrupt"));
  PWR.sleep(ALL_OFF);  

  // Interruption event happened

  ///////////////////////////////////////////////
  // 4. Disable interruption: 6D Position
  //    This is done to avoid new interruptions
  ///////////////////////////////////////////////
  ACC.ON();
  ACC.unset6DPosition(); 

  USB.ON();
  USB.println(F("Waspmote wakes up"));

  ///////////////////////////////////////////////
  // 5. Check the interruption source 
  ///////////////////////////////////////////////
  if( intFlag & ACC_INT )
  {
    // print info
    USB.ON();
    USB.println(F("++++++++++++++++++++++++++++"));
    USB.println(F("++ ACC interrupt detected ++"));
    USB.println(F("++++++++++++++++++++++++++++")); 
    USB.println(); 

    // blink LEDs
    for(int i=0; i<10; i++)
    {
      Utils.blinkLEDs(50);
    }

    USB.println(F("++++++++++++++++++++++++++++++++++++++++++++++++"));
    USB.println(F("++ 6D Movement Recognition interrupt detected ++"));
    int aux = ACC.readRegister(INT1_SRC);
    USB.print("++ Position: ");
    if (aux & ZHIE) USB.print("+Z");
    if (aux & ZLIE) USB.print("-Z");
    if (aux & YHIE) USB.print("+Y");
    if (aux & YLIE) USB.print("-Y");
    if (aux & XHIE) USB.print("+X");
    if (aux & XLIE) USB.print("-X");
    USB.println(F("                               ++"));
    USB.println(F("++++++++++++++++++++++++++++++++++++++++++++++++"));
    USB.println();


    /* 
     *  Insert your code here if more things needed
     */

  }

  ///////////////////////////////////////////////////////////////////////
  // 6. Clear 'intFlag' 
  ///////////////////////////////////////////////////////////////////////
  // This is mandatory, if not this interruption will not be deleted and 
  // Waspmote could think in the future that a not existing interruption arrived
  clearIntFlag(); 

  ///////////////////////////////////////////////////////////////////////
  // 7. Clear interruption pin   
  ///////////////////////////////////////////////////////////////////////
  // This function is used to make sure the interruption pin is cleared
  // if a non-captured interruption has been produced
  PWR.clearInterruptionPin();
}





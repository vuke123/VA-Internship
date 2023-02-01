#include <WaspSensorGas_Pro.h>
#include <WaspFrame.h>
#include <WaspPM.h>
#include <WaspLoRaWAN.h>


uint8_t socket = SOCKET0;

char DEVICE_EUI[]  = "0004A30B00212A2C";
char APP_EUI[] = "0000000000000001";
char APP_KEY[] = "00000000000000000000000000000000";

uint8_t PORT = 3;

char data[100];
uint8_t Array[100];


uint8_t error;
uint8_t error_config = 0;


bmeGasesSensor  bme;

Gas NO2(SOCKET_A);
Gas CO(SOCKET_B);
Gas O3(SOCKET_C);
Gas SO2(SOCKET_F);


float temperature;
float humidity;
float pressure;
float concentration_NO2;
float concentration_CO;
float concentration_O3;
float concentration_SO2;


char info_string[61];
char serial_number[61];
int status;
int measure;

char node_ID[] = "Node_01";

void string2hexString(char* input, char* output)
{
    int loop;
    int i; 
    i=0;
    loop=0;
    
    while(input[loop] != '\0')
    {
        sprintf((char*)(output+i),"%02X", input[loop]);
        loop+=1;
        i+=2;
    }
    //insert NULL at the end of the output string
    output[i++] = '\0';
}

void SendData(int PORT, char data[], int data_length){
  
  /*for (int i=0;i<data_length;i++){
    data_temp[i]=data[i];
  }*/
   error = LoRaWAN.joinABP();

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("2. Join network OK")); 
  error = LoRaWAN.sendUnconfirmed( PORT, data);

    // Error messages:
    /*
     * '6' : Module hasn't joined a network
     * '5' : Sending error
     * '4' : Error with data length   
     * '2' : Module didn't response
     * '1' : Module communication error   
     */
    // Check status
    if( error == 0 ) 
    {
      USB.println(F("3. Send unconfirmed packet OK"));  
      if (LoRaWAN._dataReceived == true)
      { 
        USB.print(F("   There's data on port number "));
        USB.print(LoRaWAN._port,DEC);
        USB.print(F(".\r\n   Data: "));
        USB.println(LoRaWAN._data);
      }   
    }
    else 
    {
      USB.print(F("3. Send unconfirmed packet error = ")); 
      USB.println(error, DEC);
    } 
  }
  else 
  {
    USB.print(F("2. Join network error = ")); 
    USB.println(error, DEC);
  }
}

void setup()
{

  USB.println(F("Frame Utility Example for Gases Pro Sensor Board"));
  
  USB.println(F("LoRaWAN example - Send Unconfirmed packets (ACK)\n"));

  USB.println(F("Particle Matter Sensor example"));

   // switch on sensor
   status = PM.ON();
   
   // check answer
   if (status == 1)
   {
     // get info from sensor
     status = PM.getInfoString(info_string);
     USB.print(F("Battery Level: "));
     USB.print(PWR.getBatteryLevel(),DEC);
     USB.println(F(" %"));

     if (status == 1)
     {
       USB.print(F("Information string extracted: "));
       USB.println(info_string);
     }
     else
     {
       USB.println(F("Error reading the particle sensor"));
     }

     // read serial number from sensor. That funtion isn't avalable for OPC-N2 sensor
     status = PM.readSerialNumber(serial_number);
     if (status == 1)
     {
       USB.print(F("Serial number: "));
       USB.println(serial_number);

     }
     else
     {
       USB.println(F("Error reading the serial number"));
     }

     // switch off sensor
     PM.OFF();
   }
   else
   {
     USB.println(F("Error starting the particle sensor"));
   }
  USB.println(F("------------------------------------"));
  USB.println(F("Module configuration"));
  USB.println(F("------------------------------------\n"));
  // Set the Waspmote ID
  frame.setID(node_ID);

  
  //////////////////////////////////////////////
  // 1. Switch on
  //////////////////////////////////////////////

  error = LoRaWAN.ON(socket);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("1. Switch ON OK"));     
  }
  else 
  {
    USB.print(F("1. Switch ON error = ")); 
    USB.println(error, DEC);
    error_config = 1;
  }
  
  
  //////////////////////////////////////////////
  // 2. Change data rate
  //////////////////////////////////////////////

  error = LoRaWAN.setDataRate(3);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("2. Data rate set OK"));     
  }
  else 
  {
    USB.print(F("2. Data rate set error= ")); 
    USB.println(error, DEC);
     error_config = 2;
  }


  //////////////////////////////////////////////
  // 3. Set Device EUI
  //////////////////////////////////////////////

  error = LoRaWAN.setDeviceEUI(DEVICE_EUI);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("3. Device EUI set OK"));     
  }
  else 
  {
    USB.print(F("3. Device EUI set error = ")); 
    USB.println(error, DEC);
    error_config = 3;
  }

  //////////////////////////////////////////////
  // 4. Set Application EUI
  //////////////////////////////////////////////

  error = LoRaWAN.setAppEUI(APP_EUI);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("4. Application EUI set OK"));     
  }
  else 
  {
    USB.print(F("4. Application EUI set error = ")); 
    USB.println(error, DEC);
    error_config = 4;
  }

  //////////////////////////////////////////////
  // 5. Set Application Session Key
  //////////////////////////////////////////////

  error = LoRaWAN.setAppKey(APP_KEY);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("5. Application Key set OK"));     
  }
  else 
  {
    USB.print(F("5. Application Key set error = ")); 
    USB.println(error, DEC);
    error_config = 5;
  }

  /////////////////////////////////////////////////
  // 6. Join OTAA to negotiate keys with the server
  /////////////////////////////////////////////////
  
  error = LoRaWAN.joinOTAA();

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("6. Join network OK"));         
  }
  else 
  {
    USB.print(F("6. Join network error = ")); 
    USB.println(error, DEC);
    error_config = 6;
  }


  //////////////////////////////////////////////
  // 7. Save configuration
  //////////////////////////////////////////////

  error = LoRaWAN.saveConfig();

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("7. Save configuration OK"));     
  }
  else 
  {
    USB.print(F("7. Save configuration error = ")); 
    USB.println(error, DEC);
    error_config = 7;
  }

  //////////////////////////////////////////////
  // 8. Switch off
  //////////////////////////////////////////////

  error = LoRaWAN.OFF(socket);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("8. Switch OFF OK"));     
  }
  else 
  {
    USB.print(F("8. Switch OFF error = ")); 
    USB.println(error, DEC);
    error_config = 8;
  }
  
  if (error_config == 0){
    USB.println(F("\n---------------------------------------------------------------"));
    USB.println(F("Module configured"));
    USB.println(F("After joining through OTAA, the module and the network exchanged "));
    USB.println(F("the Network Session Key and the Application Session Key which "));
    USB.println(F("are needed to perform communications. After that, 'ABP mode' is used"));
    USB.println(F("to join the network and send messages after powering on the module"));
    USB.println(F("---------------------------------------------------------------\n"));
    USB.println();  
  }
  else{
    USB.println(F("\n---------------------------------------------------------------"));
    USB.println(F("Module not configured"));
    USB.println(F("Check OTTA parameters and restart the code."));
    USB.println(F("If you continue executing the code, frames might not be sent even"));
    USB.println(F("though the code prints: Send unconfirmed packet OK"));
    USB.println(F("\n---------------------------------------------------------------"));
    
  }

}

void loop()
{
  ///////////////////////////////////////////
  // 1. Turn on sensors and wait
  ///////////////////////////////////////////

  //Power on gas sensors

  bme.ON();

  USB.ON();
  NO2.ON();
  CO.ON();
  O3.ON();
  SO2.ON();

  PWR.deepSleep("00:00:02:00", RTC_OFFSET, RTC_ALM1_MODE1, ALL_OFF);


  ///////////////////////////////////////////
  // 2. Read sensors
  ///////////////////////////////////////////
  delay(5000);
  concentration_NO2 = NO2.getConc();
  concentration_CO = CO.getConc();
  concentration_O3 = O3.getConc();
  concentration_SO2 = SO2.getConc();
  temperature = bme.getTemperature();
  humidity = bme.getHumidity();
  pressure = bme.getPressure();

  status = PM.ON();

   // check answer
   if (status == 1)
   {
     USB.println(F("Particle sensor started"));

   }
   else
   {
     USB.println(F("Error starting the particle sensor"));
   }


   ///////////////////////////////////////////
   // 2. Read sensor
   ///////////////////////////////////////////
   if (status == 1)
   {
     // Power the fan and the laser and perform a measure of 5 seconds
     measure = PM.getPM(5000, 5000);

     // check answer
     if (measure == 1)
     {
       USB.println(F("Measure performed"));
       USB.print(F("PM 1: "));
       USB.printFloat(PM._PM1, 3);
       USB.println(F(" ug/m3"));
       USB.print(F("PM 2.5: "));
       USB.printFloat(PM._PM2_5, 3);
       USB.println(F(" ug/m3"));
       USB.print(F("PM 10: "));
       USB.printFloat(PM._PM10, 3);
       USB.println(F(" ug/m3"));
       USB.println(F("***************************************"));
       USB.print(F("NO2 concentration: "));
       USB.print(concentration_NO2);
       USB.println(F(" ppm"));
       USB.print(F("CO concentration: "));
       USB.print(concentration_CO);
       USB.println(F(" ppm"));
       USB.print(F("O3 concentration: "));
       USB.print(concentration_O3);
       USB.println(F(" ppm"));
       USB.print(F("SO2 concentration: "));
       USB.print(concentration_SO2);
       USB.println(F(" ppm"));
       USB.print(F("Temperature: "));
       USB.print(temperature);
       USB.println(F(" Celsius degrees"));
       USB.print(F("RH: "));
       USB.print(humidity);
       USB.println(F(" %"));
       USB.print(F("Pressure: "));
       USB.print(pressure);
       USB.println(F(" Pa"));
       USB.println();
     }
     else
     {
       USB.print(F("Error performing the measure. Error code:"));
       USB.println(measure, DEC);
     }
   }

  //Turned off

  ///////////////////////////////////////////
  // 5. Create ASCII frame
  ///////////////////////////////////////////
  uint16_t data_len;
  // Create new frame (ASCII)
  if(measure == 1){
    frame.createFrame(ASCII);

    // Add temperature
    frame.addSensor(SENSOR_GASES_PRO_TC, temperature);
    // Add humidity
    frame.addSensor(SENSOR_GASES_PRO_HUM, humidity);
    // Add pressure value
    frame.addSensor(SENSOR_GASES_PRO_PRES, pressure);
    frame.addSensor(SENSOR_GASES_PRO_NO2, concentration_NO2);
    frame.addSensor(SENSOR_GASES_PRO_CO, concentration_CO);
    frame.addSensor(SENSOR_GASES_PRO_O3, concentration_O3);
    frame.addSensor(SENSOR_GASES_PRO_SO2, concentration_SO2);
    frame.addSensor(SENSOR_GASES_PRO_PM1, PM._PM1);
    frame.addSensor(SENSOR_GASES_PRO_PM2_5, PM._PM2_5);
    frame.addSensor(SENSOR_GASES_PRO_PM10, PM._PM10);
    frame.addSensor(SENSOR_BAT, PWR.getBatteryLevel());
    // Show the frame
    data_len = frame.showFrame(Array);

  }
  
  USB.println();
  

  
  //int length2 = sizeof(Array)/sizeof(Array[0]);
  char copy[data_len];
  for(int i = 0;i < data_len;i++){
    copy[i] = (char)Array[i];
  }

  char data2[data_len];
  int brojac = 0;
  int lijevi;
  int desni;
  int brojac_zapisa = 0;
  
  
  for(int i = 0; i < data_len;i++){
    char current = copy[i];
    if(current == '#' && brojac < 4){
      brojac++;
      lijevi = i;
      continue;
    }
  
    if(current == '#' && brojac > 3){
      desni = i;
      for(int k = lijevi; k < desni;k++){
        data2[brojac_zapisa++] = copy[k];
      }
      lijevi = desni;
    
    }
    
  }
  data2[brojac_zapisa] = '\0';

  
  USB.println();

  //int len = sizeof(data2)/sizeof(data2[0]);
  char hex_str[(data_len*2)+1];
    
  string2hexString(data2, hex_str);

   int counter = 0;
   
  while(hex_str[counter] != '\0'){
    counter++;
   }

   char final_hex[counter];

    counter = 0;
    while(hex_str[counter] != '\0'){
      final_hex[counter] = hex_str[counter];
      counter++;
   }
   
  
  USB.println();
  USB.print("Hex data: ");
  
   for(int i = 0; i<counter; i++){
    USB.print(final_hex[i]);
   }
   USB.println();
  

  delay(2000);


  //////////////////////////////////////////////
  // 1. Switch on
  //////////////////////////////////////////////

  error = LoRaWAN.ON(socket);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("1. Switch ON OK"));     
  }
  else 
  {
    USB.print(F("1. Switch ON error = ")); 
    USB.println(error, DEC);
  }



  //////////////////////////////////////////////
  // 2. Join network
  //////////////////////////////////////////////

     

    //////////////////////////////////////////////
    // 3. Send unconfirmed packet 
    ////////////////////////////////////////////// 
    int j=0;
    int flag = 0;
    if(counter>100){
      for(int i=0;i<counter;i++){
        if(j<100){
          flag = 0;
          data[j]=final_hex[i];
          j++;
        }
        else{
          flag = 1;
          data[j] = '\0';
          int counter2 = 0;
          while(data[counter2] != '\0'){
            counter2++;
          
         }
         /*for(int i = 0; i<counter2; i++){
          USB.print(data[i]);
         }*/
          SendData(PORT, data, counter2);
          j=0;
          for (int z=0;z<100;z++){
            data[z]='\0';
          }
          data[j++] = final_hex[i];
         }
      }
      if(flag == 0){
          SendData(PORT,data,j);
      }
    }else{
      int counter2 = 0;
      while(data[counter2] != '\0'){
        counter2++;
     }
     for(int i = 0; i<counter2; i++){
          USB.print(data[i]);
         }
      USB.println();
      SendData(PORT,data, counter2);
    }

    //data will be sent in a function "SendData()"


  //////////////////////////////////////////////
  // 4. Switch off
  //////////////////////////////////////////////

  error = LoRaWAN.OFF(socket);

  // Check status
  if( error == 0 ) 
  {
    USB.println(F("4. Switch OFF OK"));     
  }
  else 
  {
    USB.print(F("4. Switch OFF error = ")); 
    USB.println(error, DEC);
    USB.println();
  }


  delay(10000);

  ///////////////////////////////////////////
  // 4. Sleep
  ///////////////////////////////////////////

  bme.OFF();
  O3.OFF();
  SO2.OFF();
  NO2.OFF();
  CO.OFF();
  PM.OFF();

  // Go to deepsleep
  // After 30 seconds, Waspmote wakes up thanks to the RTC Alarm

  USB.println(F("Go to deep sleep mode..."));
  PWR.deepSleep("00:00:03:00", RTC_OFFSET, RTC_ALM1_MODE1, ALL_OFF);
  USB.ON();
  USB.println(F("Wake up!!\r\n"));

}





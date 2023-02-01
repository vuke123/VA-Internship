/*! \file WaspSensorGas_Pro.h
\brief Library for managing the Gas Pro Sensor Board

Copyright (C) 2018 Libelium Comunicaciones Distribuidas S.L.
http://www.libelium.com

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Version:		4.2
Design:			David Gascón
Implementation:	Alejandro Gállego & Ahmad Saad

*/

/*! \def WaspSensorGas_Pro_h
\brief The library flag

*/
#ifndef WaspSensorGas_Pro_h
#define WaspSensorGas_Pro_h


//!***************************************************************************
//! Includes
//!***************************************************************************

#include <inttypes.h>
#include <avr/pgmspace.h>

#include <WaspConstants.h>
#include <MCP3421.h>
#include <LMP91000.h>
#include <BME280.h>
#include <UltrasoundSensor.h>
#include <TSL2561.h>



/******************************************************************************
 * Definitions & Declarations
 ******************************************************************************/
// Probe I2C pins
#define GP_I2C_MAIN_EN		ANA0
#define GP_I2C_SOCKET_1_C	DIGITAL4
#define GP_I2C_SOCKET_2_E	DIGITAL6
#define GP_I2C_SOCKET_3_F	DIGITAL8
#define GP_I2C_SOCKET_4_A	ANA5
#define GP_I2C_SOCKET_5_B	ANA3
#define GP_I2C_SOCKET_6		ANA1

// Probe PWR pins
#define GP_PWR_SOCKET_1_C	DIGITAL3
#define GP_PWR_SOCKET_2_E	DIGITAL5
#define GP_PWR_SOCKET_3_F	DIGITAL7
#define GP_PWR_SOCKET_4_A	ANA6
#define GP_PWR_SOCKET_5_B	ANA4
#define GP_PWR_SOCKET_6		ANA2



//! DEBUG MODE
/*! 0: No debug mode enabled
 * 	1: debug mode enabled for error output messages
 * 	2: debug mode enabled for both error and ok messages
 */
#define DEBUG_GASES_PRO		0

//! NEGATIVE VALUE MODE
/*! 0: No debug mode enabled
 * 	1: debug mode enabled for negative values output
 */
#define DEBUG_NEGATIVE_VALUE	0

#define PRINT_GASES_PRO(str)		USB.print(F("[GASES PRO] ")); USB.print(str);
#define PRINT_GASES_PRO_VAL(val)	USB.printFloat(float(val), 3);

#define PRINTLN_GASES_PRO(str)		USB.print(F("[GASES PRO] ")); USB.println(str);
#define PRINTLN_GASES_PRO_VAL(val)	USB.printFloat(float(val), 3); USB.println();

#define PRINT_GASES_PRO_DATA(str1, val, str2) 	\
	USB.print(F("[GASES PRO] "));				\
	USB.print(F(str1));							\
	USB.printFloat(val, 3);						\
	USB.println(F(str2));


//!***************************************************************************
//!	EEPROM defines
//!***************************************************************************

//! EEPROM memory address
// Common
#define VER_BOARD_REG		0x00	// 1 Byte
#define SENSOR_TYPE_REG		0x01	// 1 Byte
#define SENSOR_CHECKSUM		0x06	// 1 Byte
#define SENSOR_NO_REG		0x70	// 16 Bytes

// 3 electrode board
#define SENSITIVITY_REG		0x02	// 4 Bytes
#define OFFSET_REG			0x08	// 4 Bytes
#define CAL_REG				0x10	// 64 Bytes

// 4 electrode board
#define SENS_WE_REG			0x02	// 4 Bytes
#define WE_OFFSET_REG		0x08	// 4 Bytes
#define SENS_AE_REG			0x0C	// 4 Bytes
#define CAL_WE_REG			0x10	// 16 Bytes
#define CAL_AE_REG			0x18	// 16 Bytes
#define CAL_WE_EXT_REG		0x20	// 16 Bytes
#define CAL_AE_EXT_REG		0x28	// 16 Bytes
#define AE_OFFSET_REG		0x30	// 4 Bytes
#define OFFSET_AUX_ELEC	 	0x38	// 4 Bytes used
#define OFFSET_WRK_ELEC		0x40	// 4 Bytes used
#define ZERO_POINT_OK		0x44	// 1 Byte

// pellistor/CO2 board
#define CAL_1_REG			0x10	// 4 Bytes
#define CAL_2_REG			0x18	// 4 Bytes

//!***************************************************************************
//!	MCP4146 defines
//!***************************************************************************

#define VOL_WIPER_0_REG		0x00
#define VOL_WIPER_1_REG		0x10
#define NVOL_WIPER_0_REG	0x20
#define NVOL_WIPER_1_REG	0x30
#define VOL_TCON_REG		0x40
#define MCP_STATUS_REG		0x50
#define EEPROM_0_REG		0x60
#define EEPROM_1_REG		0x70
#define EEPROM_2_REG		0x80
#define EEPROM_3_REG		0x90
#define EEPROM_4_REG		0xA0
#define EEPROM_5_REG		0xB0
#define EEPROM_6_REG		0xC0
#define EEPROM_7_REG		0xD0
#define EEPROM_8_REG		0xE0
#define EEPROM_9_REG		0xF0

#define WRITE_COMMAND	0x00
#define INC_COMMAND		0x04
#define DEC_COMMAND		0x08
#define READ_COMMAND	0x0C

#define MCP_GAIN_0		0
#define MCP_GAIN_1		20000
#define MCP_GAIN_2		40000
#define MCP_GAIN_3		60000
#define MCP_GAIN_4		80000
#define MCP_GAIN_5		100000
#define MCP_GAIN_6		1000000



//!***************************************************************************
//!	Sensor defines
//!***************************************************************************
// SOLIDSENSE gas sensors
#define CL2_SS			0	// OK
#define CO_SS_SEC		1	// OK	Vbias: 0V
#define ETO_SS			2	// OK
#define H2_SS_SEC		3	// OK	Vbias: 0V
#define H2S_SS_SEC		4	// OK	Vbias: 0V
#define HCL_SS			5	// OK
#define HCN_SS			6	// OK
#define NH3_SS			7	// OK
#define NO_SS			8	// OK
#define NO2_SS_CLE		9	// OK
#define O2_SS			10 	// OK	Vbias: -600mV
#define PH3_SS			11	// OK
#define SO2_SS			12	// OK

// ALPHASENSE gas sensors
#define LEL_AS			13	// Pellistor
#define O3_AS			14	// 4 electrode Vbias: 0V
#define NO2_AS			16	// 4 electrode Vbias: 0V
#define NO_AS			17	// 4 electrode Vbias: +200mV
#define SO2_AS			18	// 4 electrode Vbias: 0V
#define CO_AS			19	// 4 electrode Vbias: 0V

// SOLIDSENSE NDIR
#define NDIR_CO2_SS		15	// CO2 NDIR

#define CALIBRATION_NDIR	251
#define CALIBRATION_3E		252
#define CALIBRATION_4E		253
#define CALIBRATION_PEL		254
#define UNDEFINED_SENSOR	255

//!***************************************************************************
//!	Miscelaneus defines
//!***************************************************************************
#define WORKING_ELECTRODE		0
#define AUXILIARY_ELECTRODE		1
#define COMPENSATED				2

//!***************************************************************************
//!	AutoGain function defines
//!***************************************************************************
#define UHV 7	//Upper High Voltage
#define UMV 6	//Upper Medium Voltage
#define ULV 5	//Upper Low Voltage
#define LLV 4	//Lower Low Voltage
#define LMV 3	//Lower Medium Voltage
#define LHV 2	//Lower High Voltage
#define URG 1	//Upper Resisitor Gain
#define LRG 0	//Lower Resisitor Gain

#define MAX_RANGE_FACTOR	0.85
#define MIN_RANGE_FACTOR	0.15

//!Compensation values for baseline (ppm baseline vs temperature)
//-20 ºC	20ºC	40ºC	50ºC
const float table_baseline_temp_comp[][4] PROGMEM =
{
	{0,0,-0.05,-0.3},			// CL2_SS
	{-0.3,0,0,-0.3},			// CO_SS_CLE
	{-1,0,2.66,5},				// ETO_SS
	{-2,0,0,-2.5},				// H2_SS_SEC
	{0,0,0,-0.04},				// H2S_SS_SEC
	{0,0,4,15},					// HCL_SS
	{0,0,-0.1,0.1},				// HCN_SS
	{-0.25,0,1.66,3},			// NH3_SS
	{-0.6,0,4,9},				// NO_SS
	{0.1,0,-0.5,-1.7},			// NO2_SS_CLE
	{0,0,0,0},					// O2_SS
	{0,0,0.15,0.4},				// PH3_SS
	{0,0,0.2,0.6},				// SO2_SS
	{0,0,0,0},					// LEL_AS
	{0.01,0.025,0.12,0.25},		// O3_AS
	{0,0,0,0},					// NDIR_CO2_SS
	{0.013,0.016,0.047,0.130},	// NO2_AS
	{0.015,0.040,0.150,0.325},	// NO_AS
	{0.,0.01,0.1,0.225},		// SO2_AS
	{0,-0.025,-0.075,-0.150}	// CO_AS
};

//!Compensation values for sensitivity (%Output vs temperature)
//-20 ºC	0ºC		20ºC	40ºC	50ºC
const float table_sensitivity_temp_comp[][5] PROGMEM =
{
	{0.92,0.96,1,0.97,0.95},	// CL2_SS
	{0.7,0.9,1,1.09,1},			// CO_SS_CLE
	{0.4,0.7,1,1.15,1.25},		// ETO_SS
	{0.2,0.5,1,2.1,2.8},		// H2_SS_SEC
	{0.87,0.95,1,1,1},			// H2S_SS_SEC
	{0.85,0.92,1,1,1},			// HCL_SS
	{0.8,1,1,1.04,1.04},		// HCN_SS
	{0.9,1,1,1,1},				// NH3_SS
	{0.7,0.8,1,1.06,1.12},		// NO_SS
	{0.8,0.8,1,1.1,1.25},		// NO2_SS_CLE
	{0.9,0.96,1,1.07,1.07},		// O2_SS
	{0.8,0.9,1,1.05,1.05},		// PH3_SS
	{0.9,1,1,1.05,1},			// SO2_SS
	{1.055,1.035,1,1.015,1.0},	// LEL_AS
	{0.7,0.92,1,1,0.92},		// O3_AS
	{1,1,1,1,1},				// NDIR_CO2_SS
	{0.7,0.77,1,1.1,1.13},		// NO2_AS
	{0.4,0.8,1,1.2,1.3},		// NO_AS
	{0.83,0.95,1,0.99,0.96},	// SO2_AS
	{0.52,0.8,1,1.12,1.18}		// CO_AS
};

//!Compensation values for sensitivity
//-20 ºC	0ºC		20ºC	40ºC	50ºC
const float table_ppm2ugm3[] PROGMEM =
{
	2900,	// CL2_SS
	1230,	// CO_SS_CLE
	1984,	// ETO_SS
	88.9,	// H2_SS_SEC
	1500,	// H2S_SS_SEC
	1605,	// HCL_SS
	1189,	// HCN_SS
	750,	// NH3_SS
	1320,	// NO_SS
	2030,	// NO2_SS_CLE
	1410,	// O2_SS
	772,	// PH3_SS
	2820,	// SO2_SS
	1,		// LEL_AS
	2115,	// O3_AS
	1940,	// NDIR_CO2_SS
	2030,	// NO2_AS
	1320,	// NO_AS
	2820,	// SO2_AS
	1230	// CO_AS
};

extern volatile uint8_t	pwrGasPRORegister;
extern volatile uint8_t	pwrCitiesPRORegister;



/******************************************************************************
* Class
******************************************************************************/

//! WaspSensorGas_Pro Class
/*!
WaspSensorGas_Pro Class defines all the variables and functions used to manage the AFE modules and the base board
*/

class Gas
{

private:
	bool initDone = false;

protected:

	//! This struct includes all the data necessary to manage the AFE modules for each sensor
	struct sensor_conf
	{
		uint8_t socket;				// Board socket
		uint8_t sensor_type;		// Gas sensor number
		uint8_t power_pin;			// GPIO asociated to the power pin
		uint8_t i2c_pin;			// GPIO asociated to the I2C pin
		uint8_t cities_3v3_pin;		// GPIO asociated to the 3V3 pin in Cities PRO board
		float m_conc;				// nA/ppm or mV/%
		float baseline;				// nA or mV
		float aux_baseline;			// nA, offset for auxiliary electrode
		float OX_NO2_sens;			// nA/ppm
		float calibration[8][2];	// compensation values for AFE modules
		//uint32_t tempo;			// timer
		uint8_t AFE_ver;			// AFE board version
		float AFE_offset;
		float auxiliar_offset;
		float working_offset;
		uint8_t zeroPointOK;
	} sensor_config;

	//! This function generates the baseline compensation for the temperature in ppm
	/*!
	\param float temperature: ambient temperature for sensor compensation (-1000 if doesn't needed)
	\return		ppm value for compensation
	*/
	float getBaselineTempComp(float temperature);

	//! This function generates the output current compensation for the temperature
	/*!
	\param float temperature: ambient temperature for sensor compensation (-1000 if doesn't needed)
	\return		compensation factor
	*/
	float getSensitivityTempComp(float temperature);

	//! Specific function to read 3 electrode sensors
	/*!
	\param uint8_t resolution: resolution value for ADC
	MCP3421_RES_12_BIT or MCP3421_LOW_RES
	MCP3421_RES_14_BIT or MCP3421_MEDIUM_RES
	MCP3421_RES_16_BIT or MCP3421_HIGH_RES
	MCP3421_RES_18_BIT or MCP3421_ULTRA_HIGH_RES
	\param float temperature: ambient temperature for sensor compensation (-1000 if doesn't needed)
	\return		The concetration value in ppm
	*/
	float read3ElectrodeSensor(uint8_t resolution, float temperature);

	//! Specific function to read pellistor sensors
	/*!
	\param uint8_t resolution: resolution value for ADC
	MCP3421_RES_12_BIT or MCP3421_LOW_RES
	MCP3421_RES_14_BIT or MCP3421_MEDIUM_RES
	MCP3421_RES_16_BIT or MCP3421_HIGH_RES
	MCP3421_RES_18_BIT or MCP3421_ULTRA_HIGH_RES
	\param float temperature: ambient temperature for sensor compensation (-1000 if doesn't needed)
	\return		The concetration value %LEL
	*/
	float readPellistorSensor(uint8_t resolution, float temperature);

	//! Specific function to read NDIR sensors
	/*!
	\param uint8_t resolution: resolution value for ADC
	MCP3421_RES_12_BIT or MCP3421_LOW_RES
	MCP3421_RES_14_BIT or MCP3421_MEDIUM_RES
	MCP3421_RES_16_BIT or MCP3421_HIGH_RES
	MCP3421_RES_18_BIT or MCP3421_ULTRA_HIGH_RES
	\param float temperature: ambient temperature for sensor compensation (-1000 if doesn't needed)
	\return		The concetration value in ppm
	*/
	float readNDIR(uint8_t resolution);

	//! This function reads the sensor information from EEPROM
	/*!
	\return		nothing
	*/
	uint8_t readSensorInfo();


public:
	//! class constructor (basic)
	/*!
	\param int socket: number of the socket where the sensor is attached
	\return 	nothing
	*/
	Gas(int socket);

	//! class constructor (manual configuration)
	/*!
	\param uint8_t sensor_type: number of the socket where the sensor is attached
	\param int power_pin: pin to manage the power switch of the AFE board
	\param int I2C_pin: pin to manage the I2C switch of the AFE board
	\param float m_conc: sensibility for main electrode (nA/ppm or mV/%)
	\param float baseline: baseline offset of the sensor (nA or mV)
	\param float aux_var: sensibility for auxiliary electrode (nA/ppm)
	\param float calibration_table[7][2]: adjustment parameters
	\return 	nothing
	*/
	Gas(int socket, uint8_t sensor_type, int power_pin, int I2C_pin, float m_conc, float baseline, float aux_var, float calibration_table[7][2]);


	//bool over_limit;
	//bool low_conc;


	//! POWER AND CONFIGURATION FUNCTIONS
	//! This function turns on the AFE board and selects a default gain for transimpendance amplifier
	/*!
	\return 	1 if OK
	* 			-1 no communication with LMP91000
	*/
	int8_t ON();
	
		//! Specific function to read 4 electrode sensors
	/*!
	\param uint8_t resolution: resolution value for ADC
	MCP3421_RES_12_BIT or MCP3421_LOW_RES
	MCP3421_RES_14_BIT or MCP3421_MEDIUM_RES
	MCP3421_RES_16_BIT or MCP3421_HIGH_RES
	MCP3421_RES_18_BIT or MCP3421_ULTRA_HIGH_RES
	\param float temperature: ambient temperature for sensor compensation (-1000 if doesn't needed)
	\param float NO2_conc: NO2 concentration in ppm to compensate the cross-sensitivity. Only for O3 sensor, for other sensors use 0.0 value
	\return		The concetration value in ppm
	*/
	float read4ElectrodeSensorv301(uint8_t resolution, float temperature, float NO2_conc);

	//! This function turns on the AFE board and selects a gain for transimpendance amplifier
	/*!
	\param float R_gain: gain for transimpendance amplifier
	\return 	1 if OK
	* 			-1 no communication with LMP91000
	*/
	int8_t ON(float R_gain);

	//! This function turns off the AFE board
	/*!
	\return 	pwrGasRegister
	*/
	uint8_t OFF();

	//! This function turns off the AFE board and enables the shorting FET for 3 electrode boards
	/*!
	\param uint8_t enable_FET: '1' to enable the FET, 'FET_NOT_SHORTED' if not
	\return 	pwrGasRegister
	*/
	uint8_t OFF(uint8_t enable_FET);

	//! This function sets the power mode of LMP91000
	/*!
	\param uint8_t power_mode: 	MODE_DEEP_SLEEP
	MODE_2_LEAD_GALVANIC
	MODE_STAND_BY
	MODE_3_LEAD_AMPERIOMETRIC
	MODE_TEMP_TIA_OFF
	MODE_TEMP_TIA_ON
	MODE_NO_CHANGE
	\return 	1 if OK
	*/
	int8_t setPowerMode(uint8_t power_mode);

	//! This function configure the AFE module (LMP91000 and/or MCP4146)
	/*!
	\param float R_gain resistor value for transimpendance stage
	\return 	1 if OK
	* 			-1 no communication with LMP91000
	*/
	int8_t configureAFE(float R_gain);


	//! MEASURING FUNCTIONS
	//! This function reads temperature
	/*!
	\return 	The temperature, -1000 if error
	*/
	float getTemp();

	//! This function reads temperature
	/*!
	\param bool sensor: '0' for LMP91000, '1' for BME280
	\return 	The temperature, -1000 if error
	*/
	float getTemp(bool sensor);

	//! This function reads relative humidity from BME280
	/*!
	\return 	The relative humidity, -1000 if error
	*/
	float getHumidity();

	//! This function reads pressure from BME280
	/*!
	\return		The pressure, -1000 if error
	*/
	float getPressure();

	//! This function reads concentration value with default parameters (16bit ADC, BME280 temperature and compensated meassure for O3 sensor)
	/*!
	\return		The concetration value in ppm / %LEL, -1000 if error.
	*/
	float getConc();

	//! This function reads concentration value  with default parameters (BME280 temperature and compensated meassure for O3 sensor)
	/*!
	\param uint8_t resolution: resolution value for ADC
	MCP3421_RES_12_BIT or MCP3421_LOW_RES
	MCP3421_RES_14_BIT or MCP3421_MEDIUM_RES
	MCP3421_RES_16_BIT or MCP3421_HIGH_RES
	MCP3421_RES_18_BIT or MCP3421_ULTRA_HIGH_RES
	\return		The concetration value in ppm / %LEL, -1000 if error.
	*/
	float getConc(uint8_t resolution);

	//! This function reads concentration value with default parameters
	/*!
	\param float temperature: ambient temperature for sensor compensation (-1000 if doesn't needed)
	\return		The concetration value in ppm / %LEL, -1000 if error.
	*/
	float getConc(float temperature);

	//! This function reads concentration value
	/*!
	\param uint8_t resolution: resolution value for ADC
	MCP3421_RES_12_BIT or MCP3421_LOW_RES
	MCP3421_RES_14_BIT or MCP3421_MEDIUM_RES
	MCP3421_RES_16_BIT or MCP3421_HIGH_RES
	MCP3421_RES_18_BIT or MCP3421_ULTRA_HIGH_RES
	\param float NO2_conc: NO2 concentration in ppm to compensate the cross-sensitivity. Only for O3 sensor
	\return		The concetration value in ppm / %LEL, -1000 if error.
	*/
	float getConc(uint8_t resolution, float NO2_conc);

	//! This function reads concentration value
	/*!
	\param uint8_t resolution: resolution value for ADC
	MCP3421_RES_12_BIT or MCP3421_LOW_RES
	MCP3421_RES_14_BIT or MCP3421_MEDIUM_RES
	MCP3421_RES_16_BIT or MCP3421_HIGH_RES
	MCP3421_RES_18_BIT or MCP3421_ULTRA_HIGH_RES
	\param float temperature: ambient temperature for sensor compensation (-1000 if doesn't needed)
	\param float NO2_conc: NO2 concentration in ppm to compensate the cross-sensitivity. Only for O3 sensor
	\return		The concetration value in ppm / %LEL, -1000 if error.
	*/
	float getConc(uint8_t resolution, float temperature, float NO2_conc);

	//! This function changes the gain and the Vref of the AFE module
	/*!
	\return		high nibble: steps changed in Vref
	low nibble: steps changed in Rgain
	*/
	int8_t autoGain();

	//! This function converts concentration in ppm to %
	/*!
	\param float ppm_conc: concentration in ppm
	\return		The concetration value in %
	*/
	float ppm2perc(float ppm_conc);

	//! This function converts concentration in ppm to ugm3
	/*!
	\param float ppm_conc: concentration in ppm
	\return		The concetration value in ugm3
	*/
	float ppm2ugm3(float ppm_conc);

	//! This function converts temperature in Celsius degrees to Fahrenheit degrees
	/*!
	\param temp: concentration in Celsius degrees
	\return		The concetration value in Fahrenheit degrees
	*/
	float Celsius2Fahrenheit(float temp);


	//! MISCELANEUS
	//! This function shows the information about the sensor
	/*!
	\return		nothing
	*/
	void showSensorInfo();


	//! ONlY FOR MANUFACTURER
	//! This function reads the value for working electrode
	/*!
	\return		Value from working electrode
	*/
	float readWorkingElectrode3E();

	//! This function reads the value for working electrode
	/*!
	\return		Value from working electrode
	*/
	float readWorkingElectrode4E();

	//! This function reads the value for auxiliary electrode
	/*!
	\return		Value from auxiliary electrode
	*/
	float readAuxiliaryElectrode4E();

	uint8_t disableCommSockets();

	void zeroPointSet();
	
	//Used for exporting sensor type to sketch code 
	uint8_t sensorType;

	//Used for exporting serial number of sensor to sketch code 
	char sensor_no[17];

};
#endif

/******************************************************************************
 * Class
 ******************************************************************************/
#ifndef BME_GASES_SENSOR_H

class bmeGasesSensor
{
	private:
	public:

		// Constructor
		bmeGasesSensor();

		void ON();
		void OFF();

		float getTemperature();
		float getHumidity();
		float getPressure();
};


#endif



/******************************************************************************
 * Class
 ******************************************************************************/
#ifndef ULTRASOUND_GASES_SENSOR_H

class ultrasoundGasesSensor
{
	private:
	public:

		// Constructor
		ultrasoundGasesSensor();

		void ON();
		void OFF();
		uint16_t getDistance();
};


#endif



/******************************************************************************
 * Class
 ******************************************************************************/

class luxesGasesSensor
{
	private:
	public:

		// Constructor
		luxesGasesSensor();

		void ON();
		void OFF();
		uint32_t getLuminosity();
		uint32_t getLuminosity(bool gain);
		uint32_t getLuminosity(bool gain, uint8_t res);
};

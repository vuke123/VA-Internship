from http.server import BaseHTTPRequestHandler, HTTPServer
import logging
import json
import datetime
import psycopg2

####
# python3 server.py <PORT>
# python3 server.py 8083
####

counter = 0
data_global = ""
data_array = []

def sendToDB(data):
    connection = psycopg2.connect("dbname=postgres user=postgres password=123") 

    cursor = connection.cursor()

    cursor.execute("""INSERT INTO airsensor (temperature, humidity, pressure, concentration_NO2, concentration_CO, concentration_O3, concentration_SO2, PM_PM1, PM_PM2_5, PM_PM10, battery, TSTAMP) 
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""", (data["TC"], data["HUM"], data["PRES"], data["NO2"], data["CO"], data["O3"], data["SO2"], data["PM1"], data["PM2_5"], data["PM10"], data["BAT"], data["TSTAMP"]))

    connection.commit()

def extractData(data):
    data = "".join(data.split())
    byte_array = bytearray.fromhex(data)
    data = str(byte_array.decode())
    data = data.split('#')
    del data[0]
    data_map = {}
    for item in data:
        passed = False
        name = ""
        value = ""
        for letter in item:
            if letter == ':':
                passed = True
                continue
            if passed:
                value += letter
            else:
                name += letter
        
        data_map[name] = value

    vrijeme = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    data_map["TSTAMP"] = vrijeme
    sendToDB(data_map)
    


class S(BaseHTTPRequestHandler):
    def _set_response(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()


    def do_POST(self):
        content_length = int(self.headers['Content-Length']) # <--- Gets the size of data
        post_data = self.rfile.read(content_length) # <--- Gets the data itself
        
        self._set_response()
        self.wfile.write("POST request for {}".format(self.path).encode('utf-8'))

        json_data = json.loads(post_data.decode('utf-8'))
        data = json_data["data"]

        global counter, data_array, data_global
        
        if counter != 3 and data not in data_array:
            data_global += data
            counter += 1
            data_array.append(data)
            print('NUMBER OF DATA: ' + str(counter) + ' , data:'+ data)
        elif counter == 3:
            extractData(data_global)
            data_global = ""
            counter = 0
            data_array = []
        

def run(server_class=HTTPServer, handler_class=S, port=8083):
    logging.basicConfig(level=logging.INFO)
    server_address = ('0.0.0.0', port)
    httpd = server_class(server_address, handler_class)
    logging.info('Starting httpd...port: %d\n', port)


    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
    logging.info('Stopping httpd...\n')

if __name__ == '__main__':
    from sys import argv

    if len(argv) == 2:  #  pocni na novom unosu za port ako ima dodatnog unosa
        run(port=int(argv[1]))
    else:
        run()  #zapocni ako nema dodatnog inputa

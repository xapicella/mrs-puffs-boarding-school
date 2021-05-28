import serial
import serial.tools.list_ports
import sys
import glob
from consts import BAUDRATE,D_DEVICE_LOCATION
dev = None
def send_uart(data,b_len,device):
    '''Sends the data in data array, encoded as binary in each entry 
        to the device device. 
        Defaults to using the device D_DEVICE_LOCATION specified in consts'''
    if not device:
        device = open_device(D_DEVICE_LOCATION)
        
    print("writing to: " + str(device.name))#check the device port name
    try:
        for i in range(b_len):
            b_written = device.write(data[i])
            print("Wrote " + str(b_written) + " Bytes : " + hex(int.from_bytes(data[i],"big")))
    except Exception as ex:
        print("problem with send_uart")
        print(ex)
    return device
        

def open_device(device_name):
    '''Need to be run before any send_uart is run
        see https://pyserial.readthedocs.io/en/latest/pyserial_api.html
        for documentation on how to add parameters. Please add params 
        to the consts file and then import and link them here'''
    ser = None
    try:
        ser = serial.Serial(port=device_name,baudrate=BAUDRATE,timeout=None)
        ser.rts = True

        print("settings: " + str(ser.get_settings()))
    except SerialException:
        print("serial device not found")
    except ValueError:
        print("incorrect setup")
    return ser

def close_device(ser):
    '''Closes the device. Needs to be run after all actions are done...'''
    ser.close()

def read_word(device):
    '''Reads a word of data (32 bits) from serial terminal'''
    data = device.read(4)
    return data

def serial_ports():
    '''Returns a list of all of the available ports for serial communication'''
    avail_ports = serial.tools.list_ports.comports()
    avail_ports = [x.device for x in avail_ports]
    print(avail_ports)
    return avail_ports


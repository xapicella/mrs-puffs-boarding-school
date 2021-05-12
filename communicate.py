import serial
import serial.tools.list_ports
import sys
import glob
from consts import BAUDRATE,D_DEVICE_LOCATION

def send_uart(data,device):
    '''Sends the data in data, encoded as binary to the device device. 
        Defaults to using the device D_DEVICE_LOCATION specified in consts'''
    
    if not device:
        device = open_device(D_DEVICE_LOCATION)
    print(device.name)#check the device port name
    try:
        device.write(byte.encode())
    except SerialTimeoutException as ex:
        print("there was an error sending data")
        print(ex)
        

def open_device(device_name):
    '''Need to be run before any send_uart is run
        see https://pyserial.readthedocs.io/en/latest/pyserial_api.html
        for documentation on how to add parameters. Please add params 
        to the consts file and then import and link them here'''
    ser = serial.Serial(device_name,BAUDRATE)
    return ser

def close_device(ser):
    '''Closes the device. Needs to be run after all actions are done...'''
    ser.close()


def serial_ports():
    '''Returns a list of all of the available ports for serial communication'''
    avail_ports = serial.tools.list_ports.comports()
    avail_ports = [x.device for x in avail_ports]
    print(avail_ports)
    return avail_ports


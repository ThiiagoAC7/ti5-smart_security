import serial 
import datetime
import sys
import time

class Ard:
    # def __init__(self):
        # while True: #Loop para a conexão com o Arduino
        #     try:  #Tenta se conectar, se conseguir, o loop se encerra
        #         self.arduino = serial.Serial('COM4', 9600)
        #         print('Arduino conectado', file = sys.stderr)
        #         break
        #     except:
        #         pass        

    def deactivateAlarm():
        while True: #Loop para a conexão com o Arduino
            try:  #Tenta se conectar, se conseguir, o loop se encerra
                arduino = serial.Serial('COM4', 9600)
                print('Arduino conectado', file = sys.stderr)
                break
            except:
                pass 
        time.sleep(1)
        arduino.write('d'.encode())
        arduino.flush() #Limpa a comunicação
        
    def activateAlarm():
        while True: #Loop para a conexão com o Arduino
            try:  #Tenta se conectar, se conseguir, o loop se encerra
                arduino = serial.Serial('COM4', 9600)
                print('Arduino conectado', file = sys.stderr)
                break
            except:
                pass 
        time.sleep(5)
        arduino.write('a'.encode())
        arduino.flush() #Limpa a comunicação

    def readRfidTag():
        while True: #Loop para a conexão com o Arduino
            try:  #Tenta se conectar, se conseguir, o loop se encerra
                arduino = serial.Serial('COM4', 9600)
                print('Arduino conectado', file = sys.stderr)
                break
            except:
                pass 
        time.sleep(1)
        arduino.write('r'.encode())
        # time.sleep(1)    
        tag = str(arduino.readline())
        arduino.flush()
        return tag 

    def writeActivityLog():
        while True: #Loop para a conexão com o Arduino
            try:  #Tenta se conectar, se conseguir, o loop se encerra
                arduino = serial.Serial('COM4', 9600)
                print('Arduino conectado', file = sys.stderr)
                break
            except:
                pass 
        time.sleep(1)
        arduino.write('w'.encode())
        # time.sleep(1)
        numLinhas = int(arduino.readline())
        l = []
        for i in range(numLinhas):
            l.append(str(arduino.readline()) + datetime.datetime.now())

        print(l, file = sys.stderr)
        arduino.flush()
        return l


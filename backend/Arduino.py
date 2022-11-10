import serial 
import datetime
import sys
import time
import Utils

class Ard:
    def connectArd():
        global arduino
        while True: #Loop para a conexão com o Arduino
            try:  #Tenta se conectar, se conseguir, o loop se encerra
                arduino = serial.Serial('COM4', 9600)
                print('Arduino conectado', file = sys.stderr)
                arduino.readline()
                break
            except:
                pass  
        arduino.flush() #Limpa a comunicação

    def deactivateAlarm():
        time.sleep(1)
        arduino.write('d'.encode())
        arduino.flush() #Limpa a comunicação
        
    def activateAlarm():
        time.sleep(5)
        arduino.write('a'.encode())
        arduino.flush() #Limpa a comunicação

    def readRfidTag():
        time.sleep(1)
        arduino.write('r'.encode())
        # time.sleep(1)    
        tag = str(arduino.readline().decode())
        arduino.flush()
        return tag 

    def writeActivityLog():
        time.sleep(1)
        arduino.write('w'.encode())
        numLinhas = int(arduino.readline())
        print(numLinhas)
        time.sleep(1)
        l = []
        for i in range(numLinhas):
            l.append(str(arduino.readline().decode()) + str(datetime.datetime.now()))
            time.sleep(1)
            
        print(l, file = sys.stderr)
        arduino.flush()
        return l


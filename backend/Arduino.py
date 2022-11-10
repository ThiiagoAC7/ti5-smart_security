import serial 
import datetime

class Ard:
    def __init__(self):
        while True: #Loop para a conexão com o Arduino
            try:  #Tenta se conectar, se conseguir, o loop se encerra
                self.arduino = serial.Serial('COM4', 9600)
                print('Arduino conectado')
                break
            except:
                pass        

    def deactivateAlarm(self):
        self.arduino.write('d'.encode())
        
    def activateAlarm(self):
        self.arduino.write('a'.encode())

    def readRfidTag(self):
        self.arduino.write('r'.encode())    
        tag = str(self.arduino.readline())
        self.arduino.flush()
        return tag 

    def writeActivityLog(self):
        self.arduino.write('w'.encode())
        numLinhas = int(self.arduino.readline())
        l = []
        for i in range(numLinhas):
            l.append(str(self.arduino.readline()) + datetime.datetime.now())
        self.arduino.flush()
        return l


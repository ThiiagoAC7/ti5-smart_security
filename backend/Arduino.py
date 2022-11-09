import serial #Importa a biblioteca

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
        self.arduino.write('deactivateAlarm'.encode())
        
    def activateAlarm(self):
        self.arduino.write('activateAlarm'.encode())

    def readRfidTag(self):
        self.arduino.write('readRfidTag'.encode())    
        tag = str(self.arduino.readline())
        self.arduino.flush()
        return tag 

    def writeActivityLog(self):
        self.arduino.write('writeActivityLog'.encode())
        numLinhas = int(self.arduino.readline())
        l = []
        for i in range(numLinhas):
            l.append(str(self.arduino.readline()))
        self.arduino.flush()
        return l


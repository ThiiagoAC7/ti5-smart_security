import serial
import time
def teste():
    while True: #Loop para a conexão com o Arduino
        try:  #Tenta se conectar, se conseguir, o loop se encerra
            arduino = serial.Serial('COM4', 9600)
            print('Arduino conectado')
            break
        except:
            pass 
    # arduino.write('a'.encode())
    time.sleep(5)
    print("terere")
    try:
        arduino.write('d'.encode())
    except Exception as e:
        print(e)
    time.sleep(1)
    arduino.flush() #Limpa a comunicação

def teste2():
    print('a'.encode())

teste()
from flask_restful import Resource
from flask import request
from Arduino import Ard
import serial
import sys

class Alarm(Resource):
    def post(self):
        auth = request.headers["Authorization"]
        print(auth, file = sys.stderr)
        if auth:
            json_data = request.get_json(force=True)
            if json_data["activate"]:
                Ard.activateAlarm()
                return {"status" : "success", "alarm_status" : "enabled"}, 201
            else:   
                Ard.deactivateAlarm()
                return {"status" : "success", "alarm_status" : "disabled"}, 201
        else:
            return {"message": "User not authorized"}, 500
        
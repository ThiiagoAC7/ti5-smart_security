from flask_restful import Resource
from flask import request
from Arduino import Ard 

class Alarm(Resource):
    def post(self):
        auth = request.headers["Authorization"]
        ard = Ard()
        if auth:
            json_data = request.get_json(force=True)
            if json_data["activate"]:
                ard.activateAlarm()
                return {"status" : "success", "alarm_status" : "enabled"}, 201
            else:   
                ard.eactivateAlarm()
                return {"status" : "success", "alarm_status" : "disabled"}, 201
        else:
            return {"message": "User not authorized"}, 500
        
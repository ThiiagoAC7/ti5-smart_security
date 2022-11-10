from flask_restful import Resource
from flask import request
from Model import db, Activity, ActivitySchema, Rfid, RfidSchema
from Arduino import Ard 
import datetime

activities_schema = ActivitySchema(many=True)
activity_schema = ActivitySchema()
rfid_schema = RfidSchema()


class LogActivity(Resource):
    def post(self):
        json_data = request.get_json(force=True)
        rfid = Rfid.query.filter_by(id=json_data["rfid_id"]).first()
        if rfid:
            activity = Activity(
                rfid_id=rfid.id,
                type=json_data["type"],
                log=json_data["log"],
                creation_date=json_data["creation_date"],
            )

            db.session.add(activity)
            db.session.commit()

            result = activity_schema.dump(activity)
        else:
            return {"message": "Rfid not registered"}, 500

        return {"status": "success", "data": result}, 201

    def get(self):
        result = []
        auth = request.headers["Authorization"]
        json_data = request.get_json(force=True)
        if auth:
            user_id = request.headers["user_id"]
            log_list = Ard.writeActivityLog();
            for i in log_list:
                activity = Activity(
                    rfid_id=request.headers["rfid_id"],
                    type=request.headers["type"],
                    log=request.headers["log"],
                    creation_date=datetime.datetime.now(),
                )

                db.session.add(activity)
                db.session.commit()
   
            rfid_list = Rfid.query.filter_by(user_id = user_id).all()
            if rfid_list:
                for rfid_object in rfid_list:
                    rfid = rfid_schema.dump(rfid_object)
                    log_list = Activity.query.filter_by(rfid_id=rfid["id"]).all()
                    for log in log_list:
                        info = activities_schema._serialize(log)
                        info["object_name"] = rfid["object"]
                        result.append(info)
            else:
                return {"message": "Object does not have any activity registered"}
        else:
            return {"message": "User not authorized"}, 500

        return {"status": "success", "data": result}, 201
from flask_restful import Resource
from flask import request
from Model import db, Activity, ActivitySchema, Rfid, RfidSchema

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
            rfid_object = Rfid.query.filter_by(id=json_data["rfid_id"]).first()
            if rfid_object:
                rfid = rfid_schema.dump(rfid_object)
                log_list = Activity.query.filter_by(rfid_id=rfid["id"]).all()
                for log in log_list:
                    result.append(activities_schema._serialize(log))
            else:
                return {"message": "Object does not have any activity registered"}
        else:
            return {"message": "User not authorized"}, 500

        return {"status": "success", "data": result}, 201
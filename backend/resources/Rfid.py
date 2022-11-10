from flask_restful import Resource
from flask import request
from Model import db, Rfid, RfidSchema, User, UserSchema
from Arduino import Ard


rfids_schema = RfidSchema(many=True)
rfid_schema = RfidSchema()
user_schema = UserSchema()


class RfidRegistration(Resource):
    def post(self):
        json_data = request.get_json(force=True)
        auth = request.headers["Authorization"]
        if auth:
            user = User.query.filter_by(api_key=auth).first()
            rfid = Ard.readRfidTag()
            if user:
                rfid = Rfid(
                    rfid=rfid,
                    object=json_data["object"],
                    user_id=user.id,
                )

                db.session.add(rfid)
                db.session.commit()

                result = rfid_schema.dump(rfid)
            else:
                return {"message": "User not authorized"}, 500
        else:
            return {"message": "No api key found"}, 400

        return {"status": "success", "data": result}, 201

    def get(self):
        result = []
        auth = request.headers["Authorization"]
        if auth:
            user = User.query.filter_by(api_key=auth).first()
            if user:
                user = user_schema.dump(user)
                rfid_list = Rfid.query.filter_by(user_id=user["id"]).all()
                for rfid in rfid_list:
                    result.append(Rfid.serialize(rfid))
            else:
                return {"message": "User does not have any rfid registered"}
        else:
            return {"message": "User not authorized"}, 500

        return {"status": "success", "data": result}, 201

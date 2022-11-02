from flask_restful import Resource
from flask import request
from Model import db, User, UserSchema

users_schema = UserSchema(many=True)
user_schema = UserSchema()


class Register(Resource):
    def get(self):
        users = User.query.all()
        users = users_schema.dump(users)
        return {"status": "success", "data": users}, 200

    def post(self):
        json_data = request.get_json(force=True)

        if not json_data:
            return {"message": "No input data porvided"}, 400

        user = User.query.filter_by(user_name=json_data["user_name"]).first()
        if user:
            return {"message": "Username already exists"}, 400

        user = User(
            user_name=json_data["user_name"],
            password=json_data["password"],
            rfid_id=json_data["rfid_id"],
        )

        db.session.add(user)
        db.session.commit()

        result = user_schema.dump(user)

        return {"status": "success", "data": result}, 201

from flask_restful import Resource
from flask import request
from Model import db, User, UserSchema

users_schema = UserSchema(many=True)
user_schema = UserSchema()


class Signin(Resource):
    def post(self):
        result = ""
        json_data = request.get_json(force=True)
        try:
            auth = request.headers["Authorization"]
            if not auth:
                result = self.username_and_password_signin(json_data)
            else:
                user = User.query.filter_by(api_key=auth).first()
                if user:
                    result = user_schema.dump(user)
                else:
                    result = self.username_and_password_signin(json_data)
        except:
            return {"message": "User not authorized"}, 500

        return {"status": "success", "data": result}, 201

    def username_and_password_signin(self, json_data):
        if not json_data:
            return {"message": "No input data porvided"}, 400

        user = User.query.filter_by(user_name=json_data["user_name"]).first()
        if not user:
            return {"message": "Username does not exists"}, 400

        if json_data["password"] != user.password:
            return {"message": "Password does not match"}, 400

        return user_schema.dump(user)

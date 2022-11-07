from flask_restful import Resource
from flask import request
from Model import db, User, UserSchema
import sys

users_schema = UserSchema(many=True)
user_schema = UserSchema()

class ApiKey(Resource):
    def get(self):
        key = User.query.filter_by(user_name=request.headers["user_name"]).first()
        if key:
            return {"status": "success", "api_key": user_schema.dump(key)["api_key"]}, 200
              
        return {"message" : "User not registered"}

    
from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy


ma = Marshmallow()
db = SQLAlchemy()


class User(db.Model):
    __tablename__ = "users"
    __table_args__ = tuple(db.UniqueConstraint("id", "user_name", name="my_2uniq"))

    id = db.Column(db.Integer, primary_key=True)
    user_name = db.Column(db.String(), nullable=False)
    password = db.Column(db.String(), nullable=False)
    api_key = db.Column(db.String(), nullable=False)
    creation_date = db.Column(
        db.TIMESTAMP, server_default=db.func.current_timestamp(), nullable=False
    )

    def __init__(self, user_name, password, api_key) -> None:
        self.user_name = user_name
        self.password = password
        self.api_key = api_key

    def __repr__(self) -> str:
        return "<id {}>".format(self.id)

    def serialize(self):
        return {
            "id": self.id,
            "user_name": self.user_name,
            "creation_date": self.creation_date,
            "password": self.password,
            "api_key": self.api_key,
        }


class Rfid(db.Model):
    __tablename__ = "rfid"

    id = db.Column(db.Integer, primary_key=True)
    rfid = db.Column(db.String(), nullable=False)
    object = db.Column(db.String(), nullable=False)
    user_id = db.Column(db.Integer(), db.ForeignKey("users.id"))

    def __init__(self, rfid, object, user_id):
        self.object = object
        self.rfid = rfid
        self.user_id = user_id

    def __repr__(self) -> str:
        return "<id {}>".format(self.id)

    def serialize(self):
        return {
            "id": self.id,
            "rfid": self.rfid,
            "object": self.object,
            "user_id": self.user_id,
        }


class Activity(db.Model):
    __tablename__ = "activity_log"

    id = db.Column(db.Integer, primary_key=True)
    rfid_id = db.Column(db.Integer(), db.ForeignKey("rfid.id"))
    type = db.Column(db.String(), nullable=False)
    log = db.Column(db.String(), nullable=False)
    creation_date = db.Column(
        db.TIMESTAMP, server_default=db.func.current_timestamp(), nullable=False
    )

    def __init__(self, rfid_id, type, log, creation_date):
        self.rfid_id = rfid_id
        self.type = type
        self.log = log
        self.creation_date = creation_date

    def __repr__(self) -> str:
        return "<id {}>".format(self.id)

    def serialize(self):
        return {
            "id": self.id,
            "rfid_id": self.rfid_id,
            "type": self.type,
            "log": self.log,
            "creation_date": self.creation_date,
        }


class RfidSchema(ma.Schema):
    id = fields.Integer()
    rfid = fields.String(required=True)
    object = fields.String(required=True)
    user_id = fields.Integer(required=True)


class UserSchema(ma.Schema):
    id = fields.Integer(dump_only=True)
    rfid_id = fields.Integer(required=False)
    user_name = fields.String(
        required=True, allow_none=False, validate=validate.Length(1)
    )
    password = fields.String(required=True, allow_none=False)
    api_key = fields.String(required=True, allow_none=False)
    creation_date = fields.DateTime()


class ActivitySchema(ma.Schema):
    id = fields.Integer(dump_only=True)
    rfid_id = fields.Integer(required=True)
    type = fields.String(required=True, allow_none=False)
    log = fields.String(required=True, allow_none=False)
    creation_date = fields.DateTime()

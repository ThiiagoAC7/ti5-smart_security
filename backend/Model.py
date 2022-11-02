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
    creation_date = db.Column(
        db.TIMESTAMP, server_default=db.func.current_timestamp(), nullable=False
    )
    rfid_id = db.Column(
        db.Integer, db.ForeignKey("rfid.id", ondelete="CASCADE"), nullable=False
    )
    rfid = db.relationship("Rfid", backref=db.backref("users", lazy="dynamic"))

    def __init__(self, user_name, rfid_id, password) -> None:
        self.user_name = user_name
        self.rfid_id = rfid_id
        self.password = password

    def __repr__(self) -> str:
        return "<id {}>".format(self.id)

    def serialize(self):
        return {
            "id": self.id,
            "user_name": self.user_name,
            "creation_date": self.creation_date,
            "rfid_id": self.rfid_id,
            "password": self.password,
        }


class Rfid(db.Model):
    __tablename__ = "rfid"

    id = db.Column(db.Integer, primary_key=True)
    rfid = db.Column(db.String(), nullable=False)
    object = db.Column(db.String(), nullable=False)

    def __init__(self, id, rfid, object):
        self.id = id
        self.object = object
        self.rfid = rfid

    def __repr__(self) -> str:
        return "<id {}>".format(self.id)

    def serialize(self):
        return {"id": self.id, "rfid": self.rfid, "object": self.object}


class Activity(db.Model):
    __tablename__ = "activity_log"

    id = db.Column(db.Integer, primary_key=True)
    rfid_id = db.Column(
        db.Integer, db.ForeignKey("rfid.id", ondelete="CASCADE"), nullable=False
    )
    type = db.Column(db.String(), nullable=False)
    log = db.Column(db.String(), nullable=False)

    def __init__(self, id, rfid_id, type, log):
        self.id = id
        self.rfid_id = rfid_id
        self.type = type
        self.log = log

    def __repr__(self) -> str:
        return "<id {}>".format(self.id)

    def serialize(self):
        return {
            "id": self.id,
            "rfid_id": self.rfid_id,
            "type": self.type,
            "log": self.log,
        }


class RfidSchema(ma.Schema):
    id = fields.Integer()
    rfid = fields.String(required=True)
    object = fields.String(required=True)


class UserSchema(ma.Schema):
    id = fields.Integer(dump_only=True)
    rfid_id = fields.Integer(required=False)
    user_name = fields.String(
        required=True, allow_none=False, validate=validate.Length(1)
    )
    password = fields.String(required=True, allow_none=False)
    creation_date = fields.DateTime()


class ActivitySchema(ma.Schema):
    id = fields.Integer(dump_only=True)
    rfid_id = fields.Integer(required=True)
    type = fields.String(required=True, allow_none=False)
    log = fields.String(required=True, allow_none=False)

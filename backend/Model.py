from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy


ma = Marshmallow()
db = SQLAlchemy()


class User(db.Model):
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(250), nullable=False)
    creation_date = db.Column(
        db.TIMESTAMP, server_default=db.func.current_timestamp(), nullable=False
    )
    rfid_id = db.Column(
        db.Integer, db.ForeignKey("rfid.id", ondelete="CASCADE"), nullable=False
    )
    rfid = db.relationship("Rfid", backref=db.backref("user", lazy="dynamic"))

    def __init__(self, user, rfid_id):
        self.user = user
        self.rfid_id = rfid_id


class Rfid(db.Model):
    __tablename__ = "rfid"
    id = db.Column(db.Integer, primary_key=True)
    object_registration = db.Column(db.String(150), nullable=False)

    def __init__(self, object_registration):
        self.object_registration = object_registration


class RfidSchema(ma.Schema):
    id = fields.Integer()
    object_registration = fields.String(required=True)


class UserSchema(ma.Schema):
    id = fields.Integer(dump_only=True)
    rfid_id = fields.Integer(required=True)
    name = fields.String(required=True, validate=validate.Length(1))
    creation_date = fields.DateTime()

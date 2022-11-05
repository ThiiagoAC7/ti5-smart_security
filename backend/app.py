from flask import Blueprint
from flask_restful import Api
from resources.Register import Register
from resources.Signin import Signin
from resources.Rfid import RfidRegistration
from resources.LogActivity import LogActivity

api_bp = Blueprint("api", __name__)
api = Api(api_bp)

# Route
api.add_resource(Register, "/register")
api.add_resource(Signin, "/signin")
api.add_resource(RfidRegistration, "/rfid_registration")
api.add_resource(LogActivity, "/log_activity")

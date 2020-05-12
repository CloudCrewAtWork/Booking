
import firebase_admin

from firebase_admin import credentials
from firebase_admin import db
from firebase_admin import auth


cred = credentials.Certificate('fireBaseSdk.json')
firebase_admin.initialize_app(cred)

uid = "0EatQkn1BNhUshIRmuxGZOPuInN2"
user = auth.get_user(uid)
print('Successfully fetched user data: {0}'.format(user.email))





custom_token = auth.create_custom_token(uid)
# print(custom_token)
print(custom_token)

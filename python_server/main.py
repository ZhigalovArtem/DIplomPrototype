import jwt
import db
import hashPassword

from flask import Flask, jsonify, render_template, request, redirect, url_for, make_response
from flask_jwt_extended import (
    JWTManager, create_access_token,
    jwt_required, get_jwt_identity
)

app = Flask(__name__)

app.config["JWT_SECRET_KEY"] = "prototype"  # В продакшене используйте env-переменную!
app.config["JWT_TOKEN_LOCATION"] = ["cookies"]
app.config["JWT_COOKIE_HTTPONLY"] = True
app.config["JWT_COOKIE_SECURE"] = True  # Только HTTPS (в продакшене обязательно!)
jwt = JWTManager(app)

# Главная страница
@app.route('/')
def index():
    # return "Flask test"
    response = make_response(jsonify({
        'msg': "Flask test"
    }), 200)
    return response

@app.route('/registration', methods = ['POST', 'GET']) #регистрация пользовтаеля
def registration():
    if request.method == 'POST':
        password = request.form.get('password')
        login = request.form.get('login')

        ##проверка на существование такого пользователя
        if not db.userExists(login):
            db.create_user(login=login, password=hashPassword.hashPassword(password))
            return ('Ok', 200)
        else:
            return 'User exists'
        
@app.route('/login', methods = ['POST', 'GET']) #авторизация пользователя
def login():
    if request.method == 'POST':
        login = request.form.get('login')
        password = request.form.get('password')

        try:
            userInfo = db.getUser(login=login)
            if userInfo != 'None':
                print(f'userInfo: {userInfo}')
            else:
                print(f'userInfo: {userInfo}')
                return ('Login not found', 404)
        except:
            print('Unable to get user info')
            return False
        
        try:
            if hashPassword.checkPassword(password= password, hashedPassword= userInfo['password']):
                accessToken = create_access_token(identity=login)
                response = make_response(jsonify({
                    'msg': 'Success login',
                    'user': login
                }), 200)
                response.set_cookie(
                    'access_token_cookie',
                    value = accessToken,
                    httponly=True,
                    secure=True,
                    samesite='Lax'
                )
                return response
        except Exception as e:
            print(f'\n\nOccured exception: {e}')
            print(f'\n\n Didnt login')
            return False



if __name__ == '__main__':
    app.run(ssl_context = 'adhoc', debug=True, threaded = True, port = 443)


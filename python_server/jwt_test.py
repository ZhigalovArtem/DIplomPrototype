import jwt
import datetime

secret_key = 'test'

payload = {
    'user_id': 1,
    'email': 'test@test.ru',
}

token = jwt.encode(payload, secret_key, algorithm = 'HS256')

print(f'Generated token: {token}')


decoded_token = jwt.decode(token, secret_key, algorithms = ['HS256'])
print(f'Decoded token: {decoded_token}')
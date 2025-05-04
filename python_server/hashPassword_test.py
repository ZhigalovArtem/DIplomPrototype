from argon2 import PasswordHasher


ph = PasswordHasher()

def hash_password(password):
    return ph.hash(password)

def check_password(password, hash_password):
    try:
        ph.verify(hash_password, password)
        print('---------------')
        print(ph.verify(hash_password, password))
        return True
    except:
        return False
    
password = input('Enter password: ')
hashed_password = hash_password(password)

print(f'Password: {password}\nHashed password: {hashed_password}')

password = input('Retype password: ')

if check_password(password, hashed_password):
    print('Correct password')
else:
    print('Incorrect password')
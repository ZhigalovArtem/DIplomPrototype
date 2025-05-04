from argon2 import PasswordHasher
import db

ph = PasswordHasher()

def hashPassword(password):
    return ph.hash(password)

def checkPassword(password, hashedPassword):
    try:        
        ph.verify(hash=hashedPassword, password= password)
        return True
    except:
        return False
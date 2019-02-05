import random, string

def id(num):
    pool = string.ascii_letters + string.digits
    return str(''.join(random.choice(pool) for i in range(num)))

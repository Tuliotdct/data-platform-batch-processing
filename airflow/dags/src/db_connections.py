from sqlalchemy import create_engine, URL
from .aws_secrets import get_secret


def get_connection():

    secret = get_secret()

    url_object = URL.create(
        drivername = 'postgresql+psycopg2',
        username = secret['username'],
        password = secret['password'],
        host = secret['host'],
        port = secret['port'],
        database= secret['dbname']
    )

    engine = create_engine(url_object)

    return engine

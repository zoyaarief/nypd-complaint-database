import pymysql
import warnings
from getpass import getpass
#from cryptography.utils import CryptographyDeprecationWarning

#warnings.filterwarnings("ignore", category=CryptographyDeprecationWarning)

def get_db_connection():
    username = "root"
    password = "isbMB3rV"
    try:
        conn = pymysql.connect(
            host="127.0.0.1",
            user=username,
            password=password,
            db='nypd_database1'
        )
        return conn
    except pymysql.MySQLError as e:
        print("Error connecting to MySQL:", e)
        return None

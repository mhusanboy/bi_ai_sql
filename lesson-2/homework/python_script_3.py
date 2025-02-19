import pyodbc 
from pathlib import Path
current_dir = Path(__file__).resolve().parent

uid = 'sa'
server = 'localhost'
port = 1433
database = 'master'
pwd = '1234qwerASDF'


con_str = f'DRIVER=FreeTDS;SERVER={server};PORT={port};DATABASE={database};UID={uid};PWD={pwd};TDS_VERSION=7.3'


con = pyodbc.connect(con_str)
cursor = con.cursor()

cursor.execute("select * from photos")
row = cursor.fetchone()
image_id, image_data = row 

with open(current_dir/'files/apple_saved.png','wb') as f:
    f.write(image_data)
import _paths as path
import os.path

from sqlalchemy import create_engine, Column, DateTime, Float, Integer, String
from sqlalchemy.ext.declarative import declarative_base

project_path, db_path = path.project_path(), path.db_path()
db_dir = os.path.join(project_path + db_path)
db = create_engine('sqlite:///' + db_dir + 'mke_wibrs_db.db', echo = False)
Base = declarative_base()

class mke_wibrs_db(Base):

    __tablename__ = "mke_wibrs_db"

    incident_number = Column(String, primary_key = True)
    date = Column(DateTime)
    addr = Column(String)
    zip_code = Column(String)
    x_lon = Column(Float)
    y_lat = Column(Float)
    formatted_addr = Column(String)
    ald_dist = Column(String)
    mpd_dist = Column(String)
    voting_ward = Column(String)
    wpn_force = Column(String)
    code_200 = Column(Integer)
    code_13 = Column(Integer)
    code_220 = Column(Integer)
    code_290 = Column(Integer)
    code_09 = Column(Integer)
    code_23f = Column(Integer)
    code_120 = Column(Integer)
    code_11_36 = Column(Integer)
    code_23 = Column(Integer)
    code_240 = Column(Integer)
    update_time = Column(DateTime, primary_key = True)

    def __init__(self, incident_number, date, addr, zip_code, x_lon, y_lat, formatted_addr,
                 ald_dist, mpd_dist, voting_ward, wpn_force, code_200, code_13,
                 code_220, code_290, code_09, code_23f, code_120, code_11_36, code_23,
                 code_240, update_time):

        self.incident_number = incident_number
        self.date = date
        self.addr = addr
        self.zip_code = zip_code
        self.x_lon = x_lon
        self.y_lat = y_lat
        self.formatted_addr = formatted_addr
        self.ald_dist = ald_dist
        self.mpd_dist = mpd_dist
        self.voting_ward = voting_ward
        self.wpn_force = wpn_force
        self.code_200 = code_200
        self.code_13 = code_13
        self.code_220 = code_220
        self.code_290 = code_290
        self.code_09 = code_09
        self.code_23f = code_23f
        self.code_120 = code_120
        self.code_11_36 = code_11_36
        self.code_23 = code_23
        self.code_240 = code_240
        self.update_time = update_time

Base.metadata.create_all(db)

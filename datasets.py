import _paths as path
import os.path
import parameters as par_fn

from bokeh.models import ColumnDataSource
from bokeh.plotting import figure
from collections import Counter
from db import *
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

def set_annotate_interact(year, month, violation_code):
    # Build parameters
    params = par_fn.get_parameters()

    months = params[1]
    mo = months[month]

    # Build data
    project_path, db_path = path.project_path(), path.db_path()
    db_dir = os.path.join(project_path + db_path)
    db = create_engine('sqlite:///' + db_dir + 'mke_wibrs_db.db', echo = False)
    Session = sessionmaker(bind = db)
    session = Session()

    query = session.query(mke_wibrs_db).\
                  filter(mke_wibrs_db.date >= year + mo[0],
                         mke_wibrs_db.date <= year + mo[1],
                         getattr(mke_wibrs_db, 'code_' + violation_code) == 1,
                         mke_wibrs_db.addr != None,
                         mke_wibrs_db.zip_code != None,
                         mke_wibrs_db.ald_dist != None,
                         mke_wibrs_db.mpd_dist != None,
                         mke_wibrs_db.ald_dist != 0,
                         mke_wibrs_db.mpd_dist != 0,
                         mke_wibrs_db.voting_ward != None,
                         mke_wibrs_db.x_lon != None,
                         mke_wibrs_db.y_lat != None).all()

    incident_number, date, formatted_addr, ald_dist, mpd_dist = [], [], [], [], []

    for data in query:
        incident_number.append(data.incident_number)
        date.append('{:%Y-%m-%d %H:%M:%S}'.format(data.date))
        formatted_addr.append(data.formatted_addr)
        ald_dist.append(data.ald_dist)
        mpd_dist.append(data.mpd_dist)
    session.close()

    # Format data
    ald_dist_int, mpd_dist_int = [int(i) for i in ald_dist], [int(i) for i in mpd_dist]
    ald_dist_cnt, mpd_dist_cnt = Counter(ald_dist_int), Counter(mpd_dist_int)
    ald_dist_srt, mpd_dist_srt = sorted(ald_dist_cnt.items()), sorted(mpd_dist_cnt.items())

    # Aldermanic districts & violation counts
    ald_dist = [str(i[0]) for i in ald_dist_srt]
    ald_dist_cnt = [i[1] for i in ald_dist_srt]

    # MPD districts & violation counts
    mpd_dist = [str(i[0]) for i in mpd_dist_srt]
    mpd_dist_cnt = [i[1] for i in mpd_dist_srt]

    ald_source = ColumnDataSource(data = dict(ald_dist = ald_dist, ald_dist_cnt = ald_dist_cnt))
    mpd_source = ColumnDataSource(data = dict(mpd_dist = mpd_dist, mpd_dist_cnt = mpd_dist_cnt))
    ald_tool_tips = [('District', '@ald_dist'), ('Count','@ald_dist_cnt')]
    mpd_tool_tips = [('District', '@mpd_dist'), ('Count','@mpd_dist_cnt')]

    ald_p = figure(x_range = ald_dist,
                   plot_height = 275,
                   plot_width = 750,
                   toolbar_location = 'right',
                   tools = 'hover',
                   tooltips = ald_tool_tips)

    mpd_p = figure(x_range = mpd_dist,
                   plot_height = 275,
                   plot_width = 750,
                   toolbar_location = 'right',
                   tools = 'hover',
                   tooltips = mpd_tool_tips)

    ald_p.vbar(x = 'ald_dist',
               top = 'ald_dist_cnt',
               color = '#0b5394',
               width = 0.8,
               source = ald_source)

    mpd_p.vbar(x = 'mpd_dist',
               top = 'mpd_dist_cnt',
               color = '#0b5394',
               width = 0.8,
               source = mpd_source)

    ald_p.xgrid.grid_line_color, mpd_p.xgrid.grid_line_color, ald_p.toolbar.logo, mpd_p.toolbar.logo = None, None, None, None
    ald_p.y_range.start, mpd_p.y_range.start = 0, 0

    # Dataset metrics
    vio_cnt = sum(ald_dist_cnt)

    return ald_p, mpd_p, vio_cnt

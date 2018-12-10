import os.path
import kde as mkde

from bokeh.models import Label
from bokeh.plotting import ColumnDataSource, figure

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from db import *

from time import sleep

def get_parameters():
    # Build most parameters needed to pass arguments
    years = ['2018',
             '2017',
             '2016']

    months = {'January':['-01-01', '-01-31'],\
              'February':['-02-01', '-02-28'],\
              'March':['-03-01', '-03-31'],\
              'April':['-04-01', '-04-30'],\
              'May':['-05-01', '-05-31'],\
              'June':['-06-01', '-06-30'],\
              'July':['-07-01', '-07-31'],\
              'August':['-08-01', '-08-31'],\
              'September':['-09-01', '-09-30'],\
              'October':['-10-01', '-10-31'],\
              'November':['-11-01', '-11-30'],\
              'December':['-12-01', '-12-31']}

    codes = {#'Arson':'200',
             'Assault Offenses':'13',
             'Burglary/Breaking & Entering':'220',
             'Destruction/Damage/Vandalism of Property':'290',
            # 'Homicide Offenses':'09',
             'Theft From Motor Vehicle':'23f',
             'Robbery':'120',
            # 'Sex Offenses':'11_36',
             'Larceny/Theft Offenses':'23',
             'Motor Vehicle Theft':'240'}

    kernels = {'Gaussian':'gaussian',
               'Tophat':'tophat',
               'Epanechnikov':'epanechnikov',
              # 'Exponential':'exponential',
               'Linear':'linear'}#,
              # 'Cosine':'cosine'}

    bandwidths = [0.0025,
                  0.005,
                  0.0075,
                  0.01]

    metrics = {'Euclidean':'euclidean',
               'Manhattan':'manhattan',
               'Chebyshev':'chebyshev',
               'Haversine':'haversine'}

    return years, months, codes, kernels, bandwidths, metrics

    months = [month for month in months.keys()]
    codes = [code for code in codes.keys()]
    metrics = [metric for metric in metrics.keys()]

def set_startup():
    # Build startup session
    tools = 'save'
    tool_tips = [('WIBRS', '@i'), ('Address','@a'), ('Date', '@d'), ('Ald/MPD', '@ald, @m')]

    # tools, act_drag, act_scroll = 'pan, wheel_zoom, reset, save', 'pan', 'wheel_zoom'

    x_range, y_range = [-88.080736, -87.839722], [42.917670, 43.19712]

    p = figure(plot_width = 606,
               plot_height = 700,
               x_range = x_range,
               y_range = y_range,
               tools = tools) #,
              # active_drag = act_drag,
              # active_scroll = act_scroll)

    p.xgrid.grid_line_color, p.ygrid.grid_line_color = None, None

    p.image_url(url = ['plot_path'], # Declare plot path
                x = x_range[0],
                y = y_range[1],
                w = x_range[1] - x_range[0],
                h = y_range[1] - y_range[0])

    return p

def set_interact(year, month, violation_code, kernel, bandwidth, metric):
    # Build parameters
    params = get_parameters()

    codes = {'200':'Arson',
             '13':'Assault Offenses',
             '220':'Burglary/Breaking & Entering',
             '290':'Destruction/Damage/Vandalism of Property',
             '09':'Homicide Offenses',
             '23f':'Theft From Motor Vehicle',
             '120':'Robbery',
             '11_36':'Sex Offenses',
             '23':'Larceny/Theft Offenses',
             '240':'Motor Vehicle Theft'}

    months = params[1]
    mo, bw = months[month], str(bandwidth).replace('.', '')

    # Build data
    project_path, db_path = 'project_path', 'db_path' # Declare project path and database path
    db_dir = os.path.join(project_path + db_path)
    db = create_engine('sqlite:///' + db_dir + 'mke_wibrs_db.db', echo = False)
    Session = sessionmaker(bind = db)
    session = Session()

    query = session.query(mke_wibrs_db).\
                   filter(mke_wibrs_db.date >= year + mo[0],
                          mke_wibrs_db.date <= year + mo[1],
                          getattr(mke_wibrs_db, 'code_' + violation_code) == 1,
                          mke_wibrs_db.x_lon != None,
                          mke_wibrs_db.y_lat != None).all()

    x_lon, y_lat, incident_number, date, formatted_addr, ald_dist, mpd_dist = [], [], [], [], [], [], []

    for data in query:
        x_lon.append(data.x_lon)
        y_lat.append(data.y_lat)
        incident_number.append(data.incident_number)
        date.append('{:%Y-%m-%d %H:%M:%S}'.format(data.date))
        formatted_addr.append(data.formatted_addr)
        ald_dist.append(data.ald_dist)
        mpd_dist.append(data.mpd_dist)
    session.close()

    # Build plots/hover tooltips
    source = ColumnDataSource(data = dict(x = x_lon,
                                          y = y_lat,
                                          i = incident_number,
                                          d = date, a = formatted_addr,
                                          ald = ald_dist,
                                          m = mpd_dist))

    tools = 'save'
    tool_tips = [('WIBRS', '@i'), ('Address','@a'), ('Date', '@d'), ('Ald/MPD', '@ald, @m')]

    # tools, act_drag, act_scroll, tool_tips = 'pan, wheel_zoom, reset, save',\
    #                                          'pan', 'wheel_zoom',\
    #                                          [('WIBRS', '@i'),\
    #                                          ('Address','@a'),\
    #                                          ('Date', '@d'),\
    #                                          ('Ald/MPD', '@ald, @m')]

    x_range, y_range = [-88.080736, -87.839722], [42.917670, 43.19712]

    p = figure(width = 606,
               height = 700,
               x_range = x_range,
               y_range = y_range,
               tooltips = tool_tips,
               tools = tools) #,
              # active_drag = act_drag,
              # active_scroll = act_scroll)

    layout_moyr = Label(x = -87.93,
                        y = 43.177,
                        text = month + ' ' + year,
                        text_color = 'black',
                        text_font = 'helvetica',
                        text_font_size = '0.68em',
                        text_font_style = None)
    layout_vio = Label(x = -87.93,
                       y = 43.17, text = codes[violation_code],
                       text_color = 'black',
                       text_font = 'helvetica',
                       text_font_size = '0.68em',
                       text_font_style = None)
    layout_cnt = Label(x = -87.93,
                       y = 43.163,
                       text = 'Count: ' + str(len(incident_number)),
                       text_color = 'black',
                       text_font = 'helvetica',
                       text_font_size = '0.68em',
                       text_font_style = None)
    layout_ker = Label(x = -88.05,
                       y = 42.945,
                       text = 'Kernel: ' + kernel,
                       text_color = 'black',
                       text_font = 'helvetica',
                       text_font_size = '0.68em',
                       text_font_style = None)
    layout_bw = Label(x = -88.05,
                      y = 42.938, text = 'Bandwidth: ' + bandwidth,
                      text_color = 'black',
                      text_font = 'helvetica',
                      text_font_size = '0.68em',
                      text_font_style = None)
    layout_met = Label(x = -88.05,
                       y = 42.931,
                       text = 'Metric: ' + metric,
                       text_color = 'black',
                       text_font = 'helvetica',
                       text_font_size = '0.68em',
                       text_font_style = None)

    p.add_layout(layout_moyr), p.add_layout(layout_vio), p.add_layout(layout_cnt),
    p.add_layout(layout_ker), p.add_layout(layout_bw), p.add_layout(layout_met)

    p.xgrid.grid_line_color, p.ygrid.grid_line_color = None, None

    # Retrieve/create KDE
    f_yr, f_mo, f_vc, f_ke, f_bw, f_me = str(year), month.lower()[:3], str(violation_code), kernel.lower()[:3], str(bandwidth).replace('.', ''), metric.lower()[:3]
    plot_file = os.path.isfile('plot_path' % (f_yr, f_mo, f_vc, f_ke, f_bw, f_me)) # Declare plot path and plot name

    if plot_file:
        p.image_url(url = ['plot_path' % (f_yr, f_mo, f_vc, f_ke, f_bw, f_me)], # Declare plot path and plot name
                    x = x_range[0],
                    y = y_range[1],
                    w = x_range[1] - x_range[0],
                    h = y_range[1] - y_range[0])

    else:
        kde_bw = float(bandwidth)
        mkde.exe_kde(x_lon, y_lat, year, month, violation_code, kernel, kde_bw, metric)
        sleep(3)
        p.image_url(url = ['plot_path' % (f_yr, f_mo, f_vc, f_ke, f_bw, f_me)], # Declare plot path and plot name
                           x = x_range[0],
                           y = y_range[1],
                           w = x_range[1] - x_range[0],
                           h = y_range[1] - y_range[0])

    p.square(x = 'x',
             y = 'y',
             size = 20,
             color = 'blue',
             fill_alpha = 0.0,
             line_color = None,
             source = source)

    # p.circle(x = 'x',
    #          y = 'y',
    #          size = 10,
    #          color = 'blue',
    #          fill_alpha = 0.0,
    #          line_color = None,
    #          source = source)

    return p

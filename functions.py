import _paths as path
import os.path
import kde as kde_fn
import parameters as par_fn

from bokeh.models import HoverTool, Label, LabelSet, PointDrawTool
from bokeh.models import ColumnDataSource as cds
from bokeh.plotting import ColumnDataSource, figure
from db import *
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from time import sleep

def set_kde_startup():
    # Build startup session
    plot_path_short = path.plot_path_short()

    x_range, y_range = [-88.080736, -87.839722], [42.917670, 43.19712]

    p = figure(plot_width = 606,
               plot_height = 700,
               x_range = x_range,
               y_range = y_range,
               tools = 'save')

    plot_title_label = Label(x = -87.89,
                             y = 43.187,
                             text = 'Milwaukee, WI',
                             text_font = 'helvetica',
                             text_font_size = '14px',
                             text_color = '#41444B',
                             text_font_style = 'bold')

    p.add_layout(plot_title_label)
    p.xgrid.grid_line_color, p.ygrid.grid_line_color, p.toolbar.logo = None, None, None
    p.xaxis.visible, p.yaxis.visible = False, False

    p.image_url(url = [plot_path_short + 'mke.png'],
                x = x_range[0],
                y = y_range[1],
                w = x_range[1] - x_range[0],
                h = y_range[1] - y_range[0])

    return p

def set_kde_interact(year, month, violation_code, kernel, bandwidth, metric):
    # Build parameters
    params = par_fn.get_parameters()

    codes = {'200':'Arson',
             '13':'Assault Offenses',
             '220':'Burglary/Breaking & Entering',
             '290':'Destruction/Damage/Vandalism of Property',
             '09':'Homicide Offenses',
             '23f':'Theft from Motor Vehicle',
             '120':'Robbery',
             '11_36':'Sex Offenses',
             '23':'Larceny/Theft Offenses',
             '240':'Motor Vehicle Theft'}

    months = params[1]
    mo, bw = months[month], str(bandwidth).replace('.', '')

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
                          mke_wibrs_db.voting_ward != None,
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

    # Build plot & labels
    tt_src = ColumnDataSource(data = dict(x = x_lon,
                                          y = y_lat,
                                          i = incident_number,
                                          d = date,
                                          a = formatted_addr,
                                          ald = ald_dist,
                                          m = mpd_dist))

    x_range, y_range = [-88.080736, -87.839722], [42.917670, 43.19712]

    p = figure(width = 606,
               height = 700,
               x_range = x_range,
               y_range = y_range,
               tools = 'save')

    plot_title_label = Label(x = -87.89,
                             y = 43.187,
                             text = 'Milwaukee, WI',
                             text_font = 'helvetica',
                             text_font_size = '14px',
                             text_color = '#41444B',
                             text_font_style = 'bold')

    label_src = ColumnDataSource(data = dict(x = [-88.07, -88.07, -88.07, -88.07, -88.07],
                                             y = [42.955, 42.948, 42.941, 42.934, 42.927],
                                             txt = [month + ' ' + year,
                                                    codes[violation_code],
                                                    'Kernel: ' + kernel,
                                                    'Bandwidth: ' + bandwidth,
                                                    'Metric: ' + metric]))

    plot_labels = LabelSet(x = 'x',
                           y = 'y',
                           text = 'txt',
                           text_font = 'helvetica',
                           text_font_size = '8px',
                           text_color = '#41444B',
                           source = label_src)

    hs_src = ColumnDataSource(data = dict(x = [-87.93, -87.93, -87.93],
                                          y = [43.155, 43.148, 43.141],
                                          txt = ['Hotspot identification:',
                                                 '- Click the Point Draw Tool in the upper right corner',
                                                 '- Drag and drop icons on identified hotspots']))

    hs_labels = LabelSet(x = 'x',
                         y = 'y',
                         text = 'txt',
                         text_font = 'helvetica',
                         text_font_size = '12px',
                         text_color = '#41444B',
                         source = hs_src)

    p.add_layout(plot_title_label), p.add_layout(plot_labels), p.add_layout(hs_labels)
    p.xgrid.grid_line_color, p.ygrid.grid_line_color, p.toolbar.logo, = None, None, None
    p.xaxis.visible, p.yaxis.visible = False, False

    # Retrieve/create KDE
    f_yr, f_mo, f_vc = str(year), month.lower()[:3], str(violation_code)
    f_ke, f_bw, f_me = kernel.lower()[:3], str(bandwidth).replace('.', ''), metric.lower()[:3]
    plot_path_long = path.plot_path_long()
    plot_file = os.path.isfile(plot_path_long + '%s%s%s%s%s%s.png' % (f_yr, f_mo, f_vc, f_ke, f_bw, f_me))

    if plot_file:
        plot_path_short = path.plot_path_short()
        p.image_url(url = [plot_path_short + '%s%s%s%s%s%s.png' % (f_yr, f_mo, f_vc, f_ke, f_bw, f_me)],
                    x = x_range[0],
                    y = y_range[1],
                    w = x_range[1] - x_range[0],
                    h = y_range[1] - y_range[0])

    else:
        plot_path_short = path.plot_path_short()
        kde_bw = float(bandwidth)
        kde_fn.exe_kde(x_lon, y_lat, year, month, violation_code, kernel, kde_bw, metric)
        sleep(3)
        p.image_url(url = [plot_path_short + '%s%s%s%s%s%s.png' % (f_yr, f_mo, f_vc, f_ke, f_bw, f_me)],
                           x = x_range[0],
                           y = y_range[1],
                           w = x_range[1] - x_range[0],
                           h = y_range[1] - y_range[0])

    events = p.square(x = 'x',
                      y = 'y',
                      size = 20,
                      color = 'blue',
                      fill_alpha = 0.0,
                      line_color = None,
                      source = tt_src)

    tt_hover = HoverTool(tooltips = [('WIBRS', '@i'), ('Address','@a'), ('Date', '@d'), ('Ald/MPD', '@ald, @m')],
                         renderers = [events])
    p.add_tools(tt_hover)

    # Hotspot identification
    hs_src = cds({'x': [-87.9305, -87.911, -87.8915, -87.872, -87.8525],
                  'y': [43.17, 43.17, 43.17, 43.17, 43.17]})

    hs_render = p.circle_cross(x = 'x',
                               y = 'y',
                               size = 40,
                               color = 'green',
                               fill_alpha = 0.25,
                               line_width = 1,
                               source = hs_src)

    hs_plot = PointDrawTool(renderers = [hs_render],
                            empty_value = None,
                            add = False)

    p.add_tools(hs_plot)

    p.toolbar.active_tap = hs_plot

    return p

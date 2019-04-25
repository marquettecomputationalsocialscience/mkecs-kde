import csv, datetime, os.path

import _paths as path
import _session as session_id
import functions as fn
import datasets as ds_fn
import parameters as par_fn

from bokeh.embed import components
from flask import Flask, redirect, render_template, request, session, url_for

app = Flask(__name__)
app.secret_key = session_id.id(50)

@app.route('/mkecs-kde-tos', methods = ['GET', 'POST'])
def mkecs_kde_session():

    project_path, sessions_path = path.project_path(), path.sessions_path()
    sessions_dir = os.path.join(project_path + sessions_path)

    if request.method == 'POST':
        id = []
        tos_form = request.form.getlist('tos_form_submit_concur_cb')
        if 'concur' in tos_form:
            _id = session_id.id(25)
            id.append(_id)
        with open(sessions_dir, 'a') as sessions_w:
            sessions_w.write(id[0] + ',' + str(datetime.datetime.now()) + '\n')
        session['username'] = id[0]
        return redirect(url_for('kde_startup'))

    return render_template('mkecs-kde_tos.html')

@app.route('/mkecs-kde-tos/', methods = ['GET', 'POST'])
def mkecs_kde_session_end():

    session.pop('username', None)
    return redirect(url_for('mkecs_kde_session'))

@app.route('/mkecs-kde', methods = ['GET'])
def kde_startup():

    try:

      project_path, sessions_path = path.project_path(), path.sessions_path()
      sessions_dir = os.path.join(project_path + sessions_path)

      id = []

      with open(sessions_dir, 'rt') as sessions_r:
        active = csv.reader(sessions_r, delimiter = ',')
        for _id in active:
          if session['username'] in _id[0]:
            id.append(session['username'])

      if session['username'] in id:

        params = par_fn.get_parameters()

        years, months, codes, kernels, bandwidths, metrics = params[0],\
                                                             params[1],\
                                                             params[2],\
                                                             params[3],\
                                                             params[4],\
                                                             params[5]

        months, codes, metrics = [month for month in months.keys()],\
                                 [code for code in codes.keys()],\
                                 [metric for metric in metrics.keys()]

        kde = fn.set_kde_startup()
        kde_script, kde_div = components(kde)

        session_status = 'App ready.'

        return render_template('mkecs-kde.html',
                               kde_script = kde_script,
                               kde_div = kde_div,
                               months = months,
                               years = years,
                               codes = codes,
                               kernels = kernels,
                               bandwidths = bandwidths,
                               metrics = metrics,
                               session_status = session_status,
                               session_id = session['username'])
    except:

      return redirect(url_for('mkecs_kde_session'))

@app.route('/mkecs-kde', methods = ['GET', 'POST'])
def kde_interact():

    try:

      project_path, sessions_path = path.project_path(), path.sessions_path()
      sessions_dir = os.path.join(project_path + sessions_path)

      id = []

      with open(sessions_dir, 'rt') as sessions_r:
        active = csv.reader(sessions_r, delimiter = ',')
        for _id in active:
          if session['username'] in _id[0]:
            id.append(session['username'])

      if session['username'] in id:

        params = par_fn.get_parameters()

        years, months, codes, kernels, bandwidths, metrics = params[0],\
                                                             params[1],\
                                                             params[2],\
                                                             params[3],\
                                                             params[4],\
                                                             params[5]\

        months, codes, metrics = [month for month in months.keys()],\
                                 [code for code in codes.keys()],\
                                 [metric for metric in metrics.keys()]

        kde = fn.set_kde_startup()
        kde_script, kde_div = components(kde)

        try:

            session_status = 'App ready.'

            if len(request.form) != 0:
                post_year = str(request.form['kde_form_data_year_select'])
                post_month = str(request.form['kde_form_data_month_select'])
                post_violation = str(request.form['kde_form_data_code_select'])
                post_kernel = str(request.form['kde_form_data_kernel_select'])
                post_bandwidth = str(request.form['kde_form_data_bandwidth_select'])
                post_metric = str(request.form['kde_form_data_metric_select'])

                form_input = [post_year,
                              post_month,
                              post_violation,
                              post_kernel,
                              float(post_bandwidth),
                              post_metric]

                codes_post = params[2]

                post_violation = codes_post[post_violation]

                kde = fn.set_kde_interact(post_year,
                                          post_month,
                                          post_violation,
                                          post_kernel,
                                          post_bandwidth,
                                          post_metric)

                datasets = ds_fn.set_annotate_interact(post_year, post_month, post_violation)

                ald_dist, mpd_dist = datasets[0], datasets[1]

                kde_script, kde_div = components(kde)
                ald_script, ald_div = components(ald_dist)
                mpd_script, mpd_div = components(mpd_dist)
                vio_cnt = datasets[2]

                return render_template('mkecs-kde_result.html',
                                       kde_script = kde_script,
                                       kde_div = kde_div,
                                       ald_script = ald_script,
                                       ald_div = ald_div,
                                       mpd_script = mpd_script,
                                       mpd_div = mpd_div,
                                       months = months,
                                       years = years,
                                       codes = codes,
                                       kernels = kernels,
                                       bandwidths = bandwidths,
                                       metrics = metrics,
                                       form_input = form_input,
                                       session_status = session_status,
                                       session_id = session['username'],
                                       vio_cnt = vio_cnt)
        except:

            session_status = 'All fields must be selected.'

            kde = fn.set_kde_startup()
            kde_script, kde_div = components(kde)

            return render_template('mkecs-kde.html',
                                   kde_script = kde_script,
                                   kde_div = kde_div,
                                   months = months,
                                   years = years,
                                   codes = codes,
                                   kernels = kernels,
                                   bandwidths = bandwidths,
                                   metrics = metrics,
                                   session_status = session_status,
                                   session_id = session['username'])

        session_status = 'All fields must be selected.'

        return render_template('mkecs-kde.html',
                               kde_script = kde_script,
                               kde_div = kde_div,
                               months = months,
                               years = years,
                               codes = codes,
                               kernels = kernels,
                               bandwidths = bandwidths,
                               metrics = metrics,
                               session_status = session_status,
                               session_id = session['username'])
    except:

      return redirect(url_for('mkecs_kde_session'))

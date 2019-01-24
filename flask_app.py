import functions as fn
import datasets as ds_fn
import parameters as par_fn

from bokeh.embed import components
from flask import Flask, redirect, render_template, request

app = Flask(__name__)

@app.route('/mkecs-kde', methods = ['GET'])
def kde_startup():
    params = par_fn.get_parameters()
    years, months, codes, kernels, bandwidths, metrics = params[0], params[1], params[2],\
                                                         params[3], params[4], params[5]
    months, codes, metrics = [month for month in months.keys()],\
                             [code for code in codes.keys()],\
                             [metric for metric in metrics.keys()]

    kde = fn.set_kde_startup()
    kde_script, kde_div = components(kde)

    session_status = 'App ready.'

    return render_template('mkecs-kde.html', kde_script = kde_script, kde_div = kde_div,
                           months = months, years = years, codes = codes,
                           kernels = kernels,   bandwidths = bandwidths, metrics = metrics,
                           session_status = session_status)

@app.route('/mkecs-kde', methods = ['GET', 'POST'])
def kde_interact():
    params = par_fn.get_parameters()
    years, months, codes, kernels, bandwidths, metrics = params[0], params[1], params[2],\
                                                         params[3], params[4], params[5]
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

            form_input = [post_year, post_month, post_violation,
                          post_kernel, float(post_bandwidth), post_metric]

            codes_post = params[2]
            post_violation = codes_post[post_violation]

            kde = fn.set_kde_interact(post_year, post_month, post_violation,
                                      post_kernel, post_bandwidth, post_metric)

            datasets = ds_fn.set_annotate_interact(post_year, post_month, post_violation)

            ald_dist, mpd_dist = datasets[0], datasets[1]

            kde_script, kde_div = components(kde)
            ald_script, ald_div = components(ald_dist)
            mpd_script, mpd_div = components(mpd_dist)
            vio_cnt = datasets[2]

            return render_template('mkecs-kde_result.html', kde_script = kde_script, kde_div = kde_div,
                                   ald_script = ald_script, ald_div = ald_div,
                                   mpd_script = mpd_script, mpd_div = mpd_div,
                                   months = months, years = years, codes = codes,
                                   kernels = kernels, bandwidths = bandwidths, metrics = metrics,
                                   form_input = form_input, session_status = session_status,
                                   vio_cnt = vio_cnt)
    except:

        session_status = 'All fields must be selected.'

        kde = fn.set_kde_startup()
        kde_script, kde_div = components(kde)

        return render_template('mkecs-kde.html', kde_script = kde_script, kde_div = kde_div,
                               months = months, years = years, codes = codes,
                               kernels = kernels, bandwidths = bandwidths, metrics = metrics,
                               session_status = session_status)

    session_status = 'All fields must be selected.'

    return render_template('mkecs-kde.html', kde_script = kde_script, kde_div = kde_div,
                           months = months, years = years, codes = codes,
                           kernels = kernels, bandwidths = bandwidths, metrics = metrics,
                           session_status = session_status)

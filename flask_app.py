import functions as func
from bokeh.embed import components

from flask import Flask, redirect, render_template, request, url_for

app = Flask(__name__)

@app.route('/')
def rd():
    return redirect('set_path') # Set path

@app.route('/set_path', methods = ['GET', 'POST']) # Set path
def kde_startup():
    params = func.get_parameters()
    years, months, codes, kernels, bandwidths, metrics = params[0], params[1], params[2],\
                                                         params[3], params[4], params[5]
    months, codes, metrics = [month for month in months.keys()],\
                             [code for code in codes.keys()],\
                             [metric for metric in metrics.keys()]
    kde = func.set_startup()
    script, div = components(kde)

    if len(request.form) != 0:
        post_year = str(request.form['kde_form_data_year'])
        post_month = str(request.form['kde_form_data_month'])
        post_violation = str(request.form['kde_form_data_code'])
        post_kernel = str(request.form['kde_form_data_kernel'])
        post_bandwidth = str(request.form['kde_form_data_bandwidth'])
        post_metric = str(request.form['kde_form_data_metric'])

        codes_post = params[2]
        post_violation = codes_post[post_violation]

        kde = func.set_interact(post_year, post_month, post_violation, post_kernel,
                                post_bandwidth, post_metric)

        script, div = components(kde)

    return render_template('kde.html', script = script, div = div, months = months,
                           years = years, codes = codes, kernels = kernels,
                           bandwidths = bandwidths, metrics = metrics)

@app.route('/set_path', methods = ['GET', 'POST']) # Set path
def kde_interact():
    params = func.get_parameters()
    years, months, codes, kernels, bandwidths, metrics = params[0], params[1], params[2],\
                                                         params[3], params[4], params[5]
    months, codes, metrics = [month for month in months.keys()],\
                             [code for code in codes.keys()],\
                             [metric for metric in metrics.keys()]

    if len(request.form) != 0:
        post_year = str(request.form['kde_form_data_year'])
        post_month = str(request.form['kde_form_data_month'])
        post_violation = str(request.form['kde_form_data_code'])
        post_kernel = str(request.form['kde_form_data_kernel'])
        post_bandwidth = str(request.form['kde_form_data_bandwidth'])
        post_metric = str(request.form['kde_form_data_metric'])

        codes_post = params[2]
        post_violation = codes_post[post_violation]

        kde = func.set_interact(post_year, post_month, post_violation, post_kernel,
                                post_bandwidth, post_metric)

        script, div = components(kde)

        return render_template('kde.html', script = script, div = div, months = months,
                                years = years, codes = codes, kernels = kernels,
                                bandwidths = bandwidths, metrics = metrics)

    else:

        return kde_startup()

@app.route('/set_path') # Set path
def home():
    return 'tl:dr'

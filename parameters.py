def get_parameters():
    # Build most parameters needed to pass arguments
    years = ['2017', '2016', '2015', '2014', '2013', '2012']

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
             'Theft from Motor Vehicle':'23f',
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

    bandwidths = [0.0025, 0.005, 0.0075, 0.01]

    metrics = {'Euclidean':'euclidean', 'Manhattan':'manhattan',
               'Chebyshev':'chebyshev'}#, 'Haversine':'haversine'}

    return years, months, codes, kernels, bandwidths, metrics

    months = [month for month in months.keys()]
    codes = [code for code in codes.keys()]
    metrics = [metric for metric in metrics.keys()]

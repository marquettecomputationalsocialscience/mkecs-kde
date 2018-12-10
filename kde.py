import os.path
import matplotlib.pyplot as plt, numpy as np

from matplotlib import colors
from matplotlib.collections import PatchCollection
from matplotlib.patches import Polygon
from mpl_toolkits.basemap import Basemap
from sklearn.neighbors import KernelDensity

def get_shp():

    # Declare paths
    project_path, mke_nbhd_path = 'project_path', 'shp_path' # Declare project path and .shp path
    mke_nbhd = os.path.normpath(project_path + mke_nbhd_path)
    return mke_nbhd

def exe_kde(x_lon, y_lat, year, month, violation_code, kernel, bandwidth, metric):

    # Build shp
    shp = get_shp()

    # Build map
    fig = plt.figure(dpi = 1000)
    ax = fig.add_subplot(111)
    ax.axis('off')

    map = Basemap(projection = 'cyl',
                  resolution = 'h',
                  lat_0 = 43.0389025,
                  lon_0 = -87.9064736,
                  llcrnrlon = -88.080736,
                  llcrnrlat = 42.917670,
                  urcrnrlon = -87.839722,
                  urcrnrlat = 43.19712)

    map.readshapefile(shp, name = 'mke_nbhd')

    patches_mke_nbhd = []

    for info, shape in zip(map.mke_nbhd_info, map.mke_nbhd):
        if info['NEIGHBORHD'] != None:
            patches_mke_nbhd.append(Polygon(np.array(shape), True))

    ax.add_collection(PatchCollection(patches_mke_nbhd,
                                      edgecolor = '#000000',
                                      facecolor = '#bfbfbf',
                                      linewidths = 0.45,
                                      zorder = 5))

    # Build KDE
    k, m, kde_bw = kernel.lower(), metric.lower(), float(bandwidth)
    xy = np.stack([x_lon, y_lat])
    d, n = xy.shape[0], xy.shape[1]
    kde = KernelDensity(kernel = k,
                        bandwidth = kde_bw,
                        metric = m)
    kde.fit(xy.T)
    xmin, xmax, ymin, ymax = -88.080736, -87.839722, 42.917670, 43.19712

    # For all intents and purposes, this is grid size; in other words, this affects
    # resolution of the density plots
    X, Y = np.mgrid[xmin:xmax:1000j, ymin:ymax:1000j]
    positions = np.vstack([X.ravel(), Y.ravel()])
    Z = np.reshape(np.exp(kde.score_samples(positions.T)), X.shape)

    # Build save
    cmap = colors.ListedColormap(['#ffffff', '#ffebeb',
                                  '#ffd8d8', '#ffc4c4',
                                  '#ffb1b1', '#ff9d9d',
                                  '#ff8a8a', '#ff7676',
                                  '#ff6262', '#ff4f4f',
                                  '#ff3b3b', '#ff2828',
                                  '#ff1414'])
    plt.imshow(np.rot90(Z),
               cmap = cmap,
               extent = [xmin, xmax, ymin, ymax],
               alpha = 0.5,
               zorder = 10)
    plt.scatter(x_lon,
                y_lat,
                c = '#0000ff',
                s = 1.75,
                alpha = 0.5,
                linewidths = 0,
                edgecolors = None,
                zorder = 15)

    s_yr, s_mo, s_vc, s_ke, s_bw, s_me = str(year), month.lower()[:3], str(violation_code), kernel.lower()[:3], str(kde_bw).replace('.', ''), metric.lower()[:3]
    plt.savefig('plot_path' % (s_yr, s_mo, s_vc, s_ke, s_bw, s_me), # Declare plot path and plot name
                bbox_inches = 'tight',
                dpi = 1000)

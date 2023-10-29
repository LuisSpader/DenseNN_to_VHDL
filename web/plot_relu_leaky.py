import numpy as np
# from plotly import graph_objects as go
import plotly.graph_objects as go


def relu(x: int = 1):
    # return max(0.0, x).any()
    if x > 0:
        return x
    else:
        return 0


def leaky_relu(x: int = 1, factor: int = 2):
    attenuation = factor ** 2
    if x > 0:
        return x
    else:
        return x/attenuation


# ------------------------------------------------------
# Create random data with numpy
def plot_fx_activations(left: int = -5, right: int = 5, N: int = 21, leaky_attenuation: int = 2):
    np.random.seed(1)

    lin_x = np.linspace(left, right, N)
    data_relu = []
    data_leaky = []
    for i in lin_x:
        data_relu.append(relu(i))
        data_leaky.append(leaky_relu(x=i, factor=leaky_attenuation))

    fig = go.Figure()

    # Add traces
    fig.add_trace(go.Scatter(x=lin_x, y=data_relu,
                             mode='lines',
                             name='ReLU'))
    fig.add_trace(go.Scatter(x=lin_x, y=data_leaky,
                             mode='lines',
                             name='Leaky ReLU'))
    # fig.add_trace(go.Scatter(x=random_x, y=random_y2,
    #                          mode='lines',
    #                          name='lines'))

    fig.update_layout(yaxis_range=[-5, 5])
    fig.update_layout(xaxis_range=[-5, 5])
    fig.update_layout(
        autosize=False,
        width=1000,
        height=350)

    # fig.show()
    return fig


# fig = fig = plot_fx_activations(
#     left=-10, right=10, N=20, leaky_attenuation=2)

# fig.show()

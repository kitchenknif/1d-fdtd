module boundaries

#
# Perfect conductor
#

function perfect_conductor!(field, pos=1)
    field[pos] = 0
end

#
# ABC
#

# Trivial
function trivial_abc!(field, pos=200, right=true)
  if right
    field[pos] = field[pos-1]
  else
    field[pos] = field[pos+1]
  end
end

# Mur ABC, First order
prevValueLeft = 0.0
prevValueRight = 0.0
abcCoefLeft = 0.0
abcCoefRight = 0.0

# function setup_first_order_abc(cezh, chye, pos, right=true)
function setup_first_order_abc!(eps, mu, pos=200, right=true)
    global abcCoefRight, prevValueRight
    global abcCoefLeft, prevValueLeft

    if right
        prevValueRight = 0.0
        temp = 1. / sqrt(mu[pos - 1] * eps[pos])
        #temp = sqrt(cezh[pos] * chye[pos])
        abcCoefRight = (temp - 1.0) / (temp + 1.0)
    else
        prevValueLeft = 0.0
        temp = 1. / sqrt(mu[pos] * eps[pos])
        #temp = sqrt(cezh[pos] * chye[pos])
        abcCoefLeft = (temp - 1.0) / (temp + 1.0)
    end
end

function first_order_diff_abc!(field, pos=200, right=true)
    global abcCoefRight, prevValueRight
    global abcCoefLeft, prevValueLeft

    if right
        field[pos] = prevValueRight + abcCoefRight * (field[pos - 1] - field[pos]);
        prevValueRight = field[pos - 1];
    else
        field[pos] = prevValueLeft + abcCoefLeft * (field[pos + 1] - field[pos]);
        prevValueLeft = field[pos + 1];
    end
end

#
# CPML
#

### TODO

#
# TFSF
#

#function totalfield_scatteredfield!(ez, hy, eps, mu, incidentfield, pos=1, right=true)
#    ez_inc, hy_inc = incidentfield
#    hy[pos] -= hy_inc / globals.imp0 / mu[i]
#    ez[pos+1] += ez_inc * globals.imp0 / eps[i+1]
#end

end

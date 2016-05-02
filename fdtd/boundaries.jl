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

type MurABCFirst
    right::Bool
    coef::Real
    prev::Real
    pos::Int
end


function setup_first_order_abc(eps, mu, pos=200, right=true)
    abc = MurABCFirst( right, 0.0, 0.0, pos);
    if right
        temp = 1. / sqrt(mu[pos - 1] * eps[pos])
        abc.coef = (temp - 1.0) / (temp + 1.0)
    else
        temp = 1. / sqrt(mu[pos] * eps[pos])
        abc.coef = (temp - 1.0) / (temp + 1.0)
    end
    return abc
end

function first_order_diff_abc!(field, abc)
    if abc.right
        field[abc.pos] = abc.prev + abc.coef * (field[abc.pos - 1] - field[abc.pos]);
        abc.prev = field[abc.pos - 1];
    else
        field[abc.pos] = abc.prev + abc.coef * (field[abc.pos + 1] - field[abc.pos]);
        abc.prev = field[abc.pos + 1];
    end
end

#
# CPML
#
### TODO
type CPML
    right::Bool;
end

function setup_CPML()
end

function CPML(ez, hy, cpml)
end

#
# TFSF
#

function totalfield_scatteredfield!(ez, hy, eps, mu, incident, pos=1)
    ez_inc, hy_inc = incident;
    hy[pos] -= hy_inc / globals.imp0;
    ez[pos+1] += ez_inc / sqrt(eps[i+1] * mu[i+1]);
end

end

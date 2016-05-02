include("globals.jl")

module update
using globals

export update_electric_field!
export update_magnetic_field!

#
# Vacuum
#
function update_magnetic_field!(ez, hy)

    # Hack
    size = length(hy)
    if length(hy) == length(ez)
        size -= 1
    end
    #
    #
    for i = 1:size
        hy[i] = hy[i] + (ez[i + 1] - ez[i]) / globals.imp0
    end
end
function update_electric_field!(ez, hy)
    for i = 2:length(ez)
        ez[i] = ez[i] + (hy[i] - hy[i-1]) * globals.imp0
    end
end

#
# Material
#

function update_magnetic_field!(ez, hy, mu)
    for i = 1:length(hy)
        hy[i] = hy[i] + (ez[i + 1] - ez[i]) / globals.imp0 / mu[i]
    end
end
function update_electric_field!(ez, hy, eps)
    for i = 2:length(ez)-1
        ez[i] = ez[i] + (hy[i] - hy[i-1]) * globals.imp0 / eps[i]
    end
end

#
# Lossy
#

function update_magnetic_field!(ez, hy, mu, chyh, chye)
    for i = 1:length(hy)
        hy[i] = chyh[i] * hy[i] + chye[i] * (ez[i + 1] - ez[i]) / globals.imp0 / mu[i]
    end
end

function update_electric_field!(ez, hy, eps, cezh, ceze)
    for i = 2:length(ez)-1
        ez[i] = ceze[i] * ez[i] + cezh[i] * (hy[i] - hy[i-1]) * globals.imp0 / eps[i]
    end
end

end

include("globals.jl")

module update
using globals

export update_electric_field!
export update_magnetic_field!

function update_magnetic_field!(ez, hy)
    for i = 1:length(hy)-1
        hy[i] = hy[i] + (ez[i + 1] - ez[i]) / globals.imp0
    end
end
function update_electric_field!(ez, hy)
    for i = 2:length(ez)
        ez[i] = ez[i] + (hy[i] - hy[i-1]) * globals.imp0
    end
end

end

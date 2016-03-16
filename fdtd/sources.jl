include("globals.jl")

module sources

function hard_gaussian_source!(ez, pos, time, delay=30., width=100.)
    ez[pos] = exp(-(time - delay) * (time - delay) / width);
end

function additive_gaussian_source!(ez, pos, time, delay=30, width=100.)
    ez[pos] += exp(-(time - delay) * (time - delay) / width);
end

function gaussian_source(pos, time, delay=30, width=100.)
    ez_inc = exp(-(time + 0.5 - (-0.5) - delay) * (time + 0.5 - (-0.5) - delay) / width);
    hy_inc = exp(-(time - delay) * (time - delay) / width) / globals.imp0;

    # ez_inc = exp(-((time - pos - delay) / globals.cdtds / width)^2 );
    return ez_inc, hy_inc
end

# function harmonic_source(pos, time, phase=0., amp=1.)
#    ez

end

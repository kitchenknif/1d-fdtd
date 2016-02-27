module sources

export hard_gaussian_source!

function hard_gaussian_source!(ez, pos, time, delay=30., amplitude=100.)
    ez[pos] = exp(-(time - delay) * (time - delay) / amplitude)
end

end

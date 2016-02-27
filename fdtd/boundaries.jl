module boundaries

export pec_boundary!
export pmc_boundary!

function pec_boundary!(ez, pos=1)
    ez[pos] = 0
end

function pmc_boundary!(hy, pos=1)
    hy[pos] = 0
end

function trivial_abc!(ez, pos=1, right=true)
  if right
    ez[pos] = ez[pos-1]
  else
    ez[pos] = ez[pos+1]
  end
end


end

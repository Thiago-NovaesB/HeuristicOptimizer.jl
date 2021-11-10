m = Model(GLPK.Optimizer)

@variable(m, x ≥ 0)

lista = []

push!(lista,@expression(m, x-1))
push!(lista,@expression(m, x-2))
push!(lista,@expression(m, x-3))

using JuMP
using MathOptInterface
using GLPK


model = Model(GLPK.Optimizer)
@variable(model, x>=1)
@variable(model, y>=0)
@constraint(model, x + y >= 3)
@constraint(model, x + y >= 2)
@objective(model, Min, x + y)


m = HeuristicOptimizer.heuristicCreate(model)
HeuristicOptimizer.removeConstrains!(m)
optimize!(m.model)
HeuristicOptimizer.updateFunctionValue!(m)
HeuristicOptimizer.updateViolation!(m)
@show m.violation
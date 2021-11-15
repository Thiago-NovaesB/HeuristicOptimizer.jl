using JuMP
using MathOptInterface
using GLPK
using Test
using MathOptSetDistances
const MOI = MathOptInterface
const MOIU = MOI.Utilities
const MOD = MathOptSetDistances

variable_primal(model) = x -> MOI.get(model, MOI.VariablePrimal(), x)

model = Model(GLPK.Optimizer)
@variable(model, x>=1)
@variable(model, y>=0)
@constraint(model,c1, x + y >= 3)
@constraint(model,c2, x + y >= 2)
@objective(model, Min, x + y)
optimize!(model)

varval = variable_primal(backend(model))
f = JuMP.MOI.get(model, JuMP.MOI.ConstraintFunction(), c2)

delete(model,c2)
val  = MOIU.eval_variables(varval, f)

# m = HeuristicOptimizer.heuristicCreate(model)
# HeuristicOptimizer.removeConstrains!(m)
# optimize!(m.model)
# HeuristicOptimizer.updateFunctionValue!(m)
# HeuristicOptimizer.updateViolation!(m)
# @show m.violation

c = f, s
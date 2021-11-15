module HeuristicOptimizer

using JuMP
using MathOptInterface
using GLPK
using Test
using MathOptSetDistances
const MOI = MathOptInterface
const MOIU = MOI.Utilities
const MOD = MathOptSetDistances

export removeConstrains,heuristicCreate,updateFunctionValue!,updateViolation!,variable_primal

include("types.jl")
include("modification.jl")

end # module
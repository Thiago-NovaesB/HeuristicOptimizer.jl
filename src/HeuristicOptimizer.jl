module HeuristicOptimizer

using JuMP
using MathOptInterface
using GLPK
using Test
using MathOptSetDistances
const MOI = MathOptInterface
const MOD = MathOptSetDistances

export removeConstrains,heuristicCreate,updateFunctionValue!,updateViolation!

include("types.jl")
include("modification.jl")

end # module
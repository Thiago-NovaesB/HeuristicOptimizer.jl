using JuMP
using MathOptInterface
using GLPK
using MathOptSetDistances
const MOI = MathOptInterface
const MOD = MathOptSetDistances
model = Model(GLPK.Optimizer)
@variable(model, x>=0)
@variable(model, y)
@constraint(model, c1, 2x + y <= 4)
@constraint(model, c2, x + 2y -5 == 0)
@objective(model, Max, 3x + 3y)

f = JuMP.MOI.get(m, JuMP.MOI.ConstraintFunction(), c2)
s = JuMP.MOI.get(m, JuMP.MOI.ConstraintSet(), c2)

delete(m,c2)

optimize!(m)
termination_status(m)
objective_value(m)

z = 0
z += f.constant
for t in f.terms 
    coef = t.coefficient
    indx = t.variable_index.value
    global z += coef * value(all_variables(m)[indx])
end

@show z
    

# for (F, S) in list_of_constraint_types(m)
#     for con in all_constraints(m, F, S)
#         f = JuMP.MOI.get(m, JuMP.MOI.ConstraintFunction(), con)
#         s = JuMP.MOI.get(m, JuMP.MOI.ConstraintSet(), con)

#         delete(m,con)
#         unregister(m,:con)
#         @show s
#     end
# end




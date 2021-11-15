variable_primal(model) = x -> MOI.get(model, MOI.VariablePrimal(), x)

function heuristicCreate(model::Model)
    m = heuristicModel()
    m.model = model
    return m
end

function removeConstrains!(m::heuristicModel)
    model = m.model
    functions = m.functions
    sets = m.sets
    violation = m.violation
    functionValue = m.functionValue
        
    for (F, S) in list_of_constraint_types(model)
        if F != VariableRef
            for con in all_constraints(model, F, S)
                f = JuMP.MOI.get(model, JuMP.MOI.ConstraintFunction(), con)
                s = JuMP.MOI.get(model, JuMP.MOI.ConstraintSet(), con)
                push!(functions,f)
                push!(sets,s)
                push!(violation,Inf)
                push!(functionValue,0.0)
                delete(model,con)
                unregister(model,:con)
            end
        end
    end
    nothing
end

function updateFunctionValue!(m::heuristicModel)
    model = m.model
    functions = m.functions
    functionValue = m.functionValue

    for i in 1:length(functions)
        v = functions[i].constant
        for t in functions[i].terms 
            coef = t.coefficient
            indx = t.variable_index.value
            v += coef * value(all_variables(model)[indx])
        end
        functionValue[i] = v
    end
    nothing
end

function updateViolation!(m::heuristicModel)
    sets = m.sets
    functionValue = m.functionValue
    violation = m.violation
    functions = m.functions
    sets = m.sets

    for i in 1:length(functions)
        violation[i] = MOD.distance_to_set(MOD.DefaultDistance(), functionValue[i], sets[i]) 
    end
    nothing
end
function init_types(model::Model,geq_expressions::Array=[],leq_expressions::Array=[],eq_expressions::Array=[],constraint_per_iteration::Int = 1)
    heristic = data(model,geq_expressions,leq_expressions,eq_expressions)

    return heristic, parameters
end

function step_solve!(heristic::data, parameters::options)
    optimize!(heristic.model)
    nothing
    #return heristic, parameters
end

function evaluate_violations!(heristic::data, parameters::options)
    geq_error = - value.(heristic.geq_expressions)
    leq_error = value.(heristic.leq_expressions)
    eq_error = abs.(value.(heristic.eq_expressions))

    values, indices = findextrema(geq_error,parameters.constraint_per_iteration)

    for i in 1:indices
        con = @build_constraint(heristic.geq_expressions[i] >= 0)
        add_constraint(heristic.model, con)
        
    end
    nothing
end

function findextrema(v::Array,n::Int)
    idx = sortperm(v; rev=true)
    return v[idx][1:n], idx[1:n]
end
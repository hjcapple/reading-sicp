-- P37 - [1.3.1 过程作为参数]

function sum_integers(a, b)
    if a > b then 
        return 0
    else 
        return a + sum_integers(a + 1, b)
    end 
end

function cube(x)
    return x * x * x
end

function sum_cubes(a, b)
    if a > b then 
        return 0
    else 
        return cube(a) + sum_cubes(a + 1, b)
    end
end

function pi_sum(a, b)
    if a > b then 
        return 0
    else 
        return 1.0 / (a * (a + 2)) + pi_sum(a + 4, b)
    end 
end

-------
function sum(term, a, next, b)
    if a > b then 
        return 0
    else 
        return term(a) + sum(term, next(a), next, b)
    end 
end

function inc(n)
    return n + 1
end

function sum_integers_2(a, b)
    function identity(x)
        return x
    end
    return sum(identity, a, inc, b)
end

function sum_cubes_2(a, b)
    return sum(cube, a, inc, b)
end

function pi_sum_2(a, b)
    function term(x)
        return 1.0 / (x * (x + 2))
    end 

    function next(x)
        return x + 4
    end 

    return sum(term, a, next, b)
end 

--------
function integral(f, a, b, dx)
    function add_dx(x)
        return x + dx 
    end 
    return sum(f, a + dx / 2.0, add_dx, b) * dx 
end

print(pi_sum(1, 1000) * 8)
print(integral(cube, 0, 1, 0.01))
print(integral(cube, 0, 1, 0.001))

function unit_test()
    assert(pi_sum(1, 1000) == pi_sum_2(1, 1000))
    assert(sum_integers(1, 1000) == sum_integers(1, 1000))
    assert(sum_cubes(1, 1000) == sum_cubes_2(1, 1000))
end 
unit_test()


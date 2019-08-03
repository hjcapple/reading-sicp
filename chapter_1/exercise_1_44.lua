-- P51 - [练习 1.44]

function compose(f, g)
    return function (x)
        return f(g(x))
    end
end

function repeated(f, n)
    if n == 1 then
        return f 
    else 
        return compose(f, repeated(f, n - 1))
    end 
end

function smooth(f)
    return function (x)
        local dx = 0.00001
        return (f(x - dx) + f(x) + f(x + dx)) / 3
    end
end

function smooth_n_times(f, n)
    return repeated(smooth, n)(f)
end

function square(x)
    return x * x 
end 

print(smooth(square)(5))                -- 25.000000000067
print(smooth_n_times(square, 10)(5))    -- 25.000000000667


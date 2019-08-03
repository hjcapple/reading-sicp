-- P51 - [练习 1.43]

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

function square(x)
    return x * x 
end 

print(repeated(square, 3)(5))  -- 625


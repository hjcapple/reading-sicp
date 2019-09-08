-- P51 - [练习 1.42]

function compose(f, g)
    return function (x)
        return f(g(x))
    end
end

function square(x)
    return x * x 
end 

function inc(x)
    return x + 1
end

print(compose(square, inc)(6))  -- 49


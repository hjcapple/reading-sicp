-- P51 - [练习 1.41]

function double(f)
    return function (x)
        return f(f(x))
    end 
end

function inc(x)
    return x + 1
end

print(double(double(double))(inc)(5))   -- 21


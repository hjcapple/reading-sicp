-- P51 - [练习 1.40]

function fixed_point(f, first_guess)
    function close_enough(x, y)
        local abs = math.abs
        local tolerance = 0.00001
        return abs(x - y) < tolerance
    end

    function try(guess)
        local next_guess = f(guess)
        if close_enough(guess, next_guess) then 
            return next_guess
        else 
            return try(next_guess)
        end
    end

    return try(first_guess)
end


function newton_transform(g)
    function deriv(g)
        local dx = 0.00001
        return function (x)
            return (g(x + dx) - g(x)) / dx
        end
    end

    return function (x)
        return x - g(x) / deriv(g)(x)
    end
end

function newtons_method(g, guess)
    return fixed_point(newton_transform(g), guess)
end

function cubic(a, b, c)
    function cube(x)
        return x * x * x
    end

    function square(x)
        return x * x 
    end

    return function (x)
        return cube(x) + a * square(x) + b * x + c
    end
end

print(newtons_method(cubic(3, 2, 1), 1.0))
print(newtons_method(cubic(3, 4, 5), 1.0))
print(newtons_method(cubic(6, 7, 8), 1.0))

--[[ 输出
-2.3247179572447
-2.2134116627622
-4.9054740060655
]]

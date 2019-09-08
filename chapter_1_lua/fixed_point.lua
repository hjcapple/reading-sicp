-- P45 - [找出函数的不动点]

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

function sqrt(x)
    function average(a, b)
        return (a + b) / 2
    end

    return fixed_point(function(y) 
        return average(y, x / y)
    end, 1.0)
end

----------

local cos = math.cos
local sin = math.sin
print(fixed_point(cos, 1.0))

print(fixed_point(function(y)
    return sin(y) + cos(y)
end, 1.0))

assert(math.abs(sqrt(3.0) - math.sqrt(3.0)) < 0.0001)


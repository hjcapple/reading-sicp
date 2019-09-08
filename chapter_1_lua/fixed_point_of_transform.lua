-- P50 - [抽象和第一级过程]

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

function fixed_point_of_transform(g, transform, guess)
    return fixed_point(transform(g), guess)
end

function average_damp(f)
    function average(a, b)
        return (a + b) / 2
    end
    return function (x)
        return average(x, f(x))
    end
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

function sqrt(x)
    return fixed_point_of_transform(function (y)
        return x / y
    end, average_damp, 1.0)
end

function sqrt_2(x)
    return fixed_point_of_transform(function (y)
        return y * y - x
    end, newton_transform, 1.0)
end

-------
function unit_test()
    function assert_equal(a, b, tolerance)
        tolerance = tolerance or 0.0001
        assert(math.abs(a - b) < tolerance)
    end
    for i = 0, 100 do 
        assert_equal(sqrt(i), math.sqrt(i))
        assert_equal(sqrt_2(i), math.sqrt(i))
    end
end 
unit_test()

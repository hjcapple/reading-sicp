-- P48 - [平均阻尼]

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

function average_damp(f)
    function average(a, b)
        return (a + b) / 2
    end
    return function (x)
        return average(x, f(x))
    end
end

function sqrt(x)
    return fixed_point(average_damp(function(y) 
        return x / y
    end), 1.0)
end

function cube_root(x)
    return fixed_point(average_damp(function(y) 
        return x / (y * y)
    end), 1.0)
end

-----------
function unit_test()
    function assert_equal(a, b, tolerance)
        tolerance = tolerance or 0.0001
        assert(math.abs(a - b) < tolerance)
    end
    for i = 0, 100 do 
        assert_equal(sqrt(i), math.sqrt(i))
        assert_equal(cube_root(i), i ^ (1/3))
    end
end 
unit_test()




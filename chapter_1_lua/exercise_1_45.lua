-- P52 - [练习 1.45]

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

function average_damp(f)
    function average(a, b)
        return (a + b) / 2
    end
    return function (x)
        return average(x, f(x))
    end
end

function fast_expt(b, n)
    function square(x)
        return x * x
    end

    function even(n)
        return n % 2 == 0
    end

    if n == 0 then 
        return 1
    elseif even(n) then 
        return square(fast_expt(b, n / 2))
    else 
        return b * fast_expt(b, n - 1)
    end
end

function nth_root(x, n)
    function fn(y)
        return x / fast_expt(y, n - 1)
    end
    return fixed_point(repeated(average_damp, n - 1)(fn), 1.0)
end


function unit_test()
    function assert_equal(a, b, tolerance)
        tolerance = tolerance or 0.0001
        assert(math.abs(a - b) < tolerance)
    end
    for i = 0, 100 do 
        assert_equal(nth_root(i, 2), i ^ (1/2))
        assert_equal(nth_root(i, 3), i ^ (1/3))
        assert_equal(nth_root(i, 4), i ^ (1/4))
    end
end 
unit_test()

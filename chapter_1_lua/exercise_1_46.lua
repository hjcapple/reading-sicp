-- P52 - [练习 1.46]

function iterative_improve(good_enough, improve)
    function try(guess)
        local next_guess = improve(guess)
        if good_enough(guess, next_guess) then 
            return guess
        else
            return try(next_guess)
        end
    end
    return try
end

function fixed_point(f, first_guess)
    function close_enough(x, y)
        local abs = math.abs
        local tolerance = 0.00001
        return math.abs(x - y) < tolerance
    end
    return iterative_improve(close_enough, f)(first_guess)
end

function sqrt(x)
    function average(x, y)
        return (x + y) / 2
    end 

    function good_enough(guess, new_guess)
        local abs = math.abs
        return abs(guess * guess - x) < 0.001
    end

    function improve(guess)
        return average(guess, x / guess)
    end

    return iterative_improve(good_enough, improve)(1.0)
end

print(sqrt(2))                      -- 1.4142156862745
print(fixed_point(math.cos, 1.0))   -- 0.73908934140339


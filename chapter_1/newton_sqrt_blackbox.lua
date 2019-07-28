-- P17 - [1.1.8 过程作为黑箱抽象]

function average(x, y)
    return (x + y) / 2
end

function abs(x)
    if x < 0 then 
        return -x
    else
        return x
    end
end

function square(x)
    return x * x
end

function sqrt(x)
    function good_enough(guess)
        return abs(square(guess) - x) < 0.001
    end

    function improve(guess)
        return average(guess, x / guess)
    end

    function sqrt_iter(guess)
        if good_enough(guess) then 
            return guess
        else 
            return sqrt_iter(improve(guess))
        end
    end

    return sqrt_iter(1.0)
end

print(sqrt(9))
print(sqrt(100 + 37))
print(sqrt(sqrt(2) + sqrt(3)))
print(square(sqrt(1000)))

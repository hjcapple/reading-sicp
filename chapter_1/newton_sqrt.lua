-- P15 - [1.1.7 实例： 采用牛顿法求平方根]

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

function sqrt_iter(guess, x)
    if good_enough(guess, x) then 
        return guess
    else 
        return sqrt_iter(improve(guess, x), x)
    end
end

function improve(guess, x)
    return average(guess, x / guess)
end

function good_enough(guess, x)
    return abs(square(guess) - x) < 0.001
end

function sqrt(x)
    return sqrt_iter(1.0, x)
end

print(sqrt(9))
print(sqrt(100 + 37))
print(sqrt(sqrt(2) + sqrt(3)))
print(square(sqrt(1000)))

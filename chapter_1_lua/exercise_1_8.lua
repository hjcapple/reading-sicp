-- P17 - [练习 1.8]

function abs(x)
    if x < 0 then 
        return -x
    else
        return x
    end
end

function cube_root_iter(guess, x)
    local new_guess = improve(guess, x)
    if good_enough(guess, new_guess) then 
        return guess
    else 
        return cube_root_iter(new_guess, x)
    end
end

function improve(guess, x)
    return (x / (guess * guess) + 2 * guess) / 3
end

function good_enough(guess, new_guess)
    local d = (guess - new_guess) / guess
    return abs(d) < 0.001
end

function cube_root(x)
    return cube_root_iter(1.0, x)
end

function cube(x)
    return x * x * x
end

print(cube(cube_root(27)))
print(cube(cube_root(137)))
print(cube(cube_root(0.001)))
print(cube(cube_root(10000000)))

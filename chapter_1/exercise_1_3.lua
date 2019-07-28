-- P13 - [练习 1.3]

function max3(a, b, c)
    if a >= c and b >= c then 
        return a + b 
    elseif a >= b and c >= b then 
        return a + c
    else
        return b + c 
    end
end

assert(max3(1, 2, 3) == 5)
assert(max3(1, 3, 2) == 5)
assert(max3(3, 2, 1) == 5)
assert(max3(3, 4, 4) == 8)

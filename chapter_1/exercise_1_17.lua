-- P31 - [练习 1.17]

function mul(a, b)
    if b == 0 then 
        return 0
    else
        return a + mul(a, b - 1)
    end 
end

function double(x)
    return x + x 
end

function halve(x)
    return x / 2
end

function fast_mul(a, n)
    function even(n)
        return n % 2 == 0
    end

    if n == 0 then
        return 0
    elseif even(n) then 
        return double(fast_mul(a, halve(n)))
    else 
        return a + fast_mul(a, n - 1)
    end
end

----------------------------------
function unit_test()
    for i = 0, 999 do
        assert(mul(i, i) == i * i)
        assert(fast_mul(i, i) == i * i)
    end
end 
unit_test()

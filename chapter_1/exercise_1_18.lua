-- P31 - [练习 1.18]

function double(x)
    return x + x 
end

function halve(x)
    return x / 2
end

function fast_mul(b, n)
    function even(n)
        return n % 2 == 0
    end

    function iter(ret, b, n)
        if n == 0 then 
            return ret
        elseif even(n) then 
            return iter(ret, double(b), halve(n))
        else
            return iter(ret + b, b, n - 1)
        end
    end

    return iter(0, b, n)
end

----------------------------------
function unit_test()
    for i = 0, 999 do
        assert(fast_mul(i, i) == i * i)
    end
end
unit_test()

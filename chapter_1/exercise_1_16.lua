-- P30 - [练习 1.16]

function fast_expt(b, n)
    function even(n)
        return n % 2 == 0
    end

    function iter(a, b, n)
        if n == 0 then 
            return a 
        elseif even(n) then
            return iter(a, b * b, n / 2)
        else 
            return iter(a * b, b, n - 1)
        end
    end
    return iter(1, b, n)
end

function unit_test()
    function expt(b, n)
        if n == 0 then 
            return 1
        else
            return b * expt(b, n - 1) 
        end
    end

    for i = 0, 100 do
        local v0 = expt(1.1, i)
        local v1 = fast_expt(1.1, i)
        assert(math.abs(v0 - v1) < 0.00001)
    end
end 
unit_test()

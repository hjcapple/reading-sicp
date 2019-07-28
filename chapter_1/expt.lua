-- P29 - [1.2.4 求幂]

function square(x)
    return x * x
end

function expt(b, n)
    if n == 0 then 
        return 1
    else
        return b * expt(b, n - 1) 
    end
end

function expt_2(b, n)
    function iter(b, counter, product)
        if counter == 0 then 
            return product
        else
            return iter(b, counter - 1, product * b) 
        end
    end
    return iter(b, n, 1)
end

function fast_expt(b, n)
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

local n = 100
print(expt(1.1, n))
print(expt_2(1.1, n))
print(fast_expt(1.1, n))

-- P40 - [练习 1.31]

-- 递归版本
function product(term, a, next, b)
    if a > b then 
        return 1
    else 
        return term(a) * product(term, next(a), next, b)
    end 
end

-- 迭代版本
function product_2(term, a, next, b)
    function iter(a, ret)
        if a > b then 
            return ret 
        else
            return iter(next(a), term(a) * ret)
        end
    end
    return iter(a, 1)
end

function pi_product_base(product_f, n)
    function even(x)
        return x % 2 == 0
    end

    function term(i)
        if even(i) then 
            return (i + 2) / (i + 1)
        else 
            return (i + 1) / (i + 2)
        end 
    end

    function inc(x)
        return x + 1
    end

    return product_f(term, 1, inc, n)
end

function factorial(n)
    function term(i)
        return i
    end

    function inc(x)
        return x + 1
    end

    return product(term, 1, inc, n)
end

function pi_product(n)
    return pi_product_base(product, n)
end 

function pi_product_2(n)
    return pi_product_base(product_2, n)
end

print(pi_product(1000) * 4)
assert(factorial(6) == 720)
assert(math.abs(pi_product(1000) - pi_product_2(1000)) < 0.0001)


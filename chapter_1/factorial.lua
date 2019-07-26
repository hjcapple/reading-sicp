-- P21 - [1.2.1 线性的递归和迭代]

function factorial(n)
    if n == 1 then 
        return 1
    else 
        return n * factorial(n - 1)
    end 
end

function factorial_2(n)
    function iter(product, counter)
        if counter > n then 
            return product
        else 
            return iter(counter * product, counter + 1)
        end 
    end
    return iter(1, 1)
end

assert(factorial(4) == 24)
assert(factorial_2(4) == 24)

assert(factorial(1) == 1)
assert(factorial_2(1) == 1)

assert(factorial(2) == 2)
assert(factorial_2(2) == 2)

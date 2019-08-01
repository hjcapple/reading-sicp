-- P40 - [练习 1.33]

-- 递归版本
function filtered_accumulate(filter, combiner, null_value, term, a, next, b)
    if a > b then 
        return null_value
    elseif filter(a) then
        return combiner(term(a), filtered_accumulate(filter, combiner, null_value, term, next(a), next, b))
    else
        return filtered_accumulate(filter, combiner, null_value, term, next(a), next, b)
    end
end

-- 迭代版本
function filtered_accumulate_2(filter, combiner, null_value, term, a, next, b)
    function iter(a, ret)
        if a > b then 
            return ret 
        elseif filter(a) then
            return iter(next(a), combiner(term(a), ret))
        else
            return iter(next(a), ret)
        end
    end
    return iter(a, null_value)
end

-------------
-- 判断是否素数
function prime(n)
    function square(x) 
        return x * x
    end

    function remainder(n, b)
        return n % b
    end

    function smallest_divisor(n)
        return find_divisor(n, 2)
    end

    function find_divisor(n, test_divisor)
        if square(test_divisor) > n then 
            return n
        elseif divides(test_divisor, n) then 
            return test_divisor
        else
            return find_divisor(n, test_divisor + 1)
        end
    end

    function divides(a, b)
        return remainder(b, a) == 0
    end

    return smallest_divisor(n) == n
end

-- 求 gcd
function gcd(a, b)
    function remainder(a, b)
        return a % b
    end

    if b == 0 then
        return a
    else 
        return gcd(b, remainder(a, b))
    end
end

function identity(x)
    return x
end

function inc(n)
    return n + 1
end

function sum_combiner(a, b)
    return a + b 
end 

function product_combiner(a, b)
    return a * b
end

-------------
-- a) 求出 [a, b] 之间所有素数之和
function sum_prime(a, b)
    return filtered_accumulate(prime, sum_combiner, 0, identity, a, inc, b)
end

-- b) 求小于 n 的所有与 n 互素的正整数之积
function product_coprime(n)
    function filter(i)
        return gcd(i, n) == 1
    end
    return filtered_accumulate_2(filter, product_combiner, 1, identity, 1, inc, n - 1)
end

-----------
function unit_test()
    assert(sum_prime(2, 10) == 2 + 3 + 5 + 7)
    assert(sum_prime(2, 20) == 2 + 3 + 5 + 7 + 11 + 13 + 17 + 19)

    assert(product_coprime(10) == 1 * 3 * 7 * 9)
    assert(product_coprime(20) == 1 * 3 * 7 * 9 * 11 * 13 * 17 * 19)
end 
unit_test()


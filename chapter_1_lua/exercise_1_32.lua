-- P40 - [练习 1.32]

-- 递归版本
function accumulate(combiner, null_value, term, a, next, b)
    if a > b then 
        return null_value
    else 
        return combiner(term(a), accumulate(combiner, null_value, term, next(a), next, b))
    end 
end

-- 迭代版本
function accumulate_2(combiner, null_value, term, a, next, b)
    function iter(a, ret)
        if a > b then 
            return ret 
        else 
            return iter(next(a), combiner(term(a), ret))
        end
    end
    return iter(a, null_value)
end

function sum(term, a, next, b)
    function combiner(a, b)
        return a + b 
    end
    return accumulate(combiner, 0, term, a, next, b)
end

function product(term, a, next, b)
    function combiner(a, b)
        return a * b 
    end
    return accumulate_2(combiner, 1, term, a, next, b)
end

------
function unit_test()
    function identity(x)
        return x
    end

    function inc(n)
        return n + 1
    end

    assert(sum(identity, 1, inc, 100) == 5050)
    assert(product(identity, 1, inc, 6) == 720)
end 
unit_test()

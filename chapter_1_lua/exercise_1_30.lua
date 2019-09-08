-- P40 - [练习 1.30]

function sum(term, a, next, b)
    function iter(a, ret)
        if a > b then 
            return ret 
        else
            return iter(next(a), term(a) + ret)
        end
    end
    return iter(a, 0)
end

--------
function unit_test()
    function inc(n)
        return n + 1
    end 
    function identity(x)
        return x
    end
    assert(sum(identity, 1, inc, 100) == 5050)
end 
unit_test()


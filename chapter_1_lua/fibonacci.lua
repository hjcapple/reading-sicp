-- P24 - [1.2.2 树形递归]

function fib(n)
    if n == 0 then 
        return 0 
    elseif n == 1 then 
        return 1
    else 
        return fib(n - 1) + fib(n - 2)
    end
end

function fib_2(n)
    function iter(a, b, count)
        if count == 0 then 
            return b
        else
            return iter(a + b, a, count - 1)
        end
    end
    return iter(1, 0, n)
end

print("n", "fib", "fib_2")
for i = 1, 10 do 
    assert(fib(i) == fib_2(i))
    print(i, fib(i), fib_2(i))
end


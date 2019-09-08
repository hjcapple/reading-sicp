-- P27 - [练习 1.11]

-- 递归版本
function f(n)
    if n < 3 then
        return n
    else
        return f(n - 1) + 2 * f(n - 2) + 3 * f(n - 3)
    end 
end

-- 迭代版本
function f2(n)
    function iter(a, b, c, count)
        if count == 0 then 
            return c 
        else
            return iter(b, c, c + 2 * b + 3 * a, count - 1)
        end
    end

    if n < 3 then 
        return n
    else
        return iter(0, 1, 2, n - 2) 
    end
end

print("n", "f", "f2")
for n = 0, 16 do
    assert(f(n) == f2(n))
    print(n, f(n), f2(n))
end

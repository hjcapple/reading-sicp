-- P32 - [1.2.5 最大公约数]

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

----------------------------------
function unit_test()
    assert(gcd(206, 40) == 2)
    assert(gcd(3, 5) == 1)
    assert(gcd(15, 5) == 5)
    assert(gcd(3 * 4 * 5, 3 * 4 * 6) == 12)
end
unit_test()

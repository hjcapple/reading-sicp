-- P33 - 1.2.6 实例： 素数检测, [寻找因子]

function square(x) 
    return x * x
end

function remainder(n, b)
    return n % b
end

function prime(n)
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

function unit_test()
    local nums = { 2, 3, 5, 7, 11, 13, 17, 19, 23 }
    for _, num in ipairs(nums) do 
        assert(prime(num))
    end
    local nums = { 36, 25, 9, 16, 4 }
    for _, num in ipairs(nums) do 
        assert(not prime(num))
    end
end
unit_test()

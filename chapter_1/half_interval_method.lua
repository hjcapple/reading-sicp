-- P44 - [通过区间折半寻找方程的根]

function search(f, neg_point, pos_point)
    function average(a, b)
        return (a + b) / 2
    end

    function close_enough(x, y)
        local abs = math.abs
        return abs(x - y) < 0.001
    end

    local midpoint = average(neg_point, pos_point)
    if close_enough(neg_point, pos_point) then
        return midpoint
    else
        local test_value = f(midpoint)
        if test_value > 0 then 
            return search(f, neg_point, midpoint)
        elseif test_value < 0 then 
            return search(f, midpoint, pos_point)
        else 
            return midpoint
        end 
    end
end

function half_interval_method(f, a, b)
    local a_value = f(a)
    local b_value = f(b)

    if a_value < 0 and b_value > 0 then 
        return search(f, a, b)
    elseif a_value > 0 and b_value < 0 then 
        return search(f, b, a)
    else 
        error("Values are not of opposite sign")
    end 
end

local sin = math.sin
print(half_interval_method(sin, 2.0, 4.0))

print(half_interval_method(function(x) 
    return x * x * x - 2 * x - 3
end, 1.0, 2.0))


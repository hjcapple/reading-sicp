-- P26 - [实例：换零钱方式的统计]

function count_change(amount)
    function cc(amount, kinds_of_coins)
        if amount == 0 then
            return 1
        elseif amount < 0 or kinds_of_coins == 0 then
            return 0
        else 
            return cc(amount, kinds_of_coins - 1) + cc(amount - first_denomination(kinds_of_coins), kinds_of_coins)
        end
    end

    function first_denomination(kinds_of_coins)
        if kinds_of_coins == 1 then 
            return 1
        elseif kinds_of_coins == 2 then
            return 5
        elseif kinds_of_coins == 3 then
            return 10
        elseif kinds_of_coins == 4 then 
            return 25
        elseif kinds_of_coins == 5 then
            return 50
        end
    end

    return cc(amount, 5)
end

print(count_change(100))

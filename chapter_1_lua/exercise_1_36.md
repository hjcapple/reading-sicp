## P47 - [练习 1.36]

程序为 

``` Lua
function fixed_point(f, first_guess)
    function close_enough(x, y)
        local abs = math.abs
        local tolerance = 0.00001
        return abs(x - y) < tolerance
    end

    local step = 1;
    function try(guess)
        print(string.format("step %d: guess = %f", step, guess))
        step = step + 1

        local next_guess = f(guess)
        if close_enough(guess, next_guess) then 
            return next_guess
        else 
            return try(next_guess)
        end
    end

    return try(first_guess)
end

function find_root()
    local log = math.log
    function f(x)
        return log(1000) / log(x)
    end
    return fixed_point(f, 2)
end

function find_root_damp()
    function average(a, b)
        return (a + b) / 2
    end 

    local log = math.log
    function f(x)
        return average(x, log(1000) / log(x))
    end

    return fixed_point(f, 2)
end

print(find_root())
print(find_root_damp())
```
------

`find_root` 没有采用平均阻尼，需要 34 步，最终结果 4.5555322708037。

```
step 1: guess = 2.000000
step 2: guess = 9.965784
step 3: guess = 3.004472
step 4: guess = 6.279196
....
step 31: guess = 4.555518
step 32: guess = 4.555548
step 33: guess = 4.555528
step 34: guess = 4.555541
4.5555322708037
```
------

`find_root_damp` 采用平均阻尼，只需要 9 步，最终结果 4.5555375519998。

```
step 1: guess = 2.000000
step 2: guess = 5.982892
step 3: guess = 4.922169
step 4: guess = 4.628224
step 5: guess = 4.568347
step 6: guess = 4.557731
step 7: guess = 4.555910
step 8: guess = 4.555599
step 9: guess = 4.555547
4.5555375519998
```

可见，采用平均阻尼，大大加快了计算收敛速度。


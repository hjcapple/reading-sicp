## P13 - [练习 1.1]

翻译成 Lua, 运行得到结果。

``` Lua
print(10)                   -- 10
print(5 + 3 + 4)            -- 12
print(9 - 1)                -- 8
print(6 / 2)                -- 3.0
print((2 * 4) + (4 - 6))    -- 6

a = 3
b = a + 1

print(a + b + (a * b))      -- 19
print(a == b)               -- false

-- 4
if (b > a) and (b < a * b) then
    print(b)
else
    print(a)
end

-- 16
if a == 4 then 
    print(6)
elseif b == 4 then 
    print(6 + 7 + a)
else 
    print(25)
end

-- 6
local tmp 
if b > a then 
    tmp = b 
else
    tmp = a 
end
print(tmp + 2)


-- 16
local tmp
if a > b then 
    tmp = a 
elseif a < b then 
    tmp = b
else 
    tmp = -1
end 
print(tmp * (a + 1))

```

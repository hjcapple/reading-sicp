-- P27 - [练习 1.12]

function pascal_row(n)
    if n <= 1 then
        return { 1 }
    else
        local prev = pascal_row(n - 1)
        local cur = { prev[1] }
        for i = 1, #prev - 1 do 
            table.insert(cur, prev[i] + prev[i + 1])
        end
        table.insert(cur, prev[#prev])
        return cur
    end
end

function pretty_print_triangle(n)
    local last = pascal_row(n)
    local mid_v = last[math.floor(#last / 2)]
    local max_v_len = #tostring(mid_v)
    local max_line_len = (max_v_len + 2) * #last

    function spaces(c)
        local str = ""
        while c > 0 do 
            str = str .. " "
            c = c - 1
        end
        return str
    end

    for i = 1, n do
        local this = pascal_row(i)
        local this_line_len = (max_v_len + 2) * #this
        local str = spaces((max_line_len - this_line_len) / 2)
    
        for _, v in pairs(this) do 
            local v_str = tostring(v)
            str = str .. v_str
            str = str .. spaces(max_v_len - #v_str)
            str = str .. "  "
        end
        print(str)
    end
end

pretty_print_triangle(13)

--[[ 输出
                              1
                            1    1
                         1    2    1
                       1    3    3    1
                    1    4    6    4    1
                  1    5    10   10   5    1
               1    6    15   20   15   6    1
             1    7    21   35   35   21   7    1
          1    8    28   56   70   56   28   8    1
        1    9    36   84   126  126  84   36   9    1
     1    10   45   120  210  252  210  120  45   10   1
   1    11   55   165  330  462  462  330  165  55   11   1
1    12   66   220  495  792  924  792  495  220  66   12   1
]]



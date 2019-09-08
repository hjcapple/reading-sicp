-- [练习 1.14] 使用的图片

nodes = {}                  -- 节点
node_dependent_on = {}      -- 节点之间的关系

function new_node(parent, val, amount, kinds_of_coins)
    local node = {}
    node.name = "node_" .. tostring(#nodes)
    node.val = val
    node.amount = amount
    node.kinds_of_coins = kinds_of_coins
    table.insert(nodes, node)

    if parent then 
        local dep = {}
        dep.parent = parent
        dep.child = node 
        table.insert(node_dependent_on, dep)
    end
    return node
end

function pretty_print_dot()
    local G = "digraph G {\n"
    for _, n in pairs(nodes) do 
        local str = ""
        if n.val then 
            str = string.format([=[%s [label="%d" shape=none]]=], n.name, n.val)
        else 
            str = string.format([=[%s [label="(cc %d %d)" shape=none]]=], n.name, n.amount, n.kinds_of_coins)
        end
        G = G .. "    " .. str .. "\n"
    end

    for _, v in pairs(node_dependent_on) do 
        local str = string.format("%s -> %s", v.parent.name, v.child.name)
        G = G .. "    " .. str .. "\n"
    end

    G = G .. "}\n"
    print(G)
end

function count_change(amount)
    function cc(parent, amount, kinds_of_coins)
        local curnode = new_node(parent, nil, amount, kinds_of_coins)
        if amount == 0 then
            new_node(curnode, 1, nil, nil)
            return 1
        elseif amount < 0 or kinds_of_coins == 0 then
            new_node(curnode, 0, nil, nil)
            return 0
        else 
            return cc(curnode, amount, kinds_of_coins - 1) + cc(curnode, amount - first_denomination(kinds_of_coins), kinds_of_coins)
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

    return cc(nil, amount, 5)
end

count_change(11)
pretty_print_dot()

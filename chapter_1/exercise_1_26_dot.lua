-- [练习 1.26] 使用的图片

nodes = {}                  -- 节点
node_dependent_on = {}      -- 节点之间的关系

function new_node(parent, base, exp, m, val)
    local node = {}
    node.name = "node_" .. tostring(#nodes)
    node.base = base
    node.exp = exp
    node.m = m
    node.val = val
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
            str = string.format([=[%s [label="(expmod %d %d %d)" shape=none]]=], n.name, n.base, n.exp, n.m)
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

function remainder(n, b)
    return n % b
end

function even(n)
    return n % 2 == 0
end

function expmod(parent, base, exp, m)
    local curnode = new_node(parent, base, exp, m)
    if exp == 0 then 
        new_node(curnode, nil, nil, nil, 1)
        return 1
    elseif even(exp) then
        return remainder(expmod(curnode, base, exp / 2, m) * expmod(curnode, base, exp / 2, m), m)
    else
        local tmp = expmod(curnode, base, exp - 1, m)
        return remainder(base * tmp, m)
    end 
end

expmod(nil, 13, 19, 19)
pretty_print_dot()

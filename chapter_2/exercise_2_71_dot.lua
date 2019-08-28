local input_N = 5 -- or 10

-- 用于输出 [练习 2.71] 中的树形图的 Dot 代码

local nodeCount = 0
function newNode(weight)
    local ret = {}
    ret.name = "node_" .. tostring(nodeCount)
    ret.weight = weight
    nodeCount = nodeCount + 1
    return ret
end

function outputNode(node)
    return string.format("    %s [label=\"%d\"]\n", node.name, node.weight)
end

function outputEdge(parent, node)
    return string.format("    %s -> %s\n", parent.name, node.name)
end

dotOutput = [[
digraph G {
    node [shape=plaintext]
]]

local nodes = {}
for n = 1, input_N do 
    local weight = 2 ^ (n - 1)
    local node = newNode(weight)
    table.insert(nodes, node)
end

while #nodes ~= 1 do 
    local left = nodes[1]
    local right = nodes[2]
    local node = newNode(left.weight + right.weight)
    dotOutput = dotOutput .. outputNode(left)
    dotOutput = dotOutput .. outputNode(right)
    dotOutput = dotOutput .. outputNode(node)
    dotOutput = dotOutput .. outputEdge(node, left)
    dotOutput = dotOutput .. outputEdge(node, right)
    table.remove(nodes, 1)
    nodes[1] = node
end

dotOutput = dotOutput .. "}\n"
print(dotOutput)


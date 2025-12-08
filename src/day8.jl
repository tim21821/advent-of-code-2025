using DataStructures
using Graphs
using LinearAlgebra
using StaticArrays

const NUM_CONNECTIONS = 1000

function part1()
    lines = open("input/day8.txt") do f
        return readlines(f)
    end

    boxes = [SVector{3,Int}(parse.(Int, split(line, ','))) for line in lines]

    heap = BinaryHeap{Tuple{Int,Int,Float64}}(Base.By(last))
    for i in eachindex(boxes)
        for j in (i+1):length(boxes)
            push!(heap, (i, j, norm(boxes[i] - boxes[j])))
        end
    end

    graph = SimpleGraph(length(boxes))
    for _ in 1:NUM_CONNECTIONS
        connection = pop!(heap)
        add_edge!(graph, connection[1], connection[2])
    end
    components = connected_components(graph)
    sort!(components, by = length, rev = true)
    return length(components[1]) * length(components[2]) * length(components[3])
end

function part2()
    lines = open("input/day8.txt") do f
        return readlines(f)
    end

    boxes = [SVector{3,Int}(parse.(Int, split(line, ','))) for line in lines]

    heap = BinaryHeap{Tuple{Int,Int,Float64}}(Base.By(last))
    for i in eachindex(boxes)
        for j in (i+1):length(boxes)
            push!(heap, (i, j, norm(boxes[i] - boxes[j])))
        end
    end

    dsu = IntDisjointSet(length(boxes))
    while true
        connection = pop!(heap)
        union!(dsu, connection[1], connection[2])
        if num_groups(dsu) == 1
            return boxes[connection[1]][1] * boxes[connection[2]][1]
        end
    end
end

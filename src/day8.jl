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

    queue = PriorityQueue{Tuple{Int,Int},Float64}()
    for i in eachindex(boxes)
        for j in (i+1):length(boxes)
            push!(queue, (i, j) => norm(boxes[i] - boxes[j]))
        end
    end

    graph = SimpleGraph(length(boxes))
    for _ in 1:NUM_CONNECTIONS
        connection, _ = popfirst!(queue)
        add_edge!(graph, connection...)
    end
    components = connected_components(graph)
    sort!(components, by=length, rev=true)
    return length(components[1]) * length(components[2]) * length(components[3])
end

function part2()
    lines = open("input/day8.txt") do f
        return readlines(f)
    end

    boxes = [SVector{3,Int}(parse.(Int, split(line, ','))) for line in lines]

    queue = PriorityQueue{Tuple{Int,Int},Float64}()
    for i in eachindex(boxes)
        for j in (i+1):length(boxes)
            push!(queue, (i, j) => norm(boxes[i] - boxes[j]))
        end
    end

    graph = SimpleGraph(length(boxes))
    while true
        connection, _ = popfirst!(queue)
        add_edge!(graph, connection...)
        if length(connected_components(graph)) == 1
            return boxes[connection[1]][1] * boxes[connection[2]][1]
        end
    end
end

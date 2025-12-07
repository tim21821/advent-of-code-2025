using DataStructures
using Memoization

@memoize function getnumberoftimelines(grid::Matrix{Char}, pos::CartesianIndex{2})
    downpos = pos + CartesianIndex(1, 0)
    if !checkbounds(Bool, grid, downpos)
        return 1
    elseif grid[downpos] == '.'
        return getnumberoftimelines(grid, downpos)
    elseif grid[downpos] == '^'
        return getnumberoftimelines(grid, downpos + CartesianIndex(0, 1)) +
               getnumberoftimelines(grid, downpos - CartesianIndex(0, 1))
    end
end

function part1()
    lines = open("input/day7.txt") do f
        return readlines(f)
    end

    grid = stack(collect.(lines); dims = 1)
    start = findfirst(c -> c == 'S', grid)
    stack_ = Stack{CartesianIndex{2}}()
    visited = Set{CartesianIndex{2}}()
    push!(stack_, start)
    splitcount = 0
    while !isempty(stack_)
        pos = pop!(stack_)
        if pos in visited
            continue
        end
        push!(visited, pos)

        downpos = pos + CartesianIndex(1, 0)
        if checkbounds(Bool, grid, downpos) && grid[downpos] == '.'
            push!(stack_, downpos)
        elseif checkbounds(Bool, grid, downpos) && grid[downpos] == '^'
            push!(stack_, downpos + CartesianIndex(0, 1))
            push!(stack_, downpos - CartesianIndex(0, 1))
            splitcount += 1
        end
    end
    return splitcount
end

function part2()
    lines = open("input/day7.txt") do f
        return readlines(f)
    end

    grid = stack(collect.(lines); dims = 1)
    start = findfirst(c -> c == 'S', grid)
    return getnumberoftimelines(grid, start)
end

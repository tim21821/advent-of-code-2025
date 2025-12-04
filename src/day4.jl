function getadjacentcount(grid::Matrix{Char}, index::CartesianIndex{2})
    count = 0
    for i in -1:1
        for j in -1:1
            if i == 0 && j == 0
                continue
            end
            offset = CartesianIndex(i, j)
            if checkbounds(Bool, grid, index + offset) && grid[index+offset] == '@'
                count += 1
            end
        end
    end
    return count
end

function getaccessible(grid::Matrix{Char})
    accessible = Vector{CartesianIndex{2}}()
    for index in CartesianIndices(grid)
        if grid[index] == '@' && getadjacentcount(grid, index) < 4
            push!(accessible, index)
        end
    end
    return accessible
end

function part1()
    lines = open("input/day4.txt") do f
        return readlines(f)
    end

    grid = stack(collect.(lines); dims = 1)
    return length(getaccessible(grid))
end

function part2()
    lines = open("input/day4.txt") do f
        return readlines(f)
    end

    grid = stack(collect.(lines); dims = 1)
    accessible = getaccessible(grid)
    totalaccessible = 0
    while !isempty(accessible)
        totalaccessible += length(accessible)
        for index in accessible
            grid[index] = '.'
        end
        accessible = getaccessible(grid)
    end
    return totalaccessible
end

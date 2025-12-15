using Random
using Folds
using StaticArrays

getarea(p1::SVector{2,Int}, p2::SVector{2,Int}) =
    (abs(p1[1] - p2[1]) + 1) * (abs(p1[2] - p2[2]) + 1)

function makeboundary(tiles::Vector{SVector{2,Int}})
    boundary = Set{SVector{2,Int}}()
    for i in 1:(length(tiles)-1)
        tile1 = tiles[i]
        tile2 = tiles[i+1]
        if tile1[1] == tile2[1]
            for y in min(tile1[2], tile2[2]):max(tile1[2], tile2[2])
                push!(boundary, SA[tile1[1], y])
            end
        else
            for x in min(tile1[1], tile2[1]):max(tile1[1], tile2[1])
                push!(boundary, SA[x, tile1[2]])
            end
        end
    end
    tile1 = tiles[end]
    tile2 = tiles[1]
    if tile1[1] == tile2[1]
        for y in min(tile1[2], tile2[2]):max(tile1[2], tile2[2])
            push!(boundary, SA[tile1[1], y])
        end
    else
        for x in min(tile1[1], tile2[1]):max(tile1[1], tile2[1])
            push!(boundary, SA[x, tile1[2]])
        end
    end
end

function isinbounds(boundary::Set{SVector{2,Int}}, p1::SVector{2,Int}, p2::SVector{2,Int})
    for x in shuffle((min(p1[1], p2[1])+1):(max(p1[1], p2[1])-1))
        if Folds.any(
            SA[x, y] in boundary for y in (min(p1[2], p2[2])+1):(max(p1[2], p2[2])-1)
        )
            return false
        end
    end
    return true
end

function part1()
    lines = open("input/day9.txt") do f
        return readlines(f)
    end

    redtiles = [SVector{2,Int}(parse.(Int, split(line, ','))) for line in lines]
    maxarea = 0
    for i in eachindex(redtiles)
        for j in (i+1):length(redtiles)
            maxarea = max(maxarea, getarea(redtiles[i], redtiles[j]))
        end
    end
    return maxarea
end

function part2()
    lines = open("input/day9.txt") do f
        return readlines(f)
    end

    redtiles = [SVector{2,Int}(parse.(Int, split(line, ','))) for line in lines]
    boundary = makeboundary(redtiles)

    rectangles = Vector{Tuple{Int,Int,Int}}()
    for i in eachindex(redtiles)
        for j in (i+1):length(redtiles)
            push!(rectangles, (i, j, getarea(redtiles[i], redtiles[j])))
        end
    end
    sort!(rectangles, by = last, rev = true)

    for rectangle in rectangles
        if isinbounds(boundary, redtiles[rectangle[1]], redtiles[rectangle[2]])
            return rectangle[3]
        end
    end
end

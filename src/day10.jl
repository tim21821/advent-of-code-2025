using Combinatorics
using JuMP
import HiGHS

getlightdiagram(str::AbstractString) = BitVector(c == '#' for c in str[2:(end-1)])

getschematic(str::AbstractString) = parse.(Int, split(str[2:(end-1)], ','))

getjoltage(str::AbstractString) = parse.(Int, split(str[2:(end-1)], ','))

function pushbuttons(diagram::BitVector, schematic::Vector{Int})
    for pos in schematic
        diagram[pos+1] = !diagram[pos+1]
    end
    return diagram
end

function getnumpresses(lightdiagram::BitVector, schematics::Vector{Vector{Int}})
    for numpresses in 1:typemax(Int)
        for combination in combinations(schematics, numpresses)
            diagram = falses(length(lightdiagram))
            for schematic in combination
                pushbuttons(diagram, schematic)
            end
            if diagram == lightdiagram
                return numpresses
            end
        end
    end
end

function part1()
    lines = open("input/day10.txt") do f
        return readlines(f)
    end

    totalpresses = 0
    for line in lines
        s = split(line)
        lightdiagram = getlightdiagram(s[1])
        schematics = getschematic.(s[2:(end-1)])
        totalpresses += getnumpresses(lightdiagram, schematics)
    end

    return totalpresses
end

function part2()
    lines = open("input/day10.txt") do f
        return readlines(f)
    end

    totalpresses = 0
    for line in lines
        s = split(line)
        joltage = getjoltage(s[end])
        schematics = getschematic.(s[2:(end-1)])
        matrix = zeros(Int, length(joltage), length(schematics))
        for (col, schematic) in zip(eachcol(matrix), schematics)
            for i in schematic
                col[i+1] = 1
            end
        end
        model = Model(HiGHS.Optimizer)
        set_silent(model)
        n = length(schematics)
        @variable(model, x[1:n], Int)
        @constraint(model, matrix * x == joltage)
        @constraint(model, x .>= 0)
        @objective(model, Min, sum(x))
        optimize!(model)
        totalpresses += trunc(Int, sum(xi -> value(xi), x))
    end
    return totalpresses
end

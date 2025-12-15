using DataStructures
using Memoization

@memoize function numpaths(
    start::String,
    ende::String,
    outputs::Dict{String,Vector{String}},
)
    if start == ende
        return 1
    end
    if (start in keys(outputs))
        return sum(s -> numpaths(s, ende, outputs), outputs[start])
    else
        return 0
    end
end

function part1()
    lines = open("input/day11.txt") do f
        return readlines(f)
    end

    outputs = Dict{String,Vector{String}}()
    for line in lines
        start, ends = split(line, ": ")
        outputs[start] = split(ends)
    end
    queue = Queue{String}()
    push!(queue, "you")
    numpaths = 0
    while !isempty(queue)
        current = popfirst!(queue)
        if current == "out"
            numpaths += 1
            continue
        end

        for next in outputs[current]
            push!(queue, next)
        end
    end
    return numpaths
end

function part2()
    lines = open("input/day11.txt") do f
        return readlines(f)
    end

    outputs = Dict{String,Vector{String}}()
    for line in lines
        start, ends = split(line, ": ")
        outputs[start] = split(ends)
    end
    return numpaths("svr", "fft", outputs) *
           numpaths("fft", "dac", outputs) *
           numpaths("dac", "out", outputs)
end

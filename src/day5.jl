import Base.length

struct Range
    low::Int
    high::Int
end

length(range::Range) = range.high - range.low + 1

function fromstring(str::AbstractString)
    low, high = parse.(Int, split(str, '-'))
    return Range(low, high)
end

inrange(range::Range, x::Int) = x >= range.low && x <= range.high

overlap(r1::Range, r2::Range) = inrange(r1, r2.low)

merge(r1::Range, r2::Range) = Range(min(r1.low, r2.low), max(r1.high, r2.high))

function part1()
    lines = open("input/day5.txt") do f
        return readlines(f)
    end

    ranges = Vector{Range}()
    readingranges = true
    freshcount = 0
    for line in lines
        if readingranges
            if line == ""
                readingranges = false
                continue
            end

            push!(ranges, fromstring(line))
        else
            id = parse(Int, line)
            freshcount += any(r -> inrange(r, id), ranges) ? 1 : 0
        end
    end
    return freshcount
end

function part2()
    lines = open("input/day5.txt") do f
        return readlines(f)
    end

    ranges = Vector{Range}()
    for line in lines
        if line == ""
            break
        end
        push!(ranges, fromstring(line))
    end

    sort!(ranges, by = r -> r.low)
    mergedranges = Vector{Range}()
    i = 1
    while i <= length(ranges)
        merged = ranges[i]
        j = 1
        while checkbounds(Bool, ranges, i+j) && overlap(merged, ranges[i+j])
            merged = merge(merged, ranges[i+j])
            j += 1
        end
        push!(mergedranges, merged)
        i = i + j
    end
    return sum(length.(mergedranges))
end

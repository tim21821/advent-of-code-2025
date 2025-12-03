function getmaxjoltage(batteries::Vector{Int})
    maxjoltage = typemin(Int)
    for i in eachindex(batteries)
        for j in (i+1):length(batteries)
            maxjoltage = max(maxjoltage, 10 * batteries[i] + batteries[j])
        end
    end
    return maxjoltage
end

function getmaxjoltage(batteries::Vector{Int}, n::Int)
    if n == 1
        return maximum(batteries)
    end

    i = argmax(batteries[1:(end-n+1)])
    return 10^(n-1) * batteries[i] + getmaxjoltage(batteries[(i+1):end], n-1)
end

function part1()
    lines = open("input/day3.txt") do f
        return readlines(f)
    end

    banks = [parse.(Int, x) for x in collect.(lines)]
    joltage = getmaxjoltage.(banks)
    return sum(joltage)
end

function part2()
    lines = open("input/day3.txt") do f
        return readlines(f)
    end

    banks = [parse.(Int, x) for x in collect.(lines)]
    totaljoltage = 0
    for bank in banks
        totaljoltage += getmaxjoltage(bank, 12)
    end
    return totaljoltage
end

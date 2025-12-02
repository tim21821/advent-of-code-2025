const REPEAT_RE = r"^(.+)\1+$"

function isinvalid(i::Int)
    str = string(i)
    return length(str) % 2 == 0 && str[1:(length(str)÷2)] == str[(length(str)÷2+1):end]
end

isinvalid2(i::Int) = occursin(REPEAT_RE, string(i))

function part1()
    input = open("input/day2.txt") do f
        return readline(f)
    end

    ranges = split(input, ',')
    invalidsum = 0
    for range in ranges
        firstID, secondID = parse.(Int, split(range, '-'))
        for id in firstID:secondID
            if isinvalid(id)
                invalidsum += id
            end
        end
    end
    return invalidsum
end

function part2()
    input = open("input/day2.txt") do f
        return readline(f)
    end

    ranges = split(input, ',')
    invalidsum = 0
    for range in ranges
        firstID, secondID = parse.(Int, split(range, '-'))
        for id in firstID:secondID
            if isinvalid2(id)
                invalidsum += id
            end
        end
    end
    return invalidsum
end

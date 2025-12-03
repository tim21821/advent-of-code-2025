const REPEAT_RE = r"^(.+)\1+$"

function isinvalid(n::Int)
    d = digits(n)
    if length(d) % 2 != 0
        return false
    end
    for i in 1:(length(d)÷2)
        if d[i] != d[i+length(d)÷2]
            return false
        end
    end
    return true
end

function isinvalid2(n::Int)
    d = digits(n)
    len = length(d)

    for i in 1:(len÷2)
        if len % i != 0
            continue
        end
        invalid = true
        for j in 1:(len-i)
            if d[j] != d[j+i]
                invalid = false
                break
            end
        end
        if invalid
            return true
        end
    end
    return false
end

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

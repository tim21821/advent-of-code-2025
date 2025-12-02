function isinvalid(i::Int)
    str = string(i)
    return length(str) % 2 == 0 && str[1:(length(str)÷2)] == str[(length(str)÷2+1):end]
end

function isinvalid(str::AbstractString, n::Int)
    len = length(str)
    if len % n != 0
        return false
    end

    sequence = str[1:(len÷n)]
    for i in 2:n
        if str[((i-1)*(len÷n)+1):(i*(len÷n))] != sequence
            return false
        end
    end
    return true
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
            str = string(id)
            for i in 2:length(str)
                if isinvalid(str, i)
                    invalidsum += id
                    break
                end
            end
        end
    end
    return invalidsum
end

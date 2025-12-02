function part1()
    lines = open("input/day1.txt") do f
        return readlines(f)
    end

    zerocounter = 0
    dialposition = 50
    for line in lines
        direction = line[1]
        clicks = parse(Int, line[2:end])
        if direction == 'L'
            dialposition -= clicks
        elseif direction == 'R'
            dialposition += clicks
        else
            throw(ArgumentError("unknown direction: $direction"))
        end
        dialposition = mod(dialposition, 100)
        zerocounter += (dialposition == 0) ? 1 : 0
    end
    return zerocounter
end

function part2()
    lines = open("input/day1.txt") do f
        return readlines(f)
    end

    zerocounter = 0
    dialposition = 50
    for line in lines
        direction = line[1]
        clicks = parse(Int, line[2:end])
        if direction == 'L'
            for _ in 1:clicks
                dialposition -= 1
                dialposition = mod(dialposition, 100)
                zerocounter += (dialposition == 0) ? 1 : 0
            end
        elseif direction == 'R'
            for _ in 1:clicks
                dialposition += 1
                dialposition = mod(dialposition, 100)
                zerocounter += (dialposition == 0) ? 1 : 0
            end
        else
            throw(ArgumentError("unknown direction: $direction"))
        end
    end
    return zerocounter
end

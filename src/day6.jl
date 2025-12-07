function part1()
    lines = open("input/day6.txt") do f
        return readlines(f)
    end

    numbers = parse.(Int, stack(split.(lines[1:(end-1)]); dims = 1))
    operations = split(lines[end])
    grandtotal = 0
    for (operation, col) in zip(operations, eachcol(numbers))
        if operation == "*"
            grandtotal += prod(col)
        elseif operation == "+"
            grandtotal += sum(col)
        else
            throw(ArgumentError("unknown operation: $operation"))
        end
    end
    return grandtotal
end

function part2()
    lines = open("input/day6.txt") do f
        return readlines(f)
    end

    grid = stack(collect.(lines); dims = 1)
    grandtotal = 0
    numbers = Vector{Int}()
    for col in reverse(eachcol(grid))
        if all(c -> c == ' ', col)
            continue
        end

        number = ""
        for i in 1:(length(col)-1)
            number *= col[i]
        end
        push!(numbers, parse.(Int, number))
        if col[end] == '*'
            grandtotal += prod(numbers)
            numbers = Vector{Int}()
        elseif col[end] == '+'
            grandtotal += sum(numbers)
            numbers = Vector{Int}()
        end
    end

    return grandtotal
end

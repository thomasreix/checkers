WHITE = 0
BLACK = 1
EMPTY = 2

function defaultBoard(size)
    local board = {}
    for y = 1, size do
        board[y] = {}
        local cell = y < size / 2 and WHITE or y > size + 2 and WHITE or EMPTY
        for x = 1, size do
            if (y + x) % 2 == 0 then
                board[y][x] = false
            else
                board[y][x] = cell
            end
        end
    end

    return board
end

function printBoard(board)
    for y, row in ipairs(board) do
        local line = ""
        for x, cell in ipairs(row) do
            if cell == 0 then
                line = line.."0 "
            elseif cell == 1 then
                line = line.."1 "
            elseif cell == 2 then
                line = line.."_ "
            end
                line = line.."  "
            end
        end
        print(line)
    end
end

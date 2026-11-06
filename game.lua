function defaultBoard(size)
    local board = {}
    for row = 1, size do
        board[row] = {}
        for cell = 1, size do
            local color = (row + cell) % 2
            board[row][cell] = color
        end
    end
    return board
end

function printBoard(board)
    for y, row in ipairs(board) do
        print(table.concat(row, " "))
    end
end

require("game")

bot = require("bot")

size = 8
board = defaultBoard(8)
printBoard(board)


repeat
    move = bot.play(board)

    if checkMove(board, move) then
        updateBoard(board, move)
    else
        print("error: wrong move")
        print(
            tostring(move.start.y) .. " " .. tostring(move.start.x),
            tostring(move.finish.y) .. " " .. tostring(move.finish.x)
        )
    end

    print()
    printBoard(board)
until move ~= nil
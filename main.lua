require("game")

bot = require("bot")

size = 8
board = defaultBoard(8)
printBoard(board)

move = bot.play(board)
while move ~= nil do
    if checkMove(board, move) then
        board = updateBoard(board, move)
    else
        print("error: wrong move")
        print(
            tostring(move.start.y) .. " " .. tostring(move.start.x),
            tostring(move.finish.y) .. " " .. tostring(move.finish.x)
        )
    end

    print()
    printBoard(board)

    move = bot.play(board)
end
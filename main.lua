require("game")

require("bot")
require("human")
require("random")

size = 8
board = defaultBoard(8)
printBoard(board)

move = play(board)
print(move)

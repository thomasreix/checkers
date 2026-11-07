bot = require("bot")
man = require("human")
rdm = require("random")

size = 8
board = defaultBoard(8)
printBoard(board)

move = bot:play(board)
print(move)

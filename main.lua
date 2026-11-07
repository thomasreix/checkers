require "game"

bot = require "bot"

size = 8
board = defaultBoard(8)
printBoard(board)

move = bot:play(board)


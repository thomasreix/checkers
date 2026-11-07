require("game")

bot = require("bot")

size = 8
board = defaultBoard(8)
printBoard(board)

players = { bot, bot }
games = 1
battle(players, games)

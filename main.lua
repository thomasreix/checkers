require("game")

bot = require("bot")

size = 8
board = defaultBoard(8)

players = { bot, bot }
totalGames = 1
games = battle(players, totalGames)
printGames(games, players)

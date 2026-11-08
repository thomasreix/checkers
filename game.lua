BLANK = -1
EMPTY = 0
PLAYER = 1
APPONANT = 2

local symbols = {
	[PLAYER] = "●",
	[APPONANT] = "○",
	[EMPTY] = "-",
	[BLANK] = " ",
}

function defaultBoard(size)
	local board = {}
	local formation = size / 2 - 1
	for y = 1, size do
		local cell
		if y <= formation then
			cell = PLAYER
		elseif y > size - formation then
			cell = APPONANT
		else
			cell = EMPTY
		end
		local row = {}
		for x = 1, size do
			if (y + x) % 2 == 0 then
				row[x] = cell
			else
				row[x] = BLANK
			end
		end
		board[y] = row
	end
	return board
end

function reverseBoard(board)
	local size = #board
	local reversedBoard = {}
	for y, row in ipairs(board) do
		local index = size - y + 1
		reversedBoard[index] = row
	end
	return reversedBoard
end

function invertBoard(board)
	local invertedBoard = {}
	for y, row in ipairs(board) do
		local invertedRow = {}
		for x, cell in ipairs(row) do
			local invertedCell = cell
			if cell ~= BLANK and cell ~= EMPTY then
				invertedCell = cell == PLAYER and APPONANT or PLAYER
			end
			invertedRow[x] = invertedCell
		end
		invertedBoard[y] = invertedRow
	end
	return invertedBoard
end

function checkErrors(board, move)
	local error = nil
	local size = #board

	if move == nil then
		error = "the move is not moving anything"
	elseif move.start.y > size or move.start.y < 1 then
		error = "the selected pawn is outside the board"
	elseif move.start.x > size or move.start.x < 1 then
		error = "the selected pawn is outside the board"
	elseif move.finish.x > size or move.finish.x < 1 then
		error = "the selected destination is outside the board"
	elseif (move.start.y + move.start.y) % 2 ~= 0 then
		error = "the selected pawn is on the wrong color"
	elseif board[move.start.y][move.start.x] ~= PLAYER then
		error = "the selected pawn is not a player"
	elseif move.finish.y - move.start.y ~= 1 then
		error = "the pawn's destination is wrong"
	elseif move.start.x - 1 ~= move.finish.x and move.start.x + 1 ~= move.finish.x then
		error = "the pawn's destination is wrong"
	end

	if error ~= nil then
		print("incorect move: " .. error)
		print(
			tostring(move.start.y) .. " " .. tostring(move.start.x),
			tostring(move.finish.y) .. " " .. tostring(move.finish.x)
		)
	end

	return error
end

function updateGame(board, move)
	local updatedBoard = board
	updatedBoard[move.start.y][move.start.x] = EMPTY
	updatedBoard[move.finish.y][move.finish.x] = PLAYER
	return updatedBoard
end

function checkGame(board)
	local finished = false
	for x, cell in ipairs(board[1]) do
		if cell == APPONANT then
			finished = true
		end
	end

	local availableMove = false
	for y, row in ipairs(board) do
		for x, cell in ipairs(row) do
			if cell == PLAYER then
				if x == 1 then
					if board[y + 1][x + 1] == EMPTY then
						availableMove = true
					end
				elseif x == size then
					if board[y + 1][x - 1] == EMPTY then
						availableMove = true
					end
				else
					if board[y + 1][x - 1] == EMPTY then
						availableMove = true
					end
					if board[y + 1][x + 1] == EMPTY then
						availableMove = true
					end
				end
			end
		end
	end

	if not availableMove then
		finished = true
	end

	return finished
end

function printBoard(board, index)
	local printedBoard = board
	if index == 1 then
		printedBoard = reverseBoard(invertBoard(board))
	end
	printedBoard = reverseBoard(printedBoard)

	print()
	for y, row in ipairs(printedBoard) do
		local printedRow = ""
		for x, cell in ipairs(row) do
			printedRow = printedRow .. symbols[cell] .. " "
		end
		print(printedRow)
	end
end

function printBoards(boards, columns)
	local size = #boards[1]
	local boardRows = math.ceil(#boards / columns)
	for boardRow = 1, boardRows do
		for row = 1, size do
			local printedRow = ""
			for column = 1, columns do
				local boardIndex = (boardRow - 1) * columns + column
				local board = boards[boardIndex]
				if board then
					for x, cell in ipairs(board[row]) do
						printedRow = printedRow .. symbols[cell] .. " "
					end
				end
				printedRow = printedRow .. "   "
			end
			print(printedRow)
		end
		print()
	end
end

function printGames(games, players)
	for gameCount, game in ipairs(games) do
		local board = defaultBoard(8)
		local starter = gameCount % 2
		if starter == 2 then
			board = reverseBoard(invertBoard(board))
		end
		local boards = {}
		for turn, move in ipairs(game) do
			local index = (turn + starter) % 2 + 1
			
			board = updateGame(board, move)

			local printedBoard = board
			if index == 1 then
				printedBoard = reverseBoard(invertBoard(board))
			end
			printedBoard = reverseBoard(printedBoard)
			boards[turn] = printedBoard

			board = reverseBoard(invertBoard(board))
		end
		printBoards(boards, 4)
		print(players[1].name .. " has won the game")
	end
end

function battle(players, totalGames)
	local games = {}
	for gameCount = 1, totalGames do
		local board = defaultBoard(8)
		local starter = gameCount % 2 + 1
		--printBoard(board, starter - 1)
		if starter == 1 then
			board = reverseBoard(invertBoard(board))
		end
		local game = {}
		local turn = 0
		local finished = false
		while not finished do
			local index = (turn + starter - 1) % 2 + 1
			local player = players[index]

			local move = player.play(board)
			local error = checkErrors(board, move)

			if error ~= nil then
				finished = true
			else
				board = updateGame(board, move)
				--printBoard(board, index)
				board = reverseBoard(invertBoard(board))
				finished = checkGame(board)
				turn = turn + 1
				game[turn] = move
			end
		end
		games[gameCount] = game
	end
	return games
end

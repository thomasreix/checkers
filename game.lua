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
	if index == 1 then
        printedBoard = reverseBoard(invertBoard(board))
    end
	print()
	local printedBoard = reverseBoard(board)
	for y, row in ipairs(printedBoard) do
		local line = ""
		for x, cell in ipairs(row) do
			line = line .. symbols[cell] .. " "
		end
		print(line)
	end
end

function battle(players, games)
	for game = 0, games do
		local board = defaultBoard(8)
		local starter = game % 2 + 1
		local turn = 0
		local finished = false
		while not finished do
			local index = (turn + starter) % 2 + 1
			local player = players[index]

			local move = player.play(board)
			local error = checkErrors(board, move)

			if error ~= nil then
                finished = true
            else
                board = updateGame(board, move)

                local displayBoard = board
                if index == 1 then
                    displayBoard = reverseBoard(invertBoard(board))
                end
                printBoard(displayBoard)

                board = reverseBoard(invertBoard(board))
                finished = checkGame(board)
                turn = turn + 1
            end
		end
	end
end

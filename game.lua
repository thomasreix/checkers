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
				row[x] = BLANK
			else
				row[x] = cell
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
			local invertedCell = cell == PLAYER and APPONANT or PLAYER
			invertedRow[x] = invertedCell
		end
		invertedBoard[y] = invertedRow
	end
	return invertedBoard
end

function checkMove(board, move)
	size = #board
	if move.start.y > size or move.start.y < 1 then
		return false
	elseif move.start.x > size or move.start.x < 1 then
		return false
	elseif move.finish.x > size or move.finish.x < 1 then
		return false
	end

	if (move.start.y + move.start.y) % 2 ~= 0 then
		return false
	end

	if board[move.start.y][move.start.x] ~= PLAYER then
		return false
	elseif move.finish.y - move.start.y ~= 1 then
		return false
	elseif move.start.x - 1 ~= move.finish.x and move.start.x + 1 ~= move.finish.x then
		return false
	end

	return true
end

function updateBoard(board, move)
	local updatedBoard = board
	updatedBoard[move.start.y][move.start.x] = EMPTY
	updatedBoard[move.finish.y][move.finish.x] = PLAYER
	return updatedBoard
end

function printBoard(board)
	local reversedBoard = reverseBoard(board)
	for y, row in ipairs(reversedBoard) do
		local line = ""
		for x, cell in ipairs(row) do
			line = line .. symbols[cell] .. " "
		end
		print(line)
	end
end

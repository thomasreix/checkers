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

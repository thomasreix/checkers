require("game")

function available(board)
	local moves = {}
	for y, row in ipairs(board) do
		for x, cell in ipairs(row) do
			local move = { { x, y } }
			if cell == PLAYER then
				if board[y - 1][x - 1] == EMPTY then
					move[2] = { y - 1, x - 1 }
				elseif board[y - 1][x + 1] == EMPTY then
					move[2] = { y - 1, x + 1 }
				end
			end
			if #move == 2 then
				moves[#moves + 1] = move
			end
		end
	end
	return moves
end

function play(board)
	local moves = available(board)
	local move = moves[1]
	print(move)
	return move
end

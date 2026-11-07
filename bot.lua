local function available(board)
	local moves = {}
	for y, row in ipairs(board) do
		for x, cell in ipairs(row) do
			if cell == PLAYER then
				if x == 1 then
					if board[y + 1][x + 1] == EMPTY then
						local move = { { y, x }, { y + 1, x + 1 } }
						moves[#moves + 1] = move
					end
				elseif x == size then
					if board[y + 1][x - 1] == EMPTY then
						local move = { { y, x }, { y + 1, x - 1 } }
						moves[#moves + 1] = move
					end
				else
					if board[y + 1][x + 1] == EMPTY then
						local move = { { y, x }, { y + 1, x + 1 } }
						moves[#moves + 1] = move
					end
					if board[y + 1][x - 1] == EMPTY then
						local move = { { y, x }, { y + 1, x - 1 } }
						moves[#moves + 1] = move
					end
				end
			end
		end
	end
	return moves
end

local function play(board)
	local moves = available(board)
	local move = moves[1]
	return move
end

return {
	play = play,
}

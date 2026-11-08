local function availableMoves(board)
	local moves = {}
	for y, row in ipairs(board) do
		for x, cell in ipairs(row) do
			if cell == PLAYER then
				if x == 1 then
					if board[y + 1][x + 1] == EMPTY then
						local move = { start = { y = y, x = x }, finish = { y = y + 1, x = x + 1 } }
						moves[#moves + 1] = move
					end
				elseif x == size then
					if board[y + 1][x - 1] == EMPTY then
						local move = { start = { y = y, x = x }, finish = { y = y + 1, x = x - 1 } }
						moves[#moves + 1] = move
					end
				else
					if board[y + 1][x - 1] == EMPTY then
						local move = { start = { y = y, x = x }, finish = { y = y + 1, x = x - 1 } }
						moves[#moves + 1] = move
					end
					if board[y + 1][x + 1] == EMPTY then
						local move = { start = { y = y, x = x }, finish = { y = y + 1, x = x + 1 } }
						moves[#moves + 1] = move
					end
				end
			end
		end
	end
	return moves
end

local function play(board)
	local moves = availableMoves(board)
	local move = moves[1]
	return move
end

return {
	name = "bot",
	play = function(board)
		return play(board)
	end,
}

local indexCounter = 0

local MatrixConstructor = nil
MatrixConstructor = function(m, n)
	indexCounter = indexCounter + 1
	local Matrix = {index = indexCounter}
	local left = {}
	local right = {}
	local constants = {}
	local _m = m
	local _n = n

	Matrix.getDimensions = function()
		return _m, _n
	end

	-- Initing and setting all to zero
	for i = 1, m do
		left[i] = {}
		for j = 1, n do
			left[i][j] = 0
		end
		right[i] = 0
	end

	for j = 1, n do
		constants[j] = 0
	end

	Matrix.setLeftSide = function(i, j, value)
		left[i][j] = value
	end
	Matrix.getLeftSide = function(i, j)
		return left[i][j]
	end

	Matrix.setRightSide = function(i, value)
		right[i] = value
	end
	Matrix.getRightSide = function(i)
		return right[i]
	end

	Matrix.setConstants = function(newConstants)
		constants = newConstants
	end

	Matrix.getConstants = function()
		return constants
	end

	Matrix.swap = function(i, j)
		local tmp = left[i]
		local tmp2 = right[i]
		left[i] = left[j]
		right[i] = right[j]
		left[j] = left[i]
		right[j] = right[i]
	end

	Matrix.copy = function()
		local newMatrix = MatrixConstructor(m, n)
		for i = 1, _m do
			for j = 1, _n do
				newMatrix.setLeftSide(i, j, Matrix.getLeftSide(i, j))
			end
			newMatrix.setRightSide(i, Matrix.getRightSide(i))
		end

		newMatrix.setConstants(Matrix.getConstants())

		return newMatrix
	end

	Matrix.solve = function()
		local M = Matrix.copy()

	end

end

MagLib.Utils.Math.Matrix = MatrixConstructor

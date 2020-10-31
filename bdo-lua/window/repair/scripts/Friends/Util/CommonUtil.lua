CommonUtil = {}

function CommonUtil.Ternary(C, T, F)
	if C then
		return T
	else
		return F
	end
end

function CommonUtil.ParameterValue(parameterValue)
	return CommonUtil.Ternary(parameterValue == nil, "nil", tostring(parameterValue))
end
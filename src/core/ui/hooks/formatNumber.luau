local FormatEnum = {
	Abbreviate = "Abbreviate",
	Full = "Full",
}

local SUFFIXES = { "K", "M", "B", "T" }

return function(n: number, format: string): string
	if format == FormatEnum.Full then
		local formatted = tostring(math.floor(n))
		local result = ""
		local len = #formatted

		for i = 1, len do
			if i > 1 and (len - i + 1) % 3 == 0 then
				result = result .. ","
			end

			result = result .. formatted:sub(i, i)
		end

		return result
	elseif format == FormatEnum.Abbreviate then
		local abs = math.abs(n)
		local sign = n < 0 and "-" or ""

		if abs >= 1e15 then
			return sign .. string.format("%.2f", abs / 1e15) .. "Q"
		end

		for i = #SUFFIXES, 1, -1 do
			local threshold = 10 ^ (i * 3)

			if abs >= threshold then
				local value = abs / threshold
				local formatted = value % 1 == 0 and tostring(math.floor(value)) or string.format("%.2f", value)

				return sign .. formatted .. SUFFIXES[i]
			end
		end
		return tostring(n)
	end

	return tostring(n)
end

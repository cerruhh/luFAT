local module = {}
local httpsS=game:GetService("HttpService")

function module:StKB(s:string)
	return #(httpsS:JSONEncode({s})/1024)
end

function module:StB(s:string)
	return #(httpsS:JSONEncode({s}))
end

return module

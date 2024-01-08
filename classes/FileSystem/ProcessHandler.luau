local module = {}
local colServ=game:GetService("CollectionService")

local function hastag(tag:string,instance:Instance)
	for i,v in colServ:GetTags(instance) do
		if v==tag then
			return true
		end
	end
	return false
end


local function checkForValue(valuename:string,value,plr:Player)
	for i,v in plr.PlayerGui:FindFirstChild("$sys"):GetChildren() do
		if hastag("process",v) then continue end		
		if v:FindFirstChild("ProcessData") and v:FindFirstChild("ProcessData"):IsA("Folder") then
			if v:FindFirstChild(tostring(valuename)) and v:FindFirstChild(tostring(valuename)).Value==value then
				return v:FindFirstChild(tostring(valuename))
			end
		end
	end
	warn(".$notfound") return nil
end

function getProcess(id:number,plr:Player)
	if plr.PlayerGui:FindFirstChild("$sys") then
		local systemgui=plr.PlayerGui:FindFirstChild("$sys")
		local result=checkForValue("ProcessID",id,plr)
		
		if result~=nil then
			return result
		else
			warn(".$ProcessIdInvalid")
		end
	end
end


function module:GetLatestID(id:number,plr:Player)
	local cur=1
	local NotChanged=false
	
	while not NotChanged do
		NotChanged=false
		for i,v in plr.PlayerGui:FindFirstChild("$sys"):GetChildren() do
			local ProcessID=v:FindFirstChild("ProcessData"):FindFirstChild("ProcessID")
			if v:FindFirstChild("ProcessData")==nil or not v:FindFirstChild("ProcessData"):IsA("Folder") then warn(".$CorruptedProcess at"..v.Name) return end
			if ProcessID and ProcessID:IsA("IntValue") then
				if ProcessID.Value==cur then
					cur+=1
					NotChanged=true
				end
			end
		end
	end

	return cur
end

function killProcess(id:number,plr:Player,processTable)
	for i,gObject in plr.PlayerGui:FindFirstChild("$sys"):GetChildren() do
		if hastag("process",gObject) then continue end
		
		if gObject:FindFirstChild("ProcessData") then
			local prcData=gObject:FindFirstChild("ProcessData")
			if prcData:IsA("Folder") and prcData:FindFirstChild("ProcessID") and prcData:FindFirstChild("ProcessID"):IsA("IntValue") then
				if prcData:FindFirstChild("ProcessID").Value==id then
					table.find(processTable)[id]=nil
					gObject:Destroy()
				end
			end
		end
	end
end

return module


--this implementation sucks...........
-- all .$ is process/gui stuff.


--[[
ProcessID


]]--

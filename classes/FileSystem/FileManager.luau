local module = {}
local repSt=game:GetService("ReplicatedStorage")


module.IconList={
	["txt"]="rbxassetid://15524558954";
	["jpg"]="rbxassetid://15524603781";
	["mp4"]="rbxassetid://15524666897";
	["VID"]="rbxassetid://15524666897";
	["mpeg"]="rbxassetid://15524666897";
	["mp3"]="rbxassetid://15524692683";
	["ogg"]="rbxassetid://15524692683";
	["MP_CHROUS"]="rbcassetid://15524692683";
	["m4a"]="rbxassetid://15524692683";
	["md"]="rbxassetid://15524558954";
}

local TXT_FEXSES={
	"md";
	"txt";
	"cli";
	"wrd";
}

local function CH_FILETYPE(FEX:string,tbl)
	if tbl and FEX then
		for i,v in tbl do
			if v==FEX then return true end
		end
	else
		return false	
	end
	return false
end


function module:GetIcon(iconname:string)
	if module.IconList[iconname]~=nil then
		return module.IconList[iconname]	
	end
end



function module:readfile(filename,filedir:string)
	if filename==nil or filedir==nil then warn("BUGCHECK:NO_ATRB") return end

	if filedir["Contents"] then
		local cn=filedir["Contents"]
		if cn[filename]~=nil then
			return cn[filename]
		end
	end
end


function module:notepadexe(filedir,plr:Player,PrcId:number)
	if filedir==nil then return end

	if CH_FILETYPE(filedir[".SYSTEMFEX"],TXT_FEXSES) then
		local EXPwin=script.Parent.Parent:FindFirstChild("$SYSGUI"):Clone()
		EXPwin.Parent=plr.PlayerGui:WaitForChild("CMPR")

		return {
			["ProcessID"]=tonumber(PrcId);
			["hard-drive"]=EXPwin
		}
	end
end

function module:newText(text:string,name:string,FEX:string,ContentAlloc)
	--[[
	text is the inside of a textfile, as they are a BASE txt or md file, they can only contain text,
	this is NOT a rich format file.
	
	name is the file name, and can be found with name only.
	FEX(file extention) is the extention of the file, there are more than 1 base txt file types such as md,cli,wrd
	Content Alloc is the folder its assigned to.
	With that said, lets continue!
	
	ALL atributes with . is a vital atribute and if not provided in certain situations may bluescreen.
	]]--
	local suc,err=pcall(function()
		if ContentAlloc["Contents"]~=nil then
			local contents=ContentAlloc["Contents"]
			if contents["WritePermission"]==false then warn("Write permission not given") return end
			contents[name]={
				["filecontent"]=text;
				[".SYSTEMFEX"]=FEX;
			}
		end
	end)

	if suc then
		return true
	else
		print(err);
	end

end

return module

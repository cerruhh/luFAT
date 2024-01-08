local module = {}
local smallDep=script:FindFirstChild("/SmallDependencies")
local FS=script.FileSystem
--Engines
local FileManager=require(FS.FileManager)
local ProcessManager=require(FS.ProcessHandler)
-->>>>> LuFAT32>RunTime

local usedRam={
	[-4853498538405]=0;--SystemInvalidProcess,overruled
}
local MaxProcessCount=127
	

local ProcessList={}



--Settings
module.FileList={
	["/a"]={--StorageFolder
		["WritePermission"]=true;
		["Contents"]={
			["/Files"]={
				["WritePermission"]=true;
				["Contents"]={
					
				};	
			};
			["/Boot"]={
				["WritePermission"]=true;
				["Contents"]={
					["ReadMe"]={
						["filecontent"]="Hello there! \n This folder is for boot files, all files here will be loaded on boot. Be careful! \n \n Jailbreaking is not the idea here, cya around";
						[".SYSTEMFEX"]="txt"
					};
				};
			};
		};
	};
	["/c"]={--SystemFolder (Incase of Deafult Items, Write permissions off)
		["WritePermission"]=false;
		["Contents"]={
			["SystemContent"]={
				["WritePermission"]=false;
				["Contents"]={}
			};
		};
	};
};

local SRP="/"

--LOCAL FUNCTION
local function getAmountOfChar(s:string,chr:string) return select(2,s:gsub(chr,"")) end
	
local function GetDirString(s:string)
	local GAOC=getAmountOfChar(s,SRP)
	local t={}
	for i=1,GAOC do
		if i==1 then
			continue
		end
		if t[1]==nil then
			local stwo=string.split(string.sub(s,3,#s),SRP)
			print(stwo)
			table.insert(t,1)
		end
	end
end



local function GetDir(filelocation:string)
	--[[
	
	for explanation*/
	begin is defined as the search that loops through folders until found
	the beginning statements are to begin the module RootFolder as it has 2 option:
		A folder (storage)
		C folder (system)
	
	GOAC is the amount of dividers in the fileString filelocation:str
	loops through the filelocation string with the GAOC divider amount
	the search item is BEGIN:searches for contents that could be find between the divider and currentFILE
	--]]
	local begin
	if string.sub(1,2)=="/a" then
		begin=module.FileList["/a"]
	elseif string.sub(1,2)=="/c" then
		begin=module.FileList["/c"]
	end
	if not begin.WritePermission then warn("error code:7; No permission to place/write files") return 7 end
	local GAOC=getAmountOfChar(filelocation,SRP)
	local curState=begin
	--local Gtable=GetDirString(filelocation)
	
	for i,str:string in GetDirString(filelocation) do
		if curState.Contents then
			local sr=curState.Contents["/"..str]
			if sr then
				if i==#GetDirString(filelocation) then
					return sr
				else
					curState=sr
				end
				
			end
		else
			if begin["WritePermission"]==false then
				curState["Contents"]={
					["WritePermission"]=false;
					["Contents"]={}
				}
			end
			local sr=curState.Contents["/"..str]
			if sr then
				if i==#GetDirString(filelocation) then
					return sr
				else
					curState=sr
				end
			end
		end
	end
	for i=1,GAOC do
		local strsplit=string.split(string.sub(filelocation,2,#filelocation),SRP)
		local search=begin.Contents[strsplit]
		
		if search then
			if i==#GAOC then
				if not i["Contents"] then
					i["Contents"]={}	 
				end
				return search
			end
			begin=search
		else
			warn("9 File not found.")
			return 9
		end
	end
end


function module.newfile(filetype:string,name:string,fileLocation:string,Content:string)
	if filetype=="txt" or filetype=="md" or filetype=="wrd" or filetype=="cli" then
		FileManager:newText(Content,name,filetype,GetDir(fileLocation))
	end
end



return module

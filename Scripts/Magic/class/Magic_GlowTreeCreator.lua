--镇物生成
local tbTable = GameMain:GetMod("MagicHelper");
local tbMagic = tbTable:GetMagic("Magic_GlowTreeCreator");


function tbMagic:Init()
end

function tbMagic:TargetCheck(k, t)	
	if (t.def.Plant.GlowTexPath ~= null) then
		return true;
	end
	return false;
end

function tbMagic:MagicEnter(IDs, IsPlant)
	self.itemId = IDs[0];
end

function tbMagic:MagicStep(dt, duration)--返回值  0继续 1成功并结束 -1失败并结束		
	self:SetProgress(duration/self.magic.Param1);
	if duration >= self.magic.Param1 then	
		return 1;	
	end
	return 0;
end

function tbMagic:MagicLeave(success)
	if success == true then
		local thing = ThingMgr:FindThingByID(self.itemId);
		if thing ~= nil then

			thing.GlowPlant = true; -- the foundation
			thing.View:ShowGlow(); -- refreshing the object to make the glow appear
			thing:AddLing(100); -- just like how ThingMgr.AfterLoad adds some Qi to the object
			world:PlayEffect(100006, thing.Pos); -- Some juice
		end
	end
end

function tbMagic:OnGetSaveData()
	return nil;	
end

function tbMagic:OnLoadData(tbData,IDs, IsThing)	
	self.itemId = IDs[0];
end

--FSItemState 3 is related to Feng Shui Relics without Spirit Relic effects. This is with "balancing" in mind.
--镇物生成
local tbTable = GameMain:GetMod("MagicHelper");
local tbMagic = tbTable:GetMagic("Magic_FSItemCreate");


function tbMagic:Init()
end

function tbMagic:TargetCheck(k, t)	
	if t.FSItemState ~= -1 then
		return false;
	end
	return true;
end

function tbMagic:MagicEnter(IDs, IsThing)
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
	--WorldLua:ShowMsgBox(XT("随着天机变动，这个神通似乎已失去了作用。"),XT("天机"));
	if success == true then
		local item = ThingMgr:FindThingByID(self.itemId);
		if item ~= nil then
			local key = item.Key
			local nitem = item:Split(1)

			nitem.FSItemState = 3;
			local fs = nitem.FengshuiItem

			item.map:DropItem(nitem, key, true, true, true, true);
			world:PlayEffect(100006, nitem.Pos);
		end
	end
end

function tbMagic:OnGetSaveData()
	return nil;	
end

function tbMagic:OnLoadData(tbData,IDs, IsThing)	
	self.itemId = IDs[0];
end

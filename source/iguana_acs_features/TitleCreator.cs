using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.CompilerServices;
using HarmonyLib;
using XiaWorld;
using XiaWorld.UI.InGame;

namespace iguana_acs_features
{
    public class TitleCreator
    {
        public static bool enabled = true;
        [HarmonyPatch(typeof(Wnd_NpcInfo), "SetTitle")]
        public class iguana_TitleCreator
        {
            public static bool Prefix(Wnd_NpcInfo __instance)
			{
				int num = -1;
				List<string> titles = new List<string>();
				if (__instance.npc.Titles != null)
				{
					foreach (Npc.NpcTitle npcTitle in __instance.npc.Titles)
					{
						titles.Add(npcTitle.GetTitle());
						if (npcTitle.Id == __instance.npc.CurTitlte)
						{
							num = titles.Count - 1;
						}
					}
				}
				titles.Add(TFMgr.Get("增加称号"));
				Wnd_SelectCommon instance = Wnd_SelectCommon.Instance;
				List<string> titles2 = titles;
				Action<List<int>> action = delegate (List<int> rs)
				{
					if (rs != null && rs.Count > 0 && rs[0] < titles.Count - 1)
					{
						__instance.npc.SetTitle(__instance.npc.Titles[rs[0]].Id);
					}
					else if (rs != null && rs.Count > 0 && rs[0] == titles.Count - 1)
					{
						Wnd_Message.Show(TFMgr.Get("请输入称号"), 2, delegate (string name)
						{
							if (!string.IsNullOrEmpty(name))
							{
								__instance.npc.AddTitle(name, 0, g_emNpcTitleType.Normal, 4, TFMgr.Get("自定义标题"), false);
							}
						}, true, TFMgr.Get("自定义称号"), 1, 0, "");
					}
					else if (rs != null)
					{
						__instance.npc.SetTitle(0);
					}
					AccessTools.Method(typeof(Wnd_NpcInfo), "UpdateTitle", null, null).Invoke(__instance, null);
				};
				int num2 = 0;
				int num3 = 1;
				List<int> list;
				if (num >= 0)
				{
					(list = new List<int>()).Add(num);
				}
				else
				{
					list = null;
				}
				instance.Select(titles2, action, num2, num3, list, null, null, null, TFMgr.Get("选择称号"), delegate (UI_NormlSelectItem item, int index)
				{
					if (index < titles.Count - 1)
					{
						item.icon = "res/sprs/object/object_shuahua01";
						Npc.NpcTitle npcTitle2 = __instance.npc.Titles[index];
						string text = GameDefine.BindUBBColor(GameDefine.RateColors[npcTitle2.GetLevel()], titles[index]);
						if (!string.IsNullOrEmpty(npcTitle2.desc))
						{
							text = text + "\n" + npcTitle2.desc;
						}
						item.tooltips = text;
						return;
					}
					item.icon = "res/sprs/object/object_shuahua01";
					item.tooltips = TFMgr.Get( "增加一个自定义称号");
				});
				return false;
			}
		}
        

    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using XiaWorld;
using XLua;
using HarmonyLib;
using System.Reflection.Emit;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using CreativeSpore.SuperTilemapEditor;
using DigitalRuby.WeatherMaker;
using Es.InkPainter;
using Es.InkPainter.Sample;
using FoW;
using UnityEngine;


namespace iguana_acs_features
{
    class LingTexRework
    {
        public static bool enabled = false;
        //[HarmonyDebug]
        [HarmonyPatch(typeof(MapRender), "UpdateLingTex")]
        public static class iguana_UpdateLingTex
        {
            /*
            static IEnumerable<CodeInstruction> Transpiler(IEnumerable<CodeInstruction> instructions)
            {
                if (!enabled) { return instructions; }

                    foreach (CodeInstruction codeInstruction in instructions)
                {
                    if (codeInstruction.opcode.Name.ToString() == "ldc.r4" && codeInstruction.operand.ToString() == "300")
                    {
                        codeInstruction.operand = (float)15000;
                    }
                }
                return instructions;
            }
            */
            public static void Postfix(MapRender __instance)
            {
                if (!enabled)
                    return;
                List<int> allLing = World.Instance.map.Ling.GetAllLing();
                foreach (int key in allLing)
                {
                    Color clear = Color.clear;
                    int x;
                    int y;
                    GridMgr.Inst.Key2P(key, out x, out y);
                    if (World.Instance.map.IsInLight(key))
                    {
                        float ling = World.Instance.map.GetLing(key);
                        //clear.a = ling / 300f;
                    }
                    __instance.lingrender.SetPixel(x, y, clear);
                }
                __instance.lingrender.Apply();
            }

        }
    }
}

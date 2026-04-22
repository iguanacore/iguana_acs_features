using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using HarmonyLib;
using XiaWorld;

namespace iguana_acs_features
{
    class MapEnterCount
    {
        public static bool enabled=true;
        [HarmonyPatch(typeof(Wnd_SelectNpc4Map), "SelectPlace")]
        public static class iguana_MapEnterCountFightMapPatch
        {
            static IEnumerable<CodeInstruction> Transpiler(IEnumerable<CodeInstruction> instructions)
            {
                if (!enabled) { return instructions; }

                foreach (CodeInstruction codeInstruction in instructions)
                {
                    if (codeInstruction.opcode.Name.ToString() == "ldc.i4.s" && codeInstruction.operand.ToString() == "15")
                    {
                        codeInstruction.operand = 127;
                    }
                }
                return instructions;
            }
        }
        [HarmonyPatch(typeof(Wnd_SelectNpc4Map), "SelectWorld")]
        public static class iguana_MapEnterCountRPGMapPatch
        {
            static IEnumerable<CodeInstruction> Transpiler(IEnumerable<CodeInstruction> instructions)
            {
                if (!enabled) { return instructions; }

                foreach (CodeInstruction codeInstruction in instructions)
                {
                    if (codeInstruction.opcode.Name.ToString() == "ldc.i4.s" && codeInstruction.operand.ToString() == "30")
                    {
                        codeInstruction.operand = 127;
                    }
                }
                return instructions;
            }
        }
    }
}

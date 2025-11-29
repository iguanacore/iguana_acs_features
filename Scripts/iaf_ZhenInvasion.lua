ZhenInvasion = GameMain:GetMod("iauana_acs_features")
--  Inspired by BeginSchoolAttack, the Formation guide diagrams, and mod ID:2112709763
--  The amount of cursed code is to match the cursedness of the game code, this is a temporary solution
--
--  [Basic concepts] :
--  The CallInvasion function is the main, GenerateEnemies function generates a group of enemies based on the Shape provided, RetrieveRandomShape generates the shape
--  CallInvasionLevel function is currently used in the MapStory
--

-- Basic function, pure RNG
function ZhenInvasion.CallInvasion()
--formationshape = ZhenMgr:SetShapeNode(ZhenMgr:CreateShape(shapenames[randomint],true),ZhenMgr:ShapeInfo2Nodes(shapes[randomint]));
shapelevel = WorldLua:RandomInt(1,6);
formationshape = ZhenInvasion.RetrieveRandomShape(shapelevel);
-- Enemy Generation
-- Getting the amount of enemies required for the diagram
enemycount = formationshape.nodes.Count;
-- Array of enemies
Enemies={};
-- A random variable for the sex, 1 for male, 2 for female, 3 for mixed
sexvar = WorldLua:RandomInt(1,3);
sexarray = {g_emNpcSex.Male,g_emNpcSex.Female,g_emNpcSex.None}
-- The race array
racearray = {"YGRabbit","YGChicken","YGWolf","YGSnake","YGBoar","YGBear","YGTurtle","YGFrog","YGCat","YGCattle","YGTiger","YGPanda","Human"}
racevar = WorldLua:RandomInt(1,#racearray+1);
-- Generate enemies
ZhenInvasion.GenerateEnemies(enemycount, racearray[racevar], sexarray[sexvar])
-- Formation Creation
-- Spawn the formation
ZhenMgr:CreateZhen(false, formationshape, Enemies);
end

-- Level based formation spawning, level value can be between 1-5, 5 for Sect Formations
function ZhenInvasion.CallInvasionLevel(level);
    formationshape = ZhenInvasion.RetrieveRandomShape(level);
    enemycount = formationshape.nodes.Count;
    Enemies={};
    sexvar = WorldLua:RandomInt(1,3);
    sexarray = {g_emNpcSex.Male,g_emNpcSex.Female,g_emNpcSex.None}
    racearray = {"YGRabbit","YGChicken","YGWolf","YGSnake","YGBoar","YGBear","YGTurtle","YGFrog","YGCat","YGCattle","YGTiger","YGPanda","Human"}
    racevar = WorldLua:RandomInt(1,#racearray+1);
    ZhenInvasion.GenerateEnemies(enemycount, racearray[racevar], sexarray[sexvar]);
    ZhenMgr:CreateZhen(false, formationshape, Enemies);
end


-- Enemy generation for shape
function ZhenInvasion.GenerateEnemies(enemycount,enemyrace,enemysex)
    -- Spawn position, identical for all enemies
    position = Map:GetRandomSideKey(g_emThingDir.None)
    for i = 1,enemycount do
        -- The NPC as a variable
        enemy = CS.XiaWorld.NpcRandomMechine.RandomNpc(enemyrace,enemysex);
        -- Creating the NPC and the initial spawning
        CS.XiaWorld.NpcMgr.Instance:AddNpc(enemy,position,Map,CS.XiaWorld.Fight.g_emFightCamp.Enemy);
        CS.XiaWorld.ThingMgr.Instance:EquptNpc(enemy,12,CS.XiaWorld.g_emNpcRichLable.Richest);
        --Ancient Cultivator properties to beef them up
        enemy.PropertyMgr:AddModifier("Modifier_SpNpc_BasePropertie");
        enemy.PropertyMgr:AddModifier("Modifier_SpNpc_BaseFightPropertie");
        enemy.PropertyMgr:AddModifier("Modifier_SpNpc_Ling");
        -- Randomizing their Tree
        enemy.PropertyMgr.Practice:RandomTree();
        -- Boosting their GC, pillars get an increased bonus
        if i==1 then
            enemy.PropertyMgr.Practice:MakeGold(WorldLua:RandomInt(550000,750000));
        else
            enemy.PropertyMgr.Practice:MakeGold(WorldLua:RandomInt(450000,550000));
        end
        -- Refilling their Qi
        enemy:AddLing(enemy.MaxLing - enemy.LingV, 0);
        -- Title generation
        if i==1 then
            enemy:AddTitle(XT("Formation Pillar"));
        else
            enemy:AddTitle(XT("Formation Disciple"));
        end
        -- Pillar boosting
        if i==1 then
            enemy.PropertyMgr:ModifierProperty("NpcFight_ZhenKeyPointNum", 50,0,0,0);
            enemy.PropertyMgr:ModifierProperty("NpcFight_ZhenEnginePower", 10000,0,0,0);
            enemy.PropertyMgr:AddModifier("Modifier_NomalNpc_BasePropertie_God");
            enemy.PropertyMgr:AddModifier("Modifier_SpNpc_FabaoAtk");
        end
        -- Adding the enemy to the array of enemies
        Enemies[i] = enemy
    end
    return Enemies
end

-- Shape retrieving based on level
function ZhenInvasion.RetrieveRandomShape(level)
-- Shapes to Zhen, one array for each level
    local shapesLv1 = {
        "6|6|0|ZhenMainNode_Lv1_3_13|6|7|2|ZhenNode_Lv1_2_7|7|7|3|ZhenNode_Lv1_3_13|7|6|5|ZhenNode_Lv1_2_7",
        "6|6|0|ZhenMainNode_Lv1_3_14|6|7|2|ZhenNode_Lv1_2_8|7|7|3|ZhenNode_Lv1_3_14|7|6|5|ZhenNode_Lv1_2_8",
        "6|6|0|ZhenMainNode_Lv1_3_15|6|7|2|ZhenNode_Lv1_2_9|7|7|3|ZhenNode_Lv1_3_15|7|6|5|ZhenNode_Lv1_2_9",
        "6|6|0|ZhenMainNode_Lv1_3_16|6|7|2|ZhenNode_Lv1_2_10|7|7|3|ZhenNode_Lv1_3_16|7|6|5|ZhenNode_Lv1_2_10",
        "6|6|0|ZhenMainNode_Lv1_3_1|6|7|3|ZhenNode_Lv1_3_13|5|7|2|ZhenNode_Lv1_2_7|5|6|0|ZhenNode_Lv1_2_7|7|6|5|ZhenNode_Lv1_3_15|7|7|2|ZhenNode_Lv1_2_9|8|7|4|ZhenNode_Lv1_2_9|5|5|1|ZhenNode_Lv1_3_16|6|5|4|ZhenNode_Lv1_2_10|5|4|0|ZhenNode_Lv1_2_10",
        "6|6|0|ZhenMainNode_Lv1_3_2|6|7|3|ZhenNode_Lv1_3_14|5|7|2|ZhenNode_Lv1_2_8|5|6|0|ZhenNode_Lv1_2_8|7|6|5|ZhenNode_Lv1_3_15|7|7|2|ZhenNode_Lv1_2_9|8|7|4|ZhenNode_Lv1_2_9|5|5|1|ZhenNode_Lv1_3_16|6|5|4|ZhenNode_Lv1_2_10|5|4|0|ZhenNode_Lv1_2_10",
        "6|6|0|ZhenMainNode_Lv1_3_3|6|7|2|ZhenNode_Lv1_2_7|7|7|3|ZhenNode_Lv1_3_13|6|5|0|ZhenNode_Lv1_3_15|7|6|3|ZhenNode_Lv1_3_5|7|5|5|ZhenNode_Lv1_2_9",
        "6|6|0|ZhenMainNode_Lv1_3_4|6|7|2|ZhenNode_Lv1_2_8|7|7|3|ZhenNode_Lv1_3_14|6|5|0|ZhenNode_Lv1_3_15|7|6|3|ZhenNode_Lv1_3_6|7|5|5|ZhenNode_Lv1_2_9",
        "6|6|0|ZhenMainNode_Lv1_3_5|6|7|2|ZhenNode_Lv1_2_9|7|7|3|ZhenNode_Lv1_3_15|6|5|0|ZhenNode_Lv1_3_13|7|6|3|ZhenNode_Lv1_3_3|7|5|5|ZhenNode_Lv1_2_7",
        "6|6|0|ZhenMainNode_Lv1_3_6|6|7|2|ZhenNode_Lv1_2_9|7|7|3|ZhenNode_Lv1_3_15|6|5|0|ZhenNode_Lv1_3_14|7|6|3|ZhenNode_Lv1_3_4|7|5|5|ZhenNode_Lv1_2_8",
        "6|6|0|ZhenMainNode_Lv1_3_7|6|7|1|ZhenNode_Lv1_3_15|7|8|3|ZhenNode_Lv1_2_9|7|7|4|ZhenNode_Lv1_3_15|6|5|0|ZhenNode_Lv1_3_16|7|6|3|ZhenNode_Lv1_2_10|7|5|5|ZhenNode_Lv1_2_10",
        "6|6|0|ZhenMainNode_Lv1_3_8|6|7|2|ZhenNode_Lv1_3_13|7|7|4|ZhenNode_Lv1_2_7|5|5|5|ZhenNode_Lv1_3_16|5|6|3|ZhenNode_Lv1_3_10|4|5|1|ZhenNode_Lv1_2_10",
        "6|6|0|ZhenMainNode_Lv1_3_9|6|7|2|ZhenNode_Lv1_3_14|7|7|4|ZhenNode_Lv1_2_8|5|5|5|ZhenNode_Lv1_3_16|5|6|3|ZhenNode_Lv1_3_11|4|5|1|ZhenNode_Lv1_2_10",
        "6|6|0|ZhenMainNode_Lv1_3_10|6|7|2|ZhenNode_Lv1_3_16|7|7|4|ZhenNode_Lv1_2_10|5|5|5|ZhenNode_Lv1_3_13|5|6|3|ZhenNode_Lv1_3_8|4|5|1|ZhenNode_Lv1_2_7",
        "6|6|0|ZhenMainNode_Lv1_3_11|6|7|2|ZhenNode_Lv1_3_16|7|7|4|ZhenNode_Lv1_2_10|5|5|5|ZhenNode_Lv1_3_14|5|6|3|ZhenNode_Lv1_3_9|4|5|1|ZhenNode_Lv1_2_8",
        "6|6|0|ZhenMainNode_Lv1_3_12|6|7|2|ZhenNode_Lv1_2_10|7|7|4|ZhenNode_Lv1_2_10|5|5|5|ZhenNode_Lv1_3_15|5|6|3|ZhenNode_Lv1_3_7|5|7|3|ZhenNode_Lv1_1_4|4|5|1|ZhenNode_Lv1_2_9",
        "6|6|0|ZhenMainNode_Lv1_4_9|6|7|2|ZhenNode_Lv1_3_3|5|7|0|ZhenNode_Lv1_2_5|5|8|3|ZhenNode_Lv1_1_2|7|7|3|ZhenNode_Lv1_3_13|7|6|4|ZhenNode_Lv1_3_13|6|5|0|ZhenNode_Lv1_3_8|5|4|1|ZhenNode_Lv1_1_4",
        "6|6|0|ZhenMainNode_Lv1_4_10|6|7|2|ZhenNode_Lv1_3_9|6|8|1|ZhenNode_Lv1_2_4|7|9|4|ZhenNode_Lv1_1_1|7|7|3|ZhenNode_Lv1_3_14|7|6|4|ZhenNode_Lv1_3_14|6|5|0|ZhenNode_Lv1_3_4|6|4|0|ZhenNode_Lv1_1_3",
        "6|6|0|ZhenMainNode_Lv1_4_11|6|7|2|ZhenNode_Lv1_3_7|5|7|0|ZhenNode_Lv1_2_4|5|8|3|ZhenNode_Lv1_1_1|7|7|3|ZhenNode_Lv1_3_15|7|6|4|ZhenNode_Lv1_3_15|6|5|0|ZhenNode_Lv1_3_6|6|4|0|ZhenNode_Lv1_1_2",
        "6|6|0|ZhenMainNode_Lv1_4_12|6|7|2|ZhenNode_Lv1_3_11|6|8|0|ZhenNode_Lv1_2_1|6|9|3|ZhenNode_Lv1_1_1|7|7|3|ZhenNode_Lv1_3_16|7|6|4|ZhenNode_Lv1_3_16|6|5|0|ZhenNode_Lv1_3_12|5|4|1|ZhenNode_Lv1_1_3",
        "6|6|0|ZhenMainNode_Lv1_4_1|6|7|1|ZhenNode_Lv1_3_3|7|7|4|ZhenNode_Lv1_3_13|7|8|3|ZhenNode_Lv1_2_7|7|6|3|ZhenNode_Lv1_3_14|7|5|5|ZhenNode_Lv1_2_8|6|5|1|ZhenNode_Lv1_3_9|5|5|1|ZhenNode_Lv1_3_16|5|4|5|ZhenNode_Lv1_2_10|4|4|2|ZhenNode_Lv1_1_4|5|6|0|ZhenNode_Lv1_3_15|5|7|3|ZhenNode_Lv1_2_9|4|6|1|ZhenNode_Lv1_1_3",
        "6|6|0|ZhenMainNode_Lv1_4_2|7|7|2|ZhenNode_Lv1_3_13|7|6|5|ZhenNode_Lv1_3_13|8|7|4|ZhenNode_Lv1_3_3|9|8|4|ZhenNode_Lv1_1_3|5|6|2|ZhenNode_Lv1_3_14|5|5|5|ZhenNode_Lv1_3_14|4|5|1|ZhenNode_Lv1_3_9|3|5|2|ZhenNode_Lv1_1_4",
        "6|6|0|ZhenMainNode_Lv1_4_3|7|7|4|ZhenNode_Lv1_3_13|6|7|1|ZhenNode_Lv1_2_7|7|8|3|ZhenNode_Lv1_2_7|7|6|3|ZhenNode_Lv1_3_15|6|5|1|ZhenNode_Lv1_2_9|7|5|5|ZhenNode_Lv1_2_9|5|6|2|ZhenNode_Lv1_2_1|4|6|2|ZhenNode_Lv1_1_2|5|5|1|ZhenNode_Lv1_2_2|4|4|1|ZhenNode_Lv1_1_4",
        "6|6|0|ZhenMainNode_Lv1_4_4|7|7|4|ZhenNode_Lv1_3_14|6|7|1|ZhenNode_Lv1_2_8|7|8|3|ZhenNode_Lv1_2_8|7|6|3|ZhenNode_Lv1_3_15|6|5|1|ZhenNode_Lv1_2_9|7|5|5|ZhenNode_Lv1_2_9|5|6|5|ZhenNode_Lv1_2_1|4|6|2|ZhenNode_Lv1_1_1|5|5|1|ZhenNode_Lv1_2_2|4|4|1|ZhenNode_Lv1_1_4",
        "6|6|0|ZhenMainNode_Lv1_4_5|6|5|5|ZhenNode_Lv1_3_13|6|7|1|ZhenNode_Lv1_3_16|7|7|5|ZhenNode_Lv1_3_10|7|6|4|ZhenNode_Lv1_3_13|5|5|1|ZhenNode_Lv1_3_3|7|8|3|ZhenNode_Lv1_3_11|8|9|4|ZhenNode_Lv1_1_2|4|4|1|ZhenNode_Lv1_1_3",
        "6|6|0|ZhenMainNode_Lv1_4_6|6|5|5|ZhenNode_Lv1_3_14|7|6|4|ZhenNode_Lv1_3_14|6|7|1|ZhenNode_Lv1_3_16|7|7|5|ZhenNode_Lv1_3_11|7|8|3|ZhenNode_Lv1_3_10|8|9|4|ZhenNode_Lv1_1_1|5|5|1|ZhenNode_Lv1_3_4|4|4|1|ZhenNode_Lv1_1_3",
        "6|6|0|ZhenMainNode_Lv1_4_7|6|5|5|ZhenNode_Lv1_3_15|6|7|3|ZhenNode_Lv1_3_13|5|5|0|ZhenNode_Lv1_3_15|5|6|0|ZhenNode_Lv1_3_3|5|7|2|ZhenNode_Lv1_3_8|5|8|3|ZhenNode_Lv1_1_4|7|6|4|ZhenNode_Lv1_3_6|8|7|4|ZhenNode_Lv1_1_2",
        "6|6|0|ZhenMainNode_Lv1_4_8|6|5|5|ZhenNode_Lv1_3_15|5|5|0|ZhenNode_Lv1_3_15|6|7|3|ZhenNode_Lv1_3_14|5|6|0|ZhenNode_Lv1_3_4|5|7|2|ZhenNode_Lv1_3_9|5|8|3|ZhenNode_Lv1_1_4|7|6|4|ZhenNode_Lv1_3_5|8|7|4|ZhenNode_Lv1_1_1"
    }
    local shapesLv2 = {
        "6|6|0|ZhenMainNode_Lv2_4_1|7|7|4|ZhenNode_Lv2_2_9|5|6|2|ZhenNode_Lv2_2_12|7|6|5|ZhenNode_Lv2_2_10|5|5|1|ZhenNode_Lv2_2_11|8|8|4|ZhenNode_Lv2_2_9|8|6|5|ZhenNode_Lv2_2_10|4|4|1|ZhenNode_Lv2_2_11|4|6|2|ZhenNode_Lv2_2_12|9|9|2|ZhenNode_Lv2_2_17|9|6|5|ZhenNode_Lv2_2_53|10|9|3|ZhenNode_Lv2_2_25|10|8|0|ZhenNode_Lv2_2_13|10|7|4|ZhenNode_Lv2_2_35|3|6|2|ZhenNode_Lv2_2_12|3|3|1|ZhenNode_Lv2_2_11|2|6|2|ZhenNode_Lv2_2_27|1|5|1|ZhenNode_Lv2_2_39|2|2|5|ZhenNode_Lv2_2_52|1|2|0|ZhenNode_Lv2_2_23|1|3|1|ZhenNode_Lv2_2_72|2|4|4|ZhenNode_Lv2_1_8|1|4|0|ZhenNode_Lv2_1_7",
        "6|6|0|ZhenMainNode_Lv2_4_2|7|7|4|ZhenNode_Lv2_2_13|7|6|5|ZhenNode_Lv2_2_14|5|5|1|ZhenNode_Lv2_2_16|5|6|2|ZhenNode_Lv2_2_15|4|6|2|ZhenNode_Lv2_2_15|4|4|1|ZhenNode_Lv2_2_16|8|6|5|ZhenNode_Lv2_2_14|8|8|4|ZhenNode_Lv2_2_13|3|3|1|ZhenNode_Lv2_2_16|9|6|5|ZhenNode_Lv2_2_14|9|9|4|ZhenNode_Lv2_2_13|3|6|2|ZhenNode_Lv2_2_15|2|6|2|ZhenNode_Lv2_2_19|1|5|1|ZhenNode_Lv2_1_1|2|2|1|ZhenNode_Lv2_2_57|2|1|0|ZhenNode_Lv2_1_3|10|6|3|ZhenNode_Lv2_2_67|10|5|0|ZhenNode_Lv2_1_2|10|10|2|ZhenNode_Lv2_2_34|11|10|5|ZhenNode_Lv2_1_4",
        "6|6|0|ZhenMainNode_Lv2_4_4|6|7|3|ZhenNode_Lv2_2_10|6|5|0|ZhenNode_Lv2_2_15|7|6|5|ZhenNode_Lv2_2_13|5|5|1|ZhenNode_Lv2_2_11|8|6|5|ZhenNode_Lv2_2_13|4|4|1|ZhenNode_Lv2_2_11|6|4|0|ZhenNode_Lv2_2_26|7|4|5|ZhenNode_Lv2_2_10|6|8|1|ZhenNode_Lv2_2_26|8|4|5|ZhenNode_Lv2_1_2|7|9|4|ZhenNode_Lv2_2_15|8|10|4|ZhenNode_Lv2_1_7|3|3|1|ZhenNode_Lv2_2_11|9|6|5|ZhenNode_Lv2_2_13|2|2|5|ZhenNode_Lv2_2_52|10|6|5|ZhenNode_Lv2_2_68|1|2|0|ZhenNode_Lv2_2_20|1|3|3|ZhenNode_Lv2_1_4|11|7|4|ZhenNode_Lv2_2_65|11|8|3|ZhenNode_Lv2_1_8",
        "6|6|0|ZhenMainNode_Lv2_4_4|6|7|3|ZhenNode_Lv2_2_10|6|5|0|ZhenNode_Lv2_2_15|6|4|0|ZhenNode_Lv2_2_26|6|8|1|ZhenNode_Lv2_2_26|7|9|4|ZhenNode_Lv2_2_15|7|4|5|ZhenNode_Lv2_2_10|8|4|5|ZhenNode_Lv2_1_2|8|10|4|ZhenNode_Lv2_1_7|5|5|1|ZhenNode_Lv2_2_11|4|4|1|ZhenNode_Lv2_2_11|7|6|5|ZhenNode_Lv2_2_13|8|6|5|ZhenNode_Lv2_2_13|3|3|1|ZhenNode_Lv2_2_11|9|6|5|ZhenNode_Lv2_2_13|2|2|5|ZhenNode_Lv2_2_52|10|6|5|ZhenNode_Lv2_2_68|1|2|0|ZhenNode_Lv2_2_20|1|3|3|ZhenNode_Lv2_1_4|11|7|4|ZhenNode_Lv2_2_65|11|8|3|ZhenNode_Lv2_1_8",
        "6|6|0|ZhenMainNode_Lv2_4_5|7|7|4|ZhenNode_Lv2_2_10|7|6|5|ZhenNode_Lv2_2_14|5|5|1|ZhenNode_Lv2_2_16|5|6|2|ZhenNode_Lv2_2_12|8|8|4|ZhenNode_Lv2_2_10|4|4|1|ZhenNode_Lv2_2_16|8|6|5|ZhenNode_Lv2_2_14|4|6|2|ZhenNode_Lv2_2_12|3|3|1|ZhenNode_Lv2_2_16|3|6|2|ZhenNode_Lv2_2_12|9|9|4|ZhenNode_Lv2_2_10|9|6|5|ZhenNode_Lv2_2_14|10|10|4|ZhenNode_Lv2_2_17|10|11|3|ZhenNode_Lv2_1_1|2|6|0|ZhenNode_Lv2_2_48|2|7|3|ZhenNode_Lv2_1_7|2|2|1|ZhenNode_Lv2_2_36|2|1|0|ZhenNode_Lv2_1_5|10|6|3|ZhenNode_Lv2_2_71|10|5|0|ZhenNode_Lv2_1_3",
        "6|6|0|ZhenMainNode_Lv2_4_6|7|7|4|ZhenNode_Lv2_2_9|8|8|4|ZhenNode_Lv2_2_9|9|9|4|ZhenNode_Lv2_2_9|7|6|5|ZhenNode_Lv2_2_13|8|6|5|ZhenNode_Lv2_2_13|9|6|5|ZhenNode_Lv2_2_13|5|5|1|ZhenNode_Lv2_2_15|4|4|1|ZhenNode_Lv2_2_15|3|3|1|ZhenNode_Lv2_2_15|5|6|2|ZhenNode_Lv2_2_11|4|6|2|ZhenNode_Lv2_2_11|3|6|2|ZhenNode_Lv2_2_11|2|6|0|ZhenNode_Lv2_2_53|2|7|3|ZhenNode_Lv2_1_2|10|10|4|ZhenNode_Lv2_2_66|10|11|3|ZhenNode_Lv2_1_6|10|6|3|ZhenNode_Lv2_2_34|10|5|0|ZhenNode_Lv2_1_4|2|2|1|ZhenNode_Lv2_2_62|2|1|0|ZhenNode_Lv2_1_8"
    }
    local shapesLv3 = {
        "6|6|0|ZhenMainNode_Lv3_2_1|6|5|0|ZhenNode_Lv3_3_7|6|7|3|ZhenNode_Lv3_3_2|7|8|4|ZhenNode_Lv2_3_8|8|8|5|ZhenNode_Lv1_1_2|7|9|3|ZhenNode_Lv1_1_2|5|4|1|ZhenNode_Lv2_3_16|5|3|0|ZhenNode_Lv1_1_1|4|4|2|ZhenNode_Lv1_1_1|5|7|2|ZhenNode_Lv2_2_68|4|6|1|ZhenNode_Lv2_1_6|7|5|5|ZhenNode_Lv2_2_20|8|6|4|ZhenNode_Lv2_1_1",
        "6|6|0|ZhenMainNode_Lv3_2_2|6|5|0|ZhenNode_Lv3_3_12|6|7|3|ZhenNode_Lv3_3_13|7|5|5|ZhenNode_Lv2_2_33|5|7|2|ZhenNode_Lv2_2_39|7|8|2|ZhenNode_Lv2_2_28|4|6|1|ZhenNode_Lv2_2_62|8|8|5|ZhenNode_Lv2_3_15|8|7|0|ZhenNode_Lv1_1_3|9|9|4|ZhenNode_Lv1_1_3|8|6|4|ZhenNode_Lv2_1_5|4|5|0|ZhenNode_Lv2_1_8|5|4|1|ZhenNode_Lv2_1_7",
        "6|6|0|ZhenMainNode_Lv3_2_3|6|5|0|ZhenNode_Lv3_3_21|6|7|3|ZhenNode_Lv3_3_19|7|5|5|ZhenNode_Lv2_3_6|7|4|0|ZhenNode_Lv1_1_3|8|6|0|ZhenNode_Lv1_3_12|8|7|2|ZhenNode_Lv1_2_10|9|7|4|ZhenNode_Lv1_2_10|5|4|5|ZhenNode_Lv2_2_29|4|4|2|ZhenNode_Lv2_1_8|7|8|4|ZhenNode_Lv2_2_28|5|7|0|ZhenNode_Lv2_2_55|5|8|3|ZhenNode_Lv2_1_7|7|9|3|ZhenNode_Lv2_1_2",
        "6|6|0|ZhenMainNode_Lv3_2_4|6|7|3|ZhenNode_Lv3_3_28|6|5|0|ZhenNode_Lv3_3_29|5|7|2|ZhenNode_Lv2_3_20|7|5|5|ZhenNode_Lv2_3_4|8|6|4|ZhenNode_Lv1_1_1|7|4|0|ZhenNode_Lv1_1_1|4|6|1|ZhenNode_Lv1_1_2|5|8|3|ZhenNode_Lv1_1_2|5|4|5|ZhenNode_Lv2_2_29|7|8|2|ZhenNode_Lv2_2_38|4|4|2|ZhenNode_Lv2_1_8|8|8|5|ZhenNode_Lv2_1_1",
        "6|6|0|ZhenMainNode_Lv3_2_5|6|7|3|ZhenNode_Lv3_3_35|7|8|4|ZhenNode_Lv2_3_13|5|7|2|ZhenNode_Lv2_3_14|5|8|3|ZhenNode_Lv1_1_2|4|6|1|ZhenNode_Lv1_1_2|7|9|3|ZhenNode_Lv1_1_1|6|5|0|ZhenNode_Lv3_3_39|5|4|1|ZhenNode_Lv2_2_34|5|3|0|ZhenNode_Lv2_1_5|7|5|5|ZhenNode_Lv2_2_41|8|6|4|ZhenNode_Lv2_1_7|8|8|5|ZhenNode_Lv1_1_1",
        "6|6|0|ZhenMainNode_Lv3_2_6|6|5|0|ZhenNode_Lv3_3_47|6|7|3|ZhenNode_Lv3_3_43|7|8|4|ZhenNode_Lv2_3_15|7|9|3|ZhenNode_Lv1_1_3|7|5|3|ZhenNode_Lv2_2_51|7|4|0|ZhenNode_Lv2_1_6|5|4|1|ZhenNode_Lv2_2_34|5|3|0|ZhenNode_Lv2_1_5|5|7|2|ZhenNode_Lv2_1_3|8|8|5|ZhenNode_Lv1_2_2|9|8|5|ZhenNode_Lv1_1_4"
    }
    local shapesLv4 = {
        "6|6|0|ZhenMainNode_Lv4_2_1|6|7|3|ZhenNode_Lv4_5_3|6|5|0|ZhenNode_Lv4_5_6|7|8|3|ZhenNode_Lv0_3_4|6|8|2|ZhenNode_Lv0_2_2|7|7|5|ZhenNode_Lv0_3_3|5|7|1|ZhenNode_Lv0_3_4|5|6|0|ZhenNode_Lv0_3_2|7|6|3|ZhenNode_Lv0_3_2|7|5|4|ZhenNode_Lv0_3_4|6|4|5|ZhenNode_Lv0_2_2|5|4|0|ZhenNode_Lv0_3_4|5|5|2|ZhenNode_Lv0_3_3"
    }
    local shapesLvSect = {
        "6|5|2|ZhenMainNode_School_1|6|6|3|ZhenNode_Lv0_3_1|7|5|5|ZhenNode_Lv0_3_1|5|4|1|ZhenNode_Lv0_3_1|5|6|2|ZhenNode_Lv0_2_2|4|5|1|ZhenNode_Lv0_2_2|4|4|0|ZhenNode_Lv0_2_2|5|3|0|ZhenNode_Lv0_2_2|6|3|5|ZhenNode_Lv0_2_2|7|4|4|ZhenNode_Lv0_2_2|8|6|4|ZhenNode_Lv0_2_2|8|7|3|ZhenNode_Lv0_2_2|7|7|2|ZhenNode_Lv0_2_2",
        "6|4|5|ZhenMainNode_School_2|5|4|2|ZhenNode_Lv0_2_2|7|5|2|ZhenNode_Lv0_2_2|4|3|0|ZhenNode_Lv0_2_3|4|4|1|ZhenNode_Lv0_2_2|5|5|4|ZhenNode_Lv0_2_2|8|5|5|ZhenNode_Lv0_2_3|8|6|3|ZhenNode_Lv0_2_2|7|6|0|ZhenNode_Lv0_2_2|7|7|3|ZhenNode_Lv0_2_2|6|7|2|ZhenNode_Lv0_2_2|5|6|1|ZhenNode_Lv0_2_2",
        "6|5|0|ZhenMainNode_School_3|6|6|3|ZhenNode_Lv0_2_1|6|7|3|ZhenNode_Lv0_2_1|6|8|3|ZhenNode_Lv0_1_1|5|4|1|ZhenNode_Lv0_2_1|4|3|1|ZhenNode_Lv0_2_2|7|5|5|ZhenNode_Lv0_2_1|8|5|3|ZhenNode_Lv0_2_2|4|2|0|ZhenNode_Lv0_1_1|8|4|0|ZhenNode_Lv0_1_1",
        "6|4|3|ZhenMainNode_School_4|6|3|0|ZhenNode_Lv0_1_1|6|5|3|ZhenNode_Lv0_2_1|7|5|4|ZhenNode_Lv0_2_1|5|4|2|ZhenNode_Lv0_2_1|4|4|2|ZhenNode_Lv0_2_1|8|6|4|ZhenNode_Lv0_2_1|6|6|3|ZhenNode_Lv0_3_1|5|6|2|ZhenNode_Lv0_2_2|4|5|1|ZhenNode_Lv0_2_1|3|4|1|ZhenNode_Lv0_2_3|7|7|2|ZhenNode_Lv0_2_2|8|7|5|ZhenNode_Lv0_2_1|9|7|4|ZhenNode_Lv0_2_3",
        "6|7|2|ZhenMainNode_School_5|3|5|1|ZhenNode_Lv0_1_1|9|8|5|ZhenNode_Lv0_1_1|5|4|1|ZhenNode_Lv0_1_1|7|5|5|ZhenNode_Lv0_1_1|7|7|5|ZhenNode_Lv0_2_2|4|6|2|ZhenNode_Lv0_2_2|8|8|2|ZhenNode_Lv0_2_2|5|6|5|ZhenNode_Lv0_2_2|6|6|0|ZhenNode_Lv0_2_1|6|5|0|ZhenNode_Lv0_3_1",
        "6|5|0|ZhenMainNode_School_6|5|5|2|ZhenNode_Lv0_2_1|4|5|2|ZhenNode_Lv0_1_1|6|6|3|ZhenNode_Lv0_2_1|6|7|3|ZhenNode_Lv0_1_1|8|7|4|ZhenNode_Lv0_1_1|5|4|1|ZhenNode_Lv0_2_1|4|3|1|ZhenNode_Lv0_1_1|7|5|2|ZhenNode_Lv0_2_1|8|5|5|ZhenNode_Lv0_1_1|7|6|4|ZhenNode_Lv0_2_1",
        "7|5|0|ZhenMainNode_School_7|6|5|0|ZhenNode_Lv0_2_2|8|6|4|ZhenNode_Lv0_2_2|8|7|1|ZhenNode_Lv0_2_2|6|6|3|ZhenNode_Lv0_2_2|5|6|2|ZhenNode_Lv0_2_2|4|5|1|ZhenNode_Lv0_2_2|9|8|2|ZhenNode_Lv0_2_2|10|8|3|ZhenNode_Lv0_2_2|4|4|0|ZhenNode_Lv0_1_1|10|7|0|ZhenNode_Lv0_1_1",
        "6|4|0|ZhenMainNode_School_8|5|3|1|ZhenNode_Lv0_1_1|7|4|5|ZhenNode_Lv0_1_1|6|5|3|ZhenNode_Lv0_2_1|6|6|3|ZhenNode_Lv0_2_1|6|7|2|ZhenNode_Lv0_3_4|5|6|1|ZhenNode_Lv0_2_1|7|7|5|ZhenNode_Lv0_2_1|4|5|1|ZhenNode_Lv0_2_1|8|7|5|ZhenNode_Lv0_2_1|3|4|1|ZhenNode_Lv0_1_1|9|7|5|ZhenNode_Lv0_1_1",
        "6|6|2|ZhenMainNode_School_9|7|6|2|ZhenNode_Lv0_3_2|4|4|1|ZhenNode_Lv0_2_1|3|3|1|ZhenNode_Lv0_1_1|8|6|5|ZhenNode_Lv0_2_1|9|6|5|ZhenNode_Lv0_1_1|6|4|0|ZhenNode_Lv0_2_1|6|3|0|ZhenNode_Lv0_1_1|6|5|3|ZhenNode_Lv0_2_1|5|5|3|ZhenNode_Lv0_3_3|5|4|4|ZhenNode_Lv0_2_2|4|3|1|ZhenNode_Lv0_1_1|7|5|0|ZhenNode_Lv0_2_2|8|5|5|ZhenNode_Lv0_1_1",
        "6|6|2|ZhenMainNode_School_10|5|5|1|ZhenNode_Lv0_2_1|4|4|1|ZhenNode_Lv0_2_1|3|3|1|ZhenNode_Lv0_1_1|7|6|5|ZhenNode_Lv0_1_1|7|7|4|ZhenNode_Lv0_2_1|8|8|2|ZhenNode_Lv0_2_2|9|8|5|ZhenNode_Lv0_2_2|10|9|4|ZhenNode_Lv0_1_1",
        "6|6|0|ZhenMainNode_School_11|5|6|2|ZhenNode_Lv0_2_1|4|6|2|ZhenNode_Lv0_2_1|3|6|2|ZhenNode_Lv0_1_1|7|7|4|ZhenNode_Lv0_2_1|8|8|4|ZhenNode_Lv0_2_1|9|9|4|ZhenNode_Lv0_1_1|5|5|1|ZhenNode_Lv0_2_2|7|6|3|ZhenNode_Lv0_2_2|5|4|0|ZhenNode_Lv0_2_2|7|5|4|ZhenNode_Lv0_2_2|6|4|5|ZhenNode_Lv0_3_1|6|3|0|ZhenNode_Lv0_1_1"
    }

    -- The diagram names, used to name the formation.
    local shapenamesLv1 = {
        "Concentrated Sword Aura Formation",
        "Hidden Seal of Creed Formation",
        "True Congealed Positivity Formation",
        "Supreme Transformed Pliability Formation",
        "Hidden Blade of Positivity Formation",
        "Hidden Curse of Verification Formation",
        "Armored Scorpion Tail Formation",
        "Scaled Snake Breath Formation",
        "Sworded Turtle Tail Formation",
        "Cursed Turtle Form Formation",
        "Petrified Turtle Shell Formation",
        "Rain of Pine Spikes Formation",
        "Wind of Cursed Pine Formation",
        "Old Hidden Thorn Formation",
        "Deadwood Spirit Formation",
        "Pine-clamped Rock Formation",
        "Cardinal of Swords Formation",
        "Cardinal of Creeds Formation",
        "Cardinal of True Positivity Formation",
        "Cardinal of Profound Pliability Formation",
        "Balance of the Realms Formation",
        "Cry of the Crane Formation",
        "Thundercloud Dragon Formation",
        "Soaring Flood Dragon Formation",
        "Blade of Tide Formation",
        "Constant of Storm Formation",
        "Earth-piercing Blade Formation",
        "Sand of Divine Curse Formation"
    }
    local shapenamesLv2 = {
        "Heaven-Earth Harmony Formation",
        "Wind-Thunder Centrality Formation",
        "Yin-Yang Conversion Formation",
        "Yang-Yin Conversion Formation",
        "Way of Extreme Yin Formation",
        "Way of Extreme Yang Formation"
    }
    local shapenamesLv3 = {
        "Sun-Moon Wax and Wane Formation",
        "Yin-Yang Rise and Fall Formation",
        "Space-Time Evolution Formation",
        "Cycle of Beginning and End Formation",
        "Everything's Life and Death Formation",
        "Secrets of Creation Formation"
    }
    local shapenamesLv4 = {
        "Lesser Great Vastness Formation"
    }
    local shapenamesLvSect = {
        "Sunshade Formation",
        "Kunlun Formation",
        "Skydome Formation",
        "Purple Cloud Formation",
        "True Unity Formation",
        "Caerulea Formation",
        "Evenfall Formation",
        "Hundred Insects Formation",
        "Doom Formation",
        "Seven Slaughters Formation",
        "Reunion Formation"
    }

    -- Because Lua lacks a Switch statement:
    if level == 1 then
        shapenames = shapenamesLv1
        shapes = shapesLv1
    elseif level == 2 then
        shapenames = shapenamesLv2
        shapes = shapesLv2
    elseif level == 3 then
        shapenames = shapenamesLv3
        shapes = shapesLv3
    elseif level == 4 then
        shapenames = shapenamesLv4
        shapes = shapesLv4
    else
        shapenames = shapenamesLvSect
        shapes=shapesLvSect
    end
    -- Random shape index
    local randomint = WorldLua:RandomInt(1,#shapes+1);

    -- Turning the strings into a proper Shape
    fshape = ZhenMgr:SetShapeNode(ZhenMgr:CreateShape(shapenames[randomint],true),ZhenMgr:ShapeInfo2Nodes(shapes[randomint]));

    return fshape

end
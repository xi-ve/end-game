using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Generator_ActionScripts.ActionCharts;
using Generator_ActionScripts.ActionCharts.FrameEvents;
using Generator_ActionScripts.AddressGeneration;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts
{
    class Program
    {
        public static string g_Path_BlackDesert64Dump = @"D:\BlackDesert64_dump855.exe";

        public static string g_PazFileRoot = @"D:\855\bdo";
        public static string g_Path_ActionCharts = g_PazFileRoot + @"\character\binaryactionchart";
        public static string g_Path_Motions = g_PazFileRoot + @"\character\motion";

        public static long g_ModuleBase = 0x140000000;
        public static long g_DataOffset = 0xC00;
        public static byte[] g_ModuleData;

        public static Dictionary<string, ActionScript> g_ActionScripts;
        public static ActionChartPackagePCRaw g_ActionChartPackage;

        public static Dictionary<int, bool> g_AllowedFrameTypes = new Dictionary<int, bool>()
        {
            { 0  , true },
            { 1  , true },
            { 2  , true },
            { 3  , true },
            { 4  , true },
            { 5  , true },
            { 25 , true },
            { 26 , true },
            { 70 , true },
            { 71 , true },
            { 72 , true },
            { 85 , true },
            { 86 , true },
            { 87 , true },
            { 89 , true },
            { 90 , true },
            { 91 , true },
            { 92 , true },
            { 93 , true },
            { 94 , true },
            { 96 , true },
            { 100, true },
            { 101, true },
            { 104, true },
            { 105, true },
            { 108, true },
            { 112, true },
            { 113, true },
            { 122, true },
            { 124, true },
            { 125, true },
            { 129, true },
            { 130, true },
            { 131, true },
            { 134, true }
        };

        static void Main(string[] args)
        {
            Read_Dump();

            Gen_FunctionAddresses();

            g_ActionScripts = new Dictionary<string, ActionScript>();
            Parse_ActionCharts();

            Console.WriteLine("Starting Linking Process in a 5 seconds...");
            Thread.Sleep(5000);

            LinkAndWrite_BinaryActionChart();

            Console.ReadLine();
        }

        static void Read_Dump()
        {
            g_ModuleData = File.ReadAllBytes(g_Path_BlackDesert64Dump);
        }

        static void Gen_FunctionAddresses()
        {
            List<ByteSequence_FunctionObject> m_FunctionObjects = new List<ByteSequence_FunctionObject>()
            {
                new ByteSequence_FunctionObject("loadActionChartPackagePcRaw", @"\x80\x3A\x02\x75\x26\x48\x8B\x52\x48\x4C\x8D\x42\x08\x8B\x47\x40", "xxxxxxxxxxxxxxxx", -0x20),
                new ByteSequence_FunctionObject("loadActionScript", @"\x41\x8B\xD9\x48\x89\x9D\x00\x00\x00\x00\x80\x3A\x02\x75\x33", "xxxxxx????xxxxx", -0x3D),

                new ByteSequence_FunctionObject("readAnimationData", @"\xE8\x00\x00\x00\x00\x48\x8D\x57\x04\x48\x8B\xCB\xE8\x00\x00\x00\x00\x80\x3B\x02", "x????xxxxxxxx????xxx", -0x21),
                new ByteSequence_FunctionObject("readPAAHashStuff", @"\x80\x3A\x02\x75\x1B\x48\x8B\x52\x48\x4C\x8D\x42\x04\x8B\x46\x40", "xxxxxxxxxxxxxxxx", -0x3B),
                new ByteSequence_FunctionObject("readBoneInfo", @"\xE8\x00\x00\x00\x00\x48\x8D\x55\x04\x48\x8B\xCB\xE8\x00\x00\x00\x00\x33\xFF\x80\x3B\x02", "x????xxxxxxxx????xxxxx", -0x1E),
                new ByteSequence_FunctionObject("readSubMeshInfo", @"\x75\x28\x48\x8B\x4A\x48\x8B\x47\x40\x48\x8D\x51\x08", "xxxxxxxxxxxxx", -0x1D),
                new ByteSequence_FunctionObject("readEffectSwitch", @"\xE8\x00\x00\x00\x00\x48\x8D\x56\x04\x48\x8B\xCB\xE8\x00\x00\x00\x00\x48\x8D\x56\x10\x48\x8B\xCB", "x????xxxxxxxx????xxxxxxx", -0x2A),
                new ByteSequence_FunctionObject("readHitPartInfo", @"\x4C\x89\x6C\x24\x00\x80\x3A\x02\x48\x8B\xDA\x48\x8B\xF1", "xxxx?xxxxxxxxx", -0x11),
                new ByteSequence_FunctionObject("readActionBranch", @"\x48\x39\x6F\x08\x75\x2F\x48\x8D\x15\x00\x00\x00\x00", "xxxxxxxxx????", -0x4B),
                new ByteSequence_FunctionObject("readFrameHeader", @"\x48\x8B\xDA\x48\x8B\xF9\x80\x3A\x02\x75\x44", "xxxxxxxxxxx", -0x24),
                new ByteSequence_FunctionObject("readActionPackage", @"\x0F\xB6\x0A\x80\xF9\x02\x75\x45", "xxxxxxxx", -0x39),
                new ByteSequence_FunctionObject("readAiFunctions", @"\x8B\x05\x00\x00\x00\x00\x83\xF8\xFF\x75\x1F", "xx????xxxxx", -0x5A),
                new ByteSequence_FunctionObject("readActionChartFuncT", @"\x33\xF6\x80\x3A\x02\x75\x27", "xxxxxxx", -0x2B),
                new ByteSequence_FunctionObject("readActionPackageT", @"\x80\x3A\x02\x75\x28\x48\x8B\x4A\x48", "xxxxxxxxx", -0x31),
                new ByteSequence_FunctionObject("readActionChart", @"\xE8\x00\x00\x00\x00\x48\x8D\x55\x04\x48\x8B\xCF\xE8\x00\x00\x00\x00\x48\x8D\x55\x08\x48\x8B\xCF", "x????xxxxxxxx????xxxxxxx", -0x28),
                new ByteSequence_FunctionObject("readActionChart_0", @"\xE8\x00\x00\x00\x00\x80\x3F\x02\x75\x1F", "x????xxxxx", -0x33),

                new ByteSequence_FunctionObject("getFrameEventBase", @"\xE8\x00\x00\x00\x00\x80\x78\x01\x00\x74\x0D", "x????xxxxxx", -0x19),
                new ByteSequence_FunctionObject("getFrameEventBase1", @"\x48\x83\xEC\x30\x48\xC7\x45\x00\x00\x00\x00\x00\x0F\xB6\xC1\x3D\x00\x00\x00\x00", "xxxxxxx?????xxxx????", -0x5),

                new ByteSequence_FunctionObject("createActionScript", @"\x48\x89\x5C\x24\x00\x48\x8B\xF1\x48\x89\x4C\x24\x00\xE8\x00\x00\x00\x00\x90", "xxxx?xxxxxxx?x????x", -0x15),

                new ByteSequence_FunctionObject("readFrameEventBase", @"\xE8\x00\x00\x00\x00\x48\x8D\x57\x18\x48\x8B\xCD\xE8\x00\x00\x00\x00", "x????xxxxxxxx????", -0x2B),
            };

            for (int i = 0; i < g_ModuleData.Length; i++)
            {
                byte startValue = g_ModuleData[i];

                foreach (var fObject in m_FunctionObjects)
                {
                    if (fObject.m_PatternBytes[0] == startValue)
                    {
                        bool found = true;

                        for (int pI = 1; pI < fObject.m_PatternBytes.Length; pI++)
                        {
                            if (i + pI >= g_ModuleData.Length)
                            {
                                found = false;
                                break;
                            }

                            byte currentValue = g_ModuleData[i + pI];

                            if (fObject.m_Mask[pI] && currentValue != fObject.m_PatternBytes[pI])
                            {
                                found = false;
                                break;
                            }
                        }

                        if (found)
                        {
                            fObject.m_Results.Add(i + (fObject.m_Offset) + g_ModuleBase + g_DataOffset);
                        }
                    }
                }
            }

            List<string> a_Output = new List<string>();

            foreach (var fObject in m_FunctionObjects)
            {
                if (fObject.m_Results.Count == 0)
                {
                    a_Output.Add(fObject.m_Name + " = 0x0");
                }
                else
                {
                    string results = "";

                    foreach (var result in fObject.m_Results)
                    {
                        results += "0x" + result.ToString("X") + ", ";
                    }

                    a_Output.Add(fObject.m_Name + " = " + results);
                }
            }

            File.WriteAllLines(@"./Addresses.txt", a_Output);
        }
        
        static void Parse_ActionCharts()
        {
            var files = Directory.GetFiles(g_Path_ActionCharts, "*.paac", SearchOption.AllDirectories);

            foreach (var file in files)
            {
                string rawFileName = Path.GetFileNameWithoutExtension(file).ToLower();

                if (rawFileName == "pc_actionchartpackagepcraw")
                {
                    g_ActionChartPackage = new ActionChartPackagePCRaw(file);
                    g_ActionChartPackage.Parse();

                    g_ActionChartPackage.m_PackageMaps = g_ActionChartPackage.m_PackageMaps.OrderBy(x => x.Key).ToDictionary(x => x.Key, y => y.Value);
                    g_ActionChartPackage.m_ActionBranches = g_ActionChartPackage.m_ActionBranches.OrderBy(x => x.Key).ToDictionary(x => x.Key, y => y.Value);
                }
                else 
                {
                    ActionScript aScript = new ActionScript(file);

                    try
                    {
                        Console.WriteLine("Parsing ActionScript (" + rawFileName + ")");

                        aScript.Parse();

                        g_ActionScripts.Add(aScript.m_FilePath, aScript);
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine("Failed to Parse ActionScript (" + rawFileName + ")");
                    }
                }
            }

            Console.WriteLine("Parsing Done\n\nActionScripts Parsed: " + g_ActionScripts.Count + "\nActionScripts Failed: " + (files.Length - g_ActionScripts.Count));
            Console.WriteLine("\nActionChartPackage Parsed!\n\nBranches: " + g_ActionChartPackage.m_ActionBranches.Count + "\nFrameEvents: " + g_ActionChartPackage.m_FrameEvents.Count + "\nPackageMaps: " + g_ActionChartPackage.m_PackageMaps.Count);
        }

        static void LinkAndWrite_BinaryActionChart()
        {
            using (var fs = new FileStream(@".\binaryactionchart.bin", FileMode.Create))
            {
                using (var bw = new BinaryWriter(fs))
                {
                    bw.Write(g_ActionScripts.Count);

                    foreach (var actionScript in g_ActionScripts)
                    {
                        string relPath = FileUtils.GetRelativePath(actionScript.Key, g_Path_ActionCharts).Replace("\\", "/").Replace(".paac", "");
                        
                        Console.WriteLine("Linking " + relPath);

                        bw.WriteFixedWString(relPath);
                        bw.Write((short) 0);

                        bw.Write(actionScript.Value.m_ActionChartPackages.Count);

                        foreach (var actionPackage in actionScript.Value.m_ActionChartPackages)
                        {
                            bw.WriteFixedWString(actionPackage.m_PackageName);
                            bw.Write((short)0);

                            bw.Write(actionPackage.m_AiFunctions.Count);

                            foreach (var aiFunction in actionPackage.m_AiFunctions)
                            {
                                bw.Write(aiFunction.m_FunctionHash);
                                bw.Write(aiFunction.m_AiConstants.Count);

                                foreach (var aiConstant in aiFunction.m_AiConstants)
                                {
                                    bw.WriteFixedWString(aiConstant.m_Action);
                                    bw.Write((short)0);

                                    bw.Write(aiConstant.m_Value1);
                                }
                            }

                            bw.Write(actionPackage.m_ActionPackagesT.Count);

                            foreach (var actionT in actionPackage.m_ActionPackagesT)
                            {
                                ActionChart chart = actionT.m_ActionChart;

                                if (actionScript.Value.m_IsPcActionScript)
                                {
                                    uint pcPackageHash = BitConverter.ToUInt32(actionT.m_Data1, 12);      //hash seems wrong cause it doesnt fit to any PackageMap Hash in g_ActionChartPackage.m_PackageMaps

                                    if (g_ActionChartPackage.m_PackageMaps.ContainsKey(pcPackageHash))
                                    {
                                        var pMap = g_ActionChartPackage.m_PackageMaps[pcPackageHash];
                                        chart = pMap.m_ActionCharts[actionT.m_ChartHash];
                                    }
                                }
                                else
                                {
                                    chart = actionT.m_ActionChart;
                                }

                                Animation anim = actionScript.Value.m_Animations.FirstOrDefault(x => x.Key == chart.m_TextValues[1]).Value;

                                float animationTime;

                                if (anim != null)
                                {
                                    animationTime = LoadAnimationTime(anim.m_AnimationFileName);
                                }
                                else
                                {
                                    animationTime = (float)(BitConverter.ToSingle(actionT.m_Data1, 8) / 33.333332);
                                }
                                
                                bw.Write((int)chart.m_ActionChartData.m_TargetTypes);
                                bw.Write((int)actionT.m_ChartHash);
                                bw.WriteFixedWString(chart.m_TextValues[0]);
                                bw.Write((short)0);
                                bw.Write((byte)chart.m_ActionChartData.m_ActionType);
                                bw.Write((byte)chart.m_ActionChartData.m_BattleAimedActionType);
                                bw.Write((byte)chart.m_ActionChartData.m_ApplySpeedbuffType);
                                bw.Write((float)0.0f);
                                bw.Write((float)chart.m_ActionChartData.m_MoveSpeed);
                                bw.Write((float)chart.m_ActionChartData.m_MoveSpeed);
                                bw.Write((float)chart.m_ActionChartData.m_StartFrame);
                                bw.Write((float)chart.m_ActionChartData.m_EndFrame);
                                bw.Write((float)chart.m_ActionChartData.m_AnimationSpeed);
                                bw.Write((float)animationTime);
                                bw.Write((short)chart.m_ActionChartData.m_CombineWavePoint);
                                bw.Write((short)chart.m_ActionChartData.m_NeedCombineWavePoint);
                                bw.Write((ushort)0);
                                bw.Write((ushort)0);
                                bw.Write((ushort)0);
                                bw.Write((short)chart.m_ActionChartData.m_AddDvForMonster);
                                bw.Write((short)chart.m_ActionChartData.m_AddPvForMonster);
                                bw.Write((short)chart.m_ActionChartData.m_VaryWp);
                                bw.Write((int)chart.m_ActionChartData.m_VarySRP);
                                bw.Write((short)chart.m_ActionChartData.m_ApplySp);
                                bw.Write((float)chart.m_ActionChartData.m_StaminaSpeed);
                                bw.Write((byte)chart.m_ActionChartData.m_AddDv);
                                bw.Write((byte)chart.m_ActionChartData.m_AddPv);
                                bw.Write((short)chart.m_ActionChartData.m_AttackAbsorbAmount1);
                                bw.Write((short)chart.m_ActionChartData.m_AttackAbsorbAmount2);
                                bw.Write((byte)chart.m_ActionChartData.m_AttackAbsorbType1);
                                bw.Write((byte)chart.m_ActionChartData.m_AttackAbsorbType2);
                                bw.Write((byte)chart.m_ActionChartData.m_SpUseType);
                                bw.Write((byte)chart.m_ActionChartData.m_GuardType);
                                bw.Write((short)chart.m_ActionChartData.m_SkillId);
                                bw.Write((byte)chart.m_ActionChartData.m_VehicleSkillKey);
                                bw.Write((int)chart.m_ActionChartData.m_NavigationTypes);
                                bw.Write((byte)chart.m_ActionChartData.m_MoveDirectionType);
                                bw.Write((byte)chart.m_ActionChartData.m_AttachTerrainType);
                                bw.Write((short)chart.m_ActionChartData.m_IndexedActionCount);
                                bw.Write((byte)chart.m_ActionChartData.m_BitData1);
                                bw.Write((byte)chart.m_ActionChartData.m_BitData2);
                                bw.Write((byte)chart.m_ActionChartData.m_BitData3);
                                bw.Write((byte)chart.m_ActionChartData.m_BitData4);
                                bw.Write((byte)chart.m_ActionChartData.m_BitData5);
                                bw.Write((byte)chart.m_ActionChartData.m_BitData6);
                                bw.Write((byte)chart.m_ActionChartData.m_BitData7);

                                bw.Write(actionT.m_BranchIdx.Count);

                                foreach (var idx in actionT.m_BranchIdx)
                                {
                                    ActionBranch branch;

                                    if (actionScript.Value.m_IsPcActionScript)
                                        branch = g_ActionChartPackage.m_ActionBranches[idx];
                                    else
                                    {
                                        branch = actionScript.Value.m_ActionBranches[idx];
                                    }
                                    
                                    bw.WriteFixedWString(branch.m_FrameHeaders[0].m_UnkData0); //Conditions are encrypted somehow
                                    bw.Write((short)0);
                                    bw.Write(BitConverter.ToSingle(branch.m_UnkData, 4));       //might be wrong
                                    bw.WriteFixedWString(branch.m_Execute);                     //might be wrong somehow
                                    bw.Write((short)0);
                                    bw.WriteFixedWString(branch.m_ActionFileName);              
                                    bw.Write((short)0);
                                }

                                int realCount = 0;
                                long curPos = bw.BaseStream.Position;

                                bw.Write((int)0);

                                foreach (var frameLink in actionT.m_FrameLinks)
                                {
                                    FrameEventBase frame;

                                    if (actionScript.Value.m_IsPcActionScript)
                                        frame = g_ActionChartPackage.m_FrameEvents[frameLink];
                                    else
                                    {
                                        frame = actionScript.Value.m_FrameEvents[frameLink];
                                    }

                                    if (g_AllowedFrameTypes.ContainsKey((int) frame.m_FrameEventType))
                                    {
                                        bw.Write((sbyte)frame.m_FrameEventType);

                                        frame.Write(bw);        //FrameEvent write methods might yield incorrect struct offsets, updated everything manually but i am not sure and i cant test

                                        realCount++;
                                    }
                                }

                                long savedPos = bw.BaseStream.Position;
                                bw.BaseStream.Position = curPos;
                                bw.Write(realCount);
                                bw.BaseStream.Position = savedPos;
                            }
                        }
                    }
                }
            }

            Console.WriteLine("binaryactionchart.bin generated!");
        }
        
        private static float LoadAnimationTime(string animationFilePath)
        {
            float ret = 0.0f;

            string finalPath = g_Path_Motions + @"\" + animationFilePath;

            if (!File.Exists(finalPath))
                return ret;

            using (var fs = new FileStream(finalPath, FileMode.Open))
            {
                using (var br = new BinaryReader(fs))
                {
                    br.BaseStream.Position += 18;

                    ret = br.ReadSingle();
                }
            }

            return ret;
        }
    }
}

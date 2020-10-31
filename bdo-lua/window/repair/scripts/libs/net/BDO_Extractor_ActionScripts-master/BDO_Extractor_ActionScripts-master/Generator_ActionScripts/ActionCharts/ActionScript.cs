using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.ActionCharts.FrameEvents;
using Generator_ActionScripts.Enums;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts
{
    public class ActionScript
    {
        public string m_FilePath { get; private set; }

        private int m_BinaryActionsVersion { get; set; }
        public bool m_IsPcActionScript { get; set; }

        private long m_AnimationCount { get; set; }
        public Dictionary<string, Animation> m_Animations { get; set; }

        private long m_BoneInfoCount { get; set; }
        public List<BoneInfo> m_BoneInfos { get; set; }

        private long m_PhysicsCount { get; set; }
        public List<Physics> m_Physics { get; set; }

        private long m_MeshInfoCount { get; set; }
        public List<MeshInfo> m_MeshInfos { get; set; }

        private long m_EffectSwitchCount { get; set; }
        public List<EffectSwitch> m_EffectSwitches { get; set; }

        public string m_ScriptName { get; set; }
        
        public List<VehicleRidingInfo> m_VehicleRidingInfos { get; set; }

        public bool m_HasHitPartInfo { get; set; }
        public HitPartInfo m_HitPartInfo { get; set; }

        private long m_ActionBranchCount { get; set; }
        public Dictionary<int, ActionBranch> m_ActionBranches { get; set; }

        private int m_FrameEventsCount { get; set; }
        public List<FrameEventBase> m_FrameEvents { get; set; }

        private long m_ActionChartPackageCount { get; set; }
        public List<ActionPackage> m_ActionChartPackages { get; set; }

        private List<string> m_StringTable { get; set; }

        public ActionScript(string filePath)
        {
            m_FilePath = filePath;

            m_Animations = new Dictionary<string, Animation>();
            m_BoneInfos = new List<BoneInfo>();
            m_Physics = new List<Physics>();
            m_MeshInfos = new List<MeshInfo>();
            m_EffectSwitches = new List<EffectSwitch>();
            m_VehicleRidingInfos = new List<VehicleRidingInfo>();
            m_ActionBranches = new Dictionary<int, ActionBranch>();
            m_FrameEvents = new List<FrameEventBase>();
            m_ActionChartPackages = new List<ActionPackage>();
        }

        public void Parse()
        {
            using (var fs = new FileStream(m_FilePath, FileMode.Open))
            {
                using (var br = new BinaryReader(fs))
                {
                    br.BaseStream.Position = br.BaseStream.Length - 8;
                    long stringTableStart = br.ReadInt64();
                    br.BaseStream.Position = stringTableStart;

                    m_StringTable = br.ReadStringTable();
                    br.BaseStream.Position = 0;

                    br.ReadInt32(); //skip fileType

                    m_BinaryActionsVersion = br.ReadInt32();
                    m_IsPcActionScript = br.ReadBoolean();

                    m_AnimationCount = br.ReadInt64();

                    for (int iAC = 0; iAC < m_AnimationCount; iAC++)
                    {
                        Animation nAnim = new Animation(br, m_StringTable);

                        nAnim.Parse();
                        
                        m_Animations.Add(nAnim.m_AnimationName, nAnim);
                    }

                    int rowCount = br.ReadInt32();

                    for (int iH1 = 0; iH1 < rowCount; iH1++)
                    {

                        br.ReadInt32(); //readString index first and convert afterwards if needed

                        br.ReadInt32(); //rowHash
                    }

                    rowCount = br.ReadInt32();

                    for (int iH2 = 0; iH2 < rowCount; iH2++)
                    {
                        br.ReadInt32(); //readString index first and convert afterwards if needed

                        br.ReadInt32(); //rowHash
                    }

                    rowCount = br.ReadInt32();

                    for (int iH3 = 0; iH3 < rowCount; iH3++)
                    {
                        br.ReadInt32(); //rowHash

                        int dataCount = br.ReadInt32();

                        for (int iD1 = 0; iD1 < dataCount; iD1++)
                        {
                            int stringIndex_Name = br.ReadInt32();
                            ;
                            int stringIndex_PaaFileName = br.ReadInt32();
                            short switchA = br.ReadInt16();
                            short switchB = br.ReadInt16();
                        }

                        dataCount = br.ReadInt32();

                        for (int iD2 = 0; iD2 < dataCount; iD2++)
                        {
                            int unk1 = br.ReadInt32();
                            int unk2 = br.ReadInt32();
                        }
                    }

                    m_BoneInfoCount = br.ReadInt64();

                    for (int iBI = 0; iBI < m_BoneInfoCount; iBI++)
                    {
                        BoneInfo nBoneInfo = new BoneInfo(br, m_StringTable);

                        nBoneInfo.Parse();
                        
                        m_BoneInfos.Add(nBoneInfo);
                    }

                    m_PhysicsCount = br.ReadInt64();
                    
                    for (int iP = 0; iP < m_PhysicsCount; iP++)
                    {
                        Physics nPhysics = new Physics(br, m_StringTable);

                        nPhysics.Parse();
                        
                        m_Physics.Add(nPhysics);
                    }

                    m_MeshInfoCount = br.ReadInt64();

                    for (int iMI = 0; iMI < m_MeshInfoCount; iMI++)
                    {
                        MeshInfo nMeshInfo = new MeshInfo(br, m_StringTable);

                        nMeshInfo.Parse();
                        
                        m_MeshInfos.Add(nMeshInfo);
                    }

                    m_EffectSwitchCount = br.ReadInt64();

                    for (int iES = 0; iES < m_EffectSwitchCount; iES++)
                    {
                        EffectSwitch nEffectSwitch = new EffectSwitch(br, m_StringTable);

                        nEffectSwitch.Parse();
                        
                        m_EffectSwitches.Add(nEffectSwitch);
                    }

                    long unkCount = br.ReadInt64();

                    for (int i = 0; i < unkCount; i++)
                    {
                        int unk1 = br.ReadInt32();

                        if (unk1 != -1)
                        {
                            br.ReadInt32(); //someString index

                            br.ReadInt32();
                            br.ReadInt32();
                            br.ReadInt32();
                            br.ReadInt32();
                            br.ReadByte();
                            br.ReadByte();
                        }
                    }

                    unkCount = br.ReadInt64();
                    br.BaseStream.Position += unkCount * 20;

                    m_ScriptName = GetString(br.ReadInt32());

                    br.ReadInt32();
                    br.ReadInt32();

                    for (int iVI = 0; iVI < 32; iVI++)
                    {
                        VehicleRidingInfo nVehicleRidingInfo = new VehicleRidingInfo(br);

                        nVehicleRidingInfo.Parse();
                        
                        m_VehicleRidingInfos.Add(nVehicleRidingInfo);
                    }

                    m_HasHitPartInfo = br.ReadBoolean();

                    if (m_HasHitPartInfo)
                    {
                        m_HitPartInfo = new HitPartInfo(br, m_StringTable);

                        m_HitPartInfo.Parse();
                        
                    }

                    m_ActionBranchCount = br.ReadInt64();

                    for (int iAB = 0; iAB < m_ActionBranchCount; iAB++)
                    {
                        ActionBranch nActionBranch = new ActionBranch(br, m_StringTable);

                        nActionBranch.Parse();

                        m_ActionBranches.Add(BitConverter.ToInt32(nActionBranch.m_UnkData, 8), nActionBranch);
                    }

                    m_FrameEventsCount = br.ReadInt32();

                    for (int iFE = 0; iFE < m_FrameEventsCount; iFE++)
                    {
                        eActionChart_FrameEvent type = (eActionChart_FrameEvent) br.ReadByte();
                        
                        FrameEventBase frameEvent = FrameEvent_Utils.GetFrameEventBase(br, type, m_StringTable);

                        frameEvent.Parse();
                        
                        m_FrameEvents.Add(frameEvent);
                    }

                    foreach (var frameEvent in m_FrameEvents)
                    {
                        frameEvent.InsertStrings(m_StringTable);
                    }

                    m_ActionChartPackageCount = br.ReadInt64();

                    for (int iACP = 0; iACP < m_ActionChartPackageCount; iACP++)
                    {
                        ActionPackage nActionPackage = new ActionPackage(br, m_IsPcActionScript, m_StringTable);

                        nActionPackage.Parse();
                        
                        m_ActionChartPackages.Add(nActionPackage);
                    }
                    
                    int endBinary = br.ReadInt32();

                    if (m_BinaryActionsVersion != endBinary)
                    {
                        ;
                    }

                    
                }
            }
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.ActionCharts.FrameEvents;
using Generator_ActionScripts.Enums;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts
{
    public class ActionChartPackagePCRaw
    {
        public string m_FilePath { get; set; }

        private int m_BinaryActionsVersion { get; set; }

        private List<string> m_StringTable { get; set; }

        private long m_ActionBranchCount { get; set; }
        public Dictionary<int, ActionBranch> m_ActionBranches { get; set; }

        private int m_FrameEventsCount { get; set; }
        public List<FrameEventBase> m_FrameEvents { get; set; }

        private long m_PackageMapCount { get; set; }
        public Dictionary<uint, PackageMap> m_PackageMaps { get; set; }

        public ActionChartPackagePCRaw(string filePath)
        {
            m_FilePath = filePath;

            m_ActionBranches = new Dictionary<int, ActionBranch>();
            m_FrameEvents = new List<FrameEventBase>();
            m_PackageMaps = new Dictionary<uint, PackageMap>();
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

                    m_ActionBranchCount = br.ReadInt64();

                    for (int i = 0; i < m_ActionBranchCount; i++)
                    {
                        ActionBranch nActionBranch = new ActionBranch(br, m_StringTable);
                        nActionBranch.Parse();

                        m_ActionBranches.Add(BitConverter.ToInt32(nActionBranch.m_UnkData, 8), nActionBranch);
                    }

                    m_FrameEventsCount = br.ReadInt32();

                    for (int iFE = 0; iFE < m_FrameEventsCount; iFE++)
                    {
                        eActionChart_FrameEvent type = (eActionChart_FrameEvent)br.ReadByte();

                        FrameEventBase frameEvent = FrameEvent_Utils.GetFrameEventBase(br, type, m_StringTable);
                        
                        frameEvent.Parse();

                        m_FrameEvents.Add(frameEvent);
                    }

                    foreach (var frameEvent in m_FrameEvents)
                    {
                        frameEvent.InsertStrings(m_StringTable);
                    }

                    m_PackageMapCount = br.ReadInt64();

                    for (int i = 0; i < m_PackageMapCount; i++)
                    {
                        PackageMap nPackageMap = new PackageMap(br, m_StringTable);
                        nPackageMap.Parse();

                        m_PackageMaps.Add(nPackageMap.m_PackageHash, nPackageMap);
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

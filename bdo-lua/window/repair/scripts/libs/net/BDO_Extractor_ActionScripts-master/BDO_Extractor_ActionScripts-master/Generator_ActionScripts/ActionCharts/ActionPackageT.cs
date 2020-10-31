using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts
{
    public class ActionPackageT
    {
        private BinaryReader bReader { get; set; }
        private bool m_IsPcActionScript { get; set; }
        private List<string> m_StringTable { get; set; }

        public int m_ChartHash { get; set; }

        private long m_Count { get; set; }
        public List<int> m_BranchIdx { get; set; }
        public List<int> m_FrameLinks { get; set; }

        public byte[] m_Data0 { get; set; }
        public byte[] m_Data1 { get; set; }
        public int m_Value0 { get; set; }
        public int m_Value1 { get; set; }

        public ActionChart m_ActionChart { get; set; }

        public ActionPackageT(BinaryReader br, bool isPcActionScript, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;
            m_IsPcActionScript = isPcActionScript;

            m_BranchIdx = new List<int>();
            m_FrameLinks = new List<int>();
        }

        public void Parse()
        {
            m_ChartHash = bReader.ReadInt32();

            m_Count = bReader.ReadInt64();

            for(int i = 0; i < m_Count; i++)
                m_BranchIdx.Add(bReader.ReadInt32());

            m_Count = bReader.ReadInt64();

            for (int i = 0; i < m_Count; i++)
                m_FrameLinks.Add(bReader.ReadInt32());

            m_Count = bReader.ReadInt64();

            for (int i = 0; i < m_Count; i++)
                bReader.ReadInt16();

            m_Count = bReader.ReadInt64();

            for (int i = 0; i < m_Count; i++)
            {
                bReader.ReadInt16();
                bReader.ReadInt16();
            }

            m_Count = bReader.ReadInt64();

            for (int i = 0; i < m_Count; i++)
            {
                bReader.ReadInt16();
                bReader.ReadInt16();
            }

            m_Count = bReader.ReadInt64();

            for (int i = 0; i < m_Count; i++)
            {
                bReader.ReadInt32();
                bReader.ReadInt16();
                bReader.ReadInt16();
                bReader.ReadInt32();
                bReader.ReadInt32();
                bReader.ReadInt16();
                bReader.ReadInt16();
                bReader.ReadInt16();
            }

            m_Value0 = bReader.ReadInt32();
            m_Value1 = bReader.ReadInt32();

            m_Data0 = bReader.ReadFixedArray();

            bReader.ReadInt16();

            m_Data1 = bReader.ReadFixedArray();

            if (m_IsPcActionScript)
            {
                m_ActionChart = new ActionChart(bReader, m_StringTable);

                m_ActionChart.Parse();
            }
        }
    }
}

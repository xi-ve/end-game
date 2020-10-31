using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_MeshOn : FrameEventBase
    {
        public byte m_MeshNamesCount { get; set; }
        public List<string> m_MeshNames { get; set; }
        public float m_FadeTime { get; set; }
        public byte m_Value0 { get; set; }

        private List<int> m_Indexies_MeshNames { get; set; }

        public FrameEvent_MeshOn(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {
            m_MeshNames = new List<string>();
            m_Indexies_MeshNames = new List<int>();
        }

        public override void Parse()
        {
            base.Parse();

            m_MeshNamesCount = bReader.ReadByte();

            for (int i = 0; i < m_MeshNamesCount; i++)
            {
                m_Indexies_MeshNames.Add(bReader.ReadInt32());
            }

            m_FadeTime = bReader.ReadSingle();
            m_Value0 = bReader.ReadByte();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);

            foreach (var iMN in m_Indexies_MeshNames)
            {
                m_MeshNames.Add(stringTable[iMN]);
            }
        }
    }
}

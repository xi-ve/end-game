using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_EffectSwitch : FrameEventBase
    {
        public byte m_EffectSwitchNamesCount { get; set; }
        public List<string> m_EffectSwitchNames { get; set; }
        public byte m_UnkValue0 { get; set; }
        public byte m_UnkValue1 { get; set; }

        private List<int> m_Indexies_EffectSwitchNames { get; set; }

        public FrameEvent_EffectSwitch(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {
            m_EffectSwitchNames = new List<string>();
            m_Indexies_EffectSwitchNames = new List<int>();
        }

        public override void Parse()
        {
            base.Parse();

            m_EffectSwitchNamesCount = bReader.ReadByte();

            for (int i = 0; i < m_EffectSwitchNamesCount; i++)
            {
                m_Indexies_EffectSwitchNames.Add(bReader.ReadInt32());
            }

            m_UnkValue0 = bReader.ReadByte();
            m_UnkValue1 = bReader.ReadByte();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);

            foreach (var iName in m_Indexies_EffectSwitchNames)
            {
                m_EffectSwitchNames.Add(stringTable[iName]);
            }
        }
    }
}

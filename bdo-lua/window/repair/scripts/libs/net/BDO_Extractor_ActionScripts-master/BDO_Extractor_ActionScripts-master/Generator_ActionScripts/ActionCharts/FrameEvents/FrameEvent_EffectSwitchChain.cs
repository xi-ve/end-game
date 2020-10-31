using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_EffectSwitchChain : FrameEvent_EffectSwitch
    {
        public string m_Text0 { get; set; }
        public string m_Text1 { get; set; }
        public string m_Text2 { get; set; }
        public byte[] m_Data0 { get; set; }
        public byte m_Value0 { get; set; }

        private int m_Index_Text0 { get; set; }
        private int m_Index_Text1 { get; set; }
        private int m_Index_Text2 { get; set; }

        public FrameEvent_EffectSwitchChain(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Index_Text0 = bReader.ReadInt32();
            m_Index_Text1 = bReader.ReadInt32();
            m_Index_Text2 = bReader.ReadInt32();

            long unkDataCount = bReader.ReadInt64();
            List<byte> unkData = new List<byte>();
            for (int iUD = 0; iUD < unkDataCount; iUD++)
            {
                unkData.Add(bReader.ReadByte());
            }

            m_Data0 = unkData.ToArray();

            m_Value0 = bReader.ReadByte();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);

            m_Text0 = stringTable[m_Index_Text0];
            m_Text1 = stringTable[m_Index_Text1];
            m_Text2 = stringTable[m_Index_Text2];
        }
    }
}

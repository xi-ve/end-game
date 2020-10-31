using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_AttackArrow : FrameEvent_Attack
    {
        public string m_Text0 { get; set; }
        public string m_Text1 { get; set; }
        public string m_Text2 { get; set; }
        public string m_Text3 { get; set; }
        public string m_Text4 { get; set; }
        public string m_Text5 { get; set; }
        public string m_Text6 { get; set; }
        public byte[] m_AttackArrowData0 { get; set; }

        private int m_Index_Text0 { get; set; }
        private int m_Index_Text1 { get; set; }
        private int m_Index_Text2 { get; set; }
        private int m_Index_Text3 { get; set; }
        private int m_Index_Text4 { get; set; }
        private int m_Index_Text5 { get; set; }
        private int m_Index_Text6 { get; set; }

        public FrameEvent_AttackArrow(BinaryReader br, eActionChart_FrameEvent frameEventType) : base(br,
            frameEventType)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Index_Text0 = bReader.ReadInt32();
            m_Index_Text1 = bReader.ReadInt32();
            m_Index_Text2 = bReader.ReadInt32();
            m_Index_Text3 = bReader.ReadInt32();
            m_Index_Text4 = bReader.ReadInt32();
            m_Index_Text5 = bReader.ReadInt32();
            m_Index_Text6 = bReader.ReadInt32();

            long unkDataCount = bReader.ReadInt64();
            List<byte> unkData = new List<byte>();
            for (int iUD = 0; iUD < unkDataCount; iUD++)
            {
                unkData.Add(bReader.ReadByte());
            }

            m_AttackArrowData0 = unkData.ToArray();
        }

        public override void Write(BinaryWriter bw)
        {
            base.Write(bw);
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);

            m_Text0 = stringTable[m_Index_Text0];
            m_Text1 = stringTable[m_Index_Text1];
            m_Text2 = stringTable[m_Index_Text2];
            m_Text3 = stringTable[m_Index_Text3];
            m_Text4 = stringTable[m_Index_Text4];
            m_Text5 = stringTable[m_Index_Text5];
            m_Text6 = stringTable[m_Index_Text6];
        }
    }
}

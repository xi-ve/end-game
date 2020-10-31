using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_Glitter : FrameEventBase
    {
        public float m_Value0 { get; set; }
        public float m_Value1 { get; set; }
        public float m_Value2 { get; set; }
        public string m_Text0 { get; set; }
        public byte m_Value3 { get; set; }

        private int m_Index_Text0 { get; set; }

        public FrameEvent_Glitter(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Value0 = bReader.ReadSingle();
            m_Value1 = bReader.ReadSingle();
            m_Value2 = bReader.ReadSingle();

            m_Index_Text0 = bReader.ReadInt32();

            m_Value3 = bReader.ReadByte();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);

            m_Text0 = stringTable[m_Index_Text0];
        }
    }
}

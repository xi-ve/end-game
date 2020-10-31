using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_AttackThrow : FrameEventBase
    {
        public short m_Value0 { get; set; }
        public short m_Value1 { get; set; }
        public short m_Value2 { get; set; }
        public short m_Value3 { get; set; }
        public short m_Value4 { get; set; }

        public FrameEvent_AttackThrow(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Value0 = bReader.ReadInt16();
            m_Value1 = bReader.ReadInt16();
            m_Value2 = bReader.ReadInt16();
            m_Value3 = bReader.ReadInt16();
            m_Value4 = bReader.ReadInt16();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);
        }
    }
}

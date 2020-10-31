using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_CallLuaEvent : FrameEventBase
    {
        public int m_EventNo { get; set; }
        public byte m_SelfPlayerOnly { get; set; }
        public byte m_Value0 { get; set; }

        public FrameEvent_CallLuaEvent(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_EventNo = bReader.ReadInt32();
            m_SelfPlayerOnly = bReader.ReadByte();
            m_Value0 = bReader.ReadByte();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);
        }
    }
}

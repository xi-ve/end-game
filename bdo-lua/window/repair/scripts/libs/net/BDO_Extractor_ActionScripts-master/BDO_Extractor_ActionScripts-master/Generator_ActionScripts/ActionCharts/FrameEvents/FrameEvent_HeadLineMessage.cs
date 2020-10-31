using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_HeadLineMessage : FrameEventBase
    {
        public byte m_MessageNo { get; set; }
        public byte m_ShowEveryone { get; set; }

        public FrameEvent_HeadLineMessage(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_MessageNo = bReader.ReadByte();
            m_ShowEveryone = bReader.ReadByte();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);
        }
    }
}

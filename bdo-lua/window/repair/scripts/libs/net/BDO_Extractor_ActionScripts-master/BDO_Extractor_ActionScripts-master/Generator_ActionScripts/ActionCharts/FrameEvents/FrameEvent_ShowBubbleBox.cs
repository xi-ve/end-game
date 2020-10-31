using Generator_ActionScripts.Enums;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_ShowBubbleBox :FrameEventBase
    {
        public string m_Text0 { get; set; }

        private int m_Index_Text0 { get; set; }

        public FrameEvent_ShowBubbleBox(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Index_Text0 = bReader.ReadInt32();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);

            m_Text0 = stringTable[m_Index_Text0];
        }
    }
}

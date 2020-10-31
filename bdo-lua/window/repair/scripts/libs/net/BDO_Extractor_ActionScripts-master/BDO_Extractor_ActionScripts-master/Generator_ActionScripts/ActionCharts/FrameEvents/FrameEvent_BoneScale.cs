using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_BoneScale : FrameEventBase
    {
        public string m_Text0 { get; set; }
        public byte[] m_Data0 { get; set; }

        private int m_Index_Text0 { get; set; }

        public FrameEvent_BoneScale(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Index_Text0 = bReader.ReadInt32();

            m_Data0 = bReader.ReadFixedArray();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);

            m_Text0 = stringTable[m_Index_Text0];
        }
    }
}

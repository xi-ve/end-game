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
    public class FrameEvent_SetCameraPos : FrameEventBase
    {
        public byte[] m_Data0 { get; set; }
        public byte m_Value0 { get; set; }

        public FrameEvent_SetCameraPos(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Data0 = bReader.ReadFixedArray();
            m_Value0 = bReader.ReadByte();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);
        }
    }
}

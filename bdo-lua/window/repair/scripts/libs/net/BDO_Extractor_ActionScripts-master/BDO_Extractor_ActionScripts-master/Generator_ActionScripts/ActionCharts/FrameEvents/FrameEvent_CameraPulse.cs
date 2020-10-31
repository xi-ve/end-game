using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_CameraPulse : FrameEventBase
    {
        public FrameEvent_CameraPulse(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            bReader.BaseStream.Position += 84;
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);
        }
    }
}

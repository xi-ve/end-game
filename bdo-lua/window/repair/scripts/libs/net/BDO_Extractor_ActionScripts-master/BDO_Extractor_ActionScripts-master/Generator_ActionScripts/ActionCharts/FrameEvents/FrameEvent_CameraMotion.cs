using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_CameraMotion : FrameEventBase
    {
        public float m_X { get; set; }
        public float m_Y { get; set; }
        public float m_Z { get; set; }

        public FrameEvent_CameraMotion(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_X = bReader.ReadSingle();
            m_Y = bReader.ReadSingle();
            m_Z = bReader.ReadSingle();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);
        }
    }
}

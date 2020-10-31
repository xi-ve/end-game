using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_AdditiveAnimation : FrameEventBase
    {
        public string m_AnimationName { get; set; }
        public float m_Value { get; set; }

        private int m_Index_AnimationName { get; set; }

        public FrameEvent_AdditiveAnimation(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Index_AnimationName = bReader.ReadInt32();
            m_Value = bReader.ReadSingle();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);

            m_AnimationName = stringTable[m_Index_AnimationName];
        }
    }
}

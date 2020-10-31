using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_EffectGround : FrameEvent_Effect
    {
        public string m_EffectGroundName { get; set; }
        public int m_UnkValue0 { get; set; }

        private int m_Index_EffectGroundName { get; set; }

        public FrameEvent_EffectGround(BinaryReader br, eActionChart_FrameEvent type, List<string> stringTable) : base(br, type, stringTable)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Index_EffectGroundName = bReader.ReadInt32();
            m_UnkValue0 = bReader.ReadInt32();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);

            m_EffectGroundName = stringTable[m_Index_EffectGroundName];
        }
    }
}

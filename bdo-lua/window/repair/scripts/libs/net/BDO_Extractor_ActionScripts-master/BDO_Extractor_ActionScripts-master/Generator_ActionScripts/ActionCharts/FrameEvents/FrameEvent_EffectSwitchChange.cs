using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_EffectSwitchChange : FrameEventBase
    {
        public string m_Text0 { get; set; }
        public string m_Text1 { get; set; }
        public byte m_Value0 { get; set; }
        public byte m_Value1 { get; set; }

        public int m_Index_Text0 { get; set; }
        public int m_Index_Text1 { get; set; }

        public FrameEvent_EffectSwitchChange(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Index_Text0 = bReader.ReadInt32();
            m_Index_Text1 = bReader.ReadInt32();

            m_Value0 = bReader.ReadByte();
            m_Value1 = bReader.ReadByte();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);

            m_Text0 = stringTable[m_Index_Text0];
            m_Text1 = stringTable[m_Index_Text1];
        }
    }
}

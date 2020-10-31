using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_Effect : FrameEventBase
    {
        private List<string> m_StringTable { get; set; }

        public EffectSwitch m_EffectSwitch { get; set; }
        
        public FrameEvent_Effect(BinaryReader br, eActionChart_FrameEvent type, List<string>  stringTable) : base(br, type)
        {
            m_StringTable = stringTable;
        }

        public override void Parse()
        {
            base.Parse();
            
            m_EffectSwitch = new EffectSwitch(bReader, m_StringTable);
            m_EffectSwitch.Parse(false);

        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);
        }
    }
}

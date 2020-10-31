using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_AttackCatch : FrameEvent_Attack
    {
        public string m_CatcherBone { get; set; }
        public string m_CatcheeBone { get; set; }

        private int m_Index_CatcherBone { get; set; }
        private int m_Index_CatcheeBone { get; set; }

        public FrameEvent_AttackCatch(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Index_CatcherBone = bReader.ReadInt32();
            m_Index_CatcheeBone = bReader.ReadInt32();
        }
        
        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);

            m_CatcherBone = stringTable[m_Index_CatcherBone];
            m_CatcheeBone = stringTable[m_Index_CatcheeBone];
        }
    }
}

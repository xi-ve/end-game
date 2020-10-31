using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_AttackArrowSimple : FrameEvent_AttackArrow
    {
        public long m_UnkValue0 { get; set; }
        public long m_Count0 { get; set; }

        public FrameEvent_AttackArrowSimple(BinaryReader br, eActionChart_FrameEvent frameEventType) : base(br,
            frameEventType)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_UnkValue0 = bReader.ReadInt64();

            m_Count0 = bReader.ReadInt64();

            for (int i = 0; i < m_Count0; i++)
            {
                long unk0 = bReader.ReadInt64();

                if (unk0 != 0)
                {
                    bReader.BaseStream.Position += 4 * unk0;
                }
            }
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);
        }
    }
}

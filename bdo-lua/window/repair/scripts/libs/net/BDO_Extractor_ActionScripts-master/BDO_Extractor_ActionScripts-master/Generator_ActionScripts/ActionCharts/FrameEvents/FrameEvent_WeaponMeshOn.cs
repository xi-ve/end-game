using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_WeaponMeshOn : FrameEventBase
    {
        public byte m_Value0 { get; set; }

        public FrameEvent_WeaponMeshOn(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Value0 = bReader.ReadByte();

            bReader.BaseStream.Position += m_Value0;

            bReader.ReadByte();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);
        }
    }
}

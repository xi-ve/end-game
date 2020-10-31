using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_ModelAnimation : FrameEventBase
    {
        public string m_HorsePartName { get; set; }
        public string m_PartName { get; set; }
        public int m_Value0 { get; set; }
        public float m_Value1 { get; set; }
        public int m_Value2 { get; set; }
        public int m_Value3 { get; set; }
        public int m_Value4 { get; set; }

        private int m_Index_HorsePartName { get; set; }
        private int m_Index_PartName { get; set; }

        public FrameEvent_ModelAnimation(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Index_HorsePartName = bReader.ReadInt32();
            m_Index_PartName = bReader.ReadInt32();

            m_Value0 = bReader.ReadInt32();
            m_Value1 = bReader.ReadSingle();
            m_Value2 = bReader.ReadInt32();
            m_Value3 = bReader.ReadInt32();
            m_Value4 = bReader.ReadInt32();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);

            m_HorsePartName = stringTable[m_Index_HorsePartName];
            m_PartName = stringTable[m_Index_PartName];
        }
    }
}

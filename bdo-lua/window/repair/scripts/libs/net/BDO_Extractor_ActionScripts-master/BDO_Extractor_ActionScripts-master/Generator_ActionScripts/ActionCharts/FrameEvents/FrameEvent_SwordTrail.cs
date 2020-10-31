using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEvent_SwordTrail : FrameEventBase
    {
        public string m_Bone { get; set; }
        public string m_DDS { get; set; }
        public byte[] m_Data0 { get; set; }
        public byte[] m_Data1 { get; set; }

        private int m_Index_Bone { get; set; }
        private int m_Index_DDS { get; set; }

        public FrameEvent_SwordTrail(BinaryReader br, eActionChart_FrameEvent type) : base(br, type)
        {

        }

        public override void Parse()
        {
            base.Parse();

            m_Index_Bone = bReader.ReadInt32();
            m_Index_DDS = bReader.ReadInt32();

            long unkDataCount = bReader.ReadInt64();
            List<byte> unkData = new List<byte>();
            for (int iUD = 0; iUD < unkDataCount; iUD++)
            {
                unkData.Add(bReader.ReadByte());
            }

            m_Data0 = unkData.ToArray();

            unkDataCount = bReader.ReadInt64();
            unkData.Clear();
            for (int iUD = 0; iUD < unkDataCount; iUD++)
            {
                unkData.Add(bReader.ReadByte());
            }

            m_Data1 = unkData.ToArray();
        }

        public override void InsertStrings(List<string> stringTable)
        {
            base.InsertStrings(stringTable);
        }
    }
}

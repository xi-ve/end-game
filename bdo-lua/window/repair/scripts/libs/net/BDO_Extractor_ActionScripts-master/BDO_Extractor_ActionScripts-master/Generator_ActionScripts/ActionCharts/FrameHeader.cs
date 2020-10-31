using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts
{
    public class FrameHeader
    {
        private BinaryReader bReader { get; set; }

        public int m_Unk0 { get; set; }
        public int m_Unk1 { get; set; }
        public byte[] m_UnkData0 { get; set; }
        public byte[] m_Conditions { get; set; }

        public FrameHeader(BinaryReader br)
        {
            bReader = br;

            m_UnkData0 = new byte[0];
            m_Conditions = new byte[0];
        }

        public void Parse()
        {
            m_Unk0 = bReader.ReadInt32();
            m_Unk1 = bReader.ReadInt32();

            if (m_Unk0 != 0)
            {
                m_UnkData0 = bReader.ReadFixedArray(2);
            }

            if (m_Unk1 != 0)
            {
                m_Conditions = bReader.ReadFixedArray(16);
            }
        }
    }
}

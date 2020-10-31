using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts
{
    public class ActionBranch
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public byte m_Unk0 { get; set; }
        public byte m_Unk1 { get; set; }
        public List<FrameHeader> m_FrameHeaders { get; set; }
        public string m_Execute { get; set; }
        public string m_ActionFileName { get; set; }
        public bool m_HasAdditionalData { get; set; }
        public byte[] m_AdditionalData { get; set; }
        public byte[] m_UnkData { get; set; }
        
        public ActionBranch(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;

            m_FrameHeaders = new List<FrameHeader>();
        }

        public void Parse()
        {
            m_Unk0 = bReader.ReadByte();

            if (m_Unk0 != 0)
            {
                ;
            }

            m_Unk1 = bReader.ReadByte();

            if (m_Unk1 != 0)
            {
                for (int i = 0; i < m_Unk1; i++)
                {
                    FrameHeader nFrameHeader = new FrameHeader(bReader);
                    nFrameHeader.Parse();

                    m_FrameHeaders.Add(nFrameHeader);
                }
            }

            m_Execute = GetString(bReader.ReadInt32());
            m_ActionFileName = GetString(bReader.ReadInt32());

            m_HasAdditionalData = bReader.ReadBoolean();

            if (m_HasAdditionalData)
            {
                List<byte> bufferAdditionalData = new List<byte>();
                for (int iUD = 0; iUD < 12; iUD++)
                {
                    bufferAdditionalData.Add(bReader.ReadByte());
                }

                m_AdditionalData = bufferAdditionalData.ToArray();
            }

            m_UnkData = bReader.ReadFixedArray();
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}

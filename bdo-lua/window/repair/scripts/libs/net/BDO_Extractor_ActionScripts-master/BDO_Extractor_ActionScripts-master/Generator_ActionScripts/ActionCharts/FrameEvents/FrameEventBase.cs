using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Enums;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts.FrameEvents
{
    public class FrameEventBase
    {
        public BinaryReader bReader { get; set; }

        public eActionChart_FrameEvent m_FrameEventType { get; set; }
        public List<FrameHeader> m_FrameHeaders { get; set; }

        public string m_Unk0 { get; set; }
        public byte[] m_AdditionalData { get; set; }

        private int m_Index_Unk0 { get; set; }

        public FrameEventBase(BinaryReader br, eActionChart_FrameEvent frameEventType)
        {
            bReader = br;

            m_FrameEventType = frameEventType;

            m_FrameHeaders = new List<FrameHeader>();
        }

        public virtual void Parse()
        {
            m_Index_Unk0 = bReader.ReadInt32();

            long unkDataCount = bReader.ReadInt64();
            List<byte> unkData = new List<byte>();
            for (int iUD = 0; iUD < unkDataCount; iUD++)
            {
                unkData.Add(bReader.ReadByte());
            }

            m_AdditionalData = unkData.ToArray();

            if (m_AdditionalData.Length > 0)
            {
                for (int i = 0; i < m_AdditionalData[m_AdditionalData.Length - 1]; i++)
                {
                    FrameHeader nFrameHeader = new FrameHeader(bReader);
                    nFrameHeader.Parse();

                    m_FrameHeaders.Add(nFrameHeader);
                }
            }
        }

        public virtual void Write(BinaryWriter bw)
        {
            bw.Write(BitConverter.ToSingle(m_AdditionalData, 0));
            bw.WriteFixedWString(m_Unk0);
            bw.Write((short)0);
        }

        public virtual void InsertStrings(List<string> stringTable)
        {
            m_Unk0 = stringTable[m_Index_Unk0];
        }
    }
}

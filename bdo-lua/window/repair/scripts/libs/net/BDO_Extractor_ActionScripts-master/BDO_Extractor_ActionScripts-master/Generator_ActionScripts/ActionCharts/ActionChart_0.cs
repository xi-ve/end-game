using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class ActionChart_0
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public string m_FunctionValue { get; set; }
        public string m_Text0 { get; set; }
        
        public FrameHeader m_FrameHeader { get; set; }

        public float m_Value0 { get; set; }
        public byte m_Value1 { get; set; }

        public byte[] m_Data0 { get; set; }

        public ActionChart_0(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;
        }

        public void Parse()
        {
            m_FunctionValue = GetString(bReader.ReadInt32());
            m_Text0 = GetString(bReader.ReadInt32());

            m_FrameHeader = new FrameHeader(bReader);
            m_FrameHeader.Parse();

            m_Value0 = bReader.ReadSingle();
            m_Value1 = bReader.ReadByte();

            m_Data0 = new byte[m_Value1];

            for (int i = 0; i < m_Value1; i++)
                m_Data0[i] = bReader.ReadByte();
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}

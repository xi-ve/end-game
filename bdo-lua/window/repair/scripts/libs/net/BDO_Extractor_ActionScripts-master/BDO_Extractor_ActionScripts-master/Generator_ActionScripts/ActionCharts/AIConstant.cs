using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class AIConstant
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public int m_Value0 { get; set; }
        public int m_Value1 { get; set; }
        public string m_Action { get; set; }
        public int m_Value2 { get; set; }

        public AIConstant(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;
        }

        public void Parse()
        {
            m_Value0 = bReader.ReadInt32();
            m_Value1 = bReader.ReadInt32();
            m_Action = GetString(bReader.ReadInt32());
            m_Value2 = bReader.ReadInt32();
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}

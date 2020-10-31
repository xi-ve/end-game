using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class Physics
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public int m_Hash { get; set; }
        public string m_FileName { get; set; }
        public string m_Unk1 { get; set; }
        
        public Physics(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;
        }

        public void Parse()
        {
            m_Hash = bReader.ReadInt32();
            m_FileName = GetString(bReader.ReadInt32());
            m_Unk1 = GetString(bReader.ReadInt32());
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}

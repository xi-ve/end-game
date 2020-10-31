using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts
{
    public class SubMeshInfo
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public string m_MeshName { get; set; }
        public string m_MeshFileName { get; set; }
        public byte[] m_UnkData { get; set; }
        
        public SubMeshInfo(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;
        }

        public void Parse()
        {
            m_MeshName = GetString(bReader.ReadInt32());
            m_MeshFileName = GetString(bReader.ReadInt32());

            m_UnkData = bReader.ReadFixedArray();
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}

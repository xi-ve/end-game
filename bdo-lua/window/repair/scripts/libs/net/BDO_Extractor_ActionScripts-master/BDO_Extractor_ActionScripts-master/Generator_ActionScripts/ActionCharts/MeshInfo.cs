using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts
{
    public class MeshInfo
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public int m_ActionIndex { get; set; }
        public List<SubMeshInfo> m_SubMeshInfos { get; set; }
        public byte[] m_UnkData { get; set; }

        public MeshInfo(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;

            m_SubMeshInfos = new List<SubMeshInfo>();
        }

        public void Parse()
        {
            m_ActionIndex = bReader.ReadInt32();

            long subMeshCount = bReader.ReadInt64();

            for (int i = 0; i < subMeshCount; i++)
            {
                SubMeshInfo nSubMeshInfo = new SubMeshInfo(bReader, m_StringTable);
                nSubMeshInfo.Parse();

                m_SubMeshInfos.Add(nSubMeshInfo);
            }

            m_UnkData = bReader.ReadFixedArray();
        }
    }
}

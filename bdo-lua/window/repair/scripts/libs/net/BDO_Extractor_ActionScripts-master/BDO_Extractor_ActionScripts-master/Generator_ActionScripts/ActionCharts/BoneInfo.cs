using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Generator_ActionScripts.Utils;

namespace Generator_ActionScripts.ActionCharts
{
    public class BoneInfo
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public int m_ActionIndex { get; set; }
        public string m_BoneFileName { get; set; }
        public string m_BoneName { get; set; }
        public byte[] m_UnkData { get; set; }
        
        public BoneInfo(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;
        }

        public void Parse()
        {
            m_ActionIndex = bReader.ReadInt32();
            m_BoneFileName = GetString(bReader.ReadInt32());
            m_BoneName = GetString(bReader.ReadInt32());

            long count = bReader.ReadInt64();

            if (count > 10000)
            {
                throw new System.InvalidOperationException("Invalid Count");
            }

            for (int i = 0; i < count; i++)
            {
                //BoneInfoExt 41 + 12 + 1 + someOffset = 60
                bReader.BaseStream.Position += 60;
            }

            m_UnkData = bReader.ReadFixedArray();
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}

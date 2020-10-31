using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Generator_ActionScripts.ActionCharts
{
    public class BoneData
    {
        private BinaryReader bReader { get; set; }
        private List<string> m_StringTable { get; set; }

        public long m_Unk1 { get; set; }
        public int m_Unk2 { get; set; }
        public long m_Unk3 { get; set; }
        public int m_Unk4 { get; set; }
        public long m_Unk5 { get; set; }
        public int m_Unk6 { get; set; }
        public long m_Unk7 { get; set; }
        public int m_Unk8 { get; set; }
        public string m_BoneName { get; set; }
        public float m_Unk9 { get; set; }
        
        public BoneData(BinaryReader br, List<string> stringTable)
        {
            bReader = br;
            m_StringTable = stringTable;
        }

        public void Parse()
        {
            m_Unk1 = bReader.ReadInt64();
            m_Unk2 = bReader.ReadInt32();
            m_Unk3 = bReader.ReadInt64();
            m_Unk4 = bReader.ReadInt32();
            m_Unk5 = bReader.ReadInt64();
            m_Unk6 = bReader.ReadInt32();
            m_Unk7 = bReader.ReadInt64();
            m_Unk8 = bReader.ReadInt32();

            m_BoneName = GetString(bReader.ReadInt32());

            m_Unk9 = bReader.ReadSingle();
        }

        private string GetString(int index)
        {
            return m_StringTable[index];
        }
    }
}
